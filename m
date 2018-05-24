Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156161-2-11097090033017626578
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
    1527156160; b=iO5Rgyu6ObeJ2aGGevOnQCZQEK5JmFBnzSnDwLhqCoQ9K0M+ru
    fC6hVsBWtDxa5uP7/NXaheGlRbToI3fX/rf0/LO5JpcBbSbIPS3+8CbsrfWF7xA+
    x1UzZwZEyMEUcEZzj68lyGza+LwvnA8spqHnnhnYMpyzrtXvfb1wEvkxykdhK9L2
    Wh1nlcwSgPyO4VhB8vLiRMV/zUeHUyan8wjdYWb/CTgdGi/hU1p0HvTzyASNJRAx
    WcHpuUo6Py+HCdhwjfUWQUASlf+tlUK2l9TSU6BZV/1C5ATc69ULJZkruSFj4Jga
    4NffK2wIhzi7yRCZuyEMSb3ibacj65kkV8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156160; bh=St43UW+/GQZ2k3KJv6RKygRSx17zmG
    v1HNs47tQFk3w=; b=nPLAmDchYL5AO4ti9q96DV+xQ08Gpk1vraAuQ4dQ1Lm9ZA
    wVQbDC4QzMhIVayHpENXL+77n/peqToZSjyFyrMJjDVWnBqmVf73PdHa823QfrgJ
    eWN/B186saysUrpBnprK0pbsvE0/CR7TqwmhPSWnWfbm3je/6qX01STZGx31Fkuv
    efo3IDmV5jO0GQ2Q7CTyGA9KaXDZGjowB+j2i+Tx/y8X2v/+ScoGiMtWHyXs0V9E
    DJrIy8tjRfs4q1z75Hs37zTYnPYBqCk2DohFAsZb99Mi/ARYLtVjKBYyucDKoqmg
    wVqGQLba7RKjxPVCA58fJPCYnOB7pJVTiiS04TBg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jMt1oEsR x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jMt1oEsR x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNQbfWzwniwhBv8Rj3Ajs5KyCNwy2Dh2ZM+v0qqv8yIqgL3YtcRoL7eRvXQ+L8xQq1NkGOQwRJfC5TvQS0xV86ssxtYWwyJAFkq0dP++kW6/IWZaF3hU
    Q7rOiYtpKYruyYE9HtRC3wE+Z9+sl+jwGxQLcSZ2cnq9HESEQ6kBJ/FQeoWum7GCRHpcrBI48jmljksoGVVj1krEo+MPvWESEOeXrodJ8NsyAWRjvbRi8CV/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=CJJnq0S5wsgA:10
    a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8 a=Dei6p5SHAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=WhNYccqOemL3skWd1gkA:9 a=QEXdDO2ut3YA:10
    a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030765AbeEXKCi (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031112AbeEXKCf (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:02:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tedd Ho-Jeong An <tedd.an@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 083/161] Bluetooth: btusb: Add support for Intel Bluetooth device 22560 [8087:0026]
Date: Thu, 24 May 2018 11:38:28 +0200
Message-Id: <20180524093028.446779968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tedd Ho-Jeong An <tedd.an@intel.com>

[ Upstream commit 1ce0cec1c14cda7e514fa21b36c0f035203b447d ]

The Intel Bluetooth device 22560 family (HarrisonPeak, QnJ, and IcyPeak)
use the same firmware loading mechanism as previous generation,
so include new USB product ID and whitelist the hardware variant.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=8087 ProdID=0026 Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
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
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -340,6 +340,7 @@ static const struct usb_device_id blackl
 
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW },
+	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW },
 	{ USB_DEVICE(0x8087, 0x07da), .driver_info = BTUSB_CSR },
 	{ USB_DEVICE(0x8087, 0x07dc), .driver_info = BTUSB_INTEL },
 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL },
@@ -2086,6 +2087,8 @@ static int btusb_setup_intel_new(struct
 	case 0x0c:	/* WsP */
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* QnJ, IcP */
 		break;
 	default:
 		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
@@ -2178,6 +2181,8 @@ static int btusb_setup_intel_new(struct
 		break;
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* QnJ, IcP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.sfi",
 			 le16_to_cpu(ver.hw_variant),
 			 le16_to_cpu(ver.hw_revision),
@@ -2209,6 +2214,8 @@ static int btusb_setup_intel_new(struct
 		break;
 	case 0x11:	/* JfP */
 	case 0x12:	/* ThP */
+	case 0x13:	/* HrP */
+	case 0x14:	/* QnJ, IcP */
 		snprintf(fwname, sizeof(fwname), "intel/ibt-%u-%u-%u.ddc",
 			 le16_to_cpu(ver.hw_variant),
 			 le16_to_cpu(ver.hw_revision),
