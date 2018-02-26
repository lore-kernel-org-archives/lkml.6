Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3776141-1519677587-2-10364652609713436727
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
    t=1519677587; b=s8LADrm49b3RCFaV94mW2Wzqa7banuOQOADJD8yH98esiK8
    VxgFg4ZCfWxIC2KpCmwfxEQV5Gr/9LjaU8uPesdj6NT0nRxBlCqihIHsypfEUSAh
    bVntfOq+zWo8MkRh7ZB5Zau2lgGspLZUAM/kstkUyOUHcK0Q2aX5+mpnc7F87Gce
    7timim2O9Yr6OFdf2TymiksPV0JP3IAuesylj9R5TqOVpMGRA4cly0nsXgkMBOSy
    hA7N3qz5/oZqQEB1O6yjs8uvIejJvKQwCxHMtNwC7G3mLkii7mpWMJuKW+MnbeHb
    mpwjeoasnAOaZ+wFRc4PXdLEX70tPRAgf4HaqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519677587; bh=NfgxwQndUVroTo5QI3o6KUAJ13
    zIVq/Vithc30EJRXs=; b=K1UcC3nZDDYzoXBES3vHe5dAdPEG/jkLzKQ5VkN69f
    hTfDde3CDKsSwdDvaMpXCEQv/0SmVwDd8UiWtQgcN+AY3UuhBYvRChpQCx6Mqoo0
    sFHhTIfzIe0yf3AuwaWxsZmej5BHbKJ6Ly/Hx5BLiSFKl1YQxHl9dmYd9/lAOu5Y
    Gr8UwA2Vb15MzJhHFHnoqrj0LtTmRCFnkYnHBZdd06tswzCKJOF+CImubNb2TAN4
    QyL/8xQ3AJCRZKaaRSsUVR2UXJBhB6U1L/kMLm9cucPpEHpMc4QP+EdE3cwLb3Qw
    Em1PE85tLSWE4WK6yvxnhE1chZMA0lkJ8zN5Uma2uX9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753739AbeBZUjp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:39:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753674AbeBZU1Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:27:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Mamonov <pmamonov@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-mips@linux-mips.org
Subject: [PATCH 4.15 07/64] MIPS: Drop spurious __unused in struct compat_flock
Date: Mon, 26 Feb 2018 21:21:44 +0100
Message-Id: <20180226202153.748429368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
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

From: James Hogan <jhogan@kernel.org>

commit 6ae1756faddefd7494353380ee546dd38c2f97eb upstream.

MIPS' struct compat_flock doesn't match the 32-bit struct flock, as it
has an extra short __unused before pad[4], which combined with alignment
increases the size to 40 bytes compared with struct flock's 36 bytes.

Since commit 8c6657cb50cb ("Switch flock copyin/copyout primitives to
copy_{from,to}_user()"), put_compat_flock() writes the full compat_flock
struct to userland, which results in corruption of the userland word
after the struct flock when running 32-bit userlands on 64-bit kernels.

This was observed to cause a bus error exception when starting Firefox
on Debian 8 (Jessie).

Reported-by: Peter Mamonov <pmamonov@gmail.com>
Signed-off-by: James Hogan <jhogan@kernel.org>
Tested-by: Peter Mamonov <pmamonov@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.13+
Patchwork: https://patchwork.linux-mips.org/patch/18646/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/compat.h |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -86,7 +86,6 @@ struct compat_flock {
 	compat_off_t	l_len;
 	s32		l_sysid;
 	compat_pid_t	l_pid;
-	short		__unused;
 	s32		pad[4];
 };
 
