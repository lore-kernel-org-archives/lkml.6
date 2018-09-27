Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FBCC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDC3216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibsFw5Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDC3216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeI1Eu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:50:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38471 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeI1Eu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:50:29 -0400
Received: by mail-pg1-f196.google.com with SMTP id r77-v6so2954460pgr.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqh4i7/V3ST7H2fXy3WkRsTX2DEEbAKiSWf0aGnE4og=;
        b=ibsFw5Jp4rPD/Dy2DFchAIvWE1uqCk3tyToftdYswsQb7kzhUHpn8qa6NvpDSEaiMq
         ixazjjjuNJK2s7HcHE6vkaoj0VNkcyuC8YAxfkPcE8CtaB8DIfXKD9Dc0K1Z3s3ENdVV
         VK13wW5uDLQhjVyZh3YI3aWDHJTFOuPs8TFDvtDjknfUQ2E+T+qpK1HEsT5/z2FMRdlv
         BHK1BxxfgelHPBaxUOcKRNs51llZWFcXzKRz1ASebg4IR/JGbrhsSLPJFArGC2HNf5xJ
         IJUye66GKt3dQQrZftEFrdfQbhvMB2twe/bELM9MbcV0c2QYI/nIQ3YOnD4PbVcE1U7m
         Bszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqh4i7/V3ST7H2fXy3WkRsTX2DEEbAKiSWf0aGnE4og=;
        b=XtOoQe70+bp2k4qsJOwFbNUpcKpiQVrbI/k+iIZ9RZ51B/1hy8JyYvK6GWpZq70epj
         qn6Y4VqaqxH+PXFd+eFNIvxvgFrszkRU+bQNYtdliyBJquH0p/+H/Rc7FfFL7+sE2+Ks
         2OQspPL7bq1NPpED2XScehGOHpbc77FsZdvrFHBjpniV2tKXQksiMIoGbgeyqAHqXAfe
         +kkaZPAG780gFTsY3e0MloEsXETywxxHtk1hoiwoKkQNTVOA0NxQVXz0b9rFpMEQjOPk
         oVnNbM5X9M5zSI4IivTxuJqOgaqnpp4Q4z3Mut3eK5IUDp8US2eYRX6wCeZAFnHaK9he
         f7vw==
X-Gm-Message-State: ABuFfohOFiV5UJ+ivzcNaf2ULQd5IuCcqQTiZYSFzf4fg03kvIAx2xkA
        rbjaUabulcKRwae0RINHmcjr3lbZyOHCGzR+UjNnhA==
X-Google-Smtp-Source: ACcGV63MxqVWhEUoXeB1sa0K3x24dtZNKjs/nFS8npMeDtTyL6iNvgfvliS8lGXR7x8gY469i3bGXF22zOTGGAyUv3o=
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr13151377plz.238.1538087397163;
 Thu, 27 Sep 2018 15:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180927011820.13608-1-natechancellor@gmail.com> <20180927205557.32026-1-natechancellor@gmail.com>
In-Reply-To: <20180927205557.32026-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 15:29:45 -0700
Message-ID: <CAKwvOdkqcKdGnUdYXpmLhEGBzyxeGvmGAwow868y+sDFE56yFA@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/qedr: Remove enumerated type qed_roce_ll2_tx_dest
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal.Kalderon@cavium.com, Ariel.Elior@cavium.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when one enumerated type is explicitly converted to another.
>
> drivers/infiniband/hw/qedr/qedr_roce_cm.c:198:28: warning: implicit
> conversion from enumeration type 'enum qed_roce_ll2_tx_dest' to
> different enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
>         ll2_tx_pkt.tx_dest = pkt->tx_dest;
>                            ~ ~~~~~^~~~~~~
> 1 warning generated.
>
> Turns out that QED_ROCE_LL2_TX_DEST_NW and QED_ROCE_LL2_TX_DEST_LB are
> only used once in the whole tree and QED_ROCE_LL2_TX_DEST_MAX is used
> nowhere. Remove them and use the equivalent values from qed_ll2_tx_dest
> in their place.
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Rather than using an explicit cast, just convert the uses to the
>   appropriate values and delete the duplicated enum.
>
>  drivers/infiniband/hw/qedr/qedr_roce_cm.c |  4 ++--
>  include/linux/qed/qed_rdma_if.h           | 11 +----------
>  2 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> index 85578887421b..e1ac2fd60bb1 100644
> --- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> @@ -519,9 +519,9 @@ static inline int qedr_gsi_build_packet(struct qedr_dev *dev,
>         }
>
>         if (ether_addr_equal(udh.eth.smac_h, udh.eth.dmac_h))
> -               packet->tx_dest = QED_ROCE_LL2_TX_DEST_LB;
> +               packet->tx_dest = QED_LL2_TX_DEST_LB;
>         else
> -               packet->tx_dest = QED_ROCE_LL2_TX_DEST_NW;
> +               packet->tx_dest = QED_LL2_TX_DEST_NW;

Yep, looks like these were the only two sites using enum
qed_roce_ll2_tx_dest in the whole kernel.  The new enum values match
the previous enum values, so this is no functional change while
simplifying the code (one less enum to get wrong).
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>         packet->roce_mode = roce_mode;
>         memcpy(packet->header.vaddr, ud_header_buffer, header_size);
> diff --git a/include/linux/qed/qed_rdma_if.h b/include/linux/qed/qed_rdma_if.h
> index df4d13f7e191..d15f8e4815e3 100644
> --- a/include/linux/qed/qed_rdma_if.h
> +++ b/include/linux/qed/qed_rdma_if.h
> @@ -39,15 +39,6 @@
>  #include <linux/qed/qed_ll2_if.h>
>  #include <linux/qed/rdma_common.h>
>
> -enum qed_roce_ll2_tx_dest {
> -       /* Light L2 TX Destination to the Network */
> -       QED_ROCE_LL2_TX_DEST_NW,
> -
> -       /* Light L2 TX Destination to the Loopback */
> -       QED_ROCE_LL2_TX_DEST_LB,
> -       QED_ROCE_LL2_TX_DEST_MAX
> -};
> -
>  #define QED_RDMA_MAX_CNQ_SIZE               (0xFFFF)
>
>  /* rdma interface */
> @@ -581,7 +572,7 @@ struct qed_roce_ll2_packet {
>         int n_seg;
>         struct qed_roce_ll2_buffer payload[RDMA_MAX_SGE_PER_SQ_WQE];
>         int roce_mode;
> -       enum qed_roce_ll2_tx_dest tx_dest;
> +       enum qed_ll2_tx_dest tx_dest;
>  };
>
>  enum qed_rdma_type {
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
