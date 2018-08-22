Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A248B208B6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wv92jiT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A248B208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeHVW1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:27:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41978 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeHVW1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:27:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id s15-v6so1330092pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 12:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3BcfIhA3h9s6DdGVmQPVyMaMqFYY5q9/XMxBLMD3h4=;
        b=Wv92jiT66l5eVlezNHU4qDxI4BlEaegyqjhZfkcVCGF3b/0VDMHbqnYRba0i/NxtAS
         1COZsyILmj7fakX/E8K3LJU8W/gfiu+8yg8DlTCjZ8rA4eVVb09N2jG+QOo3ycw0d9Jp
         hVs7OBwOslQ8EQ/6bFYkpRxaxYD4po93cusIVb4YoDMIVpJQCzz8mdUdsbHdEMdk0Rvq
         53TDq1BvSaHxG5GWKRg8a9Jxk8fp87irfq0wX7kQoZJgXq9q+GC/wXDCgF8dSoiELccU
         GFFR4cjJch7CE+VYULGnwbNpzDeYAlmNwZjzBQhJPxiIZY6mvS2n0h3xCu+iwMGn/SUU
         HrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3BcfIhA3h9s6DdGVmQPVyMaMqFYY5q9/XMxBLMD3h4=;
        b=m95NXsCn1xPCitavRzl6Mwd6SMqRbalRrQ3hubxT4v+fbHIGxyMYRT7R/PJeAfo8XN
         qd2AuDgHtyyI4w+to/Be+Wu62R3gxtzdHM7DhVojNunTVPv55gV1PlGldgvDbIlWdcUf
         iOPd8dPrbek5wCZWISlymvsrYRSX8FX3YZKdI5SyoXKFAAJgaTSeZTLl9HPkN4YBC4FM
         BMClPGdAFJcqO9Vx+X1V/nX0kQZObJa+TP/f0EOuFnG5o2pfkuYR2wUPm8vKhTTuUa6F
         Z9zGV3JFdVck5hQcPGwBACa/fUY7tpgxqN8dTIq4DH1xMZgCLax8hjvUIUX6F9ZaoIkl
         ILtw==
X-Gm-Message-State: AOUpUlFlBS3rVnRL8KMPum3GHo1xrBpOsXDazcLrNDZ9PBX/oSc2j+CH
        7bqmVYUMz0eQiLj+08oLNRog44GroKvV8NdSb03CQg==
X-Google-Smtp-Source: AA+uWPxOEV6LvUHNfv6twWfTzLxCnLMnnVTf0+q/Y9zgfGhAgvD2idTHyBUV260xyqpwWWUr7F0qrKy3I42KYb9hVyM=
X-Received: by 2002:aa7:800f:: with SMTP id j15-v6mr58945192pfi.174.1534964499883;
 Wed, 22 Aug 2018 12:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
 <20180821123832.GA19034@nautica> <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
 <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
 <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
 <20180822041646.GA21716@nautica> <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
 <20180822043230.GA26654@nautica> <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
In-Reply-To: <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 22 Aug 2018 12:01:28 -0700
Message-ID: <CAKwvOdkV7=XSG6LOaV9Khp0faGOT=vOsHmuCArDMAXFKeOjaiw@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
To:     asmadeus@codewreck.org
Cc:     joe@perches.com, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:31 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Hi Dominique,
> I'm currently testing a fix in
> https://github.com/ClangBuiltLinux/linux/commit/1f89ae7622c26b8131f42f3a362d6ef41b88a595,

Sorry, maybe https://github.com/ClangBuiltLinux/linux/commits/compiler_detection
is a better link, as the sha changes whenever I modify the patch and
force push.
-- 
Thanks,
~Nick Desaulniers
