Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0284AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB832217B4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+u2H6J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB832217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbeHMTp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 15:45:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45686 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729029AbeHMTp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 15:45:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id w16-v6so13123811ljh.12;
        Mon, 13 Aug 2018 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m1sYTE1JFqOmAsuOarEhHma7dxZeGoetvJlo90mO0pw=;
        b=I+u2H6J+dL5sKVasWiSQWwUSnIpP4W4HC1J8hj9caIBtH6qTuKZ3HArwaklxdrHLul
         RLK1ZQT5AjMCoujj0q/rXHyYqthkk77TusZ9W7dMhXmDKOw4Pl15zO4KSW9ApSCAlpsT
         VGfgRTckAZuYSTJCTq4jwV30I6AEOQX4D6UZIg1gfwwclcIdQYXUBM0U1R5KdwcguZWy
         IQc21+xMDDkErWDXfERsjQxIHSk+PpqbdT3XLjDr+CAQI4dWL0I8a4ILzWhhK1eqZAQF
         xQEwB0uJUB7degqOYraYwopl7nXSoBWeBY2fNYeLHnEniBidPjtpbDFXbMrSMxae/0QB
         /p6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m1sYTE1JFqOmAsuOarEhHma7dxZeGoetvJlo90mO0pw=;
        b=hGYBDSKv3RGxUHuNRhpc/5wULJkxRk14BJUSr2ZYpJBu8yhXCNKzY8MEvbAOcSCcZX
         gt5qX0KfB2VS5P8aOXwJ6HKrjHbcWn7YDb+NJ7BHUXSgindHio78Ygwy/loAeG8aEFWu
         zAgNBcCzmo0cbSWe9adjV1X6Y5pRYlk+mEqqWFQvsIv/dxbIFORm47oZuZ3xM1rQ2PaC
         u3VI6WAKiothwUWwq3G3fuWTy4RFtCf0S25j7MQeegC2/LXmnk7Qc1m1vEflAee9cpYF
         AuyAyh75Knx3Y9a6mGF8pnpa8H/2pHNNnC3Gfm/t2CDJFQXtNBj8xzircNwyo8lLGgVR
         LvOg==
X-Gm-Message-State: AOUpUlFH6E44+fpPGu86rWyYqN5O9ZLlx/VyYGklrmYnSkQSxg/ybH2Z
        JOuYv49uF1lDiOR9APKksDM=
X-Google-Smtp-Source: AA+uWPzWUX2UF3pUbOwoy5OHnmeHHb5XurWKNqIHyU193DK81PIUcsMgtmBQrMTG8QJ68WHDacF9mw==
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr11239465ljk.133.1534179772327;
        Mon, 13 Aug 2018 10:02:52 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id m66-v6sm3438345lfi.17.2018.08.13.10.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 10:02:51 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V5] thermal: Add cooling device's statistics in sysfs
Date:   Mon, 13 Aug 2018 20:02:50 +0300
Message-ID: <18709513.zahsa7p5Fo@dimapc>
In-Reply-To: <CAKohpo=BnVJ5uO5+6p6ONhucHkxS893t6d1gtHJZW1kKB0EXOw@mail.gmail.com>
References: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org> <3394204.qE6hlQGZ2Z@dimapc> <CAKohpo=BnVJ5uO5+6p6ONhucHkxS893t6d1gtHJZW1kKB0EXOw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 13 August 2018 19:53:33 MSK Viresh Kumar wrote:
> On 13 August 2018 at 22:13, Dmitry Osipenko <digetx@gmail.com> wrote:
> > On Monday, 13 August 2018 19:21:43 MSK Viresh Kumar wrote:
> >> On 13 August 2018 at 21:36, Dmitry Osipenko <digetx@gmail.com> wrote:
> >> > I'm working on adding support of OPP and cooling for NVIDIA Tegra20/30
> >> > CPUFreq driver and stumbled upon a bug that is introduced by this
> >> > patch.
> >> > It is triggered on the driver module unload.
> >> 
> >> The problem is that device_unregister() will end up freeing the cdev as
> >> well, so the current sequence is surely wrong.
> >> 
> >> > diff --git a/drivers/thermal/thermal_core.c
> >> > b/drivers/thermal/thermal_core.c index 6ab982309e6a..de53c821a282
> >> > 100644
> >> > --- a/drivers/thermal/thermal_core.c
> >> > +++ b/drivers/thermal/thermal_core.c
> >> > @@ -1102,8 +1102,8 @@ void thermal_cooling_device_unregister(struct
> >> > thermal_cooling_device *cdev)>
> >> > 
> >> >         mutex_unlock(&thermal_list_lock);
> >> >         
> >> >         ida_simple_remove(&thermal_cdev_ida, cdev->id);
> >> > 
> >> > -       device_unregister(&cdev->device);
> >> > 
> >> >         thermal_cooling_device_destroy_sysfs(cdev);
> >> > 
> >> > +       device_unregister(&cdev->device);
> >> 
> >> But this looks wrong as well, as the device is still around while
> >> memory of its sysfs data is gone.
> > 
> > Indeed.
> > 
> >> Maybe something like this is what we need:
> >> 
> >> device_del();
> >> thermal_cooling_device_destroy_sysfs();
> >> device_put();
> > 
> > [I just realized that thermal_zone and cooling_device are not
> > interrelated.
> > I'm not familiar with the thermal/ code]
> > 
> > Thank you Viresh, your proposal looks good to me and works fine. Will you
> > make a proper patch?
> 
> Maybe you send a patch for this and take the credit as well :)

Okay, I'll make the patch. Thank you for the help.



