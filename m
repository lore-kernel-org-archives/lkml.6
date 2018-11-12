Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10433C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4FF214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4FF214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeKLMVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:21:43 -0500
Received: from shell.v3.sk ([90.176.6.54]:59271 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKLMVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 07:21:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 583C7C6A0A;
        Mon, 12 Nov 2018 03:30:41 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EgWjU8VWJL53; Mon, 12 Nov 2018 03:30:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 2728EC6A0D;
        Mon, 12 Nov 2018 03:30:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tghRzvknKbwN; Mon, 12 Nov 2018 03:30:34 +0100 (CET)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 1BC0AC6A0A;
        Mon, 12 Nov 2018 03:30:34 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 0/6] OLPC 1.75 Keyboard/Touchpad fixes
Date:   Mon, 12 Nov 2018 03:30:23 +0100
Message-Id: <20181112023029.648408-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes keyboard/touchpad work on a DT MMP2 platform.

Changes since v1:
- Collected Acks
- Replaced "Input: olpc_apsp: depend on CONFIG_OF" patch with "Input:
  olpc_apsp: drop CONFIG_OLPC dependency", since it was correctly
  pointed out that the driver doesn't actually depend on OF.
- Dropped "Input: olpc_apsp: allocate the GPIOs used" and "dt-bindings:
  olpc,ap-sp: add GPIO lines" since at the moment they are not useful
  for much more than documenting the lines the SP uses and actually
  claiming them was deemed not to be a good idea.
- Fixed error handling in the "enable the SP clock" patch.

Cheers
Lubo


