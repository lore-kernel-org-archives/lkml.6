Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4089336-1519168926-2-17014407363929111450
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519168925; b=kMIYh5go+/087AtfcvBEA/uVy0RqbHLz/77vhhMEBcLJLdc
    m2IHvFQLnlx6bWrzggfhmH+hwpVJIHx2m7kpG1OHB81DY5DU/KtI7iyOf2JdlTT3
    NHSGiE3sOIHg2K1TywDdUj7e6kIBO+ztpfR7uZbZWIsFlBF53HT1G+8Sydeh8vWr
    vYwFrMKj0ppAUQ+A/H8SxpI6sS5LI5Ugd0USem3h0Dc5bOgal3jygZfX+Pv7P13Z
    MJE35jtWAHod8laU3f9bEKGXtFtl+U4IGU7MA+Sw+yIaywAWYGqWQf3AVKRVYTEf
    /WJ+S8ttcKNvIGwT3AlQiY9rb/+icEoM1dOyTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519168925; bh=4BRs2G0+5R8YhBo6WODNcmSDUYYFcof9LkgV1h/DWiI=; b=I
    qyT3DXHLIW4DXL25pErIvRYsmk9QCo8erJKRYevFquKDve7G6iRR6XxiiPrbLHwZ
    ViDKv344tjYNn9qPjxKamyHB4SuHUgpkF9sTXPf9CxUefxBiZDOrHxiPGGDWoZA8
    4A0kXoBEMFUlOQcyM+v2nkzaz3b50ohqGvpqiHD0F+h0tmIRNtX/EZNzaT9yx/E2
    ekDj1PzrgYZqx20Gch8g7uAaZ9Wk5G1FPJwmKDTnuKAWuJ9CsD7TYwmwJwErPy5O
    nCAe3apg7/L775yE0yAA9H3afQucjmD1s9Pj0lrWU2qv8qTxXPGMD4LAe67BMkTS
    zXnyHajma74rmby6yrHNA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeBTXVy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 18:21:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeBTXVu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 18:21:50 -0500
Date: Tue, 20 Feb 2018 15:21:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: kbuild test robot <lkp@intel.com>
Cc: Juergen Gross <jgross@suse.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, mhocko@suse.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: don't defer struct page initialization for Xen pv
 guests
Message-Id: <20180220152148.2a3ff03d3c8aa6ade8cbae25@linux-foundation.org>
In-Reply-To: <201802190217.ctfr9bPI%fengguang.wu@intel.com>
References: <20180216133726.30813-1-jgross@suse.com>
        <201802190217.ctfr9bPI%fengguang.wu@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Feb 2018 02:45:27 +0800 kbuild test robot <lkp@intel.com> wrote:

> [auto build test ERROR on mmotm/master]
> [also build test ERROR on v4.16-rc1 next-20180216]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Juergen-Gross/mm-don-t-defer-struct-page-initialization-for-Xen-pv-guests/20180218-233657
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: i386-randconfig-x010-201807 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    mm/page_alloc.c: In function 'update_defer_init':
> >> mm/page_alloc.c:352:6: error: implicit declaration of function 'xen_pv_domain' [-Werror=implicit-function-declaration]
>      if (xen_pv_domain())
>          ^~~~~~~~~~~~~

I think I already fixed this.



From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-dont-defer-struct-page-initialization-for-xen-pv-guests-fix

explicitly include xen.h

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN mm/page_alloc.c~mm-dont-defer-struct-page-initialization-for-xen-pv-guests-fix mm/page_alloc.c
--- a/mm/page_alloc.c~mm-dont-defer-struct-page-initialization-for-xen-pv-guests-fix
+++ a/mm/page_alloc.c
@@ -46,6 +46,7 @@
 #include <linux/stop_machine.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
+#include <xen/xen.h>
 #include <linux/backing-dev.h>
 #include <linux/fault-inject.h>
 #include <linux/page-isolation.h>
_
