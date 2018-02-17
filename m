Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751088AbeBQBlG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 20:41:06 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:63066 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751068AbeBQBlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 20:41:05 -0500
To: Lee Jones <lee.jones@linaro.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: Suman Anna <s-anna@ti.com>
Subject: syscon regmap for disabled node?
Message-ID: <e9863f03-f1b5-9158-76f3-37158a0b4cd4@ti.com>
Date: Fri, 16 Feb 2018 19:40:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.247.58.153]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pankaj, Arnd, Lee,

I am testing some code to use a syscon/regmap interface and I find that
the syscon/regmap is initialized even on a disabled device node using a
"syscon" compatible property when I have expected it to fail. Prior to
commit bdb0066df96e ("mfd: syscon: Decouple syscon interface from
platform devices"), the driver would have never probed, and the
of_syscon_register() only checks for the compatible, but not if the
device node is available. Is this intentional or a bug?

regards
Suman
