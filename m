Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2483311-1525767545-2-17067912382393756726
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
    1525767545; b=h1k3xDRK7EOYOOXlcfDrAbqjtRf/AoAPd/3l+HzF6lH18PHYS9
    ZWxlZagoAv5PuLcOqz5C+EqTCGsnJkHW229RDr7r2BJqKmySmyXseh2MgypDNBkW
    6gDOYDRQArZX++lJfqJhkbGrURJ8hcC9y5eg+KFbiHndbyd0mzhCpTEoYCno/M1d
    iPNKr7fcWFNyE72KXLNd9dWajf1qGjhif8Q62IJu3RcycyTrBx1DNMMUNgzzKJ3Z
    2MTi2/eO/S9cnQysB84wpPpMsKbZliXN4Yk9pqivpyBvKDe8JhJZjx3J7j2/oC3T
    ycxTZih7yrcGWDUmHCpmHyfUkUqdJMY6RT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525767545; bh=nGTzBhLwv7uOn5JTomd7q9NPWvdpQd
    xwIEs+aZDKPp0=; b=aaVfotjqsFTFVU0okeRHVWPThXpqfzv8rTs3VB+y1Caxg7
    P7BEj3O//VCc/SIRDoMi4/nqOXBNY5xUkCYFHr3mc3ZXOsDgSLpvb9Hf+U4gRMQi
    NyXwOtq+8Vq8MtgjOJOshDTSKNdm7H0NC3x4DaNLhy6c8DtNdBVASyLfXLyr8sgi
    qk1Nr9rieyUrjSFn/MDcHYRyhXoWyXQ60tCkWBRtRtos+2VBnr6R4+dfy/FKjlBJ
    lWpwtIVJPIB71nI+vYbgAWwOjkZThAdOq6eHx5u+Jm8vQ29W5u0IoOYAYYDkwm+M
    wKim5Fct8C7S1udZKPCRkLO0i7WB1JReblfhPzfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=tHUzfgC8 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=tHUzfgC8 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOmDoNqCRitFrOSlEK1pOFFL+d3SyR7LJPqblkojkmtqHFmdCNIi7mUB1nhJ7YoyRzXZhyVbcB/gXVlwPySLXFxwPckctsyiITp/6K4w3XFCzJIbH/Pa
    yZlSdFqdT7TihK2C8G2YWmu+0xko7SKJlk8ZVPuinVxs0YE0VPhrLxIsFz/6YynHTHgHbDfO4FZjmzD0tjmM92IGC5SZppdHyFGq874hQPDaHnZymKYzNjLG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=ljRKxemVoM8RlQu1PiUA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeEHISE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 04:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932999AbeEHISD (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 04:18:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 32/32] s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT
Date: Tue,  8 May 2018 10:11:12 +0200
Message-Id: <20180508074013.907510255@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
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

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit 6f5165e864d240d15675cc2fb5a369d57e1f60d0 upstream.

Use the actual size of the facility list array within the lowcore
structure for the MAX_FACILITY_BIT define instead of a comment which
states what this is good for. This makes it a bit harder to break
things.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/include/asm/facility.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/facility.h
+++ b/arch/s390/include/asm/facility.h
@@ -15,7 +15,7 @@
 #include <linux/preempt.h>
 #include <asm/lowcore.h>
 
-#define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */
+#define MAX_FACILITY_BIT (sizeof(((struct lowcore *)0)->stfle_fac_list) * 8)
 
 static inline void __set_facility(unsigned long nr, void *facilities)
 {
