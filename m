Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbeEVHDT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:03:19 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48880 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVHDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:03:15 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: Apply QCA Rome patches for some ATH3012 models
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180521203452.9705-1-tiwai@suse.de>
Date: Tue, 22 May 2018 09:03:10 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A4990AB0-0D75-4943-AB32-86CF96FC577D@holtmann.org>
References: <20180521203452.9705-1-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> In commit f44cb4b19ed4 ("Bluetooth: btusb: Fix quirk for Atheros
> 1525/QCA6174") we tried to address the non-working Atheros BT devices
> by changing the quirk from BTUSB_ATH3012 to BTUSB_QCA_ROME.  This made
> such devices working while it turned out to break other existing chips
> with the very same USB ID, hence it was reverted afterwards.
> 
> This is another attempt to tackle the issue.  The essential point to
> use BTUSB_QCA_ROME is to apply the btusb_setup_qca() and do RAM-
> patching.  And the previous attempt failed because btusb_setup_qca()
> returns -ENODEV if the ROM version doesn't match with the expected
> ones.  For some devices that have already the "correct" ROM versions,
> we may just skip the setup procedure and continue the rest.
> 
> So, the first fix we'll need is to add a check of the ROM version in
> the function to skip the setup if the ROM version looks already sane,
> so that it can be applied for all ath devices.
> 
> However, the world is a bit more complex than that simple solution.
> Since BTUSB_ATH3012 quirk checks the bcdDevice and bails out when it's
> 0x0001 at the beginning of probing, so the device probe always aborts
> here.
> 
> In this patch, we add another check of ROM version again, and if the
> device needs patching, the probe continues.  For that, a slight
> refactoring of btusb_qca_send_vendor_req() was required so that the
> probe function can pass usb_device pointer directly before allocating
> hci_dev stuff.
> 
> Fixes: commit f44cb4b19ed4 ("Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174")
> Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1082504
> Tested-by: Ivan Levshin <ivan.levshin@microfocus.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
> drivers/bluetooth/btusb.c | 32 +++++++++++++++++++++++++-------
> 1 file changed, 25 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
