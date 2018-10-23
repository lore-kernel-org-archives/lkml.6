Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF7C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4F420832
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSTm8KZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4F420832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbeJXGB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:27 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44089 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbeJXGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so2794363ljc.11;
        Tue, 23 Oct 2018 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
        bh=wfR+fMPqGcMIiSbYRT7t8ZKG+Wth8+A7neWCKMW39bo=;
        b=NSTm8KZSg3mTcjVAHwXvMefH1L9qCAsnuF0SiZouKOL34cs6TBhJ9u+3dCXhe9tcjj
         NFfLiY6U3spOFYXhmO/FSGNo5ANtqmnSBnyS1g7A1mskX9K0SgD6zO5VnE6s2fr91B4J
         htrS0hVNIEptrkthCgGEV+IvfGNvnkUYOg9mFPJCkmz/yP2S2JuRM+fzfkVpuKFgij/u
         XqqTPMKDADSrHYlCm1aZ6pkBs6MPXWIlMRyCaF2ABF6Ot8Ft8QdU54KQHlM1muamJZK/
         RKcz16TjeZRaZsBmYR1rqRzq4xo0ph1FhdQbqY/RqDegyjmxrIiwnhBtLwP8EoMqWHwK
         188w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to;
        bh=wfR+fMPqGcMIiSbYRT7t8ZKG+Wth8+A7neWCKMW39bo=;
        b=ptDUOGck/Ty4WHGCYE6C/eJI3syiWla00WqwAxKmtrmyxo7iolEt6EGhodohBZDBsM
         4IlSRtcDXH9ZSIOnaa4cK6+M2IfrTfYO26sWSBaiY1qrP2EA6yT5vc5aDH/icOuG+hOR
         Wt29xiiFdx3qqpTv6K1KqrbhKmg6ltwGYUGPvXuNU/L9/5JeryzICk4mrheHYSMhS9OO
         ZmI4DS4puRiS17uMrm2wkUx/C9UepPM5D9LdKNKkDKlogPDgx/C/gXpBVAqntsEYaan2
         +tqLYQmOZfqMCiq6CQlhNK+7jdjsZMRuentgC12iE1eB6mxlmTJ0WW/MP3PR9GYDy/1b
         I91A==
X-Gm-Message-State: AGRZ1gK+FVhlGq40fBL6HWVE5p6AFptFrFvznUw67zEaAv1smHWX6HCZ
        qTBCjvupri3KLkuCSpJEoQY=
X-Google-Smtp-Source: AJdET5dVOeRLRbNE9ihJ7d4qwyx504gyotgQkH3VlmhhESWejLxDFLXxKx2mzRRXa361IDY4EQUANw==
X-Received: by 2002:a2e:970d:: with SMTP id r13-v6mr5241lji.30.1540330573423;
        Tue, 23 Oct 2018 14:36:13 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:36:12 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Edward Cree <ecree@solarflare.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] prmem: llist: use designated initializer
Date:   Wed, 24 Oct 2018 00:34:58 +0300
Message-Id: <20181023213504.28905-12-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181023213504.28905-1-igor.stoppa@huawei.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a list_head in an unnamed union poses a problem with the current
implementation of the initializer, since it doesn't specify the names of
the fields it is initializing.

This patch makes it use designated initializers.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: "David S. Miller" <davem@davemloft.net>
CC: Edward Cree <ecree@solarflare.com>
CC: Philippe Ombredanne <pombredanne@nexb.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-kernel@vger.kernel.org
---
 include/linux/list.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index de04cc5ed536..184a7b60436f 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -18,7 +18,10 @@
  * using the generic single-entry routines.
  */
 
-#define LIST_HEAD_INIT(name) { &(name), &(name) }
+#define LIST_HEAD_INIT(name) {	\
+	.next = &(name),	\
+	.prev = &(name),	\
+}
 
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
-- 
2.17.1

