Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021909-2-4843050099617164270
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
    1523021909; b=KybdUW9sioKu6+kNaeGK6Q7SoJmbpNUhAtEXhWbGaxZnYIeEki
    uzAm4AIPpPOF/9T3lBunPTkNqkVv/4T+HeHXg6Qaw+kB8jGWrug+VvN4Np1hfEje
    pm2o+RX9X3IeviLU39cCG6AncqKLrIaFxOT6WIUm6WKfwrY5wg3OqYvpUtoY8OAJ
    FVeM3haY2Ix6N9IGLFru8UiQiyGLq3cJlriVSASFb980hA5KB02NySoxEnD2cAlT
    GmJy70kejBqNlxnjsCWP0K4x050o4ZWDjZBu3SyhOe508sQjNwQzzh97AYiTgbSf
    ReXSxy5ArA6hxe68XXT5zfpl87RWi1WAHHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021909; bh=AWgawokpVpjLXUrXwn7aU/0CIEz3VH
    eHb75ilvyFlwg=; b=agyPjFtLhj4VJZExsr00/H+Hn2pFYSPISiOOQ8UY+ghZE4
    pTSb0Y34irJ5h1/ravNy8E5pKhVMjtskZ/EU7SALK1iFfipLBpAJAl/SntfE0Svx
    Fpt2S1NVCw7wTx4e5Dqj5cGmjaYecKWJOge50ae5qDSJGA/QIXTPYw6PAC1ji83c
    AdlG8g1jmFc7mHBAPuyX1PZ8YCuOcOQ1rX0Akl+W6zAxFp4frlER6zeM7w2Z8c3G
    447bTDHE5FZrqtz9KEuUCTlekx7TO6Fji4TofpKagz+Wnpxy5pU1nGgu5iozAqOj
    e69DTmHi1uM7Zt0Kui5j67bgfMPP7s4y49r1h3jg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfOj0dKXXmNCYTlj297Z6vWn7ghclA+YSs67IiJo63/PyNJWnf8AylxB1VKTyNQTFtEJDhC3bKhwxDjIytXtBfMANwJ4jSpQCmhyzfaX2XiY/Mj0Y088a
    zbr+BtXeBXghFo3Hp7DZC9h8SQSeqhJ8HX0wQ/LDD7RQvkK3PXL5DEP/+fuOCQJWUp8G/EfTXEV/QlwSJXfVHEXC4XK3WWokvrsPC1qXFskEJ9zp1v7/xOuD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7ZN4cI0QAAAA:8 a=hSkVLCK3AAAA:8 a=ag1SF4gXAAAA:8 a=1WA7wDV_nH3orW2v68gA:9
    a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22 a=cQPPKAXgyycSBL8etih5:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeDFNiZ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:38:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33314 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeDFNiW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:38:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.14 27/67] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
Date: Fri,  6 Apr 2018 15:23:57 +0200
Message-Id: <20180406084344.948813357@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
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
@@ -2050,6 +2050,11 @@ int xfrm_user_policy(struct sock *sk, in
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
