Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599F025CB9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599F025CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeGBV1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:27:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46900 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbeGBV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:27:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id r17-v6so127818edo.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UGrTwGkc1hj2zM7god1Sm9jaEq/BZqkI9LylXh7N+eM=;
        b=ex6mO2TufeAEKEuAlDo1oHwpz2yTK0iBkC9/13GStVb/kiCdT4pY/IybXKYZiuTmTm
         uD3AN/M4yMvFcW32eS1tD+zIxEy84+M5WHdIL5pcYxvADOyChh5SXq0cpSMQupyssjHb
         vHeZEpifNX8auEY+QbHTVSyLrdL42utPzwc0beyH+CrFQv/bXkNPRbJgqZku2ZPpD09d
         d7nDlgR2UsVC9yRUtLPyp7fR9aKTulF45Zj5s/qPpNMw97+ba7XtH30i49Cn4HJGYOIL
         SvbBj/jMKHQaiBNgZ7IgD7vagTgQln3cLQJNgqquG71UiMSBLCf1js3wvKFz7Ip11PcF
         JsGQ==
X-Gm-Message-State: APt69E2gBJPx829PKTsRklYbEXlbRcZ8EGN3mA58Ma7wFRn538kc2trq
        pl6Yyk81XDwIFY1U3fxoeKpYIQ==
X-Google-Smtp-Source: AAOMgpe/Wb9uO4Duzjg0SB4lgnTA1nbu5mN3LzlMSg1yQl9BGLY8OTBCKI8zfSTrfV8TTljA4eZRVQ==
X-Received: by 2002:a50:b2e1:: with SMTP id p88-v6mr25650155edd.297.1530566825092;
        Mon, 02 Jul 2018 14:27:05 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id i12-v6sm1092405edf.26.2018.07.02.14.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 14:27:04 -0700 (PDT)
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
To:     Tejun Heo <tj@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
 <20180702202151.GK533219@devbig577.frc2.facebook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
Date:   Mon, 2 Jul 2018 23:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702202151.GK533219@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02-07-18 22:21, Tejun Heo wrote:
> On Mon, Jul 02, 2018 at 12:08:45PM -0700, Srinivas Pandruvada wrote:
>> From: Srinivas <srinivas.pandruvada@linux.intel.com>
>>
>> One of the requirement for modern x86 system to enter lowest power mode
>> (SLP_S0) is SATA IP block to be off. This is true even during when
>> platform is suspended to idle and not only in opportunistic (runtime)
>> suspend.
>>
>> Several of these system don't have traditional ACPI S3, so it is
>> important that they enter SLP_S0 state, to avoid draining battery even
>> during suspend even with out of the box Linux installation.

Question can systems which do have S3 not also enter SLP_S0 state during
normal operation to save power?

I guess the change of that happening without being in a suspend like state
(screen turned off, etc), is very small because there will always be
something blocking entering of SLP_S0, so that it is not worth
bothering looking into SLP_S0 on systems which use S3 for suspend ?

>> SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
>> user has to either use scsi-host sysfs or tools like powertop to set
>> the sata-host link_power_management_policy to min_power.
>>
>> This change sets by default link power management policy to min_power
>> for some platforms.  To avoid regressions, the following conditions
>> are used:
>> - The kernel config is already set to use med_power_with_dipm or deeper
>> - System is a modern standby system using ACPI low power idle flag
>> - The platform is not blacklisted for Suspend to Idle and suspend
>> to idle is used instead of S3
>> This combination will make sure that systems are fairly recent and
>> since getting shipped with modern standby standby, the DEVSLP function
>> is already validated.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Seems sane to me.  Hans, what do you think?

I think this is going in the right direction, but min_power enables
both DEVSLP and HIPM, AFAIK Windows at least in the past did not
enable HIPM be default.

Srinivas can you figure out what Windows does wrt HIPM?

We may need a new med_power_with_dipm_and_devslp level if windows does
not enable HIPM by default on these systems. In hind sight we really
should have separate bools for each, rather then coding this in
a single level, ah well.

Regards,

Hans
