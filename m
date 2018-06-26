Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298CDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5C2266AB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5C2266AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeFZIVh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:21:37 -0400
Received: from mout.gmx.net ([212.227.15.15]:48593 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752706AbeFZIVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:21:34 -0400
Received: from [172.17.46.209] ([122.224.77.194]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LqQzp-1g25y611Iv-00e2Fd; Tue, 26
 Jun 2018 10:21:23 +0200
Subject: Re: [PATCH v2 net] nfp: cast sizeof() to int when comparing with
 error code
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Joe Perches <joe@perches.com>, jakub.kicinski@netronome.com,
        davem@davemloft.net, LKML <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>, oss-drivers@netronome.com,
        netdev@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20180626011631.22717-1-cgxu519@gmx.com>
 <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
 <alpine.DEB.2.20.1806261005190.4512@hadrien>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <a119eba4-aeb5-c8ee-ff48-07ee566d8431@gmx.com>
Date:   Tue, 26 Jun 2018 16:21:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1806261005190.4512@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:2ioQTmi2mIk7Q5IZKqPXZXFlyiCTquiiyMoHmOm1+fLBYAHk/Cd
 /a1pPjL6ZaTgKnvUU/tCC1oIoi7yBwnXxhP33nFEIZ7pxGO8hs/r8fUOnqfK0oyn20ls3UN
 tsOPIhON0lu3TN6LKit7DNWUe0wLaEbL/ijRt5naTXcmskXEOewoUSRM4p8rjzBsseI3BUG
 PwgjnmyTeG859ZhqZuw3w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UN/tP1SvHtc=:K4rIOsvgSO+kxcGUjcQIJb
 dYCQwNccW61Xru5ZStvGWKBxoeARzFgxKzA51f85LSq1Z8WP2iGqyEJSeRcEsNhtViJ5XtQYj
 PE5GPI+aqN64m2c02tYt6QHTICTNvd+irYzMGMFDKB3+VIHKiGUnlFpRM6kwWspuDTy6piTDE
 p687Yk4XSDfm9jBMf5tvdxHwdUsUuCxBy/Vs82JlquOGh/ryLOmxmkYd7SDoFFUj/y7PITsXe
 TdYuSfd1JZezZ23Z8OHqFM92uhpijS+1Z+6m7zPhvYcITOsq5IZ9cmKnN2PGi6gDBhLLCyj5y
 1J7tlIj1oL7IFwKnSgEANcZk6rfushhbMkwWZEf5ejVVfy7y+q0ZAwLt/LUpKmK0hlbM8wVDv
 IRv/NRIjjxr0+9cKUod7IoBnoalW8Nt17HptDa1d3y1bfYPRRXpahtiLOO1gVH52hTf8RcZDi
 4qPbL7gdBCmvjrbxV5VM2uMzd4gA7MD35xLq3RbtKKpJxLEMxJhktK8s3Xq3UU+2/5yfQHgV9
 1KpkBq6ss9L/NTcCLjZhmXj3g+0181Kqu7oBrYFWaopv7pjR8vf30+0ay5KA+H57Q3aukuDoI
 KTf3ZVURTQ4uR/Bkj1Y6O8EjsFKsLjVZBF6Sl61BRDdzMcBm9K2Y6u57fY0veLJ1hmNAvblnT
 3miYoFtav4AYTLh0NYIwGBPqNImzTjYxv9busxW2u7m82D6QbD4nu4nptmF8V3BojxsfARKKm
 FpQZSQVBZvHWkxVw2k5IT3j3W4Vb7B2IX6WfFFzLjmwSO/itknzSt8WjsqG558Lof8jO2LIaD
 +9RWKR0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 04:06 PM, Julia Lawall wrote:
>
> On Mon, 25 Jun 2018, Joe Perches wrote:
>
>> On Tue, 2018-06-26 at 09:16 +0800, Chengguang Xu wrote:
>>> sizeof() will return unsigned value so in the error check
>>> negative error code will be always larger than sizeof().
>> This looks like a general class of error in the kernel
>> where a signed result that could be returning a -errno
>> is tested against < or <= sizeof()
>>
>> A couple examples:
>>
>> drivers/input/mouse/elan_i2c_smbus.c:
>>
>> 		len = i2c_smbus_read_block_data(client,
>> 						ETP_SMBUS_IAP_PASSWORD_READ,
>> 						val);
>> 		if (len < sizeof(u16)) {
>>
>> i2c_smbus_read_block_data can return a negative errno
>>
>>
>> net/smc/smc_clc.c:
>>
>> 	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
>> 			     sizeof(struct smc_clc_msg_decline));
>> 	if (len < sizeof(struct smc_clc_msg_decline))
>>
>> where kernel_sendmsg can return a negative errno
>>
>> There are probably others, I didn't look hard.
>>
>> Perhaps a cocci script to find these could be generated?
> Here's another one:
>
> drivers/usb/serial/ir-usb.c
> @@ -126,13 +126,8 @@ irda_usb_find_class_desc(struct usb_seri
>   	if (!desc)
>   		return NULL;
>
> -	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
> -			USB_REQ_CS_IRDA_GET_CLASS_DESC,
> -			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> -			0, ifnum, desc, sizeof(*desc), 1000);
>
>   	dev_dbg(&serial->dev->dev, "%s -  ret=%d\n", __func__, ret);
> -	if (ret < sizeof(*desc)) {
>   		dev_dbg(&serial->dev->dev,
>   			"%s - class descriptor read %s (%d)\n", __func__,
>   			(ret < 0) ? "failed" : "too short", ret);
>
> There are other results, but I haven't checked all of them.

Hi Julia,

Thanks for your check. I posted a patch yesterday to fix three places in 
usb subsystem
and the patch is just in queue now, so you can skip these places.

The detail of patch.
---

diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 24b06c7e5e2d..7643716b5299 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -132,7 +132,7 @@ irda_usb_find_class_desc(struct usb_serial *serial, unsigned int ifnum)
  			0, ifnum, desc, sizeof(*desc), 1000);
  
  	dev_dbg(&serial->dev->dev, "%s -  ret=%d\n", __func__, ret);
-	if (ret < sizeof(*desc)) {
+	if (ret < (int)sizeof(*desc)) {
  		dev_dbg(&serial->dev->dev,
  			"%s - class descriptor read %s (%d)\n", __func__,
  			(ret < 0) ? "failed" : "too short", ret);
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 958e12e1e7c7..ff2322ea5e14 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -194,7 +194,7 @@ static inline int qt2_getregister(struct usb_device *dev,
  	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
  			      QT_SET_GET_REGISTER, 0xc0, reg,
  			      uart, data, sizeof(*data), QT2_USB_TIMEOUT);
-	if (ret < sizeof(*data)) {
+	if (ret < (int)sizeof(*data)) {
  		if (ret >= 0)
  			ret = -EIO;
  	}
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 2083c267787b..0900b47b5f57 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -104,7 +104,7 @@ static inline int ssu100_getregister(struct usb_device *dev,
  	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
  			      QT_SET_GET_REGISTER, 0xc0, reg,
  			      uart, data, sizeof(*data), 300);
-	if (ret < sizeof(*data)) {
+	if (ret < (int)sizeof(*data)) {
  		if (ret >= 0)
  			ret = -EIO;
  	}
---




Thanks,
Chengguang.

