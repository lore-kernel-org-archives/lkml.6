Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C21C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEADD24065
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0wqxpRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEADD24065
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754150AbeGEPKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:10:23 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38344 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753874AbeGEPKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:10:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so17536421oie.5;
        Thu, 05 Jul 2018 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6OZFBje0pznb7nNKxAn4oHr1435wc3TX7CS4LEBzkHw=;
        b=W0wqxpRqk2efC7UplTUHVZeC2WQMWVj64QH/S0S3YydFvmEuVkux4QAVbeidfKC4wI
         HWQTK+A2peECMcb3Kcok3xCg12G398+mQotDka6nxKeW/wp9E7506BzkCLAA3hD8Rxpe
         lz+JAMjy2GtbJtSrUiuemiDUCyeB/RBgbv0o1nrzSxDvc1rO6Is4/MVnVUMHEk35ugAi
         exnNu+Ev6gEixK3AdQVxeis71IKSJu7zGoXl11w6gurJdI2tiM1Z04L7boBGrx7Mjrnh
         fFpGxlFuxgca5YcAKrEdPTDwQJFNJKTn/n0jcJFBvTLpL5/7DXUk+rIG1NUVLfH/eXbg
         f2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6OZFBje0pznb7nNKxAn4oHr1435wc3TX7CS4LEBzkHw=;
        b=OlsDAtNJf/ShxWIRqXpeRPmPusytjdroh8gk2Bh39H9pHPKizrR1d32m1Vy4O6yYDG
         adVl6ogva97PY2w3DZqNB9ovDkYqM/BRqocLQOwMJbr/tfzyZ8dQ2Fcus4vGlZgkCice
         A4f11CvC25F5GqzSZbPP3k2wBXVDYxB1Qfx+usXv+0FQzQD03h0Xs1YN9RDcV8yf2vaE
         rLx+m8YAEsfBFGbxSa/LGmnvIGQ4TY6AmsqsOZAYp2OGu4w7VxwKNlEblm3mCF8UKDKD
         J1l6V3k5hiV1kmZ1AUVbAcl0e7tyr7a16NjGj9gz0BB23EQSWIWjMb3B0CnxeuatUk5+
         bpYQ==
X-Gm-Message-State: APt69E1wZWj3pA4f/GANAIOClTZprwXdXcvkBk3kENuKGEWqtvX1SHKx
        9D5sAdjcX65da0a/0DrbEYcCVo1xdTaKSNZCepk=
X-Google-Smtp-Source: AAOMgpehrBGKAvxw7qnWdn5Q3sXp5xpyzj3ubInWtXn9Jdbp67q4c/DDbMywOv5AvftayhuBKUPCvfF1mga5DG+ZbIo=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr7766218oib.116.1530803421307;
 Thu, 05 Jul 2018 08:10:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:10:20 -0700 (PDT)
In-Reply-To: <s5hk1q9u3cf.wl-tiwai@suse.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <CAJZ5v0guCPET3gM-G_NAM-BjER2D3yW2i_CwR-5sHyNzCQ6R+Q@mail.gmail.com>
 <s5hk1qaui3w.wl-tiwai@suse.de> <1999215.6UrMtQZ5Bj@aspire.rjw.lan>
 <s5ha7r5vq2r.wl-tiwai@suse.de> <da324a44-9520-db81-2106-146d98431a54@cosifan.de>
 <s5hk1q9u3cf.wl-tiwai@suse.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jul 2018 17:10:20 +0200
X-Google-Sender-Auth: Xw_lt3xekggequfUCfG63KsPknQ
Message-ID: <CAJZ5v0jgYmxu5S8JBJdtDn3MFDAroig=ZhK=V4Ec9iELZSfP6w@mail.gmail.com>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thomas H4nig <haenig@cosifan.de>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 5:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 05 Jul 2018 16:00:14 +0200,
> Thomas H4nig wrote:
>>
>> Am 05.07.2018 um 14:12 schrieb Takashi Iwai:
>> > On Thu, 05 Jul 2018 12:41:03 +0200,
>> > Rafael J. Wysocki wrote:
>> >>
>> >> On Thursday, July 5, 2018 11:50:11 AM CEST Takashi Iwai wrote:
>> >>> On Thu, 05 Jul 2018 11:34:59 +0200,
>> >>> Rafael J. Wysocki wrote:
>> >>>>
>> >>>> Hi,
>> >>>>
>> >>>> On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> we've got a regression report since 4.17 about the behavior of
>> >>>>> power-off with the power button.  When a machine is powered off with
>> >>>>> the power button on desktop, it reboots after a few seconds instead of
>> >>>>> power down.
>> >>>>>
>> >>>>> The manual power down via "systemctl poweroff" works fine, so it's
>> >>>>> possibly some spurious wakeup by the power button action, and some
>> >>>>> ACPI-related change is suspected.
>> >>>>> The regression still remains in 4.18-rc3.
>> >>>>
>> >>>> There are only a few ACPI commits directly related to power management
>> >>>> between 4.16 and 4.17 and none of them looks particularly suspicious.
>> >>>
>> >>> OK, interesting.
>> >>>
>> >>>> It looks like the power button state may not be cleared sufficiently
>> >>>> after it's been pressed which is now visible for some reason.
>> >>>
>> >>> Hmm, where can such a state remain?  Since it happens after the
>> >>> machine turned off, some (ACPI) wakeup bits?
>> >>
>> >> Basically, yes.
>> >>
>> >> It looks like a GPE may remain active which then triggers wakeup after
>> >> shutdown.
>> >>
>> >> On a hunch, I'm wondering if reverting commit
>> >>
>> >> 18996f2db918 ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume
>> >>
>> >> (may not revert clearly, though) makes any difference.
>> >
>> > OK, I'm building a 4.17.x test kernel with that revert, in OBS
>> > home:tiwai:bsc1099930 repo.
>> >
>> > Thomas, could you try later the kernel in
>> >   http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930/standard/
>> > ?  It'll take an hour or so until the build finishes.
>>
>> With your new built kernel
>> 4.17.4-1.g6f23755-default
>>
>> the power button works again, so the revert solved the problem
>
> Thanks, that clarifies the cause.
> Adding Erik and Lv to Cc.
>
> I guess it's the side-effect by removing
>         acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
> in acpi_hw_disable_all_gpes().
>
> This function is called from acpi_power_off_prepare(), and the machine
> goes to power off without clearing the GPEs, hence it's woken up later
> unexpectedly.

That's correct.

We need to fix up that commit.  I'll try to prepare something.
