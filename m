Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B2BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A34E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ossystems-com-br.20150623.gappssmtp.com header.i=@ossystems-com-br.20150623.gappssmtp.com header.b="etuK4Ac/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733190AbfAaMpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:45:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37543 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733014AbfAaMpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:45:32 -0500
Received: by mail-ot1-f67.google.com with SMTP id s13so2679063otq.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:references:in-reply-to:date:message-id:subject:to
         :cc;
        bh=Sfu6Zq/WWsE5VxlwrCHEVgVmSgLmCzC4eI5lBhFjV2I=;
        b=etuK4Ac/zLckHjoqpT5dyGhRImUAH6IcL6GV2NHMsUjmfReBLhR6wvVGiZeMKh648X
         2Z9182qjJ8fQ2BijGjkE/VeP24z0fdvLUw2T/Psn3R92BP69q8YxDPTIGsgz2lwUso+h
         vFI8dAfM9iq5SO6BCWrNAzor/TmxgTazzdEjczpWRg0qvSto8k0dMHapGW1X4e0fb280
         Z4MKiZdhI24rPg0GNoTcn8HC2nzQgYPs738VsM+4VumQyrmG52KJL4qCjtgTHtcIdvr5
         79KFK+KspNRcw9JxG7A/F5unLvHg+sXTyKM9NGRqlFJRBE7qWLyCtxzS5c7NjW3GrjoG
         XDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:references:in-reply-to:date
         :message-id:subject:to:cc;
        bh=Sfu6Zq/WWsE5VxlwrCHEVgVmSgLmCzC4eI5lBhFjV2I=;
        b=OutVjnGcOdiN42OsgijIIoKD/3z2Yexw0MTT/SCbAiYSgW7foZqt3PeYPhD8r5ADBC
         lJE8T4VueDz7OLDYVBmdS3LEE75LhXrunoj8nYlzgiZb7bVQrGwGyXBZYQxS5tlOUV2g
         xwpJAeWC1JxEj09OjzbR0vF7g8CcpgwUK+c98jGymUNVo0t6gmOENQYlb2+aMgBiNqnp
         yfWzeBf1pEsD/uMnvJ5KW2wfMKIJNdELBL9H4fEvfJJuDquRHcoDOs7RpD40DTBwyItI
         LFnXyxj7NiPwM3+UZW5xQRmxGR0b/iY/Y3/Mv5igOctct4jBgcW3NZvyP8DdJHmQO8YV
         hdwg==
X-Gm-Message-State: AJcUukd9lHopr1obTb6fy6Bf0PiyPH4u+LGPUEt/XbNJg+HwVVkHAcU6
        MgAHQgB9/h3ZNTGNAAHwNoDvstEl7H8rFQ==
X-Google-Smtp-Source: ALg8bN5Fb1gMMPh+yLmFSn3p3/kMUHxoJbWW+p+no9X7W4+urzRQ5+zPYYAqyItnENu76E9QznYYDA==
X-Received: by 2002:a05:6830:134a:: with SMTP id r10mr25087988otq.195.1548938731334;
        Thu, 31 Jan 2019 04:45:31 -0800 (PST)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id j5sm1843427otc.54.2019.01.31.04.45.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 04:45:30 -0800 (PST)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-ot1-f43.google.com with SMTP id a11so2639808otr.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 04:45:30 -0800 (PST)
X-Received: by 2002:a9d:842:: with SMTP id 60mr24835948oty.22.1548938729575;
 Thu, 31 Jan 2019 04:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20190129195424.10161-1-otavio@ossystems.com.br> <20190130153956.GB10665@sirena.org.uk>
In-Reply-To: <20190130153956.GB10665@sirena.org.uk>
Date:   Thu, 31 Jan 2019 10:45:18 -0200
X-Gmail-Original-Message-ID: <CAP9ODKoeo3+rQOXN8PMj2at1C0n1_P9GtC9E+ucqt7-4hoC8TQ@mail.gmail.com>
Message-ID: <CAP9ODKoeo3+rQOXN8PMj2at1C0n1_P9GtC9E+ucqt7-4hoC8TQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] regulator: rk808: Fix BUCK1/2 voltages on rk805
To:     Mark Brown <broonie@kernel.org>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Jason Zhu <jason.zhu@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicent Chi <vicent.chi@rock-chips.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Wed, Jan 30, 2019 at 1:40 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jan 29, 2019 at 05:54:21PM -0200, Otavio Salvador wrote:
> > RK805 has the following voltage range for the BUCK1 and BUCK2 regulators:
>
> I'm missing the other patches in this series and don't see a cover
> letter - what's the story with dependencies?

Those are just adjustments on dts files fixing the regulator handle. I
am preparing the v2 without those as they are independent.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
