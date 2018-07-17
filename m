Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8338ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7851E20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSopdf7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7851E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbeGQUlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbeGQUlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:41:39 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0956920839;
        Tue, 17 Jul 2018 20:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531858046;
        bh=G8tUGRtFuyL3IiShTFeUUAGIU75uKe6SyW21MiydR94=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=BSopdf7hp8YflzqTRX0AcMSklky8/VoXoTvfDxqoTL9lUPri6PbCcS2jWKeWPFFuS
         6QJ4mkSJbpQmZnBX8uzXpECmRgy+/S5nXvGp+TGhCBI9uwGOdjFz6wTSquj+14L63r
         mF0xT9kpV9jws/LP/tm641YBAxjCn1vr25Iu3xqI=
Received: by mail-wr1-f47.google.com with SMTP id a3-v6so2417881wrt.2;
        Tue, 17 Jul 2018 13:07:25 -0700 (PDT)
X-Gm-Message-State: AOUpUlF6nJr+n57AMCxz4ePzKC6zjA4k1yyz1sSHn1AJDYxnp4eUpAHK
        Um0/KvDawl3TWlZx+Cz11fhXVQwvTjnMy3TU1/c=
X-Google-Smtp-Source: AAOMgpdkg3nj1FgENv8CVpiijxQbBtfD2CiFDDUDCCn4xazsOvRYXfANzFSw1z8uNo1+y+gc+aYW2b4+1SnZBwbFpdU=
X-Received: by 2002:a5d:4452:: with SMTP id x18-v6mr2471384wrr.227.1531858044512;
 Tue, 17 Jul 2018 13:07:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:07:23
 -0700 (PDT)
In-Reply-To: <CANAwSgSwKBFDSWAF2dox9c7DAKKbHShXBNtSUcea2FdoR=80yg@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-4-git-send-email-linux.amoon@gmail.com> <CAJKOXPfOiTARmtkcJeC49RicWOt8q98GKPJOQkYmqG_nJtY=aQ@mail.gmail.com>
 <CANAwSgSwKBFDSWAF2dox9c7DAKKbHShXBNtSUcea2FdoR=80yg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Jul 2018 22:07:23 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc74_5XT_nscxWLmbqRMNdBQaN-0=qV+C4uoBcwBMy0xw@mail.gmail.com>
Message-ID: <CAJKOXPc74_5XT_nscxWLmbqRMNdBQaN-0=qV+C4uoBcwBMy0xw@mail.gmail.com>
Subject: Re: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for exynos5422
To:     Anand Moon <linux.amoon@gmail.com>
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

On 17 July 2018 at 21:58, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof,
>
> On 17 July 2018 at 17:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>>> e-fuse range min~max range is 16~76. if e-fuse value is out of
>>
>> s/e-fuse/Fuse/
>> s/if/If/
>>
>> Can you share the sources confirming that fuse values are between 16 and 76?
>>
> Below is my patch :
> https://github.com/hardkernel/linux/commit/52c4c9b295930bc53b215d38e274aeb0780917f1
>
> e-Fuse range min/max values are from exynos5422 user manual.

Indeed. Can you mention in commit msg, User Manual as the reference of this?

Best regards,
Krzysztof
