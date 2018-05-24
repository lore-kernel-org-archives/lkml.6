Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162457-2-4282438685959274259
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
    1527162456; b=De3Bu8lTBITRTgDisMjNueouMxCZGsXo1rP4t4Byx8gjWFguYK
    HkHHwIA1D9B17jvQ8bTJsLPsQdNTw0mIuJ1e8uJW+IBrhtWoLTOZt2/rSgu+Y8IF
    f8cZtnmJ8KDBHknJhOtm85RMKbUsm7rEPzCK418ikpyBvtzNZQkqgeFWf2/zzPGP
    z1yfBR1hhM+w/IM4z2it3BEHkvdmlxdu+p9CPURvNMFvMglhPJcstWHg+PaY+PG/
    DOt+zapbKNYU4n56rasF9ksK4z7BiPwHbv1TQCaomp+4KiRiKbalQ/vffA2yWRYm
    jkc49HjgZYtA1ZAA2KXuCpSuq2o7T46xGSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162456; bh=KhPQwhqYwaZk3X1NM4oUhwBryPZXfG
    LTbOcISV+5fJ0=; b=J1uiOF7dmtcJrmaBbJ/ebtecVZYwkzx0ZEXNWU40yUKDX3
    fNCqev6fASqRM9ajLmpKaRp9s0+SVd1XsDTf/vj5VZcjpYn/734CW6nivOG9NOAE
    qUQr+ezkJHco9MWOHIbBXKoD8MdHa4+aVhJA+7s9AFIVZm9Kcks25/lrn+qvibkW
    yLHjGqbM8Z7Xb3H4Qe9/e8U748NGhxa5w6PzSUEvkEerwxpuGQr/Bjz5ldBRbVU7
    ZD6DHCFCoinhHa1PNWKYPCNF5XP6rzRd2ep8HdVWo7oqmy25CUVqqjc5+mfWyeVz
    tYMI6gNrv8klrhjmINqU12IfkvFDWlA2ru6j9khQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=KC+QXYgx x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=KC+QXYgx x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPRzT5HW+TWUohJthF+YJZ1lUjqgz4dbu5yD7tAraUZ6H+l58JPbiE+dB9VjRtfSl+r7kGYMRKFKLdS6/1lLc7tV8AbYrw7Zn5CSq5adjVhckixySQxF
    zcxev0Z3HOZy6+Fyuk5mK/MOgI2N0LmK6kSUOD7IfN+ynuFrxJjaMaj0RjoUM1WbFLPvXMl32uZD6bKXEl+AME9CqMd0shfmB0BBnSMZVU+ywvMQ4Tj22K2+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=VwQbUJbxAAAA:8 a=NCkSHYsgAAAA:8
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=NiwbD6wQrM2umdzaVFgA:9 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=AjGcO6oz07-iQ99wixmX:22 a=AnMw66Xr5OuzjdxB04dI:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966607AbeEXLrT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966805AbeEXJre (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:47:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7d26fc1eea198488deab@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 19/96] scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()
Date: Thu, 24 May 2018 11:38:02 +0200
Message-Id: <20180524093606.702135570@linuxfoundation.org>
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
@@ -1893,7 +1893,7 @@ retry:
 		num = (rem_sz > scatter_elem_sz_prev) ?
 			scatter_elem_sz_prev : rem_sz;
 
-		schp->pages[k] = alloc_pages(gfp_mask, order);
+		schp->pages[k] = alloc_pages(gfp_mask | __GFP_ZERO, order);
 		if (!schp->pages[k])
 			goto out;
 
