Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35202081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOWdvebb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F35202081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeLEO3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:29:24 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44927 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:29:23 -0500
Received: by mail-pg1-f180.google.com with SMTP id t13so9079098pgr.11;
        Wed, 05 Dec 2018 06:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Hh30y7nFFzinjgoOoXb+ViLeqHlFOg1c1L2H1D4xVIo=;
        b=mOWdvebbADLhGCT2hNxf4rKDez9W2tmuABzAP23tH9sCsX4kshjBhH+skHCEHuC5mS
         GOLU6ISvXEVckAcXgNJWqFAYAarJAEqErSvylfjhPnP4wiUZLKbhz5INXc8SywjPHm30
         zTKdc8hCuzXaAEsXIMNx29+RN0MXuoEp8QqNjqQQAdumlSWb5k3quRkK7W840n6ME3gv
         e1wvi13LoFdSsHHuSTfZkFCt/j3KkwFkbdc5U0jrWRxRfESxLVKLEs+04ug/0IIU+vNT
         iKxOZY6JUceeuCAmieQze3//qsfCezIM6z24YyvT69tWuRt0o62h5DLf+nygwwrIW4fU
         e+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Hh30y7nFFzinjgoOoXb+ViLeqHlFOg1c1L2H1D4xVIo=;
        b=M8W3e6dwYsUPPTL6LK/iUE0w+w2sGpMtj518wTnzOnappdwAQeE1v/T5J7xf7dddhd
         //wnsRlXcbHC7P8Cj8zHOG1VU5AdRdcH+J265zp/mK35hlWHOIrYbTeGcZ50JzII+VOr
         dBkQuAMsIsPMiP7J35zwGneacBPLDmBfOp9VGk3YXAa48FiBkvHXozs/WUceooVmw/eC
         2IdCA+SCZ1iD49TGIr+quvaBJByHvY8w0EWZZ1n3dMI3dpiBNBjxlKF7zmvRMRKlcU/2
         +MM4a4FjWSRoR/7Dy+k8Xk402bL/6jLF7FOXl8b68FKiS1/ChCfUdVU7rQfVJL0eGl8E
         IvRg==
X-Gm-Message-State: AA+aEWaBd8rtw9TSK/YKUZbF0NUxeppD63AY1VAjgyRxFTiTlENjz9Jd
        fvXrysMH9702r4xsXk7N6cvTr8JEA4M=
X-Google-Smtp-Source: AFSGD/W33936He+IM0w2Mefk1IRhucRu0W/MvP4oA9Yz5/ymnpwflSadF3I89hX7XZ70Z67n/Ho6hA==
X-Received: by 2002:a63:6704:: with SMTP id b4mr20760328pgc.100.1544020162519;
        Wed, 05 Dec 2018 06:29:22 -0800 (PST)
Received: from [0.0.0.0] (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id b7sm29049849pfa.52.2018.12.05.06.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:29:21 -0800 (PST)
Subject: Re: Externally multiplexing interfaces on the same processor pins
To:     Frederick Heinecke <fheinecke@ksu.edu>
References: <BL0PR05MB4594E94CC5D74DC038E35EFBA90A0@BL0PR05MB4594.namprd05.prod.outlook.com>
From:   Song Qiang <songqiang1304521@gmail.com>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-ID: <ca1c00e1-8104-b697-24dd-d43a47adcac1@gmail.com>
Date:   Wed, 5 Dec 2018 22:29:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BL0PR05MB4594E94CC5D74DC038E35EFBA90A0@BL0PR05MB4594.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/18 2:46 AM, Frederick Heinecke wrote:
> Hello all,
>
> Does anybody here know how the kernel handles externally multiplexed peripherals and and what the proper way to setup the device tree for multiplexed peripherals? For example, if I have two interfaces (say USB and I2C) on the same pins, and I want both to be available and usable (not at the same time of course), does the kernel natively support this or is this something that needs to be written into the drivers for both interfaces? Could the kernel or a user-space process potentially attempt to access both at the same time?
>
>   Here's a poorly drawn example of what I'm asking about: https://i.snag.gy/SJQnH1.jpg
>       
>   Thank you,
>   
>   Fred Heinecke
>      

Hi Fred,


Recently I've been looking at a devices just act as you described. A FT232H 
adapter. It has several interfaces including i2c, spi, jtag, etc but share some 
pins. As far as I know these kind of devices should fall in mfd subsystem and as 
for mfd subsystem, it handles devices with functions enabled together. Doing 
what we want would need dynamic device register and unregister support. I;m just 
planning to write a more support driver for FT232H and I handle this situation 
with another sysfs entry 'current_mode', through this, I select which mode this 
device should be working on. I haven't found any facility in kernel supports this.

Would you share what you device is? I think we can help you insight the 
corresponding driver and check how did the manufacture do with it.


yours,

Song Qiang

