Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DEAR_SOMETHING,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17CB218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfBKT5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:57:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732675AbfBKT5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:57:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 90A54A7878;
        Mon, 11 Feb 2019 19:57:10 +0000 (UTC)
Received: from redhat.com (ovpn-123-21.rdu2.redhat.com [10.10.123.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 613048517;
        Mon, 11 Feb 2019 19:57:09 +0000 (UTC)
Date:   Mon, 11 Feb 2019 14:57:07 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Krzysztof Grygiencz <kfgz@interia.pl>
Cc:     dan.j.williams@intel.com, akpm@linux-foundation.org,
        dri-devel@lists.freedesktop.org, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        logang@deltatee.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v8 3/7] mm, devm_memremap_pages: Fix shutdown handling
Message-ID: <20190211195706.GE3908@redhat.com>
References: <30d86b36-8421-f899-205e-4b9c6a5fcc9d@interia.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30d86b36-8421-f899-205e-4b9c6a5fcc9d@interia.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 11 Feb 2019 19:57:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 12:09:08PM +0100, Krzysztof Grygiencz wrote:
> Dear Sir,
> 
> I'm using ArchLinux distribution. After kernel upgrade form 4.19.14 to
> 4.19.15 my X environment stopped working. I have AMD HD3300 (RS780D)
> graphics card. I have bisected kernel and found a failing commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v4.19.20&id=ec5471c92fb29ad848c81875840478be201eeb3f

This is a false positive, you should skip that commit. It will not impact
the GPU driver for your specific GPUs. My advice is to first bisect on
drivers/gpu/drm/radeon only.

Cheers,
Jérôme
