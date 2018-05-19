Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeESA66 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 20:58:58 -0400
Received: from gherkin.frus.com ([192.158.254.49]:43246 "EHLO gherkin.frus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbeESA64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 20:58:56 -0400
Date: Fri, 18 May 2018 19:32:59 -0500
From: Bob Tracy <rct@gherkin.frus.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 4.17-rcX delays during boot and memory mapping errors
Message-ID: <20180519003259.GA1114@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for not having more in the way of diagnostic info.

Every one of the 4.17-rcX series has hung during boot at the point where
"acpid" starts up.  Beginning with -rc5, the boot actually proceeds to
completion after an "uncomfortably" long delay.

Attempting to run the X11 server results in the following diagnostic
output in "/var/log/Xorg.0.log":

(...)
[   109.951] (--) Depth 24 pixmap format is 32 bpp
[   109.951] (II) RADEON(0): [DRI2] Setup complete
[   109.951] (II) RADEON(0): [DRI2]   DRI driver: r600
[   109.951] (II) RADEON(0): [DRI2]   VDPAU driver: r600
[   109.951] Failed to map cursor buffer memory
[   109.951] Failed to map cursor buffer memory
[   109.951] Failed to map cursor buffer memory
[   109.952] Failed to map cursor buffer memory
[   109.952] Failed to map cursor buffer memory
[   109.952] Failed to map cursor buffer memory
[   109.952] (II) RADEON(0): Front buffer size: 8160K
[   109.952] (II) RADEON(0): VRAM usage limit set to 218167K
[   109.952] (==) RADEON(0): DRI3 disabled
[   109.952] (==) RADEON(0): Backing store enabled
[   109.952] (II) RADEON(0): Direct rendering enabled
[   109.952] (II) EXA(0): Driver allocated offscreen pixmaps
[   109.952] (II) EXA(0): Driver registered support for the following
operations:
[   109.952] (II)         Solid
[   109.952] (II)         Copy
[   109.952] (II)         Composite (RENDER acceleration)
[   109.952] (II)         UploadToScreen
[   109.952] (II)         DownloadFromScreen
[   109.952] (EE) 
Fatal server error:
[   109.952] (EE) failed to map shader -75
[   109.952] (EE) 
[   109.952] (EE) 
Please consult the The X.Org Foundation support 
         at http://wiki.x.org
 for help. 
[   109.952] (EE) Please also check the log file at "/var/log/Xorg.0.log" for additional information.
[   109.952] (EE) 
[   109.971] (EE) Server terminated with error (1). Closing log file.

Everything works normally with a 4.16 kernel.

--Bob
