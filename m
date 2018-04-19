Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753587AbeDSNgq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:36:46 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35821 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753081AbeDSNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:36:37 -0400
X-Google-Smtp-Source: AB8JxZomAlAX9mTU+8D45OmenlWPgbv19PBqRNwX+ay6hSAMsI+bYDR17EvK0+i0ogV8TNUVEFZ3wr4Cr+1XiRh98q4=
MIME-Version: 1.0
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 15:36:36 +0200
X-Google-Sender-Auth: _-WoB2pDY3_0mPt-4OSNXqRNO2w
Message-ID: <CAK8P3a0xoOd=WRaaL6EurpD3y78XqAJyJryWwfenrze+7O5L1w@mail.gmail.com>
Subject: Re: [PATCH 1/9] nds32: lib: To use generic lib instead of libgcc to
 prevent the symbol undefined issue.
To: Greentime Hu <green.hu@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Guenter Roeck <private@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 3:18 PM, Greentime Hu <green.hu@gmail.com> wrote:
> We can use the generic lib to fix these error because the symbol of
> libgcc in toolchain is not exported.
>
> ERROR: "__ucmpdi2" [fs/xfs/xfs.ko] undefined!
> ERROR: "__ashrdi3" [fs/xfs/xfs.ko] undefined!
> ERROR: "__lshrdi3" [fs/xfs/xfs.ko] undefined!
> ERROR: "__ashldi3" [fs/ntfs/ntfs.ko] undefined!
> ...
>
> Signed-off-by: Greentime Hu <greentime@andestech.com>

I looked at all nine patches, they all seem like useful fixes:

Acked-by: Arnd Bergmann <arnd@arndb.de>

For the last patch, I commented separately, we might need an additional
patch on top to make it more robust.

        Arnd
