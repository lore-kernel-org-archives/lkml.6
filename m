Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479856-2-7741675536031597040
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
    1523479855; b=ohWz6zKesV8KS8ixBhy8mJ2duNSFy33f2x42AErcQfE2lvGJsA
    fq0StLM4OYorgPXCkMEBz0fCkf0VANsJN1BHtOB0pRqdXYN9IJOah+iaWuXxCZ2p
    PvoDpLfZUu4dbNJMd3rP+5ndMZGruzXFmRdNIklxrxQIGmf3Edzn3Jrk2GU17j1R
    PnnKEl+7XFErVPUpOzXzump1OKQ3iqKDbOMSwseit8IiqP9YWilIj7X/k4k3E+Dm
    Vt81v664qS1DHa7ta7Nnhr/YyAsQI4lodVh96BnbEFKgPMkACtJMdNDjOFH+/cdE
    SKLV0i9c4e1xjGhYj+R4T8IgSVJpmDTuDuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479855; bh=LZ60T10cwqPpawj3zODthPli9UBpDA
    fmqb0Ypnllv7Q=; b=LZlH3aZh+fRh2uTMfCzRxpopwpEUGg/DBm3d1D9ZHgJOD0
    moekRLzgnnOh8j3g1rhT2oAkj7Q/Q7V2zWBJj49zXXkD/bUjcC/NJv+WRvY25hXU
    U/JdCqqB42826Au2LV3BQCxAnImWasVvsOCgl67cbW3CR+yoljxaV3k6DY8c7TxR
    nIMKpZygmXSe/1vWrBwzaJJrjTUCntNQ8LRVyPhT5J/yGw8nPTt2pAMAL+jV5ncD
    bjb93FDVNoTZvKFwFYfpDo1K/kVmfuHFFWejs/Ej87QP4+QdoFokacSPuct2o9bR
    jYZjUqcBvON7fY0ikzDPZpgA23kmrS74szbePwuw==
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
X-CM-Envelope: MS4wfP2gIXR/oydIWdHLKfxidMCbeol48svJbOKM/Q5gASrYyRJx7tzK6pih4vtk+q0P4UJN4SyYVJk1xsMkJDUAQPdW8V1ikobny+Ht1qqjf/uQb+Ygx4+v
    laX6v1L6m1xL9pLe70cfUBVir9JjQelbh1GMhJ+dxXYFX1rTz2+uchbrxhLPwqCRrqdQ74bDqcPb1xHerfuX/3LbBYMZ71/QrhJ9oXYFyWMUgiMCvj5kRlQH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=EUspDBNiAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=mFJlSFYP1aaS0j_PnB4A:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=rMCfJy6NHDicN4J276Yl:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755592AbeDKSps (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755587AbeDKSpp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 052/190] ath5k: fix memory leak on buf on failed eeprom read
Date: Wed, 11 Apr 2018 20:34:58 +0200
Message-Id: <20180411183553.350683368@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 8fed6823e06e43ee9cf7c0ffecec2f9111ce6201 ]

The AR5K_EEPROM_READ macro returns with -EIO if a read error
occurs causing a memory leak on the allocated buffer buf. Fix
this by explicitly calling ath5k_hw_nvram_read and exiting on
the via the freebuf label that performs the necessary free'ing
of buf when a read error occurs.

Detected by CoverityScan, CID#1248782 ("Resource Leak")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath5k/debug.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -939,7 +939,10 @@ static int open_file_eeprom(struct inode
 	}
 
 	for (i = 0; i < eesize; ++i) {
-		AR5K_EEPROM_READ(i, val);
+		if (!ath5k_hw_nvram_read(ah, i, &val)) {
+			ret = -EIO;
+			goto freebuf;
+		}
 		buf[i] = val;
 	}
 
