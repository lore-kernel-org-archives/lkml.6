Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161820-2-15194583759969617097
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
    1527161819; b=MQgYlgGDacnIxZrxlFG6ow6oOSnFBLfx7kfQ4RKvnk60HnmGIS
    JU5kCx7Ti5KTgt9t0oeLaE+a8kJRBnMJiH5IWSxjZey4mol8Iz0OO5it3iS/HBSd
    Ia+wGt5phZGgiIxTKWF8erDbNEdVc13zKEQBdj83VdkQZW7JcrfwwRUBL924LK/l
    fNr2rl0qKCsNjwDWv5DVtEuHaUdJcIQ01PhhXMyWLrLl+o2w1IlYcEwkUK1+f4AN
    9c+HqDuVw3MYcKBsgYEmkGu//4Hgy6hYjlBjITEKgeEsUflSTPIUnxI2fzsAMkMb
    +64KuTBnIKVuiKQo2lZCZR5lG0RcP9hlzqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161819; bh=ML0/HXVcnq6V/l4y82ocu/w9ttSmro
    g05Bv41Tbufbo=; b=eNQE/qq4msj68IrwOLDqivmh5nH5jB4cmiyChitzyrX4Ue
    PCg4Hui47TqloQKoXSSFM1zEVKiaEaaWIIk2MrfaP0gpRJv+bWfDFyOmfF7cy7+H
    XW28npR5+rS757guCSlHYC0Wp4tKRJYVCfU1LjE0TVt0XSixwjDkG8Cnk6lc5cxs
    C8x+0ld4tKV1MIhxdcOYPkmIB3ncDs7R1mdjedKTbm1GNNcEqR/hf6rSE5naLJkZ
    ZPgNB/mrWJfzNarjlHfWyHF6RuVuedxjdNURfK2Qj4M95SCDv1SyazOvf+nmot62
    88jMZCzpMeAFyIwWRf91fxqr4TEKA5TCiq8qWTEw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IBesWQ+I x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=IBesWQ+I x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOaC6w4vehTvPeo7xJMZxgbFdn+ot2DF2k/8LMDtjpMEFJQ3P+bHocFCZMXIA2gljJsRR6n9j3htlMn4y8bJd51bcozVzlqkYOELoRhNrzrV2JgrQpPp
    Bv2kdkOC1TOj5JTf3S1DNRiDdt/BAQjGYF2ODj7TBJepvDiQXnHfEzkV6zxJH4oT5I4x0rZcr44FQCu9vU86tkRNU0mc6pfN3yjIbFzDo8g9ykSeeh6i1dHk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=J7S8MM_AAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=-45MtewHlfGo5sSz67IA:9
    a=QEXdDO2ut3YA:10 a=Mc_7STxokkYwVi4MloDe:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966961AbeEXLg4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967421AbeEXJtj (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fredrik Noring <noring@nocrew.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 31/96] USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM
Date: Thu, 24 May 2018 11:38:14 +0200
Message-Id: <20180524093607.335454929@linuxfoundation.org>
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

From: Fredrik Noring <noring@nocrew.org>

[ Upstream commit d6c931ea32dc08ac2665bb5f009f9c40ad1bbdb3 ]

Scatter-gather needs to be disabled when using dma_declare_coherent_memory
and HCD_LOCAL_MEM. Andrea Righi made the equivalent fix for EHCI drivers
in commit 4307a28eb01284 "USB: EHCI: fix NULL pointer dererence in HCDs
that use HCD_LOCAL_MEM".

The following NULL pointer WARN_ON_ONCE triggered with OHCI drivers:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 49 at drivers/usb/core/hcd.c:1379 hcd_alloc_coherent+0x4c/0xc8
Modules linked in:
CPU: 0 PID: 49 Comm: usb-storage Not tainted 4.15.0+ #1014
Stack : 00000000 00000000 805a78d2 0000003a 81f5c2cc 8053d367 804d77fc 00000031
        805a3a08 00000563 81ee9400 805a0000 00000000 10058c00 81f61b10 805c0000
        00000000 00000000 805a0000 00d9038e 00000004 803ee818 00000006 312e3420
        805c0000 00000000 00000073 81f61958 00000000 00000000 802eb380 804fd538
        00000009 00000563 81ee9400 805a0000 00000002 80056148 00000000 805a0000
        ...
Call Trace:
[<578af360>] show_stack+0x74/0x104
[<2f3702c6>] __warn+0x118/0x120
[<ae93fc9e>] warn_slowpath_null+0x44/0x58
[<a891a517>] hcd_alloc_coherent+0x4c/0xc8
[<3578fa36>] usb_hcd_map_urb_for_dma+0x4d8/0x534
[<110bc94c>] usb_hcd_submit_urb+0x82c/0x834
[<02eb5baf>] usb_sg_wait+0x14c/0x1a0
[<ccd09e85>] usb_stor_bulk_transfer_sglist.part.1+0xac/0x124
[<87a5c34c>] usb_stor_bulk_srb+0x40/0x60
[<ff1792ac>] usb_stor_Bulk_transport+0x160/0x37c
[<b9e2709c>] usb_stor_invoke_transport+0x3c/0x500
[<004754f4>] usb_stor_control_thread+0x258/0x28c
[<22edf42e>] kthread+0x134/0x13c
[<a419ffd0>] ret_from_kernel_thread+0x14/0x1c
---[ end trace bcdb825805eefdcc ]---

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>


Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-hcd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -446,7 +446,8 @@ static int ohci_init (struct ohci_hcd *o
 	struct usb_hcd *hcd = ohci_to_hcd(ohci);
 
 	/* Accept arbitrarily long scatter-gather lists */
-	hcd->self.sg_tablesize = ~0;
+	if (!(hcd->driver->flags & HCD_LOCAL_MEM))
+		hcd->self.sg_tablesize = ~0;
 
 	if (distrust_firmware)
 		ohci->flags |= OHCI_QUIRK_HUB_POWER;
