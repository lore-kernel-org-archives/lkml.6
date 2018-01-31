Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeAaPlT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:41:19 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:47098 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbeAaPlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:41:17 -0500
X-Google-Smtp-Source: AH8x2252UuXdxxlwcYTMySyZ62ws84AZolO+Lmp9LWVdaK4dzgzgBJkANnUpJh4GG2ebICLHodf1Sw==
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Rob Landley <rob@landley.net>
Subject: Allnoconfig build still broken on x86-64 in today's git.
Message-ID: <fa7661d0-bb0e-4d2d-8f55-511a6edadee9@landley.net>
Date: Wed, 31 Jan 2018 09:41:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ make clean && make allnoconfig && make
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf  --allnoconfig Kconfig
#
# configuration written to .config
#
Makefile:932: *** "Cannot generate ORC metadata for
CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or
elfutils-libelf-devel".  Stop.
$ grep CONFIG_UNWINDER .config
CONFIG_UNWINDER_FRAME_POINTER=y
# CONFIG_UNWINDER_GUESS is not set
$

Still an unnecessary dependency that breaks the build even when it's
configged out.

Rob
