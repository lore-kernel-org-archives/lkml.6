Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196D6C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA2020863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549624954;
	bh=jtFZT6pg2xfaAZLc1Bs3aw7RsCOZYo5J9JbMUrLw39w=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=S0Vdk9nPpOQL+crhsVd4LphrXgjLq8D0M7o7UWf2uh9zalkqxC+8hqJQzKekimWfr
	 Sl2YstMtov4fZUL85VmklT2Mg+BMEmqK1mDDC9Q5IJDkqTVMy/PweRmYU+9SkBrXMA
	 WYaTxVJerotVyaX254DBuExAxcMAwjNGXTCEW/Do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfBHLWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:22:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45212 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHLWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:22:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so5163004ota.12;
        Fri, 08 Feb 2019 03:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=p84v49WIlZL8pX0+KpZTS18uSWpifEkuiw1CUi8FD+E=;
        b=SOj8VM0cIoae/WUl5Rl1z4ZHHPcoC+6vhKoTAolufq+l20YKXV5veoHRWPENr8ZyC4
         fJbnuTrQJ36rvXbyrRgNikY/lZJRryH3TZHshEC3GEaoV22LNuNeTQeJcNX+WfBKjfY2
         K/3BU+P5z3yFLXFrLS18p8N3EcGvgLNJJFb7QVHqNrny2EN9BAiWrYfOk6fQdB5/nJmy
         R4J0/Nz5JSG/LIi3V555unNN2f2STMl7aKQl49RPgg0iAPiYzsW6kECjjVKJMkEB444W
         dEubMmAm3lM7Ff3XkYSHIEfmfjeDDlRZVF1N8V+/zPOQL6JjAsLF3SYY1CgWLiOL79Wp
         Pzww==
X-Gm-Message-State: AHQUAua87fU4LJjZyyIoxSlIWiSEWth0/d0+iRVSeGoYMLR/d2XcWfqd
        hTCyavnwhtFQ7Xnm0u70b3krPT4KDe5Em6EUGEvunyxm
X-Google-Smtp-Source: AHgI3IZbJozjn+bJh9kKevVr07Ar8u1wf/DQDYrLYkHjQs2khCMqQaEYklCAN5kKrteXl9P9v0LlFhmiV8htGlx3nBU=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr11639653otf.124.1549624951450;
 Fri, 08 Feb 2019 03:22:31 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Feb 2019 12:22:20 +0100
Message-ID: <CAJZ5v0hX3PB6k3GCP2y9MYGJiYH6Fvg=cFdUNuDx0FB5UnVY3A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.0-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.0-rc6

with top-most commit ce5cbf53496bfebe1b7478a532820373342e8302

 ACPI: Set debug output flags independent of ACPICA

on top of commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5

 Linux 5.0-rc5

to receive an ACPI fix for 5.0-rc6.

This prevents excessive ACPI debug messages from being printed
to the kernel log, which has started to happen after one of the
recent ACPICA commits (Erik Schmauss).

Thanks!


---------------

Erik Schmauss (1):
      ACPI: Set debug output flags independent of ACPICA

---------------

 drivers/acpi/bus.c | 3 +++
 1 file changed, 3 insertions(+)
