Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB67C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4396021470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cikmoFM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4396021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJDPZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:25:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44911 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJDPZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:25:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so8893749wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmDtcvCkwb975nAcqWHoB0JIXhy725B2m4ynNAJgE70=;
        b=cikmoFM2nlvTf8k0Jjseugkh221+L3qXfvUskmi/ucfGemg98UH1jpUd18xfiWNYE+
         jbtFRFXYZJf4ImX+EKF/K8ZwPLdyVemvxA6ZiwbTdtjOeIV6NK1aGs/ZOQJ+FrgRHh8r
         f5MS2+5LFn3jWggsd0YtZ8LBeW+tdeE/uQbgw5aqYc9Zx1XRX1dfkSM4wWrAkd44i1/z
         Oz06PKgIJg6wh6bQs5RD1h+AZzw8Gf+7BJWEFB221e7Kt7FsePjLd8/QgR8RGDQHAAfD
         4z3NOkCCvesaK807wWc+/yAbe0MoDO/qtUaI6kA9e0MFzQJ4d1iJ1VM2xDTQiZEjxIQt
         dsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmDtcvCkwb975nAcqWHoB0JIXhy725B2m4ynNAJgE70=;
        b=r1oERQdAYwBdOStk/ndU0iYoNQCVc/Kg+iIriKfqs00z5cYkaXEueu7P1/J0vG3gUH
         BvAqIYlp5e3NcXSJmaWiy3iZaxFebPWNOJeJTt2nQVZLjOI99DAnaPxg8q40esu5Q1Gf
         D/DP0IWaaPF3s4rgMoXLgPurPyxvHTNesRxrUDxBQsFarlTO4oHn9U8popmW3L6Waggw
         z3RKDY87g56SaYGvF3k8hq5Zk8KfqfaODb+RjR0r1jI9E4wIPxO3bwYuyywy3GyeAi4E
         tI01+Fwgj3BkN7rfqSq2BYflR/DXYOvSevqogLayeGdiCE4kNl1BLO8tcatQPa/8utT/
         +JvQ==
X-Gm-Message-State: ABuFfogewqBurwMXApzTdrFIL/A+V4mLvGtGKDrA5iSMGApqL8jSx9N2
        54DW9Dg8xByGcvBMW4FmLVo=
X-Google-Smtp-Source: ACcGV637OMPJ9qEZRf/p8xNqKSm95eS+ttn3O7tg79EeicM5mafwzlCRS5G3Wf/qnSnaj6d35yDhoQ==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5-v6mr3907132wrw.288.1538642016274;
        Thu, 04 Oct 2018 01:33:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u10-v6sm2767465wrt.59.2018.10.04.01.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 01:33:35 -0700 (PDT)
Date:   Thu, 4 Oct 2018 10:33:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181004083333.GA9802@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004075755.GA3353@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> I'm also somewhat annoyed at the fact that this series carries a boatload
> of reviewed-by's and acked-by's, yet none of those reviewers found it
> important to point out the large chasm that is gaping between description
> and reality.

Another problem I just realized is that we now include arch/x86/kernel/macros.S in every 
translation pass when building the kernel, right?

But arch/x86/kernel/macros.S expands to a pretty large hiearchy of header files:

  $ make arch/x86/kernel/macros.s

  $ cat $(grep include arch/x86/kernel/macros.s | cut -d\" -f2 | sort | uniq) | wc -l
  4128

That's 4,100 extra lines of code to be preprocessed for every translation unit, of
which there are tens of thousands. More if other pieces of code get macrofied in
this fasion in the future.

If we assume that a typical distribution kernel build has ~20,000 translation units
then this change adds 82,560,000 more lines to be preprocessed, just to work around
a stupid GCC bug?

I'm totally unhappy about that. Can we do this without adding macros.S?

It's also a pretty stupidly central file anyway that moves source code away
from where it's used.

Thanks,

	Ingo
