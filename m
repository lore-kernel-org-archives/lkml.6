Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804807-2-12858388514938719792
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, TVD_SUBJ_WIPE_DEBT 1.004, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES encafr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804806; b=vbNfu9VWWGNtaoCa+VjGCv5wLV6ahF8d0k3Zk+k3hsCd4fp
    o/oh/DfnpUDspyTS5CenVegAgkmnUZa/DoPJLRM+YSthHZthyPsqQLWZuR/shYBb
    pC6IUV1NuDJj+lzbz0pFJoGT6FJinTf9olOFxVCmUyPHCr8nnU/r3r72Rzyw1UrI
    tD4f7hNI5Xcicj7c2blNT857FUsNBInkr7jNWfHx0gIPKSl001uC6k0rGSKyb4vz
    gg9fYkMyfO/qlDgupL4Xjss7kn3uFfPq3S0FCaJIR48DZn5fKUYgh5jbjJirpLwV
    gVokrN8P22WjHGBB6rQzz+UKtfWDEbVqoHDSHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804806; bh=1us98clvuQMqe/YnF5hG8Wl7U0
    LcMDbbKW7Jhl07jEk=; b=GgjvIkC+RJGCSIry6odS1IEjvqkd440VWrHl54r/iN
    gsxtjQ8Y2ZNLtRBzWOPGk4aWuvQ/3c6vEUDd36IZ8Fd/u1xzn8PkG+ycTqjH4WIY
    jwnqfzPkLvNGEwtgAvMCF5ILcC/LjyuFzfHYFqbJEpBI1INwh1Ue652f7e7EIDcZ
    AbIczCvK3SCGSvSZOkEw3mZjcjKJnRLSerh33q3SIHTZGV1xFSQRYLDGwueIArBm
    hzikYcJ3iSHma2bd9S0ooKcSaaWfOWy9t5JSiVM8aQEe7OZKNVQ8CnGsTkjQU41X
    ASrhKwK+bQ7dg4i5bnrOMGj3SoDPM0TqNCH5G8aOQC3A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755039AbeCWKFi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbeCWKFh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 027/177] powerpc/64s: Remove SAO feature from Power9 DD1
Date: Fri, 23 Mar 2018 10:52:35 +0100
Message-Id: <20180323094206.386864712@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Nicholas Piggin <npiggin@gmail.com>


[ Upstream commit ca80d5d0a8175c9be04cfbce24180b8f5e0a744b ]

Power9 DD1 does not implement SAO. Although it's not widely used, its presence
or absence is visible to user space via arch_validate_prot() so it's moderately
important that we get the value right.

Fixes: 7dccfbc325bb ("powerpc/book3s: Add a cpu table entry for different POWER9 revs")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/cputable.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -474,7 +474,8 @@ enum {
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
-#define CPU_FTRS_POWER9_DD1 (CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1)
+#define CPU_FTRS_POWER9_DD1 ((CPU_FTRS_POWER9 | CPU_FTR_POWER9_DD1) & \
+			     (~CPU_FTR_SAO))
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
