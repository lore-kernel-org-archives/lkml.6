Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F39C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CB82175B
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="T+D1mtJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfA3GVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:21:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38038 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfA3GVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:21:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so20197817otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FMGtbZ9/EfwTgZU2uPXEnNLf+oyJ9Xs2DYWU4YUUYAk=;
        b=T+D1mtJLX5vE8SWmktDGSIbI0XQJvXC4CUShD0mwj6S8ND1orPibugF9fcfZpbU8dI
         KDpIvxlBkyJeBHPztCMVqLssPrVsyDUDpIOwtF+tTsqf/GzXDD4F1fPm/GbQbbBUYM3O
         53c+sKmdihH3gHdbHu9GEp22Ysw5EsW2iy4W+pcMhEilfXDV4SnsM9yKzEACe3ahoY3j
         l++9v9Jjz1O+F6Q6r59GTSRf+8wo0wPQ14DiBN/uakri9VhvJ4KgId0zFWiXnPbMQk4L
         Tj6UmJRQFsIiSqFDPZ4y8ML6OAiTy2OT/bBKuFubf2bnajyv1C/NZ84NggIs7fPM88Ka
         /hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FMGtbZ9/EfwTgZU2uPXEnNLf+oyJ9Xs2DYWU4YUUYAk=;
        b=jPX0zcB2BcEHkYsrRGyK+X4MhsYO+t1m60Yn2TjOP52Npkvk14hu5A6MOdhWlVRelv
         URjyZI4elccbY/YmCxqBR9wBZKGmixhwjh4h3l7Phm0K5CgrmIXy0bl3K2tSGJCqDjFu
         1rrZ24X6Pn3ta/+XRdxFI5uJt1QZPEiu/QybhljHrCY6VW7q1XJe1CVDAhq90eT2fk5l
         I09j/+/BUObxQ7dd0FFiXpiog2SYoPSzdMJH/V6Pbd/ksU2IrW5rhNH/K9FB1wV/XHci
         3j9a4S32MVRcxBC/nqbAQq9DngC0r7DTh3K7Fcl61yFScAx3mpngfMZ+yB03tdjLF0yP
         eNYw==
X-Gm-Message-State: AJcUukdDyNSgn276GXjOpf8EOXWF0W7Ls400/QKX5KV0ZkluiVsjvtMf
        DXdScDqQ05lQIwtLoyYmGl10666f383m7E8w9chjmQ==
X-Google-Smtp-Source: ALg8bN7IkNXTe4XOD5GzMvCUhGKblteGU7tQ1zlZlArNhnkeFv66wnI80j2sJiccIXmkvdkrZDwzqeOVvodEUwQTLzI=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr20694736otl.32.1548829307815;
 Tue, 29 Jan 2019 22:21:47 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01694923DF3280E5828E2BE2BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01694923DF3280E5828E2BE2BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 29 Jan 2019 22:21:36 -0800
Message-ID: <CAPcyv4hhzLsJK9La5C28A1tFc0p28SSLqp8W9XApgANoOcuWSQ@mail.gmail.com>
Subject: Re: [PATCH] nfit: acpi_nfit_ctl(): check out_obj->type in the right place
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 5:23 PM Dexuan Cui <decui@microsoft.com> wrote:
>
>
> In the case of ND_CMD_CALL, we should also check out_obj->type.
>
> The patch uses out_obj->type, which is a short alias to
> out_obj->package.type.
>
> Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Looks good to me, applied.
