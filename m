Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDDS34 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 14:29:56 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:11178 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeDDS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 14:29:54 -0400
X-RZG-AUTH: :JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw87WiucxqETr1IQ==
X-RZG-CLASS-ID: mo00
From: "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Subject: regression: twl4030 audio/clock stopped working in v4.16
Date: Wed, 4 Apr 2018 20:29:49 +0200
Message-Id: <2E644641-82D1-40AB-B878-06066C91AC7A@goldelico.com>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w34IU2UD023837

Hi Peter,
I just noticed a problem in v4.16 kernels with twl4030 audio and vibra driver no longer working.

Tracing it back shows that it already did appear in v4.16-rc1 and wasn't fixed up to v4.16.0.
Kernel v4.15.9 (the latest one where I have a binary) works.

The symptoms are:

[    1.557342] twl4030-audio 48070000.i2c:twl@48:audio: Invalid audio_mclk
[    1.564788] twl4030-audio: probe of 48070000.i2c:twl@48:audio failed with error -22
[    1.839141] TWL4030: HFCLK is not configured

Those are not visible in v4.15.9. And I am not aware of any changes to the gta04 device tree.

Do you know about this issue and a fix, before I start to bisect?

BR and thanks,
Nikolaus
