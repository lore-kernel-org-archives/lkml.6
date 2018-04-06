Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021304-2-805762641557696015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021303; b=jiRCoaPq/D0mZurFy4FuMrv7qJwgpidyOaRVMGFwJIl4sBwkQY
    payQeKUMHxYB1W6dkP8BSOFshsnLWbSQSliamtIyhN0tG8cdNodGSut/eddh3gJO
    wvVRFmCtWwUdOgotMToTgytQ4nn8t1jLfUNC9ATw3rVQxwTkC0k2HCXKYUhAh0u1
    lhZRLLbPse8MwGzoIn3Pzeduoj/VjdAfMIE21bd9LnNmU7jCG3V12HsxGbCxSftl
    +S+Gvhnz+EHfcnohzBLLsi8AGAsCJn51dIuNeqh4L+mAH0bf+cfAHy1qK6dnTCvu
    SzWaiILZwaGc/8h+kQbygvwDi+3g3D6eR9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021303; bh=6UtBVSZbXlFrB22eo4h7TD1Pnb41kS
    ErwV4HXPMRh+0=; b=JDN4g2F+0aZ2XJiDGUvxDXsHzsfS3rrss2b0LfdLXswfY3
    j01OCaOuit12M8QxQqbzZDn1ug7tgAzsK0y+4ByOXvgObF4LxMgHe60h4TONTLtP
    Ge2sw/rdsBMHB1V3Ux80IKSQ18UGVsgFtBW13PLGlr0SijU/70TUJ2vQaQLYhHwu
    fKib+dG0TOQDhQixM5esPMi12fPhWX3av9Tz3R8fL5o1Ch3lqA9kQo42WlfFKJQd
    w8DPTmTdsUf3bFGtq52VbIyuz7pSbhmZKYXyVWt+zU86k3pwfzcXwSRqYxyb4AHB
    nomaxQuL5DQO0XJiA9u71hSQX0xh1Rb8TUUbIbYQ==
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
X-CM-Envelope: MS4wfG+5bv9dk+S3RuC1LhXhDZz/rhPwcJDpQmmNhxU4KT6NJwRokKnBf7zg5hS1pxL7oVcwEdlDOtSniakyQwbLPwfWXgjn6WPUKoawsU4B20v1VCgjh6D+
    JYJMXbx52xAXkTirgTTw18lkHfpgi57AfGTOUe0wB1EhAuqFW8BTUAhFOHXC06ByQfkwkeIwSd/hqgNdYeXEJWQYgVnS6zoSsxfFmhJQceG2rVaoTBfSn0fi
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=KUxnxfl8UcLBcMteF0IA:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeDFN2T (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:28:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55328 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754351AbeDFN2R (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:28:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 3.18 78/93] mei: remove dev_err message on an unsupported ioctl
Date: Fri,  6 Apr 2018 15:23:47 +0200
Message-Id: <20180406084228.529873137@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit bb0829a741792b56c908d7745bc0b2b540293bcc upstream.

Currently the driver spams the kernel log on unsupported ioctls which is
unnecessary as the ioctl returns -ENOIOCTLCMD to indicate this anyway.
I suspect this was originally for debugging purposes but it really is not
required so remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/main.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -556,7 +556,6 @@ static long mei_ioctl(struct file *file,
 		break;
 
 	default:
-		dev_err(dev->dev, ": unsupported ioctl %d.\n", cmd);
 		rets = -ENOIOCTLCMD;
 	}
 
