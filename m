Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A247C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7BE20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJxVkMPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7BE20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeKHRi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:38:28 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37775 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:38:28 -0500
Received: by mail-wr1-f49.google.com with SMTP id o15-v6so16515327wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 00:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YxroUeNPICO/rCxEgqoF0BHm0TTc28cjP21bUB6hMP8=;
        b=ZJxVkMPYXbe+8HpIR3zoUC0cKKUqx4zaLLNKufjXvF7LsoqSi500Zav/wHvaDmWHic
         1yIj5fAlsxYeq/G7MssPvvBCInvNE5AbFsf78vrSvQn5RZlLd/65PBVIY3YwvQvti4O9
         md3PeUBjFPkffauviUA7m7iGAy81L5qTLebCfVgIPJ6iSCq74xOxRmic6EQ/7P3zy84x
         NVytLDwEAaGHeiQouQsXZfwBuOWjPjJ0ZmUfnCb0PWJSu4Tuf7cDeWepNSNNFd4RJNxy
         jw6Ns0MWDGcBK1x5b+6BhGsfyPnsOIpT7WUnysjp8XwV0ifW/RLpqLoEcKFhR9rwW4HD
         w+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxroUeNPICO/rCxEgqoF0BHm0TTc28cjP21bUB6hMP8=;
        b=ACb6WZoCgMlGZuwB0f9Go+F8TYvRSdFweiVyd4o1hN6qDKJPfOMcJhRZw83tUoiXTi
         YkseV/r4Dj5sn5I8nak8CjS9VC/AQVoMCC8t6vf5UfjTj2OTqQvhz9Z+7lC6u1Iol27o
         qwpcHnXmcf9s+ipao7kQupdN63udpvw26wY4I2kdOwbBO5JJY+RIhLF768kjWbzlgP2D
         QwAJpLmo215PuY3bHhRf5tRQPVXNhQPpYMjyuEw1rK6E2wZ/hzjH3HGyOGy8oVB/kfBI
         uzO6wmyERTvLQCVFgJCF1mkEpYh8lgVQMoRpPZavKa1nTwSlybKb2lfG398lpfAUkFI1
         zfVw==
X-Gm-Message-State: AGRZ1gJ3r0GlNcj+1m5bHcIER5NYw9DHF2CCYX7bwpPF6+TfV6Mx1ifY
        6i84r1x4RPnHe6t/UqvU+ILBfkGQ
X-Google-Smtp-Source: AJdET5ezjVP0AgqLSmk4pSYqGMD/sOy2UZXRgoQnf769l6nAJqE7WdVMs9L89Bt5YXVw9YHA0+hOkQ==
X-Received: by 2002:adf:8c09:: with SMTP id z9-v6mr3058661wra.82.1541664249526;
        Thu, 08 Nov 2018 00:04:09 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j203-v6sm5112032wmd.46.2018.11.08.00.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 00:04:08 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:04:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108080406.GF20032@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107171149.165693799@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +Variable types
> +^^^^^^^^^^^^^^
> +
> +Please use the proper u8, u16, u32, u64 types for variables which are meant
> +to describe hardware or are used as arguments for functions which access
> +hardware. These types are clearly defining the bit width and avoid
> +truncation, expansion and 32/64 bit confusion.
> +
> +u64 is also recommended in code which would become ambiguous for 32bit when
> +'unsigned long' would be used instead. While in such situations 'unsigned
> +long long' could be used as well, u64 is shorter and also clearly shows
> +that the operation is required to be 64bit wide independent of the target
> +CPU.
> +
> +Please use 'unsigned int' instead of 'unsigned'.

s/for 32bit
 /for 32-bit kernels

s/64bit wide
 /64 bits wide

> +Constants
> +^^^^^^^^^
> +
> +Please do not use literal (hexa)decimal numbers in code or initializers.
> +Either use proper defines which have descriptive names or consider using
> +an enum.

I believe there should be an exception for 'obvious' literal values like 
0 and 1.

I.e. the above is mostly a rule that is intended to cover undocumented 
'magic' numbers.

I.e. how about this wording:

  +Constants
  +^^^^^^^^^
  +
  +Please do not use magic literal (hexa)decimal numbers when interfacing
  +with hardware where the number has an unclear origin in code or 
  +initializers. I.e. "no magic numbers".
  +
  +Either use proper defines which have descriptive names or use an enum.
  +
  +Using obvious 0/1 literal values is fine in most cases.

?

> +
> +
> +Struct declarations and initializers
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Struct declarations should align the struct member names in a tabular
> +fashion::
> +
> +	struct bar_order {
> +		unsigned int	guest_id;
> +		int		ordered_item;
> +		struct menu	*menu;
> +	};
> +
> +Please avoid documenting struct members within the declaration, because
> +this often results in strangely formatted comments and the struct members
> +become obfuscated::
> +
> + 	struct bar_order {
> +  		unsigned int	guest_id; /* Unique guest id */

[ Sidenote: there's whitespace damage (extra spaces) in the text here. ]

> +		int		ordered_item;
> +		/* Pointer to a menu instance which contains all the drinks */
> +		struct menu	*menu;
> +	};
> +
> +Instead, please consider using the kernel-doc format in a comment preceding
> +the struct declaration, which is easier to read and has the added advantage
> +of including the information in the kernel documentation, for example, as
> +follows::

I disagree slightly here. While adding kernel-doc format is fine of 
course, so are in-line comments which I frequently use.

This form is particularly helpful for more complex structures. Have a 
look at 'struct fpu' for example:


/*
 * Highest level per task FPU state data structure that
 * contains the FPU register state plus various FPU
 * state fields:
 */
struct fpu {
	/*
	 * @last_cpu:
	 *
	 * Records the last CPU on which this context was loaded into
	 * FPU registers. (In the lazy-restore case we might be
	 * able to reuse FPU registers across multiple context switches
	 * this way, if no intermediate task used the FPU.)
	 *
	 * A value of -1 is used to indicate that the FPU state in context
	 * memory is newer than the FPU state in registers, and that the
	 * FPU state should be reloaded next time the task is run.
	 */
	unsigned int			last_cpu;

	/*
	 * @initialized:
	 *
	 * This flag indicates whether this context is initialized: if the task
	 * is not running then we can restore from this context, if the task
	 * is running then we should save into this context.
	 */
	unsigned char			initialized;

	/*
	 * @state:
	 *
	 * In-memory copy of all FPU registers that we save/restore
	 * over context switches. If the task is using the FPU then
	 * the registers in the FPU are more recent than this state
	 * copy. If the task context-switches away then they get
	 * saved here and represent the FPU state.
	 */
	union fpregs_state		state;
	/*
	 * WARNING: 'state' is dynamically-sized.  Do not put
	 * anything after it here.
	 */
};

The in-line freestanding comments is perfectly structured and readable as 
well, and this is analogous to the 'freestanding comments' style for C 
statements.

We also have occasional examples where tail comments are fine, such as:

/*
 * The legacy x87 FPU state format, as saved by FSAVE and
 * restored by the FRSTOR instructions:
 */
struct fregs_state {
	u32			cwd;	/* FPU Control Word		*/
	u32			swd;	/* FPU Status Word		*/
	u32			twd;	/* FPU Tag Word			*/
	u32			fip;	/* FPU IP Offset		*/
	u32			fcs;	/* FPU IP Selector		*/
	u32			foo;	/* FPU Operand Pointer Offset	*/
	u32			fos;	/* FPU Operand Pointer Selector	*/

	/* 8*10 bytes for each FP-reg = 80 bytes:			*/
	u32			st_space[20];

	/* Software status information [not touched by FSAVE]:		*/
	u32			status;
};

But I'd not complicate the style guide with that.

> +Static struct initializers must use C99 initializers and should also be
> +aligned in a tabular fashion::
> +
> +	static struct foo statfoo = {
> +		.a		= 0,
> +		.plain_integer	= CONSTANT_DEFINE_OR_ENUM,
> +		.bar		= &statbar,
> +	};
> +

Yeah, and maybe also add a note about the final comma:

  + Note that while C99 syntax allows the omission of the final comma, we 
  + recommend the use of a comma on the last line because it makes 
  + reordering and addition of new lines easier, and makes such future 
  + patches slightly easier to read as well.

?

Thanks,

	Ingo
