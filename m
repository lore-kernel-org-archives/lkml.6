Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC326C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F91824F47
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgNR/G1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F91824F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752063AbeFXOdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 10:33:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35043 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751915AbeFXOdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 10:33:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id c13-v6so1086916wrq.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=op1KnoKyvaMU06nGFmlNHyAcLN3KvvNe2cB7ahRoM14=;
        b=KgNR/G1KAKaYnEFieQyeSPzc44CtHuLshhw+ojseXAsMz5F6nD9ySD1Gvw+1qdkgqd
         MzRvvuwVa/Fu8sa5WYaAMdKQ0IypKphWMVR8Vc5ydZfwk9Z2Rs991Q+5vvcwLrzTA7XO
         jJqlKQXi6J+UZqUib5v3CrPpU7T2B8ls39gAG6iLuKrPKWpCQzJydsGws7yhpZLDBHXJ
         eXhzpqvtRP/ibQKpcPEZzx7WIVeEGIMQt1AaSg6dj0QNArct8vVaUD35PZSES4IASObe
         6j4axlRkgaLUcQsWrcUlxNtG8AQY+pTu5d5pOzVOX3/RwufPOAAGOmZSk4/wtzrdwGtl
         Hjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=op1KnoKyvaMU06nGFmlNHyAcLN3KvvNe2cB7ahRoM14=;
        b=MKW/JBxXggA4x0javFPhF/+jTb0ol22NjdxR2HiyMZT4ma+76yaNIm9PWgUjldnder
         sq/x0eu2uJCTH7Op45eQa4wwsNpFrc4KopLKcnvnNBEH3Rl1LBXyMsMveDOgtS50ju64
         dQc8cJQP90Hh8Dx8UUB7yOvEvmCQ7CHLa6+IGLNlRl2Vf2fo5niv4hbZX3lz8xpjGGZ+
         d2FTiHJEmY1eKmfq7lTsCZpdXew+L294iobNhMM2J+WA7TUv+y9Lrp2wcHjiJz2IhsGn
         X0Y/+ha2B01+AzC3L+wTLM7nXhNLl+fl2ZwbAbfyaAXXc16mc3miGxAGX6cKFh8Gy6N0
         jK0w==
X-Gm-Message-State: APt69E1M1Vr0Bh+Wavm2AB9JwCVuPZ0wH+2pmYklsoHmcN3aeMSINULO
        K+MW/qrOVHFteSSBi+tV+dk=
X-Google-Smtp-Source: AAOMgpduNaW9B2iP4u72P8/JTFJIyeni8X7N6X2AbN5D9Hpg8RagCP9EUg2M1a54KvnfV6MgxLd0XQ==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr1677466wrd.218.1529850789172;
        Sun, 24 Jun 2018 07:33:09 -0700 (PDT)
Received: from xux707-tw (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id 189-v6sm2499306wmd.17.2018.06.24.07.32.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 07:33:08 -0700 (PDT)
Date:   Sun, 24 Jun 2018 15:32:49 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
Message-ID: <20180624143243.uxxgdfe4pldgwlb3@xux707-tw>
References: <20180624095732.12082-1-johnfwhitmore@gmail.com>
 <20180624095732.12082-4-johnfwhitmore@gmail.com>
 <1ca5d94c5ef94930773c9f3d239e12862a65922d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ca5d94c5ef94930773c9f3d239e12862a65922d.camel@perches.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 07:26:41AM -0700, Joe Perches wrote:
> On Sun, 2018-06-24 at 10:57 +0100, John Whitmore wrote:
> > Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
> []
> > diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> []
> > @@ -742,8 +742,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
> >   */
> >  static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
> >  {
> > -	u8					i;
> > -
> >  	if (!pOperateMCS) {
> >  		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
> >  		return false;
> > @@ -756,8 +754,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
> >  		//legacy rate routine handled at selectedrate
> >  
> >  		//no MCS rate
> > -		for (i = 0; i <= 15; i++)
> > -			pOperateMCS[i] = 0;
> > +		memset(pOperateMCS, 0, 15);
> 
> Not the same code.
> 
> Loop is <= 15, so memset should use 16
> 

Arragghhhh! Thank you and thank you for spotting that. I'll reissue again. I
should have been more careful. Sorry.
