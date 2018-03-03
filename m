Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964958AbeCCBXR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 20:23:17 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53550 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964863AbeCCBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 20:23:15 -0500
X-Google-Smtp-Source: AG47ELsAfdpesng5HE+LGLHZHZRmQVS2EI00vSXpdPkv/sZqSK1090cVO0Sy5o3HafuVmEe6ArVsBpcpDngeKs8DmT0=
MIME-Version: 1.0
In-Reply-To: <20180301083950.esonqqg2m5noofdp@linutronix.de>
References: <20180301032754.146788-1-dbasehore@chromium.org> <20180301083950.esonqqg2m5noofdp@linutronix.de>
From: "dbasehore ." <dbasehore@chromium.org>
Date: Fri, 2 Mar 2018 17:23:13 -0800
X-Google-Sender-Auth: ozBquMV7kho3Xiaffg5bCRykPF0
Message-ID: <CAGAzgso6ZOKWEWPJP3FD8si39S+WUhZEB3RgWrUigo4tSC079w@mail.gmail.com>
Subject: Re: [PATCH] cpu_pm: add syscore_suspend error handling
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, alex.shi@linaro.org,
        Brian Norris <briannorris@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 12:39 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-02-28 19:27:54 [-0800], Derek Basehore wrote:
>> If cpu_cluster_pm_enter() fails, cpu_pm_exit() should be called. This
>> will put the CPU in the correct state to resume from the failure.
>
> Was this triggered or found on review? Either way it was introduced in
>   6f3eaec87b6b ("cpu_pm: call notifiers during suspend")
> and I might need a stable tag.

It was found during review. I was able to verify that this is a bug,
though. The Rockchip RK3399 doesn't use cluster idle except during
suspend. If I just return an error for cpu_cluster_pm_enter, the
machine wedges. Including this patch makes it error out of suspend
gracefully.

>
>> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
>
> Sebastian
