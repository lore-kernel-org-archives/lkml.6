Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1002550F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUoS48dT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1002550F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeFYHQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:16:19 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:34737 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbeFYHQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:16:17 -0400
Received: by mail-ot0-f193.google.com with SMTP id i17-v6so3083159otl.1;
        Mon, 25 Jun 2018 00:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Fayu7ioA2Vjn3JWoS1BJdtj+vKfuxeOiVJG5EohaC0I=;
        b=fUoS48dTkEzanElvwab5nQV3qcHOVgGm8SdxkMtiotzWr4+q+O5KxXtg/BOZfOYVQ6
         8x1lnxjAGtyYvthDv62czfbqRdHK9DQhiiXYu2THtGHuSHCGk6fhJfBvXazFiUu/PG2X
         0TckObUHmVTyJ5uM7B5DpdiZcHu6emPpTvQLVip1+Z7+O1bZoV1qm/6kAiMe9JFjQoeT
         vUIUNycgTdS/f5EbXEAf8P7e97rgGeqP12tDfBqDqoUyWSSEgdXqzMW7WxDh/Vb0VQUC
         hlNJgu4C76RJzvXOY9OAFGqo0ILJwr8HJknCBu2dB9/SnMNDKLlc+sUVvHQLJcKXeR50
         awnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Fayu7ioA2Vjn3JWoS1BJdtj+vKfuxeOiVJG5EohaC0I=;
        b=X4B99iiA/u3zS6mVMx9yURPSjCS/hHtV4hy/0HUfE7fjAtGxRseUyf971+QEd2qSag
         WofegPF1LaZA7GxfriHo6wr8ThdwW5iI0c2XwmTrQFc4zluS5WzuknbA/PZuRVnJ/Jos
         cnUmkgFlFSOJhJv1fYjivk+PqGUGJu8wy44EXkggwmwnkh3EKQf3FZkHDAymm8cvM2ao
         iLofbs6T+hpBqRCxH0h4toKdxhuSQAaYam+Scgehw25KV8/de+8Ax+upH/YXDod9vw3z
         TfVoYPjixQA2hf7NSm389jGMrFX0mkjG0hPOPDaJ5edDBEFG1VzVUC7aYOIFfcqc6ymk
         blUg==
X-Gm-Message-State: APt69E3Rxs+KWwOzgvstsRHtFYzhsjCpmQJXKbsrzMwgZKgAJiE9akvc
        0e7HdiUOv6EvWnU1hPiQ6fHG8F/PevTXUfcGack=
X-Google-Smtp-Source: ADUXVKKBlnb0fYPwjg8jGI8xbLV/vB/qIK6m+J5gDl7YBJkxSngbF0mRa2PHcwEQNvHfHpqJNNG7bBwtvoo+Op8t198=
X-Received: by 2002:a9d:cc7:: with SMTP id o7-v6mr6357503otd.291.1529910976776;
 Mon, 25 Jun 2018 00:16:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 00:16:16
 -0700 (PDT)
In-Reply-To: <20180621191443.GB14623@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com> <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com> <20180621191443.GB14623@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 09:16:16 +0200
X-Google-Sender-Auth: 85AWFdz7J4GCaJZ2pkwJGA-XUR4
Message-ID: <CAJZ5v0gHPRa-9btfCCYEDDphZrEy8DTrXjsn57MoKMAu7sKMEA@mail.gmail.com>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 9:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Thu 2018-06-21 14:08:40, Rafael J. Wysocki wrote:
>> On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> As security becomes more and more important, we add the in-kernel
>> >> encryption support for hibernation.
>> > ...
>> >> There was a discussion on the mailing list on whether this key should
>> >> be derived in kernel or in user space. And it turns out to be generating
>> >> the key by user space is more acceptable[1]. So this patch set is divided
>> >> into two parts:
>> >> 1. The hibernation snapshot encryption in kernel space,
>> >> 2. the key derivation implementation in user space.
>> >
>> > uswsusp was created so that this kind of stuff could be kept in
>> > userspace. You get graphical progress bar (etc) too. As you already
>> > have userspace component for key derivation, I see no advantages to
>> > uswsusp.
>> >
>> > If you have some, please explain.
>>
>> Not having to transfer plain text kernel memory to user space is one
>> IMO.
>
> Well, AFAICT in this case userland has the key and encrypted data are
> on disk. That does not seem to be improvement.

Not really.

With the encryption in the kernel, if the kernel is careful enough,
use space will not be able to read the image even if it knows the
passphrase, unless it can also add itself to the initramfs image
loaded by the restore kernel, which (at least) can be made way more
difficult than simply reading the plain-text image data via an I/F
readily provided by the kernel.

>> Besides, the user space part of what you are calling uswsusp has not
>> been actively maintained for years now and honestly I don't know how
>> many users of it there are.
>
> I'd assume distros want progress bars so they still use it?

I'd rather not speak for distros, but if hibernation images are
written to fast storage, progress bars are not that useful any more.
They are not used on Windows any more, for one.

> Anyway, there's solution for encrypted hibernation.

Which is suboptimal and you know it.

> If Intel wants to invent different solution for that, and put it into kernel, they
> should explain what the advantages are, relative to existing solution.

I'm not sure what "they" is supposed to mean here, but the advantages
are quite clear to me: better security and reduced syscall overhead.
