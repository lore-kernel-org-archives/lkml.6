Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807177-1523400248-2-15648597314768995780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400248; b=SxtjYVHTLVSImOa//MW4EOW1ur05zv2uN6iB7oj28yRhY3KUNe
    9q+CNj66oVWILE65M2fQru7BeRUBDgCDSmoaIh84UCt+H7ZbNNf02SqqFSTvv1VU
    goMY9D3p5dgR5FLHg5ygu6K75BdDX2DYdsy6Ye3PFjIJk/jl8QN5+zsMPdTP1V0A
    q/m2csgdrC5C415VIIis4c+ETng0gTwQUnovsIocCM6NPF0Wn0WvVwU9eK9x8BsJ
    QiBbffNZFIZC/X1engUI/FDz1egSt3dRjOl/jFA0ZBNc9Kw96XcpuuRyw8LJVKNW
    IOMhfdFwmFZ1BUOm7FhfuKCjG7Immd0D+3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400248; bh=9DAOJSPWw1lBRNn7lN+qtNjcY5Pa/M
    XucXz0VitE28g=; b=iYq7KNU8TuFcErTygnjIR2koqMkrdS1MxfeJIU61QgiHF+
    6KNuMcHMa/LW8jZ4V08fkOrus8oZcwjyagw9WNL5Hhx1xlYZPCKC+KQwtLb7adof
    2oXK4s4GyOV7LAJFzXW02oUNHIT1voXnJ7OwJk/b+SItoY7VsczGqG/iSSnWqP2z
    PbmSWKfutLQK+FCmU6z2T9Culdftra7DJ37WSBy4Oq6mWckbJOqjs+o+4c2gzxPX
    nPsKiuHsAzyO9UOUoEZQeA4Deb/wrqY0+k6mVTZ8aLnykQj8EHdrAjZdhW4tL4Yl
    dZo/w6EeHneKx/4tpoCUDf9RST9mwOHq2RgfLBvA==
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
X-CM-Envelope: MS4wfGLYM3Fgxw+NblWuPYdDVQK38qqHuDu/AxlXVATdEGLFH4EVbxgDoKd7Bh9dCwOMxceW73pycw8yg3IqXILXE3BI/NV40xx+Y3L32uisuUsAeUX2T0xG
    3vFwKRTxcthJRkWqQfRmRvVijOys/rsLrhVuGyxR9TT24TiDO9GvL2iUqL0+b959y5DUTY0mWWpLnYnPyku6Npr6RvLuaVQuYRCkoqHYqf8LdBni4K9ATD5P
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=vmLDa1wCAAAA:8 a=4RBUngkUAAAA:8
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=vFSZ3zM42u_8h33ZmkgA:9
    a=Yi6rcVn594lHFDS6:21 a=KKgrvbZCQR5esraY:21 a=QEXdDO2ut3YA:10
    a=h8Bt5HTj68qkN2fS7gvA:22 a=_sbA2Q-Kp09kWB8D3iXc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932621AbeDJWjb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:39:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbeDJWj2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:39:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 109/138] sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6
Date: Wed, 11 Apr 2018 00:24:59 +0200
Message-Id: <20180410212914.851493093@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 81e98370293afcb58340ce8bd71af7b97f925c26 ]

Check must happen before call to ipv6_addr_v4mapped()

syzbot report was :

BUG: KMSAN: uninit-value in sctp_sockaddr_af net/sctp/socket.c:359 [inline]
BUG: KMSAN: uninit-value in sctp_do_bind+0x60f/0xdc0 net/sctp/socket.c:384
CPU: 0 PID: 3576 Comm: syzkaller968804 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 sctp_sockaddr_af net/sctp/socket.c:359 [inline]
 sctp_do_bind+0x60f/0xdc0 net/sctp/socket.c:384
 sctp_bind+0x149/0x190 net/sctp/socket.c:332
 inet6_bind+0x1fd/0x1820 net/ipv6/af_inet6.c:293
 SYSC_bind+0x3f2/0x4b0 net/socket.c:1474
 SyS_bind+0x54/0x80 net/socket.c:1460
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43fd49
RSP: 002b:00007ffe99df3d28 EFLAGS: 00000213 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fd49
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401670
R13: 0000000000401700 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----address@SYSC_bind
Variable was created at:
 SYSC_bind+0x6f/0x4b0 net/socket.c:1461
 SyS_bind+0x54/0x80 net/socket.c:1460

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -337,11 +337,14 @@ static struct sctp_af *sctp_sockaddr_af(
 	if (!opt->pf->af_supported(addr->sa.sa_family, opt))
 		return NULL;
 
-	/* V4 mapped address are really of AF_INET family */
-	if (addr->sa.sa_family == AF_INET6 &&
-	    ipv6_addr_v4mapped(&addr->v6.sin6_addr) &&
-	    !opt->pf->af_supported(AF_INET, opt))
-		return NULL;
+	if (addr->sa.sa_family == AF_INET6) {
+		if (len < SIN6_LEN_RFC2133)
+			return NULL;
+		/* V4 mapped address are really of AF_INET family */
+		if (ipv6_addr_v4mapped(&addr->v6.sin6_addr) &&
+		    !opt->pf->af_supported(AF_INET, opt))
+			return NULL;
+	}
 
 	/* If we get this far, af is valid. */
 	af = sctp_get_af_specific(addr->sa.sa_family);
