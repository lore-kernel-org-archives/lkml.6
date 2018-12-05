Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C99C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075802082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHGfWmIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075802082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeLEOKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:10:48 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:44690 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeLEOKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:10:47 -0500
Received: by mail-pl1-f180.google.com with SMTP id k8so10109414pls.11;
        Wed, 05 Dec 2018 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=GFWtbv/R72DMYjtxApPw/srLzoRFGQeXnUgvDXIouXE=;
        b=vHGfWmIbI3KRLQlZPTRHitijS4lO1bOodaGzXWvL0Y/EmBp+sLaff8EHue6riyvCQe
         ZwwVM3Pq0O+pIMZ3hl+dz0msjKINEqbwBmiKx0Bgvo4xYJrIe4wEgXAAAuTakbKWgAc9
         QrtHc4jYa8cd2qx8xrfpWmrZ8sV3nuWDsXZduzK/upMJVkyNWJ9X27rtJs/F1WM71RkT
         JrlkkzrAJyrg+jwEhZv/vDRGDypDWiKFu4uRjps7MnmJ4diyRpcMFCDYlIbmU0Lz96lE
         Iw56C/UJxv3195UXwjWjlKb8RBvfqC3FRZGl1Zf79lh+hnRFH+Ad/F4JdzNAVImxR+3Z
         aOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=GFWtbv/R72DMYjtxApPw/srLzoRFGQeXnUgvDXIouXE=;
        b=gdd6FWGtzO2udq0P39LdDUJya6VnEk6ZEHvWG0GMYryrfpkh8boUKFZQah48VOOy1A
         ba87763MxjWXRcapY9izisY1elUbJm66wik6bSqZdma5QghMmcQi+J/xUutKnKqP8Y3r
         iJWJ+Tn38tpiIwq6qV70gKnB3BcoCO3AJZo/JaLChx5On16oV2B7DZWPaMPmUXXdATX+
         l4rH0ikv+lZiE+gYV3CDvPu0jOXvRLP581uv6cVxCjpe3SBzioqg9TvBFke93nJsC1sK
         Khp73jB+v4XiV5U/twmd7IsNf2GfGM7KAgUbF7cRq6Wp/il/bZOihfFUwSadPVhSnZiG
         G0+g==
X-Gm-Message-State: AA+aEWZRJMPOxGasOAsVADYdmDEc1xC7I4PkbCGUmCgVJJklQygDVkEw
        N64zjCL9cFXZx58vL/2Xw3EPLfq8YGY=
X-Google-Smtp-Source: AFSGD/X3MxY6xcO4AuCfGprF54mrqPJWqOgYYfP23zGT4hsZPQQc6285SNFgSJTg/Z8Ep3pDX8rF6Q==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr24281233plq.84.1544019046373;
        Wed, 05 Dec 2018 06:10:46 -0800 (PST)
Received: from [0.0.0.0] (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id v76sm50500957pfj.145.2018.12.05.06.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:10:45 -0800 (PST)
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Song Qiang <songqiang1304521@gmail.com>
Subject: usb: thoughts of adding more support for FT232H
Message-ID: <48bc71bb-68e4-8b29-f609-940c9aedc0a9@gmail.com>
Date:   Wed, 5 Dec 2018 22:10:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,


I've been developing some iio device drivers and found that some people
would like to test their devices with a qemu system which requires an
i2c or spi port on our development hosts. Usually this is achieved with
a DLN-2 adapter, while this is a bit difficult for me because it costs
~175$ in my country. Then I found that FTDI's FT232H supports both these
two modes and costs only less than 5$ but without full support in kernel.
The ftdi-sio driver supports FT232H only as a serial converter.
So I'm planning to write a mfd driver for it supports both these three
modes, here are my thoughts:
  - This device cannot support these three modes together because they
    share some common pins, so I'm planning to add a sysfs entry
    'current_mode' for selecting which mode the device should be working
    on.
  - This device is in uart mode on reset, so default mode would be reset,
    too. This also helps for people only want to use this as a serial
    converter feels nothing has happened (compatible).
  - I was trying to reuse the ftdi-sio driver but it seems like mfd can
    only register platform devices, while this is a usb driver. I may
    have to copy some functions from this driver.

Would you share any ideas? I'd appreciate it.

yours,

Song Qiang

