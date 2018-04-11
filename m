Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477557-2-1612944988066958536
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
    1523477556; b=lSo8pBm+QNiHqwq2bEQ+yM4+VIG6BCDexXq9dxh8qf+QJG8d4y
    N+J5B2Uqs8c63c4c3p64nMfR04urvO/1tMV89oR90b2YezA1+lEUtZC4QTsrlVgX
    pw94ZkO4U+ujXii7A8BQAa4zYSoaBMiCfB4vnHg3kaJR9+Gw64ozFoBq5srs5oya
    +BOQpHIf4vNNDNGDBQb7dwOKUlx48hgPPEez/Z8bLTCDl4H9CIPH6Wov5F5+QurO
    Q1/piyIqQtoxwbxOYg0cZ1nIfXJWBYrfqfwZ7O954V9loyxmOzs6BO5zdZZJ8/Vv
    oUGAewz4FF95EQ8fBRHFhpo0X6Q2JVueN6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477556; bh=8fe7G7j2AUvoD3QM5SoaxVsfvtv2bv
    +Kd7cZs9rg9g0=; b=gNfYvLdaDc0tuVW0MUAvXKb7/pHdNY9cMxi4ya25Jx07O4
    HlgBUCmNuvhPLhuapX6qx2Sx98v5lNCOKU1T0rgf6CCek8rrCCIvLhSL7FzFTI8h
    H+6SHMre5RicJ1deLjv6YYmZpC7DQOdkPZfb/IlrZ3Wp6xYG2/YVwze659BQ9PG+
    Pz5CdLT5+6sqiK/H5JnjX3WvzVrLDVk2KDI8HC0w3YnObsGoMktekS0HuMXZK5Ry
    uwoKwmx53T6QbOr0p92FI7BeBXQPMu2iXZr9muULEvaNBr886tlgYRDMovaLIfXQ
    f0bLmf/a/6xu76MxrgQkRqpBi0nF6goviCoX/ucQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfD0wvJ1haKfxtjzIrn4/aULR4dSwKbfb2xiPFHRPcrB5w9ITZsAQE8S1g57pQU9a/e6qlEgcKbEp5RvafbPVc5OAfC9mg8UHbPcw11xfD+icN37/AXnw
    t/LuqDWv7lIcV+dM0W/nYVCIIqzi+0ZNPbon3HvMLJ3MaH+O8kvwQuUZpTB640rs3s9K7GVrtTzwvwco4fO/wO4dSdqjCLu+p3hQqjd3aMtHl/wgkeAY0qxO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=X1amntBpBOBn3wXMwssA:9 a=RZy4pN1nmuukcFF3:21 a=ykbt7LAt_ZArCdqe:21
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeDKSx6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933393AbeDKSxy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 007/310] ovl: persistent inode numbers for upper hardlinks
Date: Wed, 11 Apr 2018 20:32:26 +0200
Message-Id: <20180411183622.606464693@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Amir Goldstein <amir73il@gmail.com>


[ Upstream commit 5b6c9053fb38a66fd5c6177fcf5022b24767811a ]

An upper type non directory dentry that is a copy up target
should have a reference to its lower copy up origin.

There are three ways for an upper type dentry to be instantiated:
1. A lower type dentry that is being copied up
2. An entry that is found in upper dir by ovl_lookup()
3. A negative dentry is hardlinked to an upper type dentry

In the first case, the lower reference is set before copy up.
In the second case, the lower reference is found by ovl_lookup().
In the last case of hardlinked upper dentry, it is not easy to
update the lower reference of the negative dentry.  Instead,
drop the newly hardlinked negative dentry from dcache and let
the next access call ovl_lookup() to find its lower reference.

This makes sure that the inode number reported by stat(2) after
the hardlink is created is the same inode number that will be
reported by stat(2) after mount cycle, which is the inode number
of the lower copy up origin of the hardlink source.

NOTE that this does not fix breaking of lower hardlinks on copy
up, but only fixes the case of lower nlink == 1, whose upper copy
up inode is hardlinked in upper dir.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/overlayfs/dir.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -180,6 +180,9 @@ static void ovl_instantiate(struct dentr
 		inc_nlink(inode);
 	}
 	d_instantiate(dentry, inode);
+	/* Force lookup of new upper hardlink to find its lower */
+	if (hardlink)
+		d_drop(dentry);
 }
 
 static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
