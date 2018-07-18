Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A943ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325C220852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHc5N6SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325C220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbeGRL2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:28:54 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33422 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeGRL2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:28:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id l10-v6so7928291oii.0;
        Wed, 18 Jul 2018 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GKQuPuTadR5YjT5DkpjNdD7WSwHDSVQy8MG0OdYR1b8=;
        b=hHc5N6SArKO6LjL08xV40AVchvuUSiDXr5PcYSA9nQ+i7IXygHhdXpleULauA848Db
         2vhPcK1J5kXn7xrTTaNb+dg7f5LbQ4qdG//qQMhoRJIj2pHAi8bg1qGiiuJaMYjKe30z
         2DsjOm5zjkEQi8Pxs1++awx4GeHpoq+lU9dGT2iQwvzGq4uerFPp/cVHpQZqU/Hh3h0V
         VoiyANNBhwxC5j075Vy7ggb47Wg6we8fcCNCG3EdK/Yo2wJlecy1gTlSVBLTw+byo+pA
         9Xa8Kc9BoI8HrucrNi+hg5JqThoykA/3GvQjTzPURAC2BjywLVlifZ5UefW+QAgE9bsI
         QNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GKQuPuTadR5YjT5DkpjNdD7WSwHDSVQy8MG0OdYR1b8=;
        b=ODqnaQkTTkIEsOnHej0XXxfNZAegIKUJib8qtpdFiqb5pfc/tEbLCdLPtnqe0V0hwl
         Vw2EKAC4SzBC+61XSBMNCOec03oFcwT9qNd5H936s+LgfM3edBdU15jp/Z1zXiWZE/me
         ZfUVOgmixImNb2X/1YpwpJOX8Pv0Ef/30H0rzALZ4kRBfWpLoe8m4cub54VNOeSVfQHz
         75nGuJa48hZr0fAGvojrxAKYgGIxNdslxx9iAP3a6AjKo1vNoFqqV51rGFw/cwYQWCjs
         n9JC7TRgXOGtYpRbZA8PKUnYDwZm/ZzX5GA/yZhBjHyzcqKh0gAM2pK/8O6JZG+UHjuB
         NDdQ==
X-Gm-Message-State: AOUpUlHNzMxSYAUSlSmEOXXpWH8EtcXuslxKxwVYw+nkU95xOEHrx1A6
        FhTvEQG6y8ePRyHddi1C9TM2giAKZEEAG4yzkQI=
X-Google-Smtp-Source: AAOMgpfOr1U80/TVsK9f2tZ423oJA6axTFXyu6zq0ktZNR1L8PwuUiUmEohEQbR+QmqAaS/O30n9K/duaGOQMg4Vo00=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr6284642oib.116.1531911095042;
 Wed, 18 Jul 2018 03:51:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 03:51:34
 -0700 (PDT)
In-Reply-To: <20180718104300.dwgbqbnllvhwzrea@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717140336.ayovaz4ksdlak6bb@suselix>
 <8115130.Fhkpr82c7G@aspire.rjw.lan> <2386802.jRaeHeNqoJ@aspire.rjw.lan> <20180718104300.dwgbqbnllvhwzrea@suselix>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Jul 2018 12:51:34 +0200
X-Google-Sender-Auth: 7N06t_PIqvmwo2Yxr7KrJvrL8qI
Message-ID: <CAJZ5v0jqM+CRckgyyP63bin+30HhO+je+fWeS1+J1dz=p3ty1A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Register when ACPI PCCH is present
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 12:43 PM, Andreas Herrmann <aherrmann@suse.com> wrote:
> On Tue, Jul 17, 2018 at 08:06:54PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Currently, intel_pstate doesn't load if _PSS is not present on
>> HP Proliant systems, because it expects the firmware to take over
>> CPU performance scaling in that case.  However, if ACPI PCCH is
>> present, the firmware expects the kernel to use it for CPU
>> performance scaling and the pcc-cpufreq driver is loaded for that.
>>
>> Unfortunately, the firmware interface used by that driver is not
>> scalable for fundamental reasons, so pcc-cpufreq is way suboptimal
>> on systems with more than just a few CPUs.  In fact, it is better to
>> avoid using it at all.
>>
>> For this reason, modify intel_pstate to look for ACPI PCCH if _PSS
>> is not present and register if it is there.  Also prevent the
>> pcc-cpufreq driver from trying to initialize if intel_pstate has
>> been registered already.
>>
>> Fixes: fbbcdc0744da (intel_pstate: skip the driver if ACPI has power mgmt option)
>> Reported-by: Andreas Herrmann <aherrmann@suse.com>
>> Reviewed-by: Andreas Herrmann <aherrmann@suse.com>
>> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> This is a replacement for https://patchwork.kernel.org/patch/10530091/
>>
>> In addition to the intel_pstate changes in the above, it also
>> prevents pcc-cpufreq from trying to initialize (which will fail
>> ultimately, but may confuse the firmware in the meantime).
>>
>> Andreas, please test this one and let me know if it still works for you.
>
> Done that (with system in "Dynamic Power Savings Mode"). It still
> works and system was stable.

Thanks!

> FYI, as a sniff test I've run a kernbench test. I now repeat the test
> with system switched to "OS control mode". Just in case -- if there
> was interference with platform code while system was in "Dynamic Power
> Savings Mode" (significantly affecting performance) I might spot it
> this way.

I'd rather not expect performance to be affected by this, but power
very well may be affected.

Anyway, good idea!

Cheers,
Rafael
