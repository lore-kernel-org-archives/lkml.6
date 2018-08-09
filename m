Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A3BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F327221CCE
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8sQMPUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F327221CCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbeHIOTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:19:35 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34697 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730132AbeHIOTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:19:35 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so9350595ois.1;
        Thu, 09 Aug 2018 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jTwOTfEOYdJ8yfQdzDyvjSqsIOn1s2SlxG7d/BoiTo0=;
        b=Y8sQMPUIfJZ+VbAaKXZkMFd/oUvN1CR60V8KiwI1uAws2J3p+jhVgfT78vYl/qb5oP
         aXGvR+9UNTveLDD8JZZ4D+6/e7z52OI+d/3HERR+cypo9f/9/OSvOC4eSgNy7m6ZXSBP
         LdanN4xrw3rqwe6BI2d9+fnNrVzYFbrDzXjiMGYSyvE/dAKsBo8CI/uY2inMjez48IU9
         UTXUuWxFHaDT6SdQTHuMWbFZOmxbpXjK3b2MV1HGALi07F6o1mgy4kPHTDm//5CTtSq2
         /TcBxW6jt1go/TtK862t+uaDFhZZbwaRQ1o7F6XmJ55Ap/r5MJWONlKeGXQTtGsW0hXz
         bdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jTwOTfEOYdJ8yfQdzDyvjSqsIOn1s2SlxG7d/BoiTo0=;
        b=J0qDaoGofcfPidYl8JIzNy1HvCFATpGQqI1bgSGYMZ52smnVS9EcSqjtdyMqpM+dYy
         pHNE2LVLD7NbuF4aM/0ioKdXWscOPqN4HFoyGR3W9dzPSibV9GzRcVhUUfJTH9RgW1EM
         VplI6godowLpreH5uWkMgn0tl1JMINPkXLbq0IKGA4fG1clBidJuRNBMHbz7PgzEq4aA
         5ib9Fw3mPI5kVZzrKHWWn33Odv/QmcqORISPRX8tQIWXR9BlrBRcdrg5xPR2BTmGK6J5
         rL9yqUl6Ga1LmhnQwDMAcC1E2V3I9KM1xEtNvQSvdko2B04gDY4zIZ43LZ28f/Jx/C7q
         c7Ig==
X-Gm-Message-State: AOUpUlEbnNmQrAwlH03pzkJo2f41UOBmK/yfWpFHel4Q+0RTmBR0i4Fp
        bVWYP1wlbE5ROUGr3pB8N0O1AYptSOnLvp465/8=
X-Google-Smtp-Source: AA+uWPzA1WpaBVcMTfO5X0X9R3wcTY7QJQbTc1nK0a9vRZajP/E58mgfBAFpLKT0cqfaB/C2Ay/aR8XGGrJimwk9xEU=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr1655379oif.358.1533815702509;
 Thu, 09 Aug 2018 04:55:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 04:55:01 -0700 (PDT)
In-Reply-To: <20180809114046.21366-5-hdegoede@redhat.com>
References: <20180809114046.21366-1-hdegoede@redhat.com> <20180809114046.21366-5-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 13:55:01 +0200
X-Google-Sender-Auth: NVY2auCGIpcBV63AaPdYQ-j-0e8
Message-ID: <CAJZ5v0jbNTGEXWJ+CtPOKSM=AyB5-3hV-tMCYehj5w87i_2znA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] platform/x86: Add ACPI i2c-multi-instantiate
 pseudo driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 1:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On systems with ACPI instantiated i2c-clients, normally there is 1 fw_node
> per i2c-device and that fw-node contains 1 I2cSerialBus resource for that 1
> i2c-device.
>
> But in some rare cases the manufacturer has decided to describe multiple
> i2c-devices in a single ACPI fwnode with multiple I2cSerialBus resources.
>
> An earlier attempt to fix this in the i2c-core resulted in a lot of extra
> code to support this corner-case.
>
> This commit introduces a new i2c-multi-instantiate driver which fixes this
> in a different way. This new driver can be built as a module which will
> only loaded on affected systems.
>
> This driver will instantiate a new i2c-client per I2cSerialBus resource,
> using the driver_data from the acpi_device_id it is binding to to tell it
> which chip-type (and optional irq-resource) to use when instantiating.
>
> Note this driver depends on a platform device being instantiated for the
> ACPI fwnode, see the i2c_multi_instantiate_ids list of ACPI device-ids in
> drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Rebase on top of 4.18-rc2
>
> Changes in v3:
> -Change from an i2c-driver using a hack to allow having multiple i2c clients
>  at the same address to a platform-driver
>
> Changes in v4:
> -Tweak MAINTAINERS entry a bit
>
> Changes in v5:
> -s/no_clients/num_clients/
> -Change patch Subject prefix to platform/x86
>
> Changes in v6:
> -s/irq_idx/gpio_irq_idx/

And this is the only patch that has changed in v6, right?

Anyway, if you have further updates on top of this series, please send
them as incremental patches.

Thanks,
Rafael
