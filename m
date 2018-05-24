Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162022-2-11311219772179165670
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
    1527162021; b=TQDolqVCt+dHWTuLDY7mxb0I0vKkIscjuZHPopMc+XBoj+g8qK
    Pqa+WojbHG1HL2ipcwZGY8A8zezhRHcl9WbZO+ViPpuOsUZl+GKEAzc0X2bjeRj5
    QVKMIrum0mhD5hANQ8YWRJfS31BNY5lrLO4yLiHSxVYczRX55tpk3jRoMiT0Jd70
    akVYC9KwJdwRi3XcH3ukujS15xQZP/3OMiZNOnNPLYVYMymbfo1kVTZTDSPu+Cs3
    wJ5mm8RSTpw2RLPdwqGz3zteMdpacTMEtoQKxRGACrKCf2xVSdAIKejTCKhANZEM
    4LNiaO0b1YqnjEfI2LVFAJ8Rqa2GRCHO4lSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162021; bh=OEPMPugtYxNBGAeWa+vo93MGGGGuPq
    vBWBXCnWXp9oA=; b=hXrJ8S1KRCdNIwKK2osnh1LJTZAlSabstLIIdwyRTlSRqB
    tX8uxRpdvfkRn+2e6TR7FjjHhREQ6dDdJbW/Ozp+U6smn33MEcDhhJPVfkdlennS
    v83Ls6rkCU6ADmEa6Jzi7WlkHs3DVjd2D9a9l7IqR4YlvELjJ0Aa7tKxh4DoibLi
    E4+tjmHKiLDOb3V6hwVjXZFb1JqIa9hwtExtAqyMfi6FCfbDywVgzCn1lfUBFUDR
    ORSvzHlib96KXFlo9cQEBdb0YUoz9RmMxj7qbdjTC6RoVYdAloZBtIWieeo7lkI4
    jdgeQSgaiLUNSYxL35zZY9Kp+vC7zM3pw2rB+BEA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=We6fiAAG x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=We6fiAAG x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKW0b1R6LuYrDxg/i43R1YJ/oHyc0kCNzeFbiqHJbBACS/TwK/C2cs5BgGpNPMSOGtrslfCuM73z6v5iHcFPMwp9UJFJZIfva8mZlamSboJn2mPjUWse
    dZkoRzzQ1boGyBKtAjm1IMeQAeOoNYb1OBmbiLUhqcTL6XVYABHyv4iOXepMMwOX3afWplJxkczZJ0WhXHxPiwEn26k6eWN5BfP3H7iXk/bjRC6L4zdxvJTI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=NWo6yD48tLJsfen1gqcA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=1CNFftbPRP8L7MoqJWF3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967371AbeEXLkH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965895AbeEXJs6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        James Simmons <jsimmons@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 49/96] staging: lustre: lmv: correctly iput lmo_root
Date: Thu, 24 May 2018 11:38:32 +0200
Message-Id: <20180524093608.293560882@linuxfoundation.org>
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
@@ -2928,7 +2928,7 @@ int lmv_unpack_md(struct obd_export *exp
 	if (lsm && !lmm) {
 		int i;
 
-		for (i = 1; i < lsm->lsm_md_stripe_count; i++) {
+		for (i = 0; i < lsm->lsm_md_stripe_count; i++) {
 			/*
 			 * For migrating inode, the master stripe and master
 			 * object will be the same, so do not need iput, see
