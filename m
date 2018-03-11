Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-851488-1520755285-2-16114175230765936293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520755284; b=c1zkUWCa44MaA9emL2a+ZSfsA8631NCfE4rE2jkZtoDl+tA
    k4QN2V8jcJdSDc8yWc4ZPfpcrJEwyqLuMADOtfGUl9gKnmA2Ywl2W8/iDd+AewCQ
    KSKMgybnufdRroi13HYNkxyAOfx8odXfNoZV2GIhgDLDBZJIiGM30B8X/sTtYl5X
    IlPplq7/7mY+CRotz6OVGedsrDlLlzQvPLjIxOvkAlSgCsw7Dr4Y44+r9Uzug+Lq
    jUrBqm6cavGJ7dFNQlEb+RUiI/TsiD3+f72HBZZ/CFzQ5MqbNvohhc961de8aGx/
    klnP09eHY9QnA/jvalhPVAzMYxxff3JFe9xil8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1520755284; bh=t08YQf3G7fBmO51/4CXWbKJkRWeQk/QFDtN3ijRRGy4=; b=K
    qhSMREN9/PZXp9/B65pNkyUHXCzV1Etcirj4vnO2zwUf55TjFv0a5Qfkg67Om/ns
    fyknN7oAIiKglLIccWtBjizxfz2gYybRYJt5h6XsEmm102dNyVw8odsysTDHtVCO
    0XkuelmTX1NPoPJLkmLyT9WrzorkNwHlsuUueO21YW0Xb747zIYYYO1H3uIkIe3f
    /m1kGd37IZex5HmNT4Rax1jSWHWqVfaHe///ZCPs0scyr9BnE1h7E2w6Yu1zfBAL
    m7x1GxwRjsS5my9R2BLf+9JyCGwsdciga5IZe9Kg/Nq080hXAwsIwKiMH7g05n/c
    tstUgZ8pEhqw/sJHPrSHQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=yealink.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=10 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yealink.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=yealink.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=10 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yealink.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeCKIBV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 04:01:21 -0400
Received: from vip.corpemail.net ([162.243.126.186]:50831 "EHLO
        vip.corpemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeCKIBU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 04:01:20 -0400
From: OuYang ZhiZhong <ouyzz@yealink.com>
To: <dwmw2@infradead.org>
CC: <computersforpeace@gmail.com>,
        <boris.brezillon@free-electrons.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <cyrille.pitchen@wedev4u.fr>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <oyzhizhong@gmail.com>, <ouyzz@yealink.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v4] mtdchar: fix usage of mtd_ooblayout_ecc()
Date: Sun, 11 Mar 2018 15:59:07 +0800
Message-ID: <1520755147-4414-1-git-send-email-ouyzz@yealink.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.84.1.206]
X-ClientProxiedBy: YLEX-CAS01.yealink.com (192.168.1.26) To
 ylex-mbx02.yealink.com (192.168.1.24)
X-Remote-Spam-Status: No, hits=0.00 required=8.00 tests= version=3.3.2
X-Remote-Spam-Level: 
X-Remote-Spam-Checker-Version: SpamAssassin 3.3.2 (1.1) on unicom149.biz-email.net
X-Corpemail-Scan-Result: 0
X-Corpemail-Rules: 0-0-0-3628-c
X-Corpemail-Clean: Yes
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Section was not properly computed. The value of OOB region definition is
always ECC section 0 information in the OOB area, but we want to get all
the ECC bytes information, so we should call
mtd_ooblayout_ecc(mtd, section++, &oobregion) until it returns -ERANGE.

Fixes: c2b78452a9db ("mtd: use mtd_ooblayout_xxx() helpers where appropriate")
Cc: <stable@vger.kernel.org>
Signed-off-by: OuYang ZhiZhong <ouyzz@yealink.com>
---
 drivers/mtd/mtdchar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index de8c902..7d80a8b 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -479,7 +479,7 @@ static int shrink_ecclayout(struct mtd_info *mtd,
 	for (i = 0; i < MTD_MAX_ECCPOS_ENTRIES;) {
 		u32 eccpos;
 
-		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
 		if (ret < 0) {
 			if (ret != -ERANGE)
 				return ret;
@@ -526,7 +526,7 @@ static int get_oobinfo(struct mtd_info *mtd, struct nand_oobinfo *to)
 	for (i = 0; i < ARRAY_SIZE(to->eccpos);) {
 		u32 eccpos;
 
-		ret = mtd_ooblayout_ecc(mtd, section, &oobregion);
+		ret = mtd_ooblayout_ecc(mtd, section++, &oobregion);
 		if (ret < 0) {
 			if (ret != -ERANGE)
 				return ret;
-- 
1.7.9.5
