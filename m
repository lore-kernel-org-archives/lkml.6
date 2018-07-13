Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8CFECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4AE208E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 01:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NZ28Z36e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4AE208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbeGMBee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 21:34:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45612 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387892AbeGMBed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 21:34:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id i26-v6so10198767pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 18:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=u8A8CIn8JEixzzWHTcYRFM2KmjqUKk+LyvlpcjdAiFA=;
        b=NZ28Z36eOBDrbDf75CvuIH7wl5ACqxGC5qbN1LPXXuM2OPn1vf7mL2ytd/+GioM83g
         csFvaqlsn8n0Q4lb/vYyI2R4Q/uZrdhEKCiGZLWxMdVOUfLKLgrCwVXOC+8yjtpaPjhx
         NY+x7e5KqvDnHPfdVxMiiz1LdweQKZGon+9W+lFdNYsHGMWJD4A9MYixG1fC3oGLd4uv
         X8KGg+1bQrCo9EnzIyjZF7FhEf91CX2c1ybXawAeIj/mdR16BxhEp2hMPqb3Is9dqUTQ
         lKGtuTGzaToc9TAeP5VqxmQ1K/0Kme7WvZLgOSbiNgliIOfJSFE2KHrbiChFRsdszbJr
         UmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=u8A8CIn8JEixzzWHTcYRFM2KmjqUKk+LyvlpcjdAiFA=;
        b=HqUpuRDzarcIvsWTsyjYCgjx0zK6BtStxyQ2aH58hl4CUx594j4tv4BYWVwZVECz4D
         nm0yEmOaBS8NsmXjZ2Pchtids9AGDG3+Az/v5z9X45nl/XKC0oUQwBF6gEHB8NrMYq4L
         VYqZ/7box6WR97jTPonkUdzmZX5dzlzz4w7XqVYqyMJiNTmrpAn8PryBa1Bbxp0SnZxu
         xAXrfgZbvT/Xn1ykxp4xPuMlWGuFFlMU82ZstE8ANhfjvv9xgU8gaFCV8tmueb8vetpU
         AjPA000kTLjtsmKRv2Yhc6kUWlQHDgiX/i807kPI1MX0XRFNsS6vUnHGrViGAl9c9K55
         Xf0A==
X-Gm-Message-State: AOUpUlFbVgge7Mlknmvk3YE/Chr8EN/qBel6+SKs8iDnlzpQLQ+RKEVu
        cl8FF5pevP0Fik+EyKhU3ToSAg==
X-Google-Smtp-Source: AAOMgpebUI6iWlzxfgtvV5BhszhUhBzpSO8S2PEFzqQ+xb0gG5qrHNKzjdlSvz13jGYfUZwPrIUD2w==
X-Received: by 2002:a62:464f:: with SMTP id t76-v6mr4806764pfa.118.1531444941751;
        Thu, 12 Jul 2018 18:22:21 -0700 (PDT)
Received: from [100.112.85.58] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id g20-v6sm37952872pfo.94.2018.07.12.18.22.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 18:22:20 -0700 (PDT)
Date:   Thu, 12 Jul 2018 18:22:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Metzger, Markus T" <markus.t.metzger@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bug] kpti, perf_event, bts: sporadic truncated trace
In-Reply-To: <A78C989F6D9628469189715575E55B236B330102@IRSMSX104.ger.corp.intel.com>
Message-ID: <alpine.LSU.2.11.1807121743050.5425@eggly.anvils>
References: <A78C989F6D9628469189715575E55B236B330102@IRSMSX104.ger.corp.intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018, Metzger, Markus T wrote:

> Hello,
> 
> Starting with 4.15 I noticed that BTS is sporadically missing the tail
> of the trace in the perf_event data buffer.  It shows as
> 
>     [decode error (1): instruction overflow]
> 
> in GDB.  Chances to see this are higher the longer the debuggee is
> running.  With this [1] tiny patch to one of GDB's tests, I am able to
> reproduce it reliably on my box.  To run the test, use:
> 
>     $ make -s check RUNTESTFLAGS="gdb.btrace/exception.exp"
> 
> from the gdb/ sub-directory in the GDB build directory.
> 
> The issue remains when I use 'nopti' on the kernel command-line.
> 
> 
> Bisecting yielded commit
> 
>     c1961a4 x86/events/intel/ds: Map debug buffers in cpu_entry_area
> 
> I reverted the commit on top of v4.17 [2] and the issue disappears
> when I use 'nopti' on the kernel command-line.
> 
> regards,
> markus.
> 
> 
> [1]
> diff --git a/gdb/testsuite/gdb.btrace/exception.exp b/gdb/testsuite/gdb.btrace/exception.exp
> index 9408d61..a24ddd3 100755
> --- a/gdb/testsuite/gdb.btrace/exception.exp
> +++ b/gdb/testsuite/gdb.btrace/exception.exp
> @@ -36,16 +36,12 @@ if ![runto_main] {
>  gdb_test_no_output "set record function-call-history-size 0"
>  
>  # set bp
> -set bp_1 [gdb_get_line_number "bp.1" $srcfile]
>  set bp_2 [gdb_get_line_number "bp.2" $srcfile]
> -gdb_breakpoint $bp_1
>  gdb_breakpoint $bp_2
>  
> -# trace the code between the two breakpoints
> -gdb_continue_to_breakpoint "cont to bp.1" ".*$srcfile:$bp_1\r\n.*"
>  # increase the BTS buffer size - the trace can be quite big
> -gdb_test_no_output "set record btrace bts buffer-size 128000"
> -gdb_test_no_output "record btrace"
> +gdb_test_no_output "set record btrace bts buffer-size 1024000"
> +gdb_test_no_output "record btrace bts"
>  gdb_continue_to_breakpoint "cont to bp.2" ".*$srcfile:$bp_2\r\n.*"
>  
>  # show the flat branch trace
> 
> 
> [2]
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
[ snipped the revert ]

Although my name was kept on that commit as a generous courtesy, it
did change a lot after leaving my fingers - and I was never the best
person to be making perf changes in the first place!

I'm sorry to hear that it's breaking you, I've spent a little while
looking through its final state, most of it looks fine to me, but I
notice one discrepancy: whose effect I cannot predict at all, but
there's a chance that it has something to do with what you're seeing.

A little "optimization" crept into alloc_bts_buffer() along the way,
which now places bts_interrupt_threshold not on a record boundary.
And Stephane has shown me the sentence in Vol 3B, 17.4.9, which says
"This address must point to an offset from the BTS buffer base that
is a multiple of the BTS record size."

Please give the patch below a try, and let us know if it helps (if it
does not, then I think we'll need perfier expertise than I can give).

Hugh

--- 4.18-rc4/arch/x86/events/intel/ds.c	2018-06-03 14:15:21.000000000 -0700
+++ linux/arch/x86/events/intel/ds.c	2018-07-12 17:38:28.471378616 -0700
@@ -408,9 +408,11 @@ static int alloc_bts_buffer(int cpu)
 	ds->bts_buffer_base = (unsigned long) cea;
 	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
 	ds->bts_index = ds->bts_buffer_base;
-	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
-	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
-	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
+	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
+	ds->bts_absolute_maximum = ds->bts_buffer_base +
+					max * BTS_RECORD_SIZE;
+	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
+					(max / 16) * BTS_RECORD_SIZE;
 	return 0;
 }
 
