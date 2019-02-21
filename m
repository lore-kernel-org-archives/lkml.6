Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9842077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfBUWCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:02:09 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45908 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfBUWCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:02:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so60968pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8QBqpDUpvDWAeQ7RLyFqYXh3CNt74MmqIg1Gn/cYipY=;
        b=pFpy6xcA5GJEr2BbQhbxwucw4K7kkGChaOfbRvleLgTqpklgBYKsMxRf1cheOQorYj
         Veq2HEuAhnYaptDTMeKUsJJ3KUSZ1vkBFumGtIMnU60yPaYBAi2P+gcvodQAb4npGd00
         mhOcM//VnPEsnYa/GXiF1SQtg/Wwqwk3capPwevkM0bX45KEHVmTIXaWPN03B4AP3hDa
         pkYWVXJM3gIZ2EnkNgWku/b++QQL//JI4ub7X7M8fGV0zWVMVBY/QRFsgAsw3z/7JYcu
         Z0fh9F1dLXtbMkzZHjiwna/fqLkUZHCPr5RcMcB/27SQsLpG71XkCcMqud+MU8ucbDtb
         +54w==
X-Gm-Message-State: AHQUAuaFo2zU+5leDOlozIG8LJtC/r+6Xkbi8zhK0GJV67g2sahcigDS
        XaP9ZZG/StWQR1RLQ6BpdzSdtdqi
X-Google-Smtp-Source: AHgI3IY/v0o7Ncm3cX5KVKFL4vts0pF/g/3y5mG5G6J+MD8kaUH6ujdy+rtvHVZCr+COjLfYbQUL5g==
X-Received: by 2002:a63:eb0f:: with SMTP id t15mr712995pgh.252.1550786528524;
        Thu, 21 Feb 2019 14:02:08 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p6sm40408pfp.15.2019.02.21.14.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 14:02:06 -0800 (PST)
Message-ID: <1550786525.31902.140.camel@acm.org>
Subject: Re: [PATCH v7 00/23] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Feb 2019 14:02:05 -0800
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 15:00 -0800, Bart Van Assche wrote:
+AD4 A known shortcoming of the current lockdep implementation is that it requires
+AD4 lock keys to be allocated statically. This forces certain unrelated
+AD4 synchronization objects to share keys and this key sharing can cause false
+AD4 positive deadlock reports. This patch series adds support for dynamic keys in
+AD4 the lockdep code and eliminates a class of false positive reports from the
+AD4 workqueue implementation.
+AD4 
+AD4 Please consider these patches for kernel v5.1.

Hi Peter and Ingo,

Do you have any feedback about this patch series that you would like to share?
If none of you has the time to do a full review of this patch series before the
v5.1 merge window opens: how about queuing only the first ten patches of this
patch series for kernel v5.1? The first ten patches of this series are small and
easy to review.

Thanks,

Bart.
