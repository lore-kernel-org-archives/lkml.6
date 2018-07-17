Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C06ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DD320647
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 17:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqi3oLnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07DD320647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeGQSCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:02:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33375 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729713AbeGQSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:02:22 -0400
Received: by mail-oi0-f67.google.com with SMTP id l10-v6so3555820oii.0;
        Tue, 17 Jul 2018 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aDyDjwaAD1SIN1UC3ibG05PEbeLGqp2u0SKPH49Fp64=;
        b=qqi3oLnmjCtwGtO3McdCraYlirZDpq22NeggAju7+AXNXf1BwhrrVrG8Us9MyxRVmq
         T8NGAIdCToJC596c6Au2bdVlam+S2BLgFWAdJWRiiFXYNX+96P5vyuJt0v2S8S7aPoOv
         0+tWwGdggEN/VLdj4Y7o4LDPBJWat367HP7uOH5wxWrLvL9qC+CaaQehAPYsSpZi2seq
         P+JuQ6fMUu/p0C5i0GRgml8PbO2jWYWbieuCiexKj5kTgCXd4FVihtX+KNs+QD1zdlVG
         SWhrhXGyMGG/hUv+j5qI8//UDHGusKOZoe4CHHG5Ksp1YNzwRFDCdSI0MZIfsshNeGTx
         vAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aDyDjwaAD1SIN1UC3ibG05PEbeLGqp2u0SKPH49Fp64=;
        b=acvIe2a7QDzr9oiufICaBYnSGVLrF8YONkYMZ1a6YM2PMmAMIF7PrBzx7G5hvjsV2m
         xbb8x9p8l13S1ODp7g0Rti3/5H+Ijx6U7lbAdFXCa2r5VPm27PQ1vx1xhGgFka36ox3k
         8UPFZlNgrajFLXKeGYaS9rKEqlTqzv33Oci9Xse6dBQFKl5oY1bZoC3sJCnQMfchOqpR
         S5QBAf7lo9efaVKLbN8sqQL77TFCLD0kgiK2riBsgnsohe4+VwaS+LBAxO6WoXW5eB7M
         XOfdimdSH35swzSZI6szxV9mQVJP24WoNBBoLVBt7ZntICmxFdTJXCCLV7cgQc0Pfgjo
         geRg==
X-Gm-Message-State: AOUpUlHvdwcsmJLH2xzci2ULN+/ZGdbPNnCU2DEAYFF6KIqtaa9XVZ/w
        mec4WtCeYJrhWSiFCWaTaStymFEZucnvDRLjcnU=
X-Google-Smtp-Source: AAOMgpfiRmE/WYbmXzBCs0ztM26vsk4oQYUdMF2BM/OA6Jf7rn7BtSQQv2pNeO6JWPv5+dxBjgDg7FgJNPwigAGKiDk=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr2480708oia.154.1531848522082;
 Tue, 17 Jul 2018 10:28:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 10:28:41
 -0700 (PDT)
In-Reply-To: <d4419603cb727bb28fe9ab7abfc9595b78cb7554.camel@linux.intel.com>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717102136.snayvzmv2h3dcwiq@suselix>
 <20180717140336.ayovaz4ksdlak6bb@suselix> <8115130.Fhkpr82c7G@aspire.rjw.lan> <d4419603cb727bb28fe9ab7abfc9595b78cb7554.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jul 2018 19:28:41 +0200
X-Google-Sender-Auth: pR0jJz_m99TcP714uIawkhVnvJI
Message-ID: <CAJZ5v0hFAWr7ozVb9OfVTUPCyjZAtsQsDSm=Le_oMwOxAgTJbA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Load when ACPI PCCH is present
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andreas Herrmann <aherrmann@suse.com>,
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

On Tue, Jul 17, 2018 at 7:23 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Tue, 2018-07-17 at 18:13 +0200, Rafael J. Wysocki wrote:
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
>> is not present and load if it is there.
>>
>> Fixes: fbbcdc0744da (intel_pstate: skip the driver if ACPI has power
>> mgmt option)
>> Reported-by: Andreas Herrmann <aherrmann@suse.com>
>> Tested-by: Andreas Herrmann <aherrmann@suse.com>
>> Reviewed-by: Andreas Herrmann <aherrmann@suse.com>
>> Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> But do we need a change as done by the following commit in in pcc-
> cpufreq.c?
>
> "
> commit 8a61e12e84597b5f8155ac91b44dea866ccfaac2
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Fri Sep 20 10:43:56 2013 -0700
>
>     acpi-cpufreq: skip loading acpi_cpufreq after intel_pstate
>
> "

Quite likely yes, good point!


>> ---
>>  drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> Index: linux-pm/drivers/cpufreq/intel_pstate.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
>> +++ linux-pm/drivers/cpufreq/intel_pstate.c
>> @@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
>>       return true;
>>  }
>>
>> +static bool __init intel_pstate_no_acpi_pcch(void)
>> +{
>> +     acpi_status status;
>> +     acpi_handle handle;
>> +
>> +     status = acpi_get_handle(NULL, "\\_SB", &handle);
>> +     if (ACPI_FAILURE(status))
>> +             return true;
>> +
>> +     return !acpi_has_method(handle, "PCCH");
>> +}
>> +
>>  static bool __init intel_pstate_has_acpi_ppc(void)
>>  {
>>       int i;
>> @@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
>>
>>       switch (plat_info[idx].data) {
>>       case PSS:
>> -             return intel_pstate_no_acpi_pss();
>> +             if (!intel_pstate_no_acpi_pss())
>> +                     return false;
>> +
>> +             return intel_pstate_no_acpi_pcch();
>>       case PPC:
>>               return intel_pstate_has_acpi_ppc() && !force_load;
>>       }
>>
