Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214857-2-15721870371481661132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214857; b=E+UOZ0Lgn2F8Z3bGC/r7+YAL7kSWgMSpzRDDbMUSU6Ow0Oi
    c/cFwS5XmuRa8jcdv95DA/gDJ/OFTqFPoKmNm+u/cEGHf9JA7UJp/1Ybw/Xt46No
    AhUxdwqbrMiLwH3z6Y+kfW4gzTcOeUPfEikZc/5UW43okjKOKx5sbJRk9AeMeFRj
    y1FwjfBvEp9zO5M8s/BNMHDmxvDl4Ki1y2ssz+LglhVsIpJwHgLob9fgXHLwpTNE
    75tbEuqwvLhYFsFBgKRhTkA0TeruIg6Kz/f3J0TX3Upywt3dFe1lWGv8l8keF/3/
    z1PkVjWHJTj1p8ZubpJmclPVYDO2J0q1cvi7Ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214857; bh=uHf5EvIm4RhexKjmXexFMe4tBS
    0NU6dDgxX/AKZbcug=; b=H/qdb/ThFD7yQzh0qnziufjVNdNi2xVz4CKWa72ru7
    68Xv6qBi7mUvgTY/rUFTRzMF/HO06BMG+e2MB8p1Rih4+yBBObMZ31YrFxtFSxq8
    FQXLYEHdNi9c8vFeZl2sZxeJVXrs+RCSah4SNCff4d0FOXiL34aJd/wDdwKbQXpx
    gugAah64EP/w80pGhguDDCilz/qJ1D0h1bjqq6apHM/SGgCiZhICtvCdhVX3P49q
    /giW2SppcOv8/nakHWXnT870iXCw3PycZTlY6kQyAx1Oy0qM8QFftcLQkKNf+/ZL
    iF4EBlA5E1NOgEjwrVU0iLJsRcHYT2jXFTwRXSO9zN1w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964880AbeCPPkn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:40:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43722 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965090AbeCPPkj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:40:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 035/128] KVM: PPC: Book3S HV: Fix typo in kvmppc_hv_get_dirty_log_radix()
Date: Fri, 16 Mar 2018 16:22:56 +0100
Message-Id: <20180316152338.403223417@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Mackerras <paulus@ozlabs.org>


[ Upstream commit 117647ff936e2d9684cc881d87c0291f46669c20 ]

This fixes a typo where the intent was to assign to 'j' in order to
skip some number of bits in the dirty bitmap for a guest.  The effect
of the typo is benign since it means we just iterate through all the
bits rather than skipping bits which we know will be zero.  This issue
was found by Coverity.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -573,7 +573,7 @@ long kvmppc_hv_get_dirty_log_radix(struc
 		j = i + 1;
 		if (npages) {
 			set_dirty_bits(map, i, npages);
-			i = j + npages;
+			j = i + npages;
 		}
 	}
 	return 0;
