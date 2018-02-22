Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933343AbeBVQnD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:43:03 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35488 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933197AbeBVQnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:43:02 -0500
X-Google-Smtp-Source: AG47ELsg4qDPIHvVK/zDBySRF1NXuLWnahmMVFJ8mJiO0gVxvl0tR/tNcSBSbtHoW5rnwyeCAkbA+fz3MM/o4QkztCU=
MIME-Version: 1.0
In-Reply-To: <20180220162519.1498223-1-arnd@arndb.de>
References: <20180220162519.1498223-1-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:43:00 +0100
X-Google-Sender-Auth: -X_jT3kDLk5fSaqzksGs4mggYo0
Message-ID: <CAK8P3a36AuFon2vC+6rz+_-kBaeceBvwMYCNX8=+SrdT3-ZqDg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: clps711x: mark clps711x_compat as const
To: arm-soc <arm@kernel.org>, Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 5:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The array of string pointers is put in __initconst, and the strings themselves
> are marke 'const' but the the pointers are not, which caused a warning when
> built with LTO:
>
> arch/arm/mach-clps711x/board-dt.c:72:20: error: 'clps711x_compat' causes a section type conflict with 'feroceon_ids'
>  static const char *clps711x_compat[] __initconst = {
>
> This marks the array itself const as well, which was certainly the
> intention originally.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to the fixes branch now.

      Arnd
