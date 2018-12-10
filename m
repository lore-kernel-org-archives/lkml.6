Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69111C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABB520672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544430949;
	bh=+rMzFdcvIBCzMASAbg0FPfMrEfDppcHTezAKXsQFE+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IiYcm+4h2zOrCsj6xoWwkRJg1I6ajEqEHb1Er5ME3Z+8m4tGkmxf/qCoT17+QUrMN
	 BaEpswNqOwyGpFuVylRVgk0Tk3MudS4b6ryu33TIc33XCQwjAVoBcOVFw1M6Zg8TYh
	 MdCWbqE0AhMXneyyyB52fqTU8Dw9UUjvXdJcTWpE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ABB520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeLJIfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:35:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeLJIfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:35:47 -0500
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8690A20867;
        Mon, 10 Dec 2018 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544430945;
        bh=+rMzFdcvIBCzMASAbg0FPfMrEfDppcHTezAKXsQFE+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cnHPejubSSMmb4Td364KgFZJJ60UCYMKIeb5D1jDHr7mOCwsL0NHO9wjrxJLW8ADE
         Vg2hntwaf2/7DKyiMmDWOZyh8Y8n2o9dvUd8X4AXT/Z/8WJRaIn4CWYPpOO2EXX8b0
         CrjLVAQXooSI1XrRqmLBlE1xcjLWhF1AFmXKYcxQ=
Received: by mail-lj1-f171.google.com with SMTP id v1-v6so8839267ljd.0;
        Mon, 10 Dec 2018 00:35:45 -0800 (PST)
X-Gm-Message-State: AA+aEWZhT8jeI2I5J1iB66Ii/xjCJp9D6gifkth5iI8VwGY+laTFnVTn
        szA4oj8f43JTFQ6lo74as9yGjq6KciOdGk8xnrE=
X-Google-Smtp-Source: AFSGD/WzMAfjsu15NiZwrRzaAhcgtZsegSzIrhR44iL3LbDqBRqfraTW0NXWhYyrSVW7QTt7k8wp+Drg2ZTf1Wu7iJQ=
X-Received: by 2002:a2e:85d3:: with SMTP id h19-v6mr6286842ljj.82.1544430943680;
 Mon, 10 Dec 2018 00:35:43 -0800 (PST)
MIME-Version: 1.0
References: <1544185974-5932-1-git-send-email-krzk@kernel.org>
 <1544185974-5932-4-git-send-email-krzk@kernel.org> <8222f85b-4e61-69c4-6d31-ba559de02829@gmail.com>
 <fcb28be6-7d6a-1216-5a22-339f30366fd1@gmail.com>
In-Reply-To: <fcb28be6-7d6a-1216-5a22-339f30366fd1@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 10 Dec 2018 09:35:32 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdWkkLhR7YPT1tajVR=8B+5SK+yc6oqqgzgLiYvbLp7+w@mail.gmail.com>
Message-ID: <CAJKOXPdWkkLhR7YPT1tajVR=8B+5SK+yc6oqqgzgLiYvbLp7+w@mail.gmail.com>
Subject: Re: [PATCH 4/4] leds: trigger: Add pattern initialization from Device Tree
To:     jacek.anaszewski@gmail.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        baolin.wang@linaro.org, rteysseyre@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Dec 2018 at 19:55, Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> On 12/8/18 7:44 PM, Jacek Anaszewski wrote:
> > Hi Krzysztof,
> >
> > Thank you for the patch set.
> >
> > Applied 1/4 and 2/4.
> >
> > I'll hold on merging 3/4 until we sort out the issues
> > I have with this one. Please refer to my comment below.
> >
> > On 12/7/18 1:32 PM, Krzysztof Kozlowski wrote:
> >> Allow initialization of pattern used in pattern trigger from Device Tree
> >> property.
> >>
> >> This is especially useful for embedded systems where the pattern trigger
> >> would be used to indicate the process of boot status in a nice,
> >> user-friendly blinking way.  This initialization pattern will be used
> >> till user-space is brought up and sets its own pattern, indicating the
> >> boot status is for example finished.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >> ---
> >>   drivers/leds/trigger/ledtrig-pattern.c | 18 ++++++++++++++++++
> >>   1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/leds/trigger/ledtrig-pattern.c
> >> b/drivers/leds/trigger/ledtrig-pattern.c
> >> index 1870cf87afe1..96309d3bc43c 100644
> >> --- a/drivers/leds/trigger/ledtrig-pattern.c
> >> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> >> @@ -11,6 +11,7 @@
> >>   #include <linux/leds.h>
> >>   #include <linux/module.h>
> >>   #include <linux/mutex.h>
> >> +#include <linux/of.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/timer.h>
> >> @@ -331,6 +332,21 @@ static const struct attribute_group
> >> *pattern_trig_groups[] = {
> >>       NULL,
> >>   };
> >> +static void pattern_init(struct led_classdev *led_cdev)
> >> +{
> >> +    struct device_node *np = dev_of_node(led_cdev->dev);
> >> +    const char *pattern;
> >> +
> >> +    if (!np)
> >> +        return;
> >> +
> >> +    if (!of_property_read_string(np, "linux,trigger-pattern",
> >> &pattern)) {
> >> +        if (strlen(pattern))
> >> +            pattern_trig_store_patterns(led_cdev, pattern,
> >> +                            strlen(pattern), false);
> >> +    }
> >> +}
> >> +
> >>   static int pattern_trig_activate(struct led_classdev *led_cdev)
> >>   {
> >>       struct pattern_trig_data *data;
> >> @@ -354,6 +370,8 @@ static int pattern_trig_activate(struct
> >> led_classdev *led_cdev)
> >>       timer_setup(&data->timer, pattern_trig_timer_function, 0);
> >>       led_cdev->activated = true;
> >> +    pattern_init(led_cdev);
>
> With my recent patches it would suffice to replace above line with:
>
> if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
>         pattern_init(led_cdev);
>         led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
> }

Right, I see the problem. I'll rebase on top of it.

Best regards,
Krzysztof
