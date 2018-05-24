Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161632-2-4150856472133040218
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
    1527161631; b=RiROzcZ0F65qKaIfzEA5KKNrF0pYPaSgjckRFIlJYVV7aj2p/6
    FFx9J1o2dV9+xVDQYt7KlX6adkovOU9kkJDXJ1H25UaCCd7CZQwS++xvl9gaZOYx
    4ntfzKWvIQMVTPyVuL1YwTmQjw2zAPOc5pdW+HA8a1nOK37V4kHkF0mm5sUmIAEf
    dy1xjEM58b0Oba49x9zz0MYhBDMXhh2TUxWv0mE6NiOUSWDMTFO6cBr/1JKdP7zL
    frv5UhppWb5VS0UZIh6XaFfJ9I9MPANbF3aEvEbgy6Q3cFyens8mVf9Ag55F9ZgK
    +TjkyBTSlaHyRrh9JSlVxu4Ej31ZmKNfEuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161631; bh=RAX4/da2Kz9cSkZYv8sVHJij63RVn9
    o4//dHHlRUUM0=; b=GjEYLQNR1Hel7eAxQIAq7lLW2KxwzR7RDIEKcRfinJgB2G
    1P9Y3PCW1kj4y2zbjcoKbA0/l4cMW77LfSaCbL3/aWdgusos8OIHlW5IEQs3wghW
    ihORE5nBaVVKwIwvgf7m9spsJmhyN89PR1vkvB10tPgKxD2pAkfdTVTpYbV93wIG
    IOSKt481iVVMAW0HTwKPmo+tnfEczeCQKoO9WyFtWi5lxqBQu+bWf+HWJRWYTqXX
    lMCnA6Ist1CiIlh8tXcOzjym19YD0ho3OtaKUWKVEB8wKlX561SrlkLkw1Vluops
    unSTAM5d0gvi/J8vnQXFKn88ciCmDfemmDmJZrog==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=S2vGJJys x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=S2vGJJys x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfH2Pt4Xh2QPj2IgAXrxa9wX68dqt6f4BG/0nMNEPEptECeTGHsDfEAaXt3dL1tB0HD/jRvZ6TQUy/l8g+/3OZpQCc0YMxtXPiMXxmj1/OhhcD8Gi/34Z
    b0kAoHDDq0iH684Jy6+WASolNqgBEa3AV+8G5WUAguvBNwLMbAW59DXDYuFaUkLw7e1JkHF/okCTboemydoAw1FyqZr1aPsnFkPfBw4YNFMBZEZjTPCY5lv/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=9Z2SPrszHxEr92HBMu0A:9
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967839AbeEXLdX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967432AbeEXJu3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 82/96] media: cx23885: Override 888 ImpactVCBe crystal frequency
Date: Thu, 24 May 2018 11:39:05 +0200
Message-Id: <20180524093610.098440449@linuxfoundation.org>
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

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 779c79d4b833ec646b0aed878da38edb45bbe156 ]

Hauppauge produced a revision of ImpactVCBe using an 888,
with a 25MHz crystal, instead of using the default third
overtone 50Mhz crystal. This overrides that frequency so
that the cx25840 is properly configured. Without the proper
crystal setup the cx25840 cannot load the firmware or
decode video.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx23885/cx23885-core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -872,6 +872,16 @@ static int cx23885_dev_setup(struct cx23
 	if (cx23885_boards[dev->board].clk_freq > 0)
 		dev->clk_freq = cx23885_boards[dev->board].clk_freq;
 
+	if (dev->board == CX23885_BOARD_HAUPPAUGE_IMPACTVCBE &&
+		dev->pci->subsystem_device == 0x7137) {
+		/* Hauppauge ImpactVCBe device ID 0x7137 is populated
+		 * with an 888, and a 25Mhz crystal, instead of the
+		 * usual third overtone 50Mhz. The default clock rate must
+		 * be overridden so the cx25840 is properly configured
+		 */
+		dev->clk_freq = 25000000;
+	}
+
 	dev->pci_bus  = dev->pci->bus->number;
 	dev->pci_slot = PCI_SLOT(dev->pci->devfn);
 	cx23885_irq_add(dev, 0x001f00);
