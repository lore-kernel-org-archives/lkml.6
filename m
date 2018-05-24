Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161189-2-14014423420298744918
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
    1527161189; b=dYfzLKYf+ocPCTlTh5a50sZoVnNzchxEEe7TbnzPCC+cZJNyxU
    fakmklJyQMUwGP/Ik4NhAMLnAVVj0gnGaKY9igcc8AtIj4jApC4UXFu1Y/j9ogkY
    T3qqjdzZmXDYvA3GdlnNrBN3viPEbVq5AERRXsJh8+3Dy2ERgoBEAW31TM/Nz2HE
    4/pf9cPCtu6c5QOuFVYQQIOD6gzW11aaXhEThmHCZq2l9I1jIBeJCMdH8ou12HC5
    G0IH/4/cBANaEJvVgTOyPIf6LMTNzbkpIHbWh9ha626QDZ9KTB3h/qoE2bzSLfvz
    mHVz2iLSvGS2G+ORdiiyH/aU77tsUFfxcDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161189; bh=BMs5DGlzUbByceHiZUIw3HGVICAsmr
    SBitLcP6PtMXA=; b=FKLUWFwrGBwiRmyQdHu3JfOovaWxHlQwezxwiFGHY/1tYA
    v9AFblroPNMl7959VFg3t9k2w94hb/OEKT/tzvswxDeBdGeMMX6N4Wb378501bH2
    Rzd00yde9eA+LJS0c0y4hcmUmYEC/DSwaOirGZHPDo3DmZad0B0RiNwil2SLH60m
    oG4H/tmfhOU6YkLKWns/iOv/2Xl/FQvVcQGa7NVte1TxRiP7aq4PhumoffgMEBGp
    AHxvRKFsJRTjR2CBMWdS2QdEgShEuYWggGxwZdT70fpjLYMBhC1FuKRXTzt0BYVD
    PlWs0SoiC0f1yAsPWAhR9Ryfsb4oW/rJvEzJDSuw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tFHjVFiR x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=tFHjVFiR x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGjMTwauLDzz+XemtDNzW8+nOV2vSmOIIjNd5Rn1OXSEIPyAQTr2iBtKy+cY+QWc7VX+oDXErBL8LNjwrqGCW4+wQ6sc9suvi28d+/ggyhu6RHAed3E6
    wmX+qNd3yKkzCvHkzEPPqgdi2vvUw8MhUJTYd3gITOcVqBctlQSSYZQTGP8A0YVFWJf40hY8kAdfYlUBEOFRTudyOoYx7hhzP6s4rl1mdR5XRWZTIHcOzhH5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=2p9LEKB4N3oWEMUFAacA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967731AbeEXJvf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967707AbeEXJvd (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 001/165] net: Fix a bug in removing queues from XPS map
Date: Thu, 24 May 2018 11:36:47 +0200
Message-Id: <20180524093622.035784561@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amritha Nambiar <amritha.nambiar@intel.com>

[ Upstream commit 6358d49ac23995fdfe157cc8747ab0f274d3954b ]

While removing queues from the XPS map, the individual CPU ID
alone was used to index the CPUs map, this should be changed to also
factor in the traffic class mapping for the CPU-to-queue lookup.

Fixes: 184c449f91fe ("net: Add support for XPS with QoS via traffic classes")
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2058,7 +2058,7 @@ static bool remove_xps_queue_cpu(struct
 		int i, j;
 
 		for (i = count, j = offset; i--; j++) {
-			if (!remove_xps_queue(dev_maps, cpu, j))
+			if (!remove_xps_queue(dev_maps, tci, j))
 				break;
 		}
 
