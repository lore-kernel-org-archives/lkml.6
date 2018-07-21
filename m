Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971E1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F47620856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUqmP/Vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F47620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeGUO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34485 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbeGUO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so233495pfi.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GyTpDiqCSzoAxLUvfs7PhBh1s33xbPdf/OCeCQ4KrSw=;
        b=jUqmP/VwwM6cUIe0SI9EX6PrdSdfS/ccppmPEp4V7jCTolSEicbNCI7XeNdxzg01o5
         wUNToZOQXsQLhFh+azmwN4KlrAlj/BoHtcQtgjSBGGTSp0G297Axb2wwHsb0/nLo9tat
         636yTaX7WvlaHxa9fkJbQp98yLJzm5yYyOatCa4u7s3kLDNINqfVSbMm9S/z60sGOlJ6
         D2paaZIQlarVxM3/2ErzkviIbX8JtJTgqe4GRhc1yP4p8RBnIRNNSLgLw8U7U34p5Xms
         efnNhoW38Q/f24UKrNrV31YyeJFJ99cyxfnjnvKEwNc1FnWgrVTplV7BDF9zIHH4StDZ
         OQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GyTpDiqCSzoAxLUvfs7PhBh1s33xbPdf/OCeCQ4KrSw=;
        b=AwWK4GyH6jyF69k/rbwQALTuNRVrxkw0urwIcAsKwwKtj1OdqUBqYn9VmGOyYcpZ8g
         NghC1p6maMh6PhGVrVkYNselSK3+GjjK0/Dd8ByasluoVGTfft+llx/h6ZnXaB1HXS7G
         gEOEKSnFTGUOZmZusUrknFEtBopKoHTj2XbSqnCfqfIY/rf1KQS/zKkIbDetL77lsboQ
         DqkDmD1gq+3iWiL/tyahxs9pBXB0jV79KBLds7LvbM3jjEwSgU3d8Wtzpv/N6YzHaVBw
         /ZEnP8Soh7f80egnMLFAfo6KY6mHSQ/jffNUd5cseuyBC/BwmDQfj4mCmB7ss+vUbfwF
         IQlg==
X-Gm-Message-State: AOUpUlGxgdtq28bb689y7r8odTq03eQ8f2d2fEPP/OPwjDzUFwo+v8bX
        CWTOlOvjXwblAf89wpg//kk=
X-Google-Smtp-Source: AAOMgpfSSlliPNJNxPaC5DPl4Xigz0kb9p1xo7EeyeGGLlh+WOWYtxbSjTxYJKOrZwO6FFAwNBdlEA==
X-Received: by 2002:a65:448a:: with SMTP id l10-v6mr5730554pgq.382.1532180124750;
        Sat, 21 Jul 2018 06:35:24 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:24 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 05/14] staging: gasket: print mmap starting address as unsigned long
Date:   Sat, 21 Jul 2018 06:34:58 -0700
Message-Id: <20180721133507.95599-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Page alignment error log should print the offending value as an unsigned
long, not as a kernel pointer.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 2cd232230845c..11ab049854493 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1596,8 +1596,8 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 
 	if (vma->vm_start & ~PAGE_MASK) {
 		gasket_log_error(
-			gasket_dev, "Base address not page-aligned: 0x%p\n",
-			(void *)vma->vm_start);
+			gasket_dev, "Base address not page-aligned: 0x%lx\n",
+			vma->vm_start);
 		trace_gasket_mmap_exit(-EINVAL);
 		return -EINVAL;
 	}
-- 
2.18.0.233.g985f88cf7e-goog

