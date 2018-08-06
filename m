Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E074DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3136E219C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVTLcHTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3136E219C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeHFKih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:38:37 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40762 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:38:37 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so20715761oie.7;
        Mon, 06 Aug 2018 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eb6Rwmkoid1MF+f2dDa6LWI1AYrLXaJF/yCt2qr+VEY=;
        b=dVTLcHTomtR/XjVn89Z2wB/LkYTCsOT4ia8i1U4FYkWfhXd55N3PdPk36JttYBrxOi
         SmQ0iMiQZFlbAw/BkaO5Q/SWWzlDidWvNAd03S2akogkaMpGkyGQPm92KdQpUl15EMeF
         rG1eTaEvRtOOqp8Wz3rAuWa5LVeA/XKZ5Icerdjv7AfcxMmecr9oVyFtpTIECuQPwpMK
         cJ08kw5aQ1RpQ/2B1//sWEbX0BaJ40I08w1Ucik6qDC03LkrD5bRSCS23R1LknaOu0yL
         DgPCmYG8vZn5bFpKi9/XddhAqeNzGZMJKdBVj+J4sNm3sNZeBXHegvzUqLd93xi92IxV
         Zqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eb6Rwmkoid1MF+f2dDa6LWI1AYrLXaJF/yCt2qr+VEY=;
        b=LGUEljheO0Y5lfM+07LN8+aXoTW82sq4K9btUR25iqF0038EuXQvFsh/SObJHp1ptP
         TAzy9gLJRoaGYrQiOLCPsP0I7FES+GHvP9H//VOUZuXfjYuQiKBgDbT1VXvBZaWhGrCx
         zBjIAGYiYTe9cNa7Tvf9O+/YNGfS8LoDG8B+h5vhyn7Ja6TE6rdfLnGk8hb/8ia2qyOP
         J0U8ggeiHq6Zic20wY/S3rTKVrv9VMkhn7kiNEjf2P4cR9v97Btdy85W/NnrhUxYyBrG
         l/l53/qel/3DqLHz5flDEJAe39uhWe8yvOTvb0GzFiDsajFrLF7DngTGNBYqBJ2B8bqS
         ubiw==
X-Gm-Message-State: AOUpUlHYrcJtG1xeXuE2LlYU2RyZl7epeqwoTlZWAI3/WqR90gmu2vaI
        wfxJTvMrzjq8cabwDckWAwobms/NV33/rwssefU=
X-Google-Smtp-Source: AA+uWPw4Gcb4FsROX/Zn5tSs3ipgURmd7xbQkGDrhlUNAPX1mxGwm7obfvDEOsnwLFoo4dIQHrOfaY+hTb4kYFn8GS8=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr14615551oih.227.1533544239846;
 Mon, 06 Aug 2018 01:30:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 01:30:39 -0700 (PDT)
In-Reply-To: <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
References: <20180804152932.3861-1-gabriele.mzt@gmail.com> <ccf46de4-d75e-306b-9554-9d33f68d2379@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Aug 2018 10:30:39 +0200
X-Google-Sender-Auth: GPqqLSHabuJrqHf63dlMCiQNVb0
Message-ID: <CAJZ5v0iwhVu6PwztsbN8cYmQtnjD2SyFkazkObc1o-1JX6GO5g@mail.gmail.com>
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy()
 interface for no_turbo"
To:     Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 7:31 PM, Gabriele Mazzotta
<gabriele.mzt@gmail.com> wrote:
> On 04/08/2018 17:29, Gabriele Mazzotta wrote:
>> This change does not take into account that some BIOSes change
>> MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
>> If the turbo is disabled when the system boots, policy.max_freq
>> is set to pstate.max_pstate. However, if the BIOS later enables
>> the turbo, the CPU will never be able to run at pstate.turbo_pstate.
>>
>> Since now intel_pstate_set_policy() does its calculations using
>> pstate.max_freq and pstate.turbo_freq, we can always calculate
>> cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
>> with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
>> speed when the turbo is enabled.

Well, the problem with this approach is that always using
pstate.turbo_pstate as the max causes the governor to overestimate the
target frequency when the turbo range is not available (the target
depends on the width of the entire available P-state range including
turbo, so if the turbo range is not available, the number take into
that computation is too large).

Are we expected to get notified when the BIOS updates
MSR_IA32_MISC_ENABLE_TURBO_DISABLE?
