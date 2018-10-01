Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B856BC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD872089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="BRZGAbFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD872089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJBDYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:24:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44020 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBDYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:24:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so1586857pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 13:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sAozqltruqLaPW3vEy/GQ2e78SQygReVUHoN3pE32f4=;
        b=BRZGAbFzzy2ZBbhcof1z/k0UjdbadnDoG8+JN9AnpXYcqiPXTOnxqFrTmvSvz9OdE+
         L8ESI01hUsS1/ZVAFToxKTjsrKP9DQdhe09tc9RZ3wI6UQEdN6V7+4v34z4E3jEtdFqn
         qt3kHUuZcN/SztJETmI6Yz831gwDt9pmnAJP5eJiLKe1rOA7fIthNPF0dfrRxidZHxL0
         I68ExO+1bwJfcphKWBS5VHRS3SSSoMoTThcgGO/vxLicz74Dey/HxQlLeuo+8NfqGaTL
         B5WWuM6F5f57taDhPHxgMst55n43A9WxnhH53ehB6tOMmkD1qEN3ovCd3cKeN8E+xa/0
         TZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sAozqltruqLaPW3vEy/GQ2e78SQygReVUHoN3pE32f4=;
        b=LDniffi61mjp9FADrbnf8Q86eL8xoEeL/SicGZE+t/WAoGRgD6ipRaxQ01Rj5Ns3Rz
         zVc6Fg75XFt/5ze0KGcfQqbvZe5d6MTbSS12BcHxn5ynh0hQ/HonGBcN4VAxI4wMezRi
         Zv9HjF9AYBnmTaP327DpC7entEdVes3UePucIVauOId7TqQDW4vU7FJnRWzbmNxkgOn0
         +gJS2xNQw23T2pG9rb+8DVEG1H9DkCbQoBtIgMZy2ymHdjxJN4QtDIMeo2IjTedlfdZn
         Sxl+S1xapG67H8R1ZPjuFtbDfU604Ei4CfNMVbUBDcVGjEcFsSGRenevcN9L3fKbzXpU
         WXdw==
X-Gm-Message-State: ABuFfog+X1V234RzUG/unxuhXZUyXBUiFRQ2uRJ1tR16sd3x+7ygd6Cr
        oWfsVfnbYoH6eRlMS53uRqzP6g==
X-Google-Smtp-Source: ACcGV60qk46zbEWfn+SPaacn/Qk5sysnWozoXo95YPudJscXKtiVlESO8TMgRbjZbvESMCLIqMz4xQ==
X-Received: by 2002:a63:61d0:: with SMTP id v199-v6mr11846771pgb.242.1538426705122;
        Mon, 01 Oct 2018 13:45:05 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id z5-v6sm19067649pfh.83.2018.10.01.13.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 13:45:04 -0700 (PDT)
Subject: Re: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
Date:   Mon, 1 Oct 2018 13:44:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 11:49 AM, John Stultz wrote:
> On Mon, Oct 1, 2018 at 10:58 AM, Mark Salyzyn <salyzyn@android.com> wrote:
>> Last sent 23 Nov 2016.
>>
>> The following 23 patches are rebased and resent, and represent a
>> rewrite of the arm and arm64 vDSO into C, adding support for arch32
>> (32-bit user space hosted 64-bit kernels) and into a common library
>> that other (arm, or non-arm) architectures may utilize.
> So I feel like this has gone around a few times w/o much comment from
> the arm/arm64 maintainers. I'm not sure if there's a reason?
I am "forming an opinion"(tm) that ARM is not interested in any work on 
32 bit arm architectures. They have no manpower that they are willing to 
devote to this.

Despite the gain of 0.4% for screen-on battery life, where Android has a 
mix of 64 and 32 bit applications, thus still relevant _today_ on 64 bit 
architectures (providing vDSO32 for 32-bit applications).
> I worry part of the issue is the scope of this patch set is a little
> unwieldy (covering two architectures + generic code) might leave
> maintainers thinking/hoping someone else should review it.
Original was submitted by ARM author as a complete patch series. Failed, 
so I took it over and have broken them up into 5 logical groups of 
adjustments to divide and conquer.

Was submitted one group at a time, out of eventually 5, with more than a 
month between them with no up-streaming action. They were reworked based 
on comments and split into smaller pieces (the first 12 were a much 
smaller set for example). Over the years (yes, it has been years) I have 
settled on resending the 23 patches, still has 5 groups, and each 
individual patch is tested one at a time, so they can be taken 
individually from each set.

ARM has complained that they want them all at one time because 
individually they represent more work. So the whole set is here ready to go.
>
> It seems the patchset is already somewhat broken up into separate
> sets, so I might recommend picking just one area and focus on
> upstreaming that first. Maybe the in-arch cleanups for arm and then
> arm64 and then maybe do the move to lib?

They are in set-order, The first 12 can be taken one at a time to 
modernize arm so that it is up-to-date with the assembler code for 
arm64. More or less the order you just outlined.

TahDah :-)

-- Mark
