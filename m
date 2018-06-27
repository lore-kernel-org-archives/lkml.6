Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55733C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50C326270
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onS2Mhoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50C326270
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeF0L3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:29:08 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33803 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeF0L3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:29:07 -0400
Received: by mail-wm0-f43.google.com with SMTP id l15-v6so17777158wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jHuYdizrSi1ltbbTMOTvJ4+F/zm2a2C+RpEM2sMXjC0=;
        b=onS2MhohNqrN2JlJL0sg/lmSjJevt/PMjSywDv8DX0Qae2SyirsOKUxRYHZmusifCF
         tOvMVzEd9puUuNPM2mVGWHgjdXXCVjCq6tGBFPNSVT8+irsNvK3KAGDazEE7dPgx4orX
         1U8NsFLSUb08U3y+6eLihLSLYANWWk3xXvGVbqa9JiIMWqjElEGajDmBCsDYg+MmsJ82
         IUBZa0YgvkdmDgYRV1h3LN9kUb8rA7MvxCmPcyXYZ1ZueOMs/ep4W5FUnKU1+vbC9UVa
         oiA4VktHltuniIv3bKpzbX5DlvKbmSk0Q5EyiONAj2b+8y2Z7Hzgeer4CywY3+U6lQDw
         xR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jHuYdizrSi1ltbbTMOTvJ4+F/zm2a2C+RpEM2sMXjC0=;
        b=QgN7EgcyznFfgOX1KyNiBniy/H8SHqideMcWrplvJo9NGD/u6SN9tEuO2VgVFLErvM
         OF/TYQ1SnqH9R2F8Ld6mouPVpbPhj1+OdGreHZjuFazo6ofbOqiQi8iC8Vxt3qiLFXHb
         cJwYDgGrrZ4GUlA9Q0C+kYeuv4lwgBeadTNx7Ac4ozoxtAd+DJWZU2AqgsYKETOlg6fT
         QhtzASawUq3zGGb19V/uPESFxCtg0YF9hnUdkQA4/8aA/ps5Fcczza6Xi7JjddTX1hpn
         L8uQPDPuTSI2+Bwcs2eMVAY/cENZthL+c6DBLueTkvLeeE5S78Sw+nNMk66IBre/jPEd
         UxgA==
X-Gm-Message-State: APt69E1q+iFqP0LEZ9lQqWqLjM7yak2Lep3O5cOhERZwWTPCDymkmDf2
        GmlW5d+GSDeqJ/qJ+jApV6xuk3dbgYsnoRyyjT8=
X-Google-Smtp-Source: AAOMgpcJtAR7QafYiBf6ZTcALueeZFNwQhTkf/NBibLYcdZ6CIEOKfLzQ5ayo+EwOsQ0Ue8ZBw8GVvURU36wpG/o4hg=
X-Received: by 2002:a1c:2fc7:: with SMTP id v190-v6mr4545734wmv.151.1530098945934;
 Wed, 27 Jun 2018 04:29:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:480b:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 04:29:05
 -0700 (PDT)
In-Reply-To: <71d13d76-4591-9206-ebbb-5e9599f10c7c@gmail.com>
References: <71d13d76-4591-9206-ebbb-5e9599f10c7c@gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 27 Jun 2018 13:29:05 +0200
Message-ID: <CAFLxGvyJsjWum34Q67UP+EGkg9+W0nPsMpu8mS9PaH8wL3Rd9g@mail.gmail.com>
Subject: Re: Memory zeroed when made available to user process
To:     Jefferson Carpenter <jeffersoncarpenter2@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:34 AM, Jefferson Carpenter
<jeffersoncarpenter2@gmail.com> wrote:
> Is there a way for a user process to mark memory as 'sensitive' or
> 'non-sensitive' when it is allocated?  That could allow it not to have to be
> zeroed before being allocated to another process.

Isn't this what we have Meltdown and Spectre for? ;-)

No, memory from the kernel is always zeroed.
libc offers malloc() and calloc() for this purpose.

-- 
Thanks,
//richard
