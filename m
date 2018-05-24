Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156454-5-17591468739543887055
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
    1527156454; b=HrvGprlWZVSN+y3xQ/k6HlDQjHdwH+wuBKg8XFw9s7TsqBItBj
    9/roFs0X3AO4L/4BsZ+9T8A55fgLzsB7Aef/L8Nvw4P6UbxDkLuWzMqShaRPHL+B
    McK8S4Rp6C5pcLOpgZM8nt2Xq9OVYpdDTtJ3A2Zi7nJ4mtWiBcCGdomgMJf6S2mM
    mht9Bo9MfHhokkSK65y0oamSRFwVY1oZtQsRuD2hxqSdD/+i8dNFNrqD4HMa9zEw
    U8e007E7f3JGe0a8A362LcHoWgrafrn0cmLsAEJJ4eGzyL7nlERlm9uMXXmkHc2z
    nzCKpkWdnpzq1TOwoXDM261Tgui69EKvMVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156454; bh=JVy8dUc2b+1lLlYCkF5m1jySzNlk3B
    JynxVmPspa2Zg=; b=EyGYIeRAx4sE+A1yHF6fAxBzHHWDIVF9z+Z2l1rVBUcTaE
    gxljxgUlmq6mQH2fp85l62qWnfskN0GSkuw4BT5S2WCTAsbSS7/bJPhv8Yb6Hoan
    xwgR9MCuyvYnzOuO4RHMp1kmeQx0GI402qv7Fb3RsIFUtbqmdDEfPxY7wrHICB2i
    2erkRCrsp0jxKacN/r3epavoIGNscoM908rV6xlu7gZJ+Zl0g7k1aX+/6U1Vs1Em
    Kky7Ea7VWIL0mCvYg28nyPT/RJvvawlNqNcFsOErdPoS1GSmanP2i25xTgsOBnIl
    cEvaR+1aqcezfCs4h2KjtQHiJ9ZjaFUI5M8/W2NQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HJffrwjB x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=HJffrwjB x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDGxum6zyMEPx4fFuL0WvbPDVt77CKoWowRIAtDh4H/tsQvPqeWGUT0JDCL82OAka9UiKIJ8oj4g9651Tc5pZ2dEWpy2dOWSmrWNfYc+fDDPQaZwy4yu
    ohBBEgXET/GV149x06Jx+gY9lbfWv8rdOdP0cOyxvsnsNhJtq1JDCuA0iWBgaRor6OfBywZEd16Cg05c/WE8iPb0+zeHSvWGminOOUzZ3RkTyDFzg8/oInuf
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8 a=hD80L64hAAAA:8 a=AUd_NHdVAAAA:8
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=JHlJ25WvbeUrrig5_RoA:9
    a=9KwCxeNyUdE38rif:21 a=X_IaPXt8nTruHlu4:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=L0NDqeB7ZLmQzAogN4cw:22 a=NGXS0kB0m_rannUenejW:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031277AbeEXKGZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031712AbeEXKGX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:23 -0400
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
Subject: [PATCH 4.16 142/161] media: vb2: Fix videobuf2 to map correct area
Date: Thu, 24 May 2018 11:39:27 +0200
Message-Id: <20180524093035.382416519@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -106,7 +106,7 @@ static void *vb2_vmalloc_get_userptr(str
 			if (nums[i-1] + 1 != nums[i])
 				goto fail_map;
 		buf->vaddr = (__force void *)
-				ioremap_nocache(nums[0] << PAGE_SHIFT, size);
+			ioremap_nocache(__pfn_to_phys(nums[0]), size + offset);
 	} else {
 		buf->vaddr = vm_map_ram(frame_vector_pages(vec), n_pages, -1,
 					PAGE_KERNEL);
