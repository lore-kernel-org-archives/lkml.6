Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2735C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7CC2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWW9Fec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7CC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeGJL4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:56:41 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37113 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754085AbeGJL4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:56:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id k81-v6so42019195oib.4;
        Tue, 10 Jul 2018 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PArMBcmWro098NLATOToBFRIob27r6Dihegrx1snU4c=;
        b=OlWW9FecM+voON8Ar0nYCA+34FnFQI+as3qqma054Cn3z0eTie9LkdaXqLoOc/MQVJ
         ymPu6gDwpQ7Qepv/5pT5LJb+1iwUEyDemW+3MIrIQ/f8gvr8ENFilEpBtofqeaZE24Nu
         LVMQtnGdrx8vo0HproG/OxTcjOWCKsy+jVcKi7feNWQuLKt7nWM1IfsTVBxLEhNZdp3G
         e63gwqi0dOz2nNggQxuxaf90z/A9/G+YURYoMIVbZbc3d7L4K7gs2PtApHaKITYHRTVi
         VeE7A5thPcj4n3M9tIeJcSNgNznqo6OsCuOpM4sQvBPb9KGyNVm6hejacAYuFFQqm3Ka
         QW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PArMBcmWro098NLATOToBFRIob27r6Dihegrx1snU4c=;
        b=V1RlPwHqQQ/7ourmKp7Ia4PpzRNcWFCp+r7F8PT94tLaKaJRBuAX39m+g9GMwj/7Rg
         R0pLA5pzSsvSMovhACsi3WRe9t1WwjpfCeQ9coR5Z/7CDVDGMq13j7leEfV9VCWFh3XN
         MEe/p4R5gOJMZXnjBzH6EQNN4EDPJUKVRcSFRw/fGN1vf8nfM5WmW005WkrgpmROsnb7
         wxSgbfOJU9pXWXYwfCKFwaXovB64YCcdh3uKnpmYv2F5Pp9hGkmuu+uS+vPgTLRfNEJs
         D7Ah31oS9oVHlGpZmoXCXhFJQH5J7nAfDAtqmdKzTRxM0oAtL3L0lHUeRCqj8m4RKAV6
         8t6Q==
X-Gm-Message-State: APt69E1jpj525kqF7dStl8J5O0eL1x78cxJqGNyZpLsxihPcZsvNzyJh
        gJYbs0AzBaaiV39DAQLwmrEQLH8xTpXIt4io9Qo=
X-Google-Smtp-Source: AAOMgpfM7gnoTZAvHWPozb3eUp3s4DGoO0HyoMQjLSMaqLY980bhXE3r7E64JeKK4XqZRoiyLk5eaOIKP7L2OaWTHW0=
X-Received: by 2002:aca:d00d:: with SMTP id h13-v6mr29034605oig.50.1531223798871;
 Tue, 10 Jul 2018 04:56:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:d37:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 04:56:38 -0700 (PDT)
In-Reply-To: <CAKTKpr5bNdo2oXb=Vsm4QytHN1Aw=n_oP7kJHV6yLHuKL-Udkg@mail.gmail.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com> <CAKTKpr5bNdo2oXb=Vsm4QytHN1Aw=n_oP7kJHV6yLHuKL-Udkg@mail.gmail.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Tue, 10 Jul 2018 17:26:38 +0530
Message-ID: <CAKTKpr7wMiJL3NCHp-BkqNFPTDPAB7BxTvbvJagwYY97JCwqHQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <Will.Deacon@arm.com>, jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 3:44 PM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
> Hi Mark,
>
> can you please review this patch?

any comments on this patch series?

>
> On Thu, Jun 21, 2018 at 12:03 PM, Ganapatrao Kulkarni
> <ganapatrao.kulkarni@cavium.com> wrote:
>> This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
>> The SoC has PMU support in L3 cache controller (L3C) and in the
>> DDR4 Memory Controller (DMC).
>>
>> v6:
>>         Rebased to 4.18-rc1
>>         Updated with comments from John Garry[3]
>>
>> [3] https://lkml.org/lkml/2018/5/17/408
>>
>> v5:
>>      -Incroporated review comments from Mark Rutland[2]
>> v4:
>>      -Incroporated review comments from Mark Rutland[1]
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg588563.html
>> [2] https://lkml.org/lkml/2018/4/26/376
>>
>> v3:
>>      - fixed warning reported by kbuild robot
>>
>> v2:
>>      - rebased to 4.12-rc1
>>      - Removed Arch VULCAN dependency.
>>      - update SMC call parameters as per latest firmware.
>>
>> v1:
>>      -Initial patch
>>
>> Ganapatrao Kulkarni (2):
>>   perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
>>   ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
>>
>>  Documentation/perf/thunderx2-pmu.txt |  66 +++
>>  drivers/perf/Kconfig                 |   8 +
>>  drivers/perf/Makefile                |   1 +
>>  drivers/perf/thunderx2_pmu.c         | 949 +++++++++++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h           |   1 +
>>  5 files changed, 1025 insertions(+)
>>  create mode 100644 Documentation/perf/thunderx2-pmu.txt
>>  create mode 100644 drivers/perf/thunderx2_pmu.c
>>
>> --
>> 2.9.4
>>
>
> thanks
> Ganapat
