Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022118-2-14706242041947346744
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022118; b=mqzjwys5O4uyTqry7BCpYNhDok1O5oLH+nK5zg9gWGRJ3MoW2X
    XnnLk3QWeuIXo9hp1MSKDh5ifqZS4V/GxACFYJtQkeSxbFZe2RXBPMwNAGV122Y9
    NPj4ADHL+nSHC3PBD/74DPKo8+xrEICeIVIKeUUlzEUlwsWCGJMb0pil98ME5V/I
    6kgk/YkudMo0X62pJ1/lpIMi/43VfiOsKFRnKeRWd8lY60oCnaUOMJw9w9aIcdD6
    HGEUB7qhskwiN05YVV3oyprxWQJFiH2rAqEZu2+dJWLyBvdnDTcI5kZvSzpAQdbX
    C+9HzpSNfY1xNWmPk/nqLQdwWFkB8uQGSpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022118; bh=lyAPvxR/qzwek4OdU/ygvEyt50S27r
    5zJTsAxJlF5XA=; b=OPZp1BlJC4lLyPPHlDW0qeoMZeVDJ5jhTWLdcVoxEcHsZx
    3+/KOvWNzpMCJJwtf6Pvv+rQ7g46x7MpkR0znM78bRY/Cdph1aBZSEwbTt5EHbJm
    Yx78u9UkttiC2nvGf7GnZqyeMMq3n3wOv9QiGykVFrNeVSPJppfbz60Zt8/BaWuC
    H68ld+LBl3YymlvoyrZTweN0B4s5R0T+FErkunVc43GTmz8xtB9DLeNYTBZpOf9b
    BDsnH1dkXRZ8h1EIevfFvjhsl714V+aSqfdwepX4LK1Playz0XruiCdIPyVfipaM
    wFWiPKzgaEVc/JVrqgCkdJ45/vqLEqORPVdJH9lw==
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
X-CM-Envelope: MS4wfHaypNE9ucTkjmnjkHwPnOrj1ADfOR14ZL56BlAJnoie3yb2N9tpVIdzeTyQrsWMB0BG2Q/E3SQVxQXPvKBYkdNl61BU/si9nVPJwg5BZHZYOpIvk1gG
    78VlaXCkDCULMOT80LH50SORTvsDQYVDK4Gjj4++IBjUP5hZSRQRYHmUL8cxMJBRPYtKMoazi5Desam8tJLkE0d0zayWZi/Wp0mknpcyJym0YPxO1rlm060K
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7ZN4cI0QAAAA:8 a=hSkVLCK3AAAA:8 a=ag1SF4gXAAAA:8 a=1WA7wDV_nH3orW2v68gA:9
    a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22 a=cQPPKAXgyycSBL8etih5:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756392AbeDFNly (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:41:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756461AbeDFNlr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:41:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.15 30/72] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
Date: Fri,  6 Apr 2018 15:24:05 +0200
Message-Id: <20180406084351.843360642@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

commit 19d7df69fdb2636856dc8919de72fc1bf8f79598 upstream.

We don't have a compat layer for xfrm, so userspace and kernel
structures have different sizes in this case. This results in
a broken configuration, so refuse to configure socket policies
when trying to insert from 32 bit userspace as we do it already
with policies inserted via netlink.

Reported-and-tested-by: syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2056,6 +2056,11 @@ int xfrm_user_policy(struct sock *sk, in
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return -EOPNOTSUPP;
+#endif
+
 	if (!optval && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
