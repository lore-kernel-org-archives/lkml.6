Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ADCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE522146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXjX8G6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECE522146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeIRR35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:29:57 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38136 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIRR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:29:57 -0400
Received: by mail-yw1-f65.google.com with SMTP id n21-v6so640944ywh.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RlK2Au7f7Pw0XN+y1/uWdu8MO+Nry4x3rQoc7bdLLWo=;
        b=YXjX8G6rpXbfHutJCG3KhruQBW90GtH7pQ9sahNp2HCVaD16B8j9XV/RmEYcrTpgVO
         cBY6E7EWAF92OCdB3LB2mqOKzfn6WOsLDys1pJKjOgsEh2d8eLXlDtgl/ncNOkb79eHV
         fBH7SFozD71XS60HDZoGRV3uCCMSA+fbrPZZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RlK2Au7f7Pw0XN+y1/uWdu8MO+Nry4x3rQoc7bdLLWo=;
        b=fJnz8sSToCSWD1IJWwOyO9tSiwd0QmVeY/QyHrPj4YSPOpnkShAYOmWjy+cwZvvXp1
         yVBpXvOeIEn+y+ciWPY4V7DKDGdNYx8d5gebS3DCIT3Bs5D2v4gcYRIb1EvVVXZ82kJe
         DmVVlo33d+FcTA3/iSzT8+/c8/Fs/YHisK2sFWRRUVK5gNN5RCj+tmHklKXKVrIhZRv9
         ksHcfWY50rVnDtsXWs4RJg2R/f8pWTqJKC7CYJ73484GjKG2uSJ5OtQOEiKZJO4xdp75
         InkEaCjLCdGrTo7AS3/z9iTzgzKE0RK1A8uUieUxH80EGHXBpt3bebpx+rF3HSuN5B5m
         gJTA==
X-Gm-Message-State: APzg51AB86XxeAo0HoVg6q56Bz2J5pwbTDxwxQrjkMkHS1mY2uhoEsiY
        wCe29LTKaiizvYOVvuQeJ4mGdlZH8ss9Ne/A+0h5CQ==
X-Google-Smtp-Source: ANB0VdZ/0qFOo0U1nAPvrC9VYwTSWTYwpGNRLiSh5mAwbZaAk92J9zyLKhsXK/ju7rFTeHdrlM3T34gGzxYJ+RT2o/Q=
X-Received: by 2002:a81:1b82:: with SMTP id b124-v6mr12433657ywb.381.1537271860818;
 Tue, 18 Sep 2018 04:57:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 04:57:40
 -0700 (PDT)
In-Reply-To: <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <1536914314-5026-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 17:27:40 +0530
Message-ID: <CALxhOnjxFiWd_rTKnUo4dAYZZgqi_AqVsCj1AB8yHL-KwvMpQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: Add system call table generation support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 September 2018 at 15:28, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 14, 2018 at 10:39 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> The system call tables are in different format in all
>> architecture and it will be difficult to manually add or
>> modify the system calls in the respective files. To make
>> it easy by keeping a script and which'll generate the
>> header file and syscall table file so this change will
>> unify them across all architectures.
>>
>> The system call table generation script is added in
>> syscalls directory which contain the script to generate
>> both uapi header file system call table generation file
>> and syscall_32/64.tbl file which'll be the input for the
>> scripts.
>
> I think it would be best to name the files
> o32/n64/n32 instead of 32/64/n32

This is an easy fix. I'll make it in the next version.

>
> It would also be helpful to mention why the n32/n64
> files cannot be combined into one nfile here.

Sure.

>
>
>> +364     32      pkey_alloc                      sys_pkey_alloc
>> +365     32      pkey_free                       sys_pkey_free
>> +366     32      statx                           sys_statx
>
> You missed the additon of rseq and io_pgetevetns here.

As I mentioned in the cover letter:
"I started working system call table generation on 4.17-rc1. I used
marcin's script - https://github.com/hrw/syscalls-table to generate
the syscall.tbl file. And this will be the input to the system call
table generation script. But there are couple system call got add
in the latest rc release. If run Marcin's script on latest release,
It will generate a new syscall.tbl. But I still use the old file -
syscall.tbl and once all review got over I'll update syscall.tbl
alone w.r.to the tip of the kernel. The impact of this thing, few
of the system call won't work."

Hopefully, the next version does have this change. Thanks!

- Firoz
