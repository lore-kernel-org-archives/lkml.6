Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B30C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1BA2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/YUEE/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1BA2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeI1DOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:14:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40318 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:14:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so2722003pfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iw08QegY6zdolsBrbHlGz1udJm+xOd7z3VpmwWRDxH4=;
        b=Y/YUEE/YO5E8mvG8IjmdxWKspeKVkLZsq2IbiK/j3JQXJP4gLYJReOgVakIWot6Kly
         yaWYXWHcZ/wNTGr8HTlQmLh3wMyI9/NLyyTkD+JUTm34jkO3LyUpZe3M3b/vMRsDdAxk
         IJ079KFEIbu11cbi/1peHT4bgfplCx4/Ldg6QpGdVeGT/tGvd3+Ni5I6dscKtqkOiTuM
         Xc8YbbwHUNpEFdjELoQEK5/4aNMLeCYLErhUSzfoFKBa5w6a8oTR2RL42nb5V/M1fbvY
         PjRd9dIBEr2Rs76ANlbtVhMDwcs5oxju5pUgR4vjPLhRyuA5nHQMrA0GsvrLRQdNSsn7
         ApgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iw08QegY6zdolsBrbHlGz1udJm+xOd7z3VpmwWRDxH4=;
        b=AnpC2ctxq3N90cOynRyskY/fvQ8Ca7FKZGX39dKBv+UG4r7J0IO9xq5foGOifbCrRe
         kUPG8jKgX/cScU1eukJzldGTmkOrte8RiTwBPLklTTGaOJUkUFNz/vYNSonn4aShV1z4
         WHkR4b7pf0tJlP8uWq6DYXNefh6GjpTj2YMuLdCaNj7zg1IDD0bU0Ruva87eteszSAgw
         O1115fDq9ZY7EhtAevZI1vPBMYd7fboh254P86iR5/GtW3T7FpFUY7SgsmFa/pHCHsMn
         zXNCRnCcUQszo8ozo9jLyaqbz7KlOEHXoGDIx2hi8kp0OKYluqusYOAOTqLyMHO459x7
         yAHQ==
X-Gm-Message-State: ABuFfogEIQf4sIfwG0E6aZqUAf1V+jIQC2x6HyQUKEWwB9b0P8PMxBcK
        4A/qKGYqsfTXmzVxVkNFEeBdjX91lT1nGCQPIo8s2A==
X-Google-Smtp-Source: ACcGV60Izt78Jh1tbHQJOkNLllF46+qreZYREiu+iY52K4YpH48vS8Gx35ZCBUHj9GiVTT9s/Jggp1GB4L1RCBf5kow=
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr13080549plk.13.1538081639682;
 Thu, 27 Sep 2018 13:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com> <20180927204352.19569-1-natechancellor@gmail.com>
In-Reply-To: <20180927204352.19569-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:53:48 -0700
Message-ID: <CAKwvOdncohhariVufRF=S1aZ9H9UJZhksBMGtM+FaU5xmT06JQ@mail.gmail.com>
Subject: Re: [PATCH v2] IB/mlx4: Avoid implicit enumerated type conversion
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:44 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is implicitly converted to another.
>
> drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> type 'enum ib_qp_create_flags' [-Wenum-conversion]
>                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
>                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
>
> drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> type 'enum ib_qp_create_flags' [-Wenum-conversion]
>                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
>                                                     ~ ^~~~~~~~~~~~~~~~~
>
> The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> type ib_qp_create_flags. Make that clear to Clang by changing the
> create_flags type to int.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Use int instead of u32 since enums are restricted to this range, as
>   suggested by Nick.

Thank you for making this change.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  include/rdma/ib_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 0d822a9db300..e5ec04e844cd 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1151,7 +1151,7 @@ struct ib_qp_init_attr {
>         struct ib_qp_cap        cap;
>         enum ib_sig_type        sq_sig_type;
>         enum ib_qp_type         qp_type;
> -       enum ib_qp_create_flags create_flags;
> +       int                     create_flags;
>
>         /*
>          * Only needed for special QP types, or when using the RW API.
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
