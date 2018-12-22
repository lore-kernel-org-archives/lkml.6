Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_06_12,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F1C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CA62195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sizNv+dS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392130AbeLVTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:12:01 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54755 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbeLVTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:12:01 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so11568635ita.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 11:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=Uy3N7oD3HBFB69iKfiIHET7jVZnFJab1ngVgt7Ce8jM=;
        b=sizNv+dSkLL1lnCM/yN4UdWmMg5oyb3CWst47CDtdPjicYMdihjIHVpHPJiTqc8htl
         h7KuChlZfy6jzDf1zHiE+6xpSiLsqiMknhQrvB4yro87fLAWhcSwDaa8hzLcEqtLRFUl
         qz2O/T2bgtIqI7fkdy6Ft3SFtbMrwkemJ1WOQnEzVfe9S+OZ4BW/yh+SBwpgocRqHPjQ
         jcz0BNPNL1gv9JjsNodfxaMhI1jXK8xtaDYi0i6UgV5W0sgt2JL6ufDmTlBQ3RtaROoG
         MrLJg06klnseX3Iuxl7CaWuOZ64Rz+4kmprH2xEkwvK0wLf8vQG2ROvkzV4DG6xYVwgs
         +9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=Uy3N7oD3HBFB69iKfiIHET7jVZnFJab1ngVgt7Ce8jM=;
        b=gKEQgEkegmokzi0Qc16LdygKVZ+2YkTFZ7Yn1d3/BcEVBpQ3usDFfadIXrU81ftNMA
         dqubucvAUJmQa01zqY32woIpz++zWn0U/W9VMtcOkYFTSEc75N9+u2+AbvEf3ACn9IMT
         6YTAK1mnTWf3xsjdC00UBMsA/ZCfQkRAclsmkQhdWq4Ahnq9fFENyazdkZhDtQy9VCtr
         3SKbBgz6ISQeueBMi87u8izUXP+aJAqwfDhl8zsjcyL8d59QV+DhWVQuyCbZWCKV6vBY
         XZOfOy2dvYdlt7cw9OU4mTuIBhsRQUjHdITQ+dHC1sqr0gq09rQbFyfoUiAnjKG7PBd/
         8DMA==
X-Gm-Message-State: AJcUukdoIYguxvCGFN1qM9aTHyVKHMvMFLVd9UCfXgCRdOGNLj3SrtnB
        pORTQ4SYpu6r88arOFLLTSLgQzyhmZlb2tMN81/pLt452qw=
X-Received: by 2002:a24:648f:: with SMTP id t137mt5436273itc.95.1545465288112;
 Fri, 21 Dec 2018 23:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20181221154455.32430-1-tiny.windzz@gmail.com> <201812221451.iR66lSP3%fengguang.wu@intel.com>
In-Reply-To: <201812221451.iR66lSP3%fengguang.wu@intel.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 22 Dec 2018 15:54:37 +0800
Message-ID: <CAEExFWsEXkAo8Max-R6Rn5W7bM4jbP1ViwaFqB=KNaeRR7W97g@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtlwifi: convert to DEFINE_SHOW_ATTRIBUTE
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernelpatch@126.com, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnnvvIHvvIHvvIFQbGVhc2UgaWdub3JlIHRoaXMuDQo=
