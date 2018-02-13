Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965402AbeBMRAq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:00:46 -0500
Received: from mout.web.de ([212.227.15.14]:34781 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965372AbeBMRAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:31 -0500
To: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] efi/apple-properties: Delete an error message for a failed
 memory allocation in unmarshal_devices()
Message-ID: <145f8fac-9297-b362-d89f-886632e2507f@users.sourceforge.net>
Date: Tue, 13 Feb 2018 18:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:zyhSeTm/Ia7asL82uFEJ99fFpVw1jgO2vUzTjkJ9YzFfmN6HFMP
 1EszfOPamqNBER/ZtOqhGa1Jwnx/V4k8NYrFNiVEX6lzYziZIi1FGVAfKSHwQ28Sh2Y8NTF
 6PvZ8t2dZFcfzlnaQfVIheTSkUU++aifmIjso9ifP5mW83jcuKwlqnqleDypNPyE3KmENFA
 m//GPBBx+YGwUB+4Q1q3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ms2XmHeCpZ0=:tswU/2ZIrOL24N8JgneTSu
 L72sWkFySYylAI3fMfsItq/AJWpmkVK11VCe13iLlkZ3tMV5mXyNENKFgMhht+Z7asoGOER4U
 kYqhWupnqMQC5FYpLVqZHhgBKIq/CYCocLVeCm408UnqWFxfkg7efRUvIvwrw6pTZDjkKPO72
 nUJ2E01dc3B4uaUNh6WRV4HCSX0oCjOZJ908M6dabmIn9cdGKaZsIwmCEmmM6ECOf3dUYeT/6
 UTeTBYXY99fdmqVqx5C3HgytG+TUUW4VNMWrQ/xqJ6Vcsenv7M2wTLlO9sBRF8W2mwCe6+qt2
 X6LFzXiEZHmP04h9HyFkQpaxvd+detMMlg7efew39JVY9unZcVYU8a2gJucanZhu5sX1WZy0O
 ET1lAaJrS/XrNXIMXg3uH8M4k6021QujCASrIzBZIF7jYiy0mb3/zNwW72JBzkYaBLkvEbc/4
 ky4eUhjhso8CHPa8gS94fk5EZhGD36QbMoeOSUFXaFnXmceDHd+Y/oht6x1PfZS57muemOEqV
 2RoBeFTfurOSBcVPk7MGa7/IGqzdWk+gSSAd1SFZCvwb9FuFS3FTE8NruLBcQtZ2ngPB75wgm
 5u6ajq1EqE5P4kFSj2zE6ers7auxy5nHsRzAdH2cYlViQ0TymJgDzFg4AvcboiaRpXwUIv+06
 Y/0nlgfi/2XtA5KxERsSP4SUZV61Ny+sYofAoFij7hj1Akf2L2Gadw25Fc4/FgL3TFR2PT2qd
 xc07nymehaeP+SJxr248hBVpVEEKRZGc1Mdcut0Z6nrEPSVQ/WUo6lkP+ymqoRvkOTR2sBTlL
 KfwasYyLEhcbBNbXen5gec3nPkdomLv9OMHsD9gh8uoniVjWsw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Feb 2018 17:52:10 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/firmware/efi/apple-properties.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 9f6bcf173b0e..f5f3159df4d5 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -158,10 +158,8 @@ static int __init unmarshal_devices(struct properties_header *properties)
 
 		entry = kcalloc(dev_header->prop_count + 1, sizeof(*entry),
 				GFP_KERNEL);
-		if (!entry) {
-			dev_err(dev, "cannot allocate properties\n");
+		if (!entry)
 			goto skip_device;
-		}
 
 		unmarshal_key_value_pairs(dev_header, dev, ptr, entry);
 		if (!entry[0].name)
-- 
2.16.1
