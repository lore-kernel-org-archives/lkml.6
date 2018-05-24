Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527154988-2-3651326879201847263
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
    1527154988; b=ZmEmXiqeb49bQXfzE2hncFLYqqP7CRnqb+DgBfe1gnmOs44yl0
    EdoaxShh1ecap0sVP3rKEYfK5uEVYkFQqm07tLv+rqmOe0IU28rFTKfZ3Vp3sKNX
    CvjAMNMHtQT5+vlGOIG8oStHnzyZtovgdjTsVw2oWdMhQAdA6V49tfKN3mI0p6Ge
    V/Y8AjWtBx0RaEiReYjoPicv8cSERdP5TfIKQJYUBf/f5DjZYd3zRkRIYDYa5USW
    l2nrStjc4uLUnLLlnIVi/NcP5zCkF0qLL6C3vpZ1Iqqoc3+xUf5WKS/utpaDF6eL
    7kh7jy2RlN9Tp8VD+FfcYb/llIvNiF6H2koQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154988; bh=lRHngEF289VHYGQBWUctdq1Vl4CKzk
    vKksclNvCjlqg=; b=BPY1IY/77wvewUiHxwialrCw8d+zSVlt5zBkGFxGK6KjB4
    65DX/RTAdpwJq5pDSd6j6+ecuJVcC0Au79nNGeGu/LrqhOEO7bAUOuikCcOAgjNx
    W/yIYvOE0701qn0o29kOlOTB7YUM4Wd/CCzTzMal2PP1ehKMRor9SxjZMWIyU/r2
    5gRu1JFtTEcQ+NFNBMyqgEO46rU4n6F1UHUyLv6SqHGjvFwh8ayqMR2pY4nUJ5HA
    pbYoqBpjzn53p9Pcj5x72sZuIeq7ewU7q0wwurY8zHs4AxJT8MnhPdRZ2lDjrimp
    il8d1cI6QvXLnF1J8mm/T0pFme/pnr8v6XPS4QEA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sQavlRHJ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sQavlRHJ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHS03IItV+tfhrZmqTdGOOCV5PoNQeiFvJTrEIGV85BHsL+l94EB09+TeVVUg8zymzmLV1kRkITu+azwOQR2TRhfgQM1ixvEL/Idre8egbnk38/w7o+N
    hn8oVfrV64IsPhrhGICDGBuLrhCfJ+B1QNb1ZKgQ/BpL7ybhZDmtqWt5GB5AfIQce1Mq8SlWqezs0v/cYM7mzv5o+A1vYV2s+HkeVR18Z2vNG9HG6POAq3JO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=FOH2dFAWAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=0ho8uy10ve2BAXLJD4AA:9
    a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966428AbeEXJnF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965972AbeEXJnB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 04/92] ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg
Date: Thu, 24 May 2018 11:37:41 +0200
Message-Id: <20180524093159.669935648@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
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
@@ -777,8 +777,10 @@ static int ping_v4_sendmsg(struct sock *
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
@@ -843,6 +845,7 @@ back_from_confirm:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err) {
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -991,8 +991,10 @@ int udp_sendmsg(struct sock *sk, struct
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
@@ -1105,6 +1107,7 @@ do_append_data:
 
 out:
 	ip_rt_put(rt);
+out_free:
 	if (free)
 		kfree(ipc.opt);
 	if (!err)
