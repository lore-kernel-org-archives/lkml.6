Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD85C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295A12133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545059936;
	bh=MX2IbbOQnBzf8fDRHjrVxvO1i8VoirvjmQxB6ZWnSNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r+jigeDenkb4VyO+JE5nAzyOX7e4l6w0EAMGthKV4u13Ci0zw1PQ7YgnBQ4nG5Zuj
	 EryOkz3wgsiD9tCHhsVL5WEphWuE8Iiw0+C0Lxz7jY6UVCFr0aoKNeWOz4GTa0GTJL
	 +TXKNPUE9PE+wr21SA1G7IjAob37BYVrP84HhDVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbeLQPSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbeLQPSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:18:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D164620578;
        Mon, 17 Dec 2018 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545059933;
        bh=MX2IbbOQnBzf8fDRHjrVxvO1i8VoirvjmQxB6ZWnSNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZZinDuCv6aFV7Uh4FbVU4CoPMOksB9RxQfJK8p931+9SK5EjvxFEnE1O0aqbV/aWL
         b4nLDIC7nlnxejj4PkkqteLrwFefBvEKFijlzlOpisyfnWRfj3Y0QC5lh7jaesTQ9n
         8TKI4xOMiL2nYXRqlYwKR+gyTbf63NXCx8eyUyV4=
Date:   Mon, 17 Dec 2018 16:18:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Marek Vasut <marex@denx.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Message-ID: <20181217151851.GA21564@kroah.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
 <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
 <20181216223510.hxsdotf332ousinh@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216223510.hxsdotf332ousinh@pburton-laptop>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:35:12PM +0000, Paul Burton wrote:
> Hi Ezequiel,
> 
> On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
> > On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
> > > This helps, but it only addresses one part of one of the 4 reasons I
> > > listed as motivation for my revert. For example serial8250_do_shutdown()
> > > also clearly intends to disable the FIFOs.
> > >
> > 
> > OK. So, let's fix that :-)
> 
> I already did, or at least tried to, on Thursday [1].
> 
> > By all means, it would be really nice to push forward and fix the garbage
> > issue on JZ4780, as well as the transmission issue on AM335x.
> >
> > AM335x is a wildly popular platform, and it's not funny to break it.
> 
> Well, clearly not if it was broken in v4.10 & only just fixed..? And
> from Marek's commit message the patch in v4.10 doesn't break the whole
> system just RS485.
> 
> > So, let's please stop discussing which board we'll break and just fix both.
> 
> I completely agree that would be ideal and I wrote a patch hoping to do
> that on Thursday, but didn't get any response on testing. It's late in
> the cycle hence a revert made sense. Simple as that.

A revert makes sense now, I'll go queue this up, thanks.

greg k-h
