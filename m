Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACB2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED0220879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJhMfuVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfAVNoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:44:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33191 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfAVNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:44:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so11112911pgu.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rEntjk/fJ4oHEuNF9JD18gQfFuD3y2ZK8grEV6Gy5c=;
        b=HJhMfuVss5GLAQGWPmKSfbbRV5EoMZ5ATQ24HNwhz2uGfuGylPYFBqPebqi4ODD9A7
         pwzV8QB3hK355lcPGo5py4t95syqxJ3VJ3fj5d3lWKRXLGcVYIwfEdslWW4PKreiaLAu
         qxpGsCV9/LNpKrEs++eGWCDZfwI48QdY+EqmVjKLAvUbY7A5CcTDiF03muRtXzCj+wlA
         1lgExy/RvmJtJD+7P5xxEYtC1N6cxFn5h9sM22de+b//3ZpCbUEWkdPj7aXXTbWnyYA/
         MXz91mnDHruAl9Eu0pJnHXuh845XEZ+dD8434b10wAhdE/XXcYJ4750X62HaA75SoLlO
         obHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rEntjk/fJ4oHEuNF9JD18gQfFuD3y2ZK8grEV6Gy5c=;
        b=EglhsEhoZrErUoB+vbAE0I3dAdXDNMgZMzskomXrt9PvdE38us8gSzh5u7S4EKdWMO
         peO6BGK+VZZ2cbJfZa3AkbcMyJgbbcjPgxw1Q2rguRaUZ45xYRZdhKXIJYUHUOgAROzK
         SdXaMX9ra+eIKH8ujV8KwfkLRMrxl3cWzqvAVYeecUlP7aDm/ceF+fixbIfvBMIFayoO
         PUbklZfERKQMvHam9npFYQOO/Brcui2aQwCpy+x79X/PqzxfRyxJKufy1bnI0N2HlhlZ
         0HOaW5NenAvPl8/EZzh0iNqxLG22ZD4B0M+xb4us6P2zeQm/ZlS6hnylEkARfIOZqwBX
         wqHw==
X-Gm-Message-State: AJcUukcxKv49ENQtTGI7LmzCcbS8PA87t19Q7tv7IU0oEhz90NQREyGB
        FZ6kS9bus1xryonYZ5sNjEs=
X-Google-Smtp-Source: ALg8bN4LWOFDdWjmflb5HjDGvmgH2jJgPDSS87cHJYTpvxbJ3f75ssHR3rEV7Qiw0pKemhJPYTTHEA==
X-Received: by 2002:a63:7d06:: with SMTP id y6mr31719543pgc.171.1548164685211;
        Tue, 22 Jan 2019 05:44:45 -0800 (PST)
Received: from hydra-Latitude-E5440.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id h185sm22474067pfg.143.2019.01.22.05.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 05:44:44 -0800 (PST)
From:   parna.naveenkumar@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Naveen Kumar Parna <parna.naveenkumar@gmail.com>
Subject: [PATCH 2/2] mbcs: add .owner to mbcs struct file_operations
Date:   Tue, 22 Jan 2019 19:14:02 +0530
Message-Id: <20190122134402.26653-1-parna.naveenkumar@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar Parna <parna.naveenkumar@gmail.com>

Without ".owner = THIS_MODULE" it is possible to crash the kernel
by unloading the mbcs module while someone works with the file.
Fix this by initializing the ‘struct file_operations' ->owner with
THIS_MODULE.

Signed-off-by: Naveen Kumar Parna <parna.naveenkumar@gmail.com>
---
 drivers/char/mbcs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/mbcs.c b/drivers/char/mbcs.c
index 8c9216a0f62e..0a31b60bee7b 100644
--- a/drivers/char/mbcs.c
+++ b/drivers/char/mbcs.c
@@ -50,6 +50,7 @@ static LIST_HEAD(soft_list);
  * file operations
  */
 static const struct file_operations mbcs_ops = {
+	.owner = THIS_MODULE,
 	.open = mbcs_open,
 	.llseek = mbcs_sram_llseek,
 	.read = mbcs_sram_read,
-- 
2.17.1

