Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522173731-2-12320758131461945177
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522173730; b=GEhtCyshSPrNz2RxJsQZHADC62tzXaIRA29ffZU2MWmRdVG
    Nzx8DsEt6Zi/mvHXKtUOCyvi8VWybk0Dq0Jj0YX5g2OztyTVMI/pOrRrTbsxdlf+
    rpyVmSitWhVbA5yJjKDJ92Je1CxxZZ57RnU9Ps6jluQqYl9BhBq0rAZihR/6lnAi
    IAA0TZTyjRJa701qwyniCfp0jTbamYrPHK9HYJ8BRoBZsb/jPvB34JnW2VhMZ4ky
    4jfskft55N4YmEaIl051qBOQtr+65n3AriAj7XGMXzVslHh2oQR7X6ZWdytGsbHF
    Ri3jBEeUCoA6i+Hc8tcBehlOW6YEZaGNLVydzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522173730; bh=JJuX/d0/R0FAKHfIluIRiAWegx
    BAm5iWO+aCFe6EicM=; b=IsB5lqdui2Dwi7TCDZKycsjKG3HsGW89RmsmW3phBn
    0Goq/Gez0NLf+AzJwXV779fvvv3s3yuKTyTS+hQOIkoVwgaBwBzBdSkyBs4sXcVG
    G4ruwJPtcWEdNdLAqpnxOIJjmSqTuVj54vIXNppYivy1AEenOqGWVLZ5x0+PjDLe
    SAZwQHRtyrzfO4soFxNQpa7d8jrkXQcf+hMS+vHh79cBZIVImZK3NC43wrKhjJGq
    B4kn7A4K2zih1eJNCZWRia4bhCXwC5uhhJxloBbOjsT1IfN4UMHhT0/N3CnSi0yX
    iB4zm41wNjPsNkaBuQAdW4RL5lb3aW6dxgv+QkSdcu9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF7hRFTl8OqIAh78Sjb6RiqTPzLjByzh9gHSydpSja43bn5QzgfZp1BYoSIa+wG86GyM2oUmVKFaueqxyzl5Ecomsddr4PIlW05aYEZ2tiSSfqh3WLeb
    666D47GMQVOD1ejvyzQTfbvVxkq9TxGLCFwjPCJZO1It8rx6xpzgeavrPkcDPChkXXl2pc7bcz21Zcd/cDIbn408qNwVYGpKBi9YVfFpr0gfKATj1kOvEvrg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=KSb9T-wMAAAA:8 a=n--uj2GoAAAA:8 a=VwQbUJbxAAAA:8 a=Dei6p5SHAAAA:8
    a=ag1SF4gXAAAA:8 a=PwiJE1izc1fLI5tGIvoA:9 a=QEXdDO2ut3YA:10
    a=KF4VuIdXkMyp4E_ug72i:22 a=AM1DvBPG0fw0BKhPEqAI:22 a=AjGcO6oz07-iQ99wixmX:22
    a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeC0QaA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:30:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbeC0Q37 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:29:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Levshin <ivan.levshin@microfocus.com>,
        Takashi Iwai <tiwai@suse.de>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.4 11/43] Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174
Date: Tue, 27 Mar 2018 18:27:15 +0200
Message-Id: <20180327162716.993681146@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f44cb4b19ed40b655c2d422c9021ab2c2625adb6 upstream.

The Atheros 1525/QCA6174 BT doesn't seem working properly on the
recent kernels, as it tries to load a wrong firmware
ar3k/AthrBT_0x00000200.dfu and it fails.

This seems to have been a problem for some time, and the known
workaround is to apply BTUSB_QCA_ROM quirk instead of BTUSB_ATH3012.

The device in question is:

T: Bus=01 Lev=01 Prnt=01 Port=09 Cnt=03 Dev#=  4 Spd=12   MxCh= 0
D: Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P: Vendor=0cf3 ProdID=3004 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E: Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E: Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I: If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I: If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I: If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I: If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I: If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E: Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E: Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1082504
Reported-by: Ivan Levshin <ivan.levshin@microfocus.com>
Tested-by: Ivan Levshin <ivan.levshin@microfocus.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -216,7 +216,6 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
@@ -247,6 +246,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe360), .driver_info = BTUSB_QCA_ROME },
