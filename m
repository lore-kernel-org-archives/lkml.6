Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1623703-1525105347-2-12375593253861603390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525105347; b=fCqfm02jEdxndPbwg8+CyCE9qWJSoGZa8HA/DDWS2fEMhJ9Wv+
    jvBjd0u+alz5vHqMYIYW/7AjJYfNioBUG5HK9tHnbKi9TXYriAyB177KlGJR13yA
    DSFhxQQIRQAWUK0QJMcLyA6s/iTfoVGtvgAGaFmzHSh9QdaHzJ3c9uvBQM/wD5ZZ
    T2M8BgIaAwUyuRQ/9xgdJlEChgn0X+gn3sGa6sAhid/T8ZI+OVrjuu8XpfirB97c
    +j2hkiWtw7lknqlUPKl9Me2X2n3BX/JcrQRegEQx1WmDjjh4GIJehPphEkCs+UFZ
    W3+piwdiCnxHTBxxq0gpZyKq2gr8xb8EhgJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525105347; bh=
    uUmVWtsNF1N4nDp5RlZ4ba9gCfbmBD15yvTmoy+50tw=; b=N/QR5iuRylJ0dA2h
    0jYYQj1SnUpgjDKW9imGidzyRZk1LwCUdFL9l5YoQxmXfoZdhpYsSMaP3XAmub1a
    eaRjV/A8V9DoUa7Fs6s87v21a+4kdCkoudsTcTqDkI1wkL9T68CrCmRcE3jR7Tgs
    zUeFqfkLR7XqbDjW/ibpHsqRbaaaqYfO+fk7tlQ6pNToYSlmshhffH5sT9WSCioL
    uKkOR4qiLho3JNPSC37WWtwFdQFE+tJaDLS0wrzEcI95PGa2FojvNijVwzZVR9sL
    vfG/gQ0yHPHopi/tYbZzRh3iI0oZECUCNcKx8qepAYEt59wrBWkniCtXaudfhP/d
    6Cd5Fg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kTNrIVbV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kTNrIVbV x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJQIB9tHDk2y00lbnUTyT9mIpbhxztRECBYUxZslmwoHBmFIvMsBH1boMIGq2LAPrKTjOUFvleqPPPmmUtAWSKIOvBOq9JZWDsBPDOxWdTELLA4hDKJq
    jt/w2wgBmXWxqvvOjLHOrhny3JY6AdBjukx1DRO5XhEIhLu/y5n/vrRNTJMDEhYoIzVxix5CfF6JbMh4CE3I3cuag9aAVtghqax8QAOiilZfWwu8EoP/+BoQ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8
    a=VwQbUJbxAAAA:8 a=sxZGIfBvxrlZtTb2juoA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754997AbeD3QWM (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 12:22:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754894AbeD3QVm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 12:21:42 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] xen/PVH: Use proper CS selector in long mode
Date: Mon, 30 Apr 2018 12:23:37 -0400
Message-Id: <20180430162339.17143-3-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=559
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300156
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: stable@vger.kernel.org
---
 arch/x86/xen/xen-pvh.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index 934f7d4..373fef0 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -93,7 +93,7 @@ ENTRY(pvh_start_xen)
 	mov %eax, %cr0
 
 	/* Jump to 64-bit mode. */
-	ljmp $__KERNEL_CS, $_pa(1f)
+	ljmp $__BOOT_CS, $_pa(1f)
 
 	/* 64-bit entry point. */
 	.code64
-- 
2.9.3
