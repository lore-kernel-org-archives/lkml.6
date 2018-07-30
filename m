Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8588FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401A220892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401A220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbeG3NLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:11:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:39175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeG3NLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:11:00 -0400
Received: from localhost ([60.39.96.235]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Ma1pn-1fOrOZ05Pj-00LnZ0; Mon, 30
 Jul 2018 13:36:24 +0200
Date:   Mon, 30 Jul 2018 20:35:19 +0900 (JST)
Message-Id: <20180730.203519.1216400263695142421.teika@gmx.com>
To:     Rosen Penev <rosenp@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jan.steffens@gmail.com, Pablo Cholaky <waltercool@slash.cl>
Subject: [PATCH v2 0/1] Input: synaptics - Enable RMI4 for Clevo P870DM
 laptops.
From:   Teika Kazura <teika@gmx.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TwBv3vX2kquMx8iqCxCE1H1jzQWch+9D5MaGkyij+Vzif8eHaVS
 omlU/26PKhutjQrYyOjiHlYP0vz3rsnLVaVFsc0V27kDJgUzdi8dCS4AQ5oxktxWRVnlosB
 jwwrQlz2cMInU1YhVCH6Ma37LneWSrQ1SOpNUmVs90CDbLwdkgMXK70n0Q/Za7fBuLk53fX
 josWnWojms0ZVXaVFBNrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EWz+ESF9Zok=:TuR8f5JvYUuEi+xteD5J9Z
 yZWBKkV8M8FdnndlbfhdDxl2YCWrnBPfmVt3MwrzFxezVE0WrNK7EK9tSypwXuAda8nLKxEnd
 GKKm6Y/WGgWGmW1ercJKqL1TK5hYDV2YEwOme5PKDJyRzugAk4O5yoIFltp52OmYTZd74mxtz
 y3oJLZbu8PkZid+xI9mNuys91UDagOb7/6XCC1fVOJSZGYnYYhKcVc4K9F7qsFvMNV0EkCpzM
 wSPotTVbDcdMCZqSaTjTIRdj5wU0RS/n3qM8cSlSEouvSpdtkeE5SyGVqWBJxlIo6Lnf6mFte
 eSGwSgQZBfuOXda/MpcDujoIBt9rvdfCu+NIWGpzFgyb1kAbM3NOlvs3vv+soFvceH2QMvA48
 nNbMhDKWWEXfOqe2S/YUlsF3U6Dt55XX6FWgm3fD5sk5vkqIxtfdo6kfp21X5Owv7+Bp9TY9t
 Cqv7zeX4h6C+/fa4wToXHJsKqbefY283nyYcXklrq1WGcw8ePl4ozAZARRfRBp+l7D35qT3ut
 Lp2ZJW620+HeT/nCjT/1tg3ek+IoVyH7n21/T9MqEWusV45knj5VuTt7amjXccjPX9rxRHjdb
 LBXPDpu8K0W/O0vhNg/Bus4YLbkmlYpPfwgGKtkQCiVM9c0l/2xffoWPA1RnLzDThoCJxZMSA
 oxImoXPi3NP64GOG34u8JVf7XT5IRnIMDPxyZDfRXdasLiDMLtS89d9u8bFXsGHFFsCWEGQmS
 YmFdUMNTxJwpjfKO2J1etZ6b2FiBiLIAFNZ3P/XNfOFl5sPvI36haViLDuQtw/H1mKtmwvVCz
 MwkrvZ4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Rosen Penev: Could you please test this patch for kernel >= 4.17, for a week or so? At least suspend/resume should not cause any problem.
------------------------------------------------------------------------
This patch enables SMBus/RMI4 for PCs with SYN1219, e.g. Clevo P870DM etc.

Three users have reported SYN1219 supports SMBus, in Jul and Aug 2017:
https://marc.info/?l=linux-input&m=150049625613055&w=2
https://marc.info/?l=linux-input&m=150284057602358&w=2
https://marc.info/?l=linux-input&m=150094561111026&w=2

No problem has been reported since then.

---
v2
  This patch was originally submitted by Rosen Penev in Jun 2018 [1], which modified the list forcepad_pnp_ids[]. The current version instead changes smbus_pnp_ids[].

  This version is yet to be tested.

[1] https://www.spinics.net/lists/linux-input/msg56884.html

Teika Kazura (1):
  Input: synaptics - Enable RMI4 for Clevo P870DM laptops.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Co-Developed-by: Teika Kazura <teika@gmx.com>
Signed-off-by: Teika Kazura <teika@gmx.com>
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

--
2.16.1
