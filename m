Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3362DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3E42086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INbsJJZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3E42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeJPW0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:26:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42111 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPW0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:26:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id g20-v6so14221439qke.9;
        Tue, 16 Oct 2018 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=86Ds328eziIMIPevc2kks39VYSat+UYQJcwfQ52w1+I=;
        b=INbsJJZ1NicP8vDVaaeabWOhZZ19YBmH0Y5tv9KYkjW62fdH1OceJIVaCUHtjHWOwV
         Fpumj9Udxw72zz2uCPlrSFDUbZ2/FE6AjYivuCTin0s8/5VzkHPJ7LDLmXu8b1+YhvXX
         xvAiReSKFg8OJc7RDd0SHV7Nagg+AFz7xzcZ3DzhhXHUlcbzcvgrUqh+38Ngj57uqmlm
         6BdRoePXn7VJ2GHdeuEhAEKuYDJ/TRMtZ5AsKL/ekxAxH/aaj8OnskTtnqOQx0Cx/wNR
         6d0LWMu2pdjvnW955Eg/R0xDIPqW3zkPxZZsbSZNlqcM0wrgUiQ+D/+JeaOObusUWMX8
         RWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=86Ds328eziIMIPevc2kks39VYSat+UYQJcwfQ52w1+I=;
        b=tKvprlUGBBcbdp+vgXbqeIde0yiXf5DZ083beGF1OzlzyjBQ8sS3cuAMDkTr98QMSw
         ruzLm1MHG5KAm+Ynl3lPng7EFhes4V1hj8OzyUgC4m3DcwFxdNqTRKKJlLlxEU2TsMau
         F00BS7ARtzyIUw+5wGuP0CLfHO8tkWwStiPW6q3U79QlX1PzUZpxQsbDrS977+ibAICr
         lxff9mV3V6wvx9kUDy+MNDtnH1njFmUfrb8KARReMTcSpd229sJZFkplnjZnjxZnBgKy
         6JpQ6gSvo6obiiucKf+gq4yEVklrXdyOvdQvmNMocmv1rr4xm+gOSUVD5ZvpmJvr7J6h
         QL3g==
X-Gm-Message-State: ABuFfohHrEMqRZk522TgB7Nr2+oHjvuLCsaaGUthTF0Af6u34jYYKK8n
        XJ38U0ss5v/N6Hmp9k6AjYTwf7loWUXoY9zeoXw=
X-Google-Smtp-Source: ACcGV62AA727wqyVPO5iB76qY9KY8IWO0uhDAx5JTbU0dyvPVsahWN+mUx5/K5P0oc1hWemnwM1a1HSa4gb9DpsG3oA=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr20567208qkg.70.1539700561454;
 Tue, 16 Oct 2018 07:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Oct 2018 17:35:50 +0300
Message-ID: <CAHp75VcWu_6jco6k5to1x1QNG8Ad893J81TPpTbJkLcqw=RR=g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
To:     "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 2:41 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi guys,
>
> To continue the discussion started by Dmitry [1], this is my proposal
> that I mentioned in my last mail. In short, the idea is that instead
> of trying to extend the support for the currently used struct
> property_set, I'm proposing that we introduce a completely new,
> independent type of fwnode, and replace the struct property_set with
> it. I'm calling the type "software node" here.
>
> The reason for a complete separation of the software nodes from the
> generic property handling code is the need to be able to create the
> nodes independently from the devices that they are bind to.
>
> The way this works is that every node that is created will have a
> kobject registered. That will take care the ref counting for us, and
> also allow us to for example display the properties in sysfs.
>
> There are a few more details in patch 3/5 about the software nodes in
> the commit message.
>
> [1] https://lkml.org/lkml/2018/9/17/1067

In private discussion I brought a concern that we exposed properties
as a part of ABI, but at the same time we have not strict rules which
might lead to ambiguous reading, e.g. there is no type exported and
thus no possibility to tell what kind of property it is.

Examples:
1. 0x1 and 0x1 =E2=80=94 are they of the same type?
2. 0x1 =E2=80=94 is it an array or single value?
3. 0x12345678 =E2=80=94 is it string or hex?
4. 25 =E2=80=94 is it hex or decimal?

Until these will not be solved, better to not to expose properties to users=
pace.

>
> --
> heikki
>
>
> Heikki Krogerus (5):
>   drivers core: Prepare support for multiple platform notifications
>   ACPI / glue: Add acpi_platform_notify() function
>   drivers: base: Introducing software nodes to the firmware node
>     framework
>   device property: Move device_add_properties() to swnode.c
>   device property: Remove struct property_set
>
>  .../ABI/testing/sysfs-devices-software_node   |  27 +
>  drivers/acpi/bus.c                            |   1 -
>  drivers/acpi/glue.c                           |  21 +-
>  drivers/acpi/internal.h                       |   1 -
>  drivers/base/Makefile                         |   2 +-
>  drivers/base/core.c                           |  32 +-
>  drivers/base/property.c                       | 529 +-----------
>  drivers/base/swnode.c                         | 812 ++++++++++++++++++
>  include/linux/acpi.h                          |  10 +
>  include/linux/property.h                      |  12 +
>  10 files changed, 929 insertions(+), 518 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-software_node
>  create mode 100644 drivers/base/swnode.c
>
> --
> 2.19.1
>


--=20
With Best Regards,
Andy Shevchenko
