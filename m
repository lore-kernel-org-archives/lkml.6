Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F37C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D3D20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D3D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbeKTAma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:42:30 -0500
Received: from gloria.sntech.de ([185.11.138.130]:38384 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbeKTAma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:42:30 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gOkNm-0007v7-2B; Mon, 19 Nov 2018 15:18:34 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Damian Kos <dkos@cadence.com>
Cc:     Chris Zhong <zyw@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: fix for mailbox read size
Date:   Mon, 19 Nov 2018 15:18:33 +0100
Message-ID: <7088529.fTnRXqZmiP@phil>
In-Reply-To: <1541518625-25984-1-git-send-email-dkos@cadence.com>
References: <1541518625-25984-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 6. November 2018, 16:37:05 CET schrieb Damian Kos:
> Some of the functions (like cdn_dp_dpcd_read, cdn_dp_get_edid_block)
> allow to read 64KiB, but the cdn_dp_mailbox_read_receive, that is
> used by them, can read only up to 255 bytes at once. Normally, it's
> not a big issue as DPCD or EDID reads won't (hopefully) exceed that
> value.
> The real issue here is the revocation list read during the HDCP
> authentication process. (problematic use case:
> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/drm/rockchip/cdn-dp-reg.c#1152)
> The list can reach 127*5+4 bytes (num devs * 5 bytes per ID/Bksv +
> 4 bytes of an additional info).
> In other words - CTSes with HDCP Repeater won't pass without this
> fix. Oh, and the driver will most likely stop working (best case
> scenario).
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>

applied to drm-misc-next

Thanks
Heiko


