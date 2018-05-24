Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527164137-2-16939610495952711651
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
    1527164136; b=PxmMHVf0z0htLRnwSVcyqbAeeclf5QHTI+t13IlK1i0ObePm2r
    wT5J0OUBgIaCuwsZrR2d4zdmqHWH3q/5PwTPidWkaw0GmrUt4Mk7Olq60IEhAyUo
    6LMNVvwS+cMe4u8CnYiGUJC1+LGK45byJnwoDIixk+puqblyJapFAuAxhdEw+WGT
    kcIrUjdlU79WrJnTsAnHpZbX8cVZRf8e6viyDRjSkKltRBSZIVb9vN7tmfdTASUq
    DPPmB6ScPGkSr7XuPa6t7g/GvytFx/mU70DHwsD5Y+dXj7zWunrlj6T1aIrytGqS
    PfdJzCE2DHwIOqYc1lB0I3LjaycC7zYdZFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164136; bh=hgkrX3lm5j1hXGp74LIQv0sKNLtikY
    i68luJp2WSo3U=; b=NhU42XxES2Ar7aPX1mH19L1QRB4UnedKIC+USDhawI3una
    hLu+09rGEFoUBSvEX+X1sTE0WwvmDdFPJt8dUGjQ8vzgoHRnuMbhDcVop7TlIY3C
    DFKNUXAhjc4fMsZojuyDWWa6Xy77BuhttKRrfQnRjQFpJ3lXDl/LQIElDusR2VZD
    A266Tz6t2JpmLpJ7csM8808liGaokjbMJUBuPZRqny+9qY8EjFxBBfJWcIzmYH8E
    j0gDuPnw5tOwGhRsz8wHTsttRHdNXAVsX1H4/rP7CLFwa28liIPR0Se4lrlRifB1
    heh8BwbEzoQPX8js9rri693+tqjPEjUA8jTkAlXQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=aoELOYx2 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=aoELOYx2 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJtJVYVRwk1ha86R99eoef64Qo3sYgw/peP6I8CMzEMy+VXm9FgIv1pDS+AJcCY3jeERbViT4k3XpBACkHBM0sNY9m+MnZg09WsjpBh8xE39eEGYrFJv
    sW2qjXwb7BFM+pOSzIhLSi/GRfoji9v+3+Bz9WGEo6n9AXyarI4aerJyReLkJfqBI+oh+npS9zSlNHsVoJN6xERGvW/w6JnWLiFGyc2L675vilE9PHaUTwJQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=NCkSHYsgAAAA:8
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=NiwbD6wQrM2umdzaVFgA:9 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22 a=AnMw66Xr5OuzjdxB04dI:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969670AbeEXMPI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966330AbeEXJmU (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 3.18 42/45] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
Date: Thu, 24 May 2018 11:38:50 +0200
Message-Id: <20180524093126.325649557@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Alexander Potapenko <glider@google.com>

commit a45b599ad808c3c982fdcdc12b0b8611c2f92824 upstream.

This shall help avoid copying uninitialized memory to the userspace when
calling ioctl(fd, SG_IO) with an empty command.

Reported-by: syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1950,7 +1950,7 @@ retry:
 		num = (rem_sz > scatter_elem_sz_prev) ?
 			scatter_elem_sz_prev : rem_sz;
 
-		schp->pages[k] = alloc_pages(gfp_mask, order);
+		schp->pages[k] = alloc_pages(gfp_mask | __GFP_ZERO, order);
 		if (!schp->pages[k])
 			goto out;
 
