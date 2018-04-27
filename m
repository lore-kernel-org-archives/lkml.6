Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838138-2-2311590572220398300
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
    1524838137; b=K0VA5bEYvSXLNkFSZIOTghyMp2wlskNTm/j5YY8uIDct0Es0hz
    nNV6RmF/nWRGOXaDmcHRogW7CfVoQbWKt+0xATU91jpwAYe2+VIkzHwz9BgbPCLo
    EQq4VohWlRR1emqauaRrcnVo2jU8NroUcA8EESx8J9o2Txhbe+xTd1hbxOsKLxzw
    H5gW819CW67hlmj8ctQyfzrAwhT5a4HyC37CO0MBOfSMN82iOCzwRZXns8XO3plK
    JYcfZ0UhREDr1beTCodX2029lIAfItgCREbcnpVNTmXETvjOCw+XSrwqUDAqdynf
    Z6MfcBobzQDT9T1wIHEHC29ePDQf2ktpeumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838137; bh=A0HbnBPA9/WGpMdmDqb81MXvzAc68D
    NipJ6zuJTasVE=; b=coqG80eB0NbB293ekoQ9v+isWaR2daQgxiZPeX1Sy+9v/v
    m1gPMXcmGNqwuTUzfQd9XYvZP1efdvZXak1MzKt7YIjO14NBgS5Acnqo0ykjpDls
    gzCcZVHqnRkqfQ9+1pyXAvTt9wMvlGZLf1f3JrDjMKHA5b3aaycZDAfE/1Yg6MGX
    1h5FlUprfmbEndQtfD7WFo6CMjZEMCX+sxvwLn796lIcNI+G10+Q9flbCoqerdKs
    J7qZVoGgo6MYKLSJxOpvHm1vjuD4wpijEaBFzIOoQ7AaaLQrc8N+iN77NeiDe6KT
    vmNW93Fmo2vVMnjNEYuPPP6kkOulNXh2oUSNYWvg==
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
X-CM-Envelope: MS4wfEvGF1Ezsz0WTQNfS7tmustYgSAShF/gUAII86YuNXM5xfT5Fj+eHCvg44Ah3oQN6GFKTpS1LMSqUFP5OWduiU2h//HcCxhf0GGUSJJapa1u8iapIm5o
    7sD+nCftJEYcdDKFeZeMOJvzjnFLc1b2Q1MLHqeKfWdWlRnbICRf0g7dRJLxkhccbX6KAlVVTnlTyXFq6qVn7CbDhHMi0aqVYoKJxQuvuwhV/xifgH/a1mN1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=ecaMXfM2ZhdHHHfHKcYA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeD0OIV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934455AbeD0OIT (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D0B21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 60/80] s390: correct module section names for expoline code revert
Date: Fri, 27 Apr 2018 15:58:53 +0200
Message-Id: <20180427135735.999680278@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
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

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit 6cf09958f32b9667bb3ebadf74367c791112771b ]

The main linker script vmlinux.lds.S for the kernel image merges
the expoline code patch tables into two section ".nospec_call_table"
and ".nospec_return_table". This is *not* done for the modules,
there the sections retain their original names as generated by gcc:
".s390_indirect_call", ".s390_return_mem" and ".s390_return_reg".

The module_finalize code has to check for the compiler generated
section names, otherwise no code patching is done. This slows down
the module code in case of "spectre_v2=off".

Cc: stable@vger.kernel.org # 4.16
Fixes: f19fbd5ed6 ("s390: introduce execute-trampolines for branches")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/module.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -478,11 +478,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 			apply_alternatives(aseg, aseg + s->sh_size);
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
-		    (!strcmp(".nospec_call_table", secname)))
+		    (!strncmp(".s390_indirect", secname, 14)))
 			nospec_revert(aseg, aseg + s->sh_size);
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
-		    (!strcmp(".nospec_return_table", secname)))
+		    (!strncmp(".s390_return", secname, 12)))
 			nospec_revert(aseg, aseg + s->sh_size);
 	}
 
