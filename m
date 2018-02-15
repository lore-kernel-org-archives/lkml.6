Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711291-2-11761166959264928711
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711291; b=SMucgp2qlsDnxmZYEqiGq4BxVi0MqIPAs5AEjrfo1YZQCwr
    M/b/wEssJc23JPzIhdxj6cLVyDrH3CNLp7rKSOZj2juhgG45VXzYV5616aoujVx1
    ZJ9OboDpE9azp1R/X81MyaONXiDAbQvLaA2wye1197giAj7SGXDdFw4kCSi02vU9
    TNDZqI09aL0fuDcgY/GjeUJIRLHd6f5tqMAMpLgwO7HbgsEBAY7uvuovRSgjhRjQ
    RvU9EU8ohCwLKfEZiZzqSlKpnQMFxPujoQbs5n2t8RS/RnBu8tZMSZRSDeVj8Ml5
    ZeYLgo+dvMtGCWb+ESbaRBzWxisKBlrp+75Tslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711291; bh=rE9iG13EMIa2oimiJE9pYBv5AP
    L01Fv1ij0YeOiDfn8=; b=pujTYXiy+aV9744ge6OXea5QqiRPKahZ66+MLy8cGG
    mACRFoYphGoFqkHhLZMW63PqIMMRP7K4aBoP1wZvssvagSf21tbkyVWpId9l+ARt
    mjAiIJZOsVu74tFMtFgpowVplT5jJsN/CmAXgt2dDfJSwW8vhxTitJdKlxUdcUL/
    L9Nb4f/SsDoUNgSrrhau9cWp2M7vTFyYCcBNVX/JlvaoX9cguAn4OYnurPMWFddJ
    MWAhEoEueO2lpmEmUV5g9gVoAoal4LBrLsTOk6xLuZ6XjXYMmkkssJ+pRwSoI26e
    oXmUakNe6GvlE4k7NOde5qlNHP+XA6sM499i7nQFHT2Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424375AbeBOQOe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:14:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424338AbeBOPos (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:44:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Magnusson <ulfalizer@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 4.15 136/202] KVM: PPC: Book3S PR: Fix broken select due to misspelling
Date: Thu, 15 Feb 2018 16:17:16 +0100
Message-Id: <20180215151720.245369371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ulf Magnusson <ulfalizer@gmail.com>

commit 57ea5f161a7de5b1913c212d04f57a175b159fdf upstream.

Commit 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code
on non-pseries platforms") added a reference to the globally undefined
symbol PPC_SERIES. Looking at the rest of the commit, PPC_PSERIES was
probably intended.

Change PPC_SERIES to PPC_PSERIES.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Fixes: 76d837a4c0f9 ("KVM: PPC: Book3S PR: Don't include SPAPR TCE code on non-pseries platforms")
Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -68,7 +68,7 @@ config KVM_BOOK3S_64
 	select KVM_BOOK3S_64_HANDLER
 	select KVM
 	select KVM_BOOK3S_PR_POSSIBLE if !KVM_BOOK3S_HV_POSSIBLE
-	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT && (PPC_SERIES || PPC_POWERNV)
+	select SPAPR_TCE_IOMMU if IOMMU_SUPPORT && (PPC_PSERIES || PPC_POWERNV)
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
