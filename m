Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161287-2-3412610717116990003
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
    1527161287; b=hZ5CGMmc0iumNEQKq9MvyABEnsEXw2+1ydPLOje8NsTdqBSmL2
    eA7kRSS/U6SHi3LSuZ6lIO0WydJn7UpIoi8vxkQtrwqwEI/ng2oLoP4n+ogjNdCX
    Or9ZveAICJuc88HC2dwCqHMcTp5x1XyxytGN4zTEzrKGZBtCZ6Lc3p8s0M2sGzQp
    IMSqo83p5YUkkiuiUk8r8Cinb9CItBBkZuzCFYiib6rNvRroVNITQPIzfkQg661q
    Tq3ov5PAlzqDKZfmkMHxActVDFajxmBo/6GhvUZf1UjBQsa+d2BYCPxR+aA/BelK
    5Wx7nHmQdz+3Cng9/3+tt6dMk0PtQq15PUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161287; bh=XIeyi1lFw1C1f2MbnLPCqi/82IDgrf
    jKQJ7xBiw3Uq0=; b=ggIODH2VpcK5En37N4PRbReQb32hCpVPks8IyQVSS5bA3Q
    Rkv1iLGrymEl4QyKX+ibXFo0+c0dxerp6N9ImgNFGrRJs0s8cpi7RfassKK+8Alr
    PcnFWFP6iYhXXISyAOXZADsJP8lZHD5R9/Hz1XnSPiMgb4yQC337ycLFs29dUC7s
    w+UViVl9TZ6pTdQ0WmNvShgIn5k5QRxXXK0jbzPms0P7FZ7tT2FwdqIO3ULZdTq9
    qWcjUhEWM5bXRVdMAeSXZG+nAURTT44G6x73jbw3On0UfRDM/FCP7S/RnQI8KzFo
    NJbQCHHd5tT9/EvDmZpgKLSxot56M1/FniZ211SQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sv86i0X3 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sv86i0X3 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCqOofh75mSs0u7G2D/bPH6BRPbyDuh3Ei44GOT5by5CL5T2naz4k5b/5vBoIk0hRGZwBaFCE5oAXl3k3IviKiDeMC7+M3YC3DlH1BM+j3DnKda4Bjx2
    hrs5yHFCj5/EPq+dPBeMKXg41FWvrQAwUpeoSSTRc1DmyZ/ovMStW0/ZnfSygUoNpqzfuwTlD/J8qR62tYote3AllBbmAFWR4gdOk36Sk5eeQJdpYC+n91hP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=TCZwIYwWp4WjhJQ2Fw4A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968890AbeEXL2D (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:28:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967383AbeEXJvY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 67/96] ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()
Date: Thu, 24 May 2018 11:38:50 +0200
Message-Id: <20180524093609.279067444@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 123af9043e93cb6f235207d260d50f832cdb5439 ]

The loop timeout doesn't work because it's a post op and ends with "tmo"
set to -1.  I changed it from a post-op to a pre-op and I changed the
initial the starting value from 5 to 6 so we still iterate 5 times.  I
left the other as it was because it's a large number.

Fixes: b3c70c9ea62a ("ASoC: Alchemy AC97C/I2SC audio support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/au1x/ac97c.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -91,8 +91,8 @@ static unsigned short au1xac97c_ac97_rea
 	do {
 		mutex_lock(&ctx->lock);
 
-		tmo = 5;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		tmo = 6;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			udelay(21);	/* wait an ac97 frame time */
 		if (!tmo) {
 			pr_debug("ac97rd timeout #1\n");
@@ -105,7 +105,7 @@ static unsigned short au1xac97c_ac97_rea
 		 * poll, Forrest, poll...
 		 */
 		tmo = 0x10000;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			asm volatile ("nop");
 		data = RD(ctx, AC97_CMDRESP);
 
