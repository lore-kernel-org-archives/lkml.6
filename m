Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479878-2-7574871666133376338
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479877; b=Dlt6zQ3JnxEqNjJU9ouj52nLgwQBWIN1ZP3srLJ2q8Zblv4zKO
    pno+ErPLG7kiNmctvTicU36qnHYQXTIg85dXlei6Gm8vtgnHfFRFDUFXuM6gN5DF
    FSDtnjkyJzznzvagRjXOz9C3d+RUZNlFEC7lnaE4i8CBJD9Wy3Ol4BBitrrDMdgI
    Dn3idxtqHHnTTqzHHAxghxonsPFZLYK3tRH84pI0LqFf80E/OzxiiUGk9dPEXAB9
    bXpKL0NFr26sA8lR8BicN6jWMvRQR1MfJKe/xEfU5uThd6laSt8joKqlmXEzvTsM
    W4xZl0z3bDEU+/jET+ueZUGej8E5M7tt+2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479877; bh=h7aP7L1xvk/qvC04XbWoWLbF3RDl/g
    DdVcpFnEPaQC0=; b=JGGAmKveQIk3I7IFVYgSlTRRWRNqaYII5XbIi0xLBa01dr
    BZyN+hur2i4T2d1oM1DVWA3PprzONTiE6gO6qEBpcaEwX2plCDC9zb+lvBfQr1Lr
    s++R64HpbphIlGVU+KB84MLgE5+38uqo0ThEtzScWMQwlhI9IF+DfUuusD9nLrux
    +6DPfSyQxzucb/1226OBgerX8w2JPuka3rdxO/v8sOu6+UkpKRRT0GOian+arLxH
    LIQd1XhbOtyTNy4E2S2Z/ovYujho1O9Gr7rXJomOWtss8pR3o47VVTycKpISnFsm
    CU3KfKFYJU9HrA2SMTO6Cjg7aK7BMo4lLR83aHgQ==
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
X-CM-Envelope: MS4wfEHWnFKltAXteBe4COB3x0BaCP3CI25A/gG3m1z1axmvRgqpxFCucv/P+TOMrYYMuNnoK8YW7OW4zKi6RS1Ca6EuLJ7CT0z880fS9Cl2ALVvzNdwcLQV
    Ewhhn4X/9HtI9RHvXVj5e6xH0+Jz0f2YgcX8grM0FBteeS5Gih/ukJVX5YlOfTT04hUAOjrL8XWrMBVLm5otg7kd0geAEpDn9zB5wvdH3f/Qv+2zUCR1x+06
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=voM4FWlXAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=usRbeA9v8uJKUopLpoQA:9 a=geZljYdC0cXtsTJ8:21 a=_S9BWLtnSfCgJfAo:21
    a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754801AbeDKSpm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932321AbeDKSpk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Breno Leitao <breno.leitao@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 051/190] powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash
Date: Wed, 11 Apr 2018 20:34:57 +0200
Message-Id: <20180411183553.284311483@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>


[ Upstream commit e41e53cd4fe331d0d1f06f8e4ed7e2cc63ee2c34 ]

virt_addr_valid() is supposed to tell you if it's OK to call virt_to_page() on
an address. What this means in practice is that it should only return true for
addresses in the linear mapping which are backed by a valid PFN.

We are failing to properly check that the address is in the linear mapping,
because virt_to_pfn() will return a valid looking PFN for more or less any
address. That bug is actually caused by __pa(), used in virt_to_pfn().

eg: __pa(0xc000000000010000) = 0x10000  # Good
    __pa(0xd000000000010000) = 0x10000  # Bad!
    __pa(0x0000000000010000) = 0x10000  # Bad!

This started happening after commit bdbc29c19b26 ("powerpc: Work around gcc
miscompilation of __pa() on 64-bit") (Aug 2013), where we changed the definition
of __pa() to work around a GCC bug. Prior to that we subtracted PAGE_OFFSET from
the value passed to __pa(), meaning __pa() of a 0xd or 0x0 address would give
you something bogus back.

Until we can verify if that GCC bug is no longer an issue, or come up with
another solution, this commit does the minimal fix to make virt_addr_valid()
work, by explicitly checking that the address is in the linear mapping region.

Fixes: bdbc29c19b26 ("powerpc: Work around gcc miscompilation of __pa() on 64-bit")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Tested-by: Breno Leitao <breno.leitao@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/page.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -132,7 +132,19 @@ extern long long virt_phys_offset;
 #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
 #define virt_to_page(kaddr)	pfn_to_page(virt_to_pfn(kaddr))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
+
+#ifdef CONFIG_PPC_BOOK3S_64
+/*
+ * On hash the vmalloc and other regions alias to the kernel region when passed
+ * through __pa(), which virt_to_pfn() uses. That means virt_addr_valid() can
+ * return true for some vmalloc addresses, which is incorrect. So explicitly
+ * check that the address is in the kernel region.
+ */
+#define virt_addr_valid(kaddr) (REGION_ID(kaddr) == KERNEL_REGION_ID && \
+				pfn_valid(virt_to_pfn(kaddr)))
+#else
 #define virt_addr_valid(kaddr)	pfn_valid(virt_to_pfn(kaddr))
+#endif
 
 /*
  * On Book-E parts we need __va to parse the device tree and we can't
