Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8D2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84E12087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb6PHeQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84E12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389820AbeKPXBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:01:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389687AbeKPXBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:01:54 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75FC520989;
        Fri, 16 Nov 2018 12:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542372578;
        bh=DD3QyMq52595KAjINwRhwj+EcOqJGT/cVTgI44xPUX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jb6PHeQuVqd7g23Y5uOyOqTJplf1Zov/YmyvxMy9g8PA6U5NXjTKBbbpXu347cMOz
         XkkmPvSThm63Tr4dHVve+NJQB2lVOBeKeW997rLUzXEJ7I6c4PQXtUcPFP4jChRleF
         dWgjttywC25FL2YyjatBoUdRl7LnM+8tMZjLe6jY=
Received: by mail-lf1-f45.google.com with SMTP id l10so12882987lfh.9;
        Fri, 16 Nov 2018 04:49:38 -0800 (PST)
X-Gm-Message-State: AGRZ1gJFTcEZml3Bjm6WJiZBM7Rb/x5kB49e5DjYjCjclungjuOLzl1S
        Wu/tdXXR1wu+GWA7VFLwCR7ALVrV7onSiTpNLjM=
X-Google-Smtp-Source: AJdET5dEoiNKB3y7nG6ApYI8mif3NpLgzPxhv/hvj7PivIYMUWbyfQY7PBzefQ1O+L7uP8yuZRISJ3Z9dS56whsAfpU=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr5972385lfe.87.1542372576603;
 Fri, 16 Nov 2018 04:49:36 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181115151247epcas2p4053da2cb28b2414156d2fd0530059c0d@epcas2p4.samsung.com>
 <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com> <1542294698-17470-10-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1542294698-17470-10-git-send-email-b.zolnierkie@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Nov 2018 13:49:24 +0100
X-Gmail-Original-Message-ID: <CAJKOXPco4yCmCH=RC3Kdoo-x1UPFj2GeGDp6Eb0zZ-DkNg013w@mail.gmail.com>
Message-ID: <CAJKOXPco4yCmCH=RC3Kdoo-x1UPFj2GeGDp6Eb0zZ-DkNg013w@mail.gmail.com>
Subject: Re: [PATCH 9/9] ARM: EXYNOS: remove <mach/map.h> include
To:     =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Cc:     arnd@arndb.de, Marek Szyprowski <m.szyprowski@samsung.com>,
        kgene@kernel.org, m.reichl@fivetechno.de,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, javierm@redhat.com,
        pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 at 16:12, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Remove no longer needed <mach/map.h> include.

If I understand correctly, header is not needed because of previous
commit so it should be squashed there.

Best regards,
Krzysztof
