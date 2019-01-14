Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D886C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637F8206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfANQwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:52:36 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46752 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfANQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:52:36 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so9678382pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxGTL3eAhAyiNG9YeBFSl+V+ony1pLTRYYou0v8pRo4=;
        b=fY8iCaJZ1ZipmB2wVFm8WSRzZ40+/06BirTTRMRFQxk3W5OqbJP9KQO4tr4d6kaM8W
         Addsz7XmYIwCv/iSfB1/HJ7Cnf1k56RbO9+17G1c0icPNGMXnDvbvRj8K6ECiSSB1q4Y
         uPuN8YNiIzistKymyadMMaEd5o8X+xRA4VTYpF5q2Ab5xMmrWWCUbkY1FXBkKKjK5A8l
         LZJ0i5yFu9HnkaJHGswqYdl4sH+CXbSFXcl/ThmWkl6k6GdJYSFM2++dDzmLxOmf7fPy
         uIxuaZrYOLgM7Jp4RCQRoRqztPHlamYIl+1yCMqy6Ijq6kPjz5G0Lz3+mHq+MbGRNQ9Y
         QjZQ==
X-Gm-Message-State: AJcUukdPfIEbgLB/GZ5NkFnlkIoLPVPlMGaCVNMZ1yjPxWfhxFRzbpdu
        Y8WOaPFNu4Ki2MwSiR55wYCCiVgo
X-Google-Smtp-Source: ALg8bN7Uwant+jBKqSh2Q+MgkAn4OkBbIap8apaXL7RYYe9ahnMtWi90jq7bGedvR9hGuRiYjBlmHg==
X-Received: by 2002:a62:109b:: with SMTP id 27mr25835499pfq.227.1547484755243;
        Mon, 14 Jan 2019 08:52:35 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m3sm1186184pfi.102.2019.01.14.08.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:52:34 -0800 (PST)
Message-ID: <1547484753.83374.109.camel@acm.org>
Subject: Re: [PATCH v6 00/16] locking/lockdep: Add support for dynamic keys
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org
Date:   Mon, 14 Jan 2019 08:52:33 -0800
In-Reply-To: <20190114125235.GB20726@hirez.programming.kicks-ass.net>
References: <20190109210204.192109-1-bvanassche@acm.org>
         <20190111124835.GP1900@hirez.programming.kicks-ass.net>
         <1547222103.83374.72.camel@acm.org>
         <20190111165529.GA14054@worktop.programming.kicks-ass.net>
         <1547226101.83374.80.camel@acm.org>
         <20190114125235.GB20726@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-14 at 13:52 +-0100, Peter Zijlstra wrote:
+AD4 On Fri, Jan 11, 2019 at 09:01:41AM -0800, Bart Van Assche wrote:
+AD4 +AD4 The list+AF8-del+AF8-rcu() call must only happen once. 
+AD4 
+AD4 Yes+ADs obviously. But if we need to check all +AEA-pf's, that means the entry
+AD4 is still reachable after a single reset+AF8-lock()/free+AF8-key+AF8-range(), which
+AD4 is a bug.
+AD4 
+AD4 +AD4 I ran into complaints reporting that
+AD4 +AD4 the list+AF8-del+AF8-rcu() call triggered list corruption. This change made these complaints
+AD4 +AD4 disappear.
+AD4 
+AD4 I'm saying this solution buggy, because that means the entry is still
+AD4 reachable after we do call+AF8-rcu() (which is a straight up UAF).
+AD4 
+AD4 Also put it differently, what guarantees checking those two +AEA-pf's is
+AD4 sufficient. Suppose your earlier +AEA-pf already did the RCU callback and
+AD4 freed stuff while the second is in progress. Then you're poking into
+AD4 dead space.

zap+AF8-class() only examines elements of the list+AF8-entries+AFsAXQ array for which the
corresponding bit in list+AF8-entries+AF8-in+AF8-use has been set. The RCU callback clears 
the bits in the list+AF8-entries+AF8-in+AF8-use that correspond to elements that have been
freed. The graph lock serializes zap+AF8-class() calls and the code inside the
RCU callback. So it's not clear to me why you are claiming that zap+AF8-class()
would trigger a use-after-free?

Bart.
