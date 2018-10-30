Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE5EC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8299D2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf4zCaJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8299D2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeJaD2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:28:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40711 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbeJaD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:28:15 -0400
Received: by mail-qt1-f193.google.com with SMTP id k12so8836942qtf.7;
        Tue, 30 Oct 2018 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3ldqB7sqGLLhjb7b7WUPwK9+CPZA78yPvaHaPUjv0A=;
        b=nf4zCaJhdTQ6jGzq7PLBpTix6P1G2XG+Eu4tHDL8YZr7n4P3JBEMgxQx614myxrBL4
         V8hM9CTvVsrNoIocG1JxvTfhSsGnE9PIf/Ew/QAZWuyG+NqK1I8vDo6nQ+xNH2BMjrkO
         9IUEVMry5MXqHI9anc13Kq1RAhs0ODll/aWMTTPUjsFRHVUHQf3ZH5H2/OH8z+762/EF
         H8AD87DiluzLWROSZvXpJeATN+P5/18sMmLghPziuZmwbg2uwaJoeBciFF+ozBPXDSMH
         KrCzylnEPOMOqltEIB0B0QCWHFfxnROg5KpRQxk5vtWYIRYahLuhqBGjq/noY7MOgm73
         0nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3ldqB7sqGLLhjb7b7WUPwK9+CPZA78yPvaHaPUjv0A=;
        b=L0u55UkDdMQTEFuK2qpuWQkT2yx1fid7fBps3ycLFbqyl0QzCxupWnE2g7tcHtp7WG
         JoY9coI6vInqL5h03Csy3SVGTCiw9Ea0Ey0WGY+3cApJbSwvKRw6kUMW1Qqcz3ZcPU8j
         3+F6xIrPpND7JTqxlhZ2FI/UNuFsZzb8K9pbwUk2vNpaHTr7bxl0TnR/ymTdFEYx0no4
         U5Z6c6t5+Qb7Xf2y2O0hQfRuyrX4osos4kAYoJBPadys9593o4xd9RmdXSxZTVfWsLw4
         yonNTK3Y9c2nvnmchF0Im39WKXDXOP/hfNRdgmj9uCP9r9xn9h9WwRuVyhoDtrC62X5q
         tdxg==
X-Gm-Message-State: AGRZ1gIuZFTIKNr+GyV7do5XvlV8QgRRE5wtHS3BTmCQkh34YpnZ8e3J
        UmvLRK3hMIRMVld3qt7hwrQHcvFeV8Ss9QsnFfQ=
X-Google-Smtp-Source: AJdET5em6aEElhcN1DSOY3LRnxLXO5pOoRbbVrpCaCANakuQwrJgnRDD9j432nLNtGcHAtz+mbI5f4PoZJKnDCdHKnA=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr3295168qtc.194.1540924419084;
 Tue, 30 Oct 2018 11:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20181006065113.669-1-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcQ3SDQ4X9+LX+y2vB4PWQURid4R=qy5+5PkWHC5nGqQA@mail.gmail.com>
 <a839e9d3-838b-0fb1-55ac-07562ec71313@linux.intel.com> <CAHp75Vd8zUR9LYOj1X-3FgqnB_XVZD5hbA+WPN_7T_6kZBAQ5w@mail.gmail.com>
 <0d940313e1be7ddaa06c5ebf4aea7a4df84540f2.camel@linux.intel.com>
In-Reply-To: <0d940313e1be7ddaa06c5ebf4aea7a4df84540f2.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 20:33:06 +0200
Message-ID: <CAHp75VcF5jB6hnLVbMJJKRvuRN7=0BS+OS1nB-EeR8Y8nTVz3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] platform/x86: intel_pmc_core: Show Latency
 Tolerance info
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rajneesh.bhardwaj@linux.intel.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 8:03 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:

> > > Index printing is required here (for LTR Show and LTR Ignore)
> > > because it
> > > paves an obvious and easy way for the users of this driver to know
> > > the
> > > IP number to be used for LTR ignore. This was specifically
> > > requested by
> > > some customer and Srinivas asked me to implement this so adding him
> > > for
> > > his inputs.
> >
> > So, why it should be in kernel? When user prints this, they usually
> > call `cat /.../file`, right?
> > Is it too hard to call `cat -n /.../file` instead? The benefit of
> > such
> > approach is that it's independent on the file we are printing.
> >
> > (Note, `grep -n <PATTERN> /.../file` does the same`)
> >
> > For more variants
> >
> https://stackoverflow.com/questions/8206370/add-numbers-to-the-beginning-of-every-line-in-a-file
> >
> We get copy/paste data from some serial terminals from systems which
> don't have traditional linux shell or busy box. Not sure if they can do
> cat "-n" option or have this command at all. So line number helps. They
> can't even store output as as file as this is RO file system.

Hmm... I'm not following this. If there is serial connection where at
least you may see things, how it's guaranteed that it will not print
more enough to rewrite the DTE's input buffer?
On the other hand if you copy the data to the other system which, I
bet, has `cat -n` available, not a problem either.

So, the use case here, AFAICS, if you have a debug log enabled and
it's spitted out like SysRq where you can see, but not able to copy
and it's guaranteed not to overflow on the screen / output device.

> But I am not as sticky on this.

Since it's a debugfs and not any ABI implied, I'm fine with it to
have, but I would like to understand the real use case of it (and this
definitely should be reflected in the commit message).

-- 
With Best Regards,
Andy Shevchenko
