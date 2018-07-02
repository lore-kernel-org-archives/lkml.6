Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4A8C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3062075E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3062075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeGBVbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:31:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbeGBVa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:30:59 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C34AD3B;
        Mon,  2 Jul 2018 21:30:58 +0000 (UTC)
Date:   Mon, 2 Jul 2018 14:30:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Tian, Baofeng" <baofeng.tian@intel.com>
Cc:     "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhuang, Qihua" <qihua.zhuang@intel.com>
Subject: Re: [PATCH] reboot: add reboot_panic parameter
Message-Id: <20180702143057.1ca20a97ddfb91056010cec8@linux-foundation.org>
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E1B93B@shsmsx102.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADD8C@shsmsx102.ccr.corp.intel.com>
        <EEBA739CCF11FE49B73E1FB4690F5EE649E1B93B@shsmsx102.ccr.corp.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 02:20:59 +0000 "Tian, Baofeng" <baofeng.tian@intel.com> wrote:

> This "reboot_panic" kernel cmdline parameter allow to change the
> reboot mode in case of panic only. It use the same format as the
> "reboot" parameter.
> Example, for cf9 warm reset in case of panic: reboot_panic=p,w
> currently it only support cold/warm reset in case of panic.

Why should we do this?  What are the benefits, what are the usecases,
etc?  

Some user-facing documentation should clear that up.  `grep -r reboot=
Documentation' will direct you to the appropriate places.

