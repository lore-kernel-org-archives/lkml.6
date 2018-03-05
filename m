Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbeCEXMv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 18:12:51 -0500
Received: from muru.com ([72.249.23.125]:59614 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932106AbeCEXMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 18:12:49 -0500
Date: Mon, 5 Mar 2018 15:12:46 -0800
From: Tony Lindgren <tony@atomide.com>
To: Mark Brown <broonie@kernel.org>, Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Regulator regression in next-20180305
Message-ID: <20180305231246.GB5799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark and Maciej,

Looks like with next-20180305 there's a regulator regression
where mmc0 won't show any cards or produces errors:

mmcblk0: error -110 requesting status
mmc1: new high speed SDIO card at address 0001
mmcblk0: error -110 requesting status
mmcblk0: recovery failed!
print_req_error: I/O error, dev mmcblk0, sector 0
Buffer I/O error on dev mmcblk0, logical block 0, async page read
mmcblk0: error -110 requesting status
mmcblk0: recovery failed!

I bisected it down to the following commits:

broken		71c33626a802 ("regulator: core: Change voltage setting path")
fails to build	a7348f502ab7 ("regulator: core: Add voltage balancing mechanism")
works		cf6fc8064766 ("regulator: core: Resolve coupled regulators")

Any ideas?

Regards,

Tony
