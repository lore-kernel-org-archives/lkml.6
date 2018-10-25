Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D04ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1471020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/78LeQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1471020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJYW2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:28:12 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34749 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbeJYW2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:28:12 -0400
Received: by mail-yb1-f193.google.com with SMTP id n140-v6so3711016yba.1;
        Thu, 25 Oct 2018 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/WP0EA0p/dABkVn3+2La+sj0vq4sGY4huqmhJn+QuQ=;
        b=f/78LeQIm+VjKpTkwVYw0DnCtYJ6o3oOBl5++AwjKpm5rXnZJcM/7VmuPUFJCZPoE7
         sl2OqskmiKMeIWC82tgLbHEiKZBq7Fa+3nVfpeNQgtc/yMnRzkn2rtLA48H9j/HcL+tp
         g90uPadXIOTmdc45BQtWaKbv8q9xU9+GHVILFymEbpYrzPJWdfin8lqaDIs49GawIO2X
         Go+dCLnU8ErUrqPywbWVDgxxR04T3fg0FqUUKXlPAtWuebcH5RmM5h+hErai1w0UMEpS
         ydBdxE6cDu8a8Ho1mQtR+W5nwUdBo44MhYlwvjCnwVr6gH/UwtF7E5400Nb//ULx27Nn
         mmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M/WP0EA0p/dABkVn3+2La+sj0vq4sGY4huqmhJn+QuQ=;
        b=hOvqpVsG7PZxGTcy0HXG7vBCxu3jdQTMfANkk5WNxK9pnV51FcvMMWL2tENXCW+w8z
         t7CkJIewdcJaoty/trlyzySN7nhu6FgGYPET27Z/MQdXXA3TZ56Ql664BwEWcgMtaQDZ
         RIMjxvue1gc9IKYJO7+rDIyVu436KErOmZV4jJmMrh04S/QUCWJrLgK3XJHoTjfh7V0d
         SIaDj0uycdqx7V8QYndgafzV1kYgtrSnLm1l/JyzxLfDyFAkst00s+HcXVkbgGHVYodU
         pznX8gho4OXws8sgtAxsvWIN0Rr/ZnFWhVTPkH9muMwIEzafW/M0enPpdPJBJ1zgPlpv
         oodg==
X-Gm-Message-State: AGRZ1gJJRq4M6Y8+V0gBgh0d1mVB0L7hDGXqaDhQJg5eYS1ApNh/AjAV
        PgtNCsohjgnXA9gLkaygCmI=
X-Google-Smtp-Source: AJdET5djgaRzkoR9GeKSlSCrX/oyYl03c1R4rCp9m3+Zp/W9tb/a5mTZWiGag4fFjzUde6nkCGpmYQ==
X-Received: by 2002:a25:37cf:: with SMTP id e198-v6mr1455690yba.243.1540475720021;
        Thu, 25 Oct 2018 06:55:20 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id v5-v6sm1960047ywc.96.2018.10.25.06.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 06:55:19 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document devicetree binding.
Date:   Thu, 25 Oct 2018 09:55:15 -0400
Message-Id: <20181025135515.8397-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, thank you for the patch review !!

>> +  - pwms : the pwm connected to the bridge's 'pwm input'.
>
> That is really unintuitive and needs a detailed explanation. What
> is a bridge doing with a PWM? Is it 100% certain this is a PWM,
> it's not just a .... clock? A pwm is a pule WIDTH modulator and
> I can't for my life understand why a bus bridge needs a signal
> with variable pulse width, but surprise me! :D

You are 100% correct, this is a clock !
The hardware designers attached the bridge's clock input to an iMX pwm output,
and instructed us to provide a clock with 50% duty cycle and a certain freq.

The only way I know to activate a pwm is to connect it to a driver in the fdt,
then inside the driver enable the pwm, like so:

+       /* PWM */
+       pwm = devm_pwm_get(dev, NULL);
+       if (IS_ERR(pwm)) {
+               dev_err(dev, "pwm not found\n");
+               return -EINVAL;
+       }
+       pwm_get_args(pwm, &pargs);
+       period = pargs.period;
+       err = pwm_config(pwm, period/2, period);
+       if (err)
+               return err;
+       err = pwm_enable(pwm);
+       if (err)
+               return err;

This is why the bridge driver has a dependency on a pwm.
If the pwm could be enabled individually, I could drop this dependency.
Can you think of a way?

>> +               fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
>> +                               0x00000000 0xa0000240 0x00000000>;
>
> Is it just a copy/paste from
> Documentation/devicetree/bindings/bus/imx-weim.txt
> leftover?

No. We attach the bridge to the i.MX WEIM bus. Every fdt WEIM child node
requires a fsl,weim-cs-timing property, which provides the bus timing for
that particular chip select. It's the weim driver that requires this,
I'm only following its instructions.

Should I just leave this out in the example? In theory, the bridge can be
connected to any parallel bus, so fsl,weim-cs-timing is Too Much Information
for the example?

