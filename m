Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F028C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D1420834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 23:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D1420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbeHaECL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 00:02:11 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45109 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeHaECK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 00:02:10 -0400
Received: by mail-oi0-f65.google.com with SMTP id t68-v6so18617367oie.12;
        Thu, 30 Aug 2018 16:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GABArCJlFdh0Wfdqt3IygZxkcQ4SlmnpHrHpBxBlkqs=;
        b=mOF60PmEUsKo1RMpOJiqgQj2QB+bzjjzMxOoNFizITmnmM2DQRFuhT4E+iPZUBQSc5
         oALrAqZjAkSdba08YpYcyQw58lE68ucreQh7nhWxl7X7Ow91qkcKSF8HMhlo19I6ujnC
         KIR/MciTbuur1AbaIhhQYZcwunEJ5Fo28HdfoCXDuxBqFxdj+KPSmscWQDwrmS/Q0LuE
         bIF9Kv5ca/ZaZkbpUJDjO0gmoOaYlycn/9XF3JJQVZZLcC7k9oVfx75bA7eePQmyZ+8+
         Zivzyd1AI8TvqjCPXrNYmulYmTtvoeY8BtXnMMFRjWKfSdxCs+uSJRVxGDn0xjC4C+tu
         uUEw==
X-Gm-Message-State: APzg51Bxw6gANEggn0pjnUaUVlbc0jfQgtxxOoCDrgus/m3Sic/G0c0j
        LZJQxYzEQyJ/z1us6dVbAbCOl3p4dD3NidoQYk8oF1cd
X-Google-Smtp-Source: ANB0VdY75sBrgkDr6aowlOxiWnmdDPamkVvpTb6Rx+/KF0EWBBl/xYSsDUtGKVB3xappuYfCPlQdijv1gFQXh/RW6zA=
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr5032472oif.180.1535673451356;
 Thu, 30 Aug 2018 16:57:31 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Aug 2018 01:54:54 +0200
Message-ID: <CAJZ5v0hBmEFyUhhqgUKuvh1DcpuN+FdPkN9_Nf+hUHm9tjtC6Q@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v4.19-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.19-rc2

with top-most commit a0b9c4de7bf3dacc32a7e70fff25e158a0bf848f

 Merge branch 'pm-core'

on top of commit dfec4a8478e8e81483a94b663f13153bb7796800

 Merge tag 'pm-4.19-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive power management fixes for 4.19-rc2.

These address a corner case in the menu cpuidle governor and fix
error handling in the PM core's generic clock management code.

Specifics:

 - Make the menu cpuidle governor avoid stopping the scheduler tick
   if the predicted idle duration exceeds the tick period length, but
   the selected idle state is shallow and deeper idle states with
   high target residencies are available (Rafael Wysocki).

 - Make the PM core's generic clock management code use a proper data
   type for one variable to make error handling work (Dan Carpenter).

Thanks!


---------------

Dan Carpenter (1):
      PM / clk: signedness bug in of_pm_clk_add_clks()

Rafael J. Wysocki (1):
      cpuidle: menu: Retain tick when shallow state is selected

---------------

 drivers/base/power/clock_ops.c   |  2 +-
 drivers/cpuidle/governors/menu.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)
