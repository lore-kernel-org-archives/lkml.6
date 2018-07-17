Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11436ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CC620C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrivR68M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CC620C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeGQJzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:55:06 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:45344 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeGQJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:55:06 -0400
Received: by mail-oi0-f50.google.com with SMTP id q11-v6so718200oic.12;
        Tue, 17 Jul 2018 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zV6nE8D5+Gj8JWPwt+5p70IzYfVEcG8kEaSvKiS4g40=;
        b=TrivR68MmgwzPGqKz1gM11CxKEof2kCzeVB6jeAW4tjmj4w0cEZA6wGlPeiOgWwRlv
         4sNCHBti/W07thEjEbtolQ1PrPX06PCW1KSRUZCXG92CWDnE692Tgu7JfEXS46i1/o+n
         hvSdZGEPdZ/ZC2MfXRrnwLLu/lh50aEipfMxPR+eig5vZVpMdk9bu+YKpIrCyh4GlsVW
         PZUzBHDeKBhLveKpC67zegy6D0EL0oXDJpofc9zpPIQihze262HrLGR8hihikkgFWPXX
         c349sBFVb3aRn+SJODGphQgEdYCmk12EtqdziZ5UurazuJDfcSqXIVWjMA/96z4LbaSC
         gZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zV6nE8D5+Gj8JWPwt+5p70IzYfVEcG8kEaSvKiS4g40=;
        b=JJ6FxqvoauUu6n/mIDzy+Mu47N/YzQp9RgamSasfHtywr5Kj+GeM/SmXB0H4o6Ox+1
         tbs/dpAS2HrdbQl9nd3A2NGD7nknPzU64ZnWx1iUnuX4/wb1uiBxS092K3mzuy5/fXc2
         rgjtU8mtXXMoxLXKDE9SeyuL5PhIZgZ/9YjwJCxDTh8vP6IQN0dm8D5hzzWXkL5iJrNl
         tiYNDo0ntEK8NkjRPLKQOj9xJkbWcztu/h4dPr8cB9DC8HwwiL9wkeVyba70p81VwzVf
         3id7by7Csn7VHD7Xi+u+i0Th7Q3llz0AAKXJh27JGPz1LuzPzQqLJJ94aHNdhFR+mkWT
         UP8g==
X-Gm-Message-State: AOUpUlHbep/+vFX4Zof+cRvTJ9Q6Hns3Hhn6J3oK3W1yFFd4P7wRNpzI
        7SQZE6s8NNdu8VHJaXXFY4tTXfg92TIsNNBj8k0=
X-Google-Smtp-Source: AAOMgpcogObnHqOdTq7fjMQwjtuWzs9jo9bm8g3QmIZ1WaWekoeyvOgiOLObuDY1IHHafya8Gqt5lSycm3QBjRgzOUU=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr754204oig.282.1531819406179;
 Tue, 17 Jul 2018 02:23:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 02:23:25
 -0700 (PDT)
In-Reply-To: <20180717091152.l4ixicbp6imvqtsr@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <CAJZ5v0ihkNKPrtzKynt8jgQi1JjwCm+SdoUnu4XqoPSkOroHvA@mail.gmail.com>
 <CAJZ5v0gG5XNmpR_0U+6EOFHPeVz+EhunLoQ0-sXDCBg8QL3mQw@mail.gmail.com>
 <20180717085039.kqxwbkgruhj5qxtx@suselix> <CAJZ5v0ivJiPhuh7Gk3KpujKjvFGAY6EYQrNdu8=kao59xqsgHw@mail.gmail.com>
 <20180717091152.l4ixicbp6imvqtsr@suselix>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 11:23:25 +0200
X-Google-Sender-Auth: YUGCsPyTU1NVy21jIflvTMTfyDs
Message-ID: <CAJZ5v0hu6d26Qu1d-NRoO8RXic2ooTEfXzcmJyRGPSOsH6OznA@mail.gmail.com>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
>>
>> [cut]
>>
>> >
>> > On balance before this commit users could use pcc-cpufreq but had
>> > already suboptimal performance (compared to say intel_pstate driver
>> > which can be used changing BIOS options).
>>
>> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
>
> I think this is because of (in intel_pstate_init()):
>
>         /*
>          * The Intel pstate driver will be ignored if the platform
>          * firmware has its own power management modes.
>          */
>         if (intel_pstate_platform_pwr_mgmt_exists())
>                 return -ENODEV;
>

OK, because of the "Proliant" entry, right?

So it looks like we have an issue there.  We find the entry and we
look for _PSS.  It is not there, so we assume that the firmware is
expected to control performance, which is not the case.  It looks like
we also should look for the presence of the PCC interface in there.

I can provide a patch for that, will you be able to test it?

>> It should be initialized before pcc-cpufreq (according to their
>> respective initcall levels), so in theory intel_pstate should be used
>> by default on the affected systems anyway.
>
>> What BIOS settings need to be changed for that?
>
> Already answered in other mail.

Indeed.
