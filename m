Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472369-2-15539702982887558554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472368; b=giJfN4Q1EN8AYB/FC5/kqGWP+TgWtJfGHKpMmH8sz1OZyfRNLs
    a8xvYOyKOQ3km99a1V1xP9nE9/Y04zjeCIoO+Cc5IGugKXlWvAqlk3cNqO6pThkG
    eYqLpXb0byeAsf9Ze7mLXVeUK+wKbE2AoWQ+PfwuR9z53E5bBeNdnJFTiTC1LM68
    WOOJRI3Uw7zIRK+Ic5w7tpdeEHDoJXwyCgmNw1oXPcmjjvpNuuwCJ3hGGfS45wuE
    wqgYcwi2uXaj3TCTmEfhgrSKFiTz/EKRz4uGZNJ+1Ei7D2AOenRPA40xm0YfKycV
    0zr0jv+zZ6LnFjm8hnB4rjUGQ5GSUYqe40HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472368; bh=1iW4TLwsyiyt6qIvi99w46wirLJsmn
    rfGTwpqya7xfo=; b=rQ18VGI8k8mqzrdjMr7+TM50fMS2/Ly1WUzRxrGLGOZIe0
    6Oeq0BD2mH1FLKJ3nZu56O11ahqwLVCUL52FAMt3MPBrKahY16sXORUR69/uV3Up
    DBxWbBvXBB7MplCwUDj23lfPMZXW0vR/8FPI420s3X6znHRzG4S/ntXup7xg2YUh
    wzK4u2EVbxtQz8hPo0rulRXlx80/CAs4o9x5wtVOVs3DBNTZkxao+jKjBJJZaXky
    MKW076utOtHsP5xd8RqppdFUqX4hxl/Q+AkpfoAuOS8azXim3PEdTnk0OtO4QePs
    jWTqVqjz0gYBdzuAdREQZImZZ+aHVeE5bIPmutPQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfKAJS9GQHi9QgCXPPQW7SnHnJ0G7sguBv8ZPt2h+3uzDA1Z/hUBE8SXPAuG7zOsi4UT8bhQW/JUNLImqfHtgjcg0VgJW/wHYbRx78vJb0FKSUtES/Knl
    hHCmSWXTIzuEUGsJyFkIGT44SsJAvE3il3+g2ihS4+glFFVnn7deRupcFWMxPxK3czUNSW5ZAvHXVm8TgLvHUHVJs0sSCFfpxMs6TXns3Qg6+sbe/l5dix1S
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=FOH2dFAWAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=8aWv2MnVS5gAdNGTbZkA:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755673AbeDKSqE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:46:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58772 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755667AbeDKSqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 058/190] md-cluster: fix potential lock issue in add_new_disk
Date: Wed, 11 Apr 2018 20:35:04 +0200
Message-Id: <20180411183553.730918372@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoqing Jiang <gqjiang@suse.com>


[ Upstream commit 2dffdc0724004f38f5e39907747b53e4b0d80e59 ]

The add_new_disk returns with communication locked if
__sendmsg returns failure, fix it with call unlock_comm
before return.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
CC: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-cluster.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -945,8 +945,10 @@ static int add_new_disk(struct mddev *md
 	cmsg.raid_slot = cpu_to_le32(rdev->desc_nr);
 	lock_comm(cinfo);
 	ret = __sendmsg(cinfo, &cmsg);
-	if (ret)
+	if (ret) {
+		unlock_comm(cinfo);
 		return ret;
+	}
 	cinfo->no_new_dev_lockres->flags |= DLM_LKF_NOQUEUE;
 	ret = dlm_lock_sync(cinfo->no_new_dev_lockres, DLM_LOCK_EX);
 	cinfo->no_new_dev_lockres->flags &= ~DLM_LKF_NOQUEUE;
