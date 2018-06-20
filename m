Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01FFC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CC920872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CC920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754167AbeFTOQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752856AbeFTOQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:16:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B012B20872;
        Wed, 20 Jun 2018 14:16:38 +0000 (UTC)
Date:   Wed, 20 Jun 2018 10:16:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namit Gupta <gupta.namit@samsung.com>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, himanshu.m@samsung.com
Subject: Re: [PATCH] printk: remove unnecessary kmalloc() from syslog during
 clear
Message-ID: <20180620101637.16c6aa15@gandalf.local.home>
In-Reply-To: <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
References: <CGME20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2@epcas5p3.samsung.com>
        <20180620135951epcas5p3bd2a8f25ec689ca333bce861b527dba2~54wyKcT0_3155531555epcas5p3y@epcas5p3.samsung.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018 19:26:19 +0530
Namit Gupta <gupta.namit@samsung.com> wrote:

> When the request is only for clearing logs, there is no need for
> allocation/deallocation. Only the indexes need to be reset and returned.
> Rest of the patch is mostly made up of changes because of indention.

Thanks for the update!

> 
> Signed-off-by: Namit Gupta <gupta.namit@samsung.com>
> Signed-off-by: Himanshu Maithani <himanshu.m@samsung.com>
> ---
>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
