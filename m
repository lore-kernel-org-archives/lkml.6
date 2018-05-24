Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159819-2-13814704203329648886
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
    1527159818; b=AfMkhyQg6l+JevTfpOpWMYkuXgVh+MFNQAq6Ll7JpD4L4LNnXW
    kDZeSxIo+6y6ONz96IKQwUPwx+1e/SRjwoeoAg4TR/0fSrUSjGLwzqTPuw6dUZRZ
    /a/lC6HFV04gOapM29xx55uLTph8LBzVPL73Mmzfo50J3hKqlDDRw9fN8L6VyIyx
    WYw1miY+nhO6xp9UD92CMvl+GBsfQk8rKGi/js4AVjBkaxY+Ouf7eneAE1YLuGGu
    cg+TbIVqNfkhOSO2vtR05mC6t59iG1Y3Yr5IT0bthdZNtGTRhUhiMMG3C1tJ74ra
    tYEOqGEYHlsAdDF2lwG6ArcfzEyTMx6Ykfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159818; bh=nbWVlEK305dyQKLH2eFoeiM524bMRs
    3buYF0GfBrSsg=; b=XsJkQx6XMMn3VuJqtteRHPFNBx9dDAwDXXFYr9t4ebVnGE
    9YBzZfAKfkBCyDTVTbHz1FJUhC7HLrq6WTlZYNLGtrD1crXaHMegh8sRuxNULqyE
    YYcRrCk+gePdDSUQd/X3aUZKpwbKxeWA4tRJCen1hwPiBZAgdy1bCjBsQcJ1Enoc
    A3W3jzl1hMVhPh8+73M5Qs+02NElAb0q5hOmQTHhd4xzwQ8IoJYuCDHocIiLfUvr
    N62DO60K4xobsI4I5wp8jii6jCDI56NxQCJ8hprMlTYdJaXYJ5JULwlIxyTlS95V
    U/42CfCXY5Ywyl4JoYUUlxZ1A5AmzNLYqZgw4Ivg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=h8S6oCk9 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=h8S6oCk9 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDsmfwbO0BDZ5H3l6111xGnMAXrEdWPH5cF8aWvoUTIgfJ3y02X5T63Sbs60+MSz8dIccf5FtEhe4VE7Xo7/E2clPCeODsALeueBVGg6cBLjvIh2cskU
    7EO2A9DhuOUWEekYLPqRRVsDwVY5fHiMBykPHl7W+Q0SWvO60ayRwJ7oTn7CkAPL1dlBqNM5H45pBoK/zk5+b7wsZPHP29/GwWJ7B1dzgxgkZVcJ8lvAM4Er
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=9rkjPaNG2vjWt7Z3QpwA:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968397AbeEXJzn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967993AbeEXJzk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Henzl <thenzl@redhat.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 099/165] scsi: mpt3sas: fix an out of bound write
Date: Thu, 24 May 2018 11:38:25 +0200
Message-Id: <20180524093626.022594428@linuxfoundation.org>
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

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit 4a8842de8db4953fdda7866626b78b12fb8adb97 ]

cpu_msix_table is allocated to store online cpus, but pci_irq_get_affinity
may return cpu_possible_mask which is then used to access cpu_msix_table.
That causes bad user experience.  Fix limits access to only online cpus,
I've also added an additional test to protect from an unlikely change in
cpu_online_mask.

[mkp: checkpatch]

Fixes: 1d55abc0e98a ("scsi: mpt3sas: switch to pci_alloc_irq_vectors")
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Acked-by: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -1921,8 +1921,11 @@ _base_assign_reply_queues(struct MPT3SAS
 				continue;
 			}
 
-			for_each_cpu(cpu, mask)
+			for_each_cpu_and(cpu, mask, cpu_online_mask) {
+				if (cpu >= ioc->cpu_msix_table_sz)
+					break;
 				ioc->cpu_msix_table[cpu] = reply_q->msix_index;
+			}
 		}
 		return;
 	}
