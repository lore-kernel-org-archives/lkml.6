Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AFEECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB2F21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QgRS/RTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB2F21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbeIUCHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:07:42 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35584 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeIUCHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:07:42 -0400
Received: by mail-ua1-f66.google.com with SMTP id m26-v6so5053697uap.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vu7cIzVPXzACVcYSW1/qZi0awyqgOvSyiBIQIJbGbcA=;
        b=QgRS/RTipJO5ORvXvOTh4yYayvDsZgKPLsdmW4oezcqsyC4rr5o2ja3JFxT5TMkHs4
         S8nLmTiVeNtO9lxytSMP5g7FzbkK0ZF7r0THhu6b7fkHwYLd9LqhrUXwl5RPgF+ZJgqy
         yjC12fQDK5EbamLHLO7iyIvyN4wHZlQDOCo0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vu7cIzVPXzACVcYSW1/qZi0awyqgOvSyiBIQIJbGbcA=;
        b=FUFv86yLStPlYQ5b9kvNXsWtopz/FD8DOCzQbVnQh2ScIzWIhkRZtCFKMogX6JAieJ
         AaPDcYSBQqqhE5LyZUi/hzk5GxP0bQ1md6gsxyfB6BQAg8maWwSL+IVR4OaJ/UOBwBlY
         REdf2OwA1TUUQiYhcQ21bBfYR8DGhC7s6VEc3b7wNXOnMZUyFQ1CXldgbv66xmXRizMr
         T3oqlz8JwEqRMUHNRPcwkguPmRFXeRZWT/ewvJlkp113Ij5aiHg9bFTZXn7E00wsf7YB
         MZ7Jryw6+UUupEI/GiWOpNMiPc84AAThEN8M/7wy1o6CsejHCqlgT9vwKk0nDj1FWyxv
         5QMg==
X-Gm-Message-State: APzg51BCWUitfkfPFz66JTL8khZgjVUbf6g4prQqOorU1VvHIrwPn0o5
        VAubJSgcm29/HCrGw0zdqxGzwX0YMBA=
X-Google-Smtp-Source: ANB0Vdbz/k5BDl3hs5TPxrLyYdmcCwaVxKAw67jOw2t2pBg7QLzD+77I4EjCWZUJOpPX8oqcVoIJFg==
X-Received: by 2002:ab0:5dcb:: with SMTP id l11-v6mr3010406uag.64.1537474948124;
        Thu, 20 Sep 2018 13:22:28 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id k10-v6sm2631609vkd.51.2018.09.20.13.22.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 13:22:27 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id f4-v6so5042459uao.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 13:22:26 -0700 (PDT)
X-Received: by 2002:ab0:274a:: with SMTP id c10-v6mr12531606uap.25.1537474946423;
 Thu, 20 Sep 2018 13:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180920180323.217377-1-swboyd@chromium.org> <20180920180323.217377-2-swboyd@chromium.org>
In-Reply-To: <20180920180323.217377-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 20 Sep 2018 13:22:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XCSER8BfqMk7oNYeckFivtpORBXCLD-qebcqAuWPgyaw@mail.gmail.com>
Message-ID: <CAD=FV=XCSER8BfqMk7oNYeckFivtpORBXCLD-qebcqAuWPgyaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Thu, Sep 20, 2018 at 11:03 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We shouldn't attempt to DMA map the message buffers passed into this
> driver from the i2c core unless the message we're mapping have been
> properly setup for DMA. The i2c core indicates such a situation by
> setting the I2C_M_DMA_SAFE flag, so check for that flag before using DMA
> mode. We can also bounce the buffer if it isn't already mapped properly
> by using the i2c_get_dma_safe_msg_buf() APIs, so do that when we
> want to use DMA for a message.
>
> This fixes a problem where the kernel oopses cleaning pages for a buffer
> that's mapped into the vmalloc space. The pages are returned from
> request_firmware() and passed down directly to the i2c master to write
> to the i2c touchscreen device. Mapping vmalloc buffers with
> dma_map_single() won't work reliably, causing an oops like below:
>
>  Unable to handle kernel paging request at virtual address ffffffc01391d0=
00
>  Mem abort info:
>    Exception class =3D DABT (current EL), IL =3D 32 bits
>    SET =3D 0, FnV =3D 0
>    EA =3D 0, S1PTW =3D 0
>  Data abort info:
>    ISV =3D 0, ISS =3D 0x00000146
>    CM =3D 1, WnR =3D 1
>  swapper pgtable: 4k pages, 39-bit VAs, pgd =3D ffffff8009ecf000
>  [ffffffc01391d000] *pgd=3D000000017fffa803, *pud=3D000000017fffa803, *pm=
d=3D0000000000000000
>  Internal error: Oops: 96000146 [#1] PREEMPT SMP
>  Modules linked in: i2c_dev rfcomm uinput lzo lzo_compress hci_uart zram =
btqca qcom_q6v5_pil bluetooth ecdh_generic qcom_common bridge qcom_q6v5 stp=
 llc ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_mark fuse snd_seq_dummy snd_s=
eq snd_seq_device cfg80211 rmtfs_mem smsc95xx usbnet mii joydev
>  CPU: 0 PID: 1269 Comm: bash Not tainted 4.14.68 #1
>  task: ffffffc0dc2a0080 task.stack: ffffff800f978000
>  PC is at __clean_dcache_area_poc+0x20/0x38
>  LR is at __swiotlb_map_page+0x80/0x98
>  pc : [<ffffff800809bfb4>] lr : [<ffffff800809a150>] pstate: 80400149
>  sp : ffffff800f97ba20
>  x29: ffffff800f97ba50 x28: 0000000000000001
>  x27: ffffff8008a04000 x26: ffffffc0f79a7a28
>  x25: 0000000000000000 x24: ffffffbf004e4740
>  x23: 0000000000000000 x22: ffffffc0f94eb290
>  x21: 000000009391d000 x20: 0000000000000084
>  x19: 0000000000000001 x18: 0000000000000000
>  x17: 0000000000000000 x16: ffffffc0dc2a0080
>  x15: 0000000000000000 x14: 0000000000000001
>  x13: 00000000000c00b1 x12: 0000000000000000
>  x11: 0000000002000000 x10: 0000000000000000
>  x9 : 0000000080000000 x8 : 000000001391d000
>  x7 : ffffff80085649dc x6 : 0000000000000000
>  x5 : 0000000000000000 x4 : 0000000000000001
>  x3 : 000000000000003f x2 : 0000000000000040
>  x1 : ffffffc01391d084 x0 : ffffffc01391d000
>  Process bash (pid: 1269, stack limit =3D 0xffffff800f978000)
>  Call trace:
>  Exception stack(0xffffff800f97b8e0 to 0xffffff800f97ba20)
>  b8e0: ffffffc01391d000 ffffffc01391d084 0000000000000040 000000000000003=
f
>  b900: 0000000000000001 0000000000000000 0000000000000000 ffffff80085649d=
c
>  b920: 000000001391d000 0000000080000000 0000000000000000 000000000200000=
0
>  b940: 0000000000000000 00000000000c00b1 0000000000000001 000000000000000=
0
>  cros-ec-spi spi10.0: SPI transfer timed out
>  b960: ffffffc0dc2a0080 0000000000000000 0000000000000000 000000000000000=
1
>  b980: 0000000000000084 000000009391d000 ffffffc0f94eb290 000000000000000=
0
>  b9a0: ffffffbf004e4740 0000000000000000 ffffffc0f79a7a28 ffffff8008a0400=
0
>  b9c0: 0000000000000001 ffffff800f97ba50 ffffff800809a150 ffffff800f97ba2=
0
>  b9e0: ffffff800809bfb4 0000000080400149 ffffffc0f94eb290 000000000000000=
0
>  ba00: 0000007fffffffff 0000000000000001 ffffff800f97ba50 ffffff800809bfb=
4
>  [<ffffff800809bfb4>] __clean_dcache_area_poc+0x20/0x38
>  [<ffffff8008448154>] geni_se_tx_dma_prep+0x80/0x154
>  [<ffffff800867eb2c>] geni_i2c_xfer+0x14c/0x3dc
>  [<ffffff80086793bc>] __i2c_transfer+0x428/0x83c
>  [<ffffff8008679850>] i2c_transfer+0x80/0xbc
>  [<ffffff80086798e8>] i2c_master_send+0x5c/0x90
>  [<ffffff8008671cc0>] elants_i2c_send+0x30/0x84
>  [<ffffff8008672460>] write_update_fw+0x324/0x484
>  [<ffffff80085559e4>] dev_attr_store+0x40/0x58
>  [<ffffff80082c4ca4>] sysfs_kf_write+0x4c/0x64
>  [<ffffff80082c36fc>] kernfs_fop_write+0x124/0x1bc
>  [<ffffff8008234f04>] __vfs_write+0x54/0x14c
>  [<ffffff80082352b0>] vfs_write+0xcc/0x188
>  [<ffffff800823548c>] SyS_write+0x60/0xc0
>  Exception stack(0xffffff800f97bec0 to 0xffffff800f97c000)
>  bec0: 0000000000000001 000000000e7ede70 0000000000000002 000000000000000=
0
>  bee0: 0000000000000002 000000000e7ede70 00000000ec049bc8 000000000000000=
4
>  bf00: 0000000000000002 0000000000000000 000000000e7f0f10 000000000ca2bcd=
8
>  bf20: 0000000000000000 00000000ff9df69c 00000000ebfaf229 000000000000000=
0
>  bf40: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
>  bf60: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
>  bf80: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
>  bfa0: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
>  bfc0: 00000000ebfec978 00000000400e0030 0000000000000001 000000000000000=
4
>  bfe0: 0000000000000000 0000000000000000 0000000000000000 000000000000000=
0
>  [<ffffff80080832c4>] el0_svc_naked+0x34/0x38
>  Code: 9ac32042 8b010001 d1000443 8a230000 (d50b7a20)
>
> Reported-by: Philip Chen <philipchen@chromium.org>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
