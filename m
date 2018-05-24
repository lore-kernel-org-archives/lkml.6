Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158678-2-9482994378843335164
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
    1527158677; b=RNXY3FCSwYYth8vg8BQiTy9asPijYxSD7S58AFdu79Of0T5x7M
    0/iYxF/MDhJ3bfiwAMNd5m4BOzS8m2JoVFT4Ca+S1sSzX47bGilnMDOMSWmCSdF+
    dgC8xbXzKJBWYwxg+X5tjbITpxV7MzpcM7MABlPrr0GW9hje+qrhX6JYqaWkzBX4
    dQSCxRtb52AGxK6Ubq2uQ85s1IRrT7MC3Juuh3pDwg9Vm4EP81C3+PYuKJUWbnL4
    XKNidKeUy0G1MMwRcsgDh3CaWaI5SkarNZHtmhcFHPZObWiWhN8nSsdlCgCNnfEB
    RLmsiDPcx3oQmiBvlrc2URiZgKUYjvBgiXng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158677; bh=0kanH7gnXUZiVLUzEiBdFHbYzM4MWI
    fCz2HEFr6cp1U=; b=i1CnX16dP0kqt9QjTnNJXf/mbwG42Q4yZMdamQueVPxoEE
    qrl6ewPF//Sep3b/AaMC2vj5qd+4QPCUI6fxBieQ0A1zOEIk/iouYNE2XUX9d1Il
    F7IYGYIHNBySS+NEJzJS72bn9YQHAazdbP29ancXo2jEw/bCjwc4KUytZ6NWbgvR
    UUMPplfxQ4z7A43w3V8CT7gE6Z+HEohVa+JGhOJ3MFQCS4b7SasBWEceQTtfZ726
    TEEgmnCS+iYrSnAC8l3QE+82jXIoRPUl00TuGaDeg2jpRJpuHwh2cS58EJ2lphKO
    V1OPanBKBc+PFw/1A/rI1XV/XyZywUn3GqgC4S8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=uu2TGceR x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=uu2TGceR x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIE3jmaSCT7MThmEpz/N/wCsu7NJUcafAvhpVGqYxZmubGPf0DzT4vIjBAbkJm1Kl3DU6Fmbv5VgEPEkckz82asB/ncrYClMJGu9PRjWNOHLUmdEBlTG
    4224TuYFU2T/NehfJo2rg4tjxHSXgiQ3AWHUQ6MnXKZbdv+BqKRGbGRZa4N9o1ttwQyf4KoAC25LokRM5ITZvnF+hKqFS6E3aSiqMbh7shpFcxjlpmmRymfO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=AUd_NHdVAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=KpQyJLamcPskq4UzwGEA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030553AbeEXKoV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030545AbeEXJ6A (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 149/165] media: cx25821: prevent out-of-bounds read on array card
Date: Thu, 24 May 2018 11:39:15 +0200
Message-Id: <20180524093628.098045813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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
@@ -867,6 +867,10 @@ static int cx25821_dev_setup(struct cx25
 	dev->nr = ++cx25821_devcount;
 	sprintf(dev->name, "cx25821[%d]", dev->nr);
 
+	if (dev->nr >= ARRAY_SIZE(card)) {
+		CX25821_INFO("dev->nr >= %zd", ARRAY_SIZE(card));
+		return -ENODEV;
+	}
 	if (dev->pci->device != 0x8210) {
 		pr_info("%s(): Exiting. Incorrect Hardware device = 0x%02x\n",
 			__func__, dev->pci->device);
@@ -882,9 +886,6 @@ static int cx25821_dev_setup(struct cx25
 		dev->channels[i].sram_channels = &cx25821_sram_channels[i];
 	}
 
-	if (dev->nr > 1)
-		CX25821_INFO("dev->nr > 1!");
-
 	/* board config */
 	dev->board = 1;		/* card[dev->nr]; */
 	dev->_max_num_decoders = MAX_DECODERS;
