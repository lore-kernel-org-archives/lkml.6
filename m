Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477680-2-18365404331678509827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477679; b=I08lSo7xH9kUGk+YJfrRQ89Eh4GyGU/nhuVd6GzT6n0bx7Dsy5
    H/pVaUTTrTY6jrC3nucRdKKr/7yvEtpLXbe7ON4WZeffUx54PyJemlTLBLFvd819
    KLtdRSN+LNbyFbB1rK1m6FkuCJOrxRkd47Vf65EvppWK654eEknscbsMv3A47ds7
    M2WbU9kQtScn3K9zJS9kwgEev5cVwGD7Ek3QEZ8twH0mbvv8Za82IdaTZL/EyC93
    //QUSfUKgxq3wpadvufwKPG3zmToOPnrCr4o+KvtRp9y6c/cFCnY2L+T8BfHo2Sy
    hP2Xhqqndlki6bk16o3PkfkGvCniJbkzVt/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477679; bh=+8c7eWO9Vufvk8casUiS7oKGQ0YYaC
    4bxJX4FB6YylU=; b=Ry2q29+RD0kAJQWFW63NBtsCmI1aVJYjrjAp59K4reJ4vq
    Hb3p3L1rQ2gliQFiW5ZtimR4KH7rR21g4wT7GWTFHuIBwidyp5PKrHAstuoQS1k4
    sX/VSlltEQe83qFyZn+SlPGZ76AqV0fuisVo89LTuFpGwKqsSIVAkAZljyPr6B+T
    D6H0xnSxCGuaXuCe4xRO6MQzq2xqTqk8g+XLQWi/k8t8zVplYunGwweegads5XD9
    EhT4e6xF7nm+DAVYnmKe2O36VcN1Dg2+sp8fi/ALMYRjDwMSEWLGZS1dEcMGU5ej
    g5tbBhHOrp9XT7H0sf7xNmkw8szJu6hErU9ha8tQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE1FJPdg7E758Zh0Bu7pMV5C7A343njsOuXM4Nl6v2uQ+y5TUsMkEMAjoyCrNeivbuDVi7GHPGgGQL5xgxyT+ZAKdo14aT7wrX+LIkJEOFM2gMnL9B2F
    7UnkT8rbpr+V6vzc2CId16lMNgRgtyB5VQKPoWCFm171eoCiBirY6tYG0Nk7+zegiHOmM8GaHqn1KQaqANeJ2rL1vBvYxzuc+VSWNugw41MRGPTLiDNXHllL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zAyngx5bAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=DBf-hYD_ZGmKF5cw2FYA:9 a=MTVkWTSYsR-TP5zS:21 a=c4HCqgu2vgwQPf1p:21
    a=QEXdDO2ut3YA:10 a=4LA4qAFo6bo561LpWNDU:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbeDKSxe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33828 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeDKSxd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ram Amrani <Ram.Amrani@cavium.com>,
        Yuval Mintz <Yuval.Mintz@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 025/310] qed: Correct doorbell configuration for !4Kb pages
Date: Wed, 11 Apr 2018 20:32:44 +0200
Message-Id: <20180411183623.377033623@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ram Amrani <Ram.Amrani@cavium.com>


[ Upstream commit a82dadbce47395747824971db08a128130786fdc ]

When configuring the doorbell DPI address, driver aligns the start
address to 4KB [HW-pages] instead of host PAGE_SIZE.
As a result, RoCE applications might receive addresses which are
unaligned to pages [when PAGE_SIZE > 4KB], which is a security risk.

Fixes: 51ff17251c9c ("qed: Add support for RoCE hw init")
Signed-off-by: Ram Amrani <Ram.Amrani@cavium.com>
Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -850,7 +850,7 @@ qed_hw_init_pf_doorbell_bar(struct qed_h
 						   NULL) +
 		       qed_cxt_get_proto_cid_count(p_hwfn, PROTOCOLID_ETH,
 						   NULL);
-	norm_regsize = roundup(QED_PF_DEMS_SIZE * non_pwm_conn, 4096);
+	norm_regsize = roundup(QED_PF_DEMS_SIZE * non_pwm_conn, PAGE_SIZE);
 	min_addr_reg1 = norm_regsize / 4096;
 	pwm_regsize = db_bar_size - norm_regsize;
 
