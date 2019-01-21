Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F8C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB422084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R7n5C9wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbfAUIDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:03:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33194 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbfAUIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:03:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so13883690oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vg4RDLLwAO/ZYWTbu5ufyFQvbdsjKMMEhcfj2Et8fZw=;
        b=R7n5C9wPJqcRHAH58fdUkrMLVF2BQlTrO6/tHDAen3PH27aklixcldVhKCPIuIt3Hv
         O44AdDiI+usunEUzUfM/KEz6Ewc6iXQadlOUBD0RuMEQ2iO3R6RU/N7qZlGjqmcb3Uzd
         FvSi0ZgFKt0XW1Z+nsZJ1uq+Lj7LI1IWCOJYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vg4RDLLwAO/ZYWTbu5ufyFQvbdsjKMMEhcfj2Et8fZw=;
        b=nxCgjI4FhNYsjikqIM1I3g7vjtzbrgYo03bMbURISgICDNVJhYWGaZ5a7M/3GVtKkQ
         iluuDkFsKyZSw5T/0ZFpHJWoQvwhi30C9sGPbE5aMKomSy1smoCfyfcue149Ycl4APab
         K6vD3nO1cx/mBN1h7M/KvJ/bbTneJ/HUU9qsy4qQiHyfkk+AxOXwAh3CqP4Qq+Z2YOfE
         9qHt7DQjzooMvlEVmLX/lmIW7ZBonYOy314ZGRCoE14uspb4LuT7WjwtQPuou0ILJs6j
         HwBn/aOL89QDPPADKP9JuwuJH28Uu8lPrB3NHlRrHfVl3ZpBsbgU9j11flm9cbUZp6Ya
         U4OA==
X-Gm-Message-State: AJcUukeP6xI24STn1OXBp0Zmhet3rPfJRNOLH8YaRLJJyhPwL/SqWzl5
        J69f1gPEz4aFFVInmZdryeI1vNJuddjXlFsi6L2NcHSwhPw=
X-Google-Smtp-Source: ALg8bN4F0pcfbFggIJYSTWnvxuYe2BGog1pCpni1CMPuW/uWqLyLdGrlNPCPje7GYXrCe4zu6FjFeKHz6rxdHfh7KRA=
X-Received: by 2002:aca:2116:: with SMTP id 22mr4977922oiz.42.1548050785511;
 Sun, 20 Jan 2019 22:06:25 -0800 (PST)
MIME-Version: 1.0
References: <1547790380-6276-1-git-send-email-pramod.kumar@broadcom.com>
 <20190118113242.GA8928@e107155-lin> <CAJ+tv6+6yqT1xkmkY3x6SNQ83K+J6zqKZr7PV5A_ffvyEzceqg@mail.gmail.com>
 <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
In-Reply-To: <CAJ+tv6KqynSf5t_VwLqpdM4BF+wLWcJ0wPTD4nWqL4ej1Yih4g@mail.gmail.com>
From:   Pramod Kumar <pramod.kumar@broadcom.com>
Date:   Mon, 21 Jan 2019 11:36:14 +0530
Message-ID: <CAJ+tv6+q+GzBXyv3DH=vX+bc+62YMUCfH7vYLNssyRzBzx6zFA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] arm64: Use PSCI calls for CPU stop when hotplug
 is supported
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 11:30 AM Pramod Kumar <pramod.kumar@broadcom.com> w=
rote:
>
>
>
> On Mon, Jan 21, 2019 at 11:28 AM Pramod Kumar <pramod.kumar@broadcom.com>=
 wrote:
>>
>> Hi Sudeep,
>>
>> Thanks for having a glance on the patch. Please see my reply in line.
>>
>> Regards,
>> Pramod
>>
>> On Fri, Jan 18, 2019 at 5:02 PM Sudeep Holla <sudeep.holla@arm.com> wrot=
e:
>>>
>>> On Fri, Jan 18, 2019 at 11:16:20AM +0530, Pramod Kumar wrote:
>>> > If CPU hotplug is supported, ipi_cpu_stop should use PSCI cpudie
>>> > call to stop the CPU. This call ensures L1/L2 cache flush,
>>> > CPUs cache-cohenrecy setting w.r.to interconnect.
>>> >
>>>
>>> Firstly, this is not specific to PSCI and I don't see any PSCI calls as
>>> $subject claims.
>>
>>
>> I had seen all the other cpu ops methods where only PSCI supports only c=
pu_die features hence
>> used PSCI reference in my subject line to be more clear where this die g=
ets converted in last.
>>
>>>
>>> Next, you fail to explain why do you have to ensure
>>> caches are cleaned and why do you need that in ipi_cpu_stop ?
>>> What's the use case ?
>>>
>>
>> Need comes from a specific use case where one Accelerator card(SoC) is p=
lugged in a sever over a PCIe interface.  This Card gets supply from a batt=
ery, which could provide very less power for a very small time, in case of =
any power loss. Once Card switches to battery, this has to reduce its power=
 consumption to its lowest point and back-up the DDR contents asap before b=
attery gets fully drained off.
>>
>> Since battery can provide limited power for a very short time hence need=
 to transition to lowest power. As per the transition process , CPUs power =
domain has to be off but before that it needs to flush out its content to s=
ystem memory(L3) so that content could be backed-up by a MCU, a controller =
consuming very less power. Since we can not afford plugging-out every indiv=
idual CPUs in sequence hence uses  ipi_cpu_stop for all other CPUs which ul=
timately switch to ATF to flush out all the CPUs caches and comes out of co=
herency domain so that its power rails could be switched-off.
>>
>>>
>>> > Apart from this, this gives control to f/w to reduce power consumptio=
n
>>> > by take appropriate decesion on power rails for plugging-out core.
>>> >
>>>
>>> May be, but ipi_cpu_stop is used is machine reboot/poweroff/halt which
>>> may restart or poweroff the system, powering down individual CPUs is no=
t
>>> necessary and may consume lot of time in systems with large number of C=
PUs.
>>> It would be good to know the use-case in case I am missing to consider
>>> that.
>>
>>
>> Use case as explained above.
>>
>>>
>>> --
>>> Regards,
>>> Sudeep
