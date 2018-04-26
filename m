Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755992AbeDZNHE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:07:04 -0400
Received: from mail2.overkiz.com ([80.245.18.67]:34748 "EHLO mail2.overkiz.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751713AbeDZNHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:07:03 -0400
To: linux-kernel@vger.kernel.org
From: =?UTF-8?Q?K=c3=a9vin_Carli?= <k.carli@overkiz.com>
Subject: Custom module to add device tree overlay - kernel 4.14-rc4
Message-ID: <8fe8056e-f22c-40a6-0697-0d80cd0d6f2e@overkiz.com>
Date: Thu, 26 Apr 2018 15:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I made a custom module using the kernel API (of_fdt_unflatten_tree + 
of_resolve_phandles + of_overlay_create ) to dynamically (after my 
kernel has booted) insert an overlay.

It seems to work just fine, I can see the result in /proc/device-tree, 
but theses changes are not propagated to /dev or to 
/sys/devices/plateform. So I can't use what I have added using my overlay.

I first though that the device/plateform driver was not re-probed, but 
even if I include a line like this one :

platform_device_register_simple("at91_rtc", -1, NULL, 0);

it does not work :/.

So I was wondering if someone knows a way to dynamically add an overlay 
and can see the changes. (not only in /proc/device-tree).

PS: I don't use U-Boot, nor configfs, and I don't want to use my overlay 
through the bootloader.

Best regards,
Carli-K
