Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B5C2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYSxPg/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfAJCji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:39:38 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36900 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfAJCjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:39:37 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so14160999iti.2;
        Wed, 09 Jan 2019 18:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p18eD1oWVtGu0SfiG4LV/LpESQd0jK9mMH1l8puA/3Q=;
        b=HYSxPg/N5DnbY3A7ogExH5KsS8AeeE9b7fvwSHXU9rVl4/EcblhkuFju80Z6AWhWYD
         mVTwrTbrrIgTw7E7RFSixvH+7sHk9lQQiJaNnVqt51LRl1l+TeoPFITrtCMRWq50+0oJ
         82iC0PkQlerQg2Iny1Wi8JhLZGtFlu4D4h/7b/Wj7O1Ipc/CrUuifDK88y1kXWT9/dYH
         2fHCZa9f3Izuu1sSHO3KQWH+gQkQWSibOb9zFg8QtUTJcKcr0gkkuPHPJVyapLA6Tk8O
         G9DPuM6VRk++f0y2IfjqFsV6he5DFLmVDvLWviLQUXvxB9pWtYL8CqrRtoi6K9Sy1NJg
         OvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p18eD1oWVtGu0SfiG4LV/LpESQd0jK9mMH1l8puA/3Q=;
        b=Zs7751P6d8wUxVzmw3iGj0sIk3WB4Pq859FQWVUETCptgeFKJrl+PM+SOEkiliifa+
         IhFoBnNpl04cVdF8Lj8UIw819w1FbNBbMqFFE3j8VMjOrXVOMYU30N1p4/ayaXxg0Tcq
         NX9FyNMM/6rzGmOdH/+VYj/xh11jTi1xTnsAggUKjT060LduyZdXPKjdvD+KmZ8eaRj7
         7tlwO1vlGwl7lsHH3WSTiTwLdkNrScva3LOvymS2DoYh92TqrdLK6DX/T4PZDB81q8WT
         RdRt/1eGA9yyYgVHtjzPKvChRD7GpbkulwzfbZewcDy3dKWWyyaqeiZdOFpFD6jkZwgx
         EVIQ==
X-Gm-Message-State: AJcUukcT1cU0u4RgYvxJgwkI4yhm6g6Y740YTxuT/RVUcpN3u4uSTOU6
        jbZyHUB2UVSHynkcEcdDu6q0n9g7cOEcgYizTaJ/mprY
X-Google-Smtp-Source: ALg8bN5lffN5JQ80S1yNaDyjiVfe5WCcFgS8dyy2XyjEPMO1i+FLgpmJL73ny5fDgsEws1s3sIIyRc56Oxo0LHID2tg=
X-Received: by 2002:a02:bb9a:: with SMTP id g26mr5734146jan.44.1547087976737;
 Wed, 09 Jan 2019 18:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20190108130747.GA13437@Red>
In-Reply-To: <20190108130747.GA13437@Red>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 10 Jan 2019 10:39:24 +0800
Message-ID: <CAL411-oSUMq3xuYJD_m_JFH0FT1unKnFtZ8nRXr8o31phPeX7w@mail.gmail.com>
Subject: Re: [BUG] rmmod g_mass_storage result to segmentation fault
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> When running an imx_defconfig on a imx6q-sabrelite, rmmod g_mass_storage =
lead to the following crash:
> [  143.952834] Internal error: Oops: 817 [#1] SMP ARM
> [  143.957639] Modules linked in: dmatest psmouse serport da9063_wdt wl12=
xx wl18xx wlcore wlcore_sdio brcmfmac brcmutil mwifiex_sdio mwifiex_pcie mw=
ifiex rtl8150 pegasus cdc_eem i2c_algo_pca i2c_algo_pcf echainiv bnep crc_c=
citt libcrc32c crc7 isofs nls_iso8859_15 udf crc_itu_t msdos binfmt_misc gs=
pca_main uvcvideo adv7180 snd_usb_audio snd_hwdep snd_usbmidi_lib usb_f_uac=
2 usb_f_hid usb_f_uac1 u_audio usb_f_obex usb_f_eem usb_f_printer usb_f_uvc=
 usb_f_ecm usb_f_midi snd_rawmidi usb_f_ecm_subset usb_f_ss_lb usb_f_serial=
 usb_f_ncm g_ffs usb_f_fs g_zero g_audio g_mass_storage(-) usb_f_mass_stora=
ge usb_f_rndis u_ether usb_f_acm u_serial libcomposite configfs usb_wwan us=
bserial imx_vdoa videobuf2_vmalloc [last unloaded: g_ncm]
> [  144.021308] CPU: 3 PID: 9158 Comm: rmmod Not tainted 5.0.0-rc1-next-20=
190108 #1
> [  144.028623] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  144.035170] PC is at usb_gadget_unregister_driver+0xac/0xd4
> [  144.040748] LR is at 0x1242afc4
> [  144.043895] pc : [<c079af08>]    lr : [<1242afc4>]    psr: 60000013
> [  144.050166] sp : ed0e7f48  ip : a54b4ce2  fp : 00000000
> [  144.055396] r10: 00000081  r9 : ed0e6000  r8 : c01011c4
> [  144.060626] r7 : 00000081  r6 : bec49b98  r5 : bf12916c  r4 : c129176c
> [  144.067159] r3 : 00000200  r2 : 00000100  r1 : 00000200  r0 : 00000100
> [  144.073693] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [  144.080833] Control: 10c5387d  Table: 3d33404a  DAC: 00000051
> [  144.086585] Process rmmod (pid: 9158, stack limit =3D 0x2ac398d3)
> [  144.092510] Stack: (0xed0e7f48 to 0xed0e8000)
> [  144.096877] 7f40:                   bf129200 c120c908 bec49b98 c01c965=
c 616d5f67 735f7373
> [  144.105063] 7f60: 61726f74 b6006567 00000017 c01175c8 b6f114c8 ed0e7fb=
0 bec49e14 000a1a98
> [  144.113249] 7f80: bec49b7c c0117aec ffffffff c33d43a5 000278d4 c33d43a=
5 000278d4 616d5f67
> [  144.121435] 7fa0: 735f7373 c0101000 000278d4 616d5f67 bec49b98 0000088=
0 00000000 bec49e18
> [  144.129621] 7fc0: 000278d4 616d5f67 735f7373 00000081 00000000 0000000=
0 b6faf000 00000000
> [  144.137807] 7fe0: bec49b90 bec49b80 000277b8 b6eb52f0 60000010 bec49b9=
8 00000000 00000000
> [  144.146006] [<c079af08>] (usb_gadget_unregister_driver) from [<c01c965=
c>] (sys_delete_module+0x130/0x1dc)
> [  144.155586] [<c01c965c>] (sys_delete_module) from [<c0101000>] (ret_fa=
st_syscall+0x0/0x28)
> [  144.163855] Exception stack(0xed0e7fa8 to 0xed0e7ff0)
> [  144.168914] 7fa0:                   000278d4 616d5f67 bec49b98 0000088=
0 00000000 bec49e18
> [  144.177100] 7fc0: 000278d4 616d5f67 735f7373 00000081 00000000 0000000=
0 b6faf000 00000000
> [  144.185283] 7fe0: bec49b90 bec49b80 000277b8 b6eb52f0
> [  144.190344] Code: e5953070 e595206c e3a00c01 e3a01c02 (e5823004)
> [  144.196538] ---[ end trace 86952e6cc74d8e8b ]---
> Segmentation fault

Some questions:
- Do you have issue for previous version,eg, v4.19 or v4.20?
-  Legacy gadget driver is not supported well now, do you have issues
with configfs?
- Any differences if the cable is connected or not?

Peter
