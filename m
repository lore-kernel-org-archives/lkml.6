Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280832-2-12429604828582773745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280831; b=kW5EFWpCvY0M6WeSc1n3XsmfNe1sFA01oJ5X59dbAxYoW+yfdO
    QW2FesqLO/w8C4N1eLzS8+8pmiYmczh+qS8A3kq3MtXKrLuxGzpoZWlAYqrtapmN
    8OwGBU9m1sNYUEBOfEfqIngfSA5Suk6Ou6K8kgTQtSFIR1isjQfPJD6rZcSl7N8m
    Mk71qgXz/YFLWFBoTkVneDaNmjEVEn7Kli04IWuhTzwe2vI9ih4AhvsEfox7IWK+
    +UWv6wAndcObdZuINvPbboJIzw0l1y+6FkrVpejwyhtHKEjyPmNfUDZ0UjRnlnDO
    QXf2UjEU6hoBjAStzU5IbntyyAY+AhDt1+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526280831; bh=GzQSLTeI9ZWpm6Bjxp8yA8n1nbzhMf
    m3KMo7QrrJMwI=; b=e0VAw3JpDt/NM9N5twzNLevQ//Jfgp18rLcwxnbBqN74KF
    GAyslymY7JySnLrAcrPxk1ZQxjG3IZhb/qM0nhz2hjdfFSG/wh5VhDN8YljiNRV0
    Oe5LKYY9MaZhJQ/FSJHnaV8aeopsjflXclP3e1AHH4IGA6CgsqccgNPJUuUCF2Nu
    0dwFDqHC0XmtKdL7hk9SXGcDbMFir8TP0SapROt3ryFfudMZ8aIt4iKBGnuSJGcb
    cvuSV0FWxBzWwU7uVXFSs2L2ozj9W7r9k7kk5roLCfrZPL5o9hWGoe33jHemBz0Y
    4V+grRgU3VHXCYAfeP1OGyFEuxWpgRDnjwHjyGnA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MSGbRNtN x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=MSGbRNtN x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKjYfjhaY0L6puAvHxQYQrFQglMK4SCGPDGLIq2ce2ngNSUkd/8geEXfQoBHzCTc9vd6eTU8eKtzSllVNHR+V63hf+eWevS9xuSZYQ56lhhpOsnnpkiG
    WBKp1ibVRVtar4eVF09DGc+Fvt+YPAFU5vKQtw7h1WOS+zH/3nRubW6CgaRmFt/QGFaFu/wwGht4uvKNMHA0U/DcYoTmwy53z0EzfkVLUkHG6VvreIWJUCGw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=-XdVNQPLK4woCof97h0A:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeENGxr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752903AbeENGxp (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:53:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 05/36] netlink: fix uninit-value in netlink_sendmsg
Date: Mon, 14 May 2018 08:48:39 +0200
Message-Id: <20180514064804.662038663@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit 6091f09c2f79730d895149bcfe3d66140288cd0e upstream.

syzbot reported :

BUG: KMSAN: uninit-value in ffs arch/x86/include/asm/bitops.h:432 [inline]
BUG: KMSAN: uninit-value in netlink_sendmsg+0xb26/0x1310 net/netlink/af_netlink.c:1851

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netlink/af_netlink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1795,6 +1795,8 @@ static int netlink_sendmsg(struct socket
 
 	if (msg->msg_namelen) {
 		err = -EINVAL;
+		if (msg->msg_namelen < sizeof(struct sockaddr_nl))
+			goto out;
 		if (addr->nl_family != AF_NETLINK)
 			goto out;
 		dst_portid = addr->nl_pid;
