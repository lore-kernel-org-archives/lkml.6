Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A4BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA47A20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 23:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S15PD9x5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfBKX6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 18:58:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55326 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfBKX6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 18:58:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id r17so1034649wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SHec7vn94+OP8p53zffPF6idAWtpNQrS9DY8pu2vr6Q=;
        b=S15PD9x5j4bt8Lzz4DbM0fpF9nPjNJoQPySEw6F5oxPstVPL/xOD3lPmQihwAokTPA
         ARJMbwm8gAE4/zm03n/vdaCdANQ7U3lkgMZTRgq8yQQrM+EVa8/6t37czk2Brybq9nOt
         p0JhxrTz4I0dZAJYf/GQdUODMto7MdQzNpPfS30xYd8utYPdVp/jygTOQKaBlATbh0t4
         mN2VOV+9Q4e7MpdUN8dawShB0JLFmI8TJOKqqiFMnSGVFljq+b5MkYZiXY7Mt9kPGXpC
         OmA5zq4/zzTQMBjUV3PS3EE0NsR0xIy9/dx3RF47JVGHIuqdihJZRtecFr7uhZ6FeYI1
         3tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHec7vn94+OP8p53zffPF6idAWtpNQrS9DY8pu2vr6Q=;
        b=RItFjm6kvIEMo00iH7OZN3KIB9KRVMAj0ds6KlNwCQDVZEREb1TUXazRPOG0qa5Wwz
         tGKoam9GDSGuZTxz6s7wbJ6bgjHYaQCmVLWR5ha6PT3sIOsCXd9bUE/X6o1/xBSiA5e4
         XTD87+vF0Nuayw6JSkKeuiKPRgYiBY1KPpLwRo6urHUNi/po+gJXL/agvLUrE0VuyVTd
         XN3cnHf5Zv2mdD2Td1UZwZZo6E8fg7wtX+jg9ZEEsdsuGH/LfwINiY9RYzU2/WAxjrBu
         Bsfu1MPRCOdfZ5Pg6N9tK+VxmLEbBR8B4hK5Oe7yAjsoToxk3J0/bT0EG+A/sNKvJXTE
         w7Bw==
X-Gm-Message-State: AHQUAuZP8cGoEMKIXf4+akS5N3912HO9lKRj2Su2TDa/KEem91uPsP77
        cV3bLvHFbBFI9rISiaYlHl5u2oByb0hhkzQqU2cx
X-Google-Smtp-Source: AHgI3IZC0jgiixUJEpwtrLv6Q/qYpfUbSKh5ZkbC0notDcqyr5bHCScUGjeGlXtawAam27BL6Mqh6my1CwamiraEkf8=
X-Received: by 2002:a7b:cb9a:: with SMTP id m26mr594590wmi.68.1549929517540;
 Mon, 11 Feb 2019 15:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20190212101055.36a8b74b@canb.auug.org.au>
In-Reply-To: <20190212101055.36a8b74b@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 11 Feb 2019 17:58:25 -0600
Message-ID: <CAErSpo50VBQpO5hnngoeveA9Y+HpKhAxSAJtup9DPdtr3Bc5gg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 5:11 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Bjorn,
>
> Commit
>
>   51c80555dea3 ("PCI/ASPM: Use LTR if already enabled by platform")
>
> is missing a Signed-off-by from its author and commiter.

Oops, fixed it, thanks!
