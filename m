Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE2AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10BE20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FEv0IZaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10BE20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLKI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:27:05 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50728 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeLKI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:27:05 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181211082702euoutp02781a51452f9fc41ddb09ff87462f4fbf~vOd33toJf2739327393euoutp028
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 08:27:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181211082702euoutp02781a51452f9fc41ddb09ff87462f4fbf~vOd33toJf2739327393euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544516822;
        bh=HhHMtYeiK0pretpmteYjesAMNNZ7vLCA+FnPmFswdqo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FEv0IZajLR/z2/fm6un8ODJffJmmAoRmhmhjuWjo2FQF3/AjkOiE1bDpBWTSfOhAX
         GlijF5inIOYTtuYdXsuqtttVEXtQ4icaSAg2tFtFYV0g1TsMsubE5vlEpYtkJvyADz
         v/8fpfFJvBDYIpFAKitdZbEUTHLRIPnT/UGMQWcM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181211082701eucas1p140cadfca2d1024ba5667c97562ae094e~vOd2v1CP92946829468eucas1p1D;
        Tue, 11 Dec 2018 08:27:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B7.7A.04806.5D47F0C5; Tue, 11
        Dec 2018 08:27:01 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181211082700eucas1p1e5abc6f2c09e2ad7415ecde21f70df28~vOd19e1xQ2946829468eucas1p18;
        Tue, 11 Dec 2018 08:27:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181211082700eusmtrp2cdb33e14ae6b2cfa38cad48d2b8794c9~vOd1taVhk0174801748eusmtrp28;
        Tue, 11 Dec 2018 08:27:00 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-4d-5c0f74d514c3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.09.04284.4D47F0C5; Tue, 11
        Dec 2018 08:27:00 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181211082659eusmtip272f192f057f30c1aa42d24fb0eb70ab7~vOd01r4Z31520615206eusmtip2T;
        Tue, 11 Dec 2018 08:26:59 +0000 (GMT)
Subject: Re: [PATCH v3 2/5] devfreq: add support for suspend/resume of a
 devfreq device
To:     myungjoo.ham@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kgene@kernel.org" <kgene@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <fc1c8d73-176a-f20e-3413-f07863a6c595@partner.samsung.com>
Date:   Tue, 11 Dec 2018 09:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211014315epcms1p153a54217e587fd76a8198db77762699a@epcms1p1>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG/XquNBY/q443auZsYtRFi0YTv6hxuhhzQuJiXBZBMdrpgaIU
        sQdQdMYOHFS8wAiZWFEMeCFtES2lFgUvXERFKFUcjgUlVoJukCkVN4mroz0147/fe3nyPk/y
        8pS6hJ3KJ6WkicYUXbKGVdKuO+898x+nTYhf0P5vJLldM5dcKa5iyNUr7xjS9bafIaVN7QzJ
        Lq9iyYMjBpLv+5MiHs9ljrRlDXDEUlSvIA7frwx5dK2EJf5jTYgUe24oSGVTD0fOd3kV5Pcf
        K1jSc795VN/6kCE/1TdxJMf2miEDHU/plVGC67qLEexn7Eg4ZfLSQkH+EBLK614pBIf1MCvc
        PG3nhOpzB4XAHU5wPs6lheNOKxIqbH9zgt/x+TrVRuXy7WJyUoZojF6xVanvd2hT38TurTQP
        sCb0PCYPRfCAF0N/aQvKQ0pejSsQeD0WVi7eIgj4qsMTP4KyC7mKT5LnbhsTZDW+OCpxLZd5
        EEH9b2yQJ+E4CLSbQuLJ+AQFNVYTFSwoPMjA4Zs5dB7ieRZrwW3dHRSo8BpwHbrLBZnGs8Ba
        khXiKTgWzM9srLwzEe6dfEEHOQJ/A0fL7ob6FI6C7helCplnQHbNqdAtwL081P3TScmuV8Or
        IkuYJ8EfLU5O5unwsbY0nEyCNrOVlfkHyL3nDu8sg8YWLxP0TOG5UHUtWm6vguY+eygK4Eh4
        MjhRthAJha4TlNxWgTlHLW/PAefRjvChz+Ci/ReuAGksY4JZxoSxjAlj+f/uWURbUZSYLhkS
        RWlRirhHK+kMUnpKonbbLoMDjf5sa6Bl2I1ufPi+AWEeacarvjgUGa9mdBlSpqEBAU9pJqvm
        J6ji1artusx9onHXFmN6sig1oGk8rYlS7R/Xu0mNE3Vp4k5RTBWNn6YKPmKqCXlhaZL/1o5z
        vtnOofF1izqyvu3xbfWYuy5VftzYsCJj9aC+aN5QyYG2zJFMRV/2zOqRbn9n8tDaPbOHa1Nj
        e/Vf1QbWL+lKai3cTP1cvirmvBYt3D+jceRpQt+sgg229V93/pX7nbIxLqFV/9JdnB33Lrbs
        gO3gpeFH1vzp9jXXM7p7NbSk1y38kjJKuv8A2oFIPa8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e3uPhRXtzn1l39k3N6hV6+m+xkVEWQ3oRJSKDNs5E1F52x3
        mkqRvcseloXVKrW0sM2lTp1SaShmmY+1Mo1KoxTEtPBRWRTW5gr873P4ns85HDgUJjfj3lRi
        ik7QpqiSGcJV2jb1pM+vSzc7JuBrvwdqrFmGKq+U46i28juOer4O4qiwuRNHR4rLCdR+Wo1y
        +4cxZLVWkKjj8AiJ9JfqJcjc342jl/evE2jibDNAV6wNEmRq7iXR7R6bBL09VEqg3meP7X7b
        Cxwdq28m0XHjKI5GnvdJ13rxlgcWnC8rKAP8tWyblD+fOw744odDEt5sOEXwj26UkXxVyUF+
        qoXkq1+dkPLnqg2ALzVOkvyEeV6ELJpdpdWk6YT5CRpRt5rZwaFAlgtFbOCKUJYLUu5cGRjM
        +K9ZFSckJ6YLWv81u9iEQTObOrYtw3RyhMgGH8NzgAsF6RXwY50RzwGulJy+DeBE3ijuDDxh
        XkMt6WR3+Ls7h3A2DQNYYLVijsCd3g6nOrOBI1DQlzHYVnMMcxQYPYbDy0bTP6VOAj/lf7HP
        pSiCZmGdYa/DltFh0HL06fQKKb0IGq4fnmYPehvsGLoHnD1zYOvVAamDXejN8Mytp4SDMToE
        FlR9wJzsBd8MFEqc7AOP1FzDzgO5foaun6HoZyj6GUoRkBqAQkgT1fFqkWNFlVpMS4lnd2vU
        ZmD/F0vLz6o68KJyaxOgKcC4yTKOz4qR46p0MVPdBCCFMQqZ3x5ZjFwWp8rMErSaWG1asiA2
        gWD7cRcwb4/dGvv3pehiuWBOiUI5ZZAyKAQxXjJrQGa0nI5X6YQkQUgVtP89CeXinQ2i9l2M
        C3un8FEMZDRF+SxY0uOmaJcp19oi800bGiMn962vr9lYtHTBOji6MKD/asudVF/bYGlrwZ+b
        Vfl/fFO5ntCuwcnv5zq+Wdp/j7t0/mRCFptt4e8rFs09oC7dRDO5XiVZC0P2P4zwHf3Gfb47
        1gUZNmdLUu+TIgwjf7z2/MVIxQQVtxzTiqq/xOgcdEUDAAA=
X-CMS-MailID: 20181211082700eucas1p1e5abc6f2c09e2ad7415ecde21f70df28
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110620eucas1p14de70dc092580b684a0304b5ce771605
References: <5C0878C0.4060500@samsung.com>
        <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <1544007956-28889-3-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110620eucas1p14de70dc092580b684a0304b5ce771605@epcms1p1>
        <20181211014315epcms1p153a54217e587fd76a8198db77762699a@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MyungJoo,

Thank you for taking the patch set.
Please check my response bellow.

On 12/11/18 2:43 AM, MyungJoo Ham wrote:
>> Hi Lukasz,
>>
>> On 2018년 12월 05일 20:05, Lukasz Luba wrote:
>>> The patch prepares devfreq device for handling suspend/resume
>>> functionality. The new fields will store needed information during this
>>> process. Devfreq framework handles opp-suspend DT entry and there is no
>>> need of modyfications in the drivers code. It uses atomic variables to
>>> make sure no race condition affects the process.
>>>
>>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>>> ---
>>>   drivers/devfreq/devfreq.c | 47 +++++++++++++++++++++++++++++++++++++++++------
>>>   include/linux/devfreq.h   |  7 +++++++
>>>   2 files changed, 48 insertions(+), 6 deletions(-)
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
> 
> Looks goot do me as well.
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> 
> Anyway, for the sake of curiosity...
> 
> Having suspend-frequency is usually required when
> the frequency configuration is reset with suspend-resume
> as older Exynos's CPU did (I don't know whether it still does).
You are right, some Exynos SoCs like 4412 needs the proper configuration.
> 
> Does GPU do this as well?
> (memory-bus won't do this because they are kept turned on during suspend)
I haven't seen GPU failures.
The CPU resume process can fail when some buses ('leftbus' (data 
bus/peripheral bus), 'rightbus', 'memory-bus')
are not operating with needed frequency.

Here is the log showing CPU1,2,3 booting failure:
-------------------------------------------------------------------
root@target:~# echo mem > /sys/power/state
[   43.432066] PM: suspend entry (deep)
[   43.481742] PM: Syncing filesystems ... done.
[   43.553433] Freezing user space processes ... (elapsed 0.002 seconds) 
done.
[   43.556687] OOM killer disabled.
[   43.556694] Freezing remaining freezable tasks ... (elapsed 0.001 
seconds) done.
[   43.558305] printk: Suspending console(s) (use no_console_suspend to 
debug)

[   43.718007] dwc2 12480000.hsotg: suspending usb gadget g_ether
[   43.718229] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   43.718260] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   43.722021] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   43.722038] dwc2 12480000.hsotg: dwc2_hsotg_ep_disable: called for ep0
[   43.781714] wake enabled for irq 134
[   43.781822] CAM_ISP_CORE_1.2V: No configuration
[   43.781918] VMEM_VDDF_3.0V: No configuration
[   43.781952] VCC_SUB_2.0V: No configuration
[   43.781986] VCC_SUB_1.35V: No configuration
[   43.782018] VMEM_1.2V_AP: No configuration
[   43.787139] MOTOR_VCC_3.0V: No configuration
[   43.787176] LCD_VCC_3.3V: No configuration
[   43.787209] TSP_VDD_1.8V: No configuration
[   43.787242] TSP_AVDD_3.3V: No configuration
[   43.787273] VMEM_VDD_2.8V: No configuration
[   43.787305] VTF_2.8V: No configuration
[   43.787422] VDDQ_PRE_1.8V: No configuration
[   43.787456] VT_CAM_1.8V: No configuration
[   43.787488] CAM_ISP_SEN_IO_1.8V: No configuration
[   43.787521] CAM_SENSOR_CORE_1.2V: No configuration
[   43.789160] NFC_AVDD_1.8V: No configuration
[   43.792571] CAM_ISP_MIPI_1.2V: No configuration
[   43.794209] VCC_1.8V_IO: No configuration
[   43.794244] VCC_2.8V_AP: No configuration
[   43.794279] VCC_1.8V_AP: No configuration
[   43.794331] VALIVE_1.0V_AP: No configuration
[   43.805821] wake enabled for irq 138
[   43.806368] wake enabled for irq 160
[   43.806382] wake enabled for irq 161
[   43.824045] samsung-pinctrl 11000000.pinctrl: Setting external wakeup 
interrupt mask: 0xff77ff7d
[   43.841162] Disabling non-boot CPUs ...
[   43.863016] Enabling non-boot CPUs ...
[   43.864749] ------------[ cut here ]------------
[   43.864779] WARNING: CPU: 1 PID: 0 at 
./arch/arm/include/asm/proc-fns.h:124 secondary_start_kernel+0x20c/0x268
[   43.864788] Modules linked in:
[   43.864805] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
4.20.0-rc2-next-20181114-00007-g5506a9cd6bd7 #1042
[   43.864813] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   43.864835] [<c011261c>] (unwind_backtrace) from [<c010e150>] 
(show_stack+0x10/0x14)
[   43.864852] [<c010e150>] (show_stack) from [<c0a4b0a0>] 
(dump_stack+0x98/0xc4)
[   43.864870] [<c0a4b0a0>] (dump_stack) from [<c01270a4>] 
(__warn+0x10c/0x124)
[   43.864884] [<c01270a4>] (__warn) from [<c01271d0>] 
(warn_slowpath_null+0x40/0x48)
[   43.864899] [<c01271d0>] (warn_slowpath_null) from [<c0110ee0>] 
(secondary_start_kernel+0x20c/0x268)
[   43.864913] [<c0110ee0>] (secondary_start_kernel) from [<401027ac>] 
(0x401027ac)
[   43.864923] irq event stamp: 982984
[   43.864942] hardirqs last  enabled at (982983): [<c0a6cc6c>] 
_raw_spin_unlock_irqrestore+0x6c/0x74
[   43.864954] hardirqs last disabled at (982984): [<c0110c68>] 
arch_cpu_idle_dead+0x18/0x84
[   43.864969] softirqs last  enabled at (982964): [<c012f0e0>] 
irq_enter+0x78/0x80
[   43.864980] softirqs last disabled at (982963): [<c012f0cc>] 
irq_enter+0x64/0x80
[   43.864989] ---[ end trace 6401b9331547e26f ]---
[   43.864996] ------------[ cut here ]------------
[   43.865009] WARNING: CPU: 1 PID: 0 at 
./arch/arm/include/asm/proc-fns.h:126 secondary_start_kernel+0x244/0x268
[   43.865016] Modules linked in:
[   43.865030] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W 
4.20.0-rc2-next-20181114-00007-g5506a9cd6bd7 #1042
[   43.865039] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   43.865054] [<c011261c>] (unwind_backtrace) from [<c010e150>] 
(show_stack+0x10/0x14)
[   43.865068] [<c010e150>] (show_stack) from [<c0a4b0a0>] 
(dump_stack+0x98/0xc4)
[   43.865081] [<c0a4b0a0>] (dump_stack) from [<c01270a4>] 
(__warn+0x10c/0x124)
[   43.865095] [<c01270a4>] (__warn) from [<c01271d0>] 
(warn_slowpath_null+0x40/0x48)
[   43.865109] [<c01271d0>] (warn_slowpath_null) from [<c0110f18>] 
(secondary_start_kernel+0x244/0x268)
[   43.865122] [<c0110f18>] (secondary_start_kernel) from [<401027ac>] 
(0x401027ac)
[   43.865131] irq event stamp: 982984
[   43.865144] hardirqs last  enabled at (982983): [<c0a6cc6c>] 
_raw_spin_unlock_irqrestore+0x6c/0x74
[   43.865156] hardirqs last disabled at (982984): [<c0110c68>] 
arch_cpu_idle_dead+0x18/0x84
[   43.865168] softirqs last  enabled at (982964): [<c012f0e0>] 
irq_enter+0x78/0x80
[   43.865179] softirqs last disabled at (982963): [<c012f0cc>] 
irq_enter+0x64/0x80
[   43.865187] ---[ end trace 6401b9331547e270 ]---
[   44.856140] CPU1: failed to boot: -110
[   44.856956] Error taking CPU1 up: -110
[   45.856655] CPU2: failed to boot: -110
[   45.857770] Error taking CPU2 up: -110
[   46.856059] CPU3: failed to boot: -110
[   46.856721] Error taking CPU3 up: -110
-------------------------------------------------------------------

With the patch set, the CPUs are up and running.
-------------------------------------------------------------------
==========================================================
root@target:~# echo mem > /sys/power/state
[ 1135.879168] PM: suspend entry (deep)
[ 1135.906378] PM: Syncing filesystems ...
[ 1135.919299] mmc_host mmc2: Bus speed (slot 0) = 50000000Hz (slot req 
400000Hz, actual 396825HZ div = 63)
[ 1136.137522] mmc_host mmc2: Bus speed (slot 0) = 50000000Hz (slot req 
52000000Hz, actual 50000000HZ div = 0)
[ 1136.184722] done.
[ 1136.196373] Freezing user space processes ... (elapsed 0.001 seconds) 
done.
[ 1136.197689] OOM killer disabled.
[ 1136.197692] Freezing remaining freezable tasks ... (elapsed 0.001 
seconds) done.
[ 1136.198923] printk: Suspending console(s) (use no_console_suspend to 
debug)
[ 1136.364056] devfreq8, suspend_freq=200000000
[ 1136.364114] devfreq4, suspend_freq=200000000
[ 1136.364174] devfreq3, suspend_freq=200000000
[ 1136.364217] devfreq2, suspend_freq=400000000
[ 1136.364311] devfreq0, suspend_freq=400000000
[ 1136.425416] wake enabled for irq 134
[ 1136.425439] CAM_ISP_CORE_1.2V: No configuration
[ 1136.425457] VMEM_VDDF_3.0V: No configuration
[ 1136.425476] VCC_SUB_2.0V: No configuration
[ 1136.425493] VCC_SUB_1.35V: No configuration
[ 1136.425510] VMEM_1.2V_AP: No configuration
[ 1136.426939] MOTOR_VCC_3.0V: No configuration
[ 1136.426958] LCD_VCC_3.3V: No configuration
[ 1136.426976] TSP_VDD_1.8V: No configuration
[ 1136.426994] TSP_AVDD_3.3V: No configuration
[ 1136.427012] VMEM_VDD_2.8V: No configuration
[ 1136.427029] VTF_2.8V: No configuration
[ 1136.427047] VDDQ_PRE_1.8V: No configuration
[ 1136.427064] VT_CAM_1.8V: No configuration
[ 1136.427082] CAM_ISP_SEN_IO_1.8V: No configuration
[ 1136.427100] CAM_SENSOR_CORE_1.2V: No configuration
[ 1136.427605] NFC_AVDD_1.8V: No configuration
[ 1136.429020] CAM_ISP_MIPI_1.2V: No configuration
[ 1136.429859] VCC_1.8V_IO: No configuration
[ 1136.429879] VCC_2.8V_AP: No configuration
[ 1136.429898] VCC_1.8V_AP: No configuration
[ 1136.429926] VALIVE_1.0V_AP: No configuration
[ 1136.435110] wake enabled for irq 138
[ 1136.435381] wake enabled for irq 160
[ 1136.435391] wake enabled for irq 161
[ 1136.443372] samsung-pinctrl 11000000.pinctrl: Setting external wakeup 
interrupt mask: 0xff77ff7d
[ 1136.450942] Disabling non-boot CPUs ...
[ 1136.575256] Enabling non-boot CPUs ...
[ 1136.577278] CPU1 is up
[ 1136.579226] CPU2 is up
[ 1136.581283] CPU3 is up
[ 1136.581773] s3c-i2c 13860000.i2c: slave address 0x10
[ 1136.581788] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[ 1136.581809] s3c-i2c 13890000.i2c: slave address 0x10
[ 1136.581821] s3c-i2c 13890000.i2c: bus frequency set to 390 KHz
[ 1136.581841] s3c-i2c 138a0000.i2c: slave address 0x10
[ 1136.581866] s3c-i2c 138a0000.i2c: bus frequency set to 97 KHz
[ 1136.581887] s3c-i2c 138b0000.i2c: slave address 0x00
[ 1136.581899] s3c-i2c 138b0000.i2c: bus frequency set to 97 KHz
[ 1136.581919] s3c-i2c 138d0000.i2c: slave address 0x10
[ 1136.581930] s3c-i2c 138d0000.i2c: bus frequency set to 97 KHz
[ 1136.581949] s3c-i2c 138e0000.i2c: slave address 0x00
[ 1136.581961] s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
[ 1136.590858] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[ 1136.592539] s3c2410-wdt 10060000.watchdog: watchdog disabled
[ 1136.592636] wake disabled for irq 160
[ 1136.592646] wake disabled for irq 161
[ 1136.592768] wake disabled for irq 138
[ 1136.596830] wake disabled for irq 134
[ 1136.648824] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[ 1136.651430] mmc1: queuing unknown CIS tuple 0x80 (6 bytes)
[ 1136.721638] devfreq8 resume_freq=200000000
[ 1136.721664] devfreq4 resume_freq=200000000
[ 1136.721681] devfreq3 resume_freq=200000000
[ 1136.721704] devfreq2 resume_freq=267000000
[ 1136.721738] devfreq0 resume_freq=267000000
[ 1136.944032] panel-samsung-s6e8aa0 11c80000.dsi.0: ID: 0xa2, 0x20, 0x8c
[ 1137.754939] OOM killer enabled.
[ 1137.760515] Restarting tasks ... done.
root@target:~# [ 1137.768132] PM: suspend exit
-------------------------------------------------------------------

Regards,
Lukasz
> 
> 
> Cheers,
> MyungJoo
> 
> 
> 
