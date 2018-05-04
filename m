Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEDRAc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:00:32 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34212 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbeEDRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:00:30 -0400
X-Google-Smtp-Source: AB8JxZqX8v9ycB9k7Gr3ZUHORR3/8jvW34A1GU1MIS2ODEz8NMKqhNva5ZhxNUWWfZzr/q3eBFuwaw==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Fri, 4 May 2018 13:00:27 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
In-Reply-To: <20180504162557.iodmglq3duomz6c2@treble>
Message-ID: <alpine.DEB.2.21.1805041256410.6376@macbook-air>
References: <20180109170716.bqmexpmywwr4bwuv@treble> <20180111052538.2qhj6oxnc24xumhk@treble> <alpine.DEB.2.21.1801111358580.22460@macbook-air> <20180111192112.d35nkotzklicd27c@treble> <alpine.DEB.2.21.1805010925140.19413@macbook-air> <20180501135850.enx4waqd5d7yowlj@treble>
 <alpine.DEB.2.21.1805011557240.19937@macbook-air> <20180501220458.p3rgwzh3jcqt4jmm@treble> <20180502205009.codkvscnh4j4hm6b@treble> <alpine.DEB.2.21.1805041033230.6376@macbook-air> <20180504162557.iodmglq3duomz6c2@treble>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018, Josh Poimboeuf wrote:

> Also, any tips for reproducing this locally?  I cloned the perf fuzzer
> github.  Is it as simple as just "make" and "./run_tests.sh"?

run_tests only runs the perf_event regressiong tests.

To run the fuzzer, enter the "fuzzer" directory and either run
	"./fast_repro98.sh"
which will run the fuzzer repeatedly, or you can instead just run
	./perf_fuzzer
but that sometimes eventually errors out if it manages to get stuck in a 
signal storm.

While running on haswell and skylake machines the WARNINGs trigger fairly 
quickly (within minutes usually).

You might also encounter a handful of other known kernel warnings which 
I've reported in the past and usually just ignore.

Vince
