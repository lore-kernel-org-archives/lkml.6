Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A73ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC11206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db4rv7RP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC11206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbeGTQXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:23:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38020 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeGTQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:22:59 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so15105973itb.3;
        Fri, 20 Jul 2018 08:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vKw2RMcMJCZ/HApBmNvTERgZS1GtJo8gav43OA0nHE=;
        b=db4rv7RPQqYfvq+DrER+aqN0l92jY4NwsH7PL0Udym1WjOg44CYtvhhjLWBIS8yYt6
         rSS96s2rXt2rwUl3sqLkRuYgthouNyn8ylJqk6SGQwicHWc4wZpFREGUBeczSNEzY7BW
         7EqOv8gMX5S1EoVCemXJEOmh/b0bpx0T3WP8iouKa8jftiJuhY+ihG33b+a5Eo0pIs3u
         ZIYEOkkA6sZE44t6i1DPd44w++4LidFLXV5BfnddJT7uslfMQRq9EUilG6Pkzl1pasiy
         Xl42wjdSpj90TkhEipnGKDDOsVX1tY5Dsc6QuYFJHHOnDvwjt3NJDAYu6/pj/xm0toW0
         3Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vKw2RMcMJCZ/HApBmNvTERgZS1GtJo8gav43OA0nHE=;
        b=f6GSsc6y/A1N9/gOYJHH7m8SG6TQU+nUuvADpoI5Hm9vJvVMWtIAf57X1N9tTN0G4h
         qeex1jhuZwKgK7XOhu+H0pzt/oRDKeQZ9u3CkVpt+HHIdGBQqFRv9HrtpuaRrs3FXBv3
         fCMjfqd7yAQGpBmJb91CZ9vZELLRJ2kOcrActWLcEZIl2VBVEHC60NidJpoWKOCTLqcP
         Ebaj7Bt/TBY8IqiXGCD+ZJlq2Qf8T/874y3YOO9NZK+H1JVfYJVHy0QKSnplwYgL9CwC
         Q+5RHX05LOdbn+JHY+4po6LjyeizfluNZioUMyr4AnKIRzMzfwILmv8Oo+BX8JdjMolZ
         jgfA==
X-Gm-Message-State: AOUpUlHzjo1sYTHHalZsVd2ukXS1kPj8oJCnN6b30mXzK54AntS7OMiq
        HNah+rzoNN1WxUUglq+Qvr/Y6+u2yaijXrNRi8lIkezg
X-Google-Smtp-Source: AAOMgpenJoeurO/oW4OxUQuSZGGlJFc8lHVksaH9QhV4fsGBIIu2VGtqJLGKHztNQ14i5zNfdXKWsleYsSeKUEcmoOg=
X-Received: by 2002:a02:1857:: with SMTP id k84-v6mr2313563jad.3.1532100850146;
 Fri, 20 Jul 2018 08:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1532090446.git.leonard.crestez@nxp.com> <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
In-Reply-To: <221deb47d7d38ecd6e0c7636f9a87ab693a3c539.1532090446.git.leonard.crestez@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 20 Jul 2018 08:33:58 -0700
Message-ID: <CAHQ1cqF6TphuN8Ls54YA6bjty-bJF8twYboaG-RM=jox8CeQPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Joao.Pinto@synopsys.com,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 5:48 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> This reverts commit 1c86c9dd82f859b474474a7fee0d5195da2c9c1d.
>
> That commit followed the reference manual but unfortunately the imx7d
> manual is incorrect.
>

I'd also add similar comment to DT file to prevent people from trying
to "fix" this in the future.

Also, this change is going to break QEMU's mapping found here:

https://git.qemu.org/?p=qemu.git;a=blob;f=hw/arm/fsl-imx7.c;h=d5e26855a552e2d52b91f0435a607fae2f88456b;hb=HEAD#l464

any change you are planning to make the change there as well?

Thanks,
Andrey Smirnov
