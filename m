Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E4C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE5A20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE5A20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeIKMpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:45:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbeIKMpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:45:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9530387916;
        Tue, 11 Sep 2018 07:47:37 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7C8D2022EEE;
        Tue, 11 Sep 2018 07:47:36 +0000 (UTC)
Date:   Tue, 11 Sep 2018 15:47:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: Add build time sanity chcek for struct page
 size
Message-ID: <20180911074733.GX1740@192.168.1.3>
References: <20180909124946.17988-3-bhe@redhat.com>
 <201809102133.gzaxoHWf%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809102133.gzaxoHWf%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 07:47:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 07:47:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 at 09:41pm, kbuild test robot wrote:
>    include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>      BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>      ^~~~~~~~~~~~~~~~
> >> mm/page_alloc.c:6852:2: note: in expansion of macro 'BUILD_BUG_ON'
>      BUILD_BUG_ON(sizeof(struct page) < min(SZ_1K, PAGE_SIZE/4));
>      ^~~~~~~~~~~~

Thanks, below code can mute the compiling warning. Will update and
repost.

+       BUILD_BUG_ON(sizeof(struct page) > min((size_t)SZ_1K, PAGE_SIZE));
