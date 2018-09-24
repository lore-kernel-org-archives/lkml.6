Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D791ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6492087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 06:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJ55igBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6492087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeIXMcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 08:32:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53364 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXMcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 08:32:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id b19-v6so8392487wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 23:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jpSmRTRJCcAtMIqv2ySojQvX0ghayb0jRLFlp2rJGzE=;
        b=PJ55igBHpib/gW81zRXjbZPnW5Q6K/MXXKrHbi0d2zgPLidKVdcx2IxQnu8Ov7J6KS
         4jqWmwzqGtrQnAchwhV75llfrmETlQnoUevgvf6acrOJA/2fKX9P/zy3LJPz/rqPJjGE
         zokqk1j8Th2s62+6Y9XY7ST1zLZMFIln6Squs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jpSmRTRJCcAtMIqv2ySojQvX0ghayb0jRLFlp2rJGzE=;
        b=eybx97p76g4LkDK1bkH1ZXpVYLPcde8RNrsZ6RZk2JfGWUnrwKMrUuMo7/DuI/C4Nz
         qgboy4ghy+o53jC0ysHyIt3V5NGChGrtl2sla+l0KLGLEuiePc6kt1MCKTUM2X7CQ1VA
         AhH6ccuradlvdU/cQdNdMobJDWjtOeZbhUbmuqt85BG9K7+rY2KSRO3PkgwDwHK4cLSi
         Lwq0Eg3KJrwCW5/MZBWiTB2AfkjsiwBBQoc6e9G8HTunK5C+VC81WWX+TOkCitiLsxWI
         gOAGEjvQvhuzPm79IO+RP0+k3hAW97S8tOuVsFs6TXKtFAkvZjO44TfXIg1ucEWlrHbY
         4aYg==
X-Gm-Message-State: APzg51Cqpgamn2VVRDI6dkYfJA30aBEziga5xG4G/1x8C2vmP+NUVTkn
        2rjWFYpmpIs/9iLrzhnCqhU5tA==
X-Google-Smtp-Source: ANB0VdZztPR7SoNRbYA1Iczwh4ZB7RTMNX2is3+znHBglx2xnEbokIdTX+B36KDv1VOFN4pkFqhAGA==
X-Received: by 2002:a1c:88cd:: with SMTP id k196-v6mr5216759wmd.17.1537770689556;
        Sun, 23 Sep 2018 23:31:29 -0700 (PDT)
Received: from [192.168.0.41] (89.154.136.77.rev.sfr.net. [77.136.154.89])
        by smtp.googlemail.com with ESMTPSA id 200-v6sm29562946wmv.6.2018.09.23.23.31.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 23:31:28 -0700 (PDT)
Subject: Re: [PATCH 1/2] clocksource/drivers: Unify the names to timer-*
 format
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM/ACTIONS SEMI ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <1537762569-18657-1-git-send-email-daniel.lezcano@linaro.org>
 <20180924062828.4yh3aumcuiihojgu@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7451938d-c600-f070-d1c7-1c77f79518b0@linaro.org>
Date:   Mon, 24 Sep 2018 08:31:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924062828.4yh3aumcuiihojgu@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2018 08:28, Uwe Kleine-König wrote:
> On Mon, Sep 24, 2018 at 06:15:17AM +0200, Daniel Lezcano wrote:
>> In order to make some housekeeping in the directory, this patch renames
>> drivers to the timer-* format in order to unify their names.
>>
>> There is no functional changes.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  MAINTAINERS                               |  10 +-
>>  drivers/clocksource/Makefile              |  26 +-
>>  drivers/clocksource/cadence_ttc_timer.c   | 543 ------------------------------
>>  drivers/clocksource/fsl_ftm_timer.c       | 376 ---------------------
>>  drivers/clocksource/owl-timer.c           | 173 ----------
>>  drivers/clocksource/qcom-timer.c          | 258 --------------
>>  drivers/clocksource/time-armada-370-xp.c  | 416 -----------------------
>>  drivers/clocksource/time-efm32.c          | 287 ----------------
>>  drivers/clocksource/time-lpc32xx.c        | 314 -----------------
>>  drivers/clocksource/time-orion.c          | 192 -----------
>>  drivers/clocksource/time-pistachio.c      | 218 ------------
>>  drivers/clocksource/timer-armada-370-xp.c | 416 +++++++++++++++++++++++
>>  drivers/clocksource/timer-cadence-ttc.c   | 543 ++++++++++++++++++++++++++++++
>>  drivers/clocksource/timer-efm32.c         | 287 ++++++++++++++++
>>  drivers/clocksource/timer-fsl-ftm.c       | 376 +++++++++++++++++++++
>>  drivers/clocksource/timer-lpc32xx.c       | 314 +++++++++++++++++
>>  drivers/clocksource/timer-orion.c         | 192 +++++++++++
>>  drivers/clocksource/timer-owl.c           | 173 ++++++++++
>>  drivers/clocksource/timer-pistachio.c     | 218 ++++++++++++
>>  drivers/clocksource/timer-qcom.c          | 258 ++++++++++++++
>>  drivers/clocksource/timer-versatile.c     |  44 +++
>>  drivers/clocksource/timer-vf-pit.c        | 204 +++++++++++
>>  drivers/clocksource/timer-vt8500.c        | 168 +++++++++
>>  drivers/clocksource/timer-zevio.c         | 218 ++++++++++++
>>  drivers/clocksource/versatile.c           |  44 ---
>>  drivers/clocksource/vf_pit_timer.c        | 204 -----------
>>  drivers/clocksource/vt8500_timer.c        | 168 ---------
>>  drivers/clocksource/zevio-timer.c         | 218 ------------
>>  28 files changed, 3429 insertions(+), 3429 deletions(-)
> 
> Wow, with git format-patch -M this should look much smaller and so
> easier to review.

Yes, I forgot the option :/


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

