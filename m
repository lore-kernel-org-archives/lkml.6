Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1491530-1523022435-2-5428015822583168802
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
    1523022434; b=jkhz6j3Hx1dJ15oSAVjt/4A3ScNHGe+USrL71Y2yyJR5Dp8XdR
    urS1BlNuAPh0OJ7lkN/5BHOGAO9qsJJABRI85RScaK7yst1RBUc8chHadbvIBsCh
    FzXJWTmlWieL78qUd08SzKIu4xaQV8z/sYTmedcUY8/Zdc7lpf8+xiK0gYyddOLx
    upsdzmwaOZMoPD0TqT5SePRJxz5LvDwVzwvD0ZqRwXTJ0cAlczclWIMoP0NhRLgy
    h1hULFcsHqGDMojWrADnJlwdwz1IE4SvFmtX3ilTB9PIIBOCAMgaYtPtPLCebyaF
    fMQRmLytA+XnaI0A3FpLL89Dzjx3P5kdtwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022434; bh=btgRWoHiAyCRJWI9H4KW6dPjZSKVfY
    lce/4uKDOmvxM=; b=hK8y+pEvSaO2DTtGBBH9o6Jf3IAS+Bq+lEfU1+hKXV/tJp
    hEq7RtzY3GDzXPY/w/M5Vo6/mC3159XpQVSBMMm0vb/MEyW3TwpgkMl3X5vHb5TH
    NzXeO8SHIHmLyeLVVmqPYGINtFUenTel90mu9/VkHfqxQuKrbrkYDnqjTP4G2SIm
    jtSkdmQhrpEbTCFp+NMGX+CqE//Dt/xg2+r/D5sAxjCHLyCpg3c5Fsv29X2MYx91
    AR2Jk8yUgp8s7AIv4il8aGzWr+vnr+XIgmSZ9DSa8v+u9o9cvYdI5gBrX9ftkB00
    XrtcrdeWwSQt63NW61MGsz0Zmwy0AhuoC7sKu/dQ==
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
X-CM-Envelope: MS4wfCG495ChYWpa1d9c8X6a1urqeoBCsQviGFcV8fwWGHr2QZn9Sbj50s0YfCbxOXxBibBfF6iNbwnqUAj41pl453VHCWZNCcpYKSYfJ71laTrFuWdVfM7n
    IckwJTmCabCTBafbic3uZHIS2bXEotI3hHLk1shGJOUeU0utagOQ5wYSZDPDFez1pLq7lIn5KRufbuVniCCgRshvThy+Nx/v6MbfrvyKf6jJ8tK2c7R0nMrI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8
    a=015h3S66Uu-8HghECTAA:9 a=IdeuhKcDquySJ9_k:21 a=v7N5vEY_NpXdKCJE:21
    a=QEXdDO2ut3YA:10 a=BpimnaHY1jUKGyF_4-AF:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756990AbeDFNpW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:45:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756966AbeDFNpV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.16 31/31] signal: Correct the offset of si_pkey and si_lower in struct siginfo on m68k
Date: Fri,  6 Apr 2018 15:24:56 +0200
Message-Id: <20180406084345.131141646@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 8420f71943ae96dcd78da5bd4a5c2827419d340c upstream.

The change moving addr_lsb into the _sigfault union failed to take
into account that _sigfault._addr_bnd._lower being a pointer forced
the entire union to have pointer alignment.  The fix for
_sigfault._addr_bnd._lower having pointer alignment failed to take
into account that m68k has a pointer alignment less than the size
of a pointer.  So simply making the padding members pointers changed
the location of later members in the structure.

Fix this by directly computing the needed size of the padding members,
and making the padding members char arrays of the needed size.  AKA
if __alignof__(void *) is 1 sizeof(short) otherwise __alignof__(void *).
Which should be exactly the same rules the compiler whould have
used when computing the padding.

I have tested this change by adding BUILD_BUG_ONs to m68k to verify
the offset of every member of struct siginfo, and with those testing
that the offsets of the fields in struct siginfo is the same before
I changed the generic _sigfault member and after the correction
to the _sigfault member.

I have also verified that the x86 with it's own BUILD_BUG_ONs to verify
the offsets of the siginfo members also compiles cleanly.

Cc: stable@vger.kernel.org
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Fixes: 859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")
Fixes: b68a68d3dcc1 ("signal: Move addr_lsb into the _sigfault union for clarity")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compat.h             |    6 ++++--
 include/uapi/asm-generic/siginfo.h |    7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -222,6 +222,8 @@ typedef struct compat_siginfo {
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
+#define __COMPAT_ADDR_BND_PKEY_PAD  (__alignof__(compat_uptr_t) < sizeof(short) ? \
+				     sizeof(short) : __alignof__(compat_uptr_t))
 			union {
 				/*
 				 * used when si_code=BUS_MCEERR_AR or
@@ -230,13 +232,13 @@ typedef struct compat_siginfo {
 				short int _addr_lsb;	/* Valid LSB of the reported address. */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
-					compat_uptr_t _dummy_bnd;
+					char _dummy_bnd[__COMPAT_ADDR_BND_PKEY_PAD];
 					compat_uptr_t _lower;
 					compat_uptr_t _upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
 				struct {
-					compat_uptr_t _dummy_pkey;
+					char _dummy_pkey[__COMPAT_ADDR_BND_PKEY_PAD];
 					u32 _pkey;
 				} _addr_pkey;
 			};
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -94,6 +94,9 @@ typedef struct siginfo {
 			unsigned int _flags;	/* see ia64 si_flags */
 			unsigned long _isr;	/* isr */
 #endif
+
+#define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
+			      sizeof(short) : __alignof__(void *))
 			union {
 				/*
 				 * used when si_code=BUS_MCEERR_AR or
@@ -102,13 +105,13 @@ typedef struct siginfo {
 				short _addr_lsb; /* LSB of the reported address */
 				/* used when si_code=SEGV_BNDERR */
 				struct {
-					void *_dummy_bnd;
+					char _dummy_bnd[__ADDR_BND_PKEY_PAD];
 					void __user *_lower;
 					void __user *_upper;
 				} _addr_bnd;
 				/* used when si_code=SEGV_PKUERR */
 				struct {
-					void *_dummy_pkey;
+					char _dummy_pkey[__ADDR_BND_PKEY_PAD];
 					__u32 _pkey;
 				} _addr_pkey;
 			};
