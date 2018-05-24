Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161598-2-1593274063076266628
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
    1527161597; b=LygnXULobei9nFlO0851Am4iOmfpbHn6D7OYQwP3KNDhgdGgI0
    QwqHjia6nvcKMr2UnxuF0/c+G+uXqtsqcDhl8mGU6JoIOmvZoLqGOtTJ0DVApJgr
    ErLmTBoTXFxK9nlXjE7UmoD3GaEMD64agFK3avAMKuKW69vwv5vg1EyU5/+YdMVY
    xVz1Y0ZAO9GiuW1BcNKkMrKEvNHkE+wGLWoGB9aDdJVqvRnsN3RTd11dXtPTqxVM
    9Bmh72G7hkZHZM/RGbAT6gzXnJ6LwvRDJP8iKWu0lEWW7XcmZkx1i/Ok3H9d1RnP
    vPREiEr+PFHn+Y7e5Yy0B7/kn1dRfclajhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161597; bh=talO8KWNjsC7hlRFUWDhyqT67kadIA
    Lvr21aCqmo1JQ=; b=QxF39Wm11dauwGMXR9/O8H/fPcn1KUJmuHbH4VXyHder3p
    8uYU1zGOuVR/ZjGzWUMRVJ443ZZ28CqfxOdmWRa6Hwd3JI0lHMUB0GOoRNBLzuIr
    P0yGqHh34b69v/TBMqJVF7nHxg0esYencOJddkJb5wLzjROxCOJDpGxmuGVHOO1e
    aepqlrNQSnXVdm10jzFFzMTjBFigh1qvumcCCVDmfT5BugvVlOochrMy+4f0wHmJ
    Xyq5EskjCNNbU2ChROqsSD38w/s29cvpkw8Ox6RPlR7xeC3nqUfyYuTn4tN67E15
    uwzGsoFF8+LSs/EW+7HgEjoqdErzLbnURfwVC/Zw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=KtBlaVuj x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=KtBlaVuj x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAZTtRXBJwP4O3qcCpBCqisEojeDOfeOQAcs6Y9B/t/vZ/jXxAvBW14gZxgO7W+73EPmAwbhID0wd8B2BGnIp6gUIEI7QfQm6vDrdlKkC2OrdKlEZcGN
    ssdZsgw4HKWmPhltRzee3mW+6XCUrxj4PP3j3hNliRO2dyHMKtHcloEjppXJuCljt+udCA3hZh2WaAXdmh3EVJR2WyMjGNaO8oWu1/07yJFqi65EBoRvsXej
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8 a=hD80L64hAAAA:8 a=AUd_NHdVAAAA:8
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=JHlJ25WvbeUrrig5_RoA:9
    a=cEHXsWEmiPyLhQHg:21 a=v1TNNCpcVkbh9PmG:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=L0NDqeB7ZLmQzAogN4cw:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967650AbeEXLdA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:33:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967102AbeEXJuf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Takao Orito <orito.takao@socionext.com>,
        Fumihiro ATSUMI <atsumi@infinitegra.co.jp>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 84/96] media: vb2: Fix videobuf2 to map correct area
Date: Thu, 24 May 2018 11:39:07 +0200
Message-Id: <20180524093610.216394292@linuxfoundation.org>
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

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit d13a0139d7874a0577b5955d6eed895517d23b72 ]

Fixes vb2_vmalloc_get_userptr() to ioremap correct area.
Since the current code does ioremap the page address, if the offset > 0,
it does not do ioremap the last page and results in kernel panic.

This fixes to pass the size + offset to ioremap so that ioremap
can map correct area. Also, this uses __pfn_to_phys() to get the physical
address of given PFN.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Takao Orito <orito.takao@socionext.com>
Reported-by: Fumihiro ATSUMI <atsumi@infinitegra.co.jp>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/videobuf2-vmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/v4l2-core/videobuf2-vmalloc.c
+++ b/drivers/media/v4l2-core/videobuf2-vmalloc.c
@@ -104,7 +104,7 @@ static void *vb2_vmalloc_get_userptr(str
 			if (nums[i-1] + 1 != nums[i])
 				goto fail_map;
 		buf->vaddr = (__force void *)
-				ioremap_nocache(nums[0] << PAGE_SHIFT, size);
+			ioremap_nocache(__pfn_to_phys(nums[0]), size + offset);
 	} else {
 		buf->vaddr = vm_map_ram(frame_vector_pages(vec), n_pages, -1,
 					PAGE_KERNEL);
