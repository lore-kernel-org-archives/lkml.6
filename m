Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0996C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE8B2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 20:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCL4KnK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfA0UUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:20:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42641 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfA0UUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 15:20:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so6313634pga.9;
        Sun, 27 Jan 2019 12:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gSrCNxCdRFZR7oBGmVmDB1cCLwcbrNG6D6gTuZhVow=;
        b=PCL4KnK5vaQoOvxRM4jvfw5I1OGMY9YopoFxL8AePa5XvvepFLg7jMEC18DOg/cRwx
         iMch2B4+FcmCUTj6pQTZ8sem1BKTmc+4jeOGn3ovtiPLE7zpC3ktA3sY31+qNgkiXnKx
         tEvjhpDwriPcJGotZS0xY4GW+ZZLKnXg/trnZ/3AJsqUK9VSr2FXIgOfJ+rrSljEvsqh
         nfFdgqnECRbcXF0vCOjqGqhVMqENpVfoscQiiEzZ9zvbrRBUygfzF5kYcKY9rnptnEKA
         QQfYkTmuJdjoheInZ9yrGGObEuKe1MVkTU/QIig1f4ULFvgEtRr1idGDqtEKgOhsugo+
         2Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gSrCNxCdRFZR7oBGmVmDB1cCLwcbrNG6D6gTuZhVow=;
        b=osNlt4DeIQG8tfkOx1JIQnB37RnCu6cy+OSTFNmFK1AOAj/vNUx6YUSBkbnVhx2e/F
         xp3XNFL66PT4ri8N4xsWj3Ort50oSmsIeTHDP/+Dp+Ct15iUQblfLLaK8Pia2Q+4Avfj
         XywFbW6u2McDAhK8lD63biKITJTk4f3xbMSqsrQ+ruYkloksSBZyWgtYAGrbxKRoNWps
         4aEoWIKB6sEeQ9gAs+Gox5uLCOJbqIGjOK70Vjl3+vSiCPDtEO1nD8nDM0wFM4LaL9nl
         0QMUysDeDPsCu2dMECDl0oBc6MTI2EIAgc4RkUcoVNZvGPBkjsTxTn+9UrhW6xWh15QA
         gOSw==
X-Gm-Message-State: AJcUuked0Er0nH202mk7FA+2OvaBcVXSEvTur+xcqwfy8y0u9D1Rzuon
        HxZaauBS7TB+TpNElj03mJwZDHbvCrNES2l+ajaKWGJy
X-Google-Smtp-Source: ALg8bN5ux1NQRwqXiz6Eg7ZAmFc4SXfVKv5xU8kNrTRzJ8f3LfPhWTI8EVE+Ubmrp/0H5md2x19a/IhImGxTSrCL5Zw=
X-Received: by 2002:a63:f615:: with SMTP id m21mr17740573pgh.428.1548620414119;
 Sun, 27 Jan 2019 12:20:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548610407.git.2pi@mok.nu> <b40da7d75a8cf02f78db7896e07859e315477120.1548610407.git.2pi@mok.nu>
In-Reply-To: <b40da7d75a8cf02f78db7896e07859e315477120.1548610407.git.2pi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Jan 2019 22:20:02 +0200
Message-ID: <CAHp75Vdsr8aY1ODpZUqR--jAfgRowJz8tbSGwS1SFTH-W4u0XA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: wmi: move struct wmi_device_id to mod_devicetable.h
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 9:04 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> In preparation for adding WMI support to MODULE_DEVICE_TABLE() move the
> definition of struct wmi_device_id to mod_devicetable.h and inline
> guid_string in the struct.
>
> Changing guid_string to an inline char array changes the loop conditions
> when looping over an array of struct wmi_device_id. Therefore update
> wmi_dev_match()'s loop to check for an empty guid_string instead of a
> NULL pointer.

Below some minor comments.

> -       while (id->guid_string) {
> +       while (id->guid_string[0] != '\0') {

Hmm.. I would rather put it as

while (*id->guid_string) {

> +#define WMI_MODULE_PREFIX      "wmi:"

> +#define WMI_GUID_STRING_LEN    36

Isn't this already defined in UUID namespace?
(include/linux/uuid.h IIRC)

>  #include <linux/device.h>
>  #include <linux/acpi.h>

> +#include <linux/mod_devicetable.h>

Not sure it's needed since acpi.h includes that.

-- 
With Best Regards,
Andy Shevchenko
