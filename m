Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A94C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29ADB20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 06:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoNg89Xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29ADB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbeKGPjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:39:36 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:38749 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeKGPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 10:39:35 -0500
Received: by mail-wm1-f41.google.com with SMTP id f2-v6so931301wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4SDD5ShUtI2RKD54FvvKFjyKOP/Qv3YcK3w0i+HF5HU=;
        b=CoNg89XunBvXGIRcOQe/z3aX+etSzzRjsBV85R9fiI7imIzBFG4X0p6rj0iJM2rRpq
         fVOBeK3zf1ZDjZ2vClw2dqzlSQ3N4RGSkEkxM9zqcoVEqVIKSKPCEa9bWp3wwcDIqswU
         fFCE39LpgvEE0W/4ZjLydOygmDvVUfeGaouKlRkd99iMaaXH+ZDuczxOEksbSaY/8TR3
         yGTS12B/BDH5SKdggDCaN7OoKUywe+DrvxTiSnqQR7n7UO3pKUtB4DynygsIvhLHD3JJ
         8uBahI4s/woyzvdRd31Z0v0w6SytDBo7Tch9eCoxyKOnC1vJIaGvE4aoBgpOvO+x7RcM
         k5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4SDD5ShUtI2RKD54FvvKFjyKOP/Qv3YcK3w0i+HF5HU=;
        b=PeEM/M/hbixdLLoFgd9vYFrIs+84xAPQJTW7sxPGFGNvL2qEk7GQ5NA5rkmUFI2K+s
         iejgMlRfBGNMU8EN2iJ2MVBQVw+V+R4j+Y/BH+VU+b1Aw/mIFalzWC+so214QovC7Id7
         T7P4TkUsx0n4gDG2BZ76pHS8cLifxZv+//QV7LOdxC84jYJejPYA4n4HIYYa0to+vZDk
         VIZIriOVVzTnjV9bZJbLLSkUq9pLeEtBNIc1hobBLXygmcndiejl9fgb3oPKf9UwLtCy
         GnG2c/c0qageOssYbrG0JNMZ04eW2i2cVqTecgFBh+NABLCnK8w0hk6pPKlqQJxG9jWK
         WHtw==
X-Gm-Message-State: AGRZ1gL1dCN8VgwjgWatgG78jJJ95sIrv8iCPql9z5jyg5a7BCeeYnMZ
        gzcZDh9g0bywcEDFvYP+9ULaGnsM8AKePqAwRetJxjIkhQc=
X-Google-Smtp-Source: AJdET5cDS02I94J9StH0V8/KVk3zMSk7ybKlCUIGUgrvSeYW4Qjzvefgh+zF6OQGvm8jwAyEI6b5vfJOmE3hQPIJTIA=
X-Received: by 2002:a1c:e40b:: with SMTP id b11-v6mr752216wmh.100.1541571041406;
 Tue, 06 Nov 2018 22:10:41 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Wed, 7 Nov 2018 07:10:29 +0100
Message-ID: <CAEXMXLSGoTfEL4ARER80bXMYGmu-mXXOQ4nRwHW-4R4uby5_WA@mail.gmail.com>
Subject: Target bindeb-pkg no longer install DTBs
To:     linux-kernel@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 37c8a5fafa3bb7dcdd51774be353be6cb2912b86 [kbuild: consolidate
Devicetree dtb build rules], the target bindeb-pkg no longer installs
DTBs in the .deb package.

Thanks,
Nuno
