Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74206C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D57C20866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="ksWSslt3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mowidNx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D57C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbeJRL6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:58:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33733 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727316AbeJRL6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:58:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 040B521BD8;
        Wed, 17 Oct 2018 23:59:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Oct 2018 23:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=fm1; bh=xCr/JsF5Z0Llq
        LW6mP8gx+P1+fo8WJkfmPhn8zyaerI=; b=ksWSslt3t85L6keldM6+eZTjM07vb
        UZtz95WnJrL+UEUDgwXW47Sg0hoCUeW+1nJb8Kq/EsC89HUWlO14/dOvpGoUILBA
        r6JK/g7NqU0+0Hoav1OvuBzOkUh/UWefv+T+NeCrwn44Et9alwdQ7I7YYXLA+yGI
        rIRcgmzA5peFnAy6KC6qmqaIwv0OLegYJkiOSlP4wJn7O2LUP/ecm9vU4d9zERix
        rrpvbH3yejT1WRkygIHKYgpa7Pku4/FGpdq1CiLk8TGppbujSiW/AkPiQXMJfkiv
        CXQ2JWjFmHYwvh904mX9NSCzSgKQcbsB8dEFSGBfbOAbswbsfO1y2rXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xCr/JsF5Z0LlqLW6m
        P8gx+P1+fo8WJkfmPhn8zyaerI=; b=mowidNx9TFPnAA5QTKSfF6yV1dkZV7KjU
        Lx9KZMoCDkBjm7DLqNG728bV12sS0P5Lj4cLsPf5L3zheHOXKfpUNSQQYZrMHa6y
        eQl25BoXYakEFNRfiRO5RZqTHGlqPYPB2w5XGk/xwkcIWONH33qzGjuKnD1Lz/RD
        joAchngYXKRkNXpIuCGc7qsK4dAhfTfcl2w5O9cwpsj+P5v8jMizG5o3sHKMnA6Z
        zXcAabl3n16MQ9CbsNa3XePc6h894WUTvggjrj9zmlAD4My4lauCsSmwCBHnt0Us
        CYaY6zVmTfbZmPd7XURfxeQEV5FgBDTH4kai4Sj1IGUv5cvvj/nlA==
X-ME-Sender: <xms:NgXIW_12ChE_lCbrGoiFU5HSPdkmpy4XqrmlOLIHioOKPM8SuuOz6w>
X-ME-Proxy: <xmx:NgXIW7J_0txgsNrbyrV77N4pndEMHQDd8_k1fnO6mNTPbXf0g7eUUQ>
    <xmx:NgXIW_VAu2xoHTjk__NdAuvYq_FMi-R7Cq5IjWy3saPmwx-OvD1rDQ>
    <xmx:NgXIW1gPzQf2SNhWX_lMdNPWS0lGRXt39ZYmitYq1597aa06Z3BraA>
    <xmx:NgXIWy8W_-z0BdvHDaK28tQ2_yE2TJ8xj2ff548eJyhEMnDB5i2JYA>
    <xmx:NgXIW3CXdulXVwE_x0Xi_W7oAKirrxhkCFLCKLppneI_bQr1rO76kw>
    <xmx:NwXIW1SlwTB7XcdYgKBpQBxNLQwWCIxIj8DmAriXxCAwNm_QmIcsUg>
Received: from v4.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 67F73102D5;
        Wed, 17 Oct 2018 23:59:48 -0400 (EDT)
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     netdev@vger.kernel.org
Cc:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH net-next 0/6] net/ncsi: Allow enabling multiple packages & channels
Date:   Thu, 18 Oct 2018 14:59:11 +1100
Message-Id: <20181018035917.19413-1-sam@mendozajonas.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the NCSI driver to configure multiple packages
and/or channels simultaneously. Since the RFC series this includes a few
extra changes to fix areas in the driver that either made this harder or
were roadblocks due to deviations from the NCSI specification.

Patches 1 & 2 fix two issues where the driver made assumptions about the
capabilities of the NCSI topology.
Patches 3 & 4 change some internal semantics slightly to make multi-mode
easier.
Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration
and keeping track of channel states.
Patch 6 implements the main multi-package/multi-channel configuration,
configured via the Netlink interface.

Readers who have an interesting NCSI setup - especially multi-package
with HWA - please test! I think I've covered all permutations but I
don't have infinite hardware to test on.

Samuel Mendoza-Jonas (6):
  net/ncsi: Don't enable all channels when HWA available
  net/ncsi: Probe single packages to avoid conflict
  net/ncsi: Don't deselect package in suspend if active
  net/ncsi: Don't mark configured channels inactive
  net/ncsi: Reset channel state in ncsi_start_dev()
  net/ncsi: Configure multi-package, multi-channel modes with failover

 include/uapi/linux/ncsi.h |  15 ++
 net/ncsi/internal.h       |  19 +-
 net/ncsi/ncsi-aen.c       |  63 ++++--
 net/ncsi/ncsi-manage.c    | 445 +++++++++++++++++++++++++-------------
 net/ncsi/ncsi-netlink.c   | 229 +++++++++++++++++---
 net/ncsi/ncsi-rsp.c       |   2 +-
 6 files changed, 570 insertions(+), 203 deletions(-)

-- 
2.19.1

