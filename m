Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90972C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8F2208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teil2WU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8F2208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeHWBNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 21:13:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34463 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeHWBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 21:13:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id h1-v6so2326333eds.1;
        Wed, 22 Aug 2018 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eHlgz5fVfBCWvnyggD5tSmLG/pwjloL36djKexv5YoI=;
        b=Teil2WU0sQxUxCdY2o129BE+/Lugsk3Ag6bS6LQXf8rEFU6QTN2rZE93iALaCM3Z8W
         hTcxr1+PlyF8UzpMDn2BHxG4ijm5GxIZHw7bq7NWFzFePq/KayfppWy4qI3Zu+HCDE2/
         IjdPHNpRQP5J3A3z1AvaDAp7NjJ6jd3fEBkye8LRlHG4rUNfROfW/cQeIQop3O+ZxIiD
         KmFuDUQ2UjttKNlv0pf1cyucX01FT6S5W/J1u49KsuEErbDFr/rIilMYO3j4ELxHIk+t
         xyTB06ptwAt4BjaoOU5bIDW6u5hCt5Sd0a5znwXmsGzsi5nqEsJo0+Pu1Sp2fnn9k7kj
         KeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eHlgz5fVfBCWvnyggD5tSmLG/pwjloL36djKexv5YoI=;
        b=F2nbQh0wxUtBNDxVOYvMtVkDF/iI07bTqeDMimuu8/39QZnt/utym5cbzK5CelWNFi
         YyUjaPhzySUy409VBgpqT2oM6XYzCQn+5D5tnd6kAvWoe7WUmO8XSPHL4TO9oudXQ8l+
         rSxyKRzxI3pWdpoKpk7SDIrzynK3EFa9nA334PxpES9X4K3W4HtONFE7ThN589o6aoyT
         br/F+kT6r6fEK7ZNBjUhcxspGN4+Z2wkXVUAuqGBDX2YwuA1RLMhJ9oiU+ujuv5e+Q0N
         mfOjLurOugf/PCIhkI9YPY93QnSWIXD122oafPWesb3FQtl4S7t5JpBlNh4CvMLDGuyF
         vqUA==
X-Gm-Message-State: AOUpUlEbheJOcH/p+FRlOe9KBJ2gOg695KgYn5V3PrdR14POl090Rjm1
        l0f66XERLlkyriU2sHH6H41OfczNtwpfowxsZ8U=
X-Google-Smtp-Source: AA+uWPyl/tK7poTz/Q61LI3M5JC3eKB4gA3Fbsn6xKaH++BQtxIiv3TCQIqYYIte/AfSOjBzrf2grkT/EGKw7OGSkqs=
X-Received: by 2002:a50:a267:: with SMTP id 94-v6mr68308036edl.189.1534974397206;
 Wed, 22 Aug 2018 14:46:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:e04f:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 14:46:36
 -0700 (PDT)
In-Reply-To: <CAB9dFdvzTx3tn=z=he08_+QrpnaPsXQ5qWTGyu65Tv7cy2=L1w@mail.gmail.com>
References: <20180724064929.GD19722@shao2-debian> <20180724130155.20641-1-mszeredi@redhat.com>
 <CAB9dFdvzTx3tn=z=he08_+QrpnaPsXQ5qWTGyu65Tv7cy2=L1w@mail.gmail.com>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Wed, 22 Aug 2018 18:46:36 -0300
Message-ID: <CAB9dFdt=Wf8ZkJV-eqjgqDKzxat2Dq7FoHvGL+GR0DBMKJX8NA@mail.gmail.com>
Subject: Re: [PATCH v3] vfs: don't evict uninitialized inode
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 4:37 PM, Marc Dionne <marc.c.dionne@gmail.com> wrote:
>
> FYI with this patch (now merged) I'm seeing warnings whenever an
> object is created in an overlayfs mount:
>
> [  842.152673] list_add double add: new=ffff88017efe03d8,
> prev=ffff88015c07ad88, next=ffff88017efe03d8.
> [  842.152687] WARNING: CPU: 4 PID: 7592 at lib/list_debug.c:31
> __list_add_valid+0x6e/0x80
>

And I see that's now fixed by 6faf05c2b2b4 ("ovl: set I_CREATING on
inode being created").

Marc
