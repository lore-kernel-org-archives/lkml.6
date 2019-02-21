Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95792081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Emk0Jfs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBUTJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:09:22 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46478 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBUTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:09:20 -0500
Received: by mail-oi1-f180.google.com with SMTP id j135so2311278oib.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/rpg1D9lSXGVTvk03mqr3lk2+qeUKb8eMWwtK9VjlJA=;
        b=Emk0Jfs+KQ7OVgWqVg+QPBcv/P/G8aqUu1ytJUhYJ7kiaJkU84302UTfqAW4Gh/hxQ
         JRSFc2NioTNnVFSeMFi6oWn29KVhvmRKrC87Zmth/gXBsmB3Z6FGDU6T39EewzTipJ6h
         dlhcHofZm9TDPfHdNn8FN6MauSxG2iQvetKgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/rpg1D9lSXGVTvk03mqr3lk2+qeUKb8eMWwtK9VjlJA=;
        b=eLHNtbH6fkVqp5vZbza7BRm4QsJBN/CKNayrymb13XkGALB7Q0gubJvsGVlWIYb3dI
         p/+QG1LGPMb7HLmTuvzFakosDrhWrSc6Cjdf8G3kFC24sSOwp22wwKKLB5AOmAsGF3SN
         Xnaj/z8TEhzKpDH+GExgVnaRNrnor348BdloNml5vfklbazl0ia8Sw777FhNCouC2wx6
         HkcM/8qwZJej7ldzGLtdwUsQUV//uiiRJs19Vd4fqPMYk3e8hCTPtRSj7RnmtzkLS0c0
         Yj0Bo2x1IZifLpI6JpyQDczpuVuJhgkPSihBpRxNSfmER61upE3xgHB5FVJB+ZmNzPod
         jfLg==
X-Gm-Message-State: AHQUAuYJ/HZQHE0Shh01cgZj2cr0qWQEC6d4wMPRN0M4uC9OPlBI2F1G
        507B7x00qwekcp78eiORRx1UA1J6dmI=
X-Google-Smtp-Source: AHgI3IYMgk4eSIbYXHC1c5dgJxz65E0QMBeq6O/t3LlIwr9XEPyon+WUKuJt/naXUTEYh3rzgdVQTA==
X-Received: by 2002:aca:f0c3:: with SMTP id o186mr28217oih.101.1550776158945;
        Thu, 21 Feb 2019 11:09:18 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id x127sm7797267oix.25.2019.02.21.11.09.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 11:09:18 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id n8so45871531otl.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 11:09:17 -0800 (PST)
X-Received: by 2002:a9d:30d1:: with SMTP id r17mr23815otg.269.1550776157241;
 Thu, 21 Feb 2019 11:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20190220215826.44366-1-ncrews@chromium.org> <a0cf4649-e06f-aded-55ad-893560c2414a@collabora.com>
 <CAHX4x87KP9QsnX-vAwyEs45tXngbiSSq+vrByj01S-LpUdO40g@mail.gmail.com> <20190221070704.GD1711@kadam>
In-Reply-To: <20190221070704.GD1711@kadam>
From:   Nick Crews <ncrews@chromium.org>
Date:   Thu, 21 Feb 2019 12:09:06 -0700
X-Gmail-Original-Message-ID: <CAHX4x851YhO8CmzMheM6bOv2+Y0jX8ZVY011CuuvO0qH-FPAGQ@mail.gmail.com>
Message-ID: <CAHX4x851YhO8CmzMheM6bOv2+Y0jX8ZVY011CuuvO0qH-FPAGQ@mail.gmail.com>
Subject: Re: [PATCH -next] platform/chrome: Fix off-by-one error in wilco_ec/debugfs.c
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dan, noted.

On Thu, Feb 21, 2019 at 11:31 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Feb 20, 2019 at 03:15:18PM -0700, Nick Crews wrote:
> > Fixing something after it's already in the tree was a new
> > process for me, so I tried to copy other people's examples. Please
> > let me know if there's anything else I should do something different
> > next time.
>
> I seldom mention how much I like Reported-by tags because it makes me
> seem needy...  Also in this case it doesn't matter because it's going to
> get folded into the original patch so it's going to be lost anyway.  But
> since you're asking process questions, the Reported-by cookie is nice.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> regards,
> dan carpenter
>
