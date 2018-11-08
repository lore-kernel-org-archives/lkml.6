Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221EC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8154E20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8154E20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeKIIaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:30:25 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbeKIIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:30:25 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 091E7A7A;
        Thu,  8 Nov 2018 22:52:40 +0000 (UTC)
Date:   Thu, 8 Nov 2018 14:52:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Chintan Pandya <cpandya@codeaurora.org>,
        David Rientjes <rientjes@google.com>,
        Joe Perches <joe@perches.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:vmalloc add vm_struct for vm_map_ram
Message-Id: <20181108145239.f8249da5833974bad286fb78@linux-foundation.org>
In-Reply-To: <1541675689-13363-1-git-send-email-huangzhaoyang@gmail.com>
References: <1541675689-13363-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Nov 2018 19:14:49 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> There is no caller and pages information etc for the area which is
> created by vm_map_ram as well as the page count > VMAP_MAX_ALLOC.
> Add them on in this commit.

Well I can kind of see what this is doing - it increases the amount of
info in /proc/vmallocinfo for regions which were created by
vm_map_area(), yes?

But I'd like to hear it in your words, please.  What problem are we
trying to solve?  Why is it actually a problem?  Why is the additional
information considered useful, etc?

It would help a lot if the changelog were to include before-and-after
examples from the /proc/vmallocinfo output.

Thanks.
