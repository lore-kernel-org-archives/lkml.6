Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1899C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FD32083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FD32083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeLHA1v convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:27:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHA1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:27:51 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6943892;
        Sat,  8 Dec 2018 00:27:49 +0000 (UTC)
Date:   Fri, 7 Dec 2018 16:27:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com,
        alexander.h.duyck@linux.intel.com, hannes@cmpxchg.org,
        miles.chen@mediatek.com, n-horiguchi@ah.jp.nec.com
Subject: Re: [PATCH] /proc/kpagecount: return 0 for special pages that are
 never mapped
Message-Id: <20181207162748.c68d0cd3565cf2b99a28c388@linux-foundation.org>
In-Reply-To: <2f3606d3-ab1f-1d3e-4514-28db69a47eb2@oracle.com>
References: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
        <20181205004836.GU10377@bombadil.infradead.org>
        <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
        <20181205012534.GW10377@bombadil.infradead.org>
        <540f7690-5fcd-04d6-edb3-a44ebd09e70c@oracle.com>
        <20181205194409.GB11646@bombadil.infradead.org>
        <d9fa0325-690d-47cc-fc49-2606855f6a4f@oracle.com>
        <20181206042631.GA24603@bombadil.infradead.org>
        <2f3606d3-ab1f-1d3e-4514-28db69a47eb2@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 22:07:37 -0800 Anthony Yznaga <anthony.yznaga@oracle.com> wrote:

> Would you like me to submit a revised patch?  An -mm tree diff?

Either is OK.  I usually turn replacemensts into deltas so we can see
what changed.

