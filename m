Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B80EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 171692086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4QNlN2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171692086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933133AbeFLSwu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:52:50 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50216 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754047AbeFLSws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:52:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so744877wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g1ew7Cyzkwe29we6u9V8RUXpPocg/90t/58XG9lIzJw=;
        b=V4QNlN2FAVrGSMZRt41MbNtrmlW5wvWbf7L1ZNNLEywkvNyT4MUHnGV5ImMmLvquVM
         Gv1ZFxDXJsMvz2zlr11Xg8Nq48h5L8+VisTui0wdSXSFBkqTZnx4wLboeC604qom+lM6
         4XxzS7gdPc7PiY/Cr30etwwh+g9QS1lWnkp47N/gfa19dPIfieWuTbAYEZ6kk6jMhAe3
         t1J6pJcdBDN9/eM0RA+phL1ft4ZH10L1iUMDSAcBuvpxSqwb2iHh+XwOksKTVGWsVE01
         REGeLj8eg5YawYH/jCE8ItrKtXWvODdiEHHG+TvLD5jzMivJcQnVnYp29u97LlIn/DbQ
         y/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g1ew7Cyzkwe29we6u9V8RUXpPocg/90t/58XG9lIzJw=;
        b=M/0wE+Ze6Ssi5MTWMSuWzrHcXnt8UdaFzGFeYymsyx05UxLFsqhudz4G5640QBjUKA
         LUxdpeZbZqSk14Z2yZwVU8zxzvXWEpZeeZYMmCZ3N3mmgGch4hVJcKZpmdOvV9XHIN9t
         Vbyc/2k7+JTFkp33vQrg514au63u5Lg6XEfskGZxsDD11a9UPb3J6fI4XfCRjYQerg20
         IjfQ8FvQsg/TJ1eZBS7uFgkpNrh/YtF3uwIPUp1a2z5p/zPY+iHw1Q8F0hDkucEzBr6E
         7Dmh4smAiL75++kIXzg2LJGR5WNuVG2Zh5uSbkjJQl7/G2Tr7+LXCKG5FVKuimnblLzX
         wsFg==
X-Gm-Message-State: APt69E2IABy39hSnQjWpMJIp7X5bIiX6gh+ug4TZszyKI6eOOQHXFUX6
        BuhbvImAyU7P0SOfy2fSVQHduYAwITtJ7KX+cQI=
X-Google-Smtp-Source: ADUXVKL9ducfiKbiTvWdD5Ehg9H9IHnQHscdNft1kHpo141vPmg4M603phcU/Xm/XBsawwy0tpBXLxrZF8lmRaqP/SM=
X-Received: by 2002:a1c:bf0c:: with SMTP id p12-v6mr1170537wmf.120.1528829567590;
 Tue, 12 Jun 2018 11:52:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e241:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 11:52:46
 -0700 (PDT)
In-Reply-To: <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
References: <20180612083449.100099222@infradead.org> <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 12 Jun 2018 20:52:46 +0200
Message-ID: <CAHpGcMJSb4pqWF7X3K7yrk+N=FwcSrbjWm9xvprpaLRGgdE24A@mail.gmail.com>
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        quilt-dev <quilt-dev@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-12 18:47 GMT+02:00 Linus Torvalds <torvalds@linux-foundation.org>:
> "
> On Tue, Jun 12, 2018 at 1:39 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> As mentioned by Linus, swait is exclusive mode and had better behave like it
>> and be named like it.
>
> Ack on the patches.
>
> I do note how quilt emails are really hard to read, because that:
>
>     Content-Disposition: inline
>
> makes gmail think it's flowed.
>
> Which works horribly badly for patches, surprise surprise.
>
> So I really wish quilt wouldn't do that. It does smell like a gmail
> bug, but at the same time, why would you use "Content-Disposition:
> inline" when you don't have an actual multi-part email? So I do blame
> quilt too for sending nonsensical headers.
>
> (Yes, yes, I see the "It is permissible to use Content-Disposition on
> the main body" in the RFC. But the RFC also makes it clear that it
> actually matters for how things are presented, so saying "ok, I'll do
> flowed" seems equally insane and equally technically RFC-compliant)

Quilt uses those Content-Disposition headers to preserve the patch
filenames; the full headers look like:

  Content-Disposition: inline; filename=foo.patch

Various mail clients use that as the default filename when saving
emails, but there's been at least one other mail client that didn't
handle those headers very well.

Is this a new problem with gmail?

I'm not sure whose workflows would break if we kill those headers
altogether, but maybe we can omit them by default.

Andreas
