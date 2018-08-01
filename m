Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ED4208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkODkbuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ED4208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbeHATbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:31:55 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41778 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390457AbeHATby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:31:54 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so36148841oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/hrQ/zVHKT8Nzvab5rUiOWM6k45yoYeCt80tXk2VamI=;
        b=rkODkbuXHekZlVTk6NLgXOM6QPfcl1xTCjnW2sRz/Ug2PbvgzyXqRB7OXidvKI45XQ
         zPWuHEWtrrsD3d9vNl8grb5SQr1B8vbaYZRdX3fxN9U/QlGYtsxvVFRFCz9F5QqVVymC
         Il+0uwYyxq3oDvyXsXVFH3VH3Vgnb5FyOqTHoXtqk/RehhuawPkRODtjAq0QlksCubXW
         AKtuefHW3Jde7yMPce0eA9PoqYCrt4ewieTShmAv4vTnOeInzqHnEmG4q9ftOAgCDANf
         CGUuRyRZf4DCox3bO0RMoDE8D2JySdheWIuhsevUtGtKovPbr7ZnAELxdJeA8Wnk7/kY
         rhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/hrQ/zVHKT8Nzvab5rUiOWM6k45yoYeCt80tXk2VamI=;
        b=YeVnuDh6f2pXUJcnWOHtMB5+AT0GcbLd3p+S9axTVYgXAMpbZ6NxFziji61JURMcqe
         5s+dLSkAf7MBHCg7bssRytjeSURyXo+RK0344lb27E59R6dReo94azzELwpiAo+Iaqq3
         jLjGS/34YAZZzqLbuyZYQLD4JipxJXyPNl16T2hk+GczZX75e4JVHmXcQy2mYoxj4PIr
         4uN++A35nFvthEC15lyja5WALb28KbdQNGZ+yrDBEAhjHlqJRyM7eZ1T9zGSS3efHfWk
         cJt6WMzF9vBvb5k8RNzMIQN3QCqTDqxbmYZuPWrEJJHY2ttmPAN0fPS0ZzhbBX9ib63j
         MpJA==
X-Gm-Message-State: AOUpUlEJOblkPzOJbg9vitS1KJMz5RlJrVbmk8y5PHZA2UmYd4ZNafur
        bjxm9dL41+GZJM8P5zOI/9HhqcTPVioK+40jFQbtxQ==
X-Google-Smtp-Source: AAOMgpd54c6tmQPxTskl+tIkz5hXNCXzGmEwvNidwohvsXbC7PspjYfjfsGXj7iYgu2Xz0XFRPuOtEDIQOnlpMzv2ow=
X-Received: by 2002:aca:7c5:: with SMTP id 188-v6mr4752997oih.58.1533145505868;
 Wed, 01 Aug 2018 10:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180730211254.173686-1-pshier@google.com> <alpine.DEB.2.21.1807302342570.1725@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807302342570.1725@nanos.tec.linutronix.de>
From:   Peter Shier <pshier@google.com>
Date:   Wed, 1 Aug 2018 10:44:55 -0700
Message-ID: <CACwOFJQqqh6m2x+JXBnmeCzS7Zb-3e+5iPzp_vAZPGCqW+i_8w@mail.gmail.com>
Subject: Re: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Peter Feiner <pfeiner@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Thomas. Wording issues understood and will post a new patch
with updated subject.

Re goals: purpose is to expose feature bit with side effect of
"ept_ad" in /proc/cpuinfo and is not necessarily related to VMX code.
We are upstreaming some internal patches that we think would be
generally useful and I will be careful from now on to remove any
wording that is not publicly relevant.

On Mon, Jul 30, 2018 at 3:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 30 Jul 2018, Peter Shier wrote:
>
> > Subject: [PATCH] proc: added ept_ad flag to /proc/cpuinfo
>
> The 'proc:' prefix is misleading here. x86/cpufeatures is the right
> choice. The /proc/cpuinfo display is a side effect.
>
> Also please avoid 'added'. Changelogs should be written in imperative
> mood. Something like this:
>
>  x86/cpufeatures: Add EPT_AD feature bit
>
> > The Intel Haswell architecture has an EPT feature whereby the access &
> > dirty bits in EPT entries are updated without taking a guest exit.
>
> Why would this be Haswell specific?
>
> Aside of that I don't see what this has to do with exits. From the SDM:
>
>   " * If bit 21 is read as 1, accessed and dirty flags for EPT are
>       supported (see Section 28.2.4)"
>
> And nothing in 28.2.4 says anything about exits. It's all about whether the
> feature is supported or not. If it is supported it can be enabled in EPTP.
>
> > This patch adds the "ept_ad" flag to /proc/cpuinfo if this feature is
> > available.
>
> See Documentation/process/submitting-patches.rst and search for 'This
> patch'.
>
> The other question is why is this new feature bit not used in the VMX code?
> It needs to be checked to enable the AD bit in EPTP ....
>
> Thanks,
>
>         tglx
