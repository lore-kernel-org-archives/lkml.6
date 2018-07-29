Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B34C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EB920857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5kCrn4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EB920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbeG2VIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:08:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38678 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbeG2VIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:08:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so6032002pgq.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U8SGMbPtwUNMmwMz4uoZx2qv637pv0e+EaUmh3FMSTs=;
        b=u5kCrn4k/nneDAgOX2udF2mlNLF0QknDI5uc474ALuPQ3sA2FIcVDDy181C08QnKxi
         vPd04A24vmQBl/MnAXhN+f9OJZKRhKPFkP/q41NRaF376ngvhhT+CJKUdxATePYjmOt0
         0oLvz2t4W7wp9Q8t79tdu9KKcW+e8ttCbPqSjFhqBCd2e1Gkmm3wUqtdTJ3fR3mX003S
         UhTDPhEo8+OXSdNYA/4EeaOaNdkWPWmXqd1ULhEnemSIKQRNNm+Wqd7cHBWxA+TOFJHY
         IQwJ3J8dy5fmMM4jZo58eCF1/K4Yi64ecDxAiy/a4/rjuG+g45tw3e6QYn2NImI9iZDt
         fS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U8SGMbPtwUNMmwMz4uoZx2qv637pv0e+EaUmh3FMSTs=;
        b=uEMd2F/DjE1d460LzaQKPL4Slti1X/p5cD1pUkQ3TEFx5EFZljcDJ3To2aJqY4tQOy
         LpHV2hvb9o27YaLanoNQ69sa14C0sFKb4G5QaXZ9Iv0cEi7BpmfgsU7ZG+Yb+nL393Ke
         6XWgMuC3R32urR7BddHFKETNewyVcP0oIDZ1aV+1SnvQ+/rEx1jggyxc97kWXJOGu3qw
         PJg+ypCepohQkFPjh8KOVqnbEBSXLE8BJUmmSTGAjtEkVPKCEAg6VVBaahnAaf/K6oea
         yRk0agGGR2z+wapeR4v0+tgpkFnJ7aoMyfqEVz3lOk7FtbOQP82ImmCRSzXlUosHe0X1
         hDsQ==
X-Gm-Message-State: AOUpUlGQyq64kImcuAeRFK0E48ri7SY2O7IBObSYvtzp/jGzIsF5QXPu
        YZ3BKaQCEPG4aHJ1I02vL04=
X-Google-Smtp-Source: AAOMgpd60juPcZzZnwovGSGVdIUJ/M6U2ojMlWtBE/r09p2BmgvCRukpfQTPdhWxCSP3/umE4ko1pA==
X-Received: by 2002:a63:5c7:: with SMTP id 190-v6mr13428194pgf.385.1532893028267;
        Sun, 29 Jul 2018 12:37:08 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id k26-v6sm27474062pfb.167.2018.07.29.12.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 12:37:07 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dtor@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 11/13] staging: gasket: TODO: remove entry for static function kernel docs
Date:   Sun, 29 Jul 2018 12:36:44 -0700
Message-Id: <20180729193646.201721-12-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180729193646.201721-1-toddpoynor@gmail.com>
References: <20180729193646.201721-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Remove the TODO entry for simplifying kernel doc style comments for
static functions, now that this has been addressed.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gasket/TODO b/drivers/staging/gasket/TODO
index fb71997fb5612..7f4c13ce021ba 100644
--- a/drivers/staging/gasket/TODO
+++ b/drivers/staging/gasket/TODO
@@ -5,7 +5,6 @@ staging directory.
 - Use misc interface instead of major number for driver version description.
 - Add descriptions of module_param's
 - apex_get_status() should actually check status.
-- Static functions don't need kernel doc formatting, can be simplified.
 - Fix multi-line alignment formatting to look like:
       int ret = long_function_name(device, VARIABLE1, VARIABLE2,
                                    VARIABLE3, VARIABLE4);
-- 
2.18.0.345.g5c9ce644c3-goog

