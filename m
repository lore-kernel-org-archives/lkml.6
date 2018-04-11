Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523473974-2-4881816959241787415
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
    1523473973; b=X79SM67fYSbyPzmuHdcXH61fF1Z0dPnp1FtLzqHIyb7C3xFFXB
    PH0ZJNabAUGWVzFoCW7mXdKk3iKVqjg0fmAvKumJRvmWdpbkvPX1bGOODX4NM5Fe
    NPTbbdfr1O1OKGMWmRlci1ZBNgxdD2gno00J0j5aVCqhysKYAEr6s92lzRRbxv2J
    e5Ee9GNVN/PfRb2CO1zOVvftB5j95TB3cfr0DQiEibok/qY48i60KO62zTmCS8ol
    1XDXZ/h2p1eFDhHgo9l1las9hDhDNgbMXJvAo11SbCPGf/S+7I+SFaZ1Ye6IXQ9a
    Obd4SXrxmQnvPAJ4HDUEo4JzYMUDXsFKG7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473973; bh=O5knnmJ4/EB28KQtd2qdwDGEf7YTHd
    JGTO4WTix3++s=; b=WNeuXJk2T+yXZN9yDRCkodQxTxU9cRgXeAZrMTInPL/B/n
    CmzZEKLZVYt+DWhjqzs3f4zuig8j2aOqW/sBtlFjer1TtQujBNtlcXwSwO+UyJ72
    /PfNQBCxb7SEjqjgMLOd+tRnxooiuNzesnwOAYPdOW6xldrz1ovIdPn2G9fuXIKd
    XMR+M3FUaGtC1mOhY3/VHP5mTnYtPpZZjiUazqBEEQu4JK8XK43tzdIlCukZQ9fy
    IONQEUBV8sVCd8ibhRwM8P1ReKGTDx9uRLG/kppXSKI+EdS9Z2PSlIF0EqOLnJx0
    Xi5Ij0b9qJ1akeDPch7rQmKW9thORv+jjd+9vE/A==
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
X-CM-Envelope: MS4wfOfWbWdxZI+8Tu1SHOKbDa0Rh0cacPY1X1VzWQABzC2GbluezWjDDN4oQPl6K6r6nh3iO5elsQHSWEpg+mfI1pLwrfR+xZSkQLrbb2YYAUER9j86vnFI
    yq5IZqDT4d5FLUn6jY03ZlFnWP/W5IjMsJp3xVCnc5WG8Pm4nAwXLjng+Fvx0tgjuwVPemUTUeX8dKGYaKUOPwy0MmGeGlmp28yT8rSzZGku0sr9IOVrtC2e
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=fhxPrRCVwfts-jpH_esA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbeDKTMh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:12:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40690 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935146AbeDKTGG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:06:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 295/310] ipv6: sit: better validate user provided tunnel names
Date: Wed, 11 Apr 2018 20:37:14 +0200
Message-Id: <20180411183635.276682264@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit b95211e066fc3494b7c115060b2297b4ba21f025 ]

Use dev_valid_name() to make sure user does not provide illegal
device name.

syzbot caught the following bug :

BUG: KASAN: stack-out-of-bounds in strlcpy include/linux/string.h:300 [inline]
BUG: KASAN: stack-out-of-bounds in ipip6_tunnel_locate+0x63b/0xaa0 net/ipv6/sit.c:254
Write of size 33 at addr ffff8801b64076d8 by task syzkaller932654/4453

CPU: 0 PID: 4453 Comm: syzkaller932654 Not tainted 4.16.0+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x1b9/0x29f lib/dump_stack.c:53
 print_address_description+0x6c/0x20b mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report.cold.7+0xac/0x2f5 mm/kasan/report.c:412
 check_memory_region_inline mm/kasan/kasan.c:260 [inline]
 check_memory_region+0x13e/0x1b0 mm/kasan/kasan.c:267
 memcpy+0x37/0x50 mm/kasan/kasan.c:303
 strlcpy include/linux/string.h:300 [inline]
 ipip6_tunnel_locate+0x63b/0xaa0 net/ipv6/sit.c:254
 ipip6_tunnel_ioctl+0xe71/0x241b net/ipv6/sit.c:1221
 dev_ifsioc+0x43e/0xb90 net/core/dev_ioctl.c:334
 dev_ioctl+0x69a/0xcc0 net/core/dev_ioctl.c:525
 sock_ioctl+0x47e/0x680 net/socket.c:1015
 vfs_ioctl fs/ioctl.c:46 [inline]
 file_ioctl fs/ioctl.c:500 [inline]
 do_vfs_ioctl+0x1cf/0x1650 fs/ioctl.c:684
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:701
 SYSC_ioctl fs/ioctl.c:708 [inline]
 SyS_ioctl+0x24/0x30 fs/ioctl.c:706
 do_syscall_64+0x29e/0x9d0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x42/0xb7

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -244,11 +244,13 @@ static struct ip_tunnel *ipip6_tunnel_lo
 	if (!create)
 		goto failed;
 
-	if (parms->name[0])
+	if (parms->name[0]) {
+		if (!dev_valid_name(parms->name))
+			goto failed;
 		strlcpy(name, parms->name, IFNAMSIZ);
-	else
+	} else {
 		strcpy(name, "sit%d");
-
+	}
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ipip6_tunnel_setup);
 	if (!dev)
