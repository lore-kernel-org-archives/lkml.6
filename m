Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805478-5-232671726125300508
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805478; b=xFaqQIO1WG6eAnTSG9twTyjZrWKH4DiAlRuKtU7MRrvnx0S
    Li3btc5iKroPbKCerWzFRkYHl8nnsODp6NdyAke/F2TAH48moa81yYG8oiTQlNpv
    KWo/bqNAvmnHjLbZZMc8aYYwL2aqmdB+r5Bqk7ZzWuGY03j2Y8gciY1hH/cE8KcD
    fmjCENQb96I8P68dVFoeYabgEiqf2NP15/LUOUSrC7ccXW+NX2dkceocScFR1hVO
    8Az1dWXpVDpAn6ZQVeCMcD8bxVOqckzm2NekPdrzVxS0RnjDM1bFCv8MC/i6bb3P
    4s4y6X2V70zqbpYZYFkLEhFNbgb+TWashbsSXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805478; bh=EEx73/fgYTirCnjZEyaqzbmrjs
    GUHQ4fDhzgJFGH6KE=; b=O1OGLwbr4YOt4eYQ7RtLtCFhgMrePA/HPj2FqxerB4
    gZ6jrBFn2Y9T2xV3/33hILYnF0B6swf45YQZkYeYXekDaYTBrqqZeXxOQXoQ/Qx/
    YEhoVRXFYbpfQ3CuJNQr5gilbt39aLdKsiKhBJ278EbmLO+GZh/CTYy/dJPx4uru
    EjBxZ0uJMOdq//hXbRyoK3WV3XhKCr9HL8LMKxaS+bA7UDbrJ79vzeaA4NMkf9DU
    WRwfS0hvtfeYtGXrQ0ETyjuIe1c0cKMF/wlIZqSwV9vF+UGNerg0xbqFCQc5/KwW
    GHfcLE6E0wyn6oukub8hgb4YwmYrkxXleLTcNBbHERyw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeCWKDY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:03:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753983AbeCWKDW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 46/77] PCI: endpoint: Fix find_first_zero_bit() usage
Date: Fri, 23 Mar 2018 10:54:20 +0100
Message-Id: <20180323094145.353322114@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Niklas Cassel <niklas.cassel@axis.com>


[ Upstream commit 35ad61921f495ee14915d185de79478c1737b4da ]

find_first_zero_bit()'s parameter 'size' is defined in bits,
not in bytes.

Calling find_first_zero_bit() with the wrong size unit
will lead to insidious bugs.

Fix this by calling find_first_zero_bit() with size BITS_PER_LONG,
rather than sizeof() and add missing find_first_zero_bit() return
handling.

Fixes: d74679911610 ("PCI: endpoint: Introduce configfs entry for configuring EP functions")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -109,7 +109,10 @@ static int pci_epc_epf_link(struct confi
 		goto err_add_epf;
 
 	func_no = find_first_zero_bit(&epc_group->function_num_map,
-				      sizeof(epc_group->function_num_map));
+				      BITS_PER_LONG);
+	if (func_no >= BITS_PER_LONG)
+		return -EINVAL;
+
 	set_bit(func_no, &epc_group->function_num_map);
 	epf->func_no = func_no;
 
