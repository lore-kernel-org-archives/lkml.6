Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A6FC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C5B20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C5B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbeK3H76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:59:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39760 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeK3H75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:59:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id g27so3098912oth.6;
        Thu, 29 Nov 2018 12:53:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Zq2IUD5lOqBgnyxyPHhqckOBOCG51YMe00ZKlcs6mzU=;
        b=PFn1/hI5YFRIsLUoR0B2YV4Ikhvdq9AK2MsbwtugvsSNVYq+ioHgFzqOweh1ITOJfr
         59YCv7KPniyJ+w2g6LtH1ATtFmuBoBsZzs7W4K0DT2c2TrVzKEIWBGMKLGMWxHPby5EY
         oi7xgTWYMbb9lqjfy1rO92AkOhl7ztJdpUn+95FDLBw97HDEWWtExDZbjzBILPELtRYY
         Rgn0QYWEHYhJPg3KHvf85/pvjSw7sCBDEkDmWgeIz0UPdtbC1Bk9cRjBRwN5SK0M2HFr
         ESSndDaFk9k5De3G0qHxaYlRH2Aku550BDpQ1JdnEd0bEuZ8Dl/pSq4QO83KAf6uYQok
         b8VA==
X-Gm-Message-State: AA+aEWYeAQt/N9Pkk3vhSAsDtQXdcEF2oduo1XKcuMnqoXac9y2wKq4Y
        40ZDiYTjevTTSOP2lMwiZb8RN3Ytp4ZD4J3G+mU=
X-Google-Smtp-Source: AFSGD/X1xoKmmafr5/oIZRM5/O+9lw9e+nP2WQBP1VDfZpzoRn7ybGC/IgkrFVVLeFsu3DIY7NI0XyHPQucBy6uvPEg=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr1764636otq.119.1543524795009;
 Thu, 29 Nov 2018 12:53:15 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Nov 2018 21:53:03 +0100
Message-ID: <CAJZ5v0hn4+dHqFh0LnUzuU76+8py=fYh8ERg5V+XpZu1xbdb_g@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v4.20-rc5
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
 acpi-4.20-rc5

with top-most commit c4f784268210ae5e6749d4ba30d117bd301a70a6

 Merge branch 'acpica-fixes'

on top of commit 2bbb5fa37475d7aa5fa62f34db1623f3da2dfdfa

 ACPI / platform: Add SMB0001 HID to forbidden_id_list

to receive an ACPI fix for 4.20-rc5.

This fixes a recent regression in ACPICA releted to the Generic
Serial Bus protocol handling and causing it to read or write too
little or too much data in some cases, so incorrect data may be
written to hardware as a result (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPICA: Fix handling of buffer-size in acpi_ex_write_data_to_field()

---------------

 drivers/acpi/acpica/exserial.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)
