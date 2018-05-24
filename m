Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155769-2-272785780912668828
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
    1527155769; b=dohgkYqi1JZOBCvfgjMfLSkkmyabMr6Uh3zD5GkdBmk6hTzuRD
    GEzGlhKc1QZt/pmRauZTgG2xDiQ+LRozZEsCgaULDDq9r+3RHvObgANDHygNPxPm
    JrsV9mxcrSWv+GQDGXxWsfsRwEm2lItCGpRP6iUAnDwqBGKhosUunYUjCEmkyaPI
    +nMAfnGwyxWhbtUfDTBLmGaTggZUfAuqCGIJu5uTwDYnpUGMNFHwFZ8xkEpSagD4
    JBdH0sWMrPHu5AlPO7kY6zla/ycp+AE1iYlwPvuBJ63vprvIRKMV8faXRPvVY71t
    cSTiZk08YpxKXS41buCAge6FhTIWA0OaKh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155769; bh=bOWxQkWRi2jM4zY5ebfVfGZRVq0Y2j
    /ITmoslkGvVpA=; b=RgkFTEVD4bio/bLHjMKG1t83ajaiUHVeu8CL20u4lrAOqe
    E+/NnmAME25WPfSqsRRmUhs1UiGPQ0z+CGf23aRoF0pvI6BLoWyhWlMb7S7hm86j
    T9v/jYP75CPpP7jK/ZKnCG79LWrwhPf9Ang683mZQGsZEC4ivLdYTigyHE6CG63X
    E4mNzwANq81vYHT1Sw8mus7dkVwYrgyoocJgEd0YZR0J4w7c1eYo+MqGZLtHZlgK
    sZo92h5hQKoSdL/B2hfpzh2iH1S+pZomrhAIptk9QOvVCgslNBCotZQdDq8AvhlY
    fx+MXUI2K+pieR4ZzdwFsAlAiPjV8VciTf3QOOVg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VJx6D7o9 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=VJx6D7o9 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfI8MZndS5A+5D2iS1O/yLLJvlgF5FSD0kLItMaf6u1aCa7l52ioOdnOj9RyNnp/sEb31LKHp94H+D/OEPpJwMHU58zqTFhajUlkxMkdHr8hioetW9Fw8
    /n1/KLuFkE9qbKkjKK0hnBxTWvl+1+kOkXoWVurw0fo6xe0FpTP04VAd3wjU7HJvsfhf+BNwdy+czM5o4B97sumP7vIDbyrs14gjmexpHK24M/ENWJVZrTes
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=P1VUzUOK4a2cKhXD81cA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030225AbeEXJz4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030210AbeEXJzy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:55:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 104/165] scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()
Date: Thu, 24 May 2018 11:38:30 +0200
Message-Id: <20180524093626.225525353@linuxfoundation.org>
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
 
