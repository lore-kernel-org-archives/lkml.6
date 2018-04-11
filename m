Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479998-2-13478012586052236135
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
    1523479997; b=VmbWOg/1xKntmV2Vwjpo8n9UMprCBgQcI9QvtMxkXwl6yAfKpE
    qqxW3gY66X9MvEo4lmLvymoVjuAFdhH2k7raAe1HfMRvjrfc18IPEqpwUP6ZweUi
    AUTdL1L0x1XnQnrrpxfeG9uHS4CeZhlHEUeDH5JT6C6tR07MnW40XfJ4/E9F4u81
    g0P/3ynBMmwU8npw5Tfa0wgqoW6xcK61w+wB6pRiJmNb5KcFkhHqiSgCVO22PlHM
    ZEtIXY8XzdslbbqQJEddPrvSRAjalozy+9ACheRuMTRMC2Vnd/ffyvC4LuXyLT8w
    Fajy9pP8624NUAdqjMoqky5jfAuPxmwKgT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479997; bh=e/YKCeZebZfSFy16GfdxxyZ3tgcS3s
    VGhQfQJSF1qrA=; b=DNfc2Cn7okBAK3h/4lYFP4ZUXrO0gHCWRXlhFa1kQ25V6/
    MTGqbhS1JVlX2dtzxFIp1IMrZ6Z6SvjewP4/viiZ8OjR5QvUhHkIAIqg5bQSrq9z
    QmiFdgHl2VLrOuDiNVll6svtqOqj/OeZmVjVr+djoE3UJ9hpoweVF9sFkEXYc15e
    PrRlNPdn+CgAokAmha3a4ZsgDoGYeJ+6f0V8tSjiRDXof9UhnkOf9Adr9FAfNzM/
    0snqg/+0GNZr1krucdpSwjoVNe1wbfui51kx0/dDtURrAt0gmiYXKbF3tF0MAkxy
    2l9yRhu38dFJKqg6Y0yWpPXSWD88MsFp26CIQqVA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfBQzWJdgMh/fDRo0v6OEhqW8GF4nRnHR/esAscrDkfGkaQIXG6yWW/Kvevdwq/WcnV7EHT2X/PBmER88EJPNlX2Qkv9SvaUde1lNT/opWXoMC6KEilco
    JdMDm0WPhmVYucjLkbN5estfKl3Ecx9w9CGsUhqxS5eVODWyGQUmuTdrvu2c3pY/ThvEMWKkZwylJum0zLruF073tELhgubH+Wja5UXWCnx3Pn/0faePO5YS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=tSXHTBh79NvrA8TYtfMA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753899AbeDKUwj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:52:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755493AbeDKSpX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linzhang <xiaolou4617@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 045/190] net: x25: fix one potential use-after-free issue
Date: Wed, 11 Apr 2018 20:34:51 +0200
Message-Id: <20180411183552.771608732@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: linzhang <xiaolou4617@gmail.com>


[ Upstream commit 64df6d525fcff1630098db9238bfd2b3e092d5c1 ]

The function x25_init is not properly unregister related resources
on error handler.It is will result in kernel oops if x25_init init
failed, so add properly unregister call on error handler.

Also, i adjust the coding style and make x25_register_sysctl properly
return failure.

Signed-off-by: linzhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/x25.h        |    4 ++--
 net/x25/af_x25.c         |   24 ++++++++++++++++--------
 net/x25/sysctl_net_x25.c |    5 ++++-
 3 files changed, 22 insertions(+), 11 deletions(-)

--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -298,10 +298,10 @@ void x25_check_rbuf(struct sock *);
 
 /* sysctl_net_x25.c */
 #ifdef CONFIG_SYSCTL
-void x25_register_sysctl(void);
+int x25_register_sysctl(void);
 void x25_unregister_sysctl(void);
 #else
-static inline void x25_register_sysctl(void) {};
+static inline int x25_register_sysctl(void) { return 0; };
 static inline void x25_unregister_sysctl(void) {};
 #endif /* CONFIG_SYSCTL */
 
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1794,32 +1794,40 @@ void x25_kill_by_neigh(struct x25_neigh
 
 static int __init x25_init(void)
 {
-	int rc = proto_register(&x25_proto, 0);
+	int rc;
 
-	if (rc != 0)
+	rc = proto_register(&x25_proto, 0);
+	if (rc)
 		goto out;
 
 	rc = sock_register(&x25_family_ops);
-	if (rc != 0)
+	if (rc)
 		goto out_proto;
 
 	dev_add_pack(&x25_packet_type);
 
 	rc = register_netdevice_notifier(&x25_dev_notifier);
-	if (rc != 0)
+	if (rc)
 		goto out_sock;
 
-	pr_info("Linux Version 0.2\n");
+	rc = x25_register_sysctl();
+	if (rc)
+		goto out_dev;
 
-	x25_register_sysctl();
 	rc = x25_proc_init();
-	if (rc != 0)
-		goto out_dev;
+	if (rc)
+		goto out_sysctl;
+
+	pr_info("Linux Version 0.2\n");
+
 out:
 	return rc;
+out_sysctl:
+	x25_unregister_sysctl();
 out_dev:
 	unregister_netdevice_notifier(&x25_dev_notifier);
 out_sock:
+	dev_remove_pack(&x25_packet_type);
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -73,9 +73,12 @@ static struct ctl_table x25_table[] = {
 	{ 0, },
 };
 
-void __init x25_register_sysctl(void)
+int __init x25_register_sysctl(void)
 {
 	x25_table_header = register_net_sysctl(&init_net, "net/x25", x25_table);
+	if (!x25_table_header)
+		return -ENOMEM;
+	return 0;
 }
 
 void x25_unregister_sysctl(void)
