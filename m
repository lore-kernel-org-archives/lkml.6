Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2EC2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2EC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeK2JOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:14:35 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeK2JOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:14:34 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B3997B76;
        Wed, 28 Nov 2018 22:11:27 +0000 (UTC)
Date:   Wed, 28 Nov 2018 14:11:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 0/5] NestMMU pte upgrade workaround for mprotect
Message-Id: <20181128141126.03004299897430353c37e889@linux-foundation.org>
In-Reply-To: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
References: <20181128143438.29458-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 20:04:33 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> We can upgrade pte access (R -> RW transition) via mprotect. We need
> to make sure we follow the recommended pte update sequence as outlined in
> commit: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")
> for such updates. This patch series do that.

The mm bits look (mostly) OK to me.  I suggest all these be merged via
the appropriate powerpc tree.
