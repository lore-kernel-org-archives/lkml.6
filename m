Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527159930-2-6013472162015930611
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
    1527159929; b=JU6eQ7z0iqtfxvn+U1SrdvAZIFn4z4bRg1LnE1hXYoYQU350dX
    96NyTLpDtmZo5yOjYpWbkgNNe+OVsLI/c/+8fCCZEEDr+HWAOk3LP9334M9ZTHmv
    QEpeqsDeKWP0+QOMxGttLyeyYZzYui1j9lELDIXIAmQ4Oaxe0GcgrPZtX0KiWttJ
    1MLADHGiOxcnbKHHUyIjcA1GRr9iW2BYvvhgZuxArdYhPoplwPbnCoqPQvqGXFYt
    H2NR5Pk4Few3yEsQ0PQ1VWRmp5sOFpwuhvfubmD7VERSnjiK2Ox6TnwQhxyGynks
    +IsB6mv1XTrONDTNzxp36XVb5oIiO76OsZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159929; bh=O3A3XOc2buO3UDT5ca+Yr+X+F7HsPu
    T6Tk2UBMtMiaw=; b=Ex2ZyODISB2cO68TXmywn8J9D/1vCxNwQRc2AG1XIsQikH
    DBCcVtKB1iCOpFqFKEwPhWL4HdaWLWgmZPX+7Og+KbtpeSOK8VE9fb0D0zWDgWeF
    R+/vPz1W8qY2zuYJIlI2wphYpbziL9ND5bfqL/wTvHRYRnM6vLyu7/jRIzX5YBD9
    r8nTI2UbHrWqxe6zwkG/oK5ymr8y80IW1DC3PYrhIIKdwcvN7/kJIn8g9niiw2GQ
    /ZqK0Z7WIo4dLlKxfeI3V8h9DNsBGkM9qoGpf8mfmNFD1nwQSLMmggj/oVk0lGDp
    o4fcLiIakLucLJJZbETka/qc+V84UgDzgrJpAm1Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rcgTB+Ee x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=rcgTB+Ee x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCUa9FcDNVcJnq1o4+2/c1GdNBe8Z8wRjF3e2u5SP0jMwDciQM0T6GbxYw7vSVN8bt/FKUM6RtrPfbjQMmif19xkMvpjkPxt27fMzQ0zJI2prHcockQ1
    73gCFrKSr2/uAGyQh00u3FRU6Sigfcg+jokAJQtgLIT7ymPuSfbBVnzOvBjmooxTW6DkaMoQ9MCTL6QnvqLwHYNw8FDwV+gP6QuH82k2WR8msQp9aOv2RJU2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=NWo6yD48tLJsfen1gqcA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968306AbeEXJzQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968019AbeEXJzN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        James Simmons <jsimmons@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 090/165] staging: lustre: lmv: correctly iput lmo_root
Date: Thu, 24 May 2018 11:38:16 +0200
Message-Id: <20180524093625.670726153@linuxfoundation.org>
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

From: NeilBrown <neilb@suse.com>

[ Upstream commit 17556cdbe6ed70a6a20e597b228628f7f34387f8 ]

Commit 8f18c8a48b73 ("staging: lustre: lmv: separate master object
with master stripe") changed how lmo_root inodes were managed,
particularly when LMV_HASH_FLAG_MIGRATION is not set.
Previously lsm_md_oinfo[0].lmo_root was always a borrowed
inode reference and didn't need to by iput().
Since the change, that special case only applies when
LMV_HASH_FLAG_MIGRATION is set

In the upstream (lustre-release) version of this patch [Commit
60e07b972114 ("LU-4690 lod: separate master object with master
stripe")] the for loop in the lmv_unpack_md() was changed to count
from 0 and to ignore entry 0 if LMV_HASH_FLAG_MIGRATION is set.
In the patch that got applied to Linux, that change was missing,
so lsm_md_oinfo[0].lmo_root is never iput().
This results in a "VFS: Busy inodes" warning at unmount.

Fixes: 8f18c8a48b73 ("staging: lustre: lmv: separate master object with master stripe")
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/lustre/lustre/lmv/lmv_obd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -2694,7 +2694,7 @@ static int lmv_unpackmd(struct obd_expor
 	if (lsm && !lmm) {
 		int i;
 
-		for (i = 1; i < lsm->lsm_md_stripe_count; i++) {
+		for (i = 0; i < lsm->lsm_md_stripe_count; i++) {
 			/*
 			 * For migrating inode, the master stripe and master
 			 * object will be the same, so do not need iput, see
