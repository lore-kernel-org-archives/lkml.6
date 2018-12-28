Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1719DC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D224721909
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 03:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCWAPT+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeL1DAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 22:00:22 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:33044 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeL1DAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 22:00:21 -0500
Received: by mail-pg1-f171.google.com with SMTP id z11so9512340pgu.0;
        Thu, 27 Dec 2018 19:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B0KcbdISQxMDURvBYdZRZkDvHnvIz0sadA1OpI96xMs=;
        b=DCWAPT+9sUNIpf30LR1rvl0hd6HEsis7Ey4wk/kFqSDG8H3G2Qd/dOnZMu2l9OpH1D
         O310wuEBr09WVIRURqXHyRPHy+oVzLQdgc4lhAizrvAPDJ68fwEB9vK1Cdcs0s6CNs4N
         a19xnBzoqaTeVeotMItWysHQX0GwFBbTM4stbbEh37MIxft2PTJRra8mgmxPh0Q04LIC
         ZJyvV8qe5uCxjwpAQIO9g2x6HWRNcl/scQInjw2oENYvF/pS4N/acmzPcRWaIq7wEdNw
         RKBX1dMyQPAFPwCJMutSSb0+j61Cl7CspDs2ztSbzvQRuDvJIbf0terudMLt5SFpr17E
         a0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B0KcbdISQxMDURvBYdZRZkDvHnvIz0sadA1OpI96xMs=;
        b=q5R+qaUC0qDQisJo06j93/iCwkh7+/RqNbu39E5Zs/Q84N1uGpM6WCikbWI3y4cWZq
         o28Ag1nmtrINHQ7JRq+6DyeN4+u+cHjJKu72aRFwyu4+OcgAx75YZktOh151VACKBB8A
         4o7L2VM9ysxndADfidf/Tq7uL+i0SS1ZUS7kuM56NK0BexYjgSyG5kjX4AAzOweykLtB
         L6HuOpWQ7JWZOb1QjVMGbS6GfNxuNjCss3U2QE4GpH/S2Ss9jNriFLCd2qZgiknPAa9q
         rUY7I2ghdo0ZPcCHlJKHNi5EAM/3CsQehD7o1fD0hLbe0g8YBiao4hVFr8F5b61Kzv75
         0fjw==
X-Gm-Message-State: AJcUukeuC4jEl0YeYCE6UCOvYgoILxGQw3+SHtbes62s9ZrBSgcpqr6c
        J0oka/tprTTktbchJ6F1n10gBEMmFkeO
X-Google-Smtp-Source: ALg8bN5strZiiM+X1VTj9znfwwVkjPpFWqClRU3rxHo4lUfVFYdNOidqJnm1eDl93LrNTJfO+oWEjA==
X-Received: by 2002:a63:f241:: with SMTP id d1mr24967448pgk.2.1545966020250;
        Thu, 27 Dec 2018 19:00:20 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 202sm80185958pfy.87.2018.12.27.19.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 19:00:19 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        kexec@lists.infradead.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Daniel Vacek <neelx@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Stefan Agner <stefan@agner.ch>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCHv3 0/2] mm/memblock: reuse memblock bottom-up allocation style
Date:   Fri, 28 Dec 2018 11:00:00 +0800
Message-Id: <1545966002-3075-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bottom-up allocation style is introduced to cope with movable_node,
where the limit inferior of allocation starts from kernel's end, due to
lack of knowledge of memory hotplug info at this early time.
Beside this original aim, 'kexec -c' prefers to reuse this style to alloc mem
at lower address, since if the reserved region is beyond 4G, then it requires
extra mem (default is 16M) for swiotlb. But at this time hotplug info has been
got, the limit inferior can be extend to 0, which is done by this series

Cc: Tang Chen <tangchen@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Daniel Vacek <neelx@redhat.com>
Cc: Mathieu Malaterre <malat@debian.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: yinghai@kernel.org,
Cc: vgoyal@redhat.com
Cc: linux-kernel@vger.kernel.org

Pingfan Liu (2):
  mm/memblock: extend the limit inferior of bottom-up after parsing
    hotplug attr
  x86/kdump: bugfix, make the behavior of crashkernel=X consistent with
    kaslr

 arch/x86/kernel/setup.c  |  9 +++++---
 drivers/acpi/numa.c      |  4 ++++
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 58 +++++++++++++++++++++++++++++-------------------
 4 files changed, 46 insertions(+), 26 deletions(-)

-- 
2.7.4

