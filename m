Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162160-2-14380624724704811661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162160; b=W4D5EVA6x058/3WrMP8vh9305lNYuHmNpXHU0KalVqQlByZHzD
    RtVER/ZcGsEWldiixqgT27O3eoTzHMENDGkl/+NMeKhKhUn2jt7vwP4nDGLvlg9J
    r1C6fZw14ce0e24+UlHl6OKXzHGB0khpnMPFSWuydzaDhin5elqR+0noi/chfQbn
    D3i4VziZbNFaeLSMIRr1QKI643EBoH8Yts7xa1LQ7mxJlVPhEweccYPP8cw0Jfd0
    gdluMF1hs0NCaOvAKj4ju1528QsGlHBRpAX1iENtSGAgUZK94oApAWjKJvppsCAR
    ZoXYVsamapxXDPQAisGBaINdvdxn4TDj4l2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162160; bh=i6y4T5HX8EPlBrDNimZc+K7XW29SbJ
    cgvoW59XJpJgg=; b=Bv3TaPE0rsIPjjwW5cMcAw+suEYKQmOb/Nhyw215bvPQeL
    r93i4ZZCYC90+7lD+AO9u2ajCSgEPvVgb0dcXsBRNyEcurbbrSax65BqOtDhfurI
    6ibaUJ4wtGuK+4r08p8BSwAt6u5AYhpE4V8BpbYhQI15IYwgOLhfR9kR896PeX7L
    OzsTyMyhmC0y58NV0p96ijcIxf6GuJKO3etpNgH/SRcvIU2rtmpjGFFmgO1bhCcP
    i6fmFbYur1T8ifk4+ytXNXrWbe5zgmByTF/8j4f7gvndaMhLCitlvHPMU0fnqrjr
    2RgNQ51zSPiGH6dFbemP8tQ31547/bzlxQBBtxBg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=oUr6qQ1K x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=oUr6qQ1K x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAg2QUlTqX7myRksROLMVAkuHDOfQmqbCsE2cASA2T6NP9dTyZQxCp0hDIOCbS0LxxRhmlBB75t1cPIaYwAlFrq07kl+xqvUv2WqbFnXwz977d9gqfyY
    piRlrEk2AaB5/aCltqEEcdH8shdDK2X5PyDRmCNlxPgRJtYuDe4ZtsUXN1g4GkQ2cmw/C/+k3CMJUUZ6LftTjdk6JmtzPUK3/wFTLU2GGbThuOXXS3f3oqrX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=qYCPb_i1qRAFcBN3h9YA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966950AbeEXJsZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967208AbeEXJsV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 37/96] usb: dwc3: Update DWC_usb31 GTXFIFOSIZ reg fields
Date: Thu, 24 May 2018 11:38:20 +0200
Message-Id: <20180524093607.696816162@linuxfoundation.org>
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit 0cab8d26d6e5e053b2bed3356992aaa71dc93628 ]

Update two GTXFIFOSIZ bit fields for the DWC_usb31 controller. TXFDEP
is a 15-bit value instead of 16-bit value, and bit 15 is TXFRAMNUM.

The GTXFIFOSIZ register for DWC_usb31 is as follows:
 +-------+-----------+----------------------------------+
 | BITS  | Name      | Description                      |
 +=======+===========+==================================+
 | 31:16 | TXFSTADDR | Transmit FIFOn RAM Start Address |
 | 15    | TXFRAMNUM | Asynchronous/Periodic TXFIFO     |
 | 14:0  | TXFDEP    | TXFIFO Depth                     |
 +-------+-----------+----------------------------------+

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -238,6 +238,8 @@
 #define DWC3_GUSB3PIPECTL_TX_DEEPH(n)	((n) << 1)
 
 /* Global TX Fifo Size Register */
+#define DWC31_GTXFIFOSIZ_TXFRAMNUM	BIT(15)		/* DWC_usb31 only */
+#define DWC31_GTXFIFOSIZ_TXFDEF(n)	((n) & 0x7fff)	/* DWC_usb31 only */
 #define DWC3_GTXFIFOSIZ_TXFDEF(n)	((n) & 0xffff)
 #define DWC3_GTXFIFOSIZ_TXFSTADDR(n)	((n) & 0xffff0000)
 
