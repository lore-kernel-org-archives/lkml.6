Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414787-2-4056587931193373534
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414786; b=e6JtGgSmqQFcnr4BaMhsjrMRz37DJMuH+jZ48gMVoSt6AfA
    On3g5H2AifPbU3vfDp5bKDzKzrTT8QPXZpaiwCp1navJ2A4/36psGZ55Z7vGbKxk
    l8In+C3TXkxmRgqAUfpiJx2nRwHg8R9L8y/N1WhX/IY8pUfe7YyExPGzpB1tYwoI
    wZCwi5rfBFonlD+jm60wgRwBCmG8zHB7CMFouc459ClzOR+quqKJWIkiasrd9GI7
    8tocKrpyPM4BTthi/2CR4kCSqRyWc1ABIZQsWlGtGhEOxFoAUj8Dv/b39eQzzNSU
    CaD5r0+BHDnune0B1eHz6M1beFgHi2T9Oe9NaBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414786; bh=09SgDvyQM+RgHoGaHtvgY9LCkX
    l8jC+/t9pDOwvay0E=; b=DMVOxr7e8ZpZ0xNzEXoxY1yoQC86UZr0dIO0XlmTlW
    e3CsTfVt4ZYrZRSJO/5KvdmCnl1IRY/gHee3njHTAmnhNRLNX1yDqe/F2fBWqc0n
    Ehlvd/iq5gVOJHfHxiEvAj17JiAeRqcZMD6jdqpa+mAnVMGBodZBaKUN1tmRdJEw
    mSjmncpRl4HzehOkaOPVyN/2HgC5kZJThYUaSsrQmCr4HrOvr6s3OzT5dqFmvm2F
    G73XYRzqW8YcaZ4mkxmO+W6LFdtlFbOFAlHJh1MArkrCpODQQ/mIdXOw9vEUxidx
    pAygbBTR3fx7xY1LeBNH+3Nbo4M5CYwy3KQ+lHklFTlQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934086AbeBWStm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:42 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934016AbeBWStl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 4.14 016/159] xfrm: check id proto in validate_tmpl()
Date: Fri, 23 Feb 2018 19:25:24 +0100
Message-Id: <20180223170745.212745353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 6a53b7593233ab9e4f96873ebacc0f653a55c3e1 upstream.

syzbot reported a kernel warning in xfrm_state_fini(), which
indicates that we have entries left in the list
net->xfrm.state_all whose proto is zero. And
xfrm_id_proto_match() doesn't consider them as a match with
IPSEC_PROTO_ANY in this case.

Proto with value 0 is probably not a valid value, at least
verify_newsa_info() doesn't consider it valid either.

This patch fixes it by checking the proto value in
validate_tmpl() and rejecting invalid ones, like what iproute2
does in xfrm_xfrmproto_getbyname().

Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1443,6 +1443,21 @@ static int validate_tmpl(int nr, struct
 		default:
 			return -EINVAL;
 		}
+
+		switch (ut[i].id.proto) {
+		case IPPROTO_AH:
+		case IPPROTO_ESP:
+		case IPPROTO_COMP:
+#if IS_ENABLED(CONFIG_IPV6)
+		case IPPROTO_ROUTING:
+		case IPPROTO_DSTOPTS:
+#endif
+		case IPSEC_PROTO_ANY:
+			break;
+		default:
+			return -EINVAL;
+		}
+
 	}
 
 	return 0;
