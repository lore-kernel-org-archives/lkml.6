Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C34C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503B72170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoOOTtD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503B72170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeI1Cs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:48:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43273 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeI1Cs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:48:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id q19-v6so2748834pgn.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyByWbXBedQV+jchaM0ForXlqaPlL4mhmg6KeFjAyWc=;
        b=ZoOOTtD+fsVVxuHg3p6/lbaLpOakEZV+JHje7Y6YozCtfBz6R1JwQqzTJ5s3nE5eip
         AFUe8k32shLrLm85prI19wBUWN+TjfBaBgHpHJjClcwsl6MkczByji+M6ukND1jJ00id
         pWcvANk1yn1GbnM9e+BcbTViUbNp9Ow1bppAByJGfTFzS/VrVXGdzkOyDXPn0zXhkZxe
         JpTc5ACGJOMB5ky5H8uTiOphGPtV6xGIEioHlohDDRSy0mRjgwFZIIJfWGHukr79KaYu
         nodgER5SiZWtKV5j57sfmcK4o4yotAVpqOSw7mnHTJZSPZ68xsst+bMO+w9v0dfya9rO
         koJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyByWbXBedQV+jchaM0ForXlqaPlL4mhmg6KeFjAyWc=;
        b=aku/xu7kIukSpeAe5uzaxzPQVy3QbJMSmMHW7f0MVofa5u2SEdNaP1qhp5jHIZpzQg
         CBfWNRKOO8CnpF+E8QtqKzDWIkxF940R74KhKzohBrQL7NcK0YKnlI4SzXHRnTMmVFSL
         r2FmFhVCcIpWmQuzFJSIQmXIsx39vPORt7E+MA1ENKklg36AhPcz/BC1jjeDdef+UsnS
         UxUneTfPgzI+5W9bIV6LXS0EJgfXgkqQ3Wj+refgqyFJ5rlLFhUvG0DpbYz9zjriX+sS
         gbBdvrdELBwpPyLC6u+QUG0b33B70zyuMwd1cdq6ZaIDcPX/LvS304DRykX7pxK7dF0y
         tfGg==
X-Gm-Message-State: ABuFfojENjfvcKuGvUPlP6mnIl93UR4R2uPPOe7Tw5T6tbDLPBf3hly5
        lKdseC3uRfxLzt+N03HCMzpFVVvkkHgm2iflcszryg==
X-Google-Smtp-Source: ACcGV61U7a+uO2jYDW7F6Zbo/vzKDE45j6yjf6o1xvYhp4YsMKq3pN02KsbDR7zwzLPhc+JtoUJ9vcboAugjKXN3bAs=
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr12124692pgl.302.1538080103331;
 Thu, 27 Sep 2018 13:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180927011820.13608-1-natechancellor@gmail.com>
In-Reply-To: <20180927011820.13608-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:28:12 -0700
Message-ID: <CAKwvOd=Oe1AAbQKcR+6K7LtZGne+-=3zREs_xVMnEbXBZJDJTQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/qedr: Explicitly cast pkt->tx_dest to qed_ll2_tx_dest
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal.Kalderon@cavium.com, Ariel.Elior@cavium.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:18 PM Nathan Chancellor
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
> Avoid this warning by explicitly casting pkt->tx_dest to
> qed_112_tx_dest, which has the expected values from the
> type qed_roce_ll2_tx_dest.

But these enums are different lengths, which is problematic for this
patch.  Is this code broken, or that it's ok for ll2_tx_pkt.tx_dest to
have a value that's not a valid enumeration value for enum
qed_ll2_tx_dest? (QED_LL2_TX_DEST_MAX 's value (3) is outside the
enumeration values of enum qed_roce_ll2_tx_dest).

include/linux/qed/qed_rdma_if.h:
 42 enum qed_roce_ll2_tx_dest {
 43         /* Light L2 TX Destination to the Network */
 44         QED_ROCE_LL2_TX_DEST_NW,
 45
 46         /* Light L2 TX Destination to the Loopback */
 47         QED_ROCE_LL2_TX_DEST_LB,
 48         QED_ROCE_LL2_TX_DEST_MAX
 49 };

include/linux/qed/qed_ll2_if.h:
 64 enum qed_ll2_tx_dest {
 65         QED_LL2_TX_DEST_NW, /* Light L2 TX Destination to the
Network */
 66         QED_LL2_TX_DEST_LB, /* Light L2 TX Destination to the
Loopback */
 67         QED_LL2_TX_DEST_DROP, /* Light L2 Drop the TX packet */
 68         QED_LL2_TX_DEST_MAX
 69 };

Maybe the maintainers can clarify?

>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_roce_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> index 85578887421b..147e0d69003d 100644
> --- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> +++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
> @@ -195,7 +195,7 @@ static int qedr_ll2_post_tx(struct qedr_dev *dev,
>
>         ll2_tx_pkt.num_of_bds = 1 /* hdr */  + pkt->n_seg;
>         ll2_tx_pkt.vlan = 0;
> -       ll2_tx_pkt.tx_dest = pkt->tx_dest;
> +       ll2_tx_pkt.tx_dest = (enum qed_ll2_tx_dest)pkt->tx_dest;
>         ll2_tx_pkt.qed_roce_flavor = roce_flavor;
>         ll2_tx_pkt.first_frag = pkt->header.baddr;
>         ll2_tx_pkt.first_frag_len = pkt->header.len;
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
