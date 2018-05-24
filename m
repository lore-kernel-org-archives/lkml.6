Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155411-2-10159185969049517707
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
    1527155410; b=UutvrLtqheUrrW4Duh7+s48+pV7lhJLUptXIR/ljrT9TLayZ2d
    F4QRkS3VX2undgJd8atgzZ7LNp/UsvthkkkVhVJhN9LoRmpxu8+qn3gqAtF0UPih
    S0oI163K7xHEQ48upuMEgaqxQQdUJrxTmC7t3p/E+nMkYfqM7rSiHQ/ACvy+BpfW
    aVaMn5GhnNMBPT9fsL4e7eVSByZjyZlBnqQrGUmY/nbOOQi8C11MRd/krmtq5tR6
    2NKq+zJNd8TD7nob5CBrzEXf42wAkZ5RBjwI+R213RhX0uLnCMZuhukjVJUpdtLj
    xRa3Qy0JM0ivb2tBiu2sL+GVkxqCDVAB009A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155410; bh=e31f9iYSMbkHPzXT516yETriYyWOgi
    TtHyDy5jSGjEQ=; b=GL3fImUaSWcTYC2Cn+E1NRfhVcCmaUaE+dQPq59hemacHX
    QzJsrel5MemGk8FkJD/B/aUf+URBijsQOAhomeyDn4FNfG3svo77WPGMMDwQhCOu
    5NOdZW+lChsQezuCPxdx/mCB2B/pFYmrevrrfoITUMUih4p6RqSBQRwlWe5JYIdr
    Zy29ATQdGujtYk0RJvSOBUu45pxJ3wGFFz6stgtyHNQYh9rFgSGp1FyUHEmOvHxU
    EfszIyPGfhCvOdGvy47rQLuhj+BoiSd0T6hYp7W6fuv7yRRUHgPgsSOUiJczArA1
    7yvP5jPTC/P4KxX/OnBeIEdCC2G2tS8UA9QWy+XA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dzJj5+yw x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=dzJj5+yw x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIWWe6RAW46aST8JnDzTqaCid3fxpEBazpELzruaGIaRTch3FQGUtNAeW9zy6mx+2xXPOrWwBIAZFkHROaWqEonWaxnzAhKDZ2s6lZWwUv+5RjAavvRO
    VivTLNe3NXd9ld12BKeNDMID3/N8hxeYZMCL3PI2sMil1kFBydEgXvU0V9qLtv49eDtxSErFySuofQ8/F/YGxRzKTpImeT8VUyQBaVZPMASj3DG/xC3HtPQl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=gV9ZC5vI7Yc8r_rdcxcA:9
    a=QEXdDO2ut3YA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967496AbeEXJuH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967462AbeEXJuF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 74/96] clk: rockchip: Prevent calculating mmc phase if clock rate is zero
Date: Thu, 24 May 2018 11:38:57 +0200
Message-Id: <20180524093609.638446128@linuxfoundation.org>
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

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 4bf59902b50012b1dddeeaa23b217d9c4956cdda ]

The MMC sample and drv clock for rockchip platforms are derived from
the bus clock output to the MMC/SDIO card. So it should never happens
that the clk rate is zero given it should inherits the clock rate from
its parent. If something goes wrong and makes the clock rate to be zero,
the calculation would be wrong but may still make the mmc tuning process
work luckily. However it makes people harder to debug when the following
data transfer is unstable.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk-mmc-phase.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -58,6 +58,12 @@ static int rockchip_mmc_get_phase(struct
 	u16 degrees;
 	u32 delay_num = 0;
 
+	/* See the comment for rockchip_mmc_set_phase below */
+	if (!rate) {
+		pr_err("%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
 	raw_value = readl(mmc_clock->reg) >> (mmc_clock->shift);
 
 	degrees = (raw_value & ROCKCHIP_MMC_DEGREE_MASK) * 90;
@@ -84,6 +90,23 @@ static int rockchip_mmc_set_phase(struct
 	u32 raw_value;
 	u32 delay;
 
+	/*
+	 * The below calculation is based on the output clock from
+	 * MMC host to the card, which expects the phase clock inherits
+	 * the clock rate from its parent, namely the output clock
+	 * provider of MMC host. However, things may go wrong if
+	 * (1) It is orphan.
+	 * (2) It is assigned to the wrong parent.
+	 *
+	 * This check help debug the case (1), which seems to be the
+	 * most likely problem we often face and which makes it difficult
+	 * for people to debug unstable mmc tuning results.
+	 */
+	if (!rate) {
+		pr_err("%s: invalid clk rate\n", __func__);
+		return -EINVAL;
+	}
+
 	nineties = degrees / 90;
 	remainder = (degrees % 90);
 
