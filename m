Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D9ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B902081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B902081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbeKEQtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:49:40 -0500
Received: from shell.v3.sk ([90.176.6.54]:49519 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbeKEQtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:49:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E71ACC551C;
        Mon,  5 Nov 2018 08:31:17 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HgT4HJEtp42Q; Mon,  5 Nov 2018 08:31:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BAE6EC5586;
        Mon,  5 Nov 2018 08:31:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HyPgyv5TaMcM; Mon,  5 Nov 2018 08:31:02 +0100 (CET)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 37E53C551C;
        Mon,  5 Nov 2018 08:31:02 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Cameron <quozl@laptop.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/11] media: make Marvell camera work on DT-based OLPC XO-1.75
Date:   Mon,  5 Nov 2018 08:30:43 +0100
Message-Id: <20181105073054.24407-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch set somewhat modernizes the Marvel MMP2 CCIC driver. Notably,
it ports it from the platform data (which seems unused as the board
support code never made it) to devicetree.

At the core of the rework is the move to asynchronous sensor discovery
and clock management with the standard clock framework. There are also
some straightforward fixes for bitrotten parts.

There's probably still room for improvement, but as it is, it seems to
work well on OLPC XO-1.75 and doesn't break OLPC XO-1 (I've tested on
both platforms).

Cheers,
Lubo


