Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBKCnO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 21:43:14 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:54409 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeBKCnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 21:43:13 -0500
X-Google-Smtp-Source: AH8x224gBvoqUsN2EJtRjhE9lz36vdYYsYJpaBfH46kJwmSyV7Z3eS52Wqlj8JYITuFKifxOVApV0g==
Message-ID: <1518316987.5562.7.camel@gmail.com>
Subject: [BUG]: A83T - AC100 gets the wrong number of parents
From: Philipp Rossak <embed3d@gmail.com>
To: linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com,
        wens@csie.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org
Date: Sun, 11 Feb 2018 03:43:07 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

When I boot my A83T I get the following bootlog [1].

After some debugging, I found out that the function call:
clk_hw_get_num_parents() returns 2. After a look in the devicetree I
found out that this value should be 1, since we only have one parent
clock [3].
Setting the variable num_parents to 1 fixes the problem, but this is no
soultion.

Regards,
Philipp



[1]: https://pastebin.com/5c7hxjsS
[2]: http://lxr.bootlin.com/linux/v4.15/source/drivers/rtc/rtc-ac100.c#
L180
[3]: http://lxr.bootlin.com/linux/v4.15/source/arch/arm/boot/dts/sun8i-
a83t-bananapi-m3.dts#L159
