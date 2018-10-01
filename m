Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7353C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19E62089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgU7g6Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19E62089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbeJAWyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:54:02 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43184 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJAWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:54:02 -0400
Received: by mail-oi1-f175.google.com with SMTP id s69-v6so11646868oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=huR58y98to4RK6kwf98+jh8WzbEdPoe4XUkb2uJfCwE=;
        b=tgU7g6LzofQgMRuTauOMRrM9c0BiRL5gygEe9YXnzoF/muqHLb2v2I8NnV7Ida76Gv
         7OoBBvYeXWB5EzDpOLtE8UTIx4L/2qwAHS21DyhR/ZFePcsXbEnox9i9qfLH3HfRamgW
         vUXtx/CNb83qcZpIBSsdRd/JIPmjt1BqnpWiB14uC0GsOy3pCAF4jJd0fwcai3l8hcSt
         Qvi/vgT3jiFhirq4S/0PrDuL3OoBcA52uM6W4tFQ43pC26xx13uc2LDOnF0LKXyd4ot6
         DIyqwpUoN5AzU7BKhiKVSFtRHACJxLRgehLEns//ItmP7tRKtqI/SFLAKcWUseO5ljTu
         E/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=huR58y98to4RK6kwf98+jh8WzbEdPoe4XUkb2uJfCwE=;
        b=jcik2VMOZO1E18ivaaWQvFB0Cxv6/cOCFwt+rCMTTdh46JTNbxic8Cyz7IS5VUmmkl
         ZQL5MRXHirZCs3IJnDbpCrO/BHyBDqwtyuo3Knt7EZnyOMCvz2dRL6RQqGt+fS9At97r
         bXqZIPZUCmn/QITWedZz7EwOnLWwXIAYkuLoNLZhs5ckJF9317QstwwGprCYXrledBsZ
         GqEqsOGPd40VvzoOLW8Qpg8k92LjB7sJJrNNg47kb8CZuPk6pWwIkVtg3B93Dkzz/Eyh
         PGPzFXY66tmBpmQHJ44xe3SvmNMZ9efNYnnV41LhDlzTY1xlqqdxsdOsq9111BtGgpkt
         agVw==
X-Gm-Message-State: ABuFfogPO3T2lpepkI0EZNHtGQqYONiqsN9vIr69Qy+mppYtvSatQY8p
        mXJa8q3mrus/r6nArxVB2oHhz0zJkQ9p5Hqpr2VWSA==
X-Google-Smtp-Source: ACcGV61wT7wDwMViyEGDB+hjupX5/9ZS8in7qY6eZVQZzz6z4E78+gN8qE8LVrgBY6SKx/70O6ZoeV2yVCq7Fq2DkpY=
X-Received: by 2002:aca:c444:: with SMTP id u65-v6mr5637287oif.8.1538410529626;
 Mon, 01 Oct 2018 09:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180919122751.12439-1-tvrtko.ursulin@linux.intel.com>
 <alpine.DEB.2.21.1809281151190.2004@nanos.tec.linutronix.de>
 <20180928164111.i6nba2j6mnegwslw@lakrids.cambridge.arm.com>
 <20180928172340.GA32651@tassilo.jf.intel.com> <20180928174016.i7d24puv7y3jwzf6@lakrids.cambridge.arm.com>
 <20180928204930.GC32651@tassilo.jf.intel.com> <CAG48ez16ECnLMNggTZQQJOuPK5ZJ8dLSkGDzvxwK1zVh1BFExw@mail.gmail.com>
 <20180928205907.GD32651@tassilo.jf.intel.com> <CAG48ez1xJ+Y=snnHJ5k6J6O3qqD=bHdjRioLFuzPZpxU9v7xxA@mail.gmail.com>
 <20180928212757.GE32651@tassilo.jf.intel.com> <22155f49-2f57-73b8-6e89-ddd8a127967b@linux.intel.com>
 <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810011741070.32062@nanos.tec.linutronix.de>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 1 Oct 2018 18:15:02 +0200
Message-ID: <CAG48ez2NKxCUncbi7DSyVn0ufBEy0P29gwH=+TnWhNMT2DJgVQ@mail.gmail.com>
Subject: Re: [RFC 0/5] perf: Per PMU access controls (paranoid setting)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     alexey.budankov@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, tursulin@ursulin.net,
        kernel list <linux-kernel@vger.kernel.org>,
        tvrtko.ursulin@linux.intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, maddy@linux.vnet.ibm.com,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 6:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> From a design POV, Jann's idea to have a per PMU special file which you
> need to open for getting access is way better than the extra knobs. It
> allows to use all existing security mechanisms to be used.

(That was Mark's idea, not mine, I just agree with his idea a lot.)
