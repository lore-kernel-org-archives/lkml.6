Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EFCD6C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58752086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yb17vIrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A58752086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935292AbeFMROp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:14:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46179 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934817AbeFMROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:14:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so3533004wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EROisNuytDAC4Hwc5gDl2CvKh6rGFXXrPE5ytSvRLbQ=;
        b=Yb17vIrGLDotKv/9U7WARSkj470RkMUIsOH2r3RbvjDFdd12kvsYCGmBnt+VntT5lh
         csgbGqatq4JgMr+T9rKMYKRizTFChIGBtSJilAWa6NVaSbh94RQTYCC4g7seAwf2wvyU
         SEyyteYiQtbE8gMuI7WKTIo+Lz/Z23stHS0Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EROisNuytDAC4Hwc5gDl2CvKh6rGFXXrPE5ytSvRLbQ=;
        b=rSQsDD/N4OIkWY7bm2neiwRUfGyNrOJ52KCEb5jytzOeU7Bw23uxObbrXP/taI7KVL
         tsHbMqFXBUZrHM/kC6hcdZUxnNc7qLCV5BII+K/MFxU50AnUK+sVf2En60sHJ4tFqI4q
         RLgQMB+DflxbRnxf6ioZ6yRM+IeVctdCkSzA+H0BtmPR15ww05MVqEeYhkTqFsP/W3TA
         eLTJlxQKNca1iGvGhw9666on5pQq+/MRTvzkQW5rxzzc1IiZaJ6XhtCnoVwEHCrkJCQP
         XIZIIzKOotJcnMNssVF3Unjl4WBIBkG4fFg/7U8eVI4uaDIQN3yV90FvOsHENr9SIkiW
         EglA==
X-Gm-Message-State: APt69E1/UMquMiQr67B/uesbbVJhe6jfgJJzFEu/COlQtg9yPRTG6vwS
        il0av6lhniK//9cVCV4b+TNSAVCsWnqK6NWeWiM1OA==
X-Google-Smtp-Source: ADUXVKLt7xNIcTbR75kI/kJT61vgW5OUDB/owgvPXxMpw6KCXbWjyz13JYBJqJuiWh5gqzGgvQR9fMobMzqqoXSixyQ=
X-Received: by 2002:adf:9582:: with SMTP id p2-v6mr4749972wrp.252.1528910082964;
 Wed, 13 Jun 2018 10:14:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:8ac3:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 10:14:42
 -0700 (PDT)
In-Reply-To: <1fc9a078-160d-b9ee-4eaa-9fb970520606@arm.com>
References: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
 <20180613041319.GA112168@atomide.com> <1fc9a078-160d-b9ee-4eaa-9fb970520606@arm.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 13 Jun 2018 10:14:42 -0700
Message-ID: <CALAqxLWuqns5Reo68xeGRdo3+s5Nf0rYNqHRiFG2WbQC_b_LHA@mail.gmail.com>
Subject: Re: REGRESSION: "wlcore: sdio: allow pm to handle sdio power" breaks
 wifi on HiKey960
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ryan Grachek <ryan@edited.us>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 7:42 AM, Valentin Schneider
<valentin.schneider@arm.com> wrote:
> On 13/06/18 05:13, Tony Lindgren wrote:
>> * John Stultz <john.stultz@linaro.org> [180612 22:15]:
>>> Hey Folks,
>>>   I noticed with linus/master wifi wasn't coming up on HiKey960. I
>>> bisected it down and it seems to be due to:
>>>
>>> 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")  and
>>> 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
>>>
>>> When wifi fails to load, the only useful error message I see is:
>>> [    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
>>> to get_sync(-13)
>>
>> Sorry to hear about that.
>>
>>> Reverting those two changes gets wifi working again for me:
>>> [    8.754953] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
>>> [    8.761778] random: crng init done
>>> [    8.765185] random: 7 urandom warning(s) missed due to ratelimiting
>>> [    8.779149] wlcore: loaded
>>> ...
>>> [   12.945903] wlcore: PHY firmware version: Rev 8.2.0.0.237
>>> [   13.058077] wlcore: firmware booted (Rev 8.9.0.0.70)
>>>
>>>
>>> Any suggestions how to resolve this w/o a revert?
>>
>> Sounds like we need to ignore also -EACCES if runtime PM is
>> disabled for MMC. Care to try and see if the patch below
>> helps?
>>
>
> I don't use wifi with my board (I have an USB ethernet adapter), but I do
> get the same error message as John.
>
> Reverting the patches works and I do see wlan0 being brought up. Sadly,
> applying your patch doesn't seem to fix the issue - and actually it seems
> to freeze my board on first boot with this error:
>
> [   11.169127] wlcore: ERROR timeout waiting for the hardware to complete initialization
>
> On second boot it finally comes to life, but issuing ifconfig freezes it again.
>
> $ dmesg | grep wl
> [    5.922661] wl18xx_driver wl18xx.0.auto: Direct firmware load for ti-connectivity/wl18xx-conf.bin failed with error -2
> [    5.933904] wlcore: ERROR could not get configuration binary ti-connectivity/wl18xx-conf.bin: -2
> [    5.949158] wlcore: WARNING falling back to default config
> [    6.199806] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> [    6.210738] wlcore: WARNING Detected unconfigured mac address in nvs, derive from fuse instead.
> [    6.221644] wlcore: WARNING This default nvs file can be removed from the file system
> [    6.235180] wlcore: loaded
> [    6.820146] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [    7.280611] wlcore: PHY firmware version: Rev 8.2.0.0.236
> [    7.388339] wlcore: firmware booted (Rev 8.9.0.0.69)
> [    7.409610] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> [    7.417815] wlcore: down
> [   10.628867] wlcore: ERROR timeout waiting for the hardware to complete initialization
>
>
> Seems like it's not getting powered on, which might be why those mmc_power_*
> calls were in there originally ?

Ryan Grachek came up with a different solution. I still need to
validate it, but it seems promising:
  https://lkml.org/lkml/2018/6/13/481


thanks
-john
