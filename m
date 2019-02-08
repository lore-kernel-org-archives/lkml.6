Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12248C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18522086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 12:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549628361;
	bh=56v5hLMTSrAp9RDkpdUGyTtNkATNSHoIbN04eP6wVGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jSCRskWHjcXJlq7boWped2wKZ90WZGWmT6p1dYtuJ+qWmpcr2mCNWTsuA5CcpqEt1
	 mxdYGkufdiHhoAaqLHGlDMfxnR2ZdnPkqRdTKMVCZgwr2uS2lsuz3bxTTyGT9y9QFy
	 DFnlml8K0VACIHydBe5ZkQFPXN0l0fMuiJ2uvadM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfBHMTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:19:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfBHMTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 07:19:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5222206BA;
        Fri,  8 Feb 2019 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549628359;
        bh=56v5hLMTSrAp9RDkpdUGyTtNkATNSHoIbN04eP6wVGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcLq9ZVMGxtr4Tayu7VrI6O3uaY4jHGg9sdsneo2BwTnwVN6t9WsKZPA1b6DAVrzv
         tCXjfay/QGaOuX3svWsfFc0h21JiIYbs0hDWFo93ncBJXz/BPXVnx7WeBq4Jw0ylPB
         vsR7S/xwmslxIvYOPHj9pCBLBSl7EUGDKv0pkego=
Date:   Fri, 8 Feb 2019 13:19:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
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
Message-ID: <20190208121916.GE23483@kroah.com>
References: <20190124201251.15159-1-TheSven73@googlemail.com>
 <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWFU-VnG=ODLWaUf0yp69qaU2GSd9exdHvyi6Ko1ib9qw@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 08:47:36AM -0500, Sven Van Asbroeck wrote:
> On Thu, Jan 24, 2019 at 3:12 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> >
> > This patch:
> >   1. adds a Fieldbus subsystem
> >   2. adds support for the HMS Industrial Networks AB Profinet card.
> >
> 
> Is there any feedback I may address? Any improvements I could make?
> Any clarifications?
> 
> If not, what would be the next step for this patchset?

I would like to see other people review and put their "name" on the
patchset either with a "reviewed-by:" or "ack" or something.  Don't
force me to be the only one who reviews the patchset :(

thanks,

greg k-h
