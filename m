Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161575-2-2161574837975652281
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161574; b=mIHnvt7KMjjVcEUy3RzdnSw/ej3V4dF8N8snyh9yeuY/uheOS3
    pZkjb3FUW5Qnq5sXZ5yf2zwvBdjfDgu2kztx92OJkSVjMhojFkMeh4DEGf21va4b
    /hbsq2FbE5hMrNXcokIAzT05eJz0yBBDQGnuEaGm7OdgRivxkH5kN0REUSaoRgs5
    2wqWF/OzzZQilLIANabwWJga3MVQ5IvSZrLy230Eor2YmIIlD6uJhq0niojvPvof
    3LhOMZyY4HGvUFYNs26g8XJfq1L4xUyENMnre2qvyG0Y9K5pCI5a43hwqEZn2Is2
    vskH/TwquaVLr3CiuTLTjGQWqoEIycl9iVig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161574; bh=7j/5KEyQTClOIUn0z7mAtOq3b1Dn5E
    f6a6MWtnt+jIQ=; b=V4htpr/BsmQgiriJAsS6RHieKDFheuKLc3HHgW0ihL1TvO
    Ov/1unMNRSiDHMqt54UQS7mcSuiRHqgPpNPsuZklHVOzIoemcuiRmLIsiYoA+8QM
    BzfYwngwFurgqrjKw1900WEBDBcR4Jdm6XByRfhMt+Kho81w39kBG3lGqwb6Bhmr
    oPaxcRdsz8IeA176lYLGJDP3/AO5RGaezMD6bADwkRY+ktlD2AlV14sd7toRTecx
    1q972fDrge1cxgo+y2KvHQVHK4rKnQjs5EO1iV1BY21yRQ8Qo2xm1gJekj/c1Bla
    FOVAJfSR83YAgZmgqODmumSYwAnPsRiDyghCx8Ug==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=d5S4IuA5 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=d5S4IuA5 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP9FZeNPu5FvoCSx/d//U6GilnQLXSyId/PZyhTZhzS0P2oyukgBs2GMK6xmgXlWg36k++eHycdhh38/emb4dSoOVwTRUxZzAtuC/WXGJrx/MkOrgQue
    knwbpqWnNBMUNwCFcFYThtmAsxjxIlCmJfCOKP8xGojNMTYi3NHIxbWdIuS0tGDwaMTELcH03oH2Mux28Py4cyI5gczgVT3u6P/ibu094HywFPvOvsiw9WCi
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=AUd_NHdVAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=KpQyJLamcPskq4UzwGEA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967478AbeEXLcj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:32:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967553AbeEXJul (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 86/96] media: cx25821: prevent out-of-bounds read on array card
Date: Thu, 24 May 2018 11:39:09 +0200
Message-Id: <20180524093610.326542751@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 67300abdbe9f1717532aaf4e037222762716d0f6 ]

Currently an out of range dev->nr is detected by just reporting the
issue and later on an out-of-bounds read on array card occurs because
of this. Fix this by checking the upper range of dev->nr with the size
of array card (removes the hard coded size), move this check earlier
and also exit with the error -ENOSYS to avoid the later out-of-bounds
array read.

Detected by CoverityScan, CID#711191 ("Out-of-bounds-read")

Fixes: commit 02b20b0b4cde ("V4L/DVB (12730): Add conexant cx25821 driver")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
[hans.verkuil@cisco.com: %ld -> %zd]
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx25821/cx25821-core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/media/pci/cx25821/cx25821-core.c
+++ b/drivers/media/pci/cx25821/cx25821-core.c
@@ -871,6 +871,10 @@ static int cx25821_dev_setup(struct cx25
 	dev->nr = ++cx25821_devcount;
 	sprintf(dev->name, "cx25821[%d]", dev->nr);
 
+	if (dev->nr >= ARRAY_SIZE(card)) {
+		CX25821_INFO("dev->nr >= %zd", ARRAY_SIZE(card));
+		return -ENODEV;
+	}
 	if (dev->pci->device != 0x8210) {
 		pr_info("%s(): Exiting. Incorrect Hardware device = 0x%02x\n",
 			__func__, dev->pci->device);
@@ -886,9 +890,6 @@ static int cx25821_dev_setup(struct cx25
 		dev->channels[i].sram_channels = &cx25821_sram_channels[i];
 	}
 
-	if (dev->nr > 1)
-		CX25821_INFO("dev->nr > 1!");
-
 	/* board config */
 	dev->board = 1;		/* card[dev->nr]; */
 	dev->_max_num_decoders = MAX_DECODERS;
