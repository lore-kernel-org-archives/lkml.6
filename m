Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4ADC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12DA2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ButZ46en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12DA2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeHXKDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 06:03:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35500 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeHXKDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 06:03:52 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so6319011iob.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 23:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rF5jdOGcr4ameuPEeORi2ABJDXswYkHSm3Rwep0v1Uo=;
        b=ButZ46en5fYAFd5BUXT/jYvE1SvAriqKuwIu9cQi4rv+hF+1LWkivkl/1m/SVnPXw8
         bAcUZBst2wsTYi5MlAhxC2MTHfgnkUiWff4rnDdEOph2c/MZ9jkCOPB5pFuNGf1Jm28r
         dLQydE2ei2zNPAK5t34Z2YBVub0sD10iw8jns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rF5jdOGcr4ameuPEeORi2ABJDXswYkHSm3Rwep0v1Uo=;
        b=trmLPBbPNAdyZfiZ1dfwMLBW6cck72dGcrdFVvNWtI01ZJ/OVJ0byW6j5097T25eBs
         CE1yGxo93ZZYbo9lxEqYIYZluqfhpZma+VsLRlD64nSbME++OVkTGvw/Z+Ldh9VHmdpH
         0WEwcaOhsXZaygtCsCKrKLMIlEa77z49oEmyz96ewNBPvYX223n1bICrPQzaWWH1oOnw
         eVRI05sypHF1gXWRHnJqsmYIF91wg4kZaGRFtX8PWlSpWzkPXtaN6yk+FaWWYKpeMnlF
         pIk2lKcmdeuY8lpZ1zjTfSEkDID9LtbKXOtuOHHabkvD6M5sCJBEXJW1GWAn/Czv5IyO
         9y1Q==
X-Gm-Message-State: APzg51DiXvRID1I7FRWIs/0r4m8Bmj8P/xcir1FuSBJeUccPt8UiahUc
        A6MSUsstDeZZw0PQnBzra7DPRxHL7s+1GryL8xG61Q==
X-Google-Smtp-Source: ANB0VdYmKKwGl67i06owZh4wtReewxovyKAHpPGgXpkqhquiocy8+vPSo0/zByvoZ6Xbf0GPNvEaLB+/Zd5YFoht5Eg=
X-Received: by 2002:a6b:c995:: with SMTP id z143-v6mr225500iof.266.1535092242011;
 Thu, 23 Aug 2018 23:30:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 23:30:41
 -0700 (PDT)
In-Reply-To: <80B44AD6-78B0-4CB2-8CBA-5814B5C1A190@canonical.com>
References: <20180731061721.15831-1-kai.heng.feng@canonical.com>
 <20180731061721.15831-5-kai.heng.feng@canonical.com> <CAPDyKFp0ut38EountRQ7pJPXGCQPZzzMroyBz6GAh25DJGMwkA@mail.gmail.com>
 <80B44AD6-78B0-4CB2-8CBA-5814B5C1A190@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Aug 2018 08:30:41 +0200
Message-ID: <CAPDyKFoYU8MvWmBnLZ5j=vSBu6bFmOh7HHOJhZmo04p=feQA-g@mail.gmail.com>
Subject: Re: [PATCH 4/5] memstick: rtsx_usb_ms: Support runtime power management
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Bauer.Chen" <bauer.chen@realtek.com>, ricky_wu@realtek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 August 2018 at 10:12, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> at 21:29, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>> [...]
>>
>>> -#ifdef CONFIG_PM_SLEEP
>>> -static int rtsx_usb_ms_suspend(struct device *dev)
>>> +#ifdef CONFIG_PM
>>> +static int rtsx_usb_ms_runtime_suspend(struct device *dev)
>>>  {
>>>         struct rtsx_usb_ms *host = dev_get_drvdata(dev);
>>>         struct memstick_host *msh = host->msh;
>>>
>>> -       dev_dbg(ms_dev(host), "--> %s\n", __func__);
>>> -
>>> +       host->suspend = true;
>>>         memstick_suspend_host(msh);
>>
>>
>> I missed this one. Does this really work? To me, this looks like doing
>> things upside-down.
>>
>> To suspend the host, you first need to runtime resume it, because
>> mmc_suspend_host() calls into one of the host ops and my touch the
>> device, right?
>>
>> If you want to suspend the host (actually the naming is wrong, as it's
>> about suspending/power-iff the memstick card), that should be done via
>> when the memstick core finds that the card is removed or during system
>> wide suspend.
>
>
> Do you mean the logic was wrong even before my modification?

No. I think you should keep the existing callbacks for system sleep,
they seems to do what they should.

Then add new ones for runtime PM.

[...]

Kind regards
Uffe
