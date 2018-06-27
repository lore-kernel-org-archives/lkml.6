Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78D2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503C8245EC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCSEH9Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503C8245EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965891AbeF0Q75 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:59:57 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42356 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965390AbeF0Q7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:59:55 -0400
Received: by mail-ua0-f196.google.com with SMTP id x18-v6so1711319uaj.9;
        Wed, 27 Jun 2018 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SQBS6v7v/EVnvrSFha5Ji4ewTNMKQ344Tyjz+CWBAuc=;
        b=mCSEH9Pi8YwO0Ma9Cz1ZwNuQlhvCSplCr2q30DilPio1H1A7Kbiy+llVqU+NI3zJ+l
         Urc0F2iVuQgtISUoYjeKaFiYDXdhFa07WWsEYKbVKw/+FGqy/2WG9qBGgMnMJJRRHLBz
         Ck0/NtbeWVXKHv3LqqVBlVpOCUjMX0lYp16RxdfFiN2Uk+e0fPp91IcgQT2hXs/K9eOA
         /ii7BXLCeXn56oU5olwR7+mcwJO44RQzsI4/XG91lW1eOp0RrRicWAjcqYNjH09E0zKK
         tfAQPs3DaJTK/aYE3zLkUQLpmTZR1t3KU929KMYuikarmqieyLpf8IXJhemaJAGB1RyR
         HC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SQBS6v7v/EVnvrSFha5Ji4ewTNMKQ344Tyjz+CWBAuc=;
        b=TohyP5u+8aOWBpdChf5RbTnp/immmmv97HYJAnhgRL76HAnJLQW9hUpaZykTuf0KUb
         mGKf98CJRexYbdCjPZvg0KPeknakxUugH3+XxqlVVDXrRd6uHRhCslmDpPnq3gH+wjd6
         7Ba4GrNdor1vagenBH3dP0L5bWi5no8I4GS2CKQvcqP9nguP/5pSNoLINjFfpDCkYFdV
         +/xOi2cwk4xfKhlgLqKds1AEGIRNJ8G367BSYD0UOjY/NOnzumLxCNlhacn0H4ZB8DoR
         eFLBFJ+kSOmGnZwpT2k2/UgmJkaa83H1IYQrOMbRavuwm34h0km7cHU9zNLPcREExEJq
         OEKQ==
X-Gm-Message-State: APt69E2/mcPqZpkSozZrrVCmwjemrQpEPTwFRLKyojau6RT0U8zsIoxw
        h6geIior56UfcgQBsZN4euNcrkkje0gjm1hN/2Q=
X-Google-Smtp-Source: AAOMgpcgeg0oca9pbEBDGM2OxEG9q749X+1SUDDy8xDeGpHzcFoQ6vVnAbvLx9ktthx3wrRz+n7OhDTkSpdpuasTbCc=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr4236922ual.141.1530118794152;
 Wed, 27 Jun 2018 09:59:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:59:53
 -0700 (PDT)
In-Reply-To: <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
References: <cover.1530004712.git.sean.wang@mediatek.com> <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 19:59:53 +0300
Message-ID: <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
To:     sean.wang@mediatek.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>

> +config BT_HCIBTUART_MTK
> +       tristate "MediaTek HCI UART driver"
> +       depends on BT_HCIBTUART

> +       default y

Perhaps it's an overkill for users which would like to have less
amount on stuff in kernel.


> +#include <asm/unaligned.h>
> +#include <linux/atomic.h>
> +#include <linux/clk.h>
> +#include <linux/firmware.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/serdev.h>

> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "h4_recv.h"
> +#include "btuart.h"
> +#include "btmtkuart.h"
> +
> +static void mtk_stp_reset(struct mtk_stp_splitter *sp)
> +{
> +       sp->cursor = 2;
> +       sp->dlen = 0;
> +}
> +
> +static const unsigned char *
> +mtk_stp_split(struct btuart_dev *bdev, struct mtk_stp_splitter *sp,
> +             const unsigned char *data, int count, int *sz_h4)
> +{
> +       struct mtk_stp_hdr *shdr;
> +
> +       /* The cursor is reset when all the data of STP is consumed out. */
> +       if (!sp->dlen && sp->cursor >= 6)
> +               sp->cursor = 0;
> +
> +       /* Filling pad until all STP info is obtained. */
> +       while (sp->cursor < 6 && count > 0) {
> +               sp->pad[sp->cursor] = *data;
> +               sp->cursor++;
> +               data++;
> +               count--;
> +       }
> +
> +       /* Retrieve STP info and have a sanity check. */
> +       if (!sp->dlen && sp->cursor >= 6) {
> +               shdr = (struct mtk_stp_hdr *)&sp->pad[2];
> +               sp->dlen = shdr->dlen1 << 8 | shdr->dlen2;
> +
> +               /* Resync STP when unexpected data is being read. */
> +               if (shdr->prefix != 0x80 || sp->dlen > 2048) {
> +                       bt_dev_err(bdev->hdev, "stp format unexpect (%d, %d)",
> +                                  shdr->prefix, sp->dlen);
> +                       mtk_stp_reset(sp);
> +               }
> +       }
> +
> +       /* Directly quit when there's no data found for H4 can process. */
> +       if (count <= 0)
> +               return NULL;
> +
> +       /* Tranlate to how much the size of data H4 can handle so far. */
> +       *sz_h4 = min_t(int, count, sp->dlen);
> +       /* Update the remaining size of STP packet. */
> +       sp->dlen -= *sz_h4;
> +
> +       /* Data points to STP payload which can be handled by H4. */
> +       return data;
> +}
> +
> +static int mtk_stp_send(struct btuart_dev *bdev, struct sk_buff *skb)
> +{
> +       struct mtk_stp_hdr *shdr;
> +       struct sk_buff *new_skb;
> +       int dlen;
> +
> +       memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> +       dlen = skb->len;
> +
> +       /* Make sure of STP header at least has 4-bytes free space to fill. */
> +       if (unlikely(skb_headroom(skb) < MTK_STP_HDR_SIZE)) {
> +               new_skb = skb_realloc_headroom(skb, MTK_STP_HDR_SIZE);
> +               kfree_skb(skb);
> +               skb = new_skb;
> +       }
> +
> +       /* Build for STP packet format. */
> +       shdr = skb_push(skb, MTK_STP_HDR_SIZE);
> +       mtk_make_stp_hdr(shdr, 0, dlen);
> +       skb_put_zero(skb, MTK_STP_TLR_SIZE);
> +
> +       skb_queue_tail(&bdev->txq, skb);
> +
> +       return 0;
> +}
> +
> +static int mtk_hci_wmt_sync(struct btuart_dev *bdev, u8 opcode, u8 flag,
> +                           u16 plen, const void *param)
> +{
> +       struct mtk_hci_wmt_cmd wc;
> +       struct mtk_wmt_hdr *hdr;
> +       struct sk_buff *skb;
> +       u32 hlen;
> +
> +       hlen = sizeof(*hdr) + plen;
> +       if (hlen > 255)
> +               return -EINVAL;
> +
> +       hdr = (struct mtk_wmt_hdr *)&wc;
> +       mtk_make_wmt_hdr(hdr, opcode, plen, flag);
> +       memcpy(wc.data, param, plen);
> +
> +       atomic_inc(&bdev->hdev->cmd_cnt);
> +
> +       skb =  __hci_cmd_sync_ev(bdev->hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> +                                HCI_INIT_TIMEOUT);
> +
> +       if (IS_ERR(skb)) {
> +               int err = PTR_ERR(skb);
> +
> +               bt_dev_err(bdev->hdev, "Failed to send wmt cmd (%d)\n", err);
> +               return err;
> +       }
> +
> +       kfree_skb(skb);
> +
> +       return 0;
> +}
> +
> +static int mtk_setup_fw(struct btuart_dev *bdev)
> +{
> +       const struct firmware *fw;
> +       struct device *dev;
> +       const char *fwname;
> +       const u8 *fw_ptr;
> +       size_t fw_size;
> +       int err, dlen;
> +       u8 flag;
> +
> +       dev = &bdev->serdev->dev;
> +       fwname = FIRMWARE_MT7622;
> +
> +       err = request_firmware(&fw, fwname, dev);
> +       if (err < 0) {
> +               bt_dev_err(bdev->hdev, "Failed to load firmware file (%d)",
> +                          err);
> +               return err;
> +       }
> +
> +       fw_ptr = fw->data;
> +       fw_size = fw->size;
> +
> +       /* The size of patch header is 30 bytes, should be skip. */
> +       if (fw_size < 30)
> +               return -EINVAL;
> +
> +       fw_size -= 30;
> +       fw_ptr += 30;
> +
> +       while (fw_size > 0) {
> +               dlen = min_t(int, 250, fw_size);
> +
> +               /* Tell deivice the position in sequence. */
> +               flag = (fw_size - dlen <= 0) ? 3 :
> +                      (fw_size < fw->size - 30) ? 2 : 1;
> +
> +               err = mtk_hci_wmt_sync(bdev, MTK_WMT_PATCH_DWNLD, flag, dlen,
> +                                      fw_ptr);
> +               if (err < 0)
> +                       break;
> +
> +               fw_size -= dlen;
> +               fw_ptr += dlen;
> +       }
> +
> +       release_firmware(fw);
> +
> +       return err;
> +}
> +
> +void *mtk_btuart_init(struct device *dev)
> +{
> +       struct mtk_bt_dev *soc;
> +
> +       soc = devm_kzalloc(dev, sizeof(*soc), GFP_KERNEL);
> +       if (!soc)
> +               return ERR_PTR(-ENOMEM);
> +
> +       soc->sp = devm_kzalloc(dev, sizeof(*soc->sp), GFP_KERNEL);
> +       if (!soc->sp)
> +               return ERR_PTR(-ENOMEM);
> +
> +       soc->clk = devm_clk_get(dev, "ref");
> +       if (IS_ERR(soc->clk))
> +               return ERR_CAST(soc->clk);
> +
> +       return soc;
> +}
> +EXPORT_SYMBOL_GPL(mtk_btuart_init);
> +
> +int mtk_btuart_send(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct btuart_dev *bdev = hci_get_drvdata(hdev);
> +
> +       return mtk_stp_send(bdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(mtk_btuart_send);
> +
> +int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct hci_event_hdr *hdr = (void *)skb->data;
> +
> +       /* Fix up the vendor event id with HCI_VENDOR_PKT instead of
> +        * 0xe4 so that btmon can parse the kind of vendor event properly.
> +        */
> +       if (hdr->evt == 0xe4)
> +               hdr->evt = HCI_VENDOR_PKT;
> +
> +       /* Each HCI event would go through the core. */
> +       return hci_recv_frame(hdev, skb);
> +}
> +EXPORT_SYMBOL_GPL(mtk_btuart_hci_frame);
> +
> +int mtk_btuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
> +{
> +       struct btuart_dev *bdev = hci_get_drvdata(hdev);
> +       const unsigned char *p_left = data, *p_h4;
> +       const struct btuart_vnd *vnd = bdev->vnd;
> +       struct mtk_bt_dev *soc = bdev->data;
> +       int sz_left = count, sz_h4, adv;
> +       struct device *dev;
> +       int err;
> +
> +       dev = &bdev->serdev->dev;
> +
> +       while (sz_left > 0) {
> +               /*  The serial data received from MT7622 BT controller is
> +                *  at all time padded around with the STP header and tailer.
> +                *
> +                *  A full STP packet is looking like
> +                *   -----------------------------------
> +                *  | STP header  |  H:4   | STP tailer |
> +                *   -----------------------------------
> +                *  but it don't guarantee to contain a full H:4 packet which
> +                *  means that it's possible for multiple STP packets forms a
> +                *  full H:4 packet and whose length recorded in STP header can
> +                *  shows up the most length the H:4 engine can handle in one
> +                *  time.
> +                */
> +
> +               p_h4 = mtk_stp_split(bdev, soc->sp, p_left, sz_left, &sz_h4);
> +               if (!p_h4)
> +                       break;
> +
> +               adv = p_h4 - p_left;
> +               sz_left -= adv;
> +               p_left += adv;
> +
> +               bdev->rx_skb = h4_recv_buf(bdev->hdev, bdev->rx_skb, p_h4,
> +                                          sz_h4, vnd->recv_pkts,
> +                                          vnd->recv_pkts_cnt);
> +               if (IS_ERR(bdev->rx_skb)) {
> +                       err = PTR_ERR(bdev->rx_skb);
> +                       bt_dev_err(bdev->hdev,
> +                                  "Frame reassembly failed (%d)", err);
> +                       bdev->rx_skb = NULL;
> +                       return err;
> +               }
> +
> +               sz_left -= sz_h4;
> +               p_left += sz_h4;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_btuart_recv);
> +
> +int mtk_btuart_setup(struct hci_dev *hdev)
> +{
> +       struct btuart_dev *bdev = hci_get_drvdata(hdev);
> +       struct mtk_bt_dev *soc = bdev->data;
> +       struct device *dev;
> +       u8 param = 0x1;
> +       int err = 0;
> +
> +       dev = &bdev->serdev->dev;
> +
> +       mtk_stp_reset(soc->sp);
> +
> +       /* Enable the power domain and clock the device requires. */
> +       pm_runtime_enable(dev);
> +       err = pm_runtime_get_sync(dev);
> +       if (err < 0)
> +               goto err_pm2;
> +
> +       err = clk_prepare_enable(soc->clk);
> +       if (err < 0)
> +               goto err_pm1;
> +
> +       /* Setup a firmware which the device definitely requires. */
> +       err = mtk_setup_fw(bdev);
> +       if (err < 0)
> +               goto err_clk;
> +
> +       /* Activate funciton the firmware providing to. */
> +       err = mtk_hci_wmt_sync(bdev, MTK_WMT_RST, 0x4, 0, 0);
> +       if (err < 0)
> +               goto err_clk;
> +
> +       /* Enable Bluetooth protocol. */
> +       err = mtk_hci_wmt_sync(bdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
> +                              &param);
> +       if (err < 0)
> +               goto err_clk;
> +
> +       set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +
> +       return 0;
> +err_clk:
> +       clk_disable_unprepare(soc->clk);
> +err_pm1:
> +       pm_runtime_put_sync(dev);
> +err_pm2:
> +       pm_runtime_disable(dev);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(mtk_btuart_setup);
> +
> +int mtk_btuart_shutdown(struct hci_dev *hdev)
> +{
> +       struct btuart_dev *bdev = hci_get_drvdata(hdev);
> +       struct device *dev = &bdev->serdev->dev;
> +       struct mtk_bt_dev *soc = bdev->data;
> +       u8 param = 0x0;
> +
> +       /* Disable the device. */
> +       mtk_hci_wmt_sync(bdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param), &param);
> +
> +       /* Shutdown the clock and power domain the device requires. */
> +       clk_disable_unprepare(soc->clk);
> +       pm_runtime_put_sync(dev);
> +       pm_runtime_disable(dev);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_btuart_shutdown);
> +
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_DESCRIPTION("Bluetooth Support for MediaTek Serial Devices");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/bluetooth/btmtkuart.h b/drivers/bluetooth/btmtkuart.h
> new file mode 100644
> index 0000000..e76ab23e
> --- /dev/null
> +++ b/drivers/bluetooth/btmtkuart.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + *
> + * Bluetooth support for MediaTek serial devices
> + *
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + *
> + */
> +
> +#define FIRMWARE_MT7622                "mediatek/mt7622pr2h.bin"
> +
> +#define MTK_STP_HDR_SIZE       4
> +#define MTK_STP_TLR_SIZE       2
> +#define MTK_WMT_HDR_SIZE       5
> +#define MTK_WMT_CMD_SIZE       (MTK_WMT_HDR_SIZE + MTK_STP_HDR_SIZE + \
> +                                MTK_STP_TLR_SIZE + HCI_ACL_HDR_SIZE)
> +
> +enum {
> +       MTK_WMT_PATCH_DWNLD = 0x1,
> +       MTK_WMT_FUNC_CTRL = 0x6,
> +       MTK_WMT_RST = 0x7
> +};
> +
> +struct mtk_stp_hdr {
> +       __u8 prefix;
> +       __u8 dlen1:4;
> +       __u8 type:4;
> +       __u8 dlen2:8;
> +       __u8 cs;
> +} __packed;
> +
> +struct mtk_wmt_hdr {
> +       __u8    dir;
> +       __u8    op;
> +       __le16  dlen;
> +       __u8    flag;
> +} __packed;
> +
> +struct mtk_hci_wmt_cmd {
> +       struct mtk_wmt_hdr hdr;
> +       __u8 data[256];
> +} __packed;
> +
> +struct mtk_stp_splitter {
> +       u8      pad[6];
> +       u8      cursor;
> +       u16     dlen;
> +};
> +
> +struct mtk_bt_dev {
> +       struct clk *clk;
> +       struct completion wmt_cmd;
> +       struct mtk_stp_splitter *sp;
> +};
> +
> +static inline void mtk_make_stp_hdr(struct mtk_stp_hdr *hdr, u8 type, u32 dlen)
> +{
> +       __u8 *p = (__u8 *)hdr;
> +
> +       hdr->prefix = 0x80;
> +       hdr->dlen1 = (dlen & 0xf00) >> 8;
> +       hdr->type = type;
> +       hdr->dlen2 = dlen & 0xff;
> +       hdr->cs = p[0] + p[1] + p[2];
> +}
> +
> +static inline void mtk_make_wmt_hdr(struct mtk_wmt_hdr *hdr, u8 op, u16 plen,
> +                                   u8 flag)
> +{
> +       hdr->dir = 1;
> +       hdr->op = op;
> +       hdr->dlen = cpu_to_le16(plen + 1);
> +       hdr->flag = flag;
> +}
> +
> +#if IS_ENABLED(CONFIG_BT_HCIBTUART_MTK)
> +
> +void *mtk_btuart_init(struct device *dev);
> +int mtk_btuart_setup(struct hci_dev *hdev);
> +int mtk_btuart_shutdown(struct hci_dev *hdev);
> +int mtk_btuart_send(struct hci_dev *hdev, struct sk_buff *skb);
> +int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb);
> +int mtk_btuart_recv(struct hci_dev *hdev, const u8 *data, size_t count);
> +
> +#else
> +
> +static void *mtk_btuart_init(struct device *dev)
> +{
> +       return 0;
> +}
> +
> +static inline int mtk_btuart_setup(struct hci_dev *hdev)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline int mtk_btuart_shutdown(struct hci_dev *hdev)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline int mtk_btuart_send(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline int mtk_btuart_recv(struct hci_dev *hdev, const u8 *data,
> +                                 size_t count)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +#endif
> diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
> index ab7f836..169bf1a 100644
> --- a/drivers/bluetooth/btuart.c
> +++ b/drivers/bluetooth/btuart.c
> @@ -35,6 +35,7 @@
>  #include "h4_recv.h"
>  #include "btuart.h"
>  #include "btbcm.h"
> +#include "btmtkuart.h"
>
>  #define VERSION "1.0"
>
> @@ -396,6 +397,12 @@ static const struct h4_recv_pkt bcm_recv_pkts[] = {
>         { BCM_RECV_NULL,    .recv = hci_recv_diag  },
>  };
>
> +static const struct h4_recv_pkt mtk_recv_pkts[] = {
> +       { H4_RECV_ACL,      .recv = hci_recv_frame },
> +       { H4_RECV_SCO,      .recv = hci_recv_frame },
> +       { H4_RECV_EVENT,    .recv = mtk_btuart_hci_frame },
> +};
> +
>  static const struct btuart_vnd bcm_vnd = {
>         .recv_pkts      = bcm_recv_pkts,
>         .recv_pkts_cnt  = ARRAY_SIZE(bcm_recv_pkts),
> @@ -403,6 +410,16 @@ static const struct btuart_vnd bcm_vnd = {
>         .setup          = bcm_setup,
>  };
>
> +static const struct btuart_vnd mtk_vnd = {
> +       .recv_pkts      = mtk_recv_pkts,
> +       .recv_pkts_cnt  = ARRAY_SIZE(mtk_recv_pkts),
> +       .init           = mtk_btuart_init,
> +       .setup          = mtk_btuart_setup,
> +       .shutdown       = mtk_btuart_shutdown,
> +       .send           = mtk_btuart_send,
> +       .recv           = mtk_btuart_recv,
> +};
> +
>  static const struct h4_recv_pkt default_recv_pkts[] = {
>         { H4_RECV_ACL,      .recv = hci_recv_frame },
>         { H4_RECV_SCO,      .recv = hci_recv_frame },
> @@ -487,6 +504,7 @@ static void btuart_remove(struct serdev_device *serdev)
>  #ifdef CONFIG_OF
>  static const struct of_device_id btuart_of_match_table[] = {
>         { .compatible = "brcm,bcm43438-bt", .data = &bcm_vnd },
> +       { .compatible = "mediatek,mt7622-bluetooth", .data = &mtk_vnd },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, btuart_of_match_table);
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
