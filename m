Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524406745-2-2031936093696794571
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406744; b=mm2o80sczE+q3DY670G3Y1lwKs3zj9dzk6KxEzlptG77x2P5HF
    7rd6Xj1SlxGBXr4VBMtqRvTczu1RK92Wimf73VwERUcKHAKzwGM1iBsWcnRws0zj
    x9+QmD5Y+MQrE0Mx9ZzDKw+C1ohecc68DT7xbHmtaTVThQ5ElfRa1Kj+Rf3RW09W
    silSYqBCplpfcUsgmmzQSv3J+3FJr0DleF5SgohhD0gBf60Il5g6SPv7RcJyuaU8
    VyQ3DI36M60zngtUufZKdsUebCOkkRSA/jskg1LtyJWOUI3HKRDKvFsPQ3zWPw55
    kMD7g8bLwSBrxIPD2EwTp2vV7zzb9LJWEFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406744; bh=88NQrC+YNpd/UX/aQJi6ntP+GY2dsl
    8qwaLB18jN0Lk=; b=R1GPiW7KRc7yHWvuuIALNkR06/2PDuintOVW/jgu/1PbBC
    zt5pIdQ8ataAtY5lB6vDKclV+3T1HC8MobF5Rss1AZ8AGP4Cv6ESwhqJyCm6U6aw
    jOgzFstsZRUbIaQsE3Jno5Kq9MOXLPN89y7+zm9UYhzH0UKBxYQ8gP66Oxsa3sdq
    ASyBOogvIO3E3JJ6zv6s7Sd9/US+Ev7EvV0A9fh/wIR9JECh86pWSAKVIurG5CiE
    i2xtc3Rj4gpV3Fs1V/ODwleQMNvAK6zR/SyunW0HNxGpElG1v6M4SbG6EPvtpcj2
    UxpoAoCu9hJ+DkngvQtZAqi/KoYPBc1PSrnXhEmA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDgvcEYsH6i5C5Si7O7Doc2nPF8555ACTGtrp0+LsAAxsr1SXPWDVolJBK/0fX++fAlsKj6JGGWf9m6zJPIX32MwDxwLaxuxoATCKdXqsMrjXIkwpAJ9
    BaLmS5JtJr4MZUaFZ1rq/JusbHOx0ZGVtoEzXBplHfAatduvdRYC0oQvv8EJIM2bL1rpVT0q7LmbasdV08+oRcsK1bfHZps7E7DobscR6rfazEqiG17jawQk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=zkkJT_EHekSEDCfo8j4A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932498AbeDVOTB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:19:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbeDVOTA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:19:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 87/97] powerpc/lib: Fix off-by-one in alternate feature patching
Date: Sun, 22 Apr 2018 15:54:05 +0200
Message-Id: <20180422135309.940968004@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit b8858581febb050688e276b956796bc4a78299ed upstream.

When we patch an alternate feature section, we have to adjust any
relative branches that branch out of the alternate section.

But currently we have a bug if we have a branch that points to past
the last instruction of the alternate section, eg:

  FTR_SECTION_ELSE
  1:     b       2f
         or      6,6,6
  2:
  ALT_FTR_SECTION_END(...)
         nop

This will result in a relative branch at 1 with a target that equals
the end of the alternate section.

That branch does not need adjusting when it's moved to the non-else
location. Currently we do adjust it, resulting in a branch that goes
off into the link-time location of the else section, which is junk.

The fix is to not patch branches that have a target == end of the
alternate section.

Fixes: d20fe50a7b3c ("KVM: PPC: Book3S HV: Branch inside feature section")
Fixes: 9b1a735de64c ("powerpc: Add logic to patch alternative feature sections")
Cc: stable@vger.kernel.org # v2.6.27+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/lib/feature-fixups.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -53,7 +53,7 @@ static int patch_alt_instruction(unsigne
 		unsigned int *target = (unsigned int *)branch_target(src);
 
 		/* Branch within the section doesn't need translating */
-		if (target < alt_start || target >= alt_end) {
+		if (target < alt_start || target > alt_end) {
 			instr = translate_branch(dest, src);
 			if (!instr)
 				return 1;
