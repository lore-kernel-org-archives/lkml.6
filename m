Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524405943-2-17436976030979562808
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
    1524405942; b=GEXnMb1GkwV9i5dh6Aq+vDP3hAH8TpUt6+6wXsSQUQWlPc0hqy
    KcuHcaFvPPv1akLcbbM3gHTMBYsS3i3nvhHp1ibHHrSbyU+WkPCgZNnVOzA1ctf7
    FpTiZi5GZQULblga8BQKQ99P9Lmf9p1hgp/+D1pLcaH/aCG8c34FKMZD2o1Ugpwu
    bfzQ8Aza0kQIxoobZwl3gK+meiVS8CgL1A48vuhwn6iPgrzFAEAVgQWqvfhiVvpo
    uSJCGR0cIvBIATGV9s9jWIKy3A2V7+SB9UXbcewyl5tgpYHuP55gCNI6SAXgqFKj
    hzPebqRgmVIfOS79PkvD6hbxFJM4rcVj+ODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405942; bh=2i1bBYtHdx/QYm1/J6OX3VaBGMFViK
    SMxAMsPGYOLBM=; b=lcCEQbXFKSC7pH0hlF56nAcDpY1yIjdlt6pNdeChzC60g9
    NTGmkLuzUODp5MpQZD4ef2Pn4GECCkjBb+FzLrdXmsHLNyJwKBuXn/urpMU6lrPX
    GF+oQlE7oW97Nfna90NLza1bL5+2py0OjeLgID9CBL7iQjACrazssvLpaMVB7f7a
    6dwNUNewiqWZl4LVBxeV21iYzBWqhcrLZs0XZK0ljFpMz6b39bhsxrCk53kEz1Td
    hd4e6Qgb9zjw9BJnNaV1OfGsr37eVmq7+OaKNi1LKvhDUDAgQfzAjGJTo/JkQGAc
    KxsnLcs7BVNFIrNfpQOPUyW1Ps+bKQ1ScJnZefgA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfBX3NC0hoRiyfr7HJPAw6G01H3UBQCKQ1+rX/zyaRfyQ+KpAn76vwT/SRNob5Dv01inxt0/k4aZ7mbrC2QqWaDJrE42J5pbYG6LwhB/38piABL7waAQx
    ObRfHoSsQkEc+9vkPhaDbaqFxItZBZEBLhDueoElZAgCihnoQwMvrwmxE9nkEF1zuSUOoQltGqmvH6EcXRzj3kTNqgY081iyMoKQQIOuhefKTqh+M8Zm9xm3
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8
    a=waIFDghFA1IxNhTx7kcA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755410AbeDVOFh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:05:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50888 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755395AbeDVOFd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:05:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
        Stewart Smith <stewart@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 051/164] powerpc/powernv: Handle unknown OPAL errors in opal_nvram_write()
Date: Sun, 22 Apr 2018 15:51:58 +0200
Message-Id: <20180422135137.490401206@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Nicholas Piggin <npiggin@gmail.com>

commit 741de617661794246f84a21a02fc5e327bffc9ad upstream.

opal_nvram_write currently just assumes success if it encounters an
error other than OPAL_BUSY or OPAL_BUSY_EVENT. Have it return -EIO
on other errors instead.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Acked-by: Stewart Smith <stewart@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -59,6 +59,10 @@ static ssize_t opal_nvram_write(char *bu
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 	}
+
+	if (rc)
+		return -EIO;
+
 	*index += count;
 	return count;
 }
