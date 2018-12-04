Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C670C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E894320851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E894320851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLDWtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:49:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLDWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:49:45 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C04128A5;
        Tue,  4 Dec 2018 22:49:43 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:49:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
        jack@suse.cz
Subject: Re: [PATCH 1/4] mm: infrastructure for page fault page caching
Message-Id: <20181204144942.63c98a3147071f054d77427d@linux-foundation.org>
In-Reply-To: <20181130195812.19536-2-josef@toxicpanda.com>
References: <20181130195812.19536-1-josef@toxicpanda.com>
        <20181130195812.19536-2-josef@toxicpanda.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 14:58:09 -0500 Josef Bacik <josef@toxicpanda.com> wrote:

> We want to be able to cache the result of a previous loop of a page
> fault in the case that we use VM_FAULT_RETRY,

Please explain here why we want to do that.

> so introduce
> handle_mm_fault_cacheable that will take a struct vm_fault directly, add
> a ->cached_page field to vm_fault, and add helpers to init/cleanup the
> struct vm_fault.
> 
> I've converted x86, other arch's can follow suit if they so wish, it's
> relatively straightforward.
> 

