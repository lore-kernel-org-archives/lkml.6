Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481598-2-10398020377360489841
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
    1523481598; b=GJ32MUCuQaBlFjaCGSfWdYCzOkVrYRbE5yCEKirETNuDV0CSBV
    HSbbi2mnR3+PiHkpQNAoxoD9T0gD51o6aqOVOokCsPIxuxSKlBcL+ENom8GnG5lJ
    v1QLNPjGIvxnI6nHv4KkFTS4LU30QyMMEByUDL2R4T2RJstgTMqvaD/iz5kj+dtK
    zCJdJyAPlAJbOqtnRoh4AcIlBSQIqM11SgUyqchyXKLa5ra6LpvNu6NXFNeWX2w6
    /0RP2JBXC0gziXUvaYwf+/DXMPyW/XdwdNvstsajIMlifkjju5P24oe7p1bYXIjV
    owVbO9/iP3OWHU00s7/HJt6qCrba7kE9IuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481598; bh=YoxfARMQBjvAAVAFa7L76nhWqwawRn
    e+6gccNoT3Uao=; b=sRvXSKoo1NhFtoycFoYhZ3LK4B2VnLoGA0zYatVKwNcS31
    GYzykGtA3IVia2I7jqyxsHtzpi5Wz/VQgljmJx/wEC7L0CUTmopNbBCWa5yQcTbI
    SeRRBLXHYoFpO9fkCdzVui/S9elK6DGMbtD96KFpgh4EwClNCShwDCGdV1dsdfgz
    /DMdTSPS6GtEqmBCROW9QnazpvFH7MtNf/9aGjWULnNm2OUcTINPcI2Na6tFvwvi
    CNvvsWRJFoM+XuYss7peqUUKeB0cguHYh6RRmLP6+f8X4NVJCXuBkF0T3vZAb5Ou
    Cp1nC/OoExHAdIOkXItLxtg/BTdj4/UVy3G7LA5w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG8k1sC13tJtpVzZs4XTXx7eaC1STzVv/zzwrOcbLFbJ5Mgy4nzsRz5yEJpH4A/hFLpNUMHflFkgY4Uv0ZED2Q7qwFCnLboBgaLtnxTlOSo1OZdre/Wr
    3rkY46uGb25cYj0hzZ13DJbzbq5//IXfqP1+o9QShsfLbjCYLWhxmQYcammUjS+N5+FpoedwehnkMsHgLapKJljzlIZLTF/tTWjFn7U71O1nrjzHbjZ7TeIS
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=YmcqAzuuD1zigcaGsQ0A:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbeDKSji (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:39:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754442AbeDKSjg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 043/121] fix race in drivers/char/random.c:get_reg()
Date: Wed, 11 Apr 2018 20:35:46 +0200
Message-Id: <20180411183459.036191423@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Schmitz <schmitzmic@gmail.com>


[ Upstream commit 9dfa7bba35ac08a63565d58c454dccb7e1bb0a08 ]

get_reg() can be reentered on architectures with prioritized interrupts
(m68k in this case), causing f->reg_index to be incremented after the
range check. Out of bounds memory access past the pt_regs struct results.
This will go mostly undetected unless access is beyond end of memory.

Prevent the race by disabling interrupts in get_reg().

Tested on m68k (Atari Falcon, and ARAnyM emulator).

Kudos to Geert Uytterhoeven for helping to trace this race.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -863,12 +863,16 @@ static void add_interrupt_bench(cycles_t
 static __u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
 {
 	__u32 *ptr = (__u32 *) regs;
+	unsigned long flags;
 
 	if (regs == NULL)
 		return 0;
+	local_irq_save(flags);
 	if (f->reg_idx >= sizeof(struct pt_regs) / sizeof(__u32))
 		f->reg_idx = 0;
-	return *(ptr + f->reg_idx++);
+	ptr += f->reg_idx++;
+	local_irq_restore(flags);
+	return *ptr;
 }
 
 void add_interrupt_randomness(int irq, int irq_flags)
