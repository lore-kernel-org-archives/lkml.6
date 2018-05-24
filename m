Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527160772-2-10439560905865284644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160771; b=hVEGlNet7bhFlfGl3AgKenLxvdPsQ+T+jppsTI8SGRmUh7nGXF
    xdrg0dQ6gMXBoHERQRshps3oAYTIgi1o4200bvQ33NUqGToGPIHndfTwbm2GeupX
    drUfLa0gPyI/WFxgwZjSRsfUYgg9eWWgT4J898PGQOMIP7Y0TkVLgirg2QqRK/3a
    dQfeErXTpMwtauezAJP24JOvaIX6yyBWAicra3i9Lc9TM2QiKvqgdjveuiyjLxMO
    7RcMd57t3XccoAkdUTYmJa3TbMMsommBrH1YAD6dFc7yzNEcLrjcCv/2Wvx0slLk
    QipKENxuxTUMCM+C/spY8Axc38OJnOLE1qSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160771; bh=236FJdzpCivcdra6w8ZWC0tWt8duZJ
    qcfHuOr2/MvVA=; b=BrR6LFNMMfzZ/AZswaT7dF+Pz4MOzXGOPJCLZwvkxbsHqj
    fI1isKWN7ZntzLpFFB4NWOfp88sUhkOv92aKTOW1/cV5TcH9PV/BwmwKBhQoaS+a
    au3D50zi63zeLV7GIXLVDrcUfwYMq+XqrW7Yay+YECx2WsL49NJ+vJxm6e1kF1mx
    2bnl4fluODod/VeYWKPAiKWkxRQpDBwjXTzHjjvjCE9E8iXgqTH3FVqvz8b4kdD2
    2T2y8wuV6VdUEIUBGMntPxueQul7sTNrbBBAkMgJw4vOZIiRS1NlR+WLf7hgAoyo
    garH9RuBx2vgG0LH4UmXCzzHFOqm6QCN3oyfvE5Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=lqBP0olE x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=lqBP0olE x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAUBhf5H42/saG8dOrLqSBptL8OfByYt2XceAE/HytZSXW++TQ/76Lycbb+JY98X9gq2heqHzi5EVWEgyG1kgb2j9j/IGZtzZ4kLak334/oXSkQz8uJV
    QmwbUL/kwkvDwv63+7hNWSd1o3EO63spVZVKs78LxQT+6trqpcnETC8KwvFJQ+DF6pFiRpdCDZ7gpn19SllHnVyIyD135/MVuq4piNtIlOp8QtRIiwGvygJw
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=_KYyZdXvlfYLBtlrgXgA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967940AbeEXJwv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967937AbeEXJwt (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 035/165] sparc: vio: use put_device() instead of kfree()
Date: Thu, 24 May 2018 11:37:21 +0200
Message-Id: <20180524093623.389722946@linuxfoundation.org>
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

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

[ Upstream commit 00ad691ab140b54ab9f5de5e74cb994f552e8124 ]

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/vio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -403,7 +403,7 @@ static struct vio_dev *vio_create_one(st
 	if (err) {
 		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
 		       dev_name(&vdev->dev), err);
-		kfree(vdev);
+		put_device(&vdev->dev);
 		return NULL;
 	}
 	if (vdev->dp)
