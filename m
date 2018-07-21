Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D179EECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C4220856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpt6Vp/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C4220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeGUO3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:29:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33900 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeGUO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so9080103pgv.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jz/0E66s5QdxLBrKAo8wNMWN58mXtO1Opehgh6K1EMw=;
        b=rpt6Vp/1OBZq5OAopIxOCoOmGQTlpiGO15IE0W+XFFpx/wDQ+j52lS/ungR9Dnlzhn
         nOv6vXEGRoVAaD6VHb1ehG9FXINKXISVqS3C60r6oAf97QqMP6IgcNHAsSiBwZRsHSHG
         uknVRAnCQRYIzNzoQJIvaY2om6CjdXVKhoYkizXpP9m6nB8oj5VA/sFmq5r0m0nyrcpN
         iadGyl11AuXISk80W4D10TuXjGvVOoylU3Zk1mOAW0WCD3EiL7iPOG7Sb2zHqNC57F1M
         UwQd8kqagcAOArjRMdU5i7W93mGXa8eP3H78zaLhHj6faPLQCWciuH69RGUkrj0Lx7b1
         CyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jz/0E66s5QdxLBrKAo8wNMWN58mXtO1Opehgh6K1EMw=;
        b=DbkwD7XghZUwEhCcu0/lKVPU7cr/T8HPCv/sm7DxjwslsZed1ntSasg2JoGZfG1P7P
         DI5fel7+vJaMJiWJwO+R1tPmwqTsazuf71GXOzwoGvJr4CkSkt/MoHB1AUufXNK4Tmzh
         GGe/2JwlIiM3u3eBQH6NzqtPlKNvUNFvzv9D4wRCAl+vH2VZJF28Ihz687Td6iNacr6b
         JNhvQ+zz5g+VNK4UDCyieFUNTwbI/r9pRUs0nlY96R28CYM6XGoRGK7NEv7HkR3v0dh2
         FezH2V7ATJAyO6pJ1iK2ceps1g8eU8WAXFq8YvedjMDa4Irs3LJUiuUXUZFBhvfumeoM
         HKGw==
X-Gm-Message-State: AOUpUlFl92aLOtGwOjm17PxX38KWwrXQgGA3RjPsWGupuKitmYdba9t5
        IEibVe69aL2tYz0/eAM/FfA=
X-Google-Smtp-Source: AAOMgpfIGn6S7k1Ib9a4pjEEcmayh0odQR1lxXL5kL4ObqriCrhCDSjThGeWa352JpTXIwxunxlgNQ==
X-Received: by 2002:a63:524e:: with SMTP id s14-v6mr5777074pgl.35.1532180122723;
        Sat, 21 Jul 2018 06:35:22 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:22 -0700 (PDT)
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
Date:   Sat, 21 Jul 2018 06:34:56 -0700
Message-Id: <20180721133507.95599-4-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
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

