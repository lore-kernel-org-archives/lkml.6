Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FCFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F58E216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVtRSz5X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F58E216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeI1CzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:55:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37460 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbeI1CzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:55:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so4039591wrr.4;
        Thu, 27 Sep 2018 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ytHOpUSnGJXSrWPcgZKRJSJ0o7STDb4obx/MyLkkEMo=;
        b=MVtRSz5XuOTy92fd6YVNhAOueZSbuNfWhFeb6hsb7RFczWBYHnu8d9v90rjVRukdxO
         hpqhsi6ZaoB2UdxIW1OFvZDv7ecygs+2BBfgPAXPnmvR7+EAUmtFiO46h7xuxWmnYYRD
         hg0uTZM5gBJNAYxdRKMkTlfaJBQ1qg2UxfnbPg0vY11a2jr7L5K1Y/T+ZyYiwFYNTwkp
         th8Vv1qlTiPeLvKzeJd2Z5lqWe41ejpYEXrlUTsIqdD16vA4oPi/iNljFz37StKUfrCl
         WKNV5YC/DM6rzTl8Sx3i40UsDS+6PaGMkzyrJ42ZuIWUVTdZKP8mFqAUA8gwbxqNQREz
         0akg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ytHOpUSnGJXSrWPcgZKRJSJ0o7STDb4obx/MyLkkEMo=;
        b=sGnL9lSE6Em9io9xSxKCGBW0BznljwuwyvIaOMfzkv9wqXE0FEnMu5VgWuakVE5e0f
         anmz+R7Y7qTjCnr69ikSZKDhUOj6dbBgdFyBo6A9T3SK6AiIVedMx2IgYqUq1CTlKa4C
         KRq2GrDRbitarvRI41nd+ex/F31CeiGWgn7u2QcQzYGB9gf8w97nGERxYqgPVOZIjtJI
         pgv7fQBE10e6jIrOleoQRX6YTY1dLUz6+AWKFfKhw1N6zuukiUdPCVs7tfYlFQ1edNUC
         8gmjJRfHjH/+nPdWesedqOzeUnlVkP6R2wWhW1MkQeyS2M+1/jz+3YBqUQnkQB6Kcx5p
         Eu9A==
X-Gm-Message-State: ABuFfoiUGwkF4gNR3FWlQLFLkG632orupa5fyYicQsItjcnWqyJL8DVa
        6wf4GcrVHDByx5DBAHyMCMI=
X-Google-Smtp-Source: ACcGV62vdMxLYJ3zJt8ei8FbtYKh7wwiHXYFBLDcPpmJzLSb7ijYWH4SjTDr5Dw8Lo/NuHG+VG2R0g==
X-Received: by 2002:a5d:4706:: with SMTP id y6-v6mr1758719wrq.256.1538080502805;
        Thu, 27 Sep 2018 13:35:02 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id k7-v6sm53709wmf.41.2018.09.27.13.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:35:02 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:35:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal.Kalderon@cavium.com, Ariel.Elior@cavium.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/qedr: Explicitly cast pkt->tx_dest to
 qed_ll2_tx_dest
Message-ID: <20180927203500.GA12450@flashbox>
References: <20180927011820.13608-1-natechancellor@gmail.com>
 <CAKwvOd=Oe1AAbQKcR+6K7LtZGne+-=3zREs_xVMnEbXBZJDJTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=Oe1AAbQKcR+6K7LtZGne+-=3zREs_xVMnEbXBZJDJTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:28:12PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 26, 2018 at 6:18 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is explicitly converted to another.
> >
> > drivers/infiniband/hw/qedr/qedr_roce_cm.c:198:28: warning: implicit
> > conversion from enumeration type 'enum qed_roce_ll2_tx_dest' to
> > different enumeration type 'enum qed_ll2_tx_dest' [-Wenum-conversion]
> >         ll2_tx_pkt.tx_dest = pkt->tx_dest;
> >                            ~ ~~~~~^~~~~~~
> > 1 warning generated.
> >
> > Avoid this warning by explicitly casting pkt->tx_dest to
> > qed_112_tx_dest, which has the expected values from the
> > type qed_roce_ll2_tx_dest.
> 
> But these enums are different lengths, which is problematic for this
> patch.  Is this code broken, or that it's ok for ll2_tx_pkt.tx_dest to
> have a value that's not a valid enumeration value for enum
> qed_ll2_tx_dest? (QED_LL2_TX_DEST_MAX 's value (3) is outside the
> enumeration values of enum qed_roce_ll2_tx_dest).
> 
> include/linux/qed/qed_rdma_if.h:
>  42 enum qed_roce_ll2_tx_dest {
>  43         /* Light L2 TX Destination to the Network */
>  44         QED_ROCE_LL2_TX_DEST_NW,
>  45
>  46         /* Light L2 TX Destination to the Loopback */
>  47         QED_ROCE_LL2_TX_DEST_LB,
>  48         QED_ROCE_LL2_TX_DEST_MAX
>  49 };
> 
> include/linux/qed/qed_ll2_if.h:
>  64 enum qed_ll2_tx_dest {
>  65         QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the
> Network */
>  66         QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the
> Loopback */
>  67         QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
>  68         QED_LL2_TX_DEST_MAX
>  69 };
> 
> Maybe the maintainers can clarify?
> 

My assumption was that if QED_ROCE_LL2_TX_DEST_MAX was used that the
packet would be dropped.

Turns out that QED_ROCE_LL2_TX_DEST_MAX isn't actually used anywhere in
the tree. I suppose that qed_roce_ll2_tx_dest could just be removed and
all other instances of those values could be converted to
qed_ll2_tx_dest like the rxe patch. I'll test this now and send a patch
along if it works out.

Nathan

> >
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/infiniband/hw/qedr/qedr_roce_cm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> > index 85578887421b..147e0d69003d 100644
> > --- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> > +++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> > @@ -195,7 +195,7 @@ static int qedr_ll2_post_tx(struct qedr_dev *dev,
> >
> >         ll2_tx_pkt.num_of_bds = 1 /* hdr */  + pkt->n_seg;
> >         ll2_tx_pkt.vlan = 0;
> > -       ll2_tx_pkt.tx_dest = pkt->tx_dest;
> > +       ll2_tx_pkt.tx_dest = (enum qed_ll2_tx_dest)pkt->tx_dest;
> >         ll2_tx_pkt.qed_roce_flavor = roce_flavor;
> >         ll2_tx_pkt.first_frag = pkt->header.baddr;
> >         ll2_tx_pkt.first_frag_len = pkt->header.len;
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
