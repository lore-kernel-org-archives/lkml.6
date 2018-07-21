Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FFECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9586320856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAlmdFUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9586320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbeGUNxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:53:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33272 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeGUNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so9025289pgv.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jz/0E66s5QdxLBrKAo8wNMWN58mXtO1Opehgh6K1EMw=;
        b=KAlmdFUFYQYa455egmd4niPrBQWMOVaj2IQ6d9ddXx/Q58K42w7z8WjZVGvTx/BY4z
         i+B6Y1b7d33Al5znH6WiPImB4xVd6dwb2O6vDl+MFBzSmOpyHmPePcjiuYCZi9BmEV3K
         cR+qHyEUWgg0UFYgdd71wXgs6kvPO3kfJXct5CEfQT8u+e9ErrUyXG81rYwCktDYXtvO
         wm9pPPK+c9n5Ai2FrrAP85LwiJs2Wwe513ixz+ss99RadlKcIsK32t9/fbYGgRuOvtbi
         ggNamHsHxcdq8nUkhJY0mFFuQwWvGavI5LLJE+7RIOU4eTUiyDlngkgj+bU+CDRGV3i5
         qedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jz/0E66s5QdxLBrKAo8wNMWN58mXtO1Opehgh6K1EMw=;
        b=n2HnBAJs0XrcJM0iQrZZXzlSk2mynG8Ji3zkv/fUx4xBg6VSM4d12ICnig2j80rEnm
         sNsAjCQXzo2ImB3DwrBC6MBh5Y/OANN76HgUZZFspu1Lfv46dEo0mp7Aosgul7Ido0IL
         YfSYCfl6doSdR2d0D7ZFJu5nsw+/vTcCPGO78xmpbfK5t5/fkEMWAG2RJiE0iaWCtZ9i
         WYfA7Sp9A2HG6kb3GYvzC8eWzLTMLePbO1lAZ9txWdxhMHi2RH3IV606H3la0UCd3w53
         nvLkOmDVd/O3qFaLaHNK5cVLxv3jp6Oer7MaiYBPyu4l5tDG0M7x2O6HvL9N8KOc8eZn
         KhZQ==
X-Gm-Message-State: AOUpUlGxiQ2FRkRrPQU8GcZV+zxx8JLeFz/qtIGps3eyiz7xooR6Kscd
        WbQpKSymAAn2dSmYuJc/Ql8=
X-Google-Smtp-Source: AAOMgpd4RNbgfxzs/VoIcWKYJh3tF0yw33HkHuK3/winkwouZJr1b94vf3g1mQKKTsdJyrSbXzP86g==
X-Received: by 2002:a63:9f0a:: with SMTP id g10-v6mr5653066pge.324.1532177857729;
        Sat, 21 Jul 2018 05:57:37 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:37 -0700 (PDT)
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
Subject: [PATCH 03/14] staging: gasket: gasket_handle_ioctl fix ioctl exit trace param
Date:   Sat, 21 Jul 2018 05:56:44 -0700
Message-Id: <20180721125713.88501-6-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Pass the return value from the device ioctl permissions callback to the
tracepoint when the callback returns an error.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index dbe9fdef0c268..1b164ac7a0496 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -65,7 +65,7 @@ long gasket_handle_ioctl(struct file *filp, uint cmd, void __user *argp)
 	if (ioctl_permissions_cb) {
 		retval = ioctl_permissions_cb(filp, cmd, argp);
 		if (retval < 0) {
-			trace_gasket_ioctl_exit(-EPERM);
+			trace_gasket_ioctl_exit(retval);
 			return retval;
 		} else if (retval == 0) {
 			trace_gasket_ioctl_exit(-EPERM);
-- 
2.18.0.233.g985f88cf7e-goog

