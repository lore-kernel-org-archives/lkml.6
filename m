Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527162276-2-862916610491962528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162275; b=etxTE3XbkD1T6WXCyzFK2H2BfWsvb9GRwECltXjqnRv4mDyrt1
    z6YamXjK6rL5wRVF7Sk836MLBNPA2qAVg9LRXn2wmmkAYwPoD0mOO/75YywBCSx6
    ios8Wg4B5EIBNuwz5Ed7daXNes+DNAHu46b1DabVbSwXHNVu1YDCYcsMd+Jm1Ms2
    FPTYWtlekAbRfKomzdEcwGyZ3DYYdK+CCcxB7N5zoOSjsBPsHSh+sPK437m1CUby
    NX6YkZLizYpC4SKeqT4fompKVshlSIOqiiKutG6xN3SkcE7pGVPCEFfNNVF3SKsx
    /vJV3YcMNfJonPkLbn6CY8Y7R5MQWKsIQYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162275; bh=EsYuvGMkDd3ehAZI8LVVM5gdsS3ODu
    KzjF+4tvdT07A=; b=nS4VkoOX8PmqghtuGzxR6W4tYBvADF67x+asfGS/D3vbSs
    HHeygjq68M5YLhwIgwpGM5m5URKZglFVOHPxZuT+5G91JCyJt16uk8J/iPoyPp1I
    UdsbYaNpbXMkZ2HUG0am8Lny4tyt/9z1rpBwgXvXNlS4Amjxn1rluXqSINaMhXrl
    FoCJ3EGVox0LhHrMUVLp9vEEVtCE5oTBe8ZhiD6x19qAghv2VHx5QvQKRsEVdbyT
    qfijX0e1e9RLlgyMyIne9vWA8mALENwfvKlCTVFW0GNvtfF5TPTZgicDlHMHTCBU
    V6hN9G2s8LKJoX3ALIeo5Q89xA/4qeNQ5tyVkQ5g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IW+s3dhK x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=IW+s3dhK x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDQsD4X7tqyFhbzPhhetyLJRSFHKqxYH6Nh/fr9YXxRSGwpom51y9c05OxzPPD3TfrYuqFY361ON69EQWtnB0uGl59CC9boHzoChmW9FzHmgl2o/311A
    Jww64/0jSkuz2smqioCbgFBDTAQCY15UQF0yXvJNNFMNUIDqm3CsRDVjT+hf65MJAIU37SHFZeUBWfaobRoWH/BIN45wjJs+BJaZz4QLGVb9nQozOrgizJbQ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=I9J5_zRYAAAA:8 a=Dei6p5SHAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=6IOA-Uz3KzGYF-SfUO8A:9 a=QEXdDO2ut3YA:10
    a=U1TWXoLsWgfj-NM_hS__:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967193AbeEXJsQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966909AbeEXJsN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vicente Bergas <vicencb@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 34/96] Bluetooth: btusb: Add USB ID 7392:a611 for Edimax EW-7611ULB
Date: Thu, 24 May 2018 11:38:17 +0200
Message-Id: <20180524093607.532254379@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicente Bergas <vicencb@gmail.com>

[ Upstream commit a41e0796396eeceff673af4a38feaee149c6ff86 ]

This WiFi/Bluetooth USB dongle uses a Realtek chipset, so, use btrtl for it.

Product information:
https://wikidevi.com/wiki/Edimax_EW-7611ULB

>From /sys/kernel/debug/usb/devices
T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=7392 ProdID=a611 Rev= 2.00
S:  Manufacturer=Realtek
S:  Product=Edimax Wi-Fi N150 Bluetooth4.0 USB Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 6 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtl8723bu
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=500us
E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -345,6 +345,9 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x13d3, 0x3459), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3494), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8723BU Bluetooth devices */
+	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
+
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
