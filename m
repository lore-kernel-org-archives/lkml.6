Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64415C65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2100D20834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8QjiBwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2100D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeJEVGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:06:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39580 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbeJEVGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:06:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id p1-v6so7866515ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iUYGmKcw/27YMu8ORqu3DQcqSN7h593NJ3nRno56mvI=;
        b=X8QjiBwdB8UlanfZwCOOa1Ls6fBzLDoDvD9WT0U79ssQ17W6o+T0mS8LvkS6dLhqAy
         yKKivJK6Vil4YSd9hjclXw5gggR+S5mo3KNXksSL5Db4htkRsJq3lh90LA2DSwOyAk7A
         ct8v5YDp0WiXNmM6wNrGHPXaPQ+JhB8vQfiSc3mJFwA8ppSYXMEr1jVXeBsw/ckOLmeA
         4QYtpk5dEj8tGYa2Q62MtnYDaDmX8UueHDsNa08iEZYKUI5ZOxWWR61UwLmxWoRxzwyl
         Fb4AchnO5C0symEBJE1hliFo1do3WP5ilALxi3jCaS3j97kA88frEkc1o5joXJ92dAQA
         tbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iUYGmKcw/27YMu8ORqu3DQcqSN7h593NJ3nRno56mvI=;
        b=Hi/OX5pwHt6baRzyhTyIxPigU3dpmq6C3767keVuvyOg97BJMqizBSCFOJVYSL4NoV
         HcURqtJeq5QURKK6LDcqPDI2GfW9JCWEijES3uKMDdONesiwH5hwJySQs3Fy2MQ1CQUj
         zhVLsXza584fxdkdIYY8I/pm4fnDXarOunnv5OvhZRjegTZ38fG4KALbnxYe/lHXvk3m
         TzbUBzoM0QKdCs7M/gnfPMmYsOMBFywuXhzhlc+aXgGOfpmlZ8VZXqZBeXUXI99O2/KG
         jY0j95mBfD9k/y4zKA2ezRWF/pXAHpETL2Pnde3vPJzgHCcl9yAvm1Rh+obu/OUdm5t7
         pKLg==
X-Gm-Message-State: ABuFfogg6Bi3VTDPp3hWFxzcXja9GGri77FukiNxTu4VcoNb2zs6cgew
        OyK92Gsm2fcLqFPX8m2gADw2KxuiQkY4Tyqn7QE=
X-Google-Smtp-Source: ACcGV63/HWMWShbhOta8LVyM9kcQeSisCBTB0XyihS8NAzfZzuReaLQdaSjV4eV0NVqOV/adhuxa/JvahOoxb8UaxuY=
X-Received: by 2002:a2e:811:: with SMTP id 17-v6mr7380957lji.140.1538748434551;
 Fri, 05 Oct 2018 07:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
 <20181004142942.11887-2-ricardo.ribalda@gmail.com> <20181005002125.12fd229f@bbrezillon>
 <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
 <20181005090811.6b7e9957@bbrezillon> <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
 <20181005103730.57d52e3c@bbrezillon> <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
 <20181005121235.7e64b64a@bbrezillon> <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
 <20181005141057.0f1b0a9b@bbrezillon>
In-Reply-To: <20181005141057.0f1b0a9b@bbrezillon>
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date:   Fri, 5 Oct 2018 16:06:57 +0200
Message-ID: <CAPybu_0OZR==4k5nxVRZ-1NjPEXLQsun7QhnYds8dPndreUjcQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Boris


On Fri, Oct 5, 2018 at 2:10 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> On Fri, 5 Oct 2018 14:04:52 +0200
> Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
>
> > Hi Boris
> > On Fri, Oct 5, 2018 at 12:12 PM Boris Brezillon
> > <boris.brezillon@bootlin.com> wrote:
> > >
> > > On Fri, 5 Oct 2018 11:54:18 +0200
> > > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> > >
> > > > Hi Boris
> > > >
> > > > Just seen that  you already did the rebase at
> > > > https://github.com/bbrezillon/linux-0day/commits/mtd/physmap-cleanup
> > > >
> > > > Thanks for that.
> > > >
> > > > I am about to test it in real hw (unless you want me wait)
> > >
> > > Sure, go ahead and test it.
> > >
> > > Thanks,
> > >
> > > Boris
> > I had to change this on your patchset to have it working on hw:
> > https://pastebin.com/78A7yhJ9
> >
> > If you send the patchset to the mailing list I can review it patch by patch.
> >
> > Also
> > mtd: maps: Prepare merging of physmap and physmap_of
> >
> > I do not think that can be bisected. (Not sure, I have to test it)
>
> Okay, I'll have a look.
>
> >
> > I add the diff to the mail, but gmail will probably scramble the
> > lines(yes I know I have to use other mail client)
>
> The diff looks good, I'll fix that an send a push a new version.

Also fix on physmap_flash_remove

physmap_data->exit(dev); must be called BEFORE
map_destroy(info->mtds[i]);

otherwise OOPS

Cheers!

[  162.700421] Unable to handle kernel paging request at virtual
address 7974696e6966a6
[  162.705461] Mem abort info:
[  162.713171]   Exception class = DABT (current EL), IL = 32 bits
[  162.715678]   SET = 0, FnV = 0
[  162.721588]   EA = 0, S1PTW = 0
[  162.724703] Data abort info:
[  162.727767]   ISV = 0, ISS = 0x00000004
[  162.730879]   CM = 0, WnR = 0
[  162.734436] [007974696e6966a6] address between user and kernel address ranges
[  162.737567] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  162.744674] Modules linked in: qtec_m43 qtec_mem qt5023_video
qtec_white qtec_cmosis arc4 snd_soc_hdmi_codec ath10k_pci ath10k_core
venus_dec venus_enc ath mac80211 q6asm_dai cfi_cmdset_0002 q6routing
q6afe_dai cfi_probe q6adm cfi_util q6asm gen_probe q6afe q6dsp_common
q6core physmap gpio_xilinx qtec_pcie qtec_clk apr qrtr_smd rpmsg_char
imx214 ad5820 v4l2_common joydev cfg80211 msm venus_core hci_uart
qt5023 qcom_camss btqca v4l2_mem2mem drm_kms_helper videobuf2_dma_sg
v4l2_fwnode videobuf2_memops videobuf2_v4l2 bluetooth drm
videobuf2_core videodev ecdh_generic i2c_qcom_cci media rtc_pm8xxx
leds_qcom_lpg qrtr crc32_ce qcom_adsp_pil crct10dif_ce qcom_common
snd_soc_apq8096 qcom_glink_smem qcom_sysmon remoteproc qmi_helpers
rmtfs_mem mdt_loader sch_fq_codel
[  162.795188] CPU: 2 PID: 1 Comm: systemd-shutdow Not tainted
4.14.53-qtec-linaro #34
[  162.817417] Hardware name: Qtechnology QT5506 (DT)
[  162.824793] task: ffff8000baac8000 task.stack: ffff000008058000
[  162.829671] PC is at cfi_amdstd_reset+0xb4/0x188 [cfi_cmdset_0002]
[  162.835474] LR is at cfi_amdstd_reset+0xb4/0x188 [cfi_cmdset_0002]
[  162.841721] pc : [<ffff00000107fe44>] lr : [<ffff00000107fe44>]
pstate: 40000145
[  162.847885] sp : ffff00000805bc80
[  162.855433] x29: ffff00000805bc80 x28: ffff8000baac8000
[  162.858648] x27: ffff000008b51000 x26: 000000000000008e
[  162.864030] x25: 0000000000000124 x24: 0000000000000014
[  162.869324] x23: 0000000000000000 x22: 0000000000000000
[  162.874619] x21: 5f7974696e696666 x20: ffff8000b3178a18
[  162.879915] x19: ffff8000b5215800 x18: 0000000000000000
[  162.885209] x17: 0000ffffa46d1768 x16: ffff0000080f9960
[  162.890504] x15: 0000000000000010 x14: ffffffffffffffff
[  162.895800] x13: ffff0000896355e7 x12: ffff0000096355ef
[  162.901094] x11: ffff00000944a000 x10: ffff00000805b9b0
[  162.906389] x9 : 0000000000000039 x8 : 000000000000000d
[  162.911686] x7 : ffff00000805ba2c x6 : 0000000000000491
[  162.916980] x5 : 0000000000000000 x4 : 0000000000000000
[  162.922275] x3 : ffffffffffffffff x2 : ffff00000944a278
[  162.927570] x1 : ffff8000baac8000 x0 : 0000000000000028
[  162.932867] Process systemd-shutdow (pid: 1, stack limit =
0xffff000008058000)
[  162.938164] Call trace:
[  162.945191] Exception stack(0xffff00000805bb40 to 0xffff00000805bc80)
[  162.947538] bb40: 0000000000000028 ffff8000baac8000
ffff00000944a278 ffffffffffffffff
[  162.954136] bb60: 0000000000000000 0000000000000000
0000000000000491 ffff00000805ba2c
[  162.961949] bb80: 000000000000000d 0000000000000039
ffff00000805b9b0 ffff00000944a000
[  162.969762] bba0: ffff0000096355ef ffff0000896355e7
ffffffffffffffff 0000000000000010
[  162.977574] bbc0: ffff0000080f9960 0000ffffa46d1768
0000000000000000 ffff8000b5215800
[  162.985386] bbe0: ffff8000b3178a18 5f7974696e696666
0000000000000000 0000000000000000
[  162.993200] bc00: 0000000000000014 0000000000000124
000000000000008e ffff000008b51000
[  163.001011] bc20: ffff8000baac8000 ffff00000805bc80
ffff00000107fe44 ffff00000805bc80
[  163.008823] bc40: ffff00000107fe44 0000000040000145
0000000000000b5b ffffffffffffffff
[  163.016637] bc60: 0000ffffffffffff 0000000000000000
ffff00000805bc80 ffff00000107fe44
[  163.024454] [<ffff00000107fe44>] cfi_amdstd_reset+0xb4/0x188
[cfi_cmdset_0002]
[  163.032264] [<ffff00000107ff78>] cfi_amdstd_reboot+0x10/0x98
[cfi_cmdset_0002]
[  163.039386] [<ffff0000080f7d0c>] notifier_call_chain+0x54/0x90
[  163.046583] [<ffff0000080f85d4>] blocking_notifier_call_chain+0x54/0x78
[  163.052399] [<ffff0000080f96ac>] kernel_restart_prepare+0x1c/0x40
[  163.058910] [<ffff0000080f97a4>] kernel_restart+0x14/0x60
[  163.065158] [<ffff0000080f9b68>] SyS_reboot+0x208/0x230


>
> Thanks,
>
> Boris



-- 
Ricardo Ribalda
