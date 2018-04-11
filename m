Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3190956-1523476442-2-18352186947079881473
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
    1523476441; b=NgAXyW6f2tJmyMNK9WseIyAjElTQy34UhJn6R1pH1l/Dip6i//
    2/2X83wKKbsK53juLVGu7InAW+pMNZcrYJm4xhsKWeRLxIWNJZgOLSpzoNsU8D5O
    5OtFIQMbfctlWgDdCo92xf3pFM4foW54bm29Bz4oVINftiE7fSDEzi0vM3dNCmL/
    GgQExtP/y2l/Qjw+ec2/WIuR1ieOKep5k+5EsjmaBAjlMN1/QnMwrKWHR76RYfKT
    1r3/n5iUsvtZ+C29A9pmPgdSXfAP+MIptFSiYx7ngLVXGUNbPQ45JSuT2ztoIp45
    cvp/vQQCbgQuLpenrx2YkSq6dcfEvvofFByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476441; bh=wxSrdRoB3ROOPZDiHy6ZlqSCF3oi/q
    gRJgxAUFYpmDQ=; b=rEXF7O21fizhKcubYT8RNIQRCgDc5oHCX6k4SfcpnHL3dt
    2k1Mo0/3keBloybDWaYp8RctaDlgKtWeBVTTnYRYOHrFelMmxB5ip8oho0XMsPOh
    wzgCalCXh0Veinuj9VSNIZ3vLflgp4ZX5dDMP+2mtW0dicH3z4nI26psKud9fssy
    RsuFlM9/EXTdR1CMusTRyI/dxzM6KSqlI7vyL3HLBtEPJ83UKNoiNlYZwVbkX0+6
    K3wGiFX82aSFtSYrEHutBpagmAQcHdOWeWPoZGSFXE2qCtszHi2SzTMnJsHg/jZd
    n5QGRyRQDsp7bJ1zqPBaemO/2eT8l3GWM9/GOAqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfOWsZx88ujonEDiX48ZSKiSL8Q0KWKVLlGZuJlzUJPP8039AG/E0eRoXJRdDfXcPOZj0LQ2tnOuHtaW+axao8TjkT55PisinA1OmFtxUMXX2JW3n5GAf
    iJMFApvpLlyfs/WF5Ev7qGWwAi20h1QiV3JxWQibbCgOF2g/WQE+zsqNfSgJPHfpifAJfpcvkY8OgPwmuDKI8/wOCvxIdTUEAw9tAqba9VeFmCuNFqHkjVQt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=w2PZPm-n07mnuKwehRkA:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756484AbeDKS5v (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:57:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756478AbeDKS5t (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:57:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 119/310] i40iw: Fix sequence number for the first partial FPDU
Date: Wed, 11 Apr 2018 20:34:18 +0200
Message-Id: <20180411183627.281074731@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Shiraz Saleem <shiraz.saleem@intel.com>


[ Upstream commit df8b13a1b23356d01dfc4647a5629cdb0f4ce566 ]

Partial FPDU processing is broken as the sequence number
for the first partial FPDU is wrong due to incorrect
Q2 buffer offset. The offset should be 64 rather than 16.

Fixes: 786c6adb3a94 ("i40iw: add puda code")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/i40iw/i40iw_d.h    |    1 +
 drivers/infiniband/hw/i40iw/i40iw_puda.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/i40iw/i40iw_d.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_d.h
@@ -86,6 +86,7 @@
 #define RDMA_OPCODE_MASK        0x0f
 #define RDMA_READ_REQ_OPCODE    1
 #define Q2_BAD_FRAME_OFFSET     72
+#define Q2_FPSN_OFFSET          64
 #define CQE_MAJOR_DRV           0x8000
 
 #define I40IW_TERM_SENT 0x01
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.c
@@ -1320,7 +1320,7 @@ static void i40iw_ieq_handle_exception(s
 	u32 *hw_host_ctx = (u32 *)qp->hw_host_ctx;
 	u32 rcv_wnd = hw_host_ctx[23];
 	/* first partial seq # in q2 */
-	u32 fps = qp->q2_buf[16];
+	u32 fps = *(u32 *)(qp->q2_buf + Q2_FPSN_OFFSET);
 	struct list_head *rxlist = &pfpdu->rxlist;
 	struct list_head *plist;
 
