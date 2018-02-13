Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeBMBv2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:51:28 -0500
Received: from ozlabs.org ([103.22.144.67]:49867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933102AbeBMBv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:51:26 -0500
Date: Tue, 13 Feb 2018 12:51:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20180213125123.003f92f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

sound/soc/codecs/wm9081.c: In function 'wm9081_digital_mute':
sound/soc/codecs/wm9081.c:1161:7: warning: 'reg' may be used uninitialized in this function [-Wmaybe-uninitialized]
   reg |= WM9081_DAC_MUTE;

Introduced by commit

  48c338764296 ("ASoC: wm9081: replace codec to component")

-- 
Cheers,
Stephen Rothwell
