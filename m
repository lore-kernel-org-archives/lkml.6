Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AB9206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="ADlbZKZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AB9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeK2KtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:49:20 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:39501 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeK2Krb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=99dL3HsMKgD31l7uRetJxzAT3iEwJVjD9ZjcYavMW6g=; b=ADlbZKZo1uVD
        ySXN6cpnSFAykB83QX85Z8hHPfC6XZEiIM8bjJ4aII+8jAzv5+BfqOxXjRnx8qiCqOyMuOgk5823O
        EAMQenOeM57i3hpKY2SG7eFQQXkBWY0iZJCGc1irqpmEaFwgGaiP3NANNQ32KJsYzd3eLUCQmvOo1
        9vcBv0nPcGQddrmgaWNi89jaF5kND02l1ETyTTNvVak5KpIyhzg9lbwPrk7x3FkWvc0Z4fkHU7HsY
        fTX5q73RcyWiSx/sBj1+fVwwt9eYXHWbnSC3xg+ZGQGwt4eQRiuo45OV+k29+kp09XPpajA6O9muR
        7vUV4N6x/y7uve/0zXpOPw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Uw-0001zB-Cp; Thu, 29 Nov 2018 00:44:02 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 6C712C11FB;
        Thu, 29 Nov 2018 00:43:58 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 12/27] net/core: Assign a name to devnet_rename_seq.dep_map
Date:   Wed, 28 Nov 2018 15:43:10 -0800
Message-Id: <20181128234325.110011-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00436199908081)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5ow55E0a5s1bVATtYWoeb2J602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTacR+7WyMgzHjz+T9oPWai2IJR/LLbceaqS8MKPufzxmNfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFqIq2rgmnTfzvSnaZPSpdF4ea4rbEb5nCRA6afYiNM/uEuf+eM3l5KPnbp/eQthjVOWYHcP
 06zXqyXOojRJS4zkklapCMIpB7xZTagDrnxQTQTJsjWw5+0eZIpQIcK9yrRZBI4MtpSGpU9W4FdB
 tQesEelBF7Ngqas1fLSi+EsXiO7J//0XCxCMJn8bXo41UD3u+ZQGpXspg4TOqv23+spbzJ3vJBBY
 vcIXZcvdbj7fjbZn+1a2iCCdPFy3WGiBkBZc+BBb+UeYFBhPAZQ65C2d4vB6Mmh6nzlzGKK4CNTd
 FmC4kGAnKNZdqPIYy5/0C0oKEgxQF7G4ajroXShVPl5s3ZvBSOdcZaQYlKee2Vxut+excQEBokpi
 mN+IpZsSCXc5abhTdeMRIGIFGG7eQynS17NirEYyqwqMBGrw8ELiqFSHA33y5Mb3HyPilJ6ZEZbN
 sFlW4xzv3KSabGJbxYTP9L1EoXi+CD9t4odUMDuXpq4Dt0gTEK9vOlOvpFXXjOyucj735mFcFqoc
 4yysvQM8ASJFC/49WOPBr5nlEUI4xIoCyX1J9mISBKtKiIG9rsVhspljkOhpjzwdmRUuxUAkJFpJ
 QUo3xelXG5xGR9WrwtMqpQY/wTdSn/KmmRPQe1WngoWueOlSkfQrrNQ0YaVuKF0zwGgxiH5VYpT1
 74cN8FvxDejqc1gSvA2YxCROcMK2BmRxGQKegzOmzXDxmXJaDPc+rUuIsEwVJ+BZMX32wspaYuNn
 lf+xG0rJagZQpvsbTUZvTFCrhb03Se6iiRxyUV8ShebT8U8Xw9HTDfreWRYYPDOuh+QYnmwzDWDO
 +6vF+qi4JhiyJsp7oQFHICv3/5BQ64Vz3kPXuj5BYP5ioVC/LbdJldJ8xntHMcYfWXZf0dFZX9FP
 4Sdv0y+AiR3/grHo9BntmBzD6tps2qyeMO7J//0XCxCMJn8bXo41UD2nJ33TKG1BQebqdAt2Cyon
 bEaUvgji2bemCFdq6WVPktdpl4o13pcoUjSBRABE8Sc=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes lockdep reports about devnet_rename_seq more informative.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index ddc551f24ba2..8c109a1624ba 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -194,7 +194,7 @@ static DEFINE_SPINLOCK(napi_hash_lock);
 static unsigned int napi_gen_id = NR_CPUS;
 static DEFINE_READ_MOSTLY_HASHTABLE(napi_hash, 8);
 
-static seqcount_t devnet_rename_seq;
+static seqcount_t devnet_rename_seq = SEQCNT_ZERO(devnet_rename_seq);
 
 static inline void dev_base_seq_inc(struct net *net)
 {
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

