Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1859598-1526967066-2-12470688492631923363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526967065; b=Rc9Xii65tiarr2yfIghB1CKdnSCXomBRMshg0jgsEq2FY9EWMf
    VoZXu56mVsvlpkx1NMzQhHW7Pu36pY+1n+cEHVOlgk8z24ptU0gTI+7O18i6+UIU
    daYggzHjf5+uCxIOqyiHuU3J9dLfiY5cNU8ZsWcbhhvNmNd5qSL98y0Obl9IqzlS
    9ga5B4p58SI0Quo/B55JHoM2mAzxzfoE6ECqQe3ymUaa4WmtciuctmMY/at9tZI6
    I4UPweWexk09kuJ7yEyYXpZmSvbNn2PqZc0ThoixVUdmRUUA2u190+QbdLcLK8EL
    0dwITEGbW/q/2BIYb5OPEQL+05L1/iVYuVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526967065; bh=j0yF48yZ7m5BsYIPFlKj/rduPA/ILD
    PPnU5zgz3Clds=; b=MaHULOTxVqyky9vruzOTEJQoQbSQ/3YdEOz3Yq/fNmWe7b
    ItWz4nleL+EWgZC6HQk/eY5EE72uEw9h9Vns5bViYZ8cQ4zGtxPU461PDn05uuP4
    Iklx5/FP+DfRvwthDxbxN3oKIIvpGUKlhZbZ7G875YtLRAFIGpTEjAuqQBHTYrzE
    jR7VyxoyTp78Y7zrbPynvfgYVKPkEWzVBNQPgl3iTnQB35r7wCvAOYjIxxVxDIN0
    8E+mBRmGTpjzKvggSvXr4FHOEfKCt5yBYzCNnf0SM/o68YDehwWfuoC/LEWhjnGi
    o/krPk4SuSvU7BjctN020r17EM7AbaET7rshWZJg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=2Hbu1x10 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=2Hbu1x10 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLRGgLOSN5p8Ttd7r7VTgHwwssK7nbM4pbh2fLO9i1leTmXrvOArDbD2TkDxL60sFJo8o7MdZNH2teuPnfaLYUYXw1FgCq1j1x7YnuLTEPCW7k1U1Duz
    O4u0/euSsInInmgNDM3CpBYLb4UEaEM6GTIAnqV0qupJBRtDc7lzhZKzBfAqv6xHRp5vaw/lujptDQslQMbpAPLUN1jgMsX6FDiqTgl++ShgpBl2XCvXY1r7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xjQjg--fAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=oPBFecwIsE1NewbdIycA:9 a=QEXdDO2ut3YA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeEVFax (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 01:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751039AbeEVFas (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 01:30:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Monakov <amonakov@ispras.ru>,
        Ben Gardner <gardner.ben@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.14 21/95] i2c: designware: fix poll-after-enable regression
Date: Mon, 21 May 2018 23:11:11 +0200
Message-Id: <20180521210452.394569412@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
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

From: Alexander Monakov <amonakov@ispras.ru>

commit 06cb616b1bca7080824acfedb3d4c898e7a64836 upstream.

Not all revisions of DW I2C controller implement the enable status register.
On platforms where that's the case (e.g. BG2CD and SPEAr ARM SoCs), waiting
for enable will time out as reading the unimplemented register yields zero.

It was observed that reading the IC_ENABLE_STATUS register once suffices to
avoid getting it stuck on Bay Trail hardware, so replace polling with one
dummy read of the register.

Fixes: fba4adbbf670 ("i2c: designware: must wait for enable")
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Tested-by: Ben Gardner <gardner.ben@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-designware-master.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -207,7 +207,10 @@ static void i2c_dw_xfer_init(struct dw_i
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
-	__i2c_dw_enable_and_wait(dev, true);
+	__i2c_dw_enable(dev, true);
+
+	/* Dummy read to avoid the register getting stuck on Bay Trail */
+	dw_readl(dev, DW_IC_ENABLE_STATUS);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
