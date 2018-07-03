Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1F0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D1621906
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D1621906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754752AbeGCKV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:21:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52115 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbeGCKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:21:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so1736244wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3/ary9HyLKxDVmz2Y9V1ewp5HN0ZMowExcvoCy/pMs0=;
        b=KimhS/hUguDT2a2X+bvgHh2K/GakXV9r60V/sWPAD2E77pjTF3v6ru/5zhbcAiojoz
         QBA4ccWxdaTBo7CldDNXIXbk6E7663MGkr/rjaJoS3EB1HqzdY47BUO43Voih59wxmqc
         L7whmlPV+NHea7it45GZjGo2+GLnatj7cpdCXwRh/EYZ5gL80QVN6naDPkHPur2PfCWs
         mh0e1XUMu3jurs7KeOkXVxM2btF2lzTYL2vxPmIRktRfI6XfzNSJhfPIUElvnGwe/DNW
         +6yzTLzSyBhte7U3qbE1hUyfEpTn905EDwR8sX59sYEO2e7lUeeYK8qUGLpStjgB+Yt4
         3j5Q==
X-Gm-Message-State: APt69E13nS0TPD7oaQKaQmnzIsn38oQgPf0NqOhnEYHj8TUW3+LQdQEv
        3yN6kcv20Hl/F/hhCS+AczLtXg==
X-Google-Smtp-Source: AAOMgpeDWVqEOTMyVeBjOAHd2B5axunE2DS1rbHn1a9SNtjueft/Le0qFlCPyMGJfPrHl0wR1snZnQ==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr5207003wmf.93.1530613312184;
        Tue, 03 Jul 2018 03:21:52 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 74-v6sm1834820wmt.31.2018.07.03.03.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 03:21:51 -0700 (PDT)
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
From:   Hans de Goede <hdegoede@redhat.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tejun Heo <tj@kernel.org>
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
 <20180702202151.GK533219@devbig577.frc2.facebook.com>
 <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
 <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
 <fefe0ef4-e21f-72cc-18d6-a5a6693c21c6@redhat.com>
Message-ID: <660d4e4b-361f-e6b1-ef21-3985c321183a@redhat.com>
Date:   Tue, 3 Jul 2018 12:21:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <fefe0ef4-e21f-72cc-18d6-a5a6693c21c6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-07-18 10:57, Hans de Goede wrote:
> Hi,
> 
> On 03-07-18 00:08, Srinivas Pandruvada wrote:
>> Hi Hans,
>>
>> On Mon, 2018-07-02 at 23:27 +0200, Hans de Goede wrote:
> 
> <snip>
> 
>>>>> SATA IP block doesn't get turned off till SATA is in DEVSLP mode.
>>>>> Here
>>>>> user has to either use scsi-host sysfs or tools like powertop to
>>>>> set
>>>>> the sata-host link_power_management_policy to min_power.
>>>>>
>>>>> This change sets by default link power management policy to
>>>>> min_power
>>>>> for some platforms.  To avoid regressions, the following
>>>>> conditions
>>>>> are used:
>>>>> - The kernel config is already set to use med_power_with_dipm or
>>>>> deeper
>>>>> - System is a modern standby system using ACPI low power idle
>>>>> flag
>>>>> - The platform is not blacklisted for Suspend to Idle and suspend
>>>>> to idle is used instead of S3
>>>>> This combination will make sure that systems are fairly recent
>>>>> and
>>>>> since getting shipped with modern standby standby, the DEVSLP
>>>>> function
>>>>> is already validated.
>>>>>
>>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.int
>>>>> el.com>
>>>>
>>>> Seems sane to me.  Hans, what do you think?
>>>
>>> I think this is going in the right direction, but min_power enables
>>> both DEVSLP and HIPM, AFAIK Windows at least in the past did not
>>> enable HIPM be default.
>>
>> Windows and Linux will need to meet the same criteria to reach SLP_S0
>> state. OS is not deciding whether we meet criteria or not, it is
>> firmware deciding, and it will look for SATA IP to be in certain
>> predefined state, before generating this SLP_S0 signal.
>>
>>
>>> Srinivas can you figure out what Windows does wrt HIPM?
>>
>> We can see that under Windows the SATA rail voltage is dropped. I don't
>> know if there is any other method other than DEVSLP configuration. But
>> I will surely check around.
> 
> I understand that we need DEVSLP, but AFAIK DEVSLP is entered automatically
> after being in slumber for a defined time. The question is how we get into
> slumber. Currently with the new med_power_with_dipm policy we always use
> DIPM to enter slumber. Your suggested switch to min_power means also
> enabling HIPM. What I'm suggesting is that it might better to have
> DIPM + DEVSLP rather then DIPM + HIPM + DEVSLP.
> 
> So basically the question is does windows use:
> 
> a) DIPM + DEVSLP; or
> b) DIPM + HIPM + DEVSLP
> 
> If b. is the case, then I'm fine with your patch as is, but if Windows
> does a. then we should mimic that, which requires a new power-level as
> our min_power level is b.

So digging a bit deeper I just realized that another important difference
between med_power_with_dipm and min_power is that min_power by default
set the ASP bits making the link go to the slumber state instead of to
the partial (power-saving) state.

According to:
https://www.intel.com/content/dam/doc/reference-guide/sata-devices-implementation-recommendations.pdf

ASP defaults to off in the iRST drivers. But that is a document from
before DEVSLP got introduced.

So we need to know if Windows and/or the iRST drivers use HIPM and
ASP by default on these systems. If they do then using min_power
is fine. If they don't use one or the other we are going to need
a new policy reflecting those settings and use that.

Regards,

Hans

