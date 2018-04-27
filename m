Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838342-2-17908806603425634116
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
    1524838342; b=jeNG1CeR1gt8p9CgINhHoVG8idaU2ZvknkOCNOQL2A0pSamTp6
    4fiRp0Gepz5/7W+Qujr8br6cXgubRGiamdqObQuUwY+GTYzSrHRHhM1K03i02zUQ
    hVrJHcdu86TSZPosy8/UX1hx7bFxm3buee8iYDTxK1AOZ6PFg0t9t7ZoDRdq21nB
    DYFXkEvqfVu6HgUctIxcfFiS6rT6/6hVXl1VUC0s+uT2waT99xWLiosPFeoph6Pj
    ho/ZdiSjeZYM3m76OGoJcFoPhsQTMhPrVlLqNJE3U1TqbbyLxNxbuU10SBWSgaWc
    4904SLqP3csVwk/5C7VbCKbBars2G99B4cBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838342; bh=ilEv5cfjTyqB6KQ7QdXIBDizAOn8Xi
    i82YOSdatPX+c=; b=YQV8B71ZKhXimpzTcznr4SOHKlBuBozwLXWbIhipkGlBH1
    R/EYTu/ckcr5/6SluZugCb0l+HonCm17YbOl+VfFJk+3OgjaP8apxfngdQDi0ev2
    7UxBL6iPk7YO80oy3q8Y6pTA2IEVAapObfdsX7Hpxcg5IUBW3X54ViwQhYEsCIvH
    50pptudRGs/Y7TW7DwZigVNEteIBnkrk97cKVj6r0J+rurhnpj3mUP3FPjkvjDtA
    ZVA6mVaKoT3/qyhA8+HAb4hcqGdawHu7vbrY7qnHFYDquNq6DUwnIqW8NccnMN33
    kAJ87YfqfOMPVMxZWuhLj1ICb78tiGEazfhVtO7g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfDwWNgD3K5BdEk7+lJc6VrvB7N0nAS9OlBCW/OIVSafKQsduqHhTXPo7HnWINwyZhTw9mNGb6gKoy0Pf8cxIu0F7EwF/u3PT5eyHBn8nnBbZMUDuaOFj
    GwOpxOYreusAjUq+tiESCnZEVLWRoWjQDFsDVUWXkdFizZLniZ0BfjnugE0qMGgKpvDLskJBUXUxRVuA/SvleDcv7KgBT64sDJf0MlYb+IGUoLEHsNHm31VW
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=ag1SF4gXAAAA:8 a=Swts24iuYcdqNhvro5IA:9 a=QEXdDO2ut3YA:10
    a=o72u2rHnfW5qNJ_4I8LD:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935138AbeD0OMT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934912AbeD0OMR (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:12:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A0F21895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4.16 66/81] block/swim: Check drive type
Date: Fri, 27 Apr 2018 15:59:08 +0200
Message-Id: <20180427135747.149951028@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Finn Thain <fthain@telegraphics.com.au>

commit 8a500df63d07d8aee44b7ee2c54e462e47ce93ec upstream.

The SWIM chip is compatible with GCR-mode Sony 400K/800K drives but
this driver only supports MFM mode. Therefore only Sony FDHD drives
are supported. Skip incompatible drives.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -834,10 +834,12 @@ static int swim_floppy_init(struct swim_
 	/* scan floppy drives */
 
 	swim_drive(base, INTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, INTERNAL_DRIVE);
 	swim_drive(base, EXTERNAL_DRIVE);
-	if (swim_readbit(base, DRIVE_PRESENT))
+	if (swim_readbit(base, DRIVE_PRESENT) &&
+	    !swim_readbit(base, ONEMEG_DRIVE))
 		swim_add_floppy(swd, EXTERNAL_DRIVE);
 
 	/* register floppy drives */
