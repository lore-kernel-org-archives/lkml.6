Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeERJHJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:07:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44797 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeERJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:07:03 -0400
X-Google-Smtp-Source: AB8JxZqWRYnl6CuNy0KVEouM531+j4/MxgI3Z14qeiI+I1zJ/UfgQ9/RyuMxx7rTW6+lWyziPifxUPw5HF6jztVa6Tc=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0ikXsWdXq-h8rWLd-vfzi-gFmxyHmOGvRvDUoJHC3L2XA@mail.gmail.com>
References: <1526633329-31729-1-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0ikXsWdXq-h8rWLd-vfzi-gFmxyHmOGvRvDUoJHC3L2XA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 18 May 2018 11:07:02 +0200
Message-ID: <CAPDyKFphMCQ_S5aBVToGUL=Rvd0cBQ4O3Top3AYPdM79Ak_LzA@mail.gmail.com>
Subject: Re: [PATCH] PM / runtime: Fixup reference counting of device link
 suppliers at probe
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2018 at 10:58, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, May 18, 2018 at 10:48 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> In the driver core, before it invokes really_probe() it runtime resumes the
>> suppliers for the device via calling pm_runtime_get_suppliers(), which also
>> increases the runtime PM usage count for each of the available supplier.
>>
>> This makes sense, as to be able to allow the consumer device to be probed
>> by its driver. However, if the driver decides to add a new supplier link
>> during ->probe(), hence updating the list of suppliers,
>
> Do any of the existing drivers do that?

Yes.

At least these, but possibly even more...

drivers/gpu/drm/rockchip/rockchip_drm_drv.c
drivers/gpu/drm/tegra/dc.c
drivers/gpu/ipu-v3/ipu-prg.c
drivers/pci/dwc/pci-dra7xx.c

>
>> the following call to pm_runtime_put_suppliers(), invoked after really_probe()
>> in the driver core, we get into trouble.

Kind regards
Uffe
