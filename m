Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C88C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gdU4dB5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C88C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbeGXRIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:08:41 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36516 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbeGXRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:08:40 -0400
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so1717880ywg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NFNc/eMgMHVYssqhOW92yZM6cke7oGOzzYhvQJd7hdk=;
        b=gdU4dB5aYn2s2h83Zj9R3E6kQoO8ATfRx18dqr4wixzLWmC3TllWfYSNGh9cakeqL5
         qLtWe2ZxXJdnFXnZSLt16G8fnOL5K/6c5ch/PK7UykXiLq+1sUjp3hC159fIirF2/BoC
         6idunzmqZihA5WFcpSkJsDSfxt9s0NoJxUbD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NFNc/eMgMHVYssqhOW92yZM6cke7oGOzzYhvQJd7hdk=;
        b=ODzZHa89rtkiChXyzUyg0n+WHgE7xcJZi9lNWy+5Fbdt9/0IHV/Li8X9dYH6iPjP+H
         J80sN2Wtzkx4nzWoR3rp6mGjY64RUQMmtLLP5GoPnf5SuLwbaQ/oPfVDY9bKdbrxta1r
         tJRw3sTIDLfok+QtVoEtRAAa+io9rwmwuA0lkJ9i7f8AYhD4XNbPO27XY7+EAAnV3hCt
         uitDk/S1eCtLL58mLjfpODkq9czQ+05iJzDdgsOY8ZKlDvxqWqnpHtkw0iRnvhAyKmtK
         p/UNPVQ96gPiSEUNXme1TLxTBnRJ0hzOLQHmO/tFwEns0MtRF8jGKHN1a3sGjv7Gu9UA
         hP5w==
X-Gm-Message-State: AOUpUlG9XOR+jAyU6IylCGaXG2WO4V8TWf36lXf3Rmghjsj2B4IfZbMM
        gVTZMlgcme0V4VXHuXbw5e7tL+xq0u3ZOXuobwm3UA==
X-Google-Smtp-Source: AAOMgpdA/oWK/SPVRKMpHX5pqZ5SRo1Uc81SJ7exZsXy7+ipd9z5dc9T4njcJDc7eXA63d5/czMXteQwH8fCNzXJ0aU=
X-Received: by 2002:a81:f102:: with SMTP id h2-v6mr9673237ywm.297.1532448089613;
 Tue, 24 Jul 2018 09:01:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:c651:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 09:01:29
 -0700 (PDT)
In-Reply-To: <CACKFLini64_5N7aVtPAVH3CBYCSsdHAJv35jimR18PJXeV6j5g@mail.gmail.com>
References: <20180724052454.21524-1-yuehaibing@huawei.com> <CACKFLini64_5N7aVtPAVH3CBYCSsdHAJv35jimR18PJXeV6j5g@mail.gmail.com>
From:   Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Date:   Tue, 24 Jul 2018 21:31:29 +0530
Message-ID: <CAACQVJrS9_fCNG3g51q7kZnTt5wy1X-SrvXTsFq=zqZEUvVS5Q@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: Fix logic of forward the VF MAC address
 to PF in bnxt_vf_validate_set_mac
To:     Michael Chan <michael.chan@broadcom.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 1:01 PM, Michael Chan <michael.chan@broadcom.com> wrote:
>
> On Mon, Jul 23, 2018 at 10:24 PM, YueHaibing <yuehaibing@huawei.com> wrote:
> > Based on the comments,req->l2addr must match the VF MAC address
> > if firmware spec >= 1.2.2, mac_ok can be true.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> > index a649108..7925964 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
> > @@ -954,12 +954,9 @@ static int bnxt_vf_validate_set_mac(struct bnxt *bp, struct bnxt_vf_info *vf)
> >                 if (ether_addr_equal((const u8 *)req->l2_addr, vf->mac_addr))
> >                         mac_ok = true;
> >         } else if (is_valid_ether_addr(vf->vf_mac_addr)) {
> > -               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr))
> > +               if (ether_addr_equal((const u8 *)req->l2_addr, vf->vf_mac_addr) &&
> > +                   bp->hwrm_spec_code >= 0x10202)
> >                         mac_ok = true;
>
> I'm not sure if this is correct.  If firmware spec < 0x10202, the VF
> MAC address is not forwarded to the PF and so it doesn't have to match
> and mac_ok should still be true.  I think we are missing that
> condition with this patch.
>
> I need to let my colleague Vasundhara comment on this.  She is more
> familiar with this logic.
Yes Michael, you are right. Also, the plain else condition is to cover
a special case to allow VF to modify
it's own MAC when PF has not assigned a valid MAC address and HWRM
spec code > 0x10202.
>
> > -       } else if (bp->hwrm_spec_code < 0x10202) {
> > -               mac_ok = true;
> > -       } else {
> > -               mac_ok = true;
> >         }
> >         if (mac_ok)
> >                 return bnxt_hwrm_exec_fwd_resp(bp, vf, msg_size);
> > --
> > 2.7.0
> >
> >
