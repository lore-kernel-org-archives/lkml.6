Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5C8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB0921473
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB0921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391099AbeGLByD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:54:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60380 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732747AbeGLByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:54:03 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CE4B1CD0;
        Thu, 12 Jul 2018 01:46:56 +0000 (UTC)
Date:   Wed, 11 Jul 2018 18:46:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Lu, Aaron" <aaron.lu@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "Wang, Kemi" <kemi.wang@intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC PATCH] mm, page_alloc: double zone's batchsize
Message-Id: <20180711184655.23638dfdc29f57c6b70732f4@linux-foundation.org>
In-Reply-To: <9f778198327e62cdab0651382740189e0665507a.camel@intel.com>
References: <20180711055855.29072-1-aaron.lu@intel.com>
        <20180711143505.5ccb378fb67dc6ba8fa202a3@linux-foundation.org>
        <9f778198327e62cdab0651382740189e0665507a.camel@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 01:40:41 +0000 "Lu, Aaron" <aaron.lu@intel.com> wrote:

> Thanks Andrew.
> I think the credit goes to Dave Hansen

Oh.  In that case, I take it all back.  The patch sucks!
