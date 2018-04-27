Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837917-2-10323721895711735049
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
    1524837916; b=RQKxNS2/HGgMEX4fY9Hrh6UaGcjQ9S9t3iSKQYeLGr8OUB2QIq
    Kfv0zwYGx8BuPRWQogsZKXR/ue64DBqqbxbc1ErufdQvjOenPkBH3wE0vAw89fXA
    DE7TcOVDbI2cuOqWFAOYlKbQSd3QHhpckj2wvN7nEXtpliWFnT5k9D6PQ7UkVH25
    TsuiuYTYfWqYv47F7YWbm2Xo3Tz3hLPEgM1FASKCncC67s9FogZVeAIElSKyL6gs
    brXrv4g/Jha7CXu75Ia2xm206rrJaIaRqTRIIeIstplpUR0MPVrM7kRtWK5FcGeW
    oJtahbLgq+Aze1/CstmHvCJb+s0PnhGZ0BPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524837916; bh=cZVk5vjlxCyGbJGfnPv+8KPxH26a6g
    Ejb1swRKqBs0Q=; b=My4CTgp9BZV9J/WzLStHPRMEQnrQVG/HeC3NZAdUgmCjG2
    5+N12MTD3r5subk8QmB/R9R6Sm1HZjg7WowecRp7xtUWjUiUL0bgfydqO5tS1V0K
    MkSgh1CrXwNqFTMElpb7+ajiQvN78Ji9Rvh82iB1wDfMoV+INs2HkoTw5qQ8bZi/
    iVruEQKRO5SKJTUHUrsBMTu5T9GY+xKnMngdN031M0/uD1esyicJfnOGVAsIrp9S
    2c7tJUFNx5c83CgVS2ZmhAWi5vSsUjAWCe5B7ye9n/q822/X7izy4egOlTm1Z+x7
    x2BazXh1x8ZDBNp4KefWzarVmc3T7pZh0LD0zrlQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBvYCXc9H3rLkxtV4PwtUsNH0EOqymfBvZZpSDTQfe0lkB/oNIiqPZ2+o0D10449UzKxjJfwE4d3iQOPhPDDMKxXcx0kG1pT5+43lY8qX45RwR+7TOIK
    whGvDKRBsjHoLYtGXx9B8HrFDtmK9eDJiweQPDWgA0xAVnxRpHT8HiRgnwfwPJ8oo+VmNUcFYC1oF04o2JDe3+2iDLNx+a8vdrOGeTspnxVmOHngO84ZE8B+
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=XmO6cA-4smvw7guTX_MA:9 a=oOMRao5BX3fnqIUg:21 a=XsbJh9U6bPW528YC:21
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeD0OFH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933222AbeD0OFF (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:05:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E27921890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 62/74] llc: fix NULL pointer deref for SOCK_ZAPPED
Date: Fri, 27 Apr 2018 15:58:52 +0200
Message-Id: <20180427135712.507232228@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>


[ Upstream commit 3a04ce7130a7e5dad4e78d45d50313747f8c830f ]

For SOCK_ZAPPED socket, we don't need to care about llc->sap,
so we should just skip these refcount functions in this case.

Fixes: f7e43672683b ("llc: hold llc_sap before release_sock()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -187,7 +187,6 @@ static int llc_ui_release(struct socket
 {
 	struct sock *sk = sock->sk;
 	struct llc_sock *llc;
-	struct llc_sap *sap;
 
 	if (unlikely(sk == NULL))
 		goto out;
@@ -198,15 +197,19 @@ static int llc_ui_release(struct socket
 		llc->laddr.lsap, llc->daddr.lsap);
 	if (!llc_send_disc(sk))
 		llc_ui_wait_for_disc(sk, sk->sk_rcvtimeo);
-	sap = llc->sap;
-	/* Hold this for release_sock(), so that llc_backlog_rcv() could still
-	 * use it.
-	 */
-	llc_sap_hold(sap);
-	if (!sock_flag(sk, SOCK_ZAPPED))
+	if (!sock_flag(sk, SOCK_ZAPPED)) {
+		struct llc_sap *sap = llc->sap;
+
+		/* Hold this for release_sock(), so that llc_backlog_rcv()
+		 * could still use it.
+		 */
+		llc_sap_hold(sap);
 		llc_sap_remove_socket(llc->sap, sk);
-	release_sock(sk);
-	llc_sap_put(sap);
+		release_sock(sk);
+		llc_sap_put(sap);
+	} else {
+		release_sock(sk);
+	}
 	if (llc->dev)
 		dev_put(llc->dev);
 	sock_put(sk);
