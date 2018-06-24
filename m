Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED4EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4F924DF9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnhE+0vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4F924DF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeFXHLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:11:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43440 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeFXHLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:11:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id p14-v6so1657680wrq.10;
        Sun, 24 Jun 2018 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJnpxvlHss854XTqSPUAAxz93Rfu1q6qJYVBHEIeCyI=;
        b=qnhE+0vfMxH9DZYHwXw4OssKh9WJzUpUC/VDbcHg0R3+NOwyrzxoarB3DtbrkwHpM4
         hDWuXOyOtPHgL80AwPmCjSO86IDuELEfYsIooyD3bkkVkcaUrBKcheF+Col/LPSH5vBi
         tNujHLRBbBkRuve+5dsLLdKH/xoZiDq+nh71xZM1gGFUYd4EIHT9UKqIlqu9sUtbJtdj
         vRrGmEMZoE7QKL0fjAhLAyhZNxAMTUmosyZec+swF+5+WEShXPIGqiHCedzWJ68b8OM6
         V8wC1Zbt6IYXLGjqvDtRHpu5bBZmUw2BnuzOoCP8PJ1UunvqolXKhFnyhfL5cPXXsxKM
         SOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJnpxvlHss854XTqSPUAAxz93Rfu1q6qJYVBHEIeCyI=;
        b=OKceip303ETw0EEw8KD3WAhlKH9a5uG7hgClPoyG1OqJoTEsR02LrvEKWA9mkunAMy
         E5zJI69jq3WtHIFBEN+KKxsxOdX9YFQ3PoYClY4pstnuu0a403CnOVh0Xu/jGaGEWA+w
         HgKhKJcdVFPA4+tXEd2zEUwq4spH4McfL4Ga2MSP14V60MSNI8cDIuIdrUKvvb8uSSpR
         vHv+K7R7/3fX9gpLKMj+stZKAqNY37Owq75ni1oSikUn45GNy2RDGAbojKeQ7rvg8wWb
         5olUJ+ub8EC6ofnfWXMXELOPEh3IvvDJfT6gGpVnLGK33yPbaVr7BcIL/gmM0Hrl+sP4
         yq/g==
X-Gm-Message-State: APt69E3RTx1fAApJRUw+lTxjeIq7xOmnXyUfe9GMadZcuFiKZ0sy53m2
        r9o2uzb9pVqKHmqnDS40RQ4=
X-Google-Smtp-Source: AAOMgpc7zrd318eGhJPuAaHiNlr9OYIjOvlcVGJWMiB6MGA/RWv7MW1ptt1SWwIXoMJP19BySUumRQ==
X-Received: by 2002:adf:b219:: with SMTP id u25-v6mr6591495wra.1.1529824269160;
        Sun, 24 Jun 2018 00:11:09 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g88-v6sm7811335wmc.27.2018.06.24.00.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 00:11:08 -0700 (PDT)
Date:   Sun, 24 Jun 2018 09:11:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-crypto@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        jpoimboe@redhat.com, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, h.peter.anvin@intel.com,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] x86/crypto: Add missing RETs
Message-ID: <20180624071105.GA29407@gmail.com>
References: <20180507213755.GA32406@avx2>
 <tip-51bad67ffbce0aaa44579f84ef5d05597054ec6a@git.kernel.org>
 <1529235613.4572.7.camel@gmx.de>
 <20180617120012.GB16877@zn.tnic>
 <1529242717.4472.3.camel@gmx.de>
 <1529244178.4674.1.camel@gmx.de>
 <20180617194747.GA21160@zn.tnic>
 <1529289279.31745.3.camel@gmx.de>
 <20180623103622.GA2760@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623103622.GA2760@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> Lemme send a proper patch now...
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Sun, 17 Jun 2018 13:57:42 +0200
> Subject: [PATCH] x86/crypto: Add missing RETs
> 
> Add explicit RETs to the tail calls of AEGIS and MORUS crypto algorithms
> otherwise they run into INT3 padding due to
> 
>   51bad67ffbce ("x86/asm: Pad assembly functions with INT3 instructions")
> 
> leading to spurious debug exceptions.
> 
> Mike Galbraith <efault@gmx.de> took care of all the remaining callsites.

Note that 51bad67ffbce has been zapped because it caused too many problems like 
this, but the explicit RETs make sense nevertheless. When applying the patch 
please don't include the SHA1 of the non-upstream (and probably never-upstream) 
commit.

Thanks,

	Ingo
