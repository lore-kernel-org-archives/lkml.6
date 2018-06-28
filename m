Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32E9C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CDD270C8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDybwgPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CDD270C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935040AbeF1Ib6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:31:58 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41684 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934404AbeF1Ibs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:31:48 -0400
Received: by mail-ua0-f196.google.com with SMTP id z12-v6so2904321uac.8;
        Thu, 28 Jun 2018 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8uRrZxOdezoP99XUGz3lVco1yY3w8VlQ0vPhJ0jvoAg=;
        b=JDybwgPzxhTH1SBGcphB94dgmWpzyVn7RUSpHIbHxHiS7+AtrinEfzJW5+7O1VooLX
         6/nEd0mX7Iaeg0sBRcRj7YSu1sJSOxEuWj+iWNcFAf8BFC4xnj557Ctmo9gCFmyo4wfb
         fJDBLt4Oig1WJBPp5dXyZt4WW7reJ/wNyZZ2lPi/EsYvzLZ2baUCfAN2cKj3O6ozFyln
         MIde8V74SJpZgzi6wfCGqfLpgQcTL6vQqrvCu99OEVkhaiazBXPObxKbQy8YO4pCDr4L
         fEBMHYQP8FUTpURYOBcOAfIRd2D1nYDNtVphM5qgeGQfnpbKm5coKof1o2WAw50/gGjA
         xqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8uRrZxOdezoP99XUGz3lVco1yY3w8VlQ0vPhJ0jvoAg=;
        b=S+6yjTKI+EykyYUxBQnAMvxxv4QpFxyKflGq/y2YFzfOZ2bh8Coold+V33DaZ4UunY
         +JxBmRw630046WUVSjvGHz87YTXQQM2KoSMtnKqWGKDKH9yn0XUsGL7HCyLn8zD/1cBS
         UieJlMowhSpxWSkOsA2w6Uio42x9rjIb0Z8y4JZ4ve1M1H78j7At/mPHiCK1TQkeOWkB
         Cpe/5Q/PlOxsFb8PxZhfwEMgGsOOCBG7vo8Nn6pSTdXyTUQ+bKE5xigkLtRp5emRDOT/
         gxpDeiOI1AAptcFaVwvPmEbIxOo9iPOpea/z4J6Tg845uU0Z0uhimRUZrKhTEvhV72mE
         5clw==
X-Gm-Message-State: APt69E1T7+hpjaOzVvkzfG+/zYyjz72rauK/z94A6T/gjQwFUnqUj+R0
        OJ4+AXkw/MNA4tbl6UVhmCsR6KaH19h380LB5DxexwwJ
X-Google-Smtp-Source: AAOMgpfG6VSgCzTaikXuCNFKVa9OfXvSHn21tUSfbOB3zWSFw5WIUS9QggHNrwLX0x39W3y6dycHFkvabAhEXceMmws=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr5832788uai.47.1530174707468;
 Thu, 28 Jun 2018 01:31:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 01:31:46
 -0700 (PDT)
In-Reply-To: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
References: <03bc9a51ccae38cdc86934746aee9f75ec667cfd.1530162340.git.baolin.wang@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jun 2018 11:31:46 +0300
Message-ID: <CAHp75Vfmr=VRtQaUWk4i8A2sws2sDS=QL3wTMfHTszrniAv-YA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] leds: core: Introduce generic pattern interface
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 8:16 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Some LED controllers have support for autonomously controlling
> brightness over time, according to some preprogrammed pattern or
> function.
>
> This adds a new optional operator that LED class drivers can implement
> if they support such functionality as well as a new device attribute to
> configure the pattern for a given LED.

> +What: /sys/class/leds/<led>/pattern
> +Date: June 2018
> +KernelVersion: 4.18

4.19 ?

> +static ssize_t pattern_show(struct device *dev,
> +                           struct device_attribute *attr, char *buf)
> +{
> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +       struct led_pattern *pattern;
> +       size_t offset = 0;
> +       int count, n, i;

> +       if (!led_cdev->pattern_get)
> +               return -EOPNOTSUPP;
> +

Perhaps just hide an attribute completely?

> +       pattern = led_cdev->pattern_get(led_cdev, &count);
> +       if (IS_ERR_OR_NULL(pattern))
> +               return PTR_ERR(pattern);

Hmm.. Here you shadow NULL case by returning 0.
Even if it's correct behaviour IS_ERR_OR_NULL is a beast to hide such
subtle detail.

It also would be good idea to check for count == 0 and bail out
immediately. Otherwise you will print an extra blank line.

> +       for (i = 0; i < count; i++) {
> +               n = snprintf(buf + offset, PAGE_SIZE - offset, "%d %d",
> +                            pattern[i].brightness, pattern[i].delta_t);
> +

> +               if (offset + n >= PAGE_SIZE)
> +                       goto err_nospc;

> +
> +               offset += n;
> +

> +               if (i < count - 1)
> +                       buf[offset++] = ' ';

You might add this to the end of above format string and remove this
conditional completely...

> +       }
> +

> +       buf[offset++] = '\n';

...and use here something like

buf[offset - 1] = '\n';

(we have such patterns in the kernel)

> +
> +       kfree(pattern);
> +       return offset;
> +
> +err_nospc:
> +       kfree(pattern);
> +       return -ENOSPC;
> +}
> +
> +static ssize_t pattern_store(struct device *dev,
> +                            struct device_attribute *attr,
> +                            const char *buf, size_t size)
> +{
> +       struct led_classdev *led_cdev = dev_get_drvdata(dev);
> +       struct led_pattern *pattern = NULL;
> +       unsigned long val;
> +       char *sbegin;
> +       char *elem;
> +       char *s;
> +       int ret, len = 0;
> +       bool odd = true;
> +
> +       s = sbegin = kstrndup(buf, size, GFP_KERNEL);
> +       if (!s)
> +               return -ENOMEM;
> +

> +       /* Trim trailing newline */
> +       s[strcspn(s, "\n")] = '\0';

It's usually done via strstrip().

sbegin = kstrndup();
...

s = strstrip(sbegin);

> +
> +       /* If the remaining string is empty, clear the pattern */
> +       if (!s[0]) {

if (!*s) ?

> +               ret = led_cdev->pattern_clear(led_cdev);
> +               goto out;
> +       }
> +
> +       pattern = kcalloc(size, sizeof(*pattern), GFP_KERNEL);
> +       if (!pattern) {
> +               ret = -ENOMEM;
> +               goto out;
> +       }
> +
> +       /* Parse out the brightness & delta_t touples */
> +       while ((elem = strsep(&s, " ")) != NULL) {
> +               ret = kstrtoul(elem, 10, &val);
> +               if (ret)
> +                       goto out;
> +

> +               if (odd) {

This is effectivelly if (len % 2 == 0)

> +                       pattern[len].brightness = val;
> +               } else {
> +                       pattern[len].delta_t = val;
> +                       len++;
> +               }
> +
> +               odd = !odd;
> +       }
> +
> +       /*
> +        * Fail if we didn't find any data points or last data point was partial
> +        */
> +       if (!len || !odd) {
> +               ret = -EINVAL;
> +               goto out;
> +       }

For partial data can we return different error code?
Does it make sense?

> +
> +       ret = led_cdev->pattern_set(led_cdev, pattern, len);
> +
> +out:
> +       kfree(pattern);
> +       kfree(sbegin);
> +       return ret < 0 ? ret : size;
> +}
> +static DEVICE_ATTR_RW(pattern);


-- 
With Best Regards,
Andy Shevchenko
