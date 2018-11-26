Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE72F20660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zkz3IDcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE72F20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbeKZWG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:06:27 -0500
Received: from casper.infradead.org ([85.118.1.10]:44500 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeKZWG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zM54IPicp1teSvgC2wlUjGP7MW/hjyQ7Q8MOzscEmJk=; b=Zkz3IDcf9JjtNoKwP5vfj5hLjB
        yPZyeixHTQdfPgSpHOBBZln0SmSyZTM73nKoHMZz5tinDT9h0UYppXhtfUQiOjPpjqUxLvOpzqPzf
        aIK0NAN3wBntpcALsqTe1aGVk9k/vP37dRvNzBBKF7ZsqVnB4yEuYmhHJAIQIHIIH7NSduNTpb72Y
        iugFtGC3h0ytB/Q0V24HaT32AwA2JuANaZGetDwCu9FqoFD+4hdiwnIiR4heoxry9zbyMD2Ffw3MM
        6El2nQuFatdguBbgxSm/tZeD/tDL5IiiQICStzS/lMPIVnlC8iv+twAvflGrzKpdzsbc43payKrGL
        7gy2aE2w==;
Received: from 177.133.7.55.dynamic.adsl.gvt.net.br ([177.133.7.55] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gREod-0000Xd-Kl; Mon, 26 Nov 2018 11:12:36 +0000
Date:   Mon, 26 Nov 2018 09:12:29 -0200
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, zwisler@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
Message-ID: <20181126091229.04b5dce0@coco.lan>
In-Reply-To: <8736rwgoem.fsf@intel.com>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
        <20181115061036.1575223d@silica.lan>
        <20181115162008.GO3759@mtr-leonro.mtl.com>
        <CABVU7+twSz3OZx7PTO+bS-wfLfTTjZVhRAnhgtcs6KWwntattw@mail.gmail.com>
        <CAPcyv4hWK+to6vOSfSdeVMDzUutYwg9=XqshSDzaCf0c-u8jLA@mail.gmail.com>
        <20181118110324.543edbd8@coco.lan>
        <8736rwgoem.fsf@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jani,

Em Tue, 20 Nov 2018 10:10:25 +0200
Jani Nikula <jani.nikula@intel.com> escreveu:

> On Sun, 18 Nov 2018, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> > Hmm.. Perhaps the subsystem profile should point to IRC channels if any?
> > Several subsystems use them in order to provide newbies some directions
> > and to discuss other development issues.  
> 
> MAINTAINERS:
> 
> 	C: URI for chat protocol, server and channel where developers
> 	   usually hang out, for example irc://server/channel.
> 
> Alas very few subsystems have added that.
> 
> I actually fear very few subsystems will add a subsystem profile for
> that matter.

Sorry for a late reply. In the case of the media subsystem, we
actually use 2 different channels, one when the matter is related
to digital TV (#linuxtv) and another one for the rest (#v4l), both
at freenode.

That's something that wouldn't fit well into MAINTAINERS file, as
we can't explain what should be used for each.

So, the way it is it won't work well for us.

Thanks,
Mauro
