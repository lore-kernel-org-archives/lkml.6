Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD17C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A6124075
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A6124075
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeGEVyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:54:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58734 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbeGEVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:54:20 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9CA62E50;
        Thu,  5 Jul 2018 21:54:19 +0000 (UTC)
Date:   Thu, 5 Jul 2018 14:54:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Tian, Baofeng" <baofeng.tian@intel.com>
Cc:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhuang, Qihua" <qihua.zhuang@intel.com>
Subject: Re: [PATCH] reboot: add reboot_panic parameter
Message-Id: <20180705145418.67fbcebca351c2d1142f3475@linux-foundation.org>
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D75@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADD8C@shsmsx102.ccr.corp.intel.com>
        <EEBA739CCF11FE49B73E1FB4690F5EE649E1B93B@shsmsx102.ccr.corp.intel.com>
        <20180702143057.1ca20a97ddfb91056010cec8@linux-foundation.org>
        <EEBA739CCF11FE49B73E1FB4690F5EE649E29D75@SHSMSX101.ccr.corp.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jul 2018 06:47:37 +0000 "Tian, Baofeng" <baofeng.tian@intel.com> wrote:

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@linux-foundation.org] 
> Sent: Tuesday, July 3, 2018 5:31 AM
> To: Tian, Baofeng <baofeng.tian@intel.com>
> Cc: andrew.smirnov@gmail.com; linux-kernel@vger.kernel.org; Zhuang, Qihua <qihua.zhuang@intel.com>
> Subject: Re: [PATCH] reboot: add reboot_panic parameter
> 
> On Mon, 2 Jul 2018 02:20:59 +0000 "Tian, Baofeng" <baofeng.tian@intel.com> wrote:
> 
> > This "reboot_panic" kernel cmdline parameter allow to change the 
> > reboot mode in case of panic only. It use the same format as the 
> > "reboot" parameter.
> > Example, for cf9 warm reset in case of panic: reboot_panic=p,w 
> > currently it only support cold/warm reset in case of panic.
> 
> Why should we do this?  What are the benefits, what are the usecases, etc?  
> 
> Some user-facing documentation should clear that up.  `grep -r reboot= Documentation' will direct you to the appropriate places.
> 

(top-posting repaired.  Please don't top-post)

> Hi, Morton

"Andrew" :)

> On android platform, if use adb reboot, it will automatically reboot with cold reset.
> cold reset will reset RAM and cause RAM lose data information, if we want to enable some debug features
> like pstore, and ramdump etc, warm reset is needed to keep RAM across reset
> 
> So, we add this interface to allow people to set reboot as warm to get log data across reset.
> 

OK, sounds good.  Please add this info to the changelog, add the user
documentation and resend.

