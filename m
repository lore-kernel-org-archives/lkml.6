Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164570-2-6196099247156430261
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
    1527164569; b=KNU3iuNI7xQGnf3GTHbwaAnzdm5/mcAVuVW6/cJ8CNNiqTi36b
    ddEc/gHDLeIORL0SdUBLHUE06gJSqgVOXPxIrkoIIpuRJ4xTHM/vtZbwHnejzCnY
    5tdfwHcT48TBYPz2/Lsc0POh4HzRbKvMQK5kNiPQ+dvacvnkCDTNM6sZLU4aN4Vh
    QK/in7S5tvzmC632pqAy8zp7//wKG/lJmvHxtgv1HSQPxKVj4TX6a0TiLV3u9Vpz
    p2HQkOg1oj2Vg6vAEVuZ7pK0X1AZxV5KRSGVW27Jh1e1LUX4M92be6Mdn1ZFSVPO
    MuF/awFJLjAgsjxiI2SbzE+w7hrt6NX9EA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164569; bh=1E92izhlUyYce+jmo38t88o3AnF9Go
    jg9980ow33g+c=; b=HgQ3sRjVq/MZE3VEiAtwz8vc1Q4L6e10iZdT3F3FGyG999
    9BsU9QhWG5exphTjbLvlhwpkItLQbKBm4D2uIF9K9pvmi5kdjKd5oy+03kS4Nvj+
    MouaEq5i0KgCdrGIaifsJBy0wZAct/bc5HYe+M3sqr8kAiuSeQZX6Dqmu6LU7+zc
    O4q3IL3QXmoeAfNi5npuFwEqi+vfObzWZSxa88i5kU/b020N5pHIxh0abUp1D1EW
    2iWL1P3LMmzSP58fvEKqotXTupIOnlRKoT99HUuNAjYH6DMzEfdXCgl9AjxDW8Rc
    Kz8RX60IcMMm1ZCzkRWscu7RAPwtPzF8dFCfmsyg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FtZJw1bX x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FtZJw1bX x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPfcpFUg5lVUH75FMHF5xW+ddeXdMDPUyp50jR56CcRaRHIN83r3kjU+p0xcC8WcTSDhp7LInYjXLburCu51hllwgzaI+4oMI5gpjuL9Xi0lUFqycFxe
    C76bBDGulbuDFp6BNQi6sG4/UOYA3WvkSJXjhTYwlNgkT8L8IQOIFo3EdTkz3sC08zXelsMemg7ojTAuII2dSyTwqUiHTKpdyyzoW2wh9qzDCe/CynrZ1hNL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=2wpadlajvgCyii3yq2kA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966143AbeEXMWa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966131AbeEXJlB (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 14/45] tcp: ignore Fast Open on repair mode
Date: Thu, 24 May 2018 11:38:22 +0200
Message-Id: <20180524093122.253202366@linuxfoundation.org>
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

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit 16ae6aa1705299789f71fdea59bfb119c1fbd9c0 ]

The TCP repair sequence of operation is to first set the socket in
repair mode, then inject the TCP stats into the socket with repair
socket options, then call connect() to re-activate the socket. The
connect syscall simply returns and set state to ESTABLISHED
mode. As a result Fast Open is meaningless for TCP repair.

However allowing sendto() system call with MSG_FASTOPEN flag half-way
during the repair operation could unexpectedly cause data to be
sent, before the operation finishes changing the internal TCP stats
(e.g. MSS).  This in turn triggers TCP warnings on inconsistent
packet accounting.

The fix is to simply disallow Fast Open operation once the socket
is in the repair mode.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1105,7 +1105,7 @@ int tcp_sendmsg(struct kiocb *iocb, stru
 	lock_sock(sk);
 
 	flags = msg->msg_flags;
-	if (flags & MSG_FASTOPEN) {
+	if ((flags & MSG_FASTOPEN) && !tp->repair) {
 		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size);
 		if (err == -EINPROGRESS && copied_syn > 0)
 			goto out;
