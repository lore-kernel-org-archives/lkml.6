Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A04C43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21772098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PedXSke9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21772098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeIYE3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:29:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42037 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeIYE3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:29:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so9747685pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPsCcGf6cqRbLlFm5vki7CQZA54KjLndaCU+NsNfKjA=;
        b=PedXSke9IRYWTST9VNoLPznOduH+0O1VqMYY7Y4XsW7pFnixGh9ZCFBpFVqxHqkWZ+
         WaNKYB0ekJxkbIcT5hfYuZfY8cjAobijEhWnd7Kct2p/958ewgKQPCNp5DBjB137Boj9
         EXGioGjAjflhp6wx0ltTRNjwYuZXEzJW3LRRXsxu9E+NPFtgEJrgkpXRxZnRZ+bbPkxY
         QHn8myvQInJQ0wjWamGalURwBQIp1M9lGM9somyS3z2BBNQkS2OktbWrWBofMi+OxaOz
         pea7nlwkawiudx86ldFbYdmInCSU+WF2Z+EX5sfEeBvOJd11xCEzYt8deuF75B1x8WW7
         tCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPsCcGf6cqRbLlFm5vki7CQZA54KjLndaCU+NsNfKjA=;
        b=VWbLf8Zp07OFHKqN1UbdIgsr2NOQbT1HoC6EPUhlKN0WHZWlR7HtM78UDz5TCeuend
         8GGO7+J0/wx3xKED9I4GPjlof7HngGUx5dy6llsZ0rcEsU9POUKgeNDl3ShQQTc9aGIz
         YrlXLdyPNQiSNVK6WK1FPbIHqeCpPdMnogl2FgYJupmmbCkpSY/LFES5JgCFd/nnPzZV
         AP5kEgZ2PYyIGoCLoSvnmuztSFZc9JJiwjpxcPt/aUQvaUxP+z0mzudkxdfuQq7JxHBT
         NMXPZp63ZyLksJNKqb2txHOiXFIAGIqRWhbEcTg97dzlDBWi1cH5pKULuG+5/VUXRTNM
         Hbgw==
X-Gm-Message-State: ABuFfojF/Azm40YgnvBb/rF7AzWBLGsPhsJnJ7yQXFg2E/5wK5/KbhXi
        Eh1GEPP2NASuzNu4Sl3bHTXYwWZ3kxzvRzNAlDZQ+sRWZAk=
X-Google-Smtp-Source: ACcGV602BXMMmyF73lECO7ObbgHmECFJCGOzf+DKTy/xNOyJ5zyF8gd5z3KMK3guZ4rA4G+tGkijcEz4fgFsGQgW5lI=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr596498pgn.145.1537827887592;
 Mon, 24 Sep 2018 15:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180924195716.30848-1-natechancellor@gmail.com>
In-Reply-To: <20180924195716.30848-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Sep 2018 15:24:36 -0700
Message-ID: <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
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
> create_flags type to u32.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  include/rdma/ib_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index e463d3007a35..f6f4d9e3c8ed 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
>         struct ib_qp_cap        cap;
>         enum ib_sig_type        sq_sig_type;
>         enum ib_qp_type         qp_type;
> -       enum ib_qp_create_flags create_flags;
> +       u32                     create_flags;

I think it might be better to just have explicit casts at the
assignment.  What do the maintainers think?

>
>         /*
>          * Only needed for special QP types, or when using the RW API.
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
