Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162007-2-9768331646860014401
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
    1527162007; b=S6eOdnNY9ggDHh4umHaijxSiykc/eghb5wR0Fcubuu6IU+B4I6
    Y07etsEyNvWo1LfCONNYenQqV2pBM5xWo1/5RlypCMSgbWargjcNIQjdjYrOMHGx
    zbU+zTnUpXRfop+y4Pn3IaCEIrm0FknmRnKB3Zo1KOLCdi++Th25nvmHmBVwUbO0
    xldXt5rxVITNrvZDIy3F9eBi3KMgHQjYgJdTtJF2ziJcZkBP8BxS+ZNmRRoOoUra
    LL7ZpzAbthu7D3VhvargBywt5vgzFDsAR1QPuiBmnUZ3ckatRQAEQWRLZSatObQ2
    WXlj68EL7u/4wQ4am8Uuz3FUWzTzNB0pHLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162007; bh=joUEaifgLUPro+wjDYTKoojwPRpgRg
    E+JbWAg8HTTtY=; b=bd4PtZPMHuh341roHiCpvdbFOWwVXwCOahZtesn8Nmpyux
    l8jjzWEHmgF+T5SRG/AcfoMBfRz6h35SPpCQBaS3ZS2y3xCexe7KFg+sDmoW5Xf+
    AlxTftPWqOEWnFxyqIxDFjQKGVzy6kG4iaPwMtPvA1QgdZMLdrYpJ4ECoiEPml2I
    OdcKmtuv9iRkgQgIEN3lm7DIXO5j+B/rPeFsTwbNnDoLXpdGvLwwSPravAdZoEof
    dZ8TLsfrbY8PqPM+7t81FRQHPd5spKJ1Qolrn9KtboH8PqZKYXNtP3TZB77rn7P1
    relZIzQxk7ldZVhv0BeSTmyWANsAev2WCRWpo7fQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cXUk1pzx x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=cXUk1pzx x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGWlYCSM9wYY7x2ISr20GnfTyuAxXDsKjNoJ61rVDyJ256J49LwUTWv/9XmH7V/P0649+hJD9obPHatbYy/ErqnV/a4aRArODVKcAGJXkWYrz9RqKu/w
    qJYkrKplIwZcoYeKOODd8tMj0vz4QFyVKj6ho2SlpCPUdNpVsMISDa3M5YZ6cNc8couur060A2T9F9Jssjom6vLUPnwxETjnEwKSzNV46KGuk4uFotAWW2RI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=A-hZHoMch7ZS3K96ndYA:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967291AbeEXJs7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966995AbeEXJsz (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 48/96] staging: rtl8192u: return -ENOMEM on failed allocation of priv->oldaddr
Date: Thu, 24 May 2018 11:38:31 +0200
Message-Id: <20180524093608.243563919@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit e1a7418529e33bc4efc346324557251a16a3e79b ]

Currently the allocation of priv->oldaddr is not null checked which will
lead to subsequent errors when accessing priv->oldaddr.  Fix this with
a null pointer check and a return of -ENOMEM on allocation failure.

Detected with Coccinelle:
drivers/staging/rtl8192u/r8192U_core.c:1708:2-15: alloc with no test,
possible model on line 1723

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8192u/r8192U_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1705,6 +1705,8 @@ static short rtl8192_usb_initendpoints(s
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
+		if (!priv->oldaddr)
+			return -ENOMEM;
 		oldaddr = priv->oldaddr;
 		align = ((long)oldaddr) & 3;
 		if (align) {
