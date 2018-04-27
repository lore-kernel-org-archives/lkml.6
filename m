Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524838139-2-11760541793962151140
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
    1524838138; b=CR1OIQA0b4e1EJpD60HWVYu1TKaHysaBZB7xbRpHqslychDqRW
    kBzSBNSnUmL0PtxtNlw67sMnjOSXuW9bW3eCtyl+u7cT9BTf6tWLqHOj3myjLZuk
    MOack/f9HvNv7ALbYn3YMXE6xeK2JIu0bPXEPYRyagS/R32k5FG6PQh1AGcS8XOq
    5pTFlShfmisE51bElL0mFRLol1aJuQoVRH4dKn1imV5QNoE5C6axB9w4eMpEyv13
    bhC1/btMBU42LLbZRRBh0lWUf1iaYFpuAGB/fcC6h/ArP9l6bckdwYvWKjZazPq9
    6Bz3Y01DFsxo3wUywDT3IFpmU3WVilmPLbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838138; bh=qEfvoZC5IgwosccPFNw3XQo2irI584
    8DQUB3ih+9wWI=; b=lDE3eP4E4rkORVBspxgxWlc7hmnZ3a00pXmXqw6qHRGJIs
    n08a0fw1N9svs+0RdpBxjvb19YnJVvNBYJ/O8G+PFJ50n/uB0zZ9yrIlfLGEBhW4
    kOai1t38sYh0249IjLr2sLN3GbSsC6iWkrNvfrhGSGfejNCoft4sPaZcPM+KAPT6
    IIXwXCravAn3CMLGqZtf7j8Uh1TPKOVAu0IGxy01CSI1/2CnJabKD5XLMgQklfn4
    0xMfMWTJvTqn5Js689ASCNbUBbH2xi+0T/qcUMS6H+mXipJrYp+jdU1l4zGczhac
    5ImyUjN+Wp+JNoYgcM0OmYwwJDxAKib3ZMhaPkCQ==
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
X-CM-Envelope: MS4wfAOhm0YGnLfm7zR1Dg+a/XMzKT37jct1RWXLBOBgLQ+O8avvbncsgAGueFlKO8e5Rmm6gUQIycmCEPYG1XhqFYCpLzpim7/sZ3eO3Em1TB/tzx4ECS6d
    5cQzadgPEE+qRqK1roq8kw8rvPYFMPC/P8cPVgewwbLIpEQYc3reAKMsKIZZMBDjf3RTw03oGlTZ9gRUTTvJ2oDfl0NG/rASdMUBIy9ijcFa9fFurQRYR/bf
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=ag1SF4gXAAAA:8 a=Swts24iuYcdqNhvro5IA:9 a=QEXdDO2ut3YA:10
    a=o72u2rHnfW5qNJ_4I8LD:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934455AbeD0OIs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933961AbeD0OIo (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:44 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B5B21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4.14 69/80] block/swim: Check drive type
Date: Fri, 27 Apr 2018 15:59:02 +0200
Message-Id: <20180427135736.453851864@linuxfoundation.org>
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
