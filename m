Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-967591-1518812373-2-16962587445659262157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518812372; b=suapb1oNQZwdyrNhzhL6Pa9mI9eMV0TeTk5dWon567GFfXU
    ggOMkF3bWY1E899iA8RToPNllo8S0fGqJrQZ8ILVr9z6KebOtscJvHAqQmc/SzDg
    lFC/Ux9bZ+MaEP/h/Y2AgHPavNv/AnM81/h01iwXcgRtUSWLePHYoOfBlCZNpOKR
    4MXoBpjoFy1ltdd+1KdAq1lJJcnnCR4mZA2sMT6fEPbfgfmquXTjDW3YADODSo+V
    5D0IQld8u2d+goqK2VaNihVyg/Tk0xcESmGBP3+f6OXW1+shK9JITNYpfkOnPvw9
    5Ns+DN4giN9RhCUIVlOqD7tev6dV/tXTE6up1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518812372; bh=r
    OGS+Adf3MfCWXYyO4Mg1bMP7ng22RQyOV+LSNjt4/8=; b=skcwHPxFEK4lsb3rE
    kVEB2u/82sxZkFfKK/l85LYF0Eoyu5Blc4b8YwVsCDQh09SlSYPn/fHHQ3FNQYff
    D7eOgG04AOiQeMvRhcVfZFDAp7CsSFnpB7dQ4yFeI8iFZa0KXCR9qa7YMA5xxCWr
    oMQg6VUuKE6iKW89gZV0pA7hDOhRvtOr8i3lpfms1hNHwvXG1cc59dIsX1GlNIsH
    CAjV/XSo4mY+0SBxleV5L98fMIcNSdAB4gQ1rDaYgKq2yMOtTxdwWxSWJrIj0Hbr
    et89c0Lnl10UdHbekLQlDG/r+y0fvPnVF6ljyv4pJeqRagmwNficsyhrwbzcWqAY
    4nz+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=S8uMPT71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=S8uMPT71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=S8uMPT71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=S8uMPT71 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1413A60585
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Fri, 16 Feb 2018 12:19:22 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v2] staging: android: ion: Initialize dma_address of new sg
 list
Message-ID: <alpine.DEB.2.02.1802161215480.14464@lmark-linux.qualcomm.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix the dup_sg_table function to initialize the dma_address of the new
sg list entries instead of the source dma_address entries.

Since ION duplicates the sg_list this issue does not appear to result in
an actual bug.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
Acked-by: Laura Abbott <labbott@redhat.com>
---
Changes in v2:
  - Add to commit message that it doesn't cause an actual bug
  - Remove 'Fixes:' since it doesn't cause a bug
  - Add Acked-by from Laura Abbott

 drivers/staging/android/ion/ion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 57e0d8035b2e..517d4f40d1b7 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -187,7 +187,7 @@ static struct sg_table *dup_sg_table(struct sg_table *table)
 	new_sg = new_table->sgl;
 	for_each_sg(table->sgl, sg, table->nents, i) {
 		memcpy(new_sg, sg, sizeof(*sg));
-		sg->dma_address = 0;
+		new_sg->dma_address = 0;
 		new_sg = sg_next(new_sg);
 	}
 
-- 
1.8.5.2


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
