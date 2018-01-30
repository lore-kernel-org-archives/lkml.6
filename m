Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeA3SOV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 13:14:21 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:53982 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752122AbeA3SOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 13:14:20 -0500
Date: Tue, 30 Jan 2018 19:14:16 +0100
From: Lukas Senger <lukas@fridolin.com>
To: giometti@enneenne.com
Cc: linux-kernel@vger.kernel.org
Subject: pps-gpio falsely reporting echo capability?
Message-ID: <20180130191416.175d4550@dinghy.localdomain>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K0:oWM4XWSVtquVxoHOGfQ+rVv/RqyTfGGoxjRwiosRU0glMbkczHs
 ukh0XioospcNYE3IGXgZ0IM2SlgB8w+f00FG2RSMbDyTeaEFVMjEl3mc2PJWc4X11lbQdPb
 HUY+GJDcipASVPlO2CQu2zCBK7H04dBIiMouFfrsEVopEssq8OWZzpxX2KjcS3dMJLZ3jje
 lwh7ULk3q7oDCJ53jrBLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/asgbUfy7+M=:DOMhJDHapTx1fjwqQAtkA5
 EFUaNNM4t8mjB+VXIqR8OnNrHEhDYybMTFNFVJRT4niXIPyKsBxg6kj1TIz/W/MVZD2KBNmq7
 BRgU+JsWqBfmohsJq3kXCTiaTa7m5GLpebtYEYIe+TdR5grt1IfcTdULjgnLsceu3Xv0Lz81T
 pY9VKhUwTTdsGpnvg0v5Uip/HHqDKN9FJqA9zydjLh8nyTbAgIs64E/zgfTtUteIGX4htuxAB
 33G/eQaQ3CmVKR12pEho6vZ/ac0XFtZ6uN5aJHvVwgxA0wqbF2JSU4DDuQzVPGBcLw54BCSH5
 y49+7R7N2lAXIMIkGhEt3anyOFdlYmwx/RXgZ8S54jks5W6ZCNJIoGDB1WEYsdzMTxIJybDLs
 jbCvdDv+ypflUlvQJTCAzh6xPDM2QedoAVEi49khTm/fFFAubSYBmMLV+3kv89xFI1VYDrmIh
 HOdbm3A8yPkr0Z97MOUmgRSzOD/gHhwjNv6IlqzT4UbR0VnTRQT7gJVAm/zZr0JGjKthqOdy1
 RVlMeR39pdFGSdPpAZ1pa3iuImW+iElur7mIPGXavqHSjsqpi2Wjn6cmkSSK4aszlK8ELhoRX
 wNTdH0GtWHI9AeeeMbp79ztCaZ93MaqD5A9z8VT+WxEwCjc3yrx+XIrXukvlgfx0Nua51wof4
 HUfiWxRRXF5u/9zUtUE+YdDmVhYVB+gNbg9q9w9M5JyQCHeBCZXRLuwS6iDQxrxe0CmyU+3B7
 +CcgcxaNvGgaplyRnYrRNDkllb2S6iNd7LN2c59buuuYtvNRedZxc2SjWTQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use PPS_ECHOASSERT with the GPIO pins on a Raspberry
Pi. /sys/class/pps/pps0/echo reports 1, however looking at pps-gpio.c,
no echo-callback is registered. Am I missing something or should either
sysfs report 0 or pps echo be implemented in the client?

>From a quick glance at the other clients, the same might be true for
pps-ktimer and pps_parport. They both report PPS_ECHO* in info.mode but
never define info.echo.

Cheers,
Lukas
