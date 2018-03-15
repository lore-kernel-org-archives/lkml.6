Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932513AbeCOSc6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:32:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58521 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752220AbeCOSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:32:56 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluebooth: btusb: Fix quirk for Atheros 1525/QCA6174
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180315160234.21789-1-tiwai@suse.de>
Date: Thu, 15 Mar 2018 19:32:54 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Ivan Levshin <ivan.levshin@microfocus.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D780224D-FFA1-4965-AF3D-299BF0A3D32B@holtmann.org>
References: <20180315160234.21789-1-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> The Atheros 1525/QCA6174 BT doesn't seem working properly on the
> recent kernels, as it tries to load a wrong firmware
> ar3k/AthrBT_0x00000200.dfu and it fails.
> 
> This seems to have been a problem for some time, and the known
> workaround is to apply BTUSB_QCA_ROM quirk instead of BTUSB_ATH3012.
> 
> The device in question is:
> 
> T: Bus=01 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
> D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P: Vendor=0cf3 ProdID=3004 Rev= 0.01
> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E: Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E: Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E: Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E: Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> 
> Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1082504
> Reported-and-tested-by: Ivan Levshin <ivan.levshin@microfocus.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
> drivers/bluetooth/btusb.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel
