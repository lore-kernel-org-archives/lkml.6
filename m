Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210AFC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80DB24F4D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/I6D0pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80DB24F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeFXOkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 10:40:01 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38044 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbeFXOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 10:39:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so11057888wrs.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t5sQ8a9l6/gNa6bdnCpVtnn7HAJeD+NqF89ui4KPgYg=;
        b=H/I6D0pexNSujzO+ff7B2REMRJRAivxcQ4JrajD+DdV6iO55wiMKLAvB9kvVjURzdN
         aOrAN1Y7k49/L9GrqYi6r0uOuhVK1GWtj71CPtdaWPRfT4LHiByyZ9263EuHLt7xZHB/
         2nO/puoz3oLMPFuzVimS82jAL4yt6ILhhpOBjyU0aKYZLby3DS/Drvsvf2TkHiTkwV+9
         o8Thz7NnWlBUBULQsxBI+le1irOGSkWaFuOXcew/MrYeGVHP2+GWkt6+8mcNRSWT/MO7
         YyyQv5Dia03qEwMoUZwHBGQB5WqdWbAmN87BDunrvchYA8ealokd5s96/dMiWeuXNTSk
         eirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t5sQ8a9l6/gNa6bdnCpVtnn7HAJeD+NqF89ui4KPgYg=;
        b=pv5RbkNmxk80iIOnqHUyNK4JTOBS0jOgPk6gUEG0BA8pzZj1WrW+HvV8NlLg0Jql4L
         QpegNWUSxJP2sDksBAmaXFACtcBFTt5VctU/aVnj3t5esJSoEUNj6ZDWV/ypYtLR5xL8
         B3tEKfdip3qWj5rLTd5rxSHbFDaWuczo4eUFXHsh1CKi00l9vFBy2ePkMIJ+3Zv8NlQ6
         M+QMuVhBsUF4aQa58jw+610zNH3fdJukNZfwoUJgGm0ZPp7ZFDNjGXP6GU6iIKwT9LFP
         grbZLomm2a9TDA7njPgtT0QBvBqSDWco4SkiTrMsz49HQR5oBp8xldJ6+BLZ23U05Kjp
         yrRw==
X-Gm-Message-State: APt69E16VJ99VBu2VYPC4PKGrhOzguz45NHzPwIJHuS3S5oCSv0K+mSy
        I6YTQTFyShBemCrlQuoR2WU=
X-Google-Smtp-Source: AAOMgpcwIyOM44mOAF3TePwaFFKMqxFt4dUbkEvfgQRBwPKjFnDG0MlaVyQ41BECnVzdBhHoleCv4Q==
X-Received: by 2002:adf:aca7:: with SMTP id o36-v6mr7692367wrc.258.1529851198849;
        Sun, 24 Jun 2018 07:39:58 -0700 (PDT)
Received: from xux707-tw (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id v19-v6sm5233029wmc.9.2018.06.24.07.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 07:39:57 -0700 (PDT)
Date:   Sun, 24 Jun 2018 15:39:44 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
Message-ID: <20180624143939.pxreyhgb3x5pv3bz@xux707-tw>
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

I wonder could I simply edit that single patch file to change "15" to "16" and
re-issue the set as "v3"? There's no checksums on the patch file just but
there are git hashes which will change with content I guess :(

I'll re-do that patch set. Stupid mistake.
