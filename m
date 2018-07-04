Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B47CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F52246BF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 03:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LYFuPFkD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F52246BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932782AbeGDDha (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 23:37:30 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34550 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753196AbeGDDh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 23:37:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so8053103ois.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UzZmaGipAT4qB3UKnL65Gf05TtfyJBxBOBkqAU7A9xA=;
        b=LYFuPFkDLNlGjT6ar3wNGuy/Rl0XVRNbDCAe0cD5NGmekhMNbaRzGZ+DI5UAzZ2i4J
         Vg3ZK78aPQFVTTEEwAYrMLsg2SkgkfgbSV2a0yQX3komHVV9wfuz7zvlddt1sXSGW4Sa
         nkOVceAZwqswJjwo1cjHW0a33aSRWyBRoM8+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UzZmaGipAT4qB3UKnL65Gf05TtfyJBxBOBkqAU7A9xA=;
        b=gtt/R071PLWOSI5Q4vYnWm2+X8F1xqnipzcdYtWQe0Ros2iOAvyEOJq32MPzWnJUyR
         rpLn2OJ+N7b1Y+WmhUaiGfDUL817E7qolAv2P6j0TkYZUPe0bu+dPnbWbXhEq1vpKYfe
         P6JkOaiiCZ9gwOup5sihXfw3wDnlZSe1Oqu+dgUYEjqzm7t+pQaaXsXIInmvhca95kqP
         oRrEumvZ6WGx5cWp8JhlD04y8i8xWDY1+AzrDgg1OK5ntD2JmjWWLXmsnyh0XhOPMTpo
         v6xkQ/fczzU1rIpZfqM6+pSQhQ4WITWXrUzKlKuJJ6ItjnFEOplSrQ1NjqNoPxvL3M4u
         Eysw==
X-Gm-Message-State: APt69E34s2lSlaQg1YMbAIfF6JyTJQaecXZjBp4hSQl98UYd+HYIaje1
        WZckZeSt2+Le1haOYum0Nf3IBzMhVkDm/RMpy+9Nfg==
X-Google-Smtp-Source: AAOMgpfU/gDmk+uhOu2Zb+VlX0ER98nnlxH8dzXI3AKaPJjtFDoVmZLb/wh7UsX06dTo4oH0V8wty+e1OaqCLEfmG3w=
X-Received: by 2002:aca:37c2:: with SMTP id e185-v6mr343870oia.326.1530675446277;
 Tue, 03 Jul 2018 20:37:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:51d2:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 20:37:25 -0700 (PDT)
In-Reply-To: <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com> <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 4 Jul 2018 09:07:25 +0530
Message-ID: <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep, Andy,

Yes, This patch is to get of_device_id and then fetch data pointer.

To add ACPI support in multiple drivers which are device-tree based
and has list of of_device_ids, by using this function
very minimal changes and can avoid acpi_device_id list in the driver.
I will send driver changes where this function used to add ACPI
support in following patches.

Below are the changes added to add ACPI support in sdhci iproc driver
using this function.

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index db40218..f1ecac97 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -15,6 +15,7 @@
  * iProc SDHCI platform driver
  */

+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
@@ -267,8 +268,13 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
        int ret;

        match = of_match_device(sdhci_iproc_of_match, &pdev->dev);
-       if (!match)
-               return -EINVAL;
+       if (!match) {
+               match = acpi_match_of_device_id(sdhci_iproc_of_match,
+                                               &pdev->dev);
+               if (!match)
+                       return -EINVAL;
+       }
+
        iproc_data = match->data;

        host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));

Regards,
Srinath.



On Tue, Jul 3, 2018 at 11:11 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 3, 2018 at 12:22 PM, Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
>> This patch provides a function, to get of_device_id after
>> matching with ACPI device _DSD object compatible property
>> in the case driver does not contain acpi_device_id list
>> and driver probe called for ACPI device ID PRP0001 with
>> compatible property match with of_device_id compatible.
>
> I don't see any usefulness of this function. Care to provide a real use case?
>
> --
> With Best Regards,
> Andy Shevchenko
