Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478C5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF9A2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF9A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeKPInd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:43:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbeKPInd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:43:33 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 36F0C49F;
        Thu, 15 Nov 2018 22:33:50 +0000 (UTC)
Date:   Thu, 15 Nov 2018 14:33:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     =?UTF-8?B?Y2hvdXJ5emhvdQ==?= (=?UTF-8?B?5ZGo5aiB?=) 
        <chouryzhou@tencent.com>
Cc:     "tkjos@google.com" <tkjos@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] binder: ipc namespace support for android binder
Message-Id: <20181115143349.44e1942213b61a4818bcbf02@linux-foundation.org>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F8FA41@EXMBX-SZMAIL022.tencent.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F8FA41@EXMBX-SZMAIL022.tencent.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 09:37:51 +0000 chouryzhou(周威) <chouryzhou@tencent.com> wrote:

> Currently android's binder is not isolated by ipc namespace. Since binder 
> is a form of IPC and therefore should be tied to ipc namespace. With this 
> patch, we can run multiple instances of  android container on one host.
> 
> This patch move "binder_procs" and "binder_context" into ipc_namespace,
> driver will find the context from it when opening. For debugfs, binder_proc
> is namespace-aware, but not for binder dead nodes, binder_stats and 
> binder_transaction_log_entry (we added ipc inum to trace it).
> 
> ...
>
>  drivers/android/binder.c      | 133 ++++++++++++++++++++++++++++++++----------
>  include/linux/ipc_namespace.h |  15 +++++
>  ipc/namespace.c               |  10 +++-
>  3 files changed, 125 insertions(+), 33 deletions(-)

Well, it's mainly an android patch so I suggest this be taken via the
android tree.

Acked-by: Andrew Morton <akpm@linux-foundation.org>

