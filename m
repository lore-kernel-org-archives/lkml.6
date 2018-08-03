Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6311C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AA7215F9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iwT7JwmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AA7215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbeHCJVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:21:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44047 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeHCJVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:21:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180803072630euoutp027f933a5402a95984b2053dbfe9aa56ed~HTx5-_dfr0439804398euoutp02n
        for <linux-kernel@vger.kernel.org>; Fri,  3 Aug 2018 07:26:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180803072630euoutp027f933a5402a95984b2053dbfe9aa56ed~HTx5-_dfr0439804398euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533281190;
        bh=MmJNquhtyobtVLgpNL9qdpUgZ7tSzu/0Ez6XL/cU2RU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iwT7JwmC8sRoYS3PC0HEqT2J1ps+8JDUjt7iIZb/fUJyopb7HXsUjKb4hs4ywAFFM
         rFoCNf2KOkCszriORwRDlOTKAdAr8fA5AniUH+k6T85HMSNDVNcHORoUVhOyoexLc5
         YUgaPNNbFq05cVxKKjAeS5C9lit23LOznSkGhbv4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180803072629eucas1p124e72ff263b24ba344ba3693809785c2~HTx4_4oIx0343103431eucas1p1H;
        Fri,  3 Aug 2018 07:26:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CA.92.04627.5A3046B5; Fri,  3
        Aug 2018 08:26:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U;
        Fri,  3 Aug 2018 07:26:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180803072628eusmtrp187840f691ac553cdf20f35de3153ef22~HTx3ytWTB2504225042eusmtrp1I;
        Fri,  3 Aug 2018 07:26:28 +0000 (GMT)
X-AuditID: cbfec7f2-0edff70000021213-77-5b6403a5a704
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DA.4A.04178.4A3046B5; Fri,  3
        Aug 2018 08:26:28 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180803072627eusmtip1d79b611e32bc6692cc5e9bb5e8c0a905~HTx3PpHc92331023310eusmtip1-;
        Fri,  3 Aug 2018 07:26:27 +0000 (GMT)
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
To:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        ravisadineni@google.com, dmitry.torokhov@gmail.com, dtor@google.com
Cc:     tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 3 Aug 2018 09:26:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180605224458.62692-1-ravisadineni@chromium.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87pLmVOiDZZ/4LY4vOgFo8X8l53s
        Fjc/fWO1uLxrDpvFjPP7mCzWtXxjtDj/9jerxaLvD1kdODxmN1xk8dg56y67x4JNpR6fN8kF
        sERx2aSk5mSWpRbp2yVwZfw5tZKl4MwW5oorV1eyNjC2fWHqYuTkkBAwkZgz8wVzFyMXh5DA
        CkaJlz1rmCCcL4wSj+6dYodwPjNKdK7fzg7TsnHiGxaIxHJGiZvb9kBVvWeUWL1oLyNIlbBA
        hMT7nhVgHSICNRJNMyeCLWQW6GWUmL3ACcRmEzCU6HrbxQZiswioSBz+vwWonoNDVCBG4vcu
        a5Awr4CgxMmZT1hAbE4Be4nDy1czQ4yRl2jeOhvKFpe49WQ+2NkSAqvYJb5smsAK0VwmceTi
        NKirXSR+t/6GelpY4tXxLVBxGYnTk3tYIJqbGSXaZ8xih3B6GCW2ztnBBlFlLXH4+EVWkOuY
        BTQl1u/SBzElBBwl/k6SgDD5JG68FYS4h09i0rbpzBBhXomONiGIGWoSs46vg9t68MIl5gmM
        SrOQfDkLyWezkHw2C2HtAkaWVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIFJ6PS/4592
        MH69lHSIUYCDUYmH94JqcrQQa2JZcWXuIUYJDmYlEd63nUAh3pTEyqrUovz4otKc1OJDjNIc
        LErivHf646KFBNITS1KzU1MLUotgskwcnFINjG5nVnx5wz3p7zarWxOTNSIkK7p3L8zI/hR8
        ol729tSrOhenFXx6oed/PXGiQl1qc7z7IeOPAqxF4pzOt0/YqH64xWj/7SG3d4gZ87/Yx5+C
        3Raw37+1ru2y8OvUed/WnBJcfjbO0sBUfnvgjVXHXzbcbWPqmj6j4EGr15bA3uSlfAEyUstr
        A5RYijMSDbWYi4oTAXr4/mQ+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xu7pLmFOiDS6fZLU4vOgFo8X8l53s
        Fjc/fWO1uLxrDpvFjPP7mCzWtXxjtDj/9jerxaLvD1kdODxmN1xk8dg56y67x4JNpR6fN8kF
        sETp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZfw5
        tZKl4MwW5oorV1eyNjC2fWHqYuTkkBAwkdg48Q1LFyMXh5DAUkaJL3PmsUAkZCROTmtghbCF
        Jf5c62IDsYUE3jJK3JvqCWILC0RIvO9ZwQ5iiwjUSNxoO8YKMohZoJdR4sqcX8wQDXYSSy7t
        AytiEzCU6HoLMYgXKN7Q9gRsGYuAisTh/1vAakQFYiSOTm6BqhGUODkTooZTwF7i8PLVYDOZ
        Bcwk5m1+CGXLSzRvnQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFhnrF
        ibnFpXnpesn5uZsYgXG37djPzTsYL20MPsQowMGoxMN7QTU5Wog1say4MvcQowQHs5II79tO
        oBBvSmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA1NCXkm8oamhuYWlobmxubGZhZI473mDyigh
        gfTEktTs1NSC1CKYPiYOTqkGRp7aDJ/3++NMfKPvCVy7s/uf3KSiy7ZKeSVz5rbs2bT8m5+v
        7N0e44nt62aesPWPbjHuYna4k+vlPfOC63NB9w0X16Sss2I9sn/BhzKfG7fKtIRv33I/EPG2
        6JrZn9WB96aanguwNbCMrsx9flmo4L/jMlu3W1v+qzZHhubLbTogmLF9QWZgpBJLcUaioRZz
        UXEiAAGuOs3RAgAA
Message-Id: <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
X-CMS-MailID: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
References: <20180605224458.62692-1-ravisadineni@chromium.org>
        <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2018-06-06 00:44, Ravi Chandra Sadineni wrote:
> Remove the unnecessary check before calling pm_wakeup_event. If the
> device is not wake enabled, this call is no-op anyway.
>
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>

This patch breaks suspend/resume on Samsung Exynos5250 Snow Chromebook. 
It looks that it is waiting forever(?) on some cros ec i2c call. With 
no_console_suspend and initcall_debug kernel parameters together with 
playing with magic-sysrq after suspend/resume cycle I've managed to get 
following log:

# rtcwake -s10 -mmem
rtcwake: wakeup from "mem" using /dev/rtc0 at Fri Aug  3 06:13:42 2018
[   38.359219] PM: suspend entry (deep)
[   38.362782] PM: Syncing filesystems ... done.
[   38.379897] Freezing user space processes ... (elapsed 0.002 seconds) 
done.
[   38.382258] OOM killer disabled.
[   38.382263] Freezing remaining freezable tasks ... (elapsed 0.001 
seconds) done.
[   38.388705] calling  input2+ @ 1610, parent: gpio-keys
[   38.388847] call input2+ returned 0 after 122 usecs
[   38.388985] calling  sound+ @ 1610, parent: platform
[   38.423739] max98095 7-0011: ASoC: PRE_PMD: LINE Left Out event 
failed: -22
[   38.435718] call sound+ returned 0 after 45628 usecs
[   38.435746] calling  panel+ @ 1610, parent: platform
[   38.435754] call panel+ returned 0 after 1 usecs
[   38.435768] calling  hdmi-audio-codec.4.auto+ @ 1610, parent: 
14530000.hdmi
[   38.435775] call hdmi-audio-codec.4.auto+ returned 0 after 1 usecs
[   38.435799] calling  backlight+ @ 1610, parent: backlight
[   38.436032] call backlight+ returned 0 after 221 usecs
[   38.436048] calling  backlight+ @ 1610, parent: platform
[   38.445536] call backlight+ returned 0 after 9257 usecs
[   38.445670] calling  mmc2:0001:3+ @ 6, parent: mmc2:0001
[   38.445700] call mmc2:0001:3+ returned 0 after 1 usecs
[   38.445733] calling  mmc2:0001:2+ @ 6, parent: mmc2:0001
[   38.445740] call mmc2:0001:2+ returned 0 after 1 usecs
[   38.445760] calling  mmc2:0001:1+ @ 6, parent: mmc2:0001
[   38.445767] call mmc2:0001:1+ returned 0 after 1 usecs
[   38.445792] calling  mmc2:0001+ @ 6, parent: mmc2
[   38.445884] calling  snd-soc-dummy+ @ 1610, parent: platform
[   38.445892] call snd-soc-dummy+ returned 0 after 1 usecs
[   38.445988] calling  cpufreq-dt+ @ 1610, parent: platform
[   38.445997] call cpufreq-dt+ returned 0 after 1 usecs
[   38.446071] calling  tps65090-charger+ @ 1610, parent: 104-0048
[   38.446079] call tps65090-charger+ returned 0 after 1 usecs
[   38.446208] calling  mmc1:e624+ @ 78, parent: mmc1
[   38.446212] calling  tps65090-pmic+ @ 1610, parent: 104-0048
[   38.446220] call tps65090-pmic+ returned 0 after 1 usecs
[   38.446279] calling  input1+ @ 1610, parent: 
i2c-arbitrator:i2c@0:embedded-controller@1e:keyboard-controller
[   38.446289] call input1+ returned 0 after 3 usecs
[   38.446305] calling 
i2c-arbitrator:i2c@0:embedded-controller@1e:keyboard-controller+ @ 1610, 
parent: 104-001e
[   38.446313] call 
i2c-arbitrator:i2c@0:embedded-controller@1e:keyboard-controller+ 
returned 0 after 1 usecs
[   38.446327] calling  cros-ec-dev.3.auto+ @ 1610, parent: 104-001e
[   38.446334] call cros-ec-dev.3.auto+ returned 0 after 1 usecs
[   38.446370] calling  104-001e+ @ 1610, parent: i2c-104
[   38.448555] call mmc1:e624+ returned 0 after 2283 usecs
[   38.450514] calling  mmc0:0001+ @ 79, parent: mmc0
[   38.457501] call mmc2:0001+ returned 0 after 11425 usecs
[   38.463830] wake enabled for irq 150
[   38.469426] calling  1-1+ @ 6, parent: usb1
[   38.474501] call 104-001e+ returned 0 after 27461 usecs
[   38.490008] call 1-1+ returned 0 after 10331 usecs
[   38.494988] calling  104-000b+ @ 1610, parent: i2c-104
[   38.512028] call mmc0:0001+ returned 0 after 36926 usecs
[   38.547373] call 104-000b+ returned 0 after 51146 usecs
[   38.670382] calling  rtc1+ @ 1610, parent: 101e0000.rtc
[   38.675688] call rtc1+ returned 0 after 2 usecs
[   38.680296] calling  rtc0+ @ 1610, parent: max77686-rtc
[   38.717626] call rtc0+ returned 0 after 31302 usecs
[   38.722578] calling  input0+ @ 1610, parent: 1-0067
[   38.727536] call input0+ returned 0 after 3 usecs
[   38.732368] calling  usb4+ @ 78, parent: xhci-hcd.2.auto
[   38.732790] calling  usb2+ @ 1614, parent: 12120000.usb
[   38.738659] calling  usb1+ @ 79, parent: 12110000.usb
[   38.743044] calling  usb3+ @ 6, parent: xhci-hcd.2.auto
[   38.748311] call usb4+ returned 0 after 10186 usecs
[   38.753567] call usb3+ returned 0 after 251 usecs
[   38.758811] call usb1+ returned 0 after 526 usecs
[   38.763006] calling  xhci-hcd.2.auto+ @ 6, parent: 12000000.dwc3
[   38.773625] call xhci-hcd.2.auto+ returned 0 after 43 usecs
[   38.779206] calling  12000000.dwc3+ @ 1610, parent: soc:usb_dwc3
[   38.785417] call 12000000.dwc3+ returned 0 after 245 usecs
[   38.790917] calling  usb_phy_generic.1.auto+ @ 1610, parent: platform
[   38.797356] call usb_phy_generic.1.auto+ returned 0 after 1 usecs
[   38.803431] calling  usb_phy_generic.0.auto+ @ 1610, parent: platform
[   38.809966] call usb_phy_generic.0.auto+ returned 0 after 1 usecs
[   38.816108] calling  Fixed MDIO bus.0+ @ 1610, parent: platform
[   38.822083] call Fixed MDIO bus.0+ returned 0 after 1 usecs
[   38.827738] calling  max77686-clk+ @ 1610, parent: 0-0009
[   38.833159] call max77686-clk+ returned 0 after 1 usecs
[   38.838478] calling  max77686-rtc+ @ 1610, parent: 0-0009
[   38.844475] wake enabled for irq 146
[   38.848184] call max77686-rtc+ returned 0 after 4181 usecs
[   38.853999] calling  max77686-pmic+ @ 1610, parent: 0-0009
[   38.859554] call max77686-pmic+ returned 0 after 1 usecs
[   38.865284] calling  exynos-drm+ @ 1610, parent: platform
[   38.871024] call usb2+ returned 0 after 114877 usecs
[   38.890105] call exynos-drm+ returned 0 after 13780 usecs
[   38.894146] calling  serial8250+ @ 1610, parent: platform
[   38.899515] call serial8250+ returned 0 after 2 usecs
[   38.908551] calling  alarmtimer+ @ 1610, parent: platform
[   38.913057] call alarmtimer+ returned 0 after 536 usecs
[   38.917812] calling  regulatory.0+ @ 1610, parent: platform
[   #8.923263] call regulatory.0+ returned 0 after 1 usecs
[   38.929144] calling  1-0067+ @ 1610, parent: i2c-1
[   38.967236] wake enabled for irq 148
[   38.969454] call 1-0067+ returned 0 after 35363 usecs
[   38.974510] calling  0-0009+ @ 1610, parent: i2c-0
[   38.979274] call 0-0009+ returned 0 after 5 usecs
[   38.983989] calling  mmc3_pwrseq+ @ 1610, parent: platform
[   38.989422] call mmc3_pwrseq+ returned 0 after 1 usecs
[   38.994522] calling  regulator-usb3+ @ 1610, parent: platform
[   39.000271] call regulator-usb3+ returned 0 after 1 usecs
[   39.005633] calling  i2c-arbitrator+ @ 1610, parent: platform
[   39.011381] call i2c-arbitrator+ returned 0 after 1 usecs
[   39.016744] calling  vbat-fixed-regulator+ @ 1610, parent: platform
[   39.023015] call vbat-fixed-regulator+ returned 0 after 1 usecs
[   39.028925] calling  gpio-keys+ @ 1610, parent: platform
[   39.034182] wake enabled for irq 152
[   39.037759] wake enabled for irq 153
[   39.041292] call gpio-keys+ returned 0 after 6944 usecs
[   39.046515] calling  opp_table0+ @ 1610, parent: platform
[   39.051915] call opp_table0+ returned 0 after 1 usecs
[   39.056940] calling  14650000.sysmmu+ @ 1610, parent: soc
[   39.062332] call 14650000.sysmmu+ returned 0 after 2 usecs
[   39.067818] calling  14640000.sysmmu+ @ 1610, parent: soc
[   39.073332] call 14640000.sysmmu+ returned 0 after 174 usecs
[   39.078845] calling  13eb0000.sysmmu+ @ 1610, parent: soc
[   39.084180] call 13eb0000.sysmmu+ returned 0 after 2 usecs
[   39.089690] calling  13ea0000.sysmmu+ @ 1610, parent: soc
[   39.095029] call 13ea0000.sysmmu+ returned 0 after 2 usecs
[   39.100547] calling  13e90000.sysmmu+ @ 1610, parent: soc
[   39.105880] call 13e90000.sysmmu+ returned 0 after 2 usecs
[   39.111402] calling  13e80000.sysmmu+ @ 1610, parent: soc
[   39.116731] call 13e80000.sysmmu+ returned 0 after 2 usecs
[   39.122241] calling  13c50000.sysmmu+ @ 1610, parent: soc
[   39.127607] call 13c50000.sysmmu+ returned 0 after 2 usecs
[   39.133065] calling  13c40000.sysmmu+ @ 1610, parent: soc
[   39.138498] call 13c40000.sysmmu+ returned 0 after 2 usecs
[   39.143915] calling  132f0000.sysmmu+ @ 1610, parent: soc
[   39.149308] call 132f0000.sysmmu+ returned 0 after 2 usecs
[   39.154765] calling  132e0000.sysmmu+ @ 1610, parent: soc
[   39.160155] call 132e0000.sysmmu+ returned 0 after 2 usecs
[   39.165615] calling  132d0000.sysmmu+ @ 1610, parent: soc
[   39.171005] call 132d0000.sysmmu+ returned 0 after 2 usecs
[   39.176465] calling  132c0000.sysmmu+ @ 1610, parent: soc
[   39.181856] call 132c0000.sysmmu+ returned 0 after 2 usecs
[   39.187340] calling  132b0000.sysmmu+ @ 1610, parent: soc
[   39.192680] call 132b0000.sysmmu+ returned 0 after 2 usecs
[   39.198190] calling  13290000.sysmmu+ @ 1610, parent: soc
[   39.203530] call 13290000.sysmmu+ returned 0 after 2 usecs
[   39.209091] calling  13280000.sysmmu+ @ 1610, parent: soc
[   39.214380] call 13280000.sysmmu+ returned 0 after 2 usecs
[   39.219892] calling  132a0000.sysmmu+ @ 1610, parent: soc
[   39.225230] call 132a0000.sysmmu+ returned 0 after 2 usecs
[   39.230749] calling  13270000.sysmmu+ @ 1610, parent: soc
[   39.236080] call 13270000.sysmmu+ returned 0 after 2 usecs
[   39.241590] calling  13260000.sysmmu+ @ 1610, parent: soc
[   39.246931] call 13260000.sysmmu+ returned 0 after 2 usecs
[   39.252440] calling  11f20000.sysmmu+ @ 1610, parent: soc
[   39.257806] call 11f20000.sysmmu+ returned 0 after 2 usecs
[   39.263265] calling  11d40000.sysmmu+ @ 1610, parent: soc
[   39.268655] call 11d40000.sysmmu+ returned 0 after 2 usecs
[   39.274115] calling  11210000.sysmmu+ @ 1610, parent: soc
[   39.279505] call 11210000.sysmmu+ returned 0 after 2 usecs
[   39.284965] calling  11200000.sysmmu+ @ 1610, parent: soc
[   39.290355] call 11200000.sysmmu+ returned 0 after 2 usecs
[   39.295815] calling  10a60000.sysmmu+ @ 1610, parent: soc
[   39.301206] call 10a60000.sysmmu+ returned 0 after 2 usecs
[   39.306657] calling  soc:video-phy+ @ 1610, parent: soc
[   39.311881] call soc:video-phy+ returned 0 after 2 usecs
[   39.317158] calling  101b0000.cec+ @ 1610, parent: soc
[   39.322296] call 101b0000.cec+ returned 0 after 1 usecs
[   39.327511] calling  13e30000.gsc+ @ 1610, parent: soc
[   39.332600] call 13e30000.gsc+ returned 0 after 1 usecs
[   39.337841] calling  13e20000.gsc+ @ 1610, parent: soc
[   39.342929] call 13e20000.gsc+ returned 0 after 1 usecs
[   39.348208] calling  13e10000.gsc+ @ 1610, parent: soc
[   39.353258] call 13e10000.gsc+ returned 0 after 1 usecs
[   39.358506] calling  13e00000.gsc+ @ 1610, parent: soc
[   39.363588] call 13e00000.gsc+ returned 0 after 1 usecs
[   39.368835] calling  11c10000.mdma+ @ 1610, parent: soc:amba
[   39.374443] call 11c10000.mdma+ returned 0 after 5 usecs
[   39.379772] calling  10800000.mdma+ @ 1610, parent: soc:amba
[   39.385379] call 10800000.mdma+ returned 0 after 5 usecs
[   39.390726] calling  121b0000.pdma+ @ 1610, parent: soc:amba
[   39.396316] call 121b0000.pdma+ returned 0 after 5 usecs
[   39.401663] calling  121a0000.pdma+ @ 1610, parent: soc:amba
[   39.407280] call 121a0000.pdma+ returned 0 after 4 usecs
[   39.412554] calling  soc:amba+ @ 1610, parent: soc
[   39.417340] call soc:amba+ returned 0 after 1 usecs
[   39.422186] calling  12130000.phy+ @ 1610, parent: soc
[   39.427323] call 12130000.phy+ returned 0 after 1 usecs
[   39.432517] calling  12120000.usb+ @ 1610, parent: soc
[   39.437820] call 12120000.usb+ returned 0 after 165 usecs
[   39.443020] calling  12110000.usb+ @ 1610, parent: soc
[   39.448434] call 12110000.usb+ returned 0 after 270 usecs
[   39.453523] calling  12100000.phy+ @ 1610, parent: soc
[   39.458662] call 12100000.phy+ returned 0 after 1 usecs
[   39.463850] calling  soc:usb_dwc3+ @ 1610, parent: soc
[   39.468994] call soc:usb_dwc3+ returned 0 after 7 usecs
[   39.474179] calling  3830000.i2s+ @ 1610, parent: soc
[   39.479232] call 3830000.i2s+ returned 0 after 2 usecs
[   39.484337] calling  12230000.mmc+ @ 1610, parent: soc
[   39.489497] call 12230000.mmc+ returned 0 after 17 usecs
[   39.494753] calling  12220000.mmc+ @ 1610, parent: soc
[   39.499900] call 12220000.mmc+ returned 0 after 11 usecs
[   39.505169] calling  12200000.mmc+ @ 1610, parent: soc
[   39.510321] call 12200000.mmc+ returned 0 after 16 usecs
[   39.515583] calling  12d30000.spi+ @ 1610, parent: soc
[   39.520864] call 12d30000.spi+ returned 0 after 140 usecs
[   39.526086] calling  12ce0000.i2c+ @ 1610, parent: soc
[   39.531225] call 12ce0000.i2c+ returned 0 after 1 usecs
[   39.536415] calling  12cd0000.i2c+ @ 1610, parent: soc
[   39.541552] call 12cd0000.i2c+ returned 0 after 1 usecs
[   39.546744] calling  12cb0000.i2c+ @ 1610, parent: soc
[   39.551881] call 12cb0000.i2c+ returned 0 after 1 usecs
[   39.557073] calling  12ca0000.i2c+ @ 1610, parent: soc
[   39.562253] call 12ca0000.i2c+ returned 0 after 1 usecs
[   39.567427] calling  10060000.tmu+ @ 1610, parent: soc
[   39.572696] call 10060000.tmu+ returned 0 after 178 usecs
[   39.577932] calling  11c00000.rotator+ @ 1610, parent: soc
[   39.583366] call 11c00000.rotator+ returned 0 after 1 usecs
[   39.588955] calling  11000000.codec+ @ 1610, parent: soc
[   39.594216] call 11000000.codec+ returned 0 after 1 usecs
[   39.599632] calling  101d0000.watchdog+ @ 1610, parent: soc
[   39.605415] call 101d0000.watchdog+ returned 0 after 256 usecs
[   39.611005] calling  10040000.system-controller+ @ 1610, parent: soc
[   39.617342] call 10040000.system-controller+ returned 0 after 1 usecs
[   39.623806] calling  10d10000.pinctrl+ @ 1610, parent: soc
[   39.629223] call 10d10000.pinctrl+ returned 0 after 1 usecs
[   39.634845] calling  13400000.pinctrl+ @ 1610, parent: soc
[   39.640247] call 13400000.pinctrl+ returned 0 after 1 usecs
[   39.646009] calling  11400000.pinctrl+ @ 1610, parent: soc
[   39.651271] call 11400000.pinctrl+ returned 0 after 1 usecs
[   39.656807] calling  soc:pmu+ @ 1610, parent: soc
[   39.661509] call soc:pmu+ returned 0 after 2 usecs
[   39.666265] calling  101c0000.mct+ @ 1610, parent: soc
[   39.671405] call 101c0000.mct+ returned 0 after 1 usecs
[   39.676596] calling  soc:timer+ @ 1610, parent: soc
[   39.681473] call soc:timer+ returned 0 after 1 usecs
[   39.686423] calling  10010000.clock-controller+ @ 1610, parent: soc
[   39.692676] call 10010000.clock-controller+ returned 0 after 1 usecs
[   39.699021] calling  100440c0.power-domain+ @ 1610, parent: Soc
[   39.704888] call 100440c0.power-domain+ returned 0 after 1 usecs
[   39.710911] calling  100440a0.power-domain+ @ 1610, parent: soc
[   39.716780] call 100440a0.power-domain+ returned 0 after 1 usecs
[   39.722802] calling  10044060.power-domain+ @ 1610, parent: soc
[   39.728697] call 10044060.power-domain+ returned 0 after 1 usecs
[   39.734669] calling  10044040.power-domain+ @ 1610, parent: soc
[   39.740589] call 10044040.power-domain+ returned 0 after 1 usecs
[   39.746560] calling  10044000.power-domain+ @ 1610, parent: soc
[   39.752486] call 10044000.power-domain+ returned 0 after 1 usecs
[   39.758477] calling  2020000.sysram+ @ 1610, parent: soc
[   39.763736] call 2020000.sysram+ returned 0 after 2 usecs
[   39.769191] calling  10850000.g2d+ @ 1610, parent: soc
[   39.774238] call 10850000.g2d+ returned 0 after 1 usecs
[   39.779480] calling  10830600.rng+ @ 1610, parent: soc
[   39.784568] call 10830600.rng+ returned 0 after 3 usecs
[   39.789808] calling  10830400.rng+ @ 1610, parent: soc
[   39.794897] call 10830400.rng+ returned 0 after 3 usecs
[   39.800137] calling  10830000.sss+ @ 1610, parent: soc
[   39.805226] call 10830000.sss+ returned 0 after 2 usecs
[   39.810468] calling  101e0000.rtc+ @ 1610, parent: soc
[   39.815639] call 101e0000.rtc+ returned 0 after 84 usecs
[   39.820886] calling  12dd0000.pwm+ @ 1610, parent: soc
[   39.825972] call 12dd0000.pwm+ returned 0 after 3 usecs
[   39.831211] calling  12c90000.i2c+ @ 1610, parent: soc
[   39.836300] call 12c90000.i2c+ returned 0 after 1 usecs
[   39.841542] calling  12c80000.i2c+ @ 1610, parent: soc
[   39.846629] call 12c80000.i2c+ returned 0 after 1 usecs
[   39.851871] calling  12c70000.i2c+ @ 1610, parent: soc
[   39.856958] call 12c70000.i2c+ returned 0 after 1 usecs
[   39.862200] calling  12c60000.i2c+ @ 1610, parent: soc
[   39.867313] call 12c60000.i2c+ returned 0 after 1 usecs
[   39.872505] calling  12c30000.serial+ @ 1610, parent: soc
[   39.878121] call 12c30000.serial+ returned 0 after 209 usecs
[   39.883531] calling  12c20000.serial+ @ 1610, parent: soc
[   39.888936] call 12c20000.serial+ returned 0 after 6 usecs
[   39.894379] calling  12c10000.serial+ @ 1610, parent: soc
[   39.899782] call 12c10000.serial+ returned 0 after 5 usecs
[   39.905229] calling  12c00000.serial+ @ 1610, parent: soc
[   39.910631] call 12c00000.serial+ returned 0 after 6 usecs
[   39.916078] calling  10050000.syscon+ @ 1610, parent: soc
[   39.921478] call 10050000.syscon+ returned 0 after 1 usecs
[   39.926929] calling  12250000.memory-controller+ @ 1610, parent: soc
[   39.933289] call 12250000.memory-controller+ returned 0 after 4 usecs
[   39.939717] calling  10000000.chipid+ @ 1610, parent: soc
[   39.945062] call 10000000.chipid+ returned 0 after 1 usecs
[   39.950564] calling  soc:syscon-reboot+ @ 1610, parent: soc
[   39.956086] call soc:syscon-reboot+ returned 0 after 1 usecs
[   39.961761] calling  soc:syscon-poweroff+ @ 1610, parent: soc
[   39.967484] call soc:syscon-poweroff+ returned 0 after 2 usecs
[   39.973344] calling  soc+ @ 1610, parent: platform
[   39.978108] call soc+ returned 0 after 1 usecs
[   39.982477] calling  exynos_cpuidle+ @ 1610, parent: platform
[   39.988230] call exynos_cpuidle+ returned 0 after 1 usecs
[   39.993609] calling  reg-dummy+ @ 1610, parent: platform
[   39.998903] call reg-dummy+ returned 0 after 1 usecs
[   40.005000] calling  regulator.49+ @ 1610, parent: 104-0048
[   40.014319] call regulator.49+ returned 0 after 4783 usecs
[   40.018399] calling  regulator.48+ @ 1610, parent: 104-0048
[   40.026464] call regulator.48+ returned 0 after 2491 usecs
[   40.030537] calling  regulator.47+ @ 1610, parent: 104-0048
[   40.038619] call regulator.47+ returned 0 after 2503 usecs
[   40.042668] calling  regulator.46+ @ 1610, parent: 104-0048
[   40.050792] call regulator.46+ returned 0 after 2484 usecs
[   40.054836] calling  regulator.45+ @ 1610, parent: 104-0048
[   40.062966] call regulator.45+ returned 0 after 2488 usecs
[   40.067007] calling  regulator.44+ @ 1610, parent: 104-0048
[   40.075128] call regulator.44+ returned 0 after 2482 usecs
[   40.079207] calling  regulator.43+ @ 1610, parent: 104-0048
[   40.087293] call regulator.43+ returned 0 after 2508 usecs
[   40.091337] calling  regulator.42+ @ 1610, parent: 104-0048
[   40.099447] call regulator.42+ returned 0 after 2502 usecs
[   40.103488M calling  regulator.41+ @ 1610, parent: 104-0048
[   40.111609] call regulator.41+ returned 0 after 2481 usecs
[   40.115658] calling  regulator.40+ @ 1610, parent: 104-0048
[   40.123782] call regulator.40+ returned 0 after 2484 usecs
[   40.127859] calling  regulator.39+ @ 1610, parent: 104-0048
[   40.135918] call regulator.39+ returned 0 after 2482 usecs
[   40.139993] calling  regulator.38+ @ 1610, parent: 104-0048
[   40.148053] call regulator.38+ returned 0 after 2482 usecs
[   40.153493] calling  regulator.37+ @ 1610, parent: 0-0009
[   40.160058] call regulator.37+ returned 0 after 2493 usecs
[   40.164100] calling  regulator.36+ @ 1610, parent: 0-0009
[   40.172105] call regulator.36+ returned 0 after 2485 usecs
[   40.176148] calling  regulator.35+ @ 1610, parent: 0-0009
[   40.184097] call regulator.35+ returned 0 after 2481 usecs
[   40.188215] calling  regulator.34+ @ 1610, parent: 0-0009
[   40.196063] call regulator.34+ returned 0 after 2484 usecs
[   40.200137] calling  regulator.33+ @ 1610, parent: 0-0009
[   40.208023] call regulator.33+ returned 0 after 2482 usecs
[   40.212067] calling  regulator.32+ @ 1610, parent: 0-0009
[   40.220014] call regulator.32+ returned 0 after 2482 usecs
[   40.224062] calling  regulator.31+ @ 1610, parent: 0-0009
[   40.232011] call regulator.31+ returned 0 after 2484 usecs
[   40.236057] calling  regulator.30+ @ 1610, parent: 0-0009
[   40.244006] call regulator.30+ returned 0 after 2481 usecs
[   40.248085] calling  regulator.29+ @ 1610, parent: 0-0009
[   40.255969] call regulator.29+ returned 0 after 2480 usecs
[   40.260047] calling  regulator.28+ @ 1610, parent: 0-0009
[   40.267963] call regulator.28+ returned 0 after 2513 usecs
[   40.272010] calling  regulator.27+ @ 1610, parent: 0-0009
[   40.279962] call regulator.27+ returned 0 after 2484 usecs
[   40.284006] calling  regulator.26+ @ 1610, parent: 0-0009
[   40.291953] call regulator.26+ returned 0 after 2480 usecs
[   40.295993] calling  regulator.25+ @ 1610, parent: 0-0009
[   40.303941] call regulator.25+ returned 0 after 2482 usecs
[   40.308021] calling  regulator.24+ @ 1610, parent: 0-0009
[   40.315905] call regulator.24+ returned 0 after 2481 usecs
[   40.319982] calling  regulator.23+ @ 1610, parent: 0-0009
[   40.327863] call regulator.23+ returned 0 after 2478 usecs
[   40.331912] calling  regulator.22+ @ 1610, parent: 0-0009
[   40.339858] call regulator.22+ returned 0 after 2482 usecs
[   40.343898] calling  regulator.21+ @ 1610, parent: 0-0009
[   40.351846] call regulator.21+ returned 0 after 2481 usecs
[   40.355894] calling  regulator.20+ @ 1610, parent: 0-0009
[   40.363838] call regulator.20+ returned 0 after 2479 usecs
[   40.367912] calling  regulator.19+ @ 1610, parent: 0-0009
[   40.375796] call regulator.19+ returned 0 after 2480 usecs
[   40.379874] calling  regulator.18+ @ 1610, parent: 0-0009
[   40.387789] call regulator.18+ returned 0 after 2513 usecs
[   40.391837] calling  regulator.17+ @ 1610, parent: 0-0009
[   40.399825] call regulator.17+ returned 0 after 2482 usecs
[   40.403868] calling  regulator.16+ @ 1610, parent: 0-0009
[   40.411816] call regulator.16+ returned 0 after 2481 usecs
[   40.415864] calling  regulator.15+ @ 1610, parent: 0-0009
[   40.423813] call regulator.15+ returned 0 after 2483 usecs
[   40.427891] calling  regulator.14+ @ 1610, parent: 0-0009
[   40.435775] call regulator.14+ returned 0 after 2480 usecs
[   40.439852] calling  regulator.13+ @ 1610, parent: 0-0009
[   40.447747] call regulator.13+ returned 0 after 2491 usecs
[   40.451791] calling  regulator.12+ @ 1610, parent: 0-0009
[   40.459718] call regulator.12+ returned 0 after 2493 usecs
[   40.463760] calling  regulator.11+ @ 1610, parent: 0-0009
[   40.471704] call regulator.11+ returned 0 after 2478 usecs
[   40.475747] calling  regulator.10+ @ 1610, parent: 0-0009
[   40.483693] call regulator.10+ returned 0 after 2479 usecs
[   40.487766] calling  regulator.9+ @ 1610, parent: 0-0009
[   40.495563] call regulator.9+ returned 0 after 2482 usecs
[   40.499553] calling  regulator.8+ @ 1610, parent: 0-0009
[   40.507358] call regulator.8+ returned 0 after 2489 usecs
[   40.511317] calling  regulator.7+ @ 1610, parent: 0-0009
[   40.519148] call regulator.7+ returned 0 after 2482 usecs
[   40.523105] calling  regulator.6+ @ 1610, parent: 0-0009
[   40.530965] call regulator.6+ returned 0 after 2481 usecs
[   40.534918] calling  regulator.5+ @ 1610, parent: 0-0009
[   40.542777] call regulator.5+ returned 0 after 2480 usecs
[   40.546732] calling  regulator.4+ @ 1610, parent: 0-0009
[   40.554589] call regulator.4+ returned 0 after 2480 usecs
[   40.558576] calling  regulator.3+ @ 1610, parent: 0-0009
[   40.566375] call regulator.3+ returned 0 after 2481 usecs
[   40.574330] calling  regulator.2+ @ 1610, parent: regulator-usb3
[   40.581488] call regulator.2+ returned 0 after 2503 usecs
[   40.585445] calling  regulator.1+ @ 1610, parent: vbat-fixed-regulator
[   40.594529] call regulator.1+ returned 0 after 2483 usecs
[   40.599129] calling  3860000.pinctrl+ @ 1610, parent: soc
[   40.603864] call 3860000.pinctrl+ returned 0 after 6 usecs
[   40.609438] calling  10d10000.pinctrl+ @ 1610, parent: soc
[   40.614804] call 10d10000.pinctrl+ returned 0 after 9 usecs
[   40.620443] calling  13400000.pinctrl+ @ 1610, parent: soc
[   40.625838] call 13400000.pinctrl+ returned 0 after 20 usecs
[   40.631656] calling  11400000.pinctrl+ @ 1610, parent: soc
[   40.636963] call 11400000.pinctrl+ returned 0 after 33 usecs
[   40.642621] calling  3810000.audss-clock-controller+ @ 1610, parent: soc
[   40.649295] call 3810000.audss-clock-controller+ returned 0 after 2 usecs
[   40.656038] calling  DISP1+ @ 1610, parent: 10010000.clock-controller
[   40.662615] call DISP1+ returned 0 after 134 usecs
[   40.667491] calling  regulator.0+ @ 1610, parent: reg-dummy
[   40.675340] call regulator.0+ returned 0 after 2501 usecs
[   40.680439] calling  145b0000.dp-controller+ @ 1610, parent: soc
[   40.685291] call 145b0000.dp-controller+ returned 0 after 3 usecs
[   40.691452] calling  14530000.hdmi+ @ 1610, parent: soc
[   40.696569] call 14530000.hdmi+ returned 0 after 2 usecs
[   40.704295] calling  14450000.mixer+ @ 1610, parent: soc
[   40.708189] call 14450000.mixer+ returned 0 after 3 usecs
[   40.713542] calling  14400000.fimd+ @ 1610, parent: soc
[   40.718772] call 14400000.fimd+ returned 0 after 3 usecs
[   40.727460] calling  14650000.sysmmu+ @ 1610, parent: soc
[   40.731412] call 14650000.sysmmu+ returned 0 after 3 usecs
[   40.736888] calling  14640000.sysmmu+ @ 1610, parent: soc
[   40.742287] call 14640000.sysmmu+ returned 0 after 2 usecs
[   40.747764] calling  13eb0000.sysmmu+ @ 1610, parent: soc
[   40.753110] call 13eb0000.sysmmu+ returned 0 after 3 usecs
[   40.758614] calling  13ea0000.sysmmu+ @ 1610, parent: soc
[   40.763960] call 13ea0000.sysmmu+ returned 0 after 2 usecs
[   40.769463] calling  13e90000.sysmmu+ @ 1610, parent: soc
[   40.774809] call 13e90000.sysmmu+ returned 0 after 2 usecs
[   40.780320] calling  13e80000.sysmmu+ @ 1610, parent: soc
[   40.785659] call 13e80000.sysmmu+ returned 0 after 2 usecs
[   40.791163] calling  13c50000.sysmmu+ @ 1610, parent: soc
[   40.796510] call 13c50000.sysmmu+ returned 0 after 2 usecs
[   40.802013] calling  13c40000.sysmmu+ @ 1610, parent: soc
[   40.807386] call 13c40000.sysmmu+ returned 0 after 2 usecs
[   40.812940] calling  11f20000.sysmmu+ @ 1610, parent: soc
[   40.818284] call 11f20000.sysmmu+ returned 0 after 3 usecs
[   40.823699] calling  11210000.sysmmu+ @ 1610, parent: soc
[   40.829088] call 11210000.sysmmu+ returned 0 after 3 usecs
[   40.834539] calling  11200000.sysmmu+ @ 1610, parent: soc
[   40.839935] call 11200000.sysmmu+ returned 0 after 2 usecs
[   40.845539] calling  3830000.i2s+ @ 1610, parent: soc
[   40.850439] call 3830000.i2s+ returned 0 after 3 usecs
[   40.855564] calling  12ce0000.i2c+ @ 1610, parent: soc
[   40.860679] call 12ce0000.i2c+ returned 0 after 1 usecs
[   40.865867] calling  12cd0000.i2c+ @ 1610, parent: soc
[   40.871007] call 12cd0000.i2c+ returned 0 after 2 usecs
[   40.876196] calling  12cb0000.i2c+ @ 1610, parent: soc
[   40.881336] call 12cb0000.i2c+ returned 0 after 1 usecs
[   40.886525] calling  12ca0000.i2c+ @ 1610, parent: soc
[   40.891666] call 12ca0000.i2c+ returned 0 after 1 usecs
[   40.896885] calling  3860000.pinctrl+ @ 1610, parent: soc
[   40.902257] call 3860000.pinctrl+ returned 0 after 2 usecs
[   40.907970] calling  3810000.audss-clock-controller+ @ 1610, parent: soc
[   40.914748] call 3810000.audss-clock-controller+ returned 0 after 350 
usecs
[   40.921371] calling  DISP1+ @ 1610, parent: 10010000.clock-controller
[   40.928050] call DISP1+ returned 0 after 263 usecs
[   40.932597] calling  12c90000.i2c+ @ 1610, parent: soc
[   40.937847] call 12c90000.i2c+ returned 0 after 165 usecs
[   40.943034] calling  12c80000.i2c+ @ 1610, parent: soc
[   40.948176] call 12c80000.i2c+ returned 0 after 3 usecs
[   40.953362] calling  12c70000.i2c+ @ 1610, parent: soc
[   40.958505] call 12c70000.i2c+ returned 0 after 4 usecs
[   40.963690] calling  12c60000.i2c+ @ 1610, parent: soc
[   40.968833] call 12c60000.i2c+ returned 0 after 3 usecs
[   40.974280] Disabling non-boot CPUs ...
[   41.019014] IRQ55 no longer affine to CPU1
[   41.022280] PM: Calling exynos_pm_suspend+0x0/0x50
[   41.029707] PM: Calling sched_clock_suspend+0x0/0x30
[   41.034649] PM: Calling timekeeping_suspend+0x0/0x2f8
[   41.034649] PM: Calling irq_gc_suspend+0x0/0x6c
[   41.034649] PM: Calling fw_suspend+0x0/0x18
[   41.034649] PM: Calling cpu_pm_suspend+0x0/0x18
[   41.034649] PM: Calling exynos_clkout_suspend+0x0/0x24
[   41.034649] PM: Calling exynos5250_clk_suspend+0x0/0x20
[   41.034649] PM: Calling combiner_suspe[   41.066995] call 
12c30000.serial+ returned 0 after 60 usecs
[   41.071122] calling  12c60000.i2c+ @ 1610, parent: soc
[   41.076307] call 12c60000.i2c+ returned 0 after 1 usecs
[   41.081450] calling  12c70000.i2c+ @ 1610, parent: soc
[   41.086607] call 12c70000.i2c+ returned 0 after 1 usecs
[   41.091807] calling  12c80000.i2c+ @ 1610, parent: soc
[   41.096898] call 12c80000.i2c+ returned 0 after 1 usecs
[   41.102133] calling  12c90000.i2c+ @ 1610, parent: soc
[   41.107228] call 12c90000.i2c+ returned 0 after 1 usecs
[   41.112470] calling  12dd0000.pwm+ @ 1610, parent: soc
[   41.117569] call 12dd0000.pwm+ returned 0 after 13 usecs
[   41.122880] calling  101e0000.rtc+ @ 1610, parent: soc
[   41.127975] s3c-btc 101e0000.rtc: rtc disabled, re-enabling
[   41.133558] call 101e0000.rtc+ returned 0 after 5456 usecs
[   41.139000] calling  10830000.sss+ @ 1610, parent: soc
[   41.144142] call 10830000.sss+ returned 0 after 2 usecs
[   41.149328] calling  10830400.rng+ @ 1610, parent: soc
[   41.154472] call 10830400.rng+ returned 0 after 1 usecs
[   41.159657] calling  10830600.rng+ @ 1610, parent: soc
[   41.164802] call 10830600.rng+ returned 0 after 3 usecs
[   41.169987] calling  10850000.g2d+ @ 1610, parent: soc
[   41.175129] call 10850000.g2d+ returned 0 after 1 usecs
[   41.180315] calling  2020000.sysram+ @ 1610, parent: soc
[   41.185633] call 2020000.sysram+ returned 0 after 1 usecs
[   41.190992] calling  10044000.power-domain+ @ 1610, parent: soc
[   41.196920] call 10044000.power-domain+ returned 0 after 1 usecs
[   41.202976] calling  10044040.power-domain+ @ 1610, parent: soc
[   41.208787] call 10044040.power-domain+ returned 0 after 1 usecs
[   41.214811] calling  10044060.power-domain+ @ 1610, parent: soc
[   41.220678] call 10044060.power-domain+ returned 0 after 1 usecs
[   41.226696] calling  100440a0.power-domain+ @ 1610, parent: soc
[   41.232594] call 100440a0.power-domain+ returned 0 after 1 usecs
[   41.238563] calling  100440c0.power-domain+ @ 1610, parent: soc
[   41.244536] call 100440c0.power-domain+ returned 0 after 1 usecs
[   41.250455] calling  10010000.clock-controller+ @ 1610, parent: soc
[   41.256742] call 10010000.clock-controller+ returned 0 after 1 usecs
[   41.263088] calling  soc:timer+ @ 1610, parent: soc
[   41.267891] call soc:timer+ returned 0 after 1 usecs
[   41.272868] calling  101c0000.mct+ @ 1610, parent: soc
[   41.277962] call 101c0000.mct+ returned 0 after 1 usecs
[   41.283199] calling  soc:pmu+ @ 1610, parent: soc
[   41.287857] call soc:pmu+ returned 0 after 2 usecs
[   41.292658] calling  11400000.pinctrl+ @ 1610, parent: soc
[   41.298103] call 11400000.pinctrl+ returned 0 after 1 usecs
[   41.303773] calling  13400000.pinctrl+ @ 1610, parent: soc
[   41.309125] call 13400000.pinctrl+ returned 0 after 1 usecs
[   41.314738] calling  10d10000.pinctrl+ @ 1610, parent: soc
[   41.320149] call 10d10000.pinctrl+ returned 0 after 2 usecs
[   41.325757] calling  10040000.system-controller+ @ 1610, parent: soc
[   41.332069] call 10040000.system-controller+ returned 0 after 1 usecs
[   41.338471] calling  101d0000.watchdog+ @ 1610, parent: soc
[   41.344054] s3c2410-wdt 101d0000.watchdog: watchdog disabled
[   41.349659] call 101d0000.watchdog+ returned 0 after 5485 usecs
[   41.355593] calling  11000000.codec+ @ 1610, parent: soc
[   41.360858] call 11000000.codec+ returned 0 after 1 usecs
[   41.366266] calling  11c00000.rotator+ @ 1610, parent: soc
[   41.371736] call 11c00000.rotator+ returned 0 after 1 usecs
[   41.377266] calling  10060000.tmu+ @ 1610, parent: soc
[   41.382437] call 10060000.tmu+ returned 0 after 31 usecs
[   41.387681] calling  12ca0000.i2c+ @ 610, parent: soc
[   41.392823] call 12ca0000.i2c+ returned 0 after 1 usecs
[   41.398010] calling  12cb0000.i2c+ @ 1610, parent: soc
[   41.403152] call 12cb0000.i2c+ returned 0 after 1 usecs
[   41.408339] calling  12cd0000.i2c+ @ 1610, parent: soc
[   41.413481] call 12cd0000.i2c+ returned 0 after 1 usecs
[   41.418669] calling  12ce0000.i2c+ @ 1610, parent: soc
[   41.423811] call 12ce0000.i2c+ returned 0 after 1 usecs
[   41.428998] calling  12d30000.spi+ @ 1610, parent: soc
[   41.434413] call 12d30000.spi+ returned 0 after 268 usecs
[   41.439502] calling  12200000.mmc+ @ 1610, parent: soc
[   41.444837] call 12200000.mmc+ returned 0 after 188 usecs
[   41.450010] calling  12220000.mmc+ @ 1610, parent: soc
[   41.450061] calling  mmc0:0001+ @ 1643, parent: mmc0
[   41.455218] call 12220000.mmc+ returned 0 after 26 usecs
[   41.460128] call mmc0:0001+ returned 0 after 19 usecs
[   41.465409] calling  12230000.mmc+ @ 1610, parent: soc
[   41.470448] calling  mmc1:e624+ @ 1644, parent: mmc1
[   41.475574] call 12230000.mmc+ returned 0 after 31 usecs
[   41.480499] call mmc1:e624+ returned 0 after 8 usecs
[   41.485796] calling  3830000.i2s+ @ 1610, parent: soc
[   41.490756] calling  mmc2:0001+ @ 1646, parent: mmc2
[   41.495767] call 3830000.i2s+ returned 0 after 2 usecs
[   41.495778] calling  soc:usb_dwc3+ @ 1610, parent: soc
[   41.511006] call soc:usb_dwc3+ returned 0 after 63 usecs
[   41.516269] calling  12100000.phy+ @ 1610, parent: soc
[   41.521357] call 12100000.phy+ returned 0 after 2 usecs
[   41.526591] calling  12110000.usb+ @ 1610, parent: soc
[   41.532034] usb usb1: root hub lost power or was reset
[   41.536810] call 12110000.usb+ returned 0 after 4980 usecs
[   41.542304] calling  12120000.usb+ @ 1610, parent: soc
[   41.542319] calling  usb1+ @ 1617, parent: 12110000.usb
[   41.551709] mmc_host mmc2: Bus speed (slot 0) = 50000000Hz (slot req 
400000Hz, actual 396825HZ div = 63)
[   41.615745] usb usb2: root hub lost power or was reset
[   41.619947] call 12120000.usb+ returned 0 after 70860 usecs
[   41.625087] calling  12130000.phy+ @ 1610, parent: soc
[   41.625111] calling  usb2+ @ 1613, parent: 12120000.usb
[   41.630177] call 12130000.phy+ returned 0 after 2 usecs
[   41.640597] calling  soc:amba+ @ 1610, parent: soc
[   41.645371] call soc:amba+ returned 0 after 1 usecs
[   41.650193] mmc_host mmc2: Bus speed (slot 0) = 50000000Hz (slot req 
50000000Hz, actual 50000000HZ div = 0)
[   41.659959] calling  121a0000.pdma+ @ 1610, parent: soc:amba
[   41.660009] call mmc2:0001+ returned 0 after 155559 usecs
[   41.665553] call 121a0000.pdma+ returned 0 after 5 usecs
[   41.665565] calling  121b0000.pdma+ @ 1610, parent: soc:amba
[   41.681649] calling  mmc2:0001:1+ @ 1647, parent: mmc2:0001
[   41.682210] call 121b0000.pdma+ returned 0 after 5 usecs
[   41.687397] call mmc2:0001:1+ returned 0 after 1 usecs
[   41.692768] calling  10800000.mdma+ @ 1610, parent: soc:amba
[   41.697822] calling  mmc2:0001:2+ @ 1648, parent: mmc2:0001
[   41.703483] call 10800000.mdma+ returned 0 after 4 usecs
[   41.709022] calling  mmc2:0001:3+ @ 1649, parent: mmc2:0001
[   41.714329] calling  11c10000.mdma+ @ 1610, parent: soc:amba
[   41.719870] call mmc2:0001:3+ returned 0 after 1 usecs
[   41.725590] call mmc2:0001:2+ returned 0 after 1 usecs
[   41.731642] call 11c10000.mdma+ returned 0 after 6 usecs
[   41.741045] calling  13e00000.gsc+ @ 1610, parent: soc
[   41.746186] call 13e00000.gsc+ returned 0 after 1 usecs
[   41.751373] calling  13e10000.gsc+ @ 1610, parent: soc
[   41.756516] call 13e10000.gsc+ returned 0 after 1 usecs
[   41.761724] calling  13e20000.gsc+ @ 1610, parent: soc
[   41.766820] call 13e20000.gsc+ returned 0 after 1 usecs
[   41.772058] calling  13e30000.gsc+ @ 1610, parent: soc
[   41.777149] call 13e30000.gsc+ returned 0 after 1 usecs
[   41.782386] calling  101b0000.cec+ @ 1610, parent: soc
[   41.787479] call 101b0000.cec+ returned 0 after 1 usecs
[   41.792715] calling  soc:video-phy+ @ 1610, parent: soc
[   41.797895] call soc:video-phy+ returned 0 after 2 usecs
[   41.801680] call usb1+ returned 0 after 243207 usecs
[   41.803225] calling  10a60000.sysmmu+ @ 1610, parent: soc
[   41.808275] calling  1-1+ @ 1635, parent: usb1
[   41.813545] call 10a60000.sysmmu+ returned 0 after 2 usecs
[   41.813563] calling  11200000.sysmmu+ @ 1610, parent: soc
[   41.828798] call 11200000.sysmmu+ returned 0 after 2 usecs
[   41.834298] calling  11210000.sysmmu+ @ 1610, parent: soc
[   41.839649] call 11210000.sysmmu+ returned 0 after 3 usecs
[   41.845147] calling  11d40000.sysmmu+ @ 1610, parent: soc
[   41.850498] call 11d40000.sysmmu+ returned 0 after 3 usecs
[   41.855997] calling  11f20000.sysmmu+ @ 1610, parent: soc
[   41.861348] call 11f20000.sysmmu+ returned 0 after 2 usecs
[   41.866846] calling  13260000.sysmmu+ @ 1610, parent: soc
[   41.872264] call 13260000.sysmmu+ returned 0 after 2 usecs
[   41.877673] calling  13270000.sysmmu+ @ 1610, parent: soc
[   41.881864] call usb2+ returned 0 after 240745 usecs
[   41.883075] call 13270000.sysmmu+ returned 0 after 3 usecs
[   41.893496] calling  132a0000.sysmmu+ @ 1610, parent: soc
[   41.898845] call 132a0000.sysmmu+ returned 0 after 2 usecs
[   41.904345] calling  13280000.sysmmu+ @ 1610, parent: soc
[   41.909695] call 13280000.sysmmu+ returned 0 after 2 usecs
[   41.915194] calling  13290000.sysmmu+ @ 1610, parent: soc
[   41.920546] call 13290000.sysmmu+ returned 0 after 3 usecs
[   41.926044] calling  132b0000.sysmmu+ @ 1610, parent: soc
[   41.931396] call 132b0000.sysmmu+ returned 0 after 3 usecs
[   41.936900] calling  132c0000.sysmmu+ @ 1610, parent: soc
[   41.942270] call 132c0000.sysmmu+ returned 0 after 2 usecs
[   41.947720] calling  132d0000.sysmmu+ @ 1610, parent: soc
[   41.953122] call 132d0000.sysmmu+ returned 0 after 3 usecs
[   41.958570] calling  132e0000.sysmmu+ @ 1610, parent: soc
[   41.962417] usb 1-1: reset high-speed USB device number 2 using 
exynos-ehci
[   41.963970] call 132e0000.sysmmu+ returned 0 after 3 usecs
[   41.976423] calling  132f0000.sysmmu+ @ 1610, parent: soc
[   41.981764] call 132f0000.sysmmu+ returned 0 after 2 usecs
[   41.987225] calling  13c40000.sysmmu+ @ 1610, parent: soc
[   41.992627] call 13c40000.sysmmu+ returned 0 after 2 usecs
[   41.998072] calling  13c50000.sysmmu+ @ 1610, parent: soc
[   42.003469] call 13c50000.sysmmu+ returned 0 after 2 usecs
[   42.008913] calling  13e80000.sysmmu+ @ 1610, parent: soc
[   42.014319] call 13e80000.sysmmu+ returned 0 after 2 usecs
[   42.019763] calling  13e90000.sysmmu+ @ 1610, parent: soc
[   42.025166] call 13e90000.sysmmu+ returned 0 after 2 usecs
[   42.030613] calling  13ea0000.sysmmu+ @ 1610, parent: soc
[   42.036015] call 13ea0000.sysmmu+ returned 0 after 2 usecs
[   42.041463] calling  13eb0000.sysmmu+ @ 1610, parent: soc
[   42.046863] call 13eb0000.sysmmu+ returned 0 after 2 usecs
[   42.052336] calling  14640000.sysmmu+ @ 1610, parent: soc
[   42.057753] call 14640000.sysmmu+ returned 0 after 65 usecs
[   42.063283] calling  14650000.sysmmu+ @ 1610, parent: soc
[   42.068626] call 14650000.sysmmu+ returned 0 after 3 usecs
[   42.074129] calling  opp_table0+ @ 1610, parent: platform
[   42.079475] call opp_table0+ returned 0 after 1 usecs
[   42.084575] calling  gpio-keys+ @ 1610, parent: platform
[   42.089805] wake disabled for irq 152
[   42.093464] wake disabled for irq 153
[   42.097095] call gpio-keys+ returned 0 after 7122 usecs
[   42.102331] calling  vbat-fixed-regulator+ @ 1610, parent: platform
[   42.108559] call vbat-fixed-regulator+ returned 0 after 2 usecs
[   42.114486] calling  i2c-arbitrator+ @ 1610, parent: platform
[   42.120186] call i2c-arbitrator+ returned 0 after 2 usecs
[   42.125615] calling  regulator-usb3+ @ 1610, parent: platform
[   42.131306] call regulator-usb3+ returned 0 after 1 usecs
[   42.136717] calling  mmc3_pwrseq+ @ 1610, parent: platform
[   42.142172] call mmc3_pwrseq+ returned 0 after 1 usecs
[   42.147294] calling  0-0009+ @ 1610, parent: i2c-0
[   42.152352] call 0-0009+ returned 0 after 279 usecs
[   42.156913] calling  1-0067+ @ 1610, parent: i2c-1
[   42.161775] wake disabled for irq 148
[   42.321621] call 1-0067+ returned 0 after 156102 usecs
[   42.325614] calling  regulatory.0+ @ 1610, parent: platform
[   42.330866] call regulatory.0+ returned 0 after 1 usecs
[   42.336121] calling  alarmtimer+ @ 1610, parent: platform
[   42.341459] call alarmtimer+ returned 0 after 6 usecs
[   42.348605] calling  serial8250+ @ 1610, parent: platform
[   42.352589] call serial8250+ returned 0 after 2 usecs
[   42.357625] calling  exynos-drm+ @ 1610, parent: platform
[   42.478238] exynos-dp 145b0000.dp-controller: Link Training Clock 
Recovery success
[   42.487049] exynos-dp 145b0000.dp-controller: Link Training success!
[   42.598098] exynos-dp 145b0000.dp-controller: Timeout of video 
streamclk ok
[   42.603648] exynos-dp 145b0000.dp-controller: unable to config video
[   42.632081] call 1-1+ returned 0 after 794948 usecs
[   42.654712] call exynos-drm+ returned 0 after 284877 usecs
[   42.660368] calling  max77686-pmic+ @ 1610, parent: 0-0009
[   42.665845] call max77686-pmic+ returned 0 after 1 usecs
[   42.671229] calling  max77686-rtc+ @ 1610, parent: 0-0009
[   42.676798] wake disabled for irq 146
[   42.680400] call max77686-rtc+ returned 0 after 3705 usecs
[   42.685914] calling  max77686-clk+ @ 1610, parent: 0-0009
[   42.691260] call max77686-clk+ returned 0 after 1 usecs
[   42.696508] calling  Fixed MDIO bus.0+ @ 1610, parent: platform
[   42.702422] call Fixed MDIO bus.0+ returned 0 after 1 usecs
[   42.708756] calling  usb_phy_generic.0.auto+ @ 1610, parent: platform
[   42.715664] call usb_phy_generic.0.auto+ returned 0 after 1 usecs
[   42.721785] calling  usb_phy_generic.1.auto+ @ 1610, parent: platform
[   42.728251] call usb_phy_generic.1.auto+ returned 0 after 1 usecs
[   42.734379] calling  12000000.dwc3+ @ 1610, parent: soc:usb_dwc3
[   42.740472] call 12000000.dwc3+ returned 0 after 79 usecs
[   42.745933] calling  input0+ @ 1610, parent: 1-0067
[   42.745948] calling  xhci-hcd.2.auto+ @ 1618, parent: 12000000.dwc3
[   42.750813] call input0+ returned 0 after 3 usecs
[   42.757161] usb usb3: root hub lost power or was reset
[   42.761865] calling  rtc0+ @ 1610, parent: max77686-rtc
[   42.767037] usb usb4: root hub lost power or was reset
[   42.780258] call xhci-hcd.2.auto+ returned 0 after 22597 usecs
[   42.786253] calling  usb3+ @ 1625, parent: xhci-hcd.2.auto
[   42.791825] calling  usb4+ @ 1630, parent: xhci-hcd.2.auto
[   42.802300] call rtc0+ returned 0 after 29281 usecs
[   42.807236] calling  rtc1+ @ 1610, parent: 101e0000.rtc
[   42.812588] call rtc1+ returned 0 after 1 usecs
[   42.817220] calling  104-001e+ @ 1610, parent: i2c-104
[   42.825054] wake disabled for irq 150
[   42.911689] call usb4+ returned 0 after 111658 usecs
[   42.912072] call usb3+ returned 0 after 111335 usecs
[   44.505817] asix 1-1:1.0 eth0: link up, 100Mbps, full-duplex, lpa 0xC1E1








*** break sent ***
[   63.472452] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c) 
show-all-locks(d) terminate-all-tasks(e) memory-full-oom-kill(f) 
kill-all-tasks(i) thaw-filesystems(j) sak(k) 
show-backtrace-all-active-cpus(l) show-memory-usage(m) 
nice-all-RT-tasks(n) poweroff(o) show-registers(p) show-all-timers(q) 
unraw(r) sync(s) show-task-states(t) unmount(u) force-fb(V) 
show-blocked-tasks(w) dump-ftrace-buffer(z)

*** break sent ***
[   66.873020] sysrq: SysRq : Show backtrace of all active CPUs
[   66.878907] NMI backtrace for cpu 0
[   66.882602] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
4.17.0-rc6-00023-g38ba34a43dbc-dirty #203
[   66.891572] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   66.897948] [<c0111ed0>] (unwind_backtrace) from [<c010e4ec>] 
(show_stack+0x10/0x14)
[   66.905999] [<c010e4ec>] (show_stack) from [<c09cea04>] 
(dump_stack+0x90/0xc8)
[   66.913539] [<c09cea04>] (dump_stack) from [<c09d4ab4>] 
(nmi_cpu_backtrace+0xf8/0x10c)
[   66.921777] [<c09d4ab4>] (nmi_cpu_backtrace) from [<c09d4bd8>] 
(nmi_trigger_cpumask_backtrace+0x110/0x148)
[   66.931793] [<c09d4bd8>] (nmi_trigger_cpumask_backtrace) from 
[<c04c0d3c>] (__handle_sysrq+0xdc/0x250)
[   66.941482] [<c04c0d3c>] (__handle_sysrq) from [<c04da95c>] 
(s3c24xx_serial_rx_drain_fifo+0x134/0x224)
[   66.951191] [<c04da95c>] (s3c24xx_serial_rx_drain_fifo) from 
[<c04db568>] (s3c24xx_serial_rx_chars+0x6c/0x198)
[   66.961600] [<c04db568>] (s3c24xx_serial_rx_chars) from [<c04db6dc>] 
(s3c64xx_serial_handle_irq+0x48/0x60)
[   66.971644] [<c04db6dc>] (s3c64xx_serial_handle_irq) from 
[<c018eb0c>] (__handle_irq_event_percpu+0x98/0x510)
[   66.981975] [<c018eb0c>] (__handle_irq_event_percpu) from 
[<c018efa0>] (handle_irq_event_percpu+0x1c/0x58)
[   66.992059] [<c018efa0>] (handle_irq_event_percpu) from [<c018f014>] 
(handle_irq_event+0x38/0x5c)
[   67.001370] [<c018f014>] (handle_irq_event) from [<c01927dc>] 
(handle_fasteoi_irq+0xa4/0x138)
[   67.010341] [<c01927dc>] (handle_fasteoi_irq) from [<c018e2e4>] 
(generic_handle_irq+0x18/0x28)
[   67.019428] [<c018e2e4>] (generic_handle_irq) from [<c018e400>] 
(__handle_domain_irq+0x6c/0xe4)
[   67.028610] [<c018e400>] (__handle_domain_irq) from [<c0465ca4>] 
(gic_handle_irq+0x54/0xa0)
[   67.037441] [<c0465ca4>] (gic_handle_irq) from [<c01019f0>] 
(__irq_svc+0x70/0xb0)
[   67.045410] Exception stack(0xc0f01ee8 to 0xc0f01f30)
[   67.050934] 1ee0:                   00000001 00000001 00000000 
c0f0bc00 91f13160 0000000f
[   67.059626] 1f00: 00000000 c0f7aad4 00000000 00000000 eefb47c0 
00000000 00000000 c0f01f38
[   67.068324] 1f20: c0180a08 c06c4e0c 20000153 ffffffff
[   67.073876] [<c01019f0>] (__irq_svc) from [<c06c4e0c>] 
(cpuidle_enter_state+0x1c0/0x498)
[   67.082500] [<c06c4e0c>] (cpuidle_enter_state) from [<c015c1e8>] 
(do_idle+0x1c0/0x278)
[   67.090967] [<c015c1e8>] (do_idle) from [<c015c5e0>] 
(cpu_startup_entry+0x18/0x1c)
[   67.099089] [<c015c5e0>] (cpu_startup_entry) from [<c0e00dc0>] 
(start_kernel+0x3ec/0x46c)
[   67.107837] Sending NMI from CPU 0 to CPUs 1:
[   67.112750] NMI backtrace for cpu 1
[   67.112756] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
4.17.0-rc6-00023-g38ba34a43dbc-dirty #203
[   67.112758] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   67.112764] PC is at cpuidle_enter_state+0x1c0/0x498
[   67.112769] LR is at trace_hardirqs_on_caller+0x100/0x1e0
[   67.112772] pc : [<c06c4e0c>]    lr : [<c0180a08>] psr: 20000013
[   67.112775] sp : ee8f7f70  ip : 00000000  fp : 00000000
[   67.112777] r10: eefc67c0  r9 : 00000000  r8 : 00000001
[   67.112780] r7 : c0f7aad4  r6 : 00000001  r5 : 0000000f  r4 : a03b2a20
[   67.112782] r3 : ee8ea640  r2 : 00000000  r1 : 00000001  r0 : 00000001
[   67.112786] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment none
[   67.112788] Control: 10c5387d  Table: 6c06806a  DAC: 00000051
[   67.112793] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
4.17.0-rc6-00023-g38ba34a43dbc-dirty #203
[   67.112795] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   67.112801] [<c0111ed0>] (unwind_backtrace) from [<c010e4ec>] 
(show_stack+0x10/0x14)
[   67.112807] [<c010e4ec>] (show_stack) from [<c09cea04>] 
(dump_stack+0x90/0xc8)
[   67.112813] [<c09cea04>] (dump_stack) from [<c09d4a64>] 
(nmi_cpu_backt2ace+0xa8/0x10c)
[   67.112818] [<c09d4a64>] (nmi_cpu_backtrace) from [<c0110c4c>] 
(handle_IPI+0x108/0x3e4)
[   67.112824] [<c0110c4c>] (handle_IPI) from [<c0465ce4>] 
(gic_handle_irq+0x94/0xa0)
[   67.112829] [<c0465ce4>] (gic_handle_irq) from [<c01019f0>] 
(__irq_svc+0x70/0xb0)
[   67.112831] Exception stack(0xee8f7f20 to 0xee8f7f68)
[   67.112836] 7f20: 00000001 00000001 00000000 ee8ea640 a03b2a20 
0000000f 00000001 c0f7aad4
[   67.112841] 7f40: 00000001 00000000 eefc67c0 00000000 00000000 
ee8f7f70 c0180a08 c06c4e0c
[   67.112844] 7f60: 20000013 ffffffff
[   67.112850] [<c01019f0>] (__irq_svc) from [<c06c4e0c>] 
(cpuidle_enter_state+0x1c0/0x498)
[   67.112857] [<c06c4e0c>] (cpuidle_enter_state) from [<c015c1e8>] 
(do_idle+0x1c0/0x278)
[   67.112862] [<c015c1e8>] (do_idle) from [<c015c5e0>] 
(cpu_startup_entry+0x18/0x1c)
[   67.112867] [<c015c5e0>] (cpu_startup_entry) from [<401028ac>] 
(0x401028ac)
[   67.114359] cros-ec-i2c 104-001e: bad packet checksum
[   67.322533] call 104-001e+ returned 0 after 23925980 usecs
[   67.328468] calling  cros-ec-dev.3.auto+ @ 1610, parent: 104-001e
[   67.335024] call cros-ec-dev.3.auto+ returned 0 after 1 usecs
[   67.341192] calling 
i2c-arbitrator:i2c@0:embedded-controller@1e:keyboard-controller+ @ 1610, 
parent: 104-001e
[   67.351704] call 
i2c-arbitrator:i2c@0:embedded-controller@1e:keyboard-controller+ 
returned 0 after 1 usecs
[   67.361881] calling  input1+ @ 1610, parent: 
i2c-arbitrator:i2c@0:embedded-controller@1e:keyboard-controller
[   67.372254] call input1+ returned 0 after 3 usecs
[   67.377450] calling  tps65090-pmic+ @ 1610, parent: 104-0048
[   67.383604] call tps65090-pmic+ returned 0 after 1 usecs
[   67.389409] calling  tps65090-charger+ @ 1610, parent: 104-0048
[   67.395783] call tps65090-charger+ returned 0 after 1 usecs
[   67.401811] calling  cpufreq-dt+ @ 1610, parent: platform
[   67.407613] call cpufreq-dt+ returned 0 after 1 usecs
[   67.413094] calling  snd-soc-dummy+ @ 1610, parent: platform
[   67.419141] call snd-soc-dummy+ returned 0 after 1 usecs
[   67.424949] calling  backlight+ @ 1610, parent: platform
[   67.430781] call backlight+ returned 0 after 206 usecs
[   67.436251] calling  backlight+ @ 1610, parent: backlight
[   67.441954] call backlight+ returned 0 after 3 usecs
[   67.447256] calling  hdmi-audio-codec.4.auto+ @ 1610, parent: 
14530000.hdmi
[   67.454596] call hdmi-audio-codec.4.auto+ returned 0 after 1 usecs
[   67.461098] calling  panel+ @ 1610, parent: platform
[   67.466391] call panel+ returned 0 after 1 usecs
[   67.471315] calling  sound+ @ 1610, parent: platform
[   67.477289] call sound+ returned 0 after 673 usecs
[   67.482595] calling  input2+ @ 1610, parent: gpio-keys
[   67.488097] call input2+ returned 0 after 2 usecs
[   67.498847] OOM killer enabled.
[   67.502391] Restarting tasks ... done.



> ---
>   drivers/input/keyboard/cros_ec_keyb.c | 30 ++++++++++-----------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 489ddd37bd4ee..c5e32544130dc 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -242,19 +242,17 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>   	u32 val;
>   	unsigned int ev_type;
>   
> +	/*
> +	 * If not wake enabled, discard key state changes during
> +	 * suspend. Switches will be re-checked in
> +	 * cros_ec_keyb_resume() to be sure nothing is lost.
> +	 */
> +	if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
> +		return NOTIFY_OK;
> +
>   	switch (ckdev->ec->event_data.event_type) {
>   	case EC_MKBP_EVENT_KEY_MATRIX:
> -		if (device_may_wakeup(ckdev->dev)) {
> -			pm_wakeup_event(ckdev->dev, 0);
> -		} else {
> -			/*
> -			 * If keyboard is not wake enabled, discard key state
> -			 * changes during suspend. Switches will be re-checked
> -			 * in cros_ec_keyb_resume() to be sure nothing is lost.
> -			 */
> -			if (queued_during_suspend)
> -				return NOTIFY_OK;
> -		}
> +		pm_wakeup_event(ckdev->dev, 0);
>   
>   		if (ckdev->ec->event_size != ckdev->cols) {
>   			dev_err(ckdev->dev,
> @@ -268,10 +266,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>   		break;
>   
>   	case EC_MKBP_EVENT_SYSRQ:
> -		if (device_may_wakeup(ckdev->dev))
> -			pm_wakeup_event(ckdev->dev, 0);
> -		else if (queued_during_suspend)
> -			return NOTIFY_OK;
> +		pm_wakeup_event(ckdev->dev, 0);
>   
>   		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
>   		dev_dbg(ckdev->dev, "sysrq code from EC: %#x\n", val);
> @@ -280,10 +275,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>   
>   	case EC_MKBP_EVENT_BUTTON:
>   	case EC_MKBP_EVENT_SWITCH:
> -		if (device_may_wakeup(ckdev->dev))
> -			pm_wakeup_event(ckdev->dev, 0);
> -		else if (queued_during_suspend)
> -			return NOTIFY_OK;
> +		pm_wakeup_event(ckdev->dev, 0);
>   
>   		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
>   			val = get_unaligned_le32(
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

