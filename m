Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116568-2-9766201798846008399
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
    1525116567; b=hl5mei0KyO4vTcg3+ZijnecxXWpnrWAFR9Dzov9cspHyXJGteM
    0ZvdyTfslUgq7vHTbJo+xme8SFgsKTSUc2ZrqCycOpa/uM7BCd+9ObrNLX6sDarZ
    AzRsdjKQTBcbSgQKlCzzsC8zK15h5bTHGhQBFbPKOhR/RrjTN2bTfXc6Y8AEX7FS
    +tiaFSMP8yjt243BhG1KDwSg+CKCK4HfbVfBEhpoT7W7E4zxz8OYIwHN/vOTfAdf
    AA3VzUNvZd//FhMJpY8wAIL283FHQp4CdIHFiKXl4VdEHGT0unSkBCVDnJVmqJhl
    S26Fy1tWqiREPUVJV7tjqx0z9IMx20KUyLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116567; bh=Q1q9vkbGNj2f4zuwYEg+gzsgjFdEeT
    1CTGhqLoVha3g=; b=TGtcB72NLhQ8rEiUUkZN14ppBWjFkGY+2kScRlucs4NPjw
    uz55N93CBjhXgqMgYCOjDIGQLMb70nqdvDW4A3ufr9isnsGFQWwcNO7obzXQJkKm
    8Xl7lbMBHzFS8oCBqyu0Z1ctLHsyUgH1JUBJxvZXB7uJb3Q9s2Yk1JeK8wARGCBB
    ORf7cX8ocuFOEe9hkuCxxmJFLkh7al6xIlNZZPuLHY3ZO1aAwZKt9pzOn/HeDzfy
    R/VEkzPrOigxY3B42U8OgMl9YRCkHMb+pGUDkT8aC+IAFtQyTqSNCZ0jNDwmt0SW
    /mMv2e6Zm+bWNes+T38VM3Kee5MtR4cX78VmkHSw==
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
X-CM-Envelope: MS4wfHuBPM3PAfT4trIjGpL7s5C/rXBiNUO7BWcpSasltX6RmoqPaMbugocsoQjdit1YD9pOjsfNZ6eHTZHSbrWyRptaHBY2v4K4sEYM4J9uRImNyAhpEhVf
    SC1wyElgY0aAm/jiq6WYZ/nr5SLBtpGr6FaGQaeXMc3BOlCuPfCu7IecFKmWxRi61ABqWHOvXgUXh4bI9GorMWq/rzbYn+cqU7l3SZAg04fcPTsTxdYCmN8E
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zd2uoN0lAAAA:8 a=YatG4K_qAAAA:8 a=VwQbUJbxAAAA:8 a=FNyBlpCuAAAA:8
    a=ag1SF4gXAAAA:8 a=2y8Fos5g4jp9JmgFTwgA:9 a=QEXdDO2ut3YA:10
    a=C-oqSJdmBX7V3poY1tIN:22 a=AjGcO6oz07-iQ99wixmX:22 a=RlW-AWeGUCXs_Nkyno-6:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932480AbeD3T3E (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932458AbeD3T3B (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:29:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BF922DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Paulian Bogdan Marinca <paulian@marinca.net>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary R Hook <gary.hook@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.16 112/113] crypto: ccp - add check to get PSP master only when PSP is detected
Date: Mon, 30 Apr 2018 12:25:23 -0700
Message-Id: <20180430184019.919215109@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brijesh Singh <brijesh.singh@amd.com>

commit 716c7c32eae4b8a45c4f5602b50453865929b670 upstream.

Paulian reported the below kernel crash on Ryzen 5 system:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000073
RIP: 0010:.LC0+0x41f/0xa00
RSP: 0018:ffffa9968003bdd0 EFLAGS: 00010002
RAX: ffffffffb113b130 RBX: 0000000000000000 RCX: 00000000000005a7
RDX: 00000000000000ff RSI: ffff8b46dee651a0 RDI: ffffffffb1bd617c
RBP: 0000000000000246 R08: 00000000000251a0 R09: 0000000000000000
R10: ffffd81f11a38200 R11: ffff8b52e8e0a161 R12: ffffffffb19db220
R13: 0000000000000007 R14: ffffffffb17e4888 R15: 5dccd7affc30a31e
FS:  0000000000000000(0000) GS:ffff8b46dee40000(0000) knlGS:0000000000000000
CR2: 0000000000000073 CR3: 000080128120a000 CR4: 00000000003406e0
Call Trace:
 ? sp_get_psp_master_device+0x56/0x80
 ? map_properties+0x540/0x540
 ? psp_pci_init+0x20/0xe0
 ? map_properties+0x540/0x540
 ? sp_mod_init+0x16/0x1a
 ? do_one_initcall+0x4b/0x190
 ? kernel_init_freeable+0x19b/0x23c
 ? rest_init+0xb0/0xb0
 ? kernel_init+0xa/0x100
 ? ret_from_fork+0x22/0x40

Since Ryzen does not support PSP/SEV firmware hence i->psp_data will
NULL in all sp instances. In those cases, 'i' will point to the
list head after list_for_each_entry(). Dereferencing the head will
cause kernel crash.

Add check to call get master device only when PSP/SEV is detected.

Reported-by: Paulian Bogdan Marinca <paulian@marinca.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
CC: Gary R Hook <gary.hook@amd.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/sp-dev.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -252,12 +252,12 @@ struct sp_device *sp_get_psp_master_devi
 		goto unlock;
 
 	list_for_each_entry(i, &sp_units, entry) {
-		if (i->psp_data)
+		if (i->psp_data && i->get_psp_master_device) {
+			ret = i->get_psp_master_device();
 			break;
+		}
 	}
 
-	if (i->get_psp_master_device)
-		ret = i->get_psp_master_device();
 unlock:
 	write_unlock_irqrestore(&sp_unit_lock, flags);
 	return ret;
