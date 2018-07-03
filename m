Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA87C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7B923E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vXkSz4QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7B923E80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933956AbeGCPgX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:36:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38573 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbeGCPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:36:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so2763033wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEPStAlSV71h0AE8f5p3+BlYM5gBJv+yz/6BPySqo2Y=;
        b=vXkSz4QBXcKhMPiQzKDNkgF4lAZqrtIPDIx3aUPlA57jJMcFRBk/T8MkuFfPjnEnqK
         aJkpboxQZT7wDrskinW6EFR6N6QVmdhV1Nmxr2DvxabpijkntM+ERDAT0dS+71czsmzn
         sY03/W6YaOf5xiri0d0E1niU71TtLPlgJPo8zbSMjEstcDFMIoXmxbiOGNO+d0f+Yy12
         PxXSi+XgHHe/axmrl0YTwB2RSSdjKyBvLQVX76SvOSltHq9dJbymS0RVNwNq3CWhwOC8
         ZW0l28PsfhCvm59zro7fXihMu90vVjAIYPq8baaEIZbzXdCwjSR+R98wa2SyBHdVycWn
         oAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEPStAlSV71h0AE8f5p3+BlYM5gBJv+yz/6BPySqo2Y=;
        b=AhslCoV4MYcUScOu1Ct8sO/q5bSumr8OSGYLQAGf4IWFfeoA18whut5UAOZJ5b0fXm
         2apGLZ2ndRL4nUnvptfIjdz3U0+spnTzZCFvSxm2Dn7SS2Gh5J7h+W5AFL0t/z5uIa91
         OydFBVbb5brWz9OzC5l8z9SalVyvgXgxMsf5xjynbDoIA6IBkb+FjcO3j35CLt3ATKJZ
         uEXwpTMePGpHJyESYYFy8b7WKOqr/mCk8BZj9A3gFb5zRT/Fe9b0+s4MCkF/pubNg4yk
         17yOwK2JX9ZPhtoLQiwUOu0VFxVQrKOa0AhQX8zcFVWTKuiGuWbCYgyMJWOMCIqaSmok
         BmxA==
X-Gm-Message-State: APt69E0kwSM5e6ABFbUwMeZM24XT9thGtRqSL9rrHMJm2ZFN+28YSWVc
        cmLRa3t//LGOKNLCwRh7xuKqSw==
X-Google-Smtp-Source: AAOMgpemMn19yST7DwSLBvZF0fgzVOVdCprqcp4NHmp1ClqwoFTZ0iLuqdLfD/Nb0t8PDr7uF4rjmA==
X-Received: by 2002:a1c:ec1b:: with SMTP id k27-v6mr8990811wmh.157.1530632180355;
        Tue, 03 Jul 2018 08:36:20 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v9-v6sm2331208wrn.97.2018.07.03.08.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 08:36:19 -0700 (PDT)
Message-ID: <1530632179.2900.210.camel@baylibre.com>
Subject: Re: [PATCH v3 0/2] ASoC: add es7241 support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Jul 2018 17:36:19 +0200
In-Reply-To: <20180703153212.GC13744@sirena.org.uk>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
         <20180703153212.GC13744@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 16:32 +0100, Mark Brown wrote:
> On Tue, Jul 03, 2018 at 03:28:43PM +0200, Jerome Brunet wrote:
> > Add support for the es7241 which is a simple 2 channels analog to
> > digital converter.
> 
> Please don't resubmit patches that have already been applied, you should
> submit patches against current code in the tree you're expecting things
> to be applied to.  If any updates are needed to a patch that's already
> been applied you should submit incremental patches which make those
> updates.  This avoids having to change published git commits which could
> cause problems for people working against git.

Unless I missed something, which entirely possible, I don't think any patches of
this series have been applied yet. You asked me resubmit after the v1 because of
 power supply bindings and the mode selection.

I don't see anything related to the es7241 in your tree ATM.




