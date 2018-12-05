Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9BAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96C420892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX6IHrc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96C420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeLEQRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:17:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36066 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:17:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so10254757pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 08:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ew5wz79DK0P/QNOxBTyTb10TRHtfLis2s/SRSKjsHpQ=;
        b=VX6IHrc4NusAxF875Deq9Pr7bbhsPUoG40nGCl2WeQHEHmGt1FsAWVH9J8Jx31Iw7L
         lQreHGowszns8ZSH3bjiZsAiNMtaiyzj8zjFKAgtEsxDDbjdIUm4ukLKE6y9dGINbvAk
         PU3CWVPWBLrEnDEuBOrnu9+ztR4X01Kgwtx4VDHZrxxrAJEszpra/pnnyOVOhVDSZsNy
         9QyTYdHP2ZtmvIgZmvKMZwjHG+Ya8/35OAzJmlf8CnXenPOHsl2Bp1OTNcaQokp1EdZ0
         E9AuArRNiUmBxTB6tu07aNat1Z9tO9Ntr01UngVBHh7ZltaQ8xnj+gSbCLJiRzRIIbtr
         hweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ew5wz79DK0P/QNOxBTyTb10TRHtfLis2s/SRSKjsHpQ=;
        b=aIbq6EkhNqLzW8xWyUErg8qeg/dm/mfP6Pz+XKW7qdsivYMOKivfdn8WISgn1Bop3W
         vhWHKOG7ylnodsWwCDKj1GfJrRfYbM8cpchFyDsyZpFdp9gqKB7JCks1t/FMx62euswG
         l1FiMw48XZtCcrYA7L/0fouk7Hg7EYP2pOy5n/qH2CjKoKzWCwtIHlYttBleaD97O+Rx
         neGoCYFUxwKkmQ9SQ5ufNb8RoDVrNDIRAmmT+V1n+QmyzRuctVZx6g2kqN9N82c6wdGD
         qZLCKiQKUiiBmCv2VcmG/Zw4p+muaUxaXwCrXWuQZBq7thhrQEx4GZ3yhxpy+dQgBTVV
         G4Ig==
X-Gm-Message-State: AA+aEWblYo1LP2KlTOUQg57VMMY+zkOHAyWN0N8XgNsMJ0C0ldnTKRK6
        TiOuuT8cGKtUOR+w67gKLns=
X-Google-Smtp-Source: AFSGD/W5RZ/3brfagI3SEpd8k4K/SGXqAR1ypXftScaDqMrKw5jkA9LW4GfthcYgybtheQVuBbC7RA==
X-Received: by 2002:a63:5761:: with SMTP id h33mr20993473pgm.283.1544026665024;
        Wed, 05 Dec 2018 08:17:45 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id y6sm26994479pfl.187.2018.12.05.08.17.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:17:44 -0800 (PST)
Date:   Wed, 5 Dec 2018 21:47:32 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 1/3] staging: mt7621-mmc: Remove #if 0 blocks in sd.c
Message-ID: <20181205161729.GA12467@nishad>
References: <cover.1538670306.git.nishadkamdar@gmail.com>
 <d24db4fd34fc2347ba0512aaae04b937b942ac0e.1538670306.git.nishadkamdar@gmail.com>
 <87sgzzcru8.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgzzcru8.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 08:33:03AM +1100, NeilBrown wrote:
> On Thu, Oct 04 2018, Nishad Kamdar wrote:
> 
> > This patch removes #if 0 code blocks and usages of
> > functions defined in the #if 0 blocks in sd.c.
> >
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> 
> Hi Nishad,
>  thanks for this patch (and others) and apologies for not
>  reviewing/testing it earlier.
>  Unfortunately there is a problem - see below.
>  
> >  
> > -#if 0 /* --- by chhung */
> > -/* For E2 only */
> > -static u8 clk_src_bit[4] = {
> > -	0, 3, 5, 7
> > -};
> > -
> >  static void msdc_select_clksrc(struct msdc_host *host, unsigned char clksrc)
> >  {
> >  	u32 val;
> 
> Above you removed the first few lines of a "#if 0" block, but not all of
> it.  Previously the function msdc_select_clksrc() was not compiled at
> all.  Now it is, and that causes an error - MSDC_CLKSRC_REG is not
> defined.
> 
> Would you be able to send a follow-patch patch which removes this
> function and the "#endif /* end of --- */" at the end?
> 
> Thanks,
> NeilBrown

Sure, I'll send the updated patch.

Thanks for the review.

Regards,
Nishad
