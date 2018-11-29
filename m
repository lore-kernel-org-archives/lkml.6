Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E22EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B22620989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B22620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeK3D4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:56:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39381 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeK3D4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:56:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so1177912pgl.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 08:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sd7vjG1hU+eq8qo1zPXNz4jA1sgUefcsZ8Qzqn2YYPg=;
        b=tRnPZk9Wr3puRXT/C2OQHRRiMzEUnsTEQLVlEOT+ZYlRpEpySivdAStnD1sNRNXoNh
         myrpDletPdtascdDCXrJ1LJyt23oSSQkjoKveN76jsrTJwDjfZkdU4wHNuD87BtsMdJo
         d8W3MwKj8vlbVQsQc0KRN1tERsxZvouT2XaBoTUuFCoD05tORo1TvOrerEDf/8v09O1M
         9yM/KSQQKdZ1BHh7JE/m42BgAQCbYniLSoNuav1n75SbCgMWBD7SeGUa89JdLYBZMhlo
         yF3ydVhQiDC8/7CJG+Fvp4105aAdKJ4WghfQMearApSjgZ6UhK1TTwVJOGRiTVaTNOzm
         +Zmw==
X-Gm-Message-State: AA+aEWY95Fen79bFivbbX2V4md9Bf5lF6UTr/1bNFa+wUsr+9VkPm+E+
        vLTCJ/2AXxaLUdItY+sZWIA=
X-Google-Smtp-Source: AFSGD/VmpRydVILt+e4IPwyDIw9gZQUYkAFimPdZPDIhcVNwVVaq68UBjeSmJz3x7T6x50SO2XNwrQ==
X-Received: by 2002:a63:9845:: with SMTP id l5mr1853800pgo.142.1543510203846;
        Thu, 29 Nov 2018 08:50:03 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p6sm3233159pfn.53.2018.11.29.08.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:50:03 -0800 (PST)
Message-ID: <1543510202.185366.140.camel@acm.org>
Subject: Re: [PATCH 23/27] locking/lockdep: Check data structure consistency
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Nov 2018 08:50:02 -0800
In-Reply-To: <20181129123039.GJ2131@hirez.programming.kicks-ass.net>
References: <20181128234325.110011-1-bvanassche@acm.org>
         <20181128234325.110011-24-bvanassche@acm.org>
         <20181129123039.GJ2131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 13:30 +-0100, Peter Zijlstra wrote:
+AD4 IIRC there were a few other sites in the series, please check them all.

OK, I will add braces around multi-line statement blocks. You may want to
know that checkpatch didn't complain about missing braces.

Bart.
