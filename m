Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83C0C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD2B248E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KreEbtrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD2B248E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754453AbeFVVMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:12:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52914 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbeFVVMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:12:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id p126-v6so3435330wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6qMFvYYk14XIIsB/LlhGnK4BgmSkiulfZWWcxdQJID4=;
        b=KreEbtrSnmxY4GhH2+MXJld06FqilhzkXqSCAHatFPG7+xup8FqkKTF4d/YpJNtaiR
         NH78B5wkBe8ahLDAf+7cwN+27+K1azUnjFWfHZhqKNEn3BKqHM5HArqEweW6JMRSKKyq
         rO28t4tDTpG0rq3IZLShFazX/KGFd9LWKDnbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6qMFvYYk14XIIsB/LlhGnK4BgmSkiulfZWWcxdQJID4=;
        b=Enz0D54W6+sC//oTY9GeVEo/zhm1+kb90lok24jVp8EPbvHtJgklfhOSG1/BAMnnR8
         aiBUv5MtyukefZKnyIfdaKwhEj6LQfAXbNR386hmos48RazqQZWT5+XnrQD7292fhpY2
         t2Q35cgwo5nmaDpCEKCu/GIbYUUhDpXftXVn+3WBpWtWlOu1KDUSyV2skR66wxyP7clS
         SdWiAvlvKw9jA7kouyHeqOu+uyVZQ7ybadEaJNZ1EKZKzs4QAxLnhEjEotOEbwDUzDRV
         om6K6vQwTtsL8LE9dyk+SdPwcGOx4NwlZrkr1jvBYt0j5TWkgSUFi5bbi/qOLXcQWykS
         SUHw==
X-Gm-Message-State: APt69E2m4bj3loIQXBSNoK+pslX99amcRv6KV05pNoSCykMvwQiqtdAm
        uib2+3GJltzvBYbZuM2sK9MgHZLTcaWoTR5DRozFUg==
X-Google-Smtp-Source: ADUXVKL0+creG5KW0qa+M49Rwyvi5uPtTCkfqPlkcv9bAy414sUB1PahHE0k7KBB3daBF54JjzKTtpIYt99mylUodO0=
X-Received: by 2002:a1c:da4e:: with SMTP id r75-v6mr2801626wmg.64.1529701950062;
 Fri, 22 Jun 2018 14:12:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:4088:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 14:12:28
 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1806222308560.1589@nanos.tec.linutronix.de>
References: <20180604133421.19559-1-mlichvar@redhat.com> <alpine.DEB.2.21.1806222308560.1589@nanos.tec.linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 22 Jun 2018 14:12:28 -0700
Message-ID: <CALAqxLUh+A1nJF1n2G_pRPrUQPMD6b-9fAdojPmAOkmnUM+-Nw@mail.gmail.com>
Subject: Re: [PATCHv2] timekeeping: Update multiplier when NTP frequency is
 set directly
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 2:09 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 4 Jun 2018, Miroslav Lichvar wrote:
>
>> When the NTP frequency is set directly from userspace using the
>> ADJ_FREQUENCY or ADJ_TICK timex mode, immediately update the
>> timekeeper's multiplier instead of waiting for the next tick.
>>
>> This removes a hidden non-deterministic delay in setting of the
>> frequency and allows an extremely tight control of the system clock
>> with update rates close to or even exceeding the kernel HZ.
>>
>> The update is limited to archs using modern timekeeping
>> (!ARCH_USES_GETTIMEOFFSET).
>
> John ?????

Yea. I've got this in my toqueue list.  I'm going to take another pass
at testing and hopefully send it your way.

thanks
-john
