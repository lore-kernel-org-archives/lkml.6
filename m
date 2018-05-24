Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161909-2-11192522063778167477
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
    1527161909; b=mjBj/UshihlOM3eEBGyT6UiMMZHQew+/OMjmA2g8xby4eyUD2v
    6L7SdAV9wJGlC1/UCqtf1OddrqGU3WLTiZdtEB+snt285j/oK8vSfZw2FjzgUvjX
    YS10rXJ5Vc4kfcPVLlGis5prGAYEsDoGFDY8fQmO7MZ0S9oGwvd5/6iiRJCK9Eyg
    AQq4GpeB3yjFGxj0qQf0O9NT4UyvVO4oBTDGT1833mgHEquw5r1nYqyOrQfvawky
    2E+/+amSVIM0dTmkA1uZSjkOTLNQdIUtFXmUsg2TqxkldtJdN2yCo17cRzMtuoX0
    IquQvTYW01X6vGBF1VJD4FdWSNfEflek7reQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161909; bh=nqfNy5VkPAB6cKv3O0BS36Hg08Lo6y
    Cedqe94sjAn90=; b=lFx+tY+7L3jNckrvEE1niom5+Cg1zZwFG4Wu6RMg2iae8t
    AACIMJu2hZV+8ep7eJj909kvTvEmr4bfF8SS8F2HZnLnkoAWOD853odeJktsMM9k
    E8xISXosCcm/1gvc7e1GKa/whnXuCY+OhdGAPnOG2HDK2EvnfPpx5LisCjH7CTk1
    XgdOchCQe34QKj8Ka/sR8mDFwTSmsfs7VlXxVeSVHesuptp4/o18wRvT1YpO8psh
    fEndhZRBNDSgwlDgaEw50uMhos9hECGbls/zbkYhzDvuqWTBjywF6LRFHjj9WG+Q
    9FZLwNQ6sS+lg9LidWr9EzUFyo87h0zigId3OrLQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=qoMof33e x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=qoMof33e x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHtOIZl2U7hA7WKATf995FYvNW6GEKiJVfIuIW32ZIcfahVplAhyYVL2yUhta+OS4kf5AE6ifosKjl61hp78zW9aKMGc3foLT68qxuDAZ6Gu2BFOIFuW
    pNemv4KfqiYsEJNi5KiidHcTVQ1r5uhvVUmjRXBDEqTzvwO8bVLozUqoeoBGoKiDBXc9lE0+Xwzv67zwVzjkQFbMMPsWvFWnSeb9aUH1tUdjnM9SFhSxmJWm
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=P1VUzUOK4a2cKhXD81cA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966936AbeEXJtT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967350AbeEXJtR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 55/96] scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()
Date: Thu, 24 May 2018 11:38:38 +0200
Message-Id: <20180524093608.662126741@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit a7043e9529f3c367cc4d82997e00be034cbe57ca ]

My static checker complains about an out of bounds read:

    drivers/message/fusion/mptctl.c:2786 mptctl_hp_targetinfo()
    error: buffer overflow 'hd->sel_timeout' 255 <= u32max.

It's true that we probably should have a bounds check here.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/message/fusion/mptctl.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -2698,6 +2698,8 @@ mptctl_hp_targetinfo(unsigned long arg)
 				__FILE__, __LINE__, iocnum);
 		return -ENODEV;
 	}
+	if (karg.hdr.id >= MPT_MAX_FC_DEVICES)
+		return -EINVAL;
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "mptctl_hp_targetinfo called.\n",
 	    ioc->name));
 
