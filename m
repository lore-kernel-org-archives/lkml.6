Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022073-2-480925401054463989
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
    1523022072; b=dIUxiF4R3EbPspavitPxySekSpaBf4inzzwP/a28O0DCY9jEDV
    1a+dxB3680a/6F6yWL9p3Vcp8pJHXOTI2TXf+fA5vQz2d+RB264NpqkReAESf+FZ
    CnSjM8s7ew+yiA35lwi0iB0ipS/4BCDA7XG4G4ECJZqz0RRg0QHhkuDSIDRVLo/K
    PIsyEBx+ZCdNivvt651wJKeu3dJYywjkEOd7D9KRf9tXp8YKvFL5t83rxQYbihql
    vPH1gTH4tU5e6t6D7LTsEZAVieoBgNs7lbnWJfak+bVFbakL0+ZGMD4yOGryFvjF
    d2OqQAb6o7FG4A31Xi8v0v0jYZ+p5QOgoupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022072; bh=NqGrTQl/+oV8ICw2d2qP/VqBzSUOi2
    /KAleVH3nAfQY=; b=ealhcEcU3jaTOYjHK5lcwLmhAyUa5I4CwHrfAuP+ibQdTX
    ZmGZw5VWxvv/lOEVb+YMDsTP/GzExIhpB8DAa2hFxDsAknknU8WxKidG3+5SoZll
    22CQBdpgovtp5m/XYjNAUX7SYNoG/K6Xo1U71IfGC+WY1VE9z1K69SuIfGlSGLCM
    Xqrldji5adshAomz1ozfVi3/DoRQhSEyMzt2WnC0P3yANiv2ePHl77WoFLuR+hzM
    oLZK3aNDtkq5A62n2ZcCXd/ga0uFj4GSvVGSWP4FA3W8o6GZid4P+lGZTefwDjBh
    nnKGCefBTNdYnUXSXsCfqVG0e5HVG/ltJsQmer3A==
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
X-CM-Envelope: MS4wfJKaeR8wiJK1te+EzszN4/U3DV96Q4WUfipf8GtZ4fmU4mdQ4gnPFxELEbtKnLevAdm3OfuW5dWsDN4U4Vr25O5WzQ06g/fxUisrbjwoQp/yKWAuwEgB
    do5e5bx/mJqgG0Axxu5mBzOEVi2xkFPF6UMPavyotSamIhSLb/jI1WwO4Sw6llXla4wV5jMSg79SnBGm9zgq3R4idAf5Zl08AVx2JDXeNMg68BiisBqPMg8f
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
    a=MwQH1ox1N2dHXpBmkLwA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDFNlL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:41:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932820AbeDFNlJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:41:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.15 05/72] mtd: jedec_probe: Fix crash in jedec_read_mfr()
Date: Fri,  6 Apr 2018 15:23:40 +0200
Message-Id: <20180406084349.901614966@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
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

From: Linus Walleij <linus.walleij@linaro.org>

commit 87a73eb5b56fd6e07c8e499fe8608ef2d8912b82 upstream.

It turns out that the loop where we read manufacturer
jedec_read_mfd() can under some circumstances get a
CFI_MFR_CONTINUATION repeatedly, making the loop go
over all banks and eventually hit the end of the
map and crash because of an access violation:

Unable to handle kernel paging request at virtual address c4980000
pgd = (ptrval)
[c4980000] *pgd=03808811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1] PREEMPT ARM
CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc1+ #150
Hardware name: Gemini (Device Tree)
PC is at jedec_probe_chip+0x6ec/0xcd0
LR is at 0x4
pc : [<c03a2bf4>]    lr : [<00000004>]    psr: 60000013
sp : c382dd18  ip : 0000ffff  fp : 00000000
r10: c0626388  r9 : 00020000  r8 : c0626340
r7 : 00000000  r6 : 00000001  r5 : c3a71afc  r4 : c382dd70
r3 : 00000001  r2 : c4900000  r1 : 00000002  r0 : 00080000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0000397f  Table: 00004000  DAC: 00000053
Process swapper (pid: 1, stack limit = 0x(ptrval))

Fix this by breaking the loop with a return 0 if
the offset exceeds the map size.

Fixes: 5c9c11e1c47c ("[MTD] [NOR] Add support for flash chips with ID in bank other than 0")
Cc: <stable@vger.kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/jedec_probe.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1889,6 +1889,8 @@ static inline u32 jedec_read_mfr(struct
 	do {
 		uint32_t ofs = cfi_build_cmd_addr(0 + (bank << 8), map, cfi);
 		mask = (1 << (cfi->device_type * 8)) - 1;
+		if (ofs >= map->size)
+			return 0;
 		result = map_read(map, base + ofs);
 		bank++;
 	} while ((result.x[0] & mask) == CFI_MFR_CONTINUATION);
