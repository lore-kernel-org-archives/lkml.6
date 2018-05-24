Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163476-2-14483809998834738760
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
    1527163475; b=dMGprTJZIkBE+exHxWAV41V8C+uWbxkwLbgsN4TlQ85c0D+gai
    2sdg+I6RWkt+9NjDhwYGXguI50KChDk/UtV61IRIjhtuc7cMdjs8goJzchDhiqLk
    ATzvRxw/0R6JvtNSy68kUjHDFjKPOcZLtxTC4aKe7CKEJLMKQ7a1ruqyWgVXEDLS
    iLBGvhBT/Hns+WYuCS2KjdzoMy1+LTwCrMwYZSfV+Mk7rB+HVeEEDUtINzUj1eay
    5ATm3nXOeaXdvbZkmqFwBoyWDfJcCp2JJRvVanW0f2Ky9r21xHoWAY5kvRwtet1k
    gHLyr64bKnx1SlM9zf5jI3TC9MWt+PpP2RcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163475; bh=2c4n0uy9eYPE3eQTAbzsuGo3jCL8hG
    2MJJYu6dtSNGY=; b=nhf9kINSXMoI3b6tE5DviWhdn08lySQBrVQ3pB7Re1NvrK
    1UvaolrAozIKCmbJQ42XLZHtqEdgbmxcfLna/bm+o04qJQU+T7Wyg53q8CfGbawt
    KkYthdfYWefbmV6v7VPL6GbsSQiq+5/bCWmR5FlHZG1xIUcZAJD59kKpueG31x41
    H05B9KlbyTV4JFDYsxt1dhiOnDje5nW66hCYEq6DaAoBD2PplP0tP0kM1gt5OHHF
    teNZTuIV9bYkeQL7Kzh4MVjV8Irx4SMvSbSwbM/a8ptDuWntwe96kXRIRFbx6TMh
    eIpOyKcW+3pngemWoiko6plyl/kERakZLku7BpFQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=o/sQC6/Y x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=o/sQC6/Y x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLbxWi+n6iAGxMVsorAISI+1MvNyrl9XpbXXx3ma6c9l424hsQhm2YgQAL+Xy9DtnjZUv5MULOEhkni4HIzetzss95qQ9MQF+HHzccOvTShPWBIFXA/8
    +kNpWsd/S1WhT2Qzfax5+XFp92La0CRCm7PFqMCR75YVywpZsQi79zhk7Q24Yi0+GA2KiWhCDvhHk1CF8G85k8cYiLn3YoxHjEaFDm57S80TaJ8Hf98ZA1VZ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=vmLDa1wCAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=qIXTWH9aknbkPzANo3gA:9 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=h8Bt5HTj68qkN2fS7gvA:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966276AbeEXMDB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966394AbeEXJok (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 13/92] sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
Date: Thu, 24 May 2018 11:37:50 +0200
Message-Id: <20180524093200.452022191@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit d625329b06e46bd20baf9ee40847d11982569204 ]

Since sctp ipv6 socket also supports v4 addrs, it's possible to
compare two v4 addrs in pf v6 .cmp_addr, sctp_inet6_cmp_addr.

However after Commit 1071ec9d453a ("sctp: do not check port in
sctp_inet6_cmp_addr"), it no longer calls af1->cmp_addr, which
in this case is sctp_v4_cmp_addr, but calls __sctp_v6_cmp_addr
where it handles them as two v6 addrs. It would cause a out of
bounds crash.

syzbot found this crash when trying to bind two v4 addrs to a
v6 socket.

This patch fixes it by adding the process for two v4 addrs in
sctp_inet6_cmp_addr.

Fixes: 1071ec9d453a ("sctp: do not check port in sctp_inet6_cmp_addr")
Reported-by: syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -863,6 +863,9 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
+	if (addr1->sa.sa_family == AF_INET && addr2->sa.sa_family == AF_INET)
+		return addr1->v4.sin_addr.s_addr == addr2->v4.sin_addr.s_addr;
+
 	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
