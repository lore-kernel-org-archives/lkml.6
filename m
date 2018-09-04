Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAF220843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhEtouMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAF220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeIDG1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:27:55 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37327 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIDG1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:27:55 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so3856053oic.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 19:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XjMqxpPQJ9fij5BCaLNtVMS3QETmSLpdGxOWWCxbZqs=;
        b=MhEtouMOLdc64myIhp1vDfz6u8vAcQN39lOiiGdARtQBCsi+8ADxJ5K4MhBw+pnU4/
         eYI6QkO1kIQ9sXg0BzuSQ8nek/YdscYPdABKfLQWIszL/1m5idsiRgUYMljDZU5SkTg5
         FfdQMAhmUvBJFNxvjkDKj1CHZF5sVICpxfTGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XjMqxpPQJ9fij5BCaLNtVMS3QETmSLpdGxOWWCxbZqs=;
        b=Q17tZCqEJ59HRWCgPNZNTBoJg+7TFkTt0dvrm5e1M9iFts/Qtv3ltNGMwKDqO0u8C8
         ZF//vOzBbz3OWseguGWtYMtxcLd8/L2CteJDOYf5RYaYC32MWZhJGcKkFZMtvhded1zn
         QvG6fsaRWAELsXtjSibLgYtG8RHtnGEBN7o9gar5Y/36F7ReaEYdouCCnc4ytrkgGGaF
         EgUel8lkt08wYJQkZDSJdBeaIuc48neyVq09lDXK8fVeH1fh82deSNJkj+rwSp6wm8KD
         Xbp3WIgwb9BsZjc4f3FaFigx1B5l/8iYdILpvZz2R/eqa+BO2+Fz6dcMHmGYMJe76cGZ
         AMwQ==
X-Gm-Message-State: APzg51B8/AltdPMQAhRJIE5HoAsxgCmyyh4a/wbBJRUBOWYOw4pt87GN
        FeGM1KZ+qFXb7sSn9CafEXUK/UvIKdKS/csnwFzLAw==
X-Google-Smtp-Source: ANB0VdZGZ3Cg5RCpK0gnhPWdfSLCcQJUAUw0Lo9LgBePhVYQiK3xsTm/Z7bo2dst7A/ObK5EYcGViOK8UkySW5BL064=
X-Received: by 2002:aca:50cf:: with SMTP id e198-v6mr23284573oib.332.1536026707116;
 Mon, 03 Sep 2018 19:05:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1d28:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 19:05:06 -0700 (PDT)
In-Reply-To: <20180903215323.GA21489@amd>
References: <e6d4e7be537a4e4d6fce26c6d446703b1910eab9.1535700092.git.baolin.wang@linaro.org>
 <ef266d4a-ba0e-cba6-ae30-ebbf730e28a2@gmail.com> <20180903215323.GA21489@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Sep 2018 10:05:06 +0800
Message-ID: <CAMz4kuJwnD1B-5X-pPDbf1vCj7-VQNdX9F+EPCj9VWg2G-vPLQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] leds: core: Introduce LED pattern trigger
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rteysseyre@gmail.com, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 4 September 2018 at 05:53, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > +static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
>> > +{
>> > +   struct pattern_trig_data *data = led_cdev->trigger_data;
>> > +
>> > +   if (!data->npatterns)
>> > +           return 0;
>> > +
>> > +   if (data->is_hw_pattern) {
>> > +           return led_cdev->pattern_set(led_cdev, data->patterns,
>> > +                                        data->npatterns, data->repeat);
>> > +   }
>>
>> I have doubts here if it is a good idea to enforce array of tuples
>> as a generic interface for all hw_patterns. It may not fit well for
>> every hw pattern engine. It seems that the only feasible solution will
>> be allowing drivers to come up with their own interfaces, i.e. the
>> approach you proposed at first for your driver. It seems that the
>> ledtrig-pattern with software pattern mechanism will be just
>> a nice side effect of this series :-)
>>
>> Unless someone will propose a better solution.
>
> I believe array of tuples will work for everyone. It is just a LED, it
> can change intensity over time.
>
>> We need a broader consensus here. I'd like to hear Pavel's opinion,
>> since he's been always in favor of common pattern interface, and
>> inspired this work.
>
> I believe Baolin did good work here. I believe it will cover most, if
> not all, hardware engines out there. I think we should merge it, and
> see what happens -- it should be good enough.
>
> (Yes, there's still more work to do, but that will be stuff like RGB
> LED synchronization.)
>
> (And yes, one of the LED chip has pattern engine that can compute
> prime numbers on its own. I don't expect to support
> _that_. Fortunately, nobody but me is likely to want that pattern, so
> we are still okay :-)

Thanks for your explanation here. So I think I should keep the same
logics in next version.

-- 
Baolin Wang
Best Regards
