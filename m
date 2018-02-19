Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeBSLfp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:35:45 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34770 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752528AbeBSLfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:35:43 -0500
X-Google-Smtp-Source: AH8x227Lgu/2riow7ruE4SAhhDK7o3RZm1KoPJFcEV1sS0EE3qn5R7/0WDu8MXQUTPDnoQiUeioHhuwc0dHqMFt2RE4=
MIME-Version: 1.0
In-Reply-To: <1514904162-11201-6-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com> <1514904162-11201-6-git-send-email-sudeep.holla@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Feb 2018 12:35:42 +0100
X-Google-Sender-Auth: W0_w-LdS8A3MBp2HExIpXkpJXE8
Message-ID: <CAK8P3a1wBBVZnd6ns5K-HhQ28WKAwVbaWsnmE+83SyOnTQt4_w@mail.gmail.com>
Subject: Re: [PATCH v5 05/20] firmware: arm_scmi: add scmi protocol bus to
 enumerate protocol devices
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
        Roy Franz <roy.franz@cavium.com>,
        Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>,
        Loc Ho <lho@apm.com>, Alexey Klimov <klimov.linux@gmail.com>,
        Ryan Harkin <Ryan.Harkin@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 2, 2018 at 3:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> +#ifdef CONFIG_ARM_SCMI_PROTOCOL
> +int scmi_driver_register(struct scmi_driver *driver,
> +                        struct module *owner, const char *mod_name);
> +void scmi_driver_unregister(struct scmi_driver *driver);
> +#else
> +static int scmi_driver_register(struct scmi_driver *driver,
> +                               struct module *owner, const char *mod_name)
> +{
> +       return -EINVAL;
> +}
> +static void scmi_driver_unregister(struct scmi_driver *driver) {}
> +#endif /* CONFIG_ARM_SCMI_PROTOCOL */

The dummy helpers must be 'static inline', not just 'static', otherwise you
get a warning when this header is included by a file that doesn't call
both of them.


      Arnd
