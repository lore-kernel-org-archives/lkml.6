Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864AC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0718520833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 22:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8yNjF3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0718520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeIYEcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 00:32:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54844 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeIYEcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 00:32:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so11298799wmb.4;
        Mon, 24 Sep 2018 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zrMmlGmFWUadx/++HaB0FdRzhsq8gaU0CCYWRDLSaw=;
        b=Y8yNjF3iA7Gl0GOqTKwb3hcNXMyId1RMMvmYhzwrQNfNnlWLjq1FfjQVL7EYmtZkC9
         AHjpeEAd1iGl0c/8VeMIHm9Z8lnn6eY5WVRvdBThiJaMjFuyLrlvVMdxOEggr/KS4fNb
         Dtj1sJb9ud+jDRwKoGRx/RlnVoZnUGrOm8H/1zPBTyjoHeTb3pNx+yMj1KA1dl+nz3T/
         rvGfdJrNxebO4L31sEcgt59i69NRok77YR+u8LQprjs1wm5sn9sVcq+8aHVLSJfWMAEy
         YnxYsnpOezaWfzgfkxsGKz+Vf5zJpPr/5JAKHXLzCTtCfpCWQXNUjQM3BSgB9XqCPhkY
         SJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zrMmlGmFWUadx/++HaB0FdRzhsq8gaU0CCYWRDLSaw=;
        b=KPb5GzvOIIPBFV00qaoYu0ZA9GH8PimPvQrnXDIIelF/iXUXblmkOBdMYmX5TOPVWF
         Kd8myYcO2xm8wCjb6f7vgmzw/QQ6MYBAPBjU6WCbR7UYQD/Y7lLG/Dd9h3t+Cpt+8VLH
         uNV0yiObeanO1spvDGiQoHS9ZKsFnZKH2j1OuNC7Ih1dJf7odxpY8UQf8X+hhT7EIdm3
         Wd5Fl85yz+b/CVwWTrtcHI9yKVzPOe2p1Es6/y6dkvoLuj5qx70rRAjTGFQFOWrSv69o
         YF7nJLO3NU3Pj3o+zD3l1K+tJ/NdUlHmgW7f1rDL+I1kH16UgtYJvi05xHoK2TKvUKRw
         FaDg==
X-Gm-Message-State: ABuFfojFkdrzkF2cpLUgxOMF36CAuhPhuk+ucg57eS5LQo8zISvGUeqN
        us/ogqKjICKUMSPjjfvz1x0=
X-Google-Smtp-Source: ACcGV60suw49D9/LrZg+ikTbWCPWIhbaF/a2vCJJufa6cnu9rPERYsbuFYhXquk6zpk4bA7sUvoEVg==
X-Received: by 2002:a1c:d04c:: with SMTP id h73-v6mr289299wmg.14.1537828059877;
        Mon, 24 Sep 2018 15:27:39 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v14-v6sm172604wmh.41.2018.09.24.15.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 15:27:39 -0700 (PDT)
Date:   Mon, 24 Sep 2018 15:27:37 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx4: Avoid implicit enumerated type conversion
Message-ID: <20180924222737.GA26973@flashbox>
References: <20180924195716.30848-1-natechancellor@gmail.com>
 <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkr+ovYgmqWENHkCcAWMC+xC6NYne6SBycq_KXscpHxEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 03:24:36PM -0700, Nick Desaulniers wrote:
> On Mon, Sep 24, 2018 at 12:57 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/infiniband/hw/mlx4/mad.c:1811:41: warning: implicit conversion
> > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_TUNNEL_QP;
> >                                                     ~ ^~~~~~~~~~~~~~~~~~~~~~~
> >
> > drivers/infiniband/hw/mlx4/mad.c:1819:41: warning: implicit conversion
> > from enumeration type 'enum mlx4_ib_qp_flags' to different enumeration
> > type 'enum ib_qp_create_flags' [-Wenum-conversion]
> >                 qp_init_attr.init_attr.create_flags = MLX4_IB_SRIOV_SQP;
> >                                                     ~ ^~~~~~~~~~~~~~~~~
> >
> > The type mlx4_ib_qp_flags explicitly provides supplemental values to the
> > type ib_qp_create_flags. Make that clear to Clang by changing the
> > create_flags type to u32.
> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  include/rdma/ib_verbs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index e463d3007a35..f6f4d9e3c8ed 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -1149,7 +1149,7 @@ struct ib_qp_init_attr {
> >         struct ib_qp_cap        cap;
> >         enum ib_sig_type        sq_sig_type;
> >         enum ib_qp_type         qp_type;
> > -       enum ib_qp_create_flags create_flags;
> > +       u32                     create_flags;
> 
> I think it might be better to just have explicit casts at the
> assignment.  What do the maintainers think?
> 

That's fine with me, I tend to explicitly cast if it is only one
location but it certainly makes sense in this case as well. I'll
wait for the maintainers to weigh in before sending a v2.

Thanks for the review,
Nathan

> >
> >         /*
> >          * Only needed for special QP types, or when using the RW API.
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
