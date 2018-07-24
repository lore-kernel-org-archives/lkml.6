Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F88ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C9F205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qA2yo74D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C9F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbeGXPKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:10:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43464 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbeGXPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:10:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so3701213ljg.10;
        Tue, 24 Jul 2018 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kyU/k2DfNKC9MvtSJxZ1ww6Vl8VYccGNTOS3WHOdpbE=;
        b=qA2yo74D2LKKNHaFnV4wAPizj4VQi2odQOoL0srMnM13jkyYBVETKbz806j3F0c9Ke
         9H7O/lQLpyA7UFEUaH/rivGjqS1domztVtFDK+NKGMycwKK9BF50bTW5/hlYQL1qaf0E
         ZqKQtXWNGtK3IDQhezVprV0o5ngusHuw3qr8qmevFsAagiC52UMppgvzyKlNb079J+p5
         HeeiuvwKI6h/BUyHecyhXrhgpW/fBMztlfzhC8UOYCyX36I1EemRfr1m/XFv9M3pH+bx
         35Iv/Ua3tEAlZM0LuJQfLfMD6JvRIdBl9paFSC9N62dhJNSwHUOtoAdtI8eMHtiwjEKl
         IkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kyU/k2DfNKC9MvtSJxZ1ww6Vl8VYccGNTOS3WHOdpbE=;
        b=Tf2OD9vTOSEORyjuOM3dZgyYHCNkGaHOhMYvUUCCr5mzRdOi8QWkLxQ440vRn42Vv0
         4PrUDAp5LAW4V+SaO7fbADfxYr97xJZrZWM3gtPTulUdASwed+BKJXTpVnry7/w81J0+
         /iN780+XH4Bte8k1GTFKo5PeD6xj4Dpd3q+AVgnbQCrU62BFEd/XKgq4Ds9GUjgeaAds
         L4U7V9m4OG917qRvE/AXUrqV4xxNRnpOPRevVMEQQ9ESxJO6Fl5WyC7PyksgMUDn50G5
         v8SHi+SoPeeWai3izMe1IB1GD2/CV8fuWrT7Prb+En0kgSyTY6w8VuMJRn34epXxdGvY
         /v8Q==
X-Gm-Message-State: AOUpUlFxcozyS4dii+7RRPY64SKsV1zf93n/MzcuOBpn6uJ6YtEu6CJV
        CKMrEIq4N5RNfhlDIBLIRJU=
X-Google-Smtp-Source: AAOMgpej+b8jePP195hOrZcAsqjOKPku4V1La54FORRO3u8T5QrZeGPhoDo9mMaBFti1ET1Bycz/cQ==
X-Received: by 2002:a2e:4e02:: with SMTP id c2-v6mr11820753ljb.108.1532441018406;
        Tue, 24 Jul 2018 07:03:38 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id m66-v6sm1824358lfi.17.2018.07.24.07.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 07:03:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 01/28] ARM: tegra: apalis_t30: enable broken-hpi on emmc
Date:   Tue, 24 Jul 2018 17:03:36 +0300
Message-ID: <1992775.WBgY65Ajyy@dimapc>
In-Reply-To: <20180722164936.20581-2-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com> <20180722164936.20581-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 22 July 2018 19:49:09 MSK Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Avoid eMMC issues by specifying broken-hpi.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

Is it a specific eMMC card model that has broken HPI or it is a host 
controller bug?


