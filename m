Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92AF20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="jzLxzvuW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ok6Y3jwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92AF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404706AbeKVRMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:12:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47687 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732955AbeKVRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:12:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B5424220F9;
        Thu, 22 Nov 2018 01:34:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=QK0hoZ+iI1WORsPvq9qi4QNw4I
        TM745+jMNHANZTDf4=; b=jzLxzvuW2RVexMtYZuFm3lRpWbghnEdjX/N4VpCSNY
        pJoN7uxA03/wpShVUMC/BJAOhxR2z/gyvnFDmIEj3WJxAH578Wj9OcOzyDDoV/RP
        9tNs0AGBB4lxMsRGVYH8jUA1+Ho7LM+JrNb4Z8Ise26blFXSt7oZbiIdl4tRavEm
        IYEB8PeuC2GroiVs1q6bDaiVJmqXBYHy7u8pTylVzIkF/WoydFya3Q3gKO4NOm0H
        /XSH5XMgNPm143gBX2oU/DmKZ7ojpOgZKB2S/odOAf0rmoXomsUjNMh59X9TtFBr
        SSqqNylS+Kq2vlfIvx/3h6CB+iZjt4SfNv7y3gwF3iyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QK0hoZ+iI1WORsPvq
        9qi4QNw4ITM745+jMNHANZTDf4=; b=Ok6Y3jwNKVxvXwfxjGCyLKOsQ7voe9Zk7
        TWSzBSegl+chY3Y33VxZEULPomS6JGxZHAn+17p2sYoX3TU7ILJfKp3eYHwqUe9F
        QUcg/Sky6AEOp4nv2dbEcOBTh88m1NlULvG2N+Q3l2aGShYa9pBfBPebN16G8kd8
        KPqH7KGQTgY/a4B7okoIcxWkZ5n8jHlZEotmYKfYaREnLsP4NQUQg9PlpXYsZ4gm
        8fK6fCIzTMzhvcNjyME2CXb0kpmDnus59tkMQfeovrNkgvJAMPuTbqpxwgIjvQaJ
        6m2STK8/u2SZTl+EwytAdkrAA9MPPwGPBMJijGTfW9YxuplDovekw==
X-ME-Sender: <xms:Ck72WyM1eSMXhkJo-mb2ji2zQ_D1cdwafWoUVKo2bdcecjxKjf2WRw>
X-ME-Proxy: <xmx:Ck72W3mJRlyCFLSZH7RhUqzTHk3hOTyn4TMptc8S5VAZsDQKjC4tsw>
    <xmx:Ck72WzCR3yH9WTGck4Qbp-998WueFegr3UeW1cecgaxF0bgnia89fA>
    <xmx:Ck72W08DK8AbAaEM8UNOGJ_iOglq5w52JaYqu4GwUmfD27xIC-b1XQ>
    <xmx:Ck72W9SIDlYIPOKX-8q0f0-tmQ-sqMV4XiylyDz3spcY6hgorbE4eQ>
    <xmx:Ck72Wy7pMAczkII8weEv1UEJh8csa-4vKDxeVGZg52fZGByde4jmHQ>
    <xmx:Ck72W_L2v5DFWzm7QHbgPsyP86pqLj0Uch4jbraQQScyywrQS1bBWg>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B3F5102EE;
        Thu, 22 Nov 2018 01:34:47 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date:   Thu, 22 Nov 2018 16:34:01 +1000
Message-Id: <20181122063409.15816-1-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series enables high-resolution scrolling on some or many Microsoft mice
of the last decade and Logitech mice with the required feature support.

High resolution scrolling is exposed to userspace as REL_WHEEL_HI_RES and
REL_HWHEEL_HI_RES. An accumulated value of 120 signals one wheel click, mice
with higher granularity can send multiple values that are fractions of 120.
REL_WHEEL and REL_HWHEEL are emulated for backwards compatibility.
The 120 magic number comes from Windows and affects how hardware vendors
build their shiny (and the use of a multiplier in the hw that is a whole
fraction of 120).

This series adds implementations for generic HID and for Logitech's HID++.

Windows Vista added the Resolution Multiplier HID feature which gives
us a multiplier that is applied (in hardware) to the wheel data. For the
same physical motion and an example multiplier of 8, the hardware may: 
- send 8 events of value 1, or
- send 1 event of value 8, or
- send 8/n events of value 1 * n
The multiplier is a HID Feature and should default to an effective 1 in the
hardware. Windows Vista and newer set this to the logical maximum, we do the
same now. It's an approved HID Feature but so far, this feature has only
been found on some Microsoft mice.

Logitech mice do not seem to use it and have their own HID++ protocol to
apply that multiplier. Harry's patchset had previously been merged, the
exact implementation was incompatible with the Microsoft bits though so it
was reverted. Harry's patches in this series are adjusted accordingly but
are by and large the same.

Notable: The Logitech REL_WHEEL emulation cannot just hook into the HID
bits. The firmware drops some events so the point when we get the REL_WHEEL
event moves around. This is worked around by directional resets and a
timeout-based reset.

Devices tested:
- Microsoft Comfort Optical Mouse 3000
- Microsoft Sculpt Ergonomic Mouse
- Microsoft Surface mouse
- Logitech MX Anywhere 2S

The following devices were tested for the HID feature and didn't have it:
- Logitech G500s, G303
- Roccat Kone XTD
- all the cheap Lenovo, HP, Dell, Logitech USB mice that come with a
  workstation that I could find in the local office
- Etekcity something something
- Razer Imperator
- Microsoft Classic IntelliMouse
- Microsoft Surface Mobile Mouse

Cheers,
  Peter

Harry Cutts (3):
      HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice
      HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
      HID: logitech: Enable high-resolution scrolling on Logitech mice

Peter Hutterer (5):
      Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
      HID: core: store the collections as a basic tree
      HID: core: process the Resolution Multiplier
      HID: input: use the Resolution Multiplier for high-resolution scrolling
      HID: logitech-hidpp: fix typo, hiddpp to hidpp

 Documentation/input/event-codes.rst    |  21 +++-
 drivers/hid/hid-core.c                 | 174 ++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c                | 137 ++++++++++++++++++++++++-
 drivers/hid/hid-logitech-hidpp.c       | 384 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/hid.h                    |  10 ++
 include/uapi/linux/input-event-codes.h |   2 +
 6 files changed, 690 insertions(+), 38 deletions(-)


