Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC269C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A9C20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbeLQR1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:27:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37973 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeLQR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:27:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so6699261pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=823vNceqOZW1qhO1NubhUnPzY9PiHcOak7MQZp1+gtg=;
        b=MH+DSScZNizEIxEDyB+05OpuP6a0SfXVEo8V7ocxYSr5m0gVs9sCUdd+rPbd8MaRLX
         lGvq+RsZwdmpOQKpZ01Afbe1UGIUbaVaXIEBFzVTXVbGPkyMpFnkYbEfamWzy+mNXCw+
         E12vB2B62rbsxHm+GrIA40UR2NR8+KjwLuIewd8Au2koo6HsQDrRRag1qIPkPqN4hJm/
         FbZjK581y/Ff7kNbMuGFhtu2dxR6vFcZY/7rosWeIIwIVlO5dbzlm189sduyXLfx0VlB
         XKwFweEIw7ofmGmeS4I2PyNT4OZ9Rc4uWG/RUWvfivhg4PQzE7M9R44/XToZw/5qhmpD
         wRtA==
X-Gm-Message-State: AA+aEWZVA5wm3FhBj45+2DgGw+QtzyjUlVasb1GP5imIshhMtbWxyF31
        /xafmPINUY1jThIVEl4xe9Y=
X-Google-Smtp-Source: AFSGD/UMeh/+NcwiHAvk6yZ4DUDFFJJYKQO95uvQw+ViJM9zubLef6Zw2WzZrpyWSDm3Bh34eZlvfQ==
X-Received: by 2002:a62:3811:: with SMTP id f17mr13863166pfa.206.1545067660861;
        Mon, 17 Dec 2018 09:27:40 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a18sm15778264pgj.30.2018.12.17.09.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:27:39 -0800 (PST)
Message-ID: <1545067657.185366.433.camel@acm.org>
Subject: Re: [LKP] [locking/lockdep] 15693f040b:
 WARNING:at_kernel/locking/lockdep.c:#lockdep_free_key_range
From:   Bart Van Assche <bvanassche@acm.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>, lkp@01.org
Date:   Mon, 17 Dec 2018 09:27:37 -0800
In-Reply-To: <20181217084128.GE23332@shao2-debian>
References: <20181217084128.GE23332@shao2-debian>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-17 at 16:41 +-0800, kernel test robot wrote:
+AD4 FYI, we noticed the following commit (built with gcc-4.9):
+AD4 
+AD4 commit: 15693f040b149ffff598cc048c2697b258d3901c (+ACI-locking/lockdep: Free lock classes that are no longer in use+ACI)
+AD4 https://github.com/bvanassche/linux for-next
+AD4 
+AD4 in testcase: locktorture
+AD4 with following parameters:
+AD4 
+AD4 	runtime: 300s
+AD4 	test: cpuhotplug
+AD4 
+AD4 test-description: This torture test consists of creating a number of kernel threads which acquire the lock and hold it for specific amount of time, thus simulating different critical region
+AD4 behaviors.
+AD4 test-url: https://www.kernel.org/doc/Documentation/locking/locktorture.txt
+AD4 
+AD4 
+AD4 on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 512M
+AD4 
+AD4 caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
+AD4 
+AD4 
+AD4 +--------------------------------------------------------------+-------------+-------------+-
+AD4 +AD4                                                             +AHw b7001c6cce +AHw 15693f040b +AHw
+AD4 
+AD4 +--------------------------------------------------------------+-------------+-------------+-
+AD4 +AD4 boot+AF8-successes                                              +AHw 0          +AHw 0          +AHw
+AD4 +AD4 boot+AF8-failures                                               +AHw 394        +AHw 396        +AHw
+AD4 +AD4 WARNING:at+AF8-lib/debugobjects.c:+ACMAXwBf-debug+AF8-object+AF8-init          +AHw 394        +AHw 396        +AHw
+AD4 +AD4 EIP:+AF8AXw-debug+AF8-object+AF8-init                                     +AHw 394        +AHw 396        +AHw
+AD4 +AD4 WARNING:possible+AF8-circular+AF8-locking+AF8-dependency+AF8-detected       +AHw 370        +AHw 375        +AHw
+AD4 +AD4 WARNING:at+AF8-kernel/locking/lockdep.c:+ACM-lock+AF8-downgrade         +AHw 145        +AHw 159        +AHw
+AD4 +AD4 EIP:lock+AF8-downgrade                                          +AHw 145        +AHw 159        +AHw
+AD4 +AD4 BUG:soft+AF8-lockup-CPU+ACMAIw-stuck+AF8-for+ACM-s                            +AHw 24         +AHw 21         +AHw
+AD4 +AD4 EIP:thread+AF8-lookup+AF8-test                                      +AHw 12         +AHw 9          +AHw
+AD4 +AD4 Kernel+AF8-panic-not+AF8-syncing:softlockup:hung+AF8-tasks              +AHw 24         +AHw 21         +AHw
+AD4 +AD4 EIP:memcmp                                                  +AHw 3          +AHw 3          +AHw
+AD4 +AD4 EIP:threadfunc                                              +AHw 4          +AHw 2          +AHw
+AD4 +AD4 EIP:lock+AF8-acquire                                            +AHw 3          +AHw 1          +AHw
+AD4 +AD4 EIP:lock+AF8-is+AF8-held+AF8-type                                       +AHw 2          +AHw 2          +AHw
+AD4 +AD4 WARNING:at+AF8-net/sched/sch+AF8-generic.c:+ACM-dev+AF8-watchdog            +AHw 1          +AHw            +AHw
+AD4 +AD4 EIP:dev+AF8-watchdog                                            +AHw 1          +AHw            +AHw
+AD4 +AD4 WARNING:at+AF8-kernel/locking/lockdep.c:+ACM-lockdep+AF8-free+AF8-key+AF8-range +AHw 0          +AHw 22         +AHw
+AD4 +AD4 EIP:lockdep+AF8-free+AF8-key+AF8-range                                  +AHw 0          +AHw 22         +AHw
+AD4 +AD4 EIP:lock+AF8-release                                            +AHw 0          +AHw 2          +AHw
+AD4 +AD4 EIP:rht+AF8-deferred+AF8-worker                                     +AHw 0          +AHw 2          +AHw
+AD4 
+AD4 +--------------------------------------------------------------+-------------+-------------+-

The WARNING:at+AF8-kernel/locking/lockdep.c:+ACM-lockdep+AF8-free+AF8-key+AF8-range warnings were caused by the
following code:

	pf +AD0 get+AF8-pending+AF8-free+AF8-lock(+ACY-flags)+ADs
	if (WARN+AF8-ON+AF8-ONCE(+ACE-pf))
		return+ADs

Before this report was produced I had already pushed out a new version of my lockdep patch
series to the for-next branch of my github repository in which that code had been modified
into the following:

	pf +AD0 get+AF8-pending+AF8-free+AF8-lock(+ACY-flags)+ADs
	if (+ACE-pf)
		return+ADs

Since the above report refers to a WARN+AF8-ON+AF8-ONCE() statement that has been removed, I think
that this report can be ignored.

Bart.

