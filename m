Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8208BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4547E2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="do+Ser1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBGVtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:49:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35530 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBGVtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:49:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so2578524otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HpbWs3SGuuisYZyAXBqdfsNKXEXuWUO5Aix3+N9r7TE=;
        b=do+Ser1IpL6fn/pFcgRzquGFenZCwUcY4uJ7IbzLmAI4tw21ztxZPLmkTY5xCkH4tp
         YyH+YtbQYAEekdNx+18i4yaTEqThu8gcVe7Qm6b9PAloZJMr7HR8dde6/SWKgsU7bg6t
         lSEc1s4B4LRAbKjG0omJaObA2c99c9oSNWBnYqFxJOiA2dQkX4E6oms0JIZcW/Budc5N
         vwQbcUWyfOkv47Daa4jU1CFkSNzAx9H1y2mWLLYyjRJNZqWBwbmxnydLqYjrChYElmr3
         7GITFkoCILkDBr/zBQLGotuZntISKvguc36gpMGZEucVBKIMi9U0hCtHDOkZbKTFbCx+
         INQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HpbWs3SGuuisYZyAXBqdfsNKXEXuWUO5Aix3+N9r7TE=;
        b=b+8Jl+kI6GM/og/+P5NvBOACn8vgapmge932NN4wlf1R6mupwusQ/nlXviWgaSb0bO
         hCYZlG4sC5+HZKs5prUshOdUSqjktuL8oIxrGF3iqRdmfFLd+oAGmZspxJVBrGANaZme
         rKusVU+pogJCayRmTOQ//ej5t9V5sm4vgvpWKWVe9dc2M/Q0t4qMX6UALwv9NfbPJqrd
         ty36Fy8hi4hu75J+QpL4MSdJWkghQe5rfbQK9HBixjwU2udpFOAN8WBdN8epO5OozeOF
         d3vHssH2vWT49mPsqbBYnQWUT+ZM5+xpuG/lpCR1cJCCrWTvyPPmS249ho2NBaAH6G8a
         9z6Q==
X-Gm-Message-State: AHQUAuaM5BfaRrBH1fPk/Rfr7/J0If+BKP0idbErHfYKkDiOf95AEVHu
        XXvFrHqZQwlHIEBQPfkDr7x9BSc/RZgQRGqDnGI=
X-Google-Smtp-Source: AHgI3IZi2buw6nWQFMqmNDTBSAOyMS5LI99v7ahMNwGTpzZdEsoXPk9/Lb6iTPV0KNOfFcO9PtzJhzgvGLkvPld1Wq4=
X-Received: by 2002:aca:5fc5:: with SMTP id t188mr139900oib.103.1549576174691;
 Thu, 07 Feb 2019 13:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com> <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
In-Reply-To: <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 7 Feb 2019 16:49:23 -0500
Message-ID: <CAGngYiUTJ0TjdTu=UB9yXRJ_mXG8LPmcuBQBDha+T5RHoRUvcQ@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Kees Cook <keescook@chromium.org>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 9:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> Can a Coccinelle script get written to find module-use of the non-devm
> work init?

Ok so I hacked together a Coccinelle script to find these
user-after-free issues,
related to work left running when the device or module is removed.

As far as I can see, these issues may crash/corrupt the kernel even on
_device_ remove/unplug. Users don't need root for that...

I got 71 hits. At least one is a false positive.
34 out of 71 could benefit from devm_init_work().

- is this important enough to ping back to authors of affected modules?
- should this be added to the kernel as part of 'make coccicheck' ?
- does this result make people "feel better" about devm_init_work() ?

Script results, and script itself, follows.

$ make coccicheck COCCI=./init_work.cocci MODE=report M=./drivers/

./drivers//usb/phy/phy-twl6030-usb.c:368:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//power/supply/ds2782_battery.c:429:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//nfc/port100.c:1558:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//net/ethernet/intel/iavf/iavf_main.c:3721:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//iio/proximity/as3935.c:371:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//hwmon/xgene-hwmon.c:649:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//gpu/drm/bridge/adv7511/adv7511_drv.c:1195:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use
devm_)
./drivers//block/sx8.c:1440:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//power/supply/isp1704_charger.c:488:1-10: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//power/supply/da9150-charger.c:592:2-11: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//phy/renesas/phy-rcar-gen3-usb2.c:453:2-11: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//pci/pcie/pme.c:330:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/atheros/atlx/atl1.c:3077:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//media/pci/b2c2/flexcop-pci.c:384:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//hid/intel-ish-hid/ishtp-hid-client.c:812:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use
devm_)
./drivers//thermal/samsung/exynos_tmu.c:1051:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//spi/spi-mpc52xx.c:472:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//rtc/rtc-88pm860x.c:403:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//net/ethernet/ibm/ibmvnic.c:4759:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/cavium/thunder/nicvf_main.c:2188:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//media/platform/qcom/venus/core.c:277:1-18: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//video/fbdev/smscufx.c:1672:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//usb/renesas_usbhs/common.c:727:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//usb/gadget/udc/snps_udc_plat.c:186:2-19: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//power/supply/twl4030_charger.c:1009:1-10: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//power/supply/twl4030_charger.c:1010:1-18: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//power/supply/max17042_battery.c:1103:2-11: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//net/fjes/fjes_main.c:1250:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/intel/e100.c:2902:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//mfd/si476x-i2c.c:772:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//input/serio/ps2-gpio.c:412:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//input/keyboard/matrix_keypad.c:512:1-18: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//extcon/extcon-sm5502.c:573:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//atm/idt77252.c:3624:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c:1239:1-18:
missing clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
(maybe use devm_)
./drivers//net/ethernet/renesas/ravb_main.c:2055:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/natsemi/ns83820.c:1971:1-10: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/cisco/enic/enic_main.c:2885:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//mfd/da903x.c:512:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//iio/adc/envelope-detector.c:343:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//hwmon/sht15.c:931:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//hwmon/sht15.c:932:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//extcon/extcon-rt8973a.c:581:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//usb/gadget/udc/renesas_usb3.c:2701:1-10: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//usb/gadget/udc/renesas_usb3.c:2740:1-10: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//power/supply/max14656_charger_detector.c:281:1-18: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use
devm_)
./drivers//net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:6060:1-10:
missing clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/xircom/xirc2ps_cs.c:497:4-13: missing clean-up
of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/microchip/enc28j60.c:1576:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/microchip/enc28j60.c:1577:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/microchip/enc28j60.c:1578:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/microchip/enc28j60.c:1579:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/calxeda/xgmac.c:1726:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//mmc/host/mxcmmc.c:1159:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//power/supply/sc2731_charger.c:468:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//platform/olpc/olpc-ec.c:271:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//media/pci/saa7164/saa7164-core.c:1280:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//media/i2c/adv7842.c:3552:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//iio/adc/xilinx-xadc-core.c:1182:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//bluetooth/btsdio.c:314:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//auxdisplay/ht16k33.c:448:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//scsi/ibmvscsi/ibmvfc.c:4785:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//power/supply/ltc2941-battery-gauge.c:548:1-18: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use
devm_)
./drivers//phy/ti/phy-twl4030-usb.c:748:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//nfc/trf7970a.c:2069:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here (maybe use devm_)
./drivers//net/ethernet/qualcomm/emac/emac.c:698:1-10: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/chelsio/cxgb/cxgb2.c:1065:3-12: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//net/ethernet/chelsio/cxgb/cxgb2.c:1067:3-20: missing
clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//memstick/host/rtsx_usb_ms.c:795:1-18: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here
./drivers//char/pcmcia/synclink_cs.c:531:1-10: missing clean-up of
INIT_WORK/INIT_DELAYED_WORK initialized here

Coccinelle script:

/// Find INIT_(DELAYED_)WORKs in module probe() that are not cancelled
///    or flushed explicitly.
///
/// The following is a common use-after-free anti-pattern:
///  - INIT_WORK() or INIT_DELAYED_WORK() in module probe.
///  - schedule this work on the global workqueue (e.g. schedule_work() )
///    anywhere in the module.
///  - on module unload, forget to either:
///      + explicitly cancel the work, or
///      + wait for its completion.
///    This could mean that the work is still running/pending after the module
///    has unloaded, which is a use-after-free issue.
//
// Licence: GPLv2
//

virtual org
virtual report
virtual context
virtual patch

@find_probe depends on !patch && (context || org || report)@
identifier __probe_name, s, driver;
@@

(
        static struct s driver = {
*               .probe = __probe_name,
        };
|
        static struct s driver = {
                .ops = {
*                       .add = __probe_name,
                },
        };
)

@find_init depends on find_probe && !patch && (context || org || report)@
identifier find_probe.__probe_name;
identifier e, __work, work_fn;
position j0;
@@

        __probe_name(...)
        {
                ...
(
*               INIT_WORK@j0(&e->__work, work_fn)
|
*               INIT_WORK@j0(&e.__work, work_fn)
|
*               INIT_DELAYED_WORK@j0(&e->__work, work_fn)
|
*               INIT_DELAYED_WORK@j0(&e.__work, work_fn)
)
                ...
        }

@find_schedule depends on find_init && !patch && (context || org || report)@
identifier find_init.__work;
identifier e;
expression delay;
@@

(
        schedule_work(&e->__work)
|
        schedule_work(&e.__work)
|
        schedule_delayed_work(&e->__work, delay)
|
        schedule_delayed_work(&e.__work, delay)
)

@find_cancel depends on find_schedule && !patch && (context || org || report)@
identifier find_init.__work;
identifier e;
@@

(
        cancel_work_sync(&e->__work)
|
        cancel_work_sync(&e.__work)
|
        flush_work(&e->__work)
|
        flush_work(&e.__work)
|
        cancel_delayed_work_sync(&e->__work)
|
        cancel_delayed_work_sync(&e.__work)
|
        flush_delayed_work(&e->__work)
|
        flush_delayed_work(&e->__work)
)

@find_devm depends on find_probe && !patch && (context || org || report)@
identifier find_probe.__probe_name;
@@

        __probe_name(...)
        {
                ...
(
                devm_kzalloc
|
                devm_kcalloc
)
                ...
        }

@script:python missing_cancel depends on find_schedule && !find_cancel
&& !find_devm && report@
j0 << find_init.j0;
@@

msg = "missing clean-up of INIT_WORK/INIT_DELAYED_WORK initialized here"
coccilib.report.print_report(j0[0], msg)

@script:python missing_cancel_devm depends on find_schedule &&
!find_cancel && find_devm && report@
j0 << find_init.j0;
@@

msg = "missing clean-up of INIT_WORK/INIT_DELAYED_WORK initialized
here (maybe use devm_)"
coccilib.report.print_report(j0[0], msg)
