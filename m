Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D138DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82B6218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439770AbfBNVWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:22:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbfBNVWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:22:46 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7E5E8FF;
        Thu, 14 Feb 2019 21:22:45 +0000 (UTC)
Date:   Thu, 14 Feb 2019 13:22:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?=C5=81ukasz?= Siudut <lsiudut@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] psi: avoid divide-by-zero crash inside virtual machines
Message-Id: <20190214132244.8a26cc78cda17abd625534dc@linux-foundation.org>
In-Reply-To: <20190214205343.GA17084@cmpxchg.org>
References: <20190214193157.15788-1-hannes@cmpxchg.org>
        <20190214115855.76869aecd777fbd37d48f45c@linux-foundation.org>
        <20190214205343.GA17084@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 15:53:43 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> 
> 	if (now < expires)
> 
> vs.
> 
> 	if (time_before64(now, expires))
> 
> These macros always have me double check the argument order.

Yeah, me too.
