Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992A9C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6724A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aj2IzNyV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfA1MhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:37:13 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39134 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfA1MhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:37:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so14053823ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 04:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dy1XvrSx6dEgjmvPuzo6v6xDy3nS51OW/InA6mRxIvk=;
        b=Aj2IzNyVtMWpHPg/SGwyjeqEGxhf9TJkU0bIEKp6TJMcHUSojPEGSPTWa5Qeukb/Sh
         26egQbxOJFwG8tLLEdWa8sGlhEpE6IQzRp+YhlI8QlcNJ7Ie74QPbC7kEmdhB1ZjwYaF
         kc04gALyaDgbUKXJFrXIsJ5Axdr3CIjAkiVhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dy1XvrSx6dEgjmvPuzo6v6xDy3nS51OW/InA6mRxIvk=;
        b=MF2ERll+870fanCjjy9U6x9zqXea1EKt5WpCNgJPdqcVWhKIQEsoJxhHKUtkVx4Guw
         Vn9YVnh+nfxskOIDqidAaEB6Asl/B5qNcG/g0hgi7ZZuaPvRKv7ZrzQtkK7w9jZbqFCv
         8J2UO/o4o66jLoxiLbXeVvO/UAq/lgBCdcfBFdpl5fBrj7xyJewS7wqG4sI0A8OfyUQv
         xbFz3OCFluseFp2f5BxL6f4JGKwDpEYKyUtqxxbJpNF0/LqzC6KnfSYd63ETMGaw6w5N
         89LKJ7VeSz3ZmsLSbXhLxG4wDGGgLXo2JUr2R7c4gIcB2zciy0YXAhJYV9QihUXz/YOM
         2v2g==
X-Gm-Message-State: AJcUukdjgo4YXkgCyEyUAVoQbwNnMn1z7H+gMDFYsQQ/eYTtxNA6Lo/p
        GQ0b7oFC7ho489cXG+fxh9jaj5Yh2wM5KK5e/4qN3A==
X-Google-Smtp-Source: ALg8bN58Y/UVDbaHBYZAvtKV8CWyDrJcKGLO5WlcS2yyDWsT/7AVan1kYf/gaS5qm2/FBOq2r0CPIf1EQJelCQZishs=
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr18326422lje.105.1548679030770;
 Mon, 28 Jan 2019 04:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20190120151357.11106-1-vz@mleia.com>
In-Reply-To: <20190120151357.11106-1-vz@mleia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 13:36:59 +0100
Message-ID: <CACRpkdYn+LgeRaL4=UPLGYxdCpnoj8r3Yp=A6yHADr=fhB_UFg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: remove unused 'pinconf-config' debugfs interface
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Meunier <laurent.meunier@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 4:14 PM Vladimir Zapolskiy <vz@mleia.com> wrote:

> The main goal of the change is to remove .pin_config_dbg_parse_modify
> callback before a driver with its support appears. So far the in-kernel
> interface did not attract any users since its introduction 5 years ago.
>
> Originally .pin_config_dbg_parse_modify callback and the associated
> 'pinconf-config' debugfs file were introduced in commit f07512e615dd
> ("pinctrl/pinconfig: add debug interface"), a short description of
> 'pinconf-config' usage for debugging can be expressed this way:
>
> Write to 'pinconf-config' (see pinconf_dbg_config_write() function):
>
> % echo -n modify $map_type $device_name $state_name $pin_name $config > \
>         /sys/kernel/debug/pinctrl/$pinctrl/pinconf-config
>
> It supposes to update a global (therefore single!) 'pinconf_dbg_conf'
> variable with an alternative setting, the arguments should match
> an existing pinconf device and some registered pinctrl mapping 'map':
>
> * $map_type is either 'config_pin' or 'config_group', it should match
>   'map->type' value of PIN_MAP_TYPE_CONFIGS_PIN or
>    PIN_MAP_TYPE_CONFIGS_GROUP accordingly,
> * $device_name should match 'map->dev_name' string value,
> * $state_name should match 'map->name' string value,
> * $pin_name should match 'map->data.configs.group_or_pin' string value,
>
> If all above has matched, then $config is a new value to be set by calling
> pinconfops->pin_config_dbg_parse_modify(pctldev, config, matched_config).
>
> After a successful write into 'pinconf-config' a user can read the file
> to get information about that single modified pin configuration.
>
> The fact is .pin_config_dbg_parse_modify callback has never been defined
> in 'struct pinconf_ops' of any pinconf driver, thus an actual modification
> of a pin or group state on any present pinconf controller does not happen,
> and it declares that all related code is no more than dead code.
>
> I discovered the issue while attempting to add .pin_config_dbg_parse_modify
> support in some drivers and found that too short 'MAX_NAME_LEN' set by
>
>   drivers/pinctrl/pinconf.c:372:#define MAX_NAME_LEN 15
>
> is practically insufficient to store a regular pinctrl device name,
> which are like 'e6060000.pin-controller-sh-pfc' or pin names like
> 'MX6QDL_PAD_ENET_REF_CLK', thus it is another indicator that the code
> is barely usable, insufficiently tested and unprepossessing.
>
> Of course it might be possible to increase MAX_NAME_LEN, and then add
> .pin_config_dbg_parse_modify callbacks to the drivers, but the whole
> idea of such a limited debug option looks inviable. A more flexible
> way to functionally substitute the original approach is to implicitly
> or explicitly use pinctrl_select_state() function whenever needed.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Laurent Meunier <laurent.meunier@st.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Russell King <linux@arm.linux.org.uk>

This is fine, the build robot is complaining of some missing
prototype though, probably some implicit include that
disappeared when you removed <linux/pinctrl/machine.h>
from the <linux/pinctrl/pinconf.h> file.

Will you send a v2 with this fixed? (I think just leaving the
include in place would be a quickfix.)

Yours,
Linus Walleij
