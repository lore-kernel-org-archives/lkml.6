Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A85C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A472081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="a/NEwgXq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dl0HUHNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A472081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeLEAmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:42:51 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:45811 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbeLEAmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:42:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CB3ABF4A;
        Tue,  4 Dec 2018 19:42:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=1RXcH6ByEYfFL4kF8B/+GNvkRh
        57vvCTmwp2KMsJ8NM=; b=a/NEwgXqSa1zx6Y1sW+FNnLko3TvNxCa/VJ1QivWEA
        33qu2OJ7rs/wzPszt8/lIiQfTMmeKgKocvHGxk4ihnMJP6fV6bIDFnleAHn1VXIS
        Y32FjsCcsHLJtSPsJlv+bnDOe0tscsMCVBuYHwL986Yqd0WxGFtRHjdEXvBs7ilm
        ND2oxLets94yUF/qoozQEt/8BSiGWh6rOB3xj/Hzn9FE71Bci32GgpraA40OkOla
        ZNgRxnUiGHJynLcfA2lrAJ43UON+6MNw2mCZolPtgiSKRH4Ad1EbJsJInsVCkuql
        io8837zLnhqbgbwXxA2BislHkCNlEpqbjkX3ezYYq60A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1RXcH6ByEYfFL4kF8
        B/+GNvkRh57vvCTmwp2KMsJ8NM=; b=Dl0HUHNh5f7n24UglS9MrMzTyR0UPUUnU
        U6MKG9FSmjqOe5ISkhKQO9MJMQa66Ir4JtFCwL/RJh5eIHwMCe+J1A+5xY/ru2Rq
        yDDp9HOnf94envVA7yc96K3qQdBuVE3pq1j/XtUk9GgmQd3yEYyRAdXehM4uxCkD
        BB7KK1uidIMxzclNdu1iWdxP1eMkOnf+AKOaGO4la73iYMdNTIqG8GfS3lINo5kj
        +YNYHrd//op3Dv892Q/lBECzfh8SvwxPp7YifQxrjxqaGFdTqTO3F1e6lIe/bmDP
        yzQrR+DlJ0fycO7lPqV2fdWnysgzvKQhceWJEPfDTuutptkYQkDUA==
X-ME-Sender: <xms:CB8HXN-es9TAlWMF7pK079DNWwT2Ywe2siI2YCj5f6aA__E_T0S1OA>
X-ME-Proxy: <xmx:CB8HXK9vOBNFAgvZVJ2JSnnqWvrTjHY4nhCVhTX3Ees3GzmLDbZJWw>
    <xmx:CB8HXOOsdAEoFWD1CoJod093m96OHGllmrl2AZOSGhy1e9zNzjaWTw>
    <xmx:CB8HXIg1V3MZXJ8eA8boZcDNLmGxpuAEKHNWaMoTNLTGAMyD-e2jVA>
    <xmx:CB8HXFSXlI2iy5603ohcru5JFsVW3Jb-ppChkFnaiwbyCGCmfq1qGA>
    <xmx:CB8HXDra-iPDDofgKltw5r_XizIVfW2jyGTSq5mw7Hzd1AEdOiepTg>
    <xmx:CR8HXGDvNj6BEg-LK6G4L0DY0sh6_LaStvZ_inAhd8xuTqWoCm3J_g>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 106D8E450E;
        Tue,  4 Dec 2018 19:42:45 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date:   Wed,  5 Dec 2018 10:42:20 +1000
Message-Id: <20181205004228.10714-1-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A full explanation of why and what is in the v1, v2 patch thread here:
https://lkml.org/lkml/2018/11/22/625

v3 adds a better commit messages, m560 REL_HWHEEL_HI_RES support and a patch 
moved in the ordering. This is a full patch sequence because Benjamin's
magic scripts struggle with singular updates ;)

hid-tools patches to add the tests:
https://gitlab.freedesktop.org/libevdev/hid-tools/merge_requests/12

libinput support (unmerged):
https://gitlab.freedesktop.org/whot/libinput/tree/wip/hi-res-scrolling
If you want to 'feel' how it works, run sudo ./builddir/libinput-debug-gui
and watch the green/red scroll bars. On a device with hi-res scrolling the
green bar (scroll fractions) will move smoother than the red bar (wheel
clicks).

Tested with:
- Microsoft Comfort Optical Mouse 3000
- Microsoft Sculpt Ergonomic Mouse
- Microsoft Wireless Mobile Mouse 4000
- Logitech MX Anywhere 2S

And a few other mice that don't have that feature, so the testing was of
limited excitement.

Cheers,
  Peter

Harry Cutts (3):
      HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
      HID: logitech: Enable high-resolution scrolling on Logitech mice
      HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice

Peter Hutterer (5):
      Input: add `REL_WHEEL_HI_RES` and `REL_HWHEEL_HI_RES`
      HID: core: store the collections as a basic tree
      HID: core: process the Resolution Multiplier
      HID: input: use the Resolution Multiplier for high-resolution scrolling
      HID: logitech-hidpp: fix typo, hiddpp to hidpp

 Documentation/input/event-codes.rst    |  21 +++-
 drivers/hid/hid-core.c                 | 174 +++++++++++++++++++++++++++++++++
 drivers/hid/hid-input.c                | 108 +++++++++++++++++++-
 drivers/hid/hid-logitech-hidpp.c       | 375 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/hid.h                    |  10 ++
 include/uapi/linux/input-event-codes.h |   2 +
 6 files changed, 651 insertions(+), 39 deletions(-)

