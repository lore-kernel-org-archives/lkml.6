Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934831AbeB1VCP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:02:15 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:54327 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932928AbeB1VCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:02:14 -0500
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To: kuninori.morimoto.gx@renesas.com
Cc: broonie@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [BUG] Kernel crash on Allwinner H3 due to sound core changes
Date: Wed, 28 Feb 2018 22:02:09 +0100
Message-ID: <2424862.oPtAVTfrB9@jernej-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

with todays linux-next (next-20180228), kernel on Allwinner H3 SoC crashes 
with dmesg like that: https://pastebin.com/raw/0D5JeaJ8

I bisected the kernel and first offending commit is:
be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm: replace platform to 
component")

I know that crash message is completely unrelated to sound subsystem, but it 
turns out that if I disable CONFIG_SND_SUN4I_CODEC kernel works ok, but this 
way I lose analog audio output.

Any suggestions what can be the issue?

Best regards,
Jernej
