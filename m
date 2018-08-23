Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50ADC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C8B21486
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C8B21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbeHWLlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:41:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53620 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbeHWLlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:41:17 -0400
Received: from mail-pg1-f198.google.com ([209.85.215.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fskjZ-0002x9-34
        for linux-kernel@vger.kernel.org; Thu, 23 Aug 2018 08:12:49 +0000
Received: by mail-pg1-f198.google.com with SMTP id s77-v6so2528958pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 01:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dTGzs73E5WyvNyN91vS0ZjtvZJlGWmsB2jYuFMwGO6c=;
        b=CqJoD/Qy5wobiG8GhctBw2NHcLgA+AtVC5OFyVopruYuG6UnMu7pXkj2TsMEII6X05
         v3p4MLGmN7rENIVI/Pizj6bwe6b3CBoRi2pr8sHP4J3Oe4v89jn0D6Kss0gDvtbpMvmu
         uydE2wOvKjAe2Rc8/h5uqaqMW41jk1kigQqTYIDY5vGsceK+dPZSQom2svWB7agVXy2+
         1XFcEGADNGIY0IjlVxu7WNlOrGhyIUHh2oH7kU7h3EKjFPw2O7ZDRWvAUNhFjLN7pVw9
         JNPGLk7MhqECdjrbwHgdGjAc+34/zVj/flXrjmZyjTr5wZQw4xiYmiKWOJnZPa1aAt3Q
         4lfA==
X-Gm-Message-State: APzg51CYSOkIXcou5t08mds86u15ohG2pKxNh5xd62t1XHuseMhpCQjK
        UzZ6I6UoR73zQim8wvtDjdUjhSMtEzw2YNL5XUC4TWczw72j+v5o7maW/quyI2vlv9CSziRuca5
        4g5udRMH9lJZ+gTDJCx725icoXysezTdnd24yd+yCmQ==
X-Received: by 2002:a62:f555:: with SMTP id n82-v6mr5586339pfh.59.1535011967630;
        Thu, 23 Aug 2018 01:12:47 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdZVOfVpIOfQl+b/aljmv/a4rSlvzDcJk/ZppVnJ8cXeCLVYI7Hnee63dIA73ff0nzuCAUI7ag==
X-Received: by 2002:a62:f555:: with SMTP id n82-v6mr5586314pfh.59.1535011967388;
        Thu, 23 Aug 2018 01:12:47 -0700 (PDT)
Received: from [192.168.1.206] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id n80-v6sm5948044pfb.95.2018.08.23.01.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 01:12:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH 4/5] memstick: rtsx_usb_ms: Support runtime power
 management
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAPDyKFp0ut38EountRQ7pJPXGCQPZzzMroyBz6GAh25DJGMwkA@mail.gmail.com>
Date:   Thu, 23 Aug 2018 16:12:42 +0800
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Bauer.Chen" <bauer.chen@realtek.com>, ricky_wu@realtek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <80B44AD6-78B0-4CB2-8CBA-5814B5C1A190@canonical.com>
References: <20180731061721.15831-1-kai.heng.feng@canonical.com>
 <20180731061721.15831-5-kai.heng.feng@canonical.com>
 <CAPDyKFp0ut38EountRQ7pJPXGCQPZzzMroyBz6GAh25DJGMwkA@mail.gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 21:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> [...]
>
>> -#ifdef CONFIG_PM_SLEEP
>> -static int rtsx_usb_ms_suspend(struct device *dev)
>> +#ifdef CONFIG_PM
>> +static int rtsx_usb_ms_runtime_suspend(struct device *dev)
>>  {
>>         struct rtsx_usb_ms *host = dev_get_drvdata(dev);
>>         struct memstick_host *msh = host->msh;
>>
>> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
>> -
>> +       host->suspend = true;
>>         memstick_suspend_host(msh);
>
> I missed this one. Does this really work? To me, this looks like doing
> things upside-down.
>
> To suspend the host, you first need to runtime resume it, because
> mmc_suspend_host() calls into one of the host ops and my touch the
> device, right?
>
> If you want to suspend the host (actually the naming is wrong, as it's
> about suspending/power-iff the memstick card), that should be done via
> when the memstick core finds that the card is removed or during system
> wide suspend.

Do you mean the logic was wrong even before my modification?

Kai-Heng

>
>> +
>>         return 0;
>>  }
>>
>> -static int rtsx_usb_ms_resume(struct device *dev)
>> +static int rtsx_usb_ms_runtime_resume(struct device *dev)
>>  {
>>         struct rtsx_usb_ms *host = dev_get_drvdata(dev);
>>         struct memstick_host *msh = host->msh;
>>
>> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
>> -
>>         memstick_resume_host(msh);
>
> According to the above, this seems not correct to me.
>
>> +       host->suspend = false;
>> +       schedule_delayed_work(&host->poll_card, 100);
>> +
>>         return 0;
>>  }
>> -#endif /* CONFIG_PM_SLEEP */
>
> [...]
>
> Kind regards
> Uffe


