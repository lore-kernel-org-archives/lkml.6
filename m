Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317C5ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFDFF214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5g7OLhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDFF214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeISOGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:06:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44660 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbeISOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:06:52 -0400
Received: by mail-io1-f68.google.com with SMTP id 75-v6so3789520iou.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=thO1O1kkEPA+NIurwfLUH/DmpyCgCrj1RRmWBvsw63s=;
        b=V5g7OLhPdCXxLHElByiZWGgqjK1YzyWrLFZNS4TeWYRW12JNoNLu2Je6/4BbEXhq9V
         SRObO1AsLBn/Vj5Cllw9pH0uC6bBvcxNh0/wixM7mJQGpSMiRnHRQ5MziaVnGtpMkVT1
         7g4SNzN5VRNGLpWTZRQNu/Y4AoTyCIEZ8fVCRjGIDikNqrfW4KgTjJ6MKeP+7B8sdd1r
         1yne/fz/HSEBWXGhekSiChJvWU0iR7BVbL1IO/1LNJHVQltQFseN6Gz7MHsgU5rYpXrf
         /t62jdKKcAVCwkXWJ+bCXXOGXtAd4/xVp+9/NWGa/OOsqMnuIAqB2Jz3kSRCoOQxyITP
         fK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=thO1O1kkEPA+NIurwfLUH/DmpyCgCrj1RRmWBvsw63s=;
        b=mBe+wmZIvWzvku5ldrubVlNi59CphP+6hymdSDkipA2QfO/xJM2mmIwWbJn7RsokUV
         n0Nl9V7+8Z2vtk/57QmXVc2nzcCvF1R8WFEHE12H/cVDAys/xwItkaCVu0JFmI+wF6BN
         zua8XdkU0dSK2wL3TtBABkBx7lgevMpPc3XERhnM9KkqR2gNmr/19F02TftmPrpVFy5Y
         61NXsI65/8wkXnft2/D2d7Hk0DDa8yNU8FYDJvcdO/t7fY1jZuziyvIk3ad92bXoHjwT
         C4fpxoHjZcfS5tJ4CxHse+wenFMaPkgyKtFPE8RAA4BkcEQLfCXsnMRX/aa7Z6iDT9YP
         CCUQ==
X-Gm-Message-State: APzg51DTPDNhczjQ9nUOfHv6z/jVq6mm7oTczMaQTpw4CHG6WAnAgO0F
        jo5WEYYyCD7LyXkeJ/AqRclSIODQNLHOe+rJkERBsQ==
X-Google-Smtp-Source: ANB0VdbgSPd3TD1ZPqfqP9WXEJ3EdXbPe3b4+vS9QALfK9YMxiVsQs62a2wA14jirS0ijVGtYsDDsgo7EHkKAxbkcZg=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr25980503ioe.282.1537345802682;
 Wed, 19 Sep 2018 01:30:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 01:29:42
 -0700 (PDT)
In-Reply-To: <20180919071847.GE3876@unicorn.suse.cz>
References: <CACT4Y+YS55tk5xoPmscBXcgSbLrgWFSLAz1MUEjby0XT8eanmQ@mail.gmail.com>
 <20180919071847.GE3876@unicorn.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Sep 2018 10:29:42 +0200
Message-ID: <CACT4Y+bdzDe_LhQQh-eLapOg0ZsfXFRm2tjUbiAsgS-ObMvwBg@mail.gmail.com>
Subject: Re: bpfilter breaks IPT_SO_GET_INFO
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Fabian Vogt <fvogt@suse.com>, Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 9:18 AM, Michal Kubecek <mkubecek@suse.cz> wrote:
> On Mon, Sep 17, 2018 at 03:36:21PM +0200, Dmitry Vyukov wrote:
>> Hi,
>>
>> I am having some problem with upstream kernel and bpfilter. The
>> manifestation is that IPT_SO_GET_INFO on an ipv4 socket works, then
>> something (that I can't fully localize but can reproduce) happens and
>> then IPT_SO_GET_INFO starts permanently returning 256.
> ...
>> Now the litmus program always fails with:
>>
>> getsockopt(3, SOL_IP, 0x40 /* IP_??? */,
>> "filter\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., [84])
>> = 256
>>
>> I am currently on upstream commit
>> 28619527b8a712590c93d0a9e24b4425b9376a8c, my .config is attached. I
>> don't know what is bpfilter, I see it mentions some umh, if it
>> requires some additional setup I don't it, i.e. I don't install any
>> userspace modules/helpers.
>
> This looks similar to the fallback issue described here:
>
>   https://bugzilla.suse.com/show_bug.cgi?id=1106751#c1
>
> Unfortunately I didn't have time to look into it more closely yet.

+Takashi

But I already have CONFIG_BPFILTER_UMH=y in my config, so it does not
help completely.
Also in my case it is working initially, but breaks after I run the
second program.
