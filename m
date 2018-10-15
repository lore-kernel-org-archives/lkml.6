Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D695C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C36208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufygQDov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C36208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeJPFwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:52:09 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40130 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeJPFwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:52:09 -0400
Received: by mail-lj1-f170.google.com with SMTP id r83-v6so18934876ljr.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c6v2p/Mh2UIeR7AshI2QHs59D35WmV8IBz++4LUXbng=;
        b=ufygQDovQPP5kauOD4VGri5yApe9sG8pPBWYC/jjGYlWoOGkv3N7SOEPz2jPiCd9UE
         aFbBgghDgGSFKhSu1uO8VNHIU9IwIX6AQ9o0j86v2xAJeu2T+odvN773jDar1zOZfRC0
         OIjLyO0yaoKDTYIvuwodXJZ4vSboMaq7LfRHXpiK5O5gMAJ0Irf6J1AmeZM9TRO5k5lD
         nePaDrZhIZg+WbxBdvL64alrcyzDKAdGO/pUGkPLTKWhoipVTC8keTMWv0jffx+YbTZp
         oBfMhp80Xj2TJZfZm1/lilWN/7yILroffimgEfLwfpivN7VZRy4Bsgl0oTkGnTDIdb9N
         s55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c6v2p/Mh2UIeR7AshI2QHs59D35WmV8IBz++4LUXbng=;
        b=ez2YxBZN+OhYfp8mrBj3OHGEwx/Ll852HxrqUaDCADIpXfYksfIzTuq4vRVF/ASuMQ
         g5V4MiNtZNUQMxPEVS2B0wpmt2FOOj4oC4wI1XkEjMUytejprTPQNZ97r3uTjTgultoA
         g3VNXu6bgoAl4DhjI/Z/h2nPqIOw/STlMyyYuxpowoCORtcBiLCb+P7VoIUwMQVxPkEB
         njUA0umyniemSXRPklGd+OaVNCo5Vc3yz7qnpI1w5e7rmYFMAACqGX5iW6/0s6vfZ0s1
         gWjXIJ/xRaJ3GivhCFGDciXpovQLSVBCQp7AO5FNpVhsBeMVJr3K9IbSdVqTGiA6rbE4
         15Gg==
X-Gm-Message-State: ABuFfogyEgnqZERzLljvcXX/CHCJ9Lua8/nrO0IY3D/K7P4+yRx1OLMO
        //yqyrNryeBIV6fNVtKqEWtDVeZmRTZ7Qs5qhu2BicgBBLY=
X-Google-Smtp-Source: ACcGV60UCQpSoq3Rpsp/tAUgmvdkQPrO5isMPOgHZuPbOtq+Y0T07kI5IbSDauynCyTdkURb1wej48WAhg7gYtphS6A=
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr13136016ljc.14.1539641099688;
 Mon, 15 Oct 2018 15:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com> <20181003171720.169953-7-rkir@google.com>
 <20181015183605.GB28454@kroah.com>
In-Reply-To: <20181015183605.GB28454@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 15 Oct 2018 15:04:47 -0700
Message-ID: <CAOGAQeqiWMseXPi6n2gkBHAWhsRdwDyMXpCFB1h2mEuQLJz-mw@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] platform: goldfish: pipe: Return status from
 "deinit" since "remove" does not do much
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This function can not fail, why are you returning 0 always?  That
> doesn't make sense.

remove in struct platform_driver requires returning something, we have
to have "return" somewhere.

I think we want to return closer to the place where we do something useful.
