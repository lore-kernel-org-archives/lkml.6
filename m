Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C20C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441EE2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999771;
	bh=ctj6Eh9IIsiuyk8qk+7IEznBK7ZT7RW7z9w67xP/25w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODMdRnsnzwv0Lz8S1TRJrcMSkLC+1cQ1Sw7oBUODIGunxVnA+h3jrEsnE/HLgGbVi
	 cQZuuBIWhVJnVg8FE56dj3/LFuGa222chPpW860blmZ2HZL3+Q0NtTaZukTERQfg2D
	 bh7qq64kEiqlHmA05rePsPpLuyMBjs/1zVbikFLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeL1MWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:22:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731421AbeL1MPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E6C2087F;
        Fri, 28 Dec 2018 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999310;
        bh=ctj6Eh9IIsiuyk8qk+7IEznBK7ZT7RW7z9w67xP/25w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzwLW5RYC5VMQ/U8s6XGKYojIsOmSm2PHFwvfw5IuxbyTU2qE8pVKH4x0dPDJBGQz
         vN/tLMf99EtpyOvSvIhpirpVMlOYgcjm6vGAaYge6g9LqqSYEYS+Sp5PZjJfD6hSie
         /jo0KmAhyj0bJ1t2ATktOCDAqa7mcaJDr32O2mgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?J=C3=B6rgen=20Storvist?= <jorgen.storvist@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 09/46] USB: serial: option: add Fibocom NL668 series
Date:   Fri, 28 Dec 2018 12:52:03 +0100
Message-Id: <20181228113125.356932332@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113124.971620049@linuxfoundation.org>
References: <20181228113124.971620049@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jörgen Storvist <jorgen.storvist@gmail.com>

commit 30360224441ce89a98ed627861e735beb4010775 upstream.

Added USB serial option driver support for Fibocom NL668 series cellular
modules. Reserved USB endpoints 4, 5 and 6 for network + ADB interfaces.

usb-devices output (QMI mode)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1508 ProdID=1001 Rev=03.18
S:  Manufacturer=Nodecom NL668 Modem
S:  Product=Nodecom NL668-CN Modem
S:  SerialNumber=
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)

usb-devices output (ECM mode)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 17 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1508 ProdID=1001 Rev=03.18
S:  Manufacturer=Nodecom NL668 Modem
S:  Product=Nodecom NL668-CN Modem
S:  SerialNumber=
C:  #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#= 4 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
I:  If#= 5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)

Signed-off-by: Jörgen Storvist <jorgen.storvist@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1949,6 +1949,8 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x13) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x14) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0xa31d, 0xff, 0x06, 0x1b) },
+	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 */
+	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);


