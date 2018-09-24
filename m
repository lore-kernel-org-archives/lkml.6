Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABD7C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5686620883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxWzHX4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5686620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIYELt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:11:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeIYELs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:11:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85-v6so6847726pge.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSmDT0rO3RTbXHu8PVgi/4vnDW7DuX+yiL+YCsE4uGs=;
        b=YxWzHX4vQzVBXYosoBSYGromW+Obac3lEQgE+N2ikwPS5cE7gdMH3Lf4JIPMlb+xJB
         nhmoCo+BCpIxtFHh6hzS0DgSXzvmKHfCQ3ywejQg7VAgEuWLH09ZxelcuirUn/3uL4gB
         /xN1Nud27F+UzXFB/6YeMlL/+Ji7hMvP0NNxTEpdW+GV0kA/VeS+qDUIh976lVceyho6
         neX4Bdkp/ZjLU1I2xGVPo9MgGNob+unO5BjR/c1/QeLQuBAoRG4Y64W8mEUeEt7w1MgQ
         0EnJNASQBPN+/Oe55QpRBsly+9wjOLUa2lImJo+pedX64gaMRnrGRd33j3lMgOqTkCeT
         iitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSmDT0rO3RTbXHu8PVgi/4vnDW7DuX+yiL+YCsE4uGs=;
        b=DzHydYQDt2jHx9Wb1rJcZbs3gFTOXB6ZM+NoCXa5xU8dYpA0gbYaSE3HthymXhg56g
         /+k6CGBTMIZKSVxLeP2g+sZE4Sl/biKJ40y60hFWYhILHsjIzqczH9TIgszmDgVLrmbc
         3UxZfYEqJWCtMaNoTjZXC/gGKKNT0TpXLEGToWID0XCOBE15NLBpqBQ2PpUJ5OxtbxxY
         wpB7Zq8KS1ity+9Ug4BSS3LJxgYCLmcX98vJ6F7tKEPSDh2ANfwNvFN7eysgTYFfjMhf
         XdB2cA+FxFrB5vIWtfkpRay0ykysARkhT6Qs/lIWyseK8QKAr/l3sbzfas9YYeSg7Mam
         JOGQ==
X-Gm-Message-State: ABuFfohfIRw39Kv8UqLwV1uPoJFUuX3NXHFvZOlIArrzhI0EMxVYPxKe
        gnG0fa3pgJv4LcOEkNov60vbPnJJ+OmZW85DKOUt1A==
X-Google-Smtp-Source: ACcGV61Qx+jvRFwi2kXxKxoVV/eyRZmfE/dwXbTCi1N79CIstjgLcvZ/XInbCfBiIhn6nAXtRiqmHY6eS622XXuSw2M=
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr645472plk.13.1537826847840;
 Mon, 24 Sep 2018 15:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180921215505.14634-1-natechancellor@gmail.com>
In-Reply-To: <20180921215505.14634-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 15:07:16 -0700
Message-ID: <CAKwvOd=PYNbPjK86Fxct=LShqnuRNhX3nih8whyjEUQBULDTLg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Change status's type in aux_reply_transaction_data
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 2:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
> implicit conversion from enumeration type 'enum
> aux_channel_operation_result' to different enumeration type 'enum
> aux_transaction_reply' [-Wenum-conversion]
>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
> warning: implicit conversion from enumeration type 'enum
> aux_channel_operation_result' to different enumeration type 'enum
> aux_transaction_reply' [-Wenum-conversion]
>                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
>                               ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I think the enum is actually wrong here.  I think the correct fix would be:

-                 reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
+                 reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;

The identifiers are so similar, my guess was that it was easy to mix
them up.  This looks like an actual bug to me, since the identifiers
have different values between the 2 different enums.

>
> Instead of implicitly or explicitly converting between types, just
> change status to type uint8_t (since its max size is 255) which avoids
> this construct altogether.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> index 05c8c31d8b31..97e1d4d19263 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
> @@ -79,7 +79,7 @@ enum aux_transaction_reply {
>  };
>
>  struct aux_reply_transaction_data {
> -       enum aux_transaction_reply status;
> +       uint8_t status;
>         uint32_t length;
>         uint8_t *data;
>  };
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
