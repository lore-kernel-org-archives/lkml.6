Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9467C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CDE2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549635245;
	bh=94yI00TNBLHkPmBAjyzhuaoudci/T1/X9KZPsyOgjq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a4PqaobyTDKl1JBswvIi4V+2p+279MtjJrr/Sz0smeGkauoLEL9f/8fMbIiNXexn9
	 X8SuGSdKeQTYrAbifvvhex4E1bF6k7JJN5XamRAaQFi0v0qyUL71RL8HMGVn3eRpST
	 ZtDwXcOY8limaN64fm9aEqfIJxaKZ9PcRn6Lqj+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfBHOOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfBHOOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:14:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3F920844;
        Fri,  8 Feb 2019 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549635242;
        bh=94yI00TNBLHkPmBAjyzhuaoudci/T1/X9KZPsyOgjq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zci152GgCor8pE4cHEf4OUgvtA3Vmbz4/HI5a38W6x5PhS3Z3/RmFoPbPo0myehuw
         U9YzXCZ3hO2rzI4Pl6b7GDP8uCMjiyoK2lr42c8tZYo1SjHhYdg6uF6ZWd2Dd8h9TU
         81ZJ1Hk/nG3eEhYQR8fJyfJeXecFku+E7vKM89oQ=
Date:   Fri, 8 Feb 2019 15:14:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     robh+dt@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/6] Add Fieldbus subsystem + support HMS Profinet card
Message-ID: <20190208141400.GA22162@kroah.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
 <20190208121916.GE23483@kroah.com>
 <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVVNitd5SDLah-kxP69W6XHYHOQrOz=DnevuGnqoHD7HA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:05:11AM -0500, Sven Van Asbroeck wrote:
> On Fri, Feb 8, 2019 at 7:19 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > I would like to see other people review and put their "name" on the
> > patchset either with a "reviewed-by:" or "ack" or something.
> 
> That's what I would love to see too !
> 
> And I agree with you that a patchset like this needs more review.
> Probably a lot more. Especially the fieldbus userspace interface.
> 
> The question is: how can I generate interest? Other than starting
> an advertising campaign or spamming developers :)
> 
> I guess this is one of the ways a patch can die: lack of interest
> by the wider community?

Well, who wants this code?  Who uses it?  Find those people and get them
to review it.  If no one wants it or uses it, that kind of implies that
it's not needed :)

thanks,

greg k-h
