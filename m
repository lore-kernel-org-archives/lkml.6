Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0B9207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 04:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srh1M/5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfBVEKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 23:10:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43836 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfBVEJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 23:09:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id n71so776729ota.10;
        Thu, 21 Feb 2019 20:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fB11OAjQTMSWomG1nU88AL6IibWleeoEtKkmtCRPDFk=;
        b=Srh1M/5+97RWTCpmGWsWQ7AxDlFan3jDLhaVmmPFhQaLgKUl5wNNqAgML05RKt5osS
         LGtaTsJQcKK47DeDbJlM3/yoYoIzAHkvfIZ92G0yWeLq3BOwsan+K/wp4U+ye0cBnyTR
         hurtI6BFtVLxBCsc1mUgEVOYDg9ity1q9qysELvui3hU2xqF/xl3+lJI0vBgdtcCFdsg
         nosNZrIDRg5q9HDmTUCe+zWg4Fe7Zu+C/7eJDnKxRyMDC9UM0yr5l2G2OjhmYpLIMisn
         PdysrJESm55ZiLFTbeLMP+66eeUYVYP3IlYY0YcTmRrxK24V61s0ZTKeUZpQY2vMfa2j
         FH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fB11OAjQTMSWomG1nU88AL6IibWleeoEtKkmtCRPDFk=;
        b=W6kqdRkkhGc4O/iF1CLlkxuB27isTnmaOZWfgF0OPqTMLzJC4+jb41jvT/OUCjUFKy
         sgJlW5cLOsgZozY2/9LDeQYTQra7LacntsCHn7pE6f00UaUnyXnNSJ/cfOw19SFTbGb7
         mYEsapKvZwcM2MW83UwyjnMdFSjvfUoQPQETTY9wmyhlGT2fGkCwSn2LjBy7UIT9Nmw2
         V2qaovAA3+08TdvaeZa182tYpV0bApJuEqrTcpxYXTrmIIPDorQdLjb+INws59tLmzbV
         BNqLynQumPv9fW0BIqPVZe3qkCznkXVCgIut/bpOAc7dHTz0oD8NDXj0n2HmycJKrF+X
         ZEYw==
X-Gm-Message-State: AHQUAuZQB1M+eQC9uIL9hbBS7rJFEo3qDPWAeMyhRYjsX5xXk6VAbZUO
        rvq8jV4YJ2WmiC0nHR/tPYjy+kvq
X-Google-Smtp-Source: AHgI3IYlpQiuRF40WD3/qIFR9LJhUk6GVmfeGDgmoXmpllDEPNwK2mgUBWsB4vpjYiKUXd7yiWhlpA==
X-Received: by 2002:a9d:7554:: with SMTP id b20mr1354832otl.32.1550808594677;
        Thu, 21 Feb 2019 20:09:54 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id r1sm167836otk.48.2019.02.21.20.09.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 20:09:53 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Florian Fainelli <f.fainelli@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        David Ahern <dsahern@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Li RongQing <lirongqing@baidu.com>,
        linux-kernel@vger.kernel.org (open list),
        xdp-newbies@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [PATCH net-next 4/4] veth: Fix -Wformat-truncation
Date:   Thu, 21 Feb 2019 20:09:29 -0800
Message-Id: <20190222040929.16657-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190222040929.16657-1-f.fainelli@gmail.com>
References: <20190222040929.16657-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a precision hint to snprintf() in order to eliminate a
-Wformat-truncation warning provided below. A maximum of 11 characters
is allowed to reach a maximum of 32 - 1 characters given a possible
maximum value of queues using up to UINT_MAX which occupies 10
characters. Incidentally 11 is the number of characters for
"xdp_packets" which is the largest string we append.

drivers/net/veth.c: In function 'veth_get_strings':
drivers/net/veth.c:118:47: warning: '%s' directive output may be
truncated writing up to 31 bytes into a region of size between 12 and 21
[-Wformat-truncation=]
     snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
                                               ^~
drivers/net/veth.c:118:5: note: 'snprintf' output between 12 and 52
bytes into a destination of size 32
     snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       i, veth_rq_stats_desc[j].desc);
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/veth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index fbf890ebbeae..569e87a51a33 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -115,7 +115,8 @@ static void veth_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 		p += sizeof(ethtool_stats_keys);
 		for (i = 0; i < dev->real_num_rx_queues; i++) {
 			for (j = 0; j < VETH_RQ_STATS_LEN; j++) {
-				snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
+				snprintf(p, ETH_GSTRING_LEN,
+					 "rx_queue_%u_%.11s",
 					 i, veth_rq_stats_desc[j].desc);
 				p += ETH_GSTRING_LEN;
 			}
-- 
2.19.1

