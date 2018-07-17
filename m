Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5892ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F152064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIQh0Yfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F152064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbeGQUdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:04 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:47050 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbeGQUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:03 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so4338469oie.13;
        Tue, 17 Jul 2018 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yq5fLOiL8iUq+ZPLkVu8YJOzj7hZG8v+JY+hQRK6aZ8=;
        b=cIQh0YfcZGmNgc+RZKXQJfe8dfnRHq+dv+fBgqVaU3c9L7IwgJFpaJtQrU4qSg8mJt
         5uXNO+uqpQz4oat23gHRRA46YJdia8aO6OcIORSY4S7+FIipjgeXGydssWdaqzNyHVZa
         r3gV09rPH71ebIqV9xmz6+4Kme/Oc0QrHQcQ2LFKTxxFveyff/I49Ci9iIuRtlxPQhqw
         1BDYA9c4ZvT3mEGHetCFH6jM2mVR/hQzYzFEPTC+QO2u1v1rS1aMSup3xI/Bkyu/k0uU
         R1HfdehZ9eCTlMVidpmRDZKh3HOdH3BEbtXWqMIv9oBWHE2zmtqGgE5gZPlVY9MDIGA8
         3GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yq5fLOiL8iUq+ZPLkVu8YJOzj7hZG8v+JY+hQRK6aZ8=;
        b=BHtBvNZ6O6w8deoianPqnP9BCKv4mLYPeQhreZfkqgnq0F1tXWgcd44kY/xUey6Pn2
         aBbhPcf3d0fOk+TJkr24PXn1/vKydyd96hrNWzA+3FCLmjZ7hDsLFYD0ioO/dTctnd9L
         /+v0dN9JX1kh143SoiXv+fakO5iLs3PkUEqEmqbi+H+9Nel4036OUiTMEbIg/ydsZJ2a
         kaCZnrw4EGfNjGDVQcmjgTBAvg7w/UPmocK07N9gWnHEkCmrcz1CoI91MBtwD4Zc5wjr
         p8S+P5zFpD9ygRyPGpZyeJ8gJMcYCC/IKpn11u94Epo+CrG3kxpHSDsDN/FX/zcZsgzh
         WmLw==
X-Gm-Message-State: AOUpUlEQ+lLszheBDXoQaRhImOdfgH6zYKBRMIJZcuLtou575Fq7GeUY
        6UxiJfSMvlh2XlusG+Rne5kKxPiQ2psy1Bmwvso=
X-Google-Smtp-Source: AAOMgpfU/WiusZ4t6KzpK4wVF5Wzc3/yNOGSjH361HGCWTYDkbQvUFoCznr6qO1cDTj5lGN2gso79lVZMrPWmAufWuQ=
X-Received: by 2002:aca:b48b:: with SMTP id d133-v6mr2944137oif.165.1531857532500;
 Tue, 17 Jul 2018 12:58:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b33:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 12:58:31
 -0700 (PDT)
In-Reply-To: <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-4-git-send-email-linux.amoon@gmail.com> <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 18 Jul 2018 01:28:31 +0530
Message-ID: <CANAwSgSwKBFDSWAF2dox9c7DAKKbHShXBNtSUcea2FdoR=80yg@mail.gmail.com>
Subject: Re: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 17 July 2018 at 17:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> e-fuse range min~max range is 16~76. if e-fuse value is out of
>
> s/e-fuse/Fuse/
> s/if/If/
>
> Can you share the sources confirming that fuse values are between 16 and 76?
>
Below is my patch :
https://github.com/hardkernel/linux/commit/52c4c9b295930bc53b215d38e274aeb0780917f1

e-Fuse range min/max values are from exynos5422 user manual.

Best Regards
-Anand
