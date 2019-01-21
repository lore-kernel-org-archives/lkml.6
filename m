Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C834C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D6F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfAUHif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:38:35 -0500
Received: from shell.v3.sk ([90.176.6.54]:49579 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfAUHid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:38:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 97618CAF8A;
        Mon, 21 Jan 2019 07:23:21 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id J0HzxClg1-lo; Mon, 21 Jan 2019 07:23:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 99292CAE40;
        Mon, 21 Jan 2019 07:23:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V0tVi3pP10qR; Mon, 21 Jan 2019 07:23:16 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id AED87CAE3B;
        Mon, 21 Jan 2019 07:23:15 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/3] Stop managing the SP clock
Date:   Mon, 21 Jan 2019 07:22:53 +0100
Message-Id: <20190121062255.551587-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Per discussion in [1] it seems that the kernel has no business managing
this clock: once the SP clock is disabled, it's not sufficient to just
enable it in order to bring the SP core back up.

Just let the firmware keep it enabled and don't expose it to drivers.

[1] https://lore.kernel.org/lkml/154783267051.169631.3197836544646625747@=
swboyd.mtv.corp.google.com/

The "secure processor" (SP) core runs the keyboard firmware on the
OLPC XO 1.75 laptop.

Lubo


