Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5138AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7272154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seCVIswU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7272154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbeI0Eq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:46:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38059 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeI0Eq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:46:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id z16-v6so3979086wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=csnNe32Mb1sBYL5xyHWNBq5X2DM3melVl9dy6kewzWI=;
        b=seCVIswUu8l5TNC0xeV0c20Z9kVszFD3eqe/vL2fvCML32ygrEHezfq3oXIeSVvtRw
         iwSF01Gd3D3rffO4RNFcTUUat0rN2Bbjov3tam2YH/tJXe0clGFj8mj5NmSHlwsopmJt
         wKGSGCtvq3KwVLFUX4p5K0RdOWHyLhhOvUJBp3lj7WfD0r0nhWlYRCxIgeuB/WBf3Rl4
         Q/QixX8csqcqF+6sh01LS8qyBizsBNiYL0WaGfG8eR3G7LTc0CqEH3rcWGk9lPQVZ20q
         nrKxYLGmWylKHrUL0zcY0zraBndmDjnTJxgVVWhNP2WNB8TQCr+SaZlyP2HebwKBagwd
         dN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=csnNe32Mb1sBYL5xyHWNBq5X2DM3melVl9dy6kewzWI=;
        b=AanyhJO2kwp0rTWIrgJ3nGL4LsyK6TmClh0EaQNmkpDlp8X3kgQR82OPuNzO57+n7L
         YMTInCrp8U12WGdO4K06dhkBqctNWb3R7jB5vcchU9XFwzzielr2uRerc7Xxfi6T9N+7
         vAP/GF1Y3oG6VBS9N5l7LAQ6DCdRbe8IyQmG06XNHItoxScYZlirOMYmlWh0MyVb1BzC
         TvseL2fVqzAfeGu0vBFLUK6hn/HxdhUxmY3FnCsDsht7Ucyj+ARrJ23Zp30AWjlhlDM1
         XRGkmexBcl/7FKLeW1mEx7GcR1Y2ccn36lT17U/qFiIWdjRcNt3mbb1PgvdVYXUnhBTo
         mGXA==
X-Gm-Message-State: ABuFfoherXt1G2QXNyQkE0HVX3sdDeY0w1fet2zjKNNOI/WKWzEUh4aq
        adjuHmcXhrY9qKZO9esFNRrVBKKnZYw=
X-Google-Smtp-Source: ACcGV608dCXvjSKw/NQqzefaG8Y58JhSskYKJpEesem0rD+vXdZIsM7NGHk3dh1uY35OVvgz+KXhhg==
X-Received: by 2002:a1c:448a:: with SMTP id r132-v6mr6040253wma.132.1538001105699;
        Wed, 26 Sep 2018 15:31:45 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id b138-v6sm558595wmb.1.2018.09.26.15.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:31:45 -0700 (PDT)
Message-ID: <7dfadae9a7896db71fabc71bc7c489791be27baa.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] MIPS: Add Kconfig variable for CPUs with
 unaligned load/store instructions
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 27 Sep 2018 01:31:42 +0300
In-Reply-To: <20180926221815.jfh7uv52oyry2gmq@pburton-laptop>
References: <20180926111615.6780-1-yasha.che3@gmail.com>
         <20180926111615.6780-2-yasha.che3@gmail.com>
         <20180926221815.jfh7uv52oyry2gmq@pburton-laptop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, 2018-09-26 at 22:18 +0000, Paul Burton wrote:
> Hi Yasha,
> 
> On Wed, Sep 26, 2018 at 02:16:15PM +0300, Yasha Cherikovsky wrote:
> > MIPSR6 CPUs do not support unaligned load/store instructions
> > (LWL, LWR, SWL, SWR and LDL, LDR, SDL, SDR for 64bit).
> > 
> > Currently the MIPS tree has some special cases to avoid these
> > instructions, and the code is testing for !CONFIG_CPU_MIPSR6.
> > 
> > This patch declares a new Kconfig variable:
> > CONFIG_CPU_HAS_LOAD_STORE_LR.
> > This variable indicates that the CPU supports these instructions.
> > 
> > Then, the patch does the following:
> > - Carefully selects this option on all CPUs except MIPSR6.
> > - Switches all the special cases to test for the new variable,
> >   and inverts the logic:
> >     '#ifndef CONFIG_CPU_MIPSR6' turns into
> >     '#ifdef CONFIG_CPU_HAS_LOAD_STORE_LR'
> >     and vice-versa.
> > 
> > Also, when this variable is NOT selected (e.g. MIPSR6),
> > CONFIG_GENERIC_CSUM will default to 'y', to compile generic
> > C checksum code (instead of special assembly code that uses the
> > unsupported instructions).
> > 
> > This commit should not affect any existing CPU, and is required
> > for future Lexra CPU support, that misses these instructions too.
> > 
> > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  arch/mips/Kconfig            | 35 +++++++++++++++++++++++++--
> >  arch/mips/kernel/unaligned.c | 47 ++++++++++++++++++------------------
> >  arch/mips/lib/memcpy.S       | 10 ++++----
> >  arch/mips/lib/memset.S       | 12 ++++-----
> >  4 files changed, 67 insertions(+), 37 deletions(-)
> 
> Thanks - applied to mips-next for 4.20.
> 
> Paul

Thanks!

Yasha

