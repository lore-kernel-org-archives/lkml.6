Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF18C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED50A208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfAJTbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:31:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35529 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfAJTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:31:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so5622844plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 11:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dtEbHdOY1NOMIPHMwb3aw+WsI5CLq4/Nk9FZ+zWWgIA=;
        b=KHBWj76Inx9PnwN5GVVihZNn/YHcwFt9GHOjH22wDmDGCicYTxukpCkBsnsPzXDOGj
         OujgOTDTw0ly9wOsRL0lEThoiXnpimghXyBsyBYweftNW5tQjtaln0y8y2cEXUuk2d+B
         hxqa+YkkLdT5lr9kOLuCTJs61n+tbLIywTBd00k83JSfUtHJ8HU38foBxrMLSimVbMUT
         8sGeDefKSNtXCO6eNQW1naaj34wfE+yShIl5BtwIl3ecno7hKvDKI8gbyWkOTDpRzB1c
         OiGHuBy7NEvkMY4GH8V7Yp0Z2HzSMZin9+IcT+be9t9mk97RlHyTgyARFgGiSiJ4H5RH
         kUSw==
X-Gm-Message-State: AJcUukfBDBlVkYgJvGMj6r3EcrMIUornBpxVQQWCE3g5C9ELa+Nrx0ZH
        nFC94A0ME2CO4iYEWqLcsLP7mlLQ
X-Google-Smtp-Source: ALg8bN5zUfQ1c41PjFPDk2KZAarUfGdI/AK3fClQp9teSgFflVv1CWPqykalw5zy4k7OZ88ORpNnHQ==
X-Received: by 2002:a17:902:680f:: with SMTP id h15mr11442096plk.40.1547148674672;
        Thu, 10 Jan 2019 11:31:14 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m9sm88996285pgd.32.2019.01.10.11.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 11:31:13 -0800 (PST)
Message-ID: <1547148671.83374.54.camel@acm.org>
Subject: Re: [PATCH v5 07/15] locking/lockdep: Free lock classes that are no
 longer in use
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Date:   Thu, 10 Jan 2019 11:31:11 -0800
In-Reply-To: <20190110152804.GH30894@hirez.programming.kicks-ass.net>
References: <20181217213002.73776-1-bvanassche@acm.org>
         <20181217213002.73776-8-bvanassche@acm.org>
         <20190110152804.GH30894@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-10 at 16:28 +-0100, Peter Zijlstra wrote:
+AD4 On Mon, Dec 17, 2018 at 01:29:54PM -0800, Bart Van Assche wrote:
+AD4 +AD4 +-static bool inside+AF8-selftest(void)
+AD4 +AD4 +-+AHs
+AD4 +AD4 +-	return current +AD0APQ lockdep+AF8-selftest+AF8-task+AF8-struct+ADs
+AD4 +AD4 +-+AH0
+AD4 +AD4 +-void lockdep+AF8-free+AF8-key+AF8-range(void +ACo-start, unsigned long size)
+AD4 +AD4 +-+AHs
+AD4 +AD4 +-	init+AF8-data+AF8-structures+AF8-once()+ADs
+AD4 +AD4 +-
+AD4 +AD4 +-	if (inside+AF8-selftest())
+AD4 +AD4 +-		lockdep+AF8-free+AF8-key+AF8-range+AF8-imm(start, size)+ADs
+AD4 +AD4 +-	else
+AD4 +AD4 +-		lockdep+AF8-free+AF8-key+AF8-range+AF8-reg(start, size)+ADs
+AD4 +AD4  +AH0
+AD4 
+AD4 That is .... unfortunate. The whole reason that whole immediate thing
+AD4 works at all is because there is no concurrency what so ever that early,
+AD4 right?
+AD4 
+AD4 Should we maybe key off of: 'system+AF8-state +AD0APQ SYSTEM+AF8-BOOTING' instead?

Hi Peter,

I agree that it is unfortunate that the selftests require a different code
path. I have not been able to find any way to avoid this. Using the test
system+AF8-state +AD0APQ SYSTEM+AF8-BOOTING should work and will allow to remove the
lockdep+AF8-selftest+AF8-task+AF8-struct variable. Do you want me to make that change?

Bart.
