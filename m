Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4EBC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76AF20855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3FxSqAD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76AF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeKZGjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:39:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38464 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeKZGjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:39:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so13287900wrw.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 11:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MhdDBBBAQf8DlrD78udgNz1GWmvxiQBnM0+4kbNQ25o=;
        b=X3FxSqAD2CU0LqAq6caZ25jV2Rdf/AMMYrBmhQikURc3DO4zs6k/jdSFKxn1Q7MNHv
         IC5YfBaIDxbHTlpazlfvawTdIjvuHJAKkZJU4xTfflkOQ2dXAOPOim3deVoPjJd0GlCZ
         qSSxZu302voMLyDsbKqCAKxGruXTX+AB8hudQNXjlw6UUzGu4/mwBvpxmsM3/JVxCbMJ
         3eeBUzohOItv+6lvH/NiVyEFacj7vCO2n5bJzf8DODieG6dpAAlXAaH04CSIZmcxMVmL
         xCTi3gvrosxbcnbOWsUGxlmXJ5+zYTEjp1okqAivTAHRPXo7kobFjJf1PiUcvJkzkaXm
         LNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MhdDBBBAQf8DlrD78udgNz1GWmvxiQBnM0+4kbNQ25o=;
        b=Dl7Ak2LH5pYLMBLGSJV4yxcQ1IfNXZHcuZltk2w4syV14YrgZme91grSzqAPSLy4bA
         Oey/DIU9NN8fIxFkhLvBZyLMWRL21Ne0yISVtntFZ+ZLZKta3pJkEEhlIPocimCalK/Z
         5iWBdB2p668jtklfhlaWXh5+tj4QNbnNBSjfIcU7KoOwgWug7AzYYNdXhfEnq0ro9fFf
         wzQSVDtSPAU2Ox2fgTQQsGlCC+rJIlf7cHyKXSy33+dIf8rIR46RxXPoJYdi2wePlI2C
         Karz6mlht9GiUCUEdcX4lz6lTVgBAagfdVIMvJZiSdfofhmt7Z7g3m5VaCPeNvxBpHuE
         5WOg==
X-Gm-Message-State: AA+aEWYh0uoO+E2FNexNzPABC4zFc0UQ632XU+jyDLe6bBUNlGk5QWt4
        J5mcqTbrYLq9AB/yM91asI/eIDD+0ak=
X-Google-Smtp-Source: AFSGD/X4cYyvDlsXDnGGIyZNmWoKUIUc9YWvdmOIFlt68YYWh1xbDAHKhwoTc5+Om54Y2HpoKLAXlw==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr20367491wrq.16.1543175266172;
        Sun, 25 Nov 2018 11:47:46 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id y138sm15744436wmc.16.2018.11.25.11.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 11:47:45 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 5/6] char: lp: fix whitespace with pointers
Date:   Sun, 25 Nov 2018 19:47:36 +0000
Message-Id: <20181125194737.5591-5-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
References: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch warning:
"foo * bar should be foo *bar"

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 15d03aa55a1a..017ea457a9d7 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -192,7 +192,7 @@ static int lp_preempt(void *handle)
  * Try to negotiate to a new mode; if unsuccessful negotiate to
  * compatibility mode.  Return the mode we ended up in.
  */
-static int lp_negotiate(struct parport * port, int mode)
+static int lp_negotiate(struct parport *port, int mode)
 {
 	if (parport_negotiate (port, mode) != 0) {
 		mode = IEEE1284_MODE_COMPAT;
@@ -294,7 +294,7 @@ static int lp_wait_ready(int minor, int nonblock)
 	return error;
 }
 
-static ssize_t lp_write(struct file * file, const char __user * buf,
+static ssize_t lp_write(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
 	unsigned int minor = iminor(file_inode(file));
@@ -412,7 +412,7 @@ static ssize_t lp_write(struct file * file, const char __user * buf,
 #ifdef CONFIG_PARPORT_1284
 
 /* Status readback conforming to ieee1284 */
-static ssize_t lp_read(struct file * file, char __user * buf,
+static ssize_t lp_read(struct file *file, char __user *buf,
 		       size_t count, loff_t *ppos)
 {
 	DEFINE_WAIT(wait);
@@ -491,7 +491,7 @@ static ssize_t lp_read(struct file * file, char __user * buf,
 
 #endif /* IEEE 1284 support */
 
-static int lp_open(struct inode * inode, struct file * file)
+static int lp_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
 	int ret = 0;
@@ -561,7 +561,7 @@ static int lp_open(struct inode * inode, struct file * file)
 	return ret;
 }
 
-static int lp_release(struct inode * inode, struct file * file)
+static int lp_release(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
 
-- 
2.11.0

