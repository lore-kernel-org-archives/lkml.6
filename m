Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253E8C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCD120936
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dds.mil header.i=@dds.mil header.b="0f1wyv/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCD120936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dds.mil
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeHVXjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:39:25 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:41232 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbeHVXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:39:25 -0400
Received: by mail-ed1-f54.google.com with SMTP id f38-v6so2164675edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dds.mil; s=ddsmail;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jUMPDCsMRlLboJ7WLShiYDTZtJowlEjZBQfrq0+gg54=;
        b=0f1wyv/niY652tI4sWNJIBaSW2IwUg9fu3dulbLFHX9q4m3/hpRGRv5XsQV4HnLyPG
         Lk1xXO0CTHNzzHPuDlAYFN3VR1BKcDnwsq3x/NytNtXYPrQo5fr3p1RYMhXh7aFbm9cY
         giNyhbq/yP2+bohYNSHmfhjfW3b2mC2As88RhubnAKrMCyTJvlIW/irUXwizxqCPRVTH
         gQPXTWafxzAYfjdd9WQTt0htsIE4HLs7dGfxuZYQELCWczWxYs/F9f6ylazemiyz5tAc
         Utj9xqFOphq3RcnHdD/dgkiNSxUbb7YZ1tzalDsNoxgnDSrwcNElDPij0h4zmeb2pjoq
         7JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jUMPDCsMRlLboJ7WLShiYDTZtJowlEjZBQfrq0+gg54=;
        b=H6A6xXgSmlEfYMMWT4iRcj695mmhneaUYQgmSk/ZsQUxreudPYggnQmVuDfKJKArjw
         nmbRLVTbzmU3/lMVxlUDk3aAamBLHrH/B4PzevuaIVFwhoLGI8C6D+g75Jpti+d/HfEL
         ouStIWe6e8xwN8WR4k/DH7tFP1nDxmkDsYsV+09P3p0/m31bd0puhvQooXifo7PLBgQ7
         uY71QW+khveOqvk8veDwYEUUFD0K3k3KkNJLnYgrvmBwa7bOasUOcILBNV7pCRBuqZ9p
         tFkeMLo16/tMICyHSUnjgRZukoaKtdtSNbZ28hM9NYR9Pd6HMDX92SJZrcgSlUnh1FfK
         am2Q==
X-Gm-Message-State: AOUpUlGXAtzlCqM3B6mIO1Tpe8LEV8LmfkBcCxV3WXsvpcfkEZb7ryOs
        uJEMmj2TdMzbHpe5AmckBYqxUBcnpjSxanLDIyqC2A==
X-Google-Smtp-Source: AA+uWPy3tsqmAxi2uD2MsQ5eqqTSKCV5tb40alzbc9NJDw0BkvfOM0BGa+4UzBAZ0KdYlK5+RrNu9TXjIThR2tvAkF0=
X-Received: by 2002:a50:f383:: with SMTP id g3-v6mr14309947edm.110.1534968785786;
 Wed, 22 Aug 2018 13:13:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:aef2:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 13:12:35
 -0700 (PDT)
From:   Harlan Lieberman-Berg <harlan@dds.mil>
Date:   Wed, 22 Aug 2018 16:12:35 -0400
Message-ID: <CAO-sURQqNhQ3R+REeTrWTBf=ZARB7RhBFjNdUqGS8rXZdTZp4Q@mail.gmail.com>
Subject: nvs.c: Inappropriately maps TPM space on Dell Inspiron 11 3000
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Paul Tagliamonte <paultag@dds.mil>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers,

Crossing over from a thread in linux-integrity
(<CAO-sURTs1dc_5iY+b34Jqj4hxZFdUj9LZxTWhDdvqM8AbEqMAw@mail.gmail.com>),
the fTPM on the Dell Inspiron 11 3000 reports its TPM registers inside
ACPI NV space.  This causes the TPM to fail to run as the address
space has already been mapped by acpi/nvs.c prior to the TPM driver
loading.

In discussion with Jarkko and mjg, as well as contacts with the
manufacturer, this appears to something that Linux should support,
despite being arguably broken.  Because the fTPM is part of the ODM
BIOS, this isn't something that can realistically be fixed through
firmware updates; it's going to be scattered across many different
devices and many different manufacturers -- and because Windows
already works around this particular brain-damage, there's not as much
leverage that can be applied.

The full ACPI dump and the output of dmidecode can be found at
https://gist.github.com/hlieberman-gov/83fa708d41051bafccc553cf0147db4f.
I have machines that are set-aside for testing, running both Windows
10 and Debian sid, and I'm happy to help test possible fixes.

Sincerely,
-- 
Harlan Lieberman-Berg
Defense Digital Service
