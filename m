Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F602C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457D524E75
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj8mTRm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457D524E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbeFXJ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:58:13 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35860 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeFXJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:58:11 -0400
Received: by mail-wm0-f51.google.com with SMTP id u18-v6so2385058wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 02:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/Rht/e6Iwc2DY+OzLQiKJN7gWr9XzK6M+RkxsNwcmsQ=;
        b=Yj8mTRm/r2HWpJQKfzaEkAPfib4K4LL+nfCjwWCx0CVP0GeNtdASmJT3Ac4p+x/3sv
         ZHNkNI1tHB/WAG/Ufl93mHWYtv9/iRdso7RfECEDAexWgx9XbystAPLFwY233w0+yGmH
         8QI1ww/B3wX27i4lQ+rQgffRHVsfBJ0gu/QeejoWyG2xqJGvx/TN7bWzAxau3d6+nlkj
         KRSNFatOAvMk8wEAcPQVxJBd861uuZ6Hp3sq/AWMzriW2MZD/bHx9am4eZTja+xnJgCC
         npmdHiQkJFstELPWQuTYLcX4ZxOf4RVQjHSGAunRYzwKWb2bNACkCzAt0br+VW2Gb+c1
         gQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Rht/e6Iwc2DY+OzLQiKJN7gWr9XzK6M+RkxsNwcmsQ=;
        b=p93wi91QxVDI8/QAs+h06sqU+qM/huR+fpwrXMBBc/OePOsHKlks5iNHY/2W8XAgWt
         eFoLpHKdjx5Xn8Iu89SS06cbn/1w9dJW16Nbz8NCeCFzFfL5nX5XMHHykjhgyHlxh0pZ
         AKGGx2ccUxStutohZcMvN2oXreUhh6IFoCgHz8wquP384FmnawEifyA2reWayjvbFYf7
         wahWlDlmbBskFmzlsGuYFLOVhsiqaAxBM7/CW8GaXelqAmeoPrrqvSKvUG5qlX/PE7+1
         OJZTOASj8u13exMv9J56n8HX5+INMzz9iUlLM0paqlj61k1DHcADPoLYykukpty+94ZV
         eZ5w==
X-Gm-Message-State: APt69E10lrqWU2cDMHLD63pf6WbA0YwpyjYT7S/XtlUzh9XPpzeDo6k4
        ht1t5J5LqdX0UuWXhHDYF3Ajhg==
X-Google-Smtp-Source: ADUXVKI90ST4vw9uDPF7ZK7O3EEOqUuzmkMBTO+HOF+6EMzmU1mUe8YLazXuwL1BEYUDPcU6SWb/0A==
X-Received: by 2002:a1c:9f11:: with SMTP id i17-v6mr4568162wme.157.1529834290244;
        Sun, 24 Jun 2018 02:58:10 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4468328wmc.1.2018.06.24.02.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 02:58:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org
Subject: V2 Coding style changes. Plus one change to use memset()
Date:   Sun, 24 Jun 2018 10:57:24 +0100
Message-Id: <20180624095732.12082-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple coding style changes to single file
drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c

Given feedback on some of the comments, I truncated to the 80 character limit,
in code, (as opposed to function block comments). I have left a number of the
contentious comments as they are.

Another piece of feedback suggested using memset() instead of a loop to
initialise memory so I've added that change to the set.

I tried to respond to issues raised on the mailing list in the gmail web gui,
rather then in mutt. That was not a good idea and I don't think my comms got
through to the list. I know for future no web gmail.


