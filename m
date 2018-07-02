Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65834C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E382555B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaKF6U1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E382555B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965095AbeGBJRD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:17:03 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45832 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965047AbeGBJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:16:55 -0400
Received: by mail-pl0-f67.google.com with SMTP id bi1-v6so7649464plb.12;
        Mon, 02 Jul 2018 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4XorU3zqP9XxZCB7qmx3UuNdzlVxuHzSk75vgTdmeJ0=;
        b=BaKF6U1jNyc8VGdFJS9J1t+4g4bvauJ3yM911QMTtc9ePKjsSqMVlhWNeCvM2gs05x
         9Rj+/T3Blehnu9Ly2e7k15gOOpCTxoAuM2GsWB6uc/0RjAMT0GM5tbjCNgddFn1uiYf1
         po886hWIajfG81d16fGvov7pAcvIR8vZb1VM9ZmLA26qx/RUPwTBkWApa8Z4jIbz7JzL
         33urWhRvKzk+4u1nGp7tYM9sobR5A6ahavhCFZyNgio2/cSUwaU5J+8b6M2h5RzQJznf
         YHRF0tiw79oojKy/73RioWd2Vwy5ATXOoPMkq8ZlsraVo6QJm5PnSIriRVT0UK7DeH7u
         YJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4XorU3zqP9XxZCB7qmx3UuNdzlVxuHzSk75vgTdmeJ0=;
        b=bn+iM7m5zf845GlJekT6e8dFJOjVoYhWZ3sWZKLdKuLrk69XpeXRjr0oRdg29+3ppz
         WGnFLCGi97ph0307NyprUAlFJgs6J7k+0lVwYl1iuOA831nT8pOlKo8aYlvQZ+62241A
         OKHv9Ol6dN7IMkOMKRUOxYWjKvbw2Qle+QHT20s/Tk2oPI2/VlR2JluqAmum9/wxJvvJ
         j36lOFo/gvqBUeeoP1drnmhVSE38b6fJ18I98LPN9S2PG+vW7+iZFS92t749eFf1R6iV
         YVOOYYpCfimA/VNBNx5AQYbk7fCvIB1IqUbVXS+7JlIH76EkSd8c111vmzRvONmml434
         Y0LQ==
X-Gm-Message-State: APt69E1ezBZULODybX9oiwSsS5fk/qAR17rm5wbqRXfJwHZd2bkoTNdT
        87vLwyyf8AOwaUR9m+SULbE=
X-Google-Smtp-Source: ADUXVKIeeN/8cafL21bRxMYHSX7YvQ+YT8TZtw2aH+TAGrqPT1K0eWcCVAQeaucz1bzESIxsGIgoWQ==
X-Received: by 2002:a17:902:784d:: with SMTP id e13-v6mr24510898pln.197.1530523014789;
        Mon, 02 Jul 2018 02:16:54 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id 67-v6sm24527627pga.9.2018.07.02.02.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 02:16:54 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Teng Qin <qinteng@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH 1/4] samples/bpf: add missing <linux/if_vlan.h>
Date:   Mon,  2 Jul 2018 18:14:50 +0900
Message-Id: <1530522893-8961-2-git-send-email-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
References: <1530522893-8961-1-git-send-email-treeze.taeung@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes build error regarding redefinition:

    CLANG-bpf  samples/bpf/parse_varlen.o
  samples/bpf/parse_varlen.c:111:8: error: redefinition of 'vlan_hdr'
  struct vlan_hdr {
         ^
  ./include/linux/if_vlan.h:38:8: note: previous definition is here

So remove duplicate 'struct vlan_hdr' in sample code and include if_vlan.h

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
---
 samples/bpf/parse_varlen.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/samples/bpf/parse_varlen.c b/samples/bpf/parse_varlen.c
index 95c1632..0b6f22f 100644
--- a/samples/bpf/parse_varlen.c
+++ b/samples/bpf/parse_varlen.c
@@ -6,6 +6,7 @@
  */
 #define KBUILD_MODNAME "foo"
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/in.h>
@@ -108,11 +109,6 @@ static int parse_ipv6(void *data, uint64_t nh_off, void *data_end)
 	return 0;
 }
 
-struct vlan_hdr {
-	uint16_t h_vlan_TCI;
-	uint16_t h_vlan_encapsulated_proto;
-};
-
 SEC("varlen")
 int handle_ingress(struct __sk_buff *skb)
 {
-- 
2.7.4

