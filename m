Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91122C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520BC20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn1zR+H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfBDUGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:06:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37132 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfBDUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:06:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id s13so1985282otq.4;
        Mon, 04 Feb 2019 12:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sidxCzUNKwcFHzntOo5HzEGEGZsF+y25S6tfJdHRD+k=;
        b=Tn1zR+H0UcR2T70CJ++JUSojjK+jSq3Q5ttMZEgsVy2dLJLgzzaU/Z5C2zkFS0T8f6
         peGPlgQ85lQIcLg3S+x5V11IWBLd0L+J1nCoLcZ0Et6+Wpwosy0OLTsIiGNp2cnBOqHR
         Ocy2k3jSojXeiuVQ9q6IP0+cOEFEvRF/SFOuoq0mUU+DVY5hc7tKgpSjFNynENAoUESm
         4IvibzqsEiJhpTQoltinynZ6/4pjPmlEnS/5xPIInuAbONNpw4MLUkOg1dI6XZ/lOZgm
         M6mikNylQSyUkI1ygTArBZReaXUI6hZ3uVJB8yUUK29qEemcgQtSwtAgICRM/4u40g6u
         m+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sidxCzUNKwcFHzntOo5HzEGEGZsF+y25S6tfJdHRD+k=;
        b=e21eeyAcqNN24IZc6XTMt2r311Ks1PjelNcoZ7sdDkSWXToKhMtoGX2AxlnKZwMYnB
         JPW7E9/y8MkhKzSOE6lvheCHYqYsFbVqz4exFkkPl+D+ICKtbeYXps34V3Y9xnkXrDEW
         lPVnSSNo83ZgmpIgpneq0hqTg50dO2Dywwo2op3v+kKmPhzgroKYYndG0tt31E9V3CDo
         EtgLp2bcoDLCIX2IGZfxqF/MaMJ/uyl0rkH5WP6FqFDoS8H8YkEfclC7BWjXEUCRzIj2
         zMMuCSA+SMu5y0w5cXEF5laMG/G+Qqu+zZHPbg3FRQYVx6xUEu4Wi7PCCuwwSkrltw9w
         0Z0g==
X-Gm-Message-State: AHQUAubJqtndd5MZ13jU3z+qFq1CJx45KdfXgdWAFa9Bm8pL13ruHgeH
        C5bBHkj0cm3ND2a99OfejjrA9kYw7njFQ2APM8o=
X-Google-Smtp-Source: AHgI3Ia8snY0q2MFSSBuHMKS2J8kYImctzaKFvsQCN+BHmC1vG3EF2uDgCjbDE5LgkmNiqwbnp1UWnoY2skTNyCZx8k=
X-Received: by 2002:a9d:3464:: with SMTP id v91mr678565otb.102.1549310760049;
 Mon, 04 Feb 2019 12:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20190129102521.4141-1-linux.amoon@gmail.com> <20190129102521.4141-3-linux.amoon@gmail.com>
 <CAFBinCDRTeO9FWoJ-=BUc8uizN5_mhJE9EBYv0X6pse7Rxsxew@mail.gmail.com>
In-Reply-To: <CAFBinCDRTeO9FWoJ-=BUc8uizN5_mhJE9EBYv0X6pse7Rxsxew@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 5 Feb 2019 01:35:45 +0530
Message-ID: <CANAwSgRUqXiDLMxQ4bTE0M8-UT_1=S5Om5PCR2S94iZsRuS0Zw@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] ARM64: dts: meson-gxbb-odroidc2: Fix usb phy
 regulator power failed warning
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, 4 Feb 2019 at 19:36, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Jan 29, 2019 at 11:25 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Override the dr_mode from "host" to "otg" for USB_HOST controller (usb0)
> > changes help usb_phy0->usb0 initialization of OTG bus port.
> >
> > Changes fix the below warning.
> >
> > [    1.183681] dwc2 c9000000.usb: c9000000.usb supply vusb_d not found, using dummy regulator
> > [    1.190627] dwc2 c9000000.usb: Linked as a consumer to regulator.0
> > [    1.196696] dwc2 c9000000.usb: c9000000.usb supply vusb_a not found, using dummy regulator
> > [    1.206094] phy phy-c0000000.phy.0: USB ID detect failed!
> > [    1.210243] phy phy-c0000000.phy.0: phy poweron failed --> -22
> I wonder if the warning below are a side-effect of "phy poweron failed"...

As pointed by you we need the fix this issue earlier email.
unless we enable the phy and set the correct dr_mode to tune the phy
we cannot the tune and power on phy bus properly.

After this patch we get phy and power correctly registered.

# cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage
current     min     max
---------------------------------------------------------------------------------------
 regulator-dummy                  5    4      0 unknown     0mV
0mA     0mV     0mV
    c9100000.usb                  1
0mA     0mV     0mV
    c9100000.usb                  1
0mA     0mV     0mV
    c9000000.usb                  1
0mA     0mV     0mV
    c9000000.usb                  1
0mA     0mV     0mV
 P5V0                             1    1      0 unknown  5000mV
0mA  5000mV  5000mV
    USB_OTG_PWR                   4    2      0 unknown  5000mV
0mA  5000mV  5000mV
       phy-c0000020.phy.1         2
0mA     0mV     0mV
       phy-c0000000.phy.0         2
0mA     0mV     0mV

>
> > [    1.216072] WARNING: CPU: 0 PID: 78 at drivers/regulator/core.c:2054 _regulator_put.part.11+0xf0/0xf8
> > [    1.225147] Modules linked in:
> > [    1.228169] CPU: 0 PID: 78 Comm: kworker/0:1 Not tainted 5.0.0-rc4-xc2ml #1
> > [    1.235066] Hardware name: Hardkernel ODROID-C2 (DT)
> > [    1.239987] Workqueue: events deferred_probe_work_func
> > [    1.245072] pstate: 80000005 (Nzcv daif -PAN -UAO)
> > [    1.249816] pc : _regulator_put.part.11+0xf0/0xf8
> > [    1.254473] lr : regulator_put+0x34/0x48
> > [    1.258353] sp : ffff0000117b3b00
> > [    1.261630] x29: ffff0000117b3b00 x28: 0000000000000000
> > [    1.266891] x27: ffff80007ec1a7b8 x26: ffff000010eec280
> > [    1.272153] x25: 0000000000000000 x24: 0000000000000009
> > [    1.277414] x23: ffff0000117b3bc8 x22: ffff80007ecd3c00
> > [    1.282675] x21: ffff0000111ad6c8 x20: ffff80007ecd3e00
> > [    1.287936] x19: ffff80007ecd3e00 x18: 0000000000000124
> > [    1.293198] x17: 0000000000000000 x16: 0000000000000000
> > [    1.298459] x15: 0000000000000400 x14: 0000000000000400
> > [    1.303720] x13: ff00000000000000 x12: ffffffffffffffff
> > [    1.308981] x11: 0000000000000038 x10: 0000000000000040
> > [    1.314243] x9 : ffff0000111c58b0 x8 : ffff0000111c58a8
> > [    1.319504] x7 : ffff80006b055200 x6 : ffff80007edd2880
> > [    1.324765] x5 : ffff80007f400248 x4 : ffff80007fb92b00
> > [    1.330026] x3 : ffff0000112c9d58 x2 : ffff80007edd2880
> > [    1.335288] x1 : 0000000000000000 x0 : 0000000000000001
> > [    1.340549] Call trace:
> > [    1.342966]  _regulator_put.part.11+0xf0/0xf8
> > [    1.347278]  regulator_put+0x34/0x48
> > [    1.350814]  regulator_bulk_free+0x30/0x50
> > [    1.354868]  devm_regulator_bulk_release+0x18/0x20
> > [    1.359612]  release_nodes+0x1b0/0x220
> > [    1.363320]  devres_release_all+0x34/0x50
> > [    1.367288]  really_probe+0xec/0x290
> > [    1.370824]  driver_probe_device+0x54/0xe8
> > [    1.374878]  __device_attach_driver+0xb8/0xe8
> > [    1.379190]  bus_for_each_drv+0x78/0xc8
> > [    1.382985]  __device_attach+0xd4/0x130
> > [    1.386780]  device_initial_probe+0x10/0x18
> > [    1.390920]  bus_probe_device+0x90/0x98
> > [    1.394715]  deferred_probe_work_func+0x6c/0xa0
> > [    1.399203]  process_one_work+0x1e0/0x318
> > [    1.403168]  worker_thread+0x228/0x428
> > [    1.406877]  kthread+0x124/0x128
> > [    1.410070]  ret_from_fork+0x10/0x18
> > [    1.413603] ---[ end trace 498aca4cb07e5377 ]---
> phy_power_on fails above with -EINVAL and then something else breaks
> (it seems like you're hitting the WARN_ON in drivers/regulator/core.c
> below the comment which states: "Docs say you must disable before
> calling regulator_put()")

Ok will look into this later.

> so this looks like a bug in either the dwc2 driver or the PHY
> framework. can you please report that to the dwc2 and PHY maintainers
> so it can be fixed independently?
>
>
> Regards
> Martin

Best Regards

-Anand
