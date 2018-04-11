Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472992-2-5014613229090652621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472992; b=b4c0lWN7MQ3EuuBzxidzNPK+5KVA6B54YihoghmB2skeOcoUw0
    2ZoP3cU0mqouyKbFRZ6GJvYjVs4ivbNP1J5Ix/tuUqQx8rqhfl9mMlwoq38/q1aT
    qr3wxJxLN3yzXFXS/9mcKXZew3qXm72kA5+IG0GWQhhi4r2ypAnC/03UJs5itDP8
    eRcbEZCmKz+O9NMfohvFd+pThVmE1RpZPywLQJSUPd2UBEatGMlMoG4O4pH8YzWu
    gNpF5kyXdVN4tCKvXJLksSm5bGHLba1AfK+9k1xK92rwSBDovnsl7iwjQHCxcvXK
    V62s4wy/LWpCAy+e7WZyRZYP4NWyshCxfwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472992; bh=ruLajQAuq9eaAVvCLZjWrXTHdei1A4
    fMnQLVlOkU5Qk=; b=GbeJNPcMskJvveZ9mmOwi6CPCBQ+cYER0OcEAtMWW7JTBw
    uyyRpHvgcq3XVAZkkcjY5PwrOHrgMqjubXDH4YSJfthiuQjDTO8ZFZx7QrNp/r+j
    IbYlAjzM0eHth0mpd6Hm8TVav9cGuxdtrLEBP5VLgRSn/8gZ0krIQyFBKAsrJKxV
    cqJy/KJ+g1dcbLY6EVmdTlviNa9DM5aDlCTYt8dfGJ5jm1FhFk1CMUbYc4i3eocp
    KStHQTgohPuymOM41DYovaN7+oigwW/RfWOgEQkm7wRRdbUc0b75q5gXJPbb1Ke1
    KTUWqXdGdwodBHzVmKY+PfmyXKdA3ZeaC/DSqGhw==
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
X-CM-Envelope: MS4wfC0ZK6wdNK5SdduotBk2w4BgbdN3MFZdiSAKok9RBy4yOClCuuIyBSO/6yXlwbyMD1RUgp3sdKdzWRC+36kH3PH/d5wr9aPGP1MokoanvI7Mn97qD2Kx
    mBq9z2WMEnMesY/tRfJwu0K3k6yAf18NhKeFagAQaT3wbJvPz55idu/y4H8ritjVi4+MCryk9I6d/dpXlIYSsi7qsvtSzGqyPaTiWiS4cwaUMR+mr9gk3tVc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=FOH2dFAWAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=8aWv2MnVS5gAdNGTbZkA:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933881AbeDKS40 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:56:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeDKS4Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:56:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Guoqing Jiang <gqjiang@suse.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 087/310] md-cluster: fix potential lock issue in add_new_disk
Date: Wed, 11 Apr 2018 20:33:46 +0200
Message-Id: <20180411183626.008481882@linuxfoundation.org>
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
@@ -1122,8 +1122,10 @@ static int add_new_disk(struct mddev *md
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
