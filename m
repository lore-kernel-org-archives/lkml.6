Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3887703-1521233767-2-15099791257939280095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521233766; b=lshPnHIUVxpc3lc+OCs6/yMlQzyRI1u5cVN7iimTu9MU49e
    8TkGjsZPUMWiJoxsDb9uMR2de2tCUnlCRifz11DnW50rXY1L4PkHnvLuSez84qwp
    NLV0NFuV1pbkX/YxjvYwL6pCfuWL+O0fod/MX72KHLes2Zk5BnJm4Wuy9rRHsmRT
    5Hx1gRoDPzj4rKZ1LKGmJmZEOy5CY27awuqQ500yxVrpfucuMqj37NLmmF0Y/tn8
    J/IYEQrjI6xzBGIyrf82NuQS/R6WjE20QeKwC1yiRZM/2Y3OzoZrT8mc7BMVypIX
    3ZemnnOeVWhNbCcJBw/+5kQXIVi1BE+CLKCJlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521233766; bh=9VtXbuwsr2o3iBBiuINBqMhf/6
    BrKNNMXZnsP8LB4+k=; b=uq9N1vHM8Oanob9tgtdOpOKH0wcxwLQVPnd9UPg0s2
    l3O1XOASGRto+bFYFtyEU70d2kIwzQibs/oYqucpSEA1F15gIRTvu+gQa9ZH33Bq
    kmliZWpu05ah7nkv+6zG2zfuWMlAqmBSawGsYjXwRowxzOwFQa1MkRWOeeNDpS2E
    mKxTMUxHS1JHxTb7XbYYT3jncP9IigIQl3cR+5h3w1Q9ut2GIcdjPZXsAVglIIHs
    GCrsIFQ0mr4MBoa8fzRboVwzyB+vd82FN6LZAyRBoY1PJDjZNGU0qxiajlxa7wGs
    zRW8nvEijtSuGmXEfjNU/dOUI1F6mzEMwuW3v6jX8QXA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DmWmLCW3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RrqpyC11;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DmWmLCW3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RrqpyC11;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbeCPU4E (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 16:56:04 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53306 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeCPU4D (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 16:56:03 -0400
X-Google-Smtp-Source: AG47ELte6bSNlJQ4vYO8C1FUrb/sbTWcICKY5zkQqZbxQrO9Mo0zk+Bjf63SLjFBxS8WYzudMNik1Q==
Date: Fri, 16 Mar 2018 20:55:59 +0000
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] libata: blacklist Micron 500IT SSD with MU01 firmware
Message-ID: <20180316205559.GA29406@sudip-laptop>
References: <1521210819-9225-1-git-send-email-sudipm.mukherjee@gmail.com>
 <yq137106mo9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq137106mo9.fsf@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Martin,

On Fri, Mar 16, 2018 at 11:54:30AM -0400, Martin K. Petersen wrote:
> 
> Sudip,
> 
> > While whitelisting Micron M500DC drives, the tweaked blacklist entry
> > enabled queued TRIM from M500IT variants also. But these do not support
> > queued TRIM. And while using those SSDs with the latest kernel we have
> > seen errors and even the partition table getting corrupted.
> 
> > +	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
> > +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> 
> Any reason to believe this deficiency is limited to MU01 firmware?

Not really. But we also use MG02 firmware and afaik, Micron has
confirmed that MG02 is a fixed one.
I have only mentioned MU01 as I know it has the problem.

--
Regards
Sudip
