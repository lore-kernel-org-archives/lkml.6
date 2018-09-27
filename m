Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF76216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVypxl/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF76216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbeI1Cie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:38:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35454 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1Cie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:38:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so2686442pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hfrntaj5PagNbMYGs+mmJCxWqM/A41y9ewSyAx3Pso=;
        b=DVypxl/IVKqzCtiBGEfjWVsf6u8TruRsHPJgArr51p/iiQif/Krpna5ZugQ4QgkKt9
         N56Q/pebrPyrBm31ZxMU5FhV4TqeAFnhS2HJ6q9aLmT9acw2J2wOWezcJ3rxjuA+kObr
         V6lskuWgsphqjGwmjheMX15nJFBxaWePS/Qva0FnsBiKtJdTiJluDeKKrMJbjxEQRMom
         Ktpb0lh+J33Z90DZpGYyojxv3SJlxOu1dszdMo3i+MWvd+662DWtak3KP2cLDyH7X4ut
         1V58GetlE+3vRHRaFTfXXa5wbZ2eWIcmerL/S3+qmK03VRIu6r/uI0H/a1FSC1X6qktS
         S48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hfrntaj5PagNbMYGs+mmJCxWqM/A41y9ewSyAx3Pso=;
        b=N+/5N4vZtHuQDYIZ6wOEwgwfK9BZeO6OxZMdRPvjrIIHrVE4nNyQN8ugPrh1sPfHRL
         BXg0MqUrOv3IDsRT+uS/sKAXEg//XZMl7K8bDKU0WXrAHDzPlmb4+qqGNT0p2lLfwQ30
         jd8DOHPIt5fgr2m7Eye7oPirsYHhLIXgWslfQi4xD+4TFlqJFomOwIPBCJt0XpokrvQV
         gOQ1HdQUFKNUZMpA/HBLNRe0zBOj5I3j5FPNCYiSbhL8qtLEzkNGaMbEfjzqK35Ogszx
         Wsn7NUgakamF6lS4rW1s+8W/qunuxE8LUhWgcamgJdq7mZebhEYw/RXZbyP6BGG+n6mE
         nD7A==
X-Gm-Message-State: ABuFfoic0SURfIXnWF+GKwKJjhUkRIPQq1HOhrUyGuT2QUg4hH73TVV3
        MqiEis60/szGXfeMGnGkCvN55Ayqt1CG302o3o8DuQ==
X-Google-Smtp-Source: ACcGV615xa2dfts6s2GYNBcGvLjrFqVNgd2FyfzIUpxrZiAM9jKBNPgU1Brb4Y3vebZXkiDkjO3JdbZncSehVpNt9xE=
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12-v6mr12881445plq.229.1538079512356;
 Thu, 27 Sep 2018 13:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180927050156.20023-1-natechancellor@gmail.com> <20180927051222.23084-1-natechancellor@gmail.com>
In-Reply-To: <20180927051222.23084-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:18:20 -0700
Message-ID: <CAKwvOdm41LdZ3KPO765arTAV99awzR8gPn=_79-UcZ6DWL9Fpg@mail.gmail.com>
Subject: Re: [PATCH v3] IB/rxe: Remove unnecessary enum values
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     monis@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:14 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when an emumerated type is implicitly converted to another.
>
> drivers/infiniband/sw/rxe/rxe.c:106:27: warning: implicit conversion
> from enumeration type 'enum rxe_device_param' to different enumeration
> type 'enum ib_atomic_cap' [-Wenum-conversion]
>         rxe->attr.atomic_cap                    = RXE_ATOMIC_CAP;
>                                                 ~ ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:131:22: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_port_state' [-Wenum-conversion]
>         port->attr.state                = RXE_PORT_STATE;
>                                         ~ ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:132:24: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>         port->attr.max_mtu              = RXE_PORT_MAX_MTU;
>                                         ~ ^~~~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:133:27: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>         port->attr.active_mtu           = RXE_PORT_ACTIVE_MTU;
>                                         ~ ^~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/rxe/rxe.c:151:24: warning: implicit conversion
> from enumeration type 'enum rxe_port_param' to different enumeration
> type 'enum ib_mtu' [-Wenum-conversion]
>                                 ib_mtu_enum_to_int(RXE_PORT_ACTIVE_MTU);
>                                 ~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~
> 5 warnings generated.
>
> Use the appropriate values from the expected enumerated type so no
> conversion needs to happen then remove the unneeded definitions.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Nathan,
Thanks for taking the time to respond to feedback and send incremental
revisions to this patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> v1 -> v2:
>
> * Don't cast, just use the expecting enumerated value directly, per
>   Jason's request
>
> v2 -> v3:
>
> * Convert two spots from RXE_PORT_MAX_MTU to IB_MTU_4096 then remove
>   value definitions.
>
>  drivers/infiniband/sw/rxe/rxe.c       | 13 ++++++-------
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  2 +-
>  drivers/infiniband/sw/rxe/rxe_param.h |  4 ----
>  3 files changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 10999fa69281..383e65c7bbc0 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -103,7 +103,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>         rxe->attr.max_res_rd_atom               = RXE_MAX_RES_RD_ATOM;
>         rxe->attr.max_qp_init_rd_atom           = RXE_MAX_QP_INIT_RD_ATOM;
>         rxe->attr.max_ee_init_rd_atom           = RXE_MAX_EE_INIT_RD_ATOM;
> -       rxe->attr.atomic_cap                    = RXE_ATOMIC_CAP;
> +       rxe->attr.atomic_cap                    = IB_ATOMIC_HCA;
>         rxe->attr.max_ee                        = RXE_MAX_EE;
>         rxe->attr.max_rdd                       = RXE_MAX_RDD;
>         rxe->attr.max_mw                        = RXE_MAX_MW;
> @@ -128,9 +128,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  /* initialize port attributes */
>  static int rxe_init_port_param(struct rxe_port *port)
>  {
> -       port->attr.state                = RXE_PORT_STATE;
> -       port->attr.max_mtu              = RXE_PORT_MAX_MTU;
> -       port->attr.active_mtu           = RXE_PORT_ACTIVE_MTU;
> +       port->attr.state                = IB_PORT_DOWN;
> +       port->attr.max_mtu              = IB_MTU_4096;
> +       port->attr.active_mtu           = IB_MTU_256;
>         port->attr.gid_tbl_len          = RXE_PORT_GID_TBL_LEN;
>         port->attr.port_cap_flags       = RXE_PORT_PORT_CAP_FLAGS;
>         port->attr.max_msg_sz           = RXE_PORT_MAX_MSG_SZ;
> @@ -147,8 +147,7 @@ static int rxe_init_port_param(struct rxe_port *port)
>         port->attr.active_width         = RXE_PORT_ACTIVE_WIDTH;
>         port->attr.active_speed         = RXE_PORT_ACTIVE_SPEED;
>         port->attr.phys_state           = RXE_PORT_PHYS_STATE;
> -       port->mtu_cap                   =
> -                               ib_mtu_enum_to_int(RXE_PORT_ACTIVE_MTU);
> +       port->mtu_cap                   = ib_mtu_enum_to_int(IB_MTU_256);
>         port->subnet_prefix             = cpu_to_be64(RXE_PORT_SUBNET_PREFIX);
>
>         return 0;
> @@ -300,7 +299,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>         mtu = eth_mtu_int_to_enum(ndev_mtu);
>
>         /* Make sure that new MTU in range */
> -       mtu = mtu ? min_t(enum ib_mtu, mtu, RXE_PORT_MAX_MTU) : IB_MTU_256;
> +       mtu = mtu ? min_t(enum ib_mtu, mtu, IB_MTU_4096) : IB_MTU_256;
>
>         port->attr.active_mtu = mtu;
>         port->mtu_cap = ib_mtu_enum_to_int(mtu);
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 8e305422adbb..afd53f57a62b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -195,7 +195,7 @@ static inline int qp_mtu(struct rxe_qp *qp)
>         if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC)
>                 return qp->attr.path_mtu;
>         else
> -               return RXE_PORT_MAX_MTU;
> +               return IB_MTU_4096;
>  }
>
>  static inline int rcv_wqe_size(int max_sge)
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index 4555510d86c4..bdea899a58ac 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -90,7 +90,6 @@ enum rxe_device_param {
>         RXE_MAX_RES_RD_ATOM             = 0x3f000,
>         RXE_MAX_QP_INIT_RD_ATOM         = 128,
>         RXE_MAX_EE_INIT_RD_ATOM         = 0,
> -       RXE_ATOMIC_CAP                  = 1,
>         RXE_MAX_EE                      = 0,
>         RXE_MAX_RDD                     = 0,
>         RXE_MAX_MW                      = 0,
> @@ -139,9 +138,6 @@ enum rxe_device_param {
>
>  /* default/initial rxe port parameters */
>  enum rxe_port_param {
> -       RXE_PORT_STATE                  = IB_PORT_DOWN,
> -       RXE_PORT_MAX_MTU                = IB_MTU_4096,
> -       RXE_PORT_ACTIVE_MTU             = IB_MTU_256,
>         RXE_PORT_GID_TBL_LEN            = 1024,
>         RXE_PORT_PORT_CAP_FLAGS         = RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP,
>         RXE_PORT_MAX_MSG_SZ             = 0x800000,
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
