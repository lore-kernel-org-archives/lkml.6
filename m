Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164515-2-8635595018837335762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164515; b=MLwzqpE9xjiO4Z1RNkMJbtjTp4aBaa8xQyXBxp4nlV3dbT1xrc
    SC3e/1ph1HVGgki5E0IqpILCfnF4CxYNeFWWSflqPXmJlQzWpa531cHXovYXvL7k
    M3LsKRftD05cmYjR2GTti9qmjoSQDNGzqc+3FrFdkTs8vqGYFdbilEGMHp5fGi5O
    hM1S9b4kK/uDaQfA8HBnfQr9fcYTRhh5gzshnHwS1bQ/VgF5JD2uh8yp6Upxrn4d
    onZkVldGFGuwuQerkEVuiSp6D+p2n5yYGTJw8lODzXiyfa8SnVIM/td2zPA39AVO
    ISP9tZX6NBdqhQ4OehpA0DRtaDDy2m6vXYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164515; bh=KVfzl73amKq+DsvpOUDxknSbBhGEFC
    dEKfHJdDXN+9g=; b=ar5yUJ90mULxXk6MXp5iNAUz00kCCLw5CV5lHPFNYPl1kX
    7/lm/hqynoMxTalzprL2MQ4I7XobeTauJCbkIH8n/A0dStAna0UQTmgm6kSMS9dE
    eujTzHofwdLvV/NvSfiQEQeFjz8Lfca88XJd4OUq+ZbAjCS8Un2jqoMgH/tcPQj+
    bDNPVnmUgyvUIADEerkgWWx0eQDMIklNCLjfm013QAEZEIDqb8QVUYAmmfp1vg+/
    m5zqsCHCvRVhEnAKguzA2sOZAHnxdl71AEhDPiaZe7lA/BdzoFjiOujDy6o7mVrD
    LUNTxj0wkBj7M40o846uM5js7bNX95h7/nTllhXg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HmilEjV6 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HmilEjV6 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ4aEQYJ+N6MMA4640ZiwXdvNtJU+W1q7BM0ITFaqK0VFQ7idYYCXavCoe0j2DkmwT2mZzGubVSN5/UaypMuqAbpnyvKdnfr8Eenk01MQeoMN4mqsjn6
    Tu0zVYBx2T20++vzR72eSitadc0XXXtWZ+xzpJFY/LImiXRHHS+zWcKNMA4L7LOHtx9LbKpLHeq4Ljs7qELY2baS9kdj/l06y3aBiK5yYAhE+I+Y+xj9jX4e
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=0ho8uy10ve2BAXLJD4AA:9
    a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966227AbeEXMVY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965759AbeEXJlO (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 04/45] ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg
Date: Thu, 24 May 2018 11:38:12 +0200
Message-Id: <20180524093121.103500882@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Ignatov <rdna@fb.com>

[ Upstream commit 1b97013bfb11d66f041de691de6f0fec748ce016 ]

Fix more memory leaks in ip_cmsg_send() callers. Part of them were fixed
earlier in 919483096bfe.

* udp_sendmsg one was there since the beginning when linux sources were
  first added to git;
* ping_v4_sendmsg one was copy/pasted in c319b4d76b9e.

Whenever return happens in udp_sendmsg() or ping_v4_sendmsg() IP options
have to be freed if they were allocated previously.

Add label so that future callers (if any) can use it instead of kfree()
before return that is easy to forget.

Fixes: c319b4d76b9e (net: ipv4: add IPPROTO_ICMP socket kind)
Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ping.c |    7 +++++--
 net/ipv4/udp.c  |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -771,8 +771,10 @@ static int ping_v4_sendmsg(struct kiocb
 	ipc.addr = faddr = daddr;
 
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
 		faddr = ipc.opt->opt.faddr;
 	}
 	tos = get_rttos(&ipc, inet);
@@ -837,6 +839,7 @@ back_from_confirm:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err) {
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -975,8 +975,10 @@ int udp_sendmsg(struct kiocb *iocb, stru
 	ipc.addr = faddr = daddr;
 
 	if (ipc.opt && ipc.opt->opt.srr) {
-		if (!daddr)
-			return -EINVAL;
+		if (!daddr) {
+			err = -EINVAL;
+			goto out_free;
+		}
 		faddr = ipc.opt->opt.faddr;
 		connected = 0;
 	}
@@ -1081,6 +1083,7 @@ do_append_data:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err)
