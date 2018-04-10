Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402350-2-10152368612882617764
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
    1523402350; b=JgDJnaiDgv79BUXBmP5uz+vPh+SjL6AUWe2zAJG/fyKidhiA80
    5nQIsQuhrVHEmZwOBN+c0TwvEimDw95Q+CvueyNWhGTSJ5a7uS5yyCym5cx1IUhE
    sYPyoj1OKl63KhvuocqU4fdKSriph6hgNgqRp/EYtwsZi5FhjdGdOcY7WPSdHA8H
    x0/ETWCYdGJT8NG1Bu2yaBrv1UHWjtDUBN/UBJPSaDi8QzwuaXGP3bAifXUWDGo8
    DTMudmHE2cznRPI7Q1AAUlr1ho7zsoNbDIqE/vh761QSkK0pFqrKQdjt0X0fh8rv
    qq0HXQbV1G99kCUCulDApXYgu46OkQpno2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402350; bh=vDraaTi7ZRa7xGlWLEe28qagsUCKuM
    GmYemv5Va3q+g=; b=oZegW7d/r8I42g3yt6sAs1ZuAYw58ZW3TTjfMyCLkZRP1B
    N/jO2idW5HxnnxQUnR55r0N9ifKAIS6An/XuSf6BMWMVJ3Xy2T7+OnTg+cpHwZxZ
    raDfGstGFFdAd/NypPGhjEHFT5lLKpvZ5BxRtLmS2oMEcguQng63ROLaDH5r+jhi
    U8/fsJNu5/DNKeSLFmrUb7ZQbKmFDfkr8g7cxloACIY+WQWT7G+8ctS28lwSg49C
    X4exjuLZH0EXNRa3ekvSFXGOj6s8IehRlxtLCqbypT3t4q+uy+ZORgnFtyv9wh0a
    G2ONmaUc1yRsCp0h5fBGqhA9JCWzGRK4BczeZRmA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfIVtiyECsJ6hd9IhfCOtvp4C6ZBRYlzioufUZ2A26G7Ti76ySge3rNC0KkxqqNa7tAfcC+9flGthhCDNv+0SYdnBGxDwPBEv4Wle3P7nticRGz3nUm3p
    ViiwIIRENL27/KNfXIBu5M0e+8p5MvafzRITrOyl01re9bxMkVKsh+2ZcHjnXhffhfHecBAIYE5KJIY+mpTcnE8se51YaaGUb8AvYvCsDVGuG7Cl4M6/3vmR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=nOdykIpmWu9aoI1BNPwA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeDJXSw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 19:18:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40318 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754769AbeDJWbS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [PATCH 4.15 114/168] x86/microcode/intel: Writeback and invalidate caches before updating microcode
Date: Wed, 11 Apr 2018 00:24:16 +0200
Message-Id: <20180410212805.280595107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
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

From: Ashok Raj <ashok.raj@intel.com>

commit 91df9fdf51492aec9fed6b4cbd33160886740f47 upstream.

Updating microcode is less error prone when caches have been flushed and
depending on what exactly the microcode is updating. For example, some
of the issues around certain Broadwell parts can be addressed by doing a
full cache flush.

[ Borislav: Massage it and use native_wbinvd() in both cases. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Ashok Raj <ashok.raj@intel.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
Link: http://lkml.kernel.org/r/1519352533-15992-3-git-send-email-ashok.raj@intel.com
Link: https://lkml.kernel.org/r/20180228102846.13447-4-bp@alien8.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/microcode/intel.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -600,6 +600,12 @@ static int apply_microcode_early(struct
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -816,6 +822,12 @@ static enum ucode_state apply_microcode_
 		return UCODE_OK;
 	}
 
+	/*
+	 * Writeback and invalidate caches before updating microcode to avoid
+	 * internal issues depending on what the microcode is updating.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
