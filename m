Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B72EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159A224491
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7ZPG24a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159A224491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753518AbeGDNhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:37:11 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33707 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeGDNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:37:07 -0400
Received: by mail-pg0-f65.google.com with SMTP id b15-v6so161394pgs.0;
        Wed, 04 Jul 2018 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6XjpLB9wSJQc+z6jT5a6EOWybVP0TNgpBjba/zoR8I=;
        b=O7ZPG24aypjwkenuq36H0FaqopgPt/Cj5O5scp9hOiNoenMlcjrc+DoM10+3E13lXY
         3ahmQD4vJxSDt0bwE5Dro1myIW63iQSdttbgaR3beM6dd5ZX/0r0cVDvQ0Gs/Zu6uAb5
         s+v/fWMX+1Wj/S8vrcWY9umaReAVVM22i0Q/I6lLKCOwUvkMLmFxySdRqrmaQAxE2Jng
         IdWACgQ3WsTjfklBdaSoI4FCOUp4z4rBiI2O+2PrXYot6w5ya5f9YDPRv8ykDg590Qlt
         PCWIzDiHRoD/gjMQp9IY5fpHdJgodqnvbod8xMC7mlXZxVTE4ZuMtDjvyfiXWM2qYch+
         1o3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n6XjpLB9wSJQc+z6jT5a6EOWybVP0TNgpBjba/zoR8I=;
        b=HZFIjYYxCk0ay2fpVVdUHmpjE9vsH9qfnxKaAO7GOrHp8FGDt2SOa3H8gSUmS9nFgW
         RugTX1/u27XIRwxYik3qCqUp94fli2yFtObYA60/y59Vtnt73y4n93NJcDuxE/28K1Ni
         WwXNRi05Qcq9j4uI00hSIzZXCLKgke/ZF3k8FYc20AlKqtNfQC2JoBuzODgZXzP2JKr7
         1wAX1a119r//RsoPi8mlio7ETLUux+wwz49Xn9YRnZSyRR4lhEuAaxKlXapFT6W2R6VH
         r24If5iP+c2pb5Iiz026e7Vh1mDaqBfsHWNcdFE7QbvHtyG/2lc+DUQ1NgUIuNsNJBMs
         v9+w==
X-Gm-Message-State: APt69E36/VgFe5BcDKbdOCe4VOrgSenCUC+rGkKCouOGlidi1Dnn34iK
        DOxEwzwDN61XzC38wpOpkmA=
X-Google-Smtp-Source: AAOMgpfa9SH04zRXqCGOZDY0cTQr3suwhXdslFPOj9UFKwHKQblSburFkb0OmRI6yvT8bkx+fx5/Fg==
X-Received: by 2002:a62:ed5:: with SMTP id 82-v6mr1009574pfo.198.1530711427218;
        Wed, 04 Jul 2018 06:37:07 -0700 (PDT)
Received: from localhost.localdomain ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id i12-v6sm3593913pgd.87.2018.07.04.06.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 06:37:06 -0700 (PDT)
From:   Taeung Song <treeze.taeung@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taeung Song <treeze.taeung@gmail.com>
Subject: [PATCH v2 1/4] samples/bpf: add missing <linux/if_vlan.h>
Date:   Wed,  4 Jul 2018 22:36:36 +0900
Message-Id: <20180704133639.11855-2-treeze.taeung@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704133639.11855-1-treeze.taeung@gmail.com>
References: <20180704133639.11855-1-treeze.taeung@gmail.com>
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
index 95c16324760c..0b6f22feb2c9 100644
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
2.17.1

