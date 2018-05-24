Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155758-2-2402222476535438955
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
    1527155757; b=L/husWY2uHl5McIB0TJf1R4rS+a2dWuIEPgRIYF60KzQiDL0ig
    4qhTSUQWdoIImbvuXN26KSiNIfCe0D6tp8BQRxYj5RigMifCPBRfcn4CBNeYKmHA
    fEyMEteQbNhc6Z7+r6IGqiOdQt45N955s7Dtq92NwXN+zqBueDzy/bO0BBTCRkCV
    PDVDbCeN69e+zBGzM6Z1h9kJGIM96fbHH3NcsqmzyoSNemQi6jn+EublUDW+ZqMU
    2FtEnrZaQEAB5yb+vgHnIN3HFImQKrsYg29pZkRLe0D6k+AJem952lJwTKmSj3gU
    j6LmFyg796jGT+G9NESj5TvI5xl4tqZr4wZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155757; bh=Hou3ddALr4QQVeYo3CyBvaeySWC2Zf
    gSu5wcy+1d++4=; b=S4j7+pbYTdP8G7B3j11usrC9xFGIGdW2Hq5y66R9kqhtzK
    e766ymEIb0nKshs5+9w0xuEZ78iyKVvQBrC8IViun7buSTOg4/AKKZwLczfSdf9/
    iAd66e6alkdDgaY6dBu7CXbyBVq139o+D8up6z7ZTSbSnz/YYFMHS0+IEEtyxjQY
    dOA1TBT7FD4yZsiQ37vw3MeNmm9FY2fWgwpyAKP/gS5bUiMzFfZfmGJqVshiFlYG
    jHv/5LHyp2VKRKl1YaYKYnKrT5MzuoS6i7FwSPKnJqByz210puQvdUzK/yZuKpt3
    6su5tM30kKEVh3qXNzY5lBsYITcrkCWpk2EP3OHw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=d95VygIX x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=d95VygIX x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFhr9KQgxIf1LyyJ1OVmYa+4FNDVkL4AupdMC73eaGakxomEsNJfcptLBH0PXinvEoOF8gDQv5O9+Sk5AKmitGFQlytIihZN4uwfQiaUSIXm9//Ot4An
    Mfynsq0f7cGXt1lo83hVeT6vTfIm7paAB/GNltPFZxcarl21iRlndVbTPWZnNDPY82Jlds2EiOfLJjlVL8ymNURLvPZYF8vjz3BQk5EKlm9giZv+YRfBuc6b
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=x3GXP8Dy4zAY1LmwQykA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030214AbeEXJzy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030206AbeEXJzv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 103/165] scsi: sym53c8xx_2: iterator underflow in sym_getsync()
Date: Thu, 24 May 2018 11:38:29 +0200
Message-Id: <20180524093626.183969575@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e6f791d95313c85f3dd4a26141e28e50ae9aa0ae ]

We wanted to exit the loop with "div" set to zero, but instead, if we
don't hit the break then "div" is -1 when we finish the loop.  It leads
to an array underflow a few lines later.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Acked-by: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -536,7 +536,7 @@ sym_getsync(struct sym_hcb *np, u_char d
 	 *  Look for the greatest clock divisor that allows an 
 	 *  input speed faster than the period.
 	 */
-	while (div-- > 0)
+	while (--div > 0)
 		if (kpc >= (div_10M[div] << 2)) break;
 
 	/*
