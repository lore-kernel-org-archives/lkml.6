Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A54FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E190D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwLHsYF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E190D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeK0GSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:18:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32873 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeK0GSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:18:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so14343123plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OCLzU9E0NA0nI6dXG+LvtUY3QLEo7AD97fW17wQKIig=;
        b=QwLHsYF6O/ib7uoLRSC8Xw+lvCNSRE7x6vB210ZNNCRS0qLh1+MbigttnmL8SIpaOQ
         dd5eMgPl/7GtDbsBCzbCUeFtTmcRXoFREcanwH/1GEU0LrBzVxRyIG972sb9AoNCsz3v
         8LT8V3qjKp10ItDAh2NgKlZkuGfwDqrJRingw5XTOSeUdeVPDcyqWy7V9AxL8zJnv1i1
         ArqXTDGUsRA/g/b5NV4CyHzxNDkKy/uKHpYyf7yhOA26UZvbhDAOUuHlJALMrYe2LbNK
         N2LDqqbfZ/SA0Tr+jNEguBAw+Y2Kk9SIRh7XXKwKHlPchuIm9fFFZC3Wkddg2mJbecnK
         N59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OCLzU9E0NA0nI6dXG+LvtUY3QLEo7AD97fW17wQKIig=;
        b=m6rWiILJG5BpvNdYgFFdmzwlzgakWtOQBXvFJS/VKWlikMd+2a07AH2rzzLkR1wHzf
         +32TtTiplkod8pwPSNCYv1Jjx+NW+2/0j7SAKzgRYsaN9u5IL5Qq1Z72m8vjFQ3oduQz
         yJKJbNm6R4oxtOpCunW4wA2aqFjC/KbXQV71HlthaGguKZ7D+xj/VegR9MvRE7qhogrL
         0IdC96HdNkTzmLa3+7+dTtLuMB82M3IIdT7m886HDTxwjiRx7bff5WJ+lpNK2SPzAmFM
         VO1k5oZfbuIFAd93FagWXFLhfU5wPYwQdTBw0TqYMUIraZIim9d3naqf5xoZEutqKyPH
         zcVA==
X-Gm-Message-State: AA+aEWZ3+SeAQfozb9sWwO4Ln6r6na5x6JaNcQb7/mUKq3fh0oNWEGwX
        xDU8FT9hiyD2YkVMM0+asNEg4WqBirrFu9ROBBs=
X-Google-Smtp-Source: AFSGD/XSXuKtRtGHZjMbUlQORifV1QWZgM0erYJBBUnOvaUu+p+S3ITn93xMc4yaysya4VCiJaTHkNCfQTkzCeFsOPs=
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr15288443plo.210.1543260225308;
 Mon, 26 Nov 2018 11:23:45 -0800 (PST)
MIME-Version: 1.0
References: <1543096879-82837-1-git-send-email-carmeli.tamir@gmail.com> <7525d368-62aa-a288-b590-864f78cb69f5@suse.de>
In-Reply-To: <7525d368-62aa-a288-b590-864f78cb69f5@suse.de>
From:   Tamir Carmeli <carmeli.tamir@gmail.com>
Date:   Mon, 26 Nov 2018 21:23:09 +0200
Message-ID: <CAKxm1-EWENsj5Ug+5zzivASNHVvJQY0DXC09fWn-V7mPiCW3kQ@mail.gmail.com>
Subject: Re: [PATCH] fat: Replaced 11 magic to MSDOS_NAME for volume label
To:     jthumshirn@suse.de
Cc:     axboe@kernel.dk, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        bvanassche@acm.org, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply and sorry for my noob question:
Wasn't I supposed to send this patch also to the FAT maintainer, OGAWA
Hirofumi? His name wasn't on the get_maintainer output, and I think
that this specific file isn't listed anywhere under the maintainers
file.

On Mon, Nov 26, 2018 at 9:58 AM Johannes Thumshirn <jthumshirn@suse.de> wro=
te:
>
> Looks good,
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> --
> Johannes Thumshirn                                        SUSE Labs
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
