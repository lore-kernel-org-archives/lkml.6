Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD11C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217CA2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 05:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+RWhVtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfBQFLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 00:11:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41077 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfBQFLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 00:11:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id t7so6789775otk.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Feb 2019 21:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ODzSrp9mIKo3HqMLVvFOVbi74xmbO6rbK55wRLXxEaM=;
        b=o+RWhVtDqqwUl0qvx1KegbO5TM2kV6BUJJUc9kOhKcx/s8y+BD2kbzNWfZQ3W6URv2
         l9XBWTky8Ija8dRD9gThmBQvVsT8uZyCvDefhbnD4ZHLqoABxJLRZ6Ye5XXWV3lA2ULG
         eRo8dktXv2KF9Hf3KLeWBEvufMflg2m/upgv/3m4N5ZzitOnZtd+ARVLTzaiPC2wPx4f
         Ln3ZkIWV8FSS1+vSRlEmuA1LmwtcSQjMG2TwiTfFh1pTPFyGPp207i35ZeDYR0Lr208N
         vmZT+5QF6/bI/WujPue4m5yD0Zhl8l2n8dWkhKSF9CGDmgOTIP/Kpk2H0LM2WoWAJSzC
         HlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ODzSrp9mIKo3HqMLVvFOVbi74xmbO6rbK55wRLXxEaM=;
        b=Aej/Ba3EAbxomrskoTlsHN+zw1JKXIpybQu62mp4pcuegI7UO6rn9QtuAZADhH969n
         pPe++k18MUiRUUiyXlpUWV2c4zmOQfulDmX8O8r4N4JYcAu8soJP0zQlHuFuWd2imJy0
         LdsM1we0X76EJatSmesPcwrdaS95IdDFZevurDFDwJGNKTjK+BGLBrJ/1zGYfqN2xQzx
         jJ4zc2J+0UpoPyYdN0ovPe+j0vK7FyGZ4b71zf672UD33BUTOms6isLb+PJFqQgeyCKL
         ijYsYih2IW0kFgA/i53C3o6SgeISFwAGRB2mo67489vlVqwII+HaggfpEQp7xZ/fPAGd
         rPAg==
X-Gm-Message-State: AHQUAuZ2ZWgWa2joovymkZ99mUhbZUpZ4fM0EEYD3bg6e2PoY6MTeyhm
        hteLKpWnz07mXhs4A2w1u6CRsRJR6pis7de0Infjqj6D
X-Google-Smtp-Source: AHgI3IbnyZIYu3Xbgkh66Yf1JN1AFlwdnZuHYZnJyZwRnMBP0MAsQXR2ZYEyMKF5ntCIf22yMED02UodWn21slAVIQw=
X-Received: by 2002:a9d:6357:: with SMTP id y23mr10737514otk.203.1550380280357;
 Sat, 16 Feb 2019 21:11:20 -0800 (PST)
MIME-Version: 1.0
References: <CAM5Ud7NzkM72EaZ_ow4m6wtie=UHYqfhvM3L1dtNX6AidBWEzg@mail.gmail.com>
 <CAM5Ud7NDojyOnNmOpgx7ZsT1g=vMB9xxKOkmVj27FirNp+DPng@mail.gmail.com>
In-Reply-To: <CAM5Ud7NDojyOnNmOpgx7ZsT1g=vMB9xxKOkmVj27FirNp+DPng@mail.gmail.com>
From:   Alec Ari <neotheuser@gmail.com>
Date:   Sat, 16 Feb 2019 17:12:43 -0600
Message-ID: <CAM5Ud7P64zfxXwTd_TwnP623B0tEonhTAx0DMu_otn+rf64UnA@mail.gmail.com>
Subject: Fwd: [PATCH] scripts/sign-file.c: Use CMS if LibreSSL >= 2.6.0 is present
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, it seems it's impossible to add tabs via gmail. The appropriate
patch has been attached to kernel bugzilla #202159

Sorry about this, hitting tab toggles highlighted selection, using
"more indent" didn't do the trick I guess. The patch works here but I
suppose not for the one who reported the bug.

Alec
