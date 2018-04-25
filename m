Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652648-2-1811852695990474652
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
    1524652648; b=Xr9dnyimajyoP12yVATtQMlKT+5xlLpAnAmZv4esHuxa2dJouW
    0uNRg5NajXR3EXlgBuxyreURTFD2QG6BPxq4Of8XjFHmF+Saksm8grr8Jk/JMT8+
    VQGl6gQ7unWzD8gdLdZKslfF1LO46lCByG+9rsAdeyQhDIITJdzIqcEyQAsVt/fD
    pVKuxkhaP/KtbKWaWp/yAEXHiVKEoRT6POWtkWCca7VVpHLl4z4XDRHT+gUAeZ1F
    MsIFByZqt7a0vesRArH2CJ4d5mKDVffuPHYPTjfxV8wg4tNr7aVJPKC+ZhooFtD+
    U21ND2Dw952ElHB0mPnbhHW7KMiVy7McBWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652648; bh=GpY0hjbIf4QCszEal3K+9p7wjMEmqC
    nJmagoqZnxr/I=; b=g/L7i5DFzkBQmiN3y/hSduwf5CkHCTcxMpuBXhd1Fs7nOa
    e/rX8aFj6o07VNaONYs/yFLyyLol3b3nK8PXJA+s0hd8Z8mqr4QxdrY1yZtmdv8w
    dVBiE3Y1qc0LcOjkbrjyFRcLMjWMiEH7lIA3l10zOF3thJOkGJJryd4NNgUOPtX7
    xuc0Q9xkx5hBn7ReZuLbTQpJ1Q561ZOmo4H9tnEWmChB31+PWq6TvNpjt/Ze2WY/
    j2IbNLddbVDkyFd3DWDl8dtL2PLFIBOVi71fs6J5IWeOZMTucFQO3TjAEkTFSWvx
    YSlm8yy+GiRJOjJQma6jkZsjdJfyYmnAzxMHIrYg==
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
X-CM-Envelope: MS4wfIK3jLwUsHwYsnIXcEY5jJOUauPkX3CvoumtEDnHvmkna29KTB0L+kk8RdvFds7K1SKhyzkpcr2lUVaGT1r8HtgGNMT+qQSeqERpHe8F8iFiW52OF4js
    iMT2XGMJ7ox3Op3LVWGdVkX2rILlEfPweYUkLbD0XMHLfLeRsmg/ucN2Feq/eNgVvXvxcdbJwQepcUGqY4Dx+kd9F86A2Djd3z/z6hh0Ox0A/sFQU0kbTVwN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=BcN0S9LAIc19CvRaRVkA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeDYKh0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:37:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753257AbeDYKhV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:37:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Clemens Ladisch <clemens@ladisch.de>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 016/183] firewire-ohci: work around oversized DMA reads on JMicron controllers
Date: Wed, 25 Apr 2018 12:33:56 +0200
Message-Id: <20180425103243.263203532@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Hector Martin <marcan@marcan.st>


[ Upstream commit 188775181bc05f29372b305ef96485840e351fde ]

At least some JMicron controllers issue buggy oversized DMA reads when
fetching context descriptors, always fetching 0x20 bytes at once for
descriptors which are only 0x10 bytes long. This is often harmless, but
can cause page faults on modern systems with IOMMUs:

DMAR: [DMA Read] Request device [05:00.0] fault addr fff56000 [fault reason 06] PTE Read access is not set
firewire_ohci 0000:05:00.0: DMA context IT0 has stopped, error code: evt_descriptor_read

This works around the problem by always leaving 0x10 padding bytes at
the end of descriptor buffer pages, which should be harmless to do
unconditionally for controllers in case others have the same behavior.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firewire/ohci.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1130,7 +1130,13 @@ static int context_add_buffer(struct con
 		return -ENOMEM;
 
 	offset = (void *)&desc->buffer - (void *)desc;
-	desc->buffer_size = PAGE_SIZE - offset;
+	/*
+	 * Some controllers, like JMicron ones, always issue 0x20-byte DMA reads
+	 * for descriptors, even 0x10-byte ones. This can cause page faults when
+	 * an IOMMU is in use and the oversized read crosses a page boundary.
+	 * Work around this by always leaving at least 0x10 bytes of padding.
+	 */
+	desc->buffer_size = PAGE_SIZE - offset - 0x10;
 	desc->buffer_bus = bus_addr + offset;
 	desc->used = 0;
 
