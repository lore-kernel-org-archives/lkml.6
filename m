Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FE2C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042C020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="qC/0DlP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l94w8xIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042C020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeFTEVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:21:15 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60389 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753594AbeFTEVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:21:09 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 812E721BE5;
        Wed, 20 Jun 2018 00:21:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 20 Jun 2018 00:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CvifqLPP7cGoRj6Up
        SP+9PMq0GmO9sSt02sZ9BN0R08=; b=qC/0DlP3sdJbJvMhJnJZ5AvxeO/Ayqhgb
        PCrSiBzMe73rm/raUfDm2YrwLa+Ug+vPFxxPKfVjHEjRBTSdxo4THub3LscNhYJX
        9QYCZi2l80cWgjDOyHeDFSdtekKHxKxQ5Meop5uyEln098u3ZVEKTxrH2vuSngWb
        jZjMJHjcWSfm1BCZnZn108HCb7DYIYD2/fkUltNwwWvbAdn/cVKzD0syxmLUjHuC
        0intiOZkXSR6CgDIzuzJb5eDz5dTov5sID9hFV49lcbV0rnCRRqDXzp7TuXBJ25Y
        0EeLK6U/WppytS9xYkaFSU1DoTdLfB51/1IuXw1E/iyfx5R9AMMLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=CvifqLPP7cGoRj6UpSP+9PMq0GmO9sSt02sZ9BN0R08=; b=l94w8xIK
        zhzI9l0ar7bksQTpIY58DvFsCgvvsprUNuKbwr3UZ3AdCOJGi1FePK8bqrUwP0rR
        0t2mG+3LBxym/Ij5iEd2UuKb4IwGoq4l+Dodbt9+FKtJ+PUlEWP9W/HzYiOlpNPj
        Dmv2n38mTcJ9KputxpC+t2v7bbBK/DtwchJNqU1S21A/ycV9fNEw1jlhLletowJh
        lgoVOrziKqSUXutB9snmF86IQt8RalNHJW5lBl9h7StPaKWN18lwKSvNFhVQOHvz
        FAijDUII5g49cEFt1UKkQDJlYbspQiAi+0iEMnVDQ7+BXppUUCbqnX0CDlCFH1lv
        cCCgLZIgTv9Afg==
X-ME-Proxy: <xmx:NNYpW3FsK61FrpiJ2_QBNSRFcB29yEYGariwFJeY8NHDaNua5zWzDg>
    <xmx:NNYpWx9ttgLOiHgd2vN9zrLIy7CtNzf2QWfmcotEZKrkxTvbd2waMA>
    <xmx:NNYpWwjigldRSAnLJB2fc4KmQ2MVR11Ju0KmOC2FsfK64-b7rRYo0A>
    <xmx:NNYpW9Q5VfsdNwQ3YvbSz-5zZaRuRoAvTc0Wn3lLzSIeKceazTGwZg>
    <xmx:NNYpW1DPlcayb9oEgCvImH9Gwg9-_wrYEbJO777lCss0Qss-Pzw2pQ>
    <xmx:NNYpW30SrkZs9ZrO1Dmj7B9hTpopyiOb5heygpZDWWVW7BI9V23f_g>
X-ME-Sender: <xms:NNYpW6U3hSakHfXEmmyn6lu6fplb-iUHf8wz3_EHt54Pf2C51Mj-HQ>
Received: from localhost (ppp118-211-207-6.bras1.syd2.internode.on.net [118.211.207.6])
        by mail.messagingengine.com (Postfix) with ESMTPA id A65CFE403B;
        Wed, 20 Jun 2018 00:21:07 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/4] vsprintf: Use hw RNG for ptr_key
Date:   Wed, 20 Jun 2018 14:20:45 +1000
Message-Id: <20180620042046.30806-4-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620042046.30806-1-me@tobin.cc>
References: <20180620042046.30806-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we must wait for enough entropy to become available before
hashed pointers can be printed.  We can remove this wait by using the
hw RNG if available.

Use hw RNG to get keying material.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 lib/vsprintf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a48aaa79d352..c445f9f28760 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1675,8 +1675,16 @@ static struct random_ready_callback random_ready = {
 
 static int __init initialize_ptr_random(void)
 {
-	int ret = add_random_ready_callback(&random_ready);
+	int key_size = sizeof(ptr_key);
+	int ret;
+
+	/* Use hw RNG if available */
+	if (get_random_bytes_arch(&ptr_key, key_size) == key_size) {
+		static_branch_disable(&not_filled_random_ptr_key);
+		return 0;
+	}
 
+	ret = add_random_ready_callback(&random_ready);
 	if (!ret) {
 		return 0;
 	} else if (ret == -EALREADY) {
-- 
2.17.1

