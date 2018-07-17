Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2717ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E7B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT7ZmNel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E7B20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbeGQJiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:38:06 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:45218 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeGQJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:38:06 -0400
Received: by mail-oi0-f48.google.com with SMTP id q11-v6so638847oic.12;
        Tue, 17 Jul 2018 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=l/OdpnuM/35tsCykHePGm5i7P0/AE7RuQx9WaZ1mNWM=;
        b=XT7ZmNelQNEbnHMkWXt+Y1eMhQt/fMYcsZJKMduYRnEQ5oeSZm7b6gUWfHUajhyh/o
         0yyq5lmXaPG3vw4lxXZc53hJ/hBn4zk3pu2DmQNUcFlRi2Rs1Q6jjXrLH3javH3lFfps
         sGUNVP6BgDHsRwNVXTUppyjduH47gC3SLBUh8/+KR/0sBg3cKETGn1/LrlwmX5VZoocN
         LsgSGJJnarfIsPrd1RmqO1WthqvkbN4YjFIY+9FhEwBQUMHtoDBMReuSI1zV2COsn7Og
         SwYXie7DNojcwVBzvriBWF5mzXsy1drmTfmvIw0/8vzOS6JRNr2JnexXbZL9B1Psj9zi
         D5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=l/OdpnuM/35tsCykHePGm5i7P0/AE7RuQx9WaZ1mNWM=;
        b=Gh4yZNY3GttpimraL9lEJ/FPomNU0iVQR1UAU3eOOkgnPp1sY/GAj/+UZka5i0xOfs
         jl5qv4XdvV/yR67+xG1wD0V8mPKpjLkB9ZE4kE7lvPTb5/D3WDo0cAVZaPVE9KxjCL4i
         +YUMA0cI9pakiCokdKvJfOe+YZTUcs6sK5p8wlARMtkyQX2jokcEOufU/G5xDemSaUcn
         K4Xf+elKIYnVhzLjIxyW4PxSqnEz88ouekGxIOsEfvBS1E3g48WFtWF1m97Q32uF6p/H
         o5DjLaTwthgohvB+iPe2YctyJzfnVpgkJd0SHNXpy1RZFM/rKFJ3mlKrOfAm0vyO+dJS
         rW0g==
X-Gm-Message-State: AOUpUlHA4O1c2Zv0a7Hl4RkR9LUCr5l20s/Kw1dFDgyoZq2ncvZXF5j0
        ePHjE/YKHgMazT5E8rade1fDuRVl27bSqCyCOIg=
X-Google-Smtp-Source: AAOMgpfe6knD8GfNCAQrsIRZhvNLCsdqYvQeZw/G2wSDMyRN5NFKktLTy9LweBs++x+TKKf/erxwGawOKp+JG8Ah43c=
X-Received: by 2002:aca:ad4f:: with SMTP id w76-v6mr787333oie.233.1531818389893;
 Tue, 17 Jul 2018 02:06:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 02:06:29
 -0700 (PDT)
In-Reply-To: <20180717085039.kqxwbkgruhj5qxtx@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
 <CAJZ5v0gG5XNmpR_0U+6EOFHPeVz+EhunLoQ0-sXDCBg8QL3mQw@mail.gmail.com> <20180717085039.kqxwbkgruhj5qxtx@suselix>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 11:06:29 +0200
X-Google-Sender-Auth: cD83MyQbgc-lh7NNBC2kHIQG03w
Message-ID: <CAJZ5v0ivJiPhuh7Gk3KpujKjvFGAY6EYQrNdu8=kao59xqsgHw@mail.gmail.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:

[cut]

>
> On balance before this commit users could use pcc-cpufreq but had
> already suboptimal performance (compared to say intel_pstate driver
> which can be used changing BIOS options).

BTW, I wonder why you need to change the BIOS options for intel_pstate to load.

It should be initialized before pcc-cpufreq (according to their
respective initcall levels), so in theory intel_pstate should be used
by default on the affected systems anyway.

What BIOS settings need to be changed for that?
