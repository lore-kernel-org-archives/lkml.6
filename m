Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15631C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15ED21924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550227005;
	bh=dY9HSg7Kki1n9LZJbVHlFx/cSCp5ZlWR4cxG1tWoASo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I2zcxq23PDrTTNMme2hRfpEyezR3TxyMfdTmi5ObplKlD69Vy2qE3K+s3B2R8F83q
	 ghowbCm4UvROipRgS1cAbTGEWAqM3wrUdkQLZuPTfjx99bJAJOnUpYoA1KwpM/Pdzb
	 OTQ4nOgUiW+wS0xF/uo5Y5gBWj4upG0symigEn5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405656AbfBOKgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 05:36:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbfBOKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 05:36:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id l5so8696532wrw.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 02:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xGvAiDp+MEv+hqQHKiVjskz47oSmC8Ft2LD9lUt2kN0=;
        b=AHW6y59PktDWDvcms8KlTjMX0DJdIx1ZsRHcnhW2qzO1tD5x6xEUAAFKGPnMOswyXS
         yCiVD8RiPXVu+z0K11ZCjctB1KpE1K0YXuKS7u5LuS35GCKBLBT5d6KOEaIkYs7MLn+q
         fXyWgAIHH29VMzWRiiKinpthJ8mxXPG53LBpjTy6IpBZ3GcFCTwba2Rjk3TYSBuY6n/e
         BdM6rsyUGWaWBfspFgl7g2GnNB9n+TZlZEgyp0XWy2ZR5lAzddfs0WgbvngmIWBDGcEr
         PkRvit6TWycJWxCLMlQLaaFyWNBVNcBIQmNIubWVQX+vr2Ajk6HTDqcsAI+qRNCkn8gG
         jXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xGvAiDp+MEv+hqQHKiVjskz47oSmC8Ft2LD9lUt2kN0=;
        b=oT7A0UcB3iSNGXvjAf8WH4qJZAN9iddSgbiWI++V540HMsw4C9Gg8ZgMJ42rcOk97o
         c6T7u/jsGgtN5Th+SQxU5bqey7cWynBea/jR9gxuBRW6W6/cl4OrqSPuGcclU0kQTPDc
         qpyLnFieRMPUD4aJrkX7HHrtzZc9atFXKLcPunfCFSIRZHAjM8dtiZ3LKXcBjpHvthAH
         EidpF72ohO+oMROTJyr8opL8t0qlgrqo+CiKyKGFvmUhVi444a8uZp6KLMHFwb5BCo3N
         fKKtawtzwPj+7tcY+Im5C+fl0ShHGvrI22TqZVA61DKVOE1TrPatPhockIPnYHlUpT93
         Q2CA==
X-Gm-Message-State: AHQUAuaIfdstzst7/IKJ7CYEW+/ZgUsN/kIG33ZBUpQKb7DNOcLHA8GF
        xRqwIWoBOg4teg3D0gB63U8=
X-Google-Smtp-Source: AHgI3IbecG2i/Mvs8UpycwlIrQi7wUAQ3KQryV16mE5kjFrwFJPXwHVmJ0Ikp/76LaGsX32y1vKTxA==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr6635415wrq.17.1550227000665;
        Fri, 15 Feb 2019 02:36:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z17sm4774590wrs.75.2019.02.15.02.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 02:36:39 -0800 (PST)
Date:   Fri, 15 Feb 2019 11:36:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jan@schnhrr.de>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/tsc: Allow quick PIT calibration despite
 interruptions
Message-ID: <20190215103637.GA55294@gmail.com>
References: <20190214214608.8672-1-jan@schnhrr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190214214608.8672-1-jan@schnhrr.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan H. Schönherr <jan@schnhrr.de> wrote:

> Some systems experience regular interruptions (60 Hz SMI?), that prevent
> the quick PIT calibration from succeeding: individual interruptions can be
> so long, that the PIT MSB is observed to decrement by 2 or 3 instead of 1.
> The existing code cannot recover from this.
> 
> The system in question is an AMD Ryzen Threadripper 2950X, microcode
> 0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.
> 
> Change the code to handle (almost) arbitrary interruptions, as long
> as they happen only once in a while and they do not take too long.
> Specifically, also cover an interruption during the very first reads.
> 
> Signed-off-by: Jan H. Schönherr <jan@schnhrr.de>
> ---
> 
> v2:
> - Dropped the other hacky patch for the time being.
> - Fixed the early exit check.
> - Hopefully fixed all inaccurate math in v1.
> - Extended comments.
> 
>  arch/x86/kernel/tsc.c | 91 +++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 34 deletions(-)

BTW., I tried this on my Ryzen system, and it appears to be working well:

old (without patch):

  [    0.000000] tsc: Fast TSC calibration failed
  [    0.032000] tsc: PIT calibration matches HPET. 2 loops
  [    0.032000] tsc: Detected 3599.655 MHz processor
  [    0.000014] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33e30d9825f, max_idle_ns: 440795248078 ns
  [    0.160104] clocksource: Switched to clocksource tsc-early
  [    1.468132] tsc: Refined TSC clocksource calibration: 3599.927 MHz
  [    1.478418] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33e40e9d0e7, max_idle_ns: 440795301696 ns
  [    1.483197] clocksource: Switched to clocksource tsc

new (with patch):

  [    0.000000] tsc: Fast TSC calibration using PIT
  [    0.000000] tsc: Detected 3599.857 MHz processor
  [    0.736649] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33e3cc37f8b, max_idle_ns: 440795303609 ns
  [    0.896736] clocksource: Switched to clocksource tsc-early
  [    2.212732] tsc: Refined TSC clocksource calibration: 3599.931 MHz
  [    2.218368] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33e4128ece2, max_idle_ns: 440795387864 ns
  [    2.261799] clocksource: Switched to clocksource tsc

Tested-by: Ingo Molnar <mingo@kernel.org>

(Note that in the old log the printk timestamps start later so they are 
no basis for boot time comparison.)

Thanks,

	Ingo
