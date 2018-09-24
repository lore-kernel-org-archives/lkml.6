Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB10AC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4C20C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqdDPHNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE4C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeIYE0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:26:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36244 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbeIYE0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:26:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id y13-v6so6816069wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5rMojbeLQ4wf0Thqx+pjTHjeMhNiJTAXQ4pr12hittM=;
        b=fqdDPHNraTHggCGg9Y9Zix+roaZ63/1S4yiN+kxWzEfQFnarPro1W2HO/g/kXG1nXb
         pyCIfRP80cmgsxMwKLafNn5CB+rY4WSgFHuYH/MlQlqFyA+nP8ZUago7ScPWFUzipQ0O
         8wwUF37tPJWFt31beJecNCrkE2BDXmcA53hQQRV/7x43dfd/PU6b1j4BPQE5H43r2BVw
         NqPYoDNvH5uZxN+eZWsLALOl6HOXaX9n+0t1qpoepyNe8AGPhpRZ7nZIw7JX+s6/NDWz
         fIpjynSN3w9ZDvZtAE3gQ/EqjrfQY7DvicPHYXgmrKp6ztr7i6EucjP4mNBkBLnCGkos
         iCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5rMojbeLQ4wf0Thqx+pjTHjeMhNiJTAXQ4pr12hittM=;
        b=erLymB//gnU1Zco0sQV13OOaoe2Rl3omBGpGXXizRLCfuZg7Lhj9tb36x2dVXSQLyk
         4sH2li7QnpiJeBhk63X+HYb/zwXzZMelPCfIDCkHJFw1JOIlLTEXeqHD1xMEpm9x+TM3
         iLXwKAh+D98/yHObMWOZ7j1QVj7CI7tVL0psZsIxoi2PzzyUrS1Ua9IcjZNpeE8a0bjT
         2+EX6z1ntB+Ty9wnHm4/x4g91nkEcC/sFeod/Ma01UAYkcJRoJvLAC+DoOHeJVB+7oAr
         08CX9W7C4nemBP5wwY9JNgxUtYN4z3zZxrJu/oPKDSlT5Yl8HfIuaIUBDWFgzOiya4OW
         b5zg==
X-Gm-Message-State: ABuFfohtJQ0iDKOmRSiXFl8GKlW2s6YW7JR4/eZJgjh/Lc71KQzUO8Fh
        FpiZKTACO4X+Xxyj3ltBQhv69EFBD3xV5w==
X-Google-Smtp-Source: ACcGV63/Khht6CWLQXZdicJj1dea+QKKuuR8G4cvcyQqFDnPfZu7omnjhxaybwSl9HPo7EYgx0zfzg==
X-Received: by 2002:a1c:adca:: with SMTP id w193-v6mr246000wme.147.1537827747633;
        Mon, 24 Sep 2018 15:22:27 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id q200-v6sm22865609wmd.2.2018.09.24.15.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 15:22:26 -0700 (PDT)
Date:   Mon, 24 Sep 2018 15:22:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Change status's type in
 aux_reply_transaction_data
Message-ID: <20180924222225.GA26613@flashbox>
References: <20180921215505.14634-1-natechancellor@gmail.com>
 <CAKwvOd=PYNbPjK86Fxct=LShqnuRNhX3nih8whyjEUQBULDTLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=PYNbPjK86Fxct=LShqnuRNhX3nih8whyjEUQBULDTLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:07:16PM -0700, Nick Desaulniers wrote:
> On Fri, Sep 21, 2018 at 2:55 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
> > implicit conversion from enumeration type 'enum
> > aux_channel_operation_result' to different enumeration type 'enum
> > aux_transaction_reply' [-Wenum-conversion]
> >                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> >                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
> > warning: implicit conversion from enumeration type 'enum
> > aux_channel_operation_result' to different enumeration type 'enum
> > aux_transaction_reply' [-Wenum-conversion]
> >                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> >                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I think the enum is actually wrong here.  I think the correct fix would be:
> 
> -                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> +                 reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
> 
> The identifiers are so similar, my guess was that it was easy to mix
> them up.  This looks like an actual bug to me, since the identifiers
> have different values between the 2 different enums.
> 

Hmmm interesting... I will be happy to send a v2 with your suggestion if
one of the maintainers could confirm that to be the case (given DRM code
is rather dense).

Thanks for the review!
Nathan

> >
> > Instead of implicitly or explicitly converting between types, just
> > change status to type uint8_t (since its max size is 255) which avoids
> > this construct altogether.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> > index 05c8c31d8b31..97e1d4d19263 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> > @@ -79,7 +79,7 @@ enum aux_transaction_reply {
> >  };
> >
> >  struct aux_reply_transaction_data {
> > -       enum aux_transaction_reply status;
> > +       uint8_t status;
> >         uint32_t length;
> >         uint8_t *data;
> >  };
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
