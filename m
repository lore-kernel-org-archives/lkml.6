Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeBSLb3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:31:29 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53868 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeBSLb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:31:27 -0500
X-Google-Smtp-Source: AH8x226WJ9X3x9L8HY/GYM+FgPYxriPeVf+bzepHqAGtH/iVmgA9ODK4awYVGej7zchxldH4up4khA==
Subject: Re: 500 ms delay in time saved into RTC
To: Karel Zak <kzak@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, util-linux@vger.kernel.org,
        J William Piggott <elseifthen@gmx.com>
References: <30ae185f-28c9-54f1-2884-4ee7801b130e@gmail.com>
 <34f50661-85f5-eb46-3ff7-45f0c2bb5960@prevas.dk>
 <20180219110328.n7yjorinjm3xxckr@ws.net.home>
From: Igor Plyatov <plyatov@gmail.com>
Message-ID: <0ce68f3f-fec7-1f1c-e70b-331c0752f6d6@gmail.com>
Date: Mon, 19 Feb 2018 14:31:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219110328.n7yjorinjm3xxckr@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Karel,


> Would be possible to somehow detect what is the right default setting for
> --delay? I mean for example detect architecture / clock HW, etc.
>
> I have no problem with --delay, but it's tuning for advanced users and
> HW specific stuff. It would be nice to have something more portable.
>
>      Karel
>

As I understood, issue exists only at x86 platform, where 
MC146818-compatible RTC used.

But even if you will correctly detect platform, there is no guaranty to 
get exactly MC146818 RTC. RTC can be other type. It even can be not 
single in the system.

What is more or less usable is "/sys/class/rtc/rtcX/name" file, which 
contains driver name.
For x86 and MC146818-compatible RTC its name is "rtc_cmos". And it can 
be used to distinguish RTC type by hwclock utility.

Best wishes.
--
Igor Plyatov
