Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeCLRFe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:05:34 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35111 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932190AbeCLRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:05:33 -0400
X-Google-Smtp-Source: AG47ELvszZHYNoE2s3i/4OVPDXgGnP+6nMJPWuM8MO0t0MkQYn0SqRmPfMJ/POuqzlRgYbNZ2BQA1A==
Date: Mon, 12 Mar 2018 13:05:31 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Andi Kleen <ak@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
Message-ID: <nycvar.YSQ.7.76.1803121303350.28583@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-2-arnd@arndb.de> <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr> <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com> <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
 <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2018, Nicolas Pitre wrote:

> On Mon, 12 Mar 2018, Arnd Bergmann wrote:
> 
> > arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux':
> > No such file
> 
> That is weird. The Makefile has:
> 
> cmd_mkxip = $(cmd_objcopy) && $(cmd_deflate_xip_data)
> 
> $(obj)/xipImage: vmlinux FORCE
>         $(call if_changed,mkxip)
> 
> So the objcopy must succeed at producing vmlinux for deflate_xip_data 
> (where nm is used) to be called.

Correction: vmlinux is a dependency not a product, so it must be there 
for this rule to be executed, and it is input to both objcopy and nm.


Nicolas
