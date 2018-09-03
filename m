Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA5BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5282520862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vApzQ0RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5282520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeICQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:54:26 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44075 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeICQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:54:25 -0400
Received: by mail-io0-f194.google.com with SMTP id 75-v6so278947iou.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Op5rprZXqxsDaY0yzNUnJilPlVxPCIJ7drovmWT86dQ=;
        b=vApzQ0RZdg/YQ9Yyjr02onu1NyHkuDllZiAcnOpsvtd5pg6j+c0M+vPZgJsrkvd+gc
         JFNf96JoPMdDNrqUdsbAmQ245rxM4Sul4PsD42hshb3u2NY/G0UCR7+hfsmmpHdfp+Ab
         x4vFVG61XZurnusb1TWXs0Vn4waZi3gIT9p9GerW8kJhGB1Wbo6QyIyc9rQhkW3rcc2Y
         EbpF1HQudQPtiiDIfqUltCPBdt8ZcEFjeWy2ohys0Sug2Ss99UJSLC4CQBBDHNVkXas7
         2aEpAlbbRieBq+aIi5P+akSrD33iYpRxoa2jSsUdJMDawsUa+OJtagTssHDBM3NnqtaO
         LJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Op5rprZXqxsDaY0yzNUnJilPlVxPCIJ7drovmWT86dQ=;
        b=Qf/XlKeCuxLRLAIgCnK4zfIz8+7hStq3a1RzowZ7ID8SMy84/cbEDBOLIn4+9ng1OC
         pQ5NeKtB1OQSgBTwiQQZWdGcoo3AOTfsI4kFYN70JrDR2Rjx34vkh0f/YEFhqCdf6nYx
         38W/rt37cNDnBF8MF41cLIYkaJ8O0zq85RQBFSrZzTsSQZ5M24oErqDk0I19kOIR0xxF
         DoBxd9NNJr0BpW9SAvHqnaxLEcmTG0cjI92TpnKirsSZutYypU9pVmFkJ+CuKG+vJur+
         nvcOeFTrw61QzAkpJHOyesKegB3SfAuBP5FPm42iHDlPZoItsANjvEZNDxaGNdMq48D5
         NaVQ==
X-Gm-Message-State: APzg51AXtCnNU/pEtSOVH6GHQ3OwEL/Urf18gzfQ83he/tyvELViYi46
        Zu9rghWi2zrQQSVswEMZi7yo0Imvnz13FiFMChuanw==
X-Google-Smtp-Source: ANB0VdZHMcXiWjaag0oWnNY7KCsAxfTjolYzoSRPrsmT9dn+jwUQ4z+0ygkn7h1gbqEACT4T1sIrT2mXpK20GzRNhQw=
X-Received: by 2002:a6b:2147:: with SMTP id h68-v6mr18964210ioh.192.1535978068101;
 Mon, 03 Sep 2018 05:34:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:8482:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 05:34:27 -0700 (PDT)
In-Reply-To: <20180831134244.GB19965@ZenIV.linux.org.uk>
References: <cover.1535629099.git.andreyknvl@google.com> <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
 <20180831081123.6mo62xnk54pvlxmc@ltop.local> <20180831134244.GB19965@ZenIV.linux.org.uk>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 3 Sep 2018 14:34:27 +0200
Message-ID: <CAAeHK+w86m6YztnTGhuZPKRczb-+znZ1hiJskPXeQok4SgcaOw@mail.gmail.com>
Subject: Re: [PATCH v6 11/11] arm64: annotate user pointers casts detected by sparse
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 3:42 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Aug 31, 2018 at 10:11:24AM +0200, Luc Van Oostenryck wrote:
>> On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
>> > This patch adds __force annotations for __user pointers casts detected by
>> > sparse with the -Wcast-from-as flag enabled (added in [1]).
>> >
>> > [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292
>>
>> Hi,
>>
>> It would be nice to have some explanation for why these added __force
>> are useful.

I'll add this in the next version, thanks!

>         It would be even more useful if that series would either deal with
> the noise for real ("that's what we intend here, that's what we intend there,
> here's a primitive for such-and-such kind of cases, here we actually
> ought to pass __user pointer instead of unsigned long", etc.) or left it
> unmasked.
>
>         As it is, __force says only one thing: "I know the code is doing
> the right thing here".  That belongs in primitives, and I do *not* mean the
> #define cast_to_ulong(x) ((__force unsigned long)(x))
> kind.
>
>         Folks, if you don't want to deal with that - leave the warnings be.
> They do carry more information than "someone has slapped __force in that place".
>
> Al, very annoyed by that kind of information-hiding crap...

This patch only adds __force to hide the reports I've looked at and
decided that the code does the right thing. The cases where this is
not the case are handled by the previous patches in the patchset. I'll
this to the patch description as well. Is that OK?
