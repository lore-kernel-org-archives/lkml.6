Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E003C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC2D214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548577943;
	bh=nQXDxP01s4SLMY6bzfqIw/LMSfQaNg6LvEpP7Ni8Izs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l+BWHVVEs6o3ltb1jcbpnh6Ys/k+RgqICzwsh87E+gGGX/y/g7l0jAFznEh0VDfvd
	 yWH6RYva8TemVvB/z/jKst0fdCjpqokcs51IfxFKsavtWerjM0Qwh7H/jrKdktdb0t
	 MA+eNXu2Sxw8GAc+LCDmlDZiYpaDj4m0W2Hn/4Vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfA0IcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfA0IcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 03:32:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12982214C6;
        Sun, 27 Jan 2019 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548577940;
        bh=nQXDxP01s4SLMY6bzfqIw/LMSfQaNg6LvEpP7Ni8Izs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9LgnseCMb3D7LsL3cgC7lxiDi1RrKVyjCSdTgqptMqaFfHv+xjHvYKgQUqedd9Nd
         n1ViOAzKt/pNCHNwn5ZYZd6FHBY4sG71lEL+sD24wcP6myfvXQh7tA9YaT62n0x6QW
         SMXZTTZ7ymmZDHaiqbO5Q3X2lAvCQrAFKnHsetlY=
Date:   Sun, 27 Jan 2019 09:32:17 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ogabbay@habana.ai
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
Message-ID: <20190127083217.GB4561@kroah.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-2-oded.gabbay@gmail.com>
 <CAK8P3a2NX_SNZPfqE4fnVcnxmSfAEzWMODce3L-g6JJ0NSTuBw@mail.gmail.com>
 <CAFCwf10jv4aMNefk_1Xj_Tg5Yjg8ekzWtZ94TssfHzaSN5CVAA@mail.gmail.com>
 <CAK8P3a3=1Rocb8jcG8XHadgcUCL6xXs8GRxc-Az6oyPqffYTpw@mail.gmail.com>
 <CAFCwf109SsyUVfvWAwA-j6HbqJ-QEZkWUhwirtX7dUf5CP_R7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf109SsyUVfvWAwA-j6HbqJ-QEZkWUhwirtX7dUf5CP_R7A@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 11:48:02PM +0200, Oded Gabbay wrote:
> On Sat, Jan 26, 2019 at 11:14 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Jan 26, 2019 at 5:25 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > On Sat, Jan 26, 2019 at 6:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >
> > > > On Wed, Jan 23, 2019 at 1:01 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > > >
> > > > > diff --git a/drivers/misc/habanalabs/include/habanalabs_device_if.h b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > > > > new file mode 100644
> > > > > index 000000000000..9dbb7077eabd
> > > > > --- /dev/null
> > > > > +++ b/drivers/misc/habanalabs/include/habanalabs_device_if.h
> > > >
> > > > Since this is a apparently a user space ABI, the file should be in
> > > > include/uapi/linux/,
> > > > not in the driver directory.
> > >
> > > This is not a user space ABI. This is the ABI between the driver and the F/W.
> >
> > Ah, I see. In that case, you should get rid of all the bitfields and make the
> > struct members all __le32/__le64/... to make it work on big-endian kernels.
> >
> I really don't want to start converting bitfields and structures to
> use __le32/64.
> As I wrote in one of the previous reviews, we don't support big-endian
> architecture (what's left after POWER moved to support little endian
> ?).  We actually do run on POWER9 but with ppc64le architecture
> In any case, our software stack is so big that this minor change in
> the driver won't have any impact on the overall ability to run
> something on our H/W

You don't have to do anything at the moment to "convert" to use a
specific endian, but you do have to always mark such variables that are
in a specific endian that this is the format they are expected in.

Then, when you run a tool like sparse, you will be notified if you
happen to be making any assumptions that might not be correct about
those variables, and it's trivial to usually fix it up at that time.

hope this helps,

greg k-h
