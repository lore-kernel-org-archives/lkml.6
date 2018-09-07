Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB8DC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD5C2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD5C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbeIHAhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:37:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46950 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:37:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so13158958ljj.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BIBU7gkAa9Pzi0dv7OCWVm0IvhEG0kaPDCv+qAO33jk=;
        b=TKuXhId3feBCR4ArpVEeFaeBYd+KBL3FmFF7EFRr6TbgNkZVOao3/nb2YkHgsrW4iB
         ql9GbdPZIzDhc+iua/oBpunxVeQA943rS1W/VQgMeiYirlD9UJ7LoagD5KJZzUuLhMkF
         ryCNn2Mw0cU/A2LShKXjQ6jRrq5Eo0YBga7E6WgR3ElFv4gwqtI7OPblOlgcVQ6Pqsc5
         UaFrfsKhE2yA7I/TmUqBLtZt+EYP1ojOGXN1Yf+0JU7lDImywNdyZUunk8+m70Bi/VF8
         J5hqwm9/foKvFHGq8os50KKbX4CEnJgMNJ2HP6rcUVLc/IClK2/YmhFjRk4Hy1Mv7oKE
         jy2Q==
X-Gm-Message-State: APzg51CeyTW3pPPeOz/jmKirNjHvLNyGNRuWEcXP9d24k8VVkiR0DgDk
        7glWxiNXpye23ZTjegS0nrWnBWcAakTQZzT4xUPQxA==
X-Google-Smtp-Source: ANB0VdYOgmo3cmBt9QjzRWRqsXXydkIlw5MPumxA+xzDq9CbcEiv73M/S+3XkLYKn33UDV7zqGvvpO6/H94Paf33YzU=
X-Received: by 2002:a2e:8:: with SMTP id 8-v6mr5887985lja.112.1536350104170;
 Fri, 07 Sep 2018 12:55:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:30a:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 12:55:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1809072116530.1402@nanos.tec.linutronix.de>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180907112207.GS24106@hirez.programming.kicks-ass.net> <FFF73D592F13FD46B8700F0A279B802F485BA5C1@ORSMSX114.amr.corp.intel.com>
 <e10acaa8-f5d8-85f3-219c-86fafd793a87@redhat.com> <FFF73D592F13FD46B8700F0A279B802F485BA620@ORSMSX114.amr.corp.intel.com>
 <alpine.DEB.2.21.1809072116530.1402@nanos.tec.linutronix.de>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Sat, 8 Sep 2018 01:25:01 +0530
Message-ID: <CACi5LpM4QoRn5bAwR-ZJHhaih7N41HYGx6MPZXAY78jFsbu9dg@mail.gmail.com>
Subject: Re: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 8, 2018 at 12:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 7 Sep 2018, Prakhya, Sai Praneeth wrote:
>> > > So, if Thomas, Ingo, Andy, Ard and Boris are ok.. I will make it as
>> > > default (i.e. without config).
>
> Yes, that's the right thing to do.
>
>> > Also, some distributions already have specific ways to handle buggy
>> > firmwares which can be at times dependent on the underlying hardware
>> > and the firmware versions.
>
> If the distro patched their kernel to deal with buggy firmware, then:
>
>  1) why did they not upstream it ?

Because some of the kernel fixes are (for such cases), well to be
honest, ugly.. and probably not suitable for placement in quirks
files/common code present upstream as they introduce lots of #ifdef
jugglery.

Also the x86 machines with such buggy BIOS firmwares are too old (but
still used in some production environment) and the OS workarounds are
suggested by the vendors themselves and they historically had issues
getting the quirks upstream.

>  2) why should we worry about that ?

As this allows one to still promote upgrading such machines to
upstream kernel versions and keep the kernel running on them as close
as possible to mainline.

>> > I would suggest that we enable this under a CONFIG for the first round
>> > and once it is tested with wider variety of x86 machines which have
>> > buggy or orphaned firmware and linux (and reboot) works fine with them,
>> > we can drop the CONFIG option in future and enable this by default.
>
> Sure and then nobody enables it and the affected machines still crash or
> hang on reboot. The whole thing is simple enough now to make it
> unconditional.

Instead, why not the make the CONFIG option default to Y. At least it
gives us an opportunity to turn it off if needed for backported/distro
kernels on such broken platforms which might need more testing with
the EFI page fault approach.

That should serve both the purposes. Just my 2 cents.

Thanks,
Bhupesh

>> Sounds fair to me, but, I would like to wait for someone experienced to
>> make the final call.
>
> Please get rid of that config knob. Buggy firmware exists and we better
> deal with it by default.
>
> Thanks,
>
>         tglx
>
