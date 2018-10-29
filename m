Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242D82082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5ju0yYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242D82082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJ3CYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:24:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43291 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbeJ3CYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:24:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so4234344pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=458MnBvigZvERH5qF2mEjByL9E13uRBKocVYzwnLrTM=;
        b=i5ju0yYNKAF56ibNyvH8OHKmIe6w1Y1jSOJMy/HxalnoR33qtqx9nOJIa13QqXEDex
         14Vbwlau1t8bjXxNcePy0fTCYFdy1B9MaQorDJjAevuZEf8BWpykOC3UMAY6T5ppsx4h
         rzaZnk33xb1aQdRGL/+Fi5kvpgGMQyzmixDSnHSrPSnscdOjmvifQpj7N9aWGbN2NrnV
         NC9JD8SZHz0394eb5hX0em1PL+xwii1dP5Wnh3tze7olgIx6xwa0Z99QtFvVk4htuUM1
         ccp8UPDWYJqXSvkyDNm9bAF9vvNb3ajato70sqD51lu2DSyIyV7JkymMHucN9no0ooqZ
         NDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=458MnBvigZvERH5qF2mEjByL9E13uRBKocVYzwnLrTM=;
        b=MQrMvuDDeld2PI032tPlyDmXHkqn+CnNurPQXhxQsR97Y63dFNCYrhNAM6JtdjKVKE
         gzabSKhx1Kl75YKwITl7/yAb471o3W6O2vSvVfyNzRRAJuGBnBsat4Lcv+mfiWlQWhBn
         rhfXTxUVYEuP1Cx8QnWT35cgsv67/kBQvRnI/UHWYsVyWuCK+8t//il3fMuniJEgG2SS
         Q3sSfv/4iiVtgZ+H2fyJDyM7PPdoehqxfhAnzPh4FSmw88SVVfzMoBTv+j+951l/Fezj
         9OjE+6PYVBwhf7zKQP1yJX7u70F19J53N591SMuPLDZEObpcLea3NlJFziem0kgdGCFJ
         y+Gw==
X-Gm-Message-State: AGRZ1gJ6fkPu4RlnUlu4s3vw1yTmDIlwrQtRDLyjkcygU6Fu4NfisgIF
        MFJc5FCk7KAA65y1waY95JYkWDPHyCja2vpyTEj95Q==
X-Google-Smtp-Source: AJdET5eZ7disJM5giAumkHBHmE/gp6r82VFcWtz7JlCHm7PtctJDCWEPS9w2LnhFgZfsK/EGlw5dam1YlM+d0kjdKQI=
X-Received: by 2002:a62:d405:: with SMTP id a5-v6mr15885703pfh.174.1540834512307;
 Mon, 29 Oct 2018 10:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181029105158.6340-1-natechancellor@gmail.com> <CAKwvOdmkPFC5SPNVTXeRdrE-vnbjYiDdXr_ZCArmvYYVtsYKVQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmkPFC5SPNVTXeRdrE-vnbjYiDdXr_ZCArmvYYVtsYKVQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 29 Oct 2018 10:35:01 -0700
Message-ID: <CAKwvOdkg=4BnDKVSuZ0ag4n2G0brL7XS1NL3u9D9mwxaP-6dfA@mail.gmail.com>
Subject: Re: [PATCH] hinic: Fix l4_type parameter in hinic_task_set_tunnel_l4
To:     "David S. Miller" <davem@davemloft.net>
Cc:     aviad.krawczyk@huawei.com, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:28 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Oct 29, 2018 at 3:54 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/net/ethernet/huawei/hinic/hinic_tx.c:392:34: error: implicit
> > conversion from enumeration type 'enum hinic_l4_tunnel_type' to
> > different enumeration type 'enum hinic_l4_offload_type'
> > [-Werror,-Wenum-conversion]
> >                 hinic_task_set_tunnel_l4(task, TUNNEL_UDP_NO_CSUM,
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~       ^~~~~~~~~~~~~~~~~~
> > 1 error generated.
> >
> > It seems that hinic_task_set_tunnel_l4 was meant to take an enum of type
> > hinic_l4_tunnel_type, not hinic_l4_offload_type, given both the name of
> > the functions and the values used.
>
> I agree. Thanks for fixing this up, Nathan!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

David,
I'm getting bounce backs from Aviad's email address.  They are listed
in MAINTAINERS for `HUAWEI ETHERNET DRIVER`.  I did not see an updated
email address in .mailmap.

It seems that the last commit message mentioning them was commit
bbdc9e687fb3 ("net-next/hinic: Fix a case of Tx Queue is Stopped
forever") authored Sep 27 2017.

So I think we'll need you to merge up Nathan's patch.  Is there
anything additional to mark this driver as unmaintained in
MAINTAINERS?

>
> >
> > Fixes: cc18a7543d2f ("net-next/hinic: add checksum offload and TSO support")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c | 2 +-
> >  drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
> > index 967c993d5303..bbf9bdd0ee3e 100644
> > --- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
> > +++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c
> > @@ -532,7 +532,7 @@ void hinic_task_set_inner_l3(struct hinic_sq_task *task,
> >  }
> >
> >  void hinic_task_set_tunnel_l4(struct hinic_sq_task *task,
> > -                             enum hinic_l4_offload_type l4_type,
> > +                             enum hinic_l4_tunnel_type l4_type,
> >                               u32 tunnel_len)
> >  {
> >         task->pkt_info2 |= HINIC_SQ_TASK_INFO2_SET(l4_type, TUNNEL_L4TYPE) |
> > diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
> > index a0dc63a4bfc7..038522e202b6 100644
> > --- a/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
> > +++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_qp.h
> > @@ -160,7 +160,7 @@ void hinic_task_set_inner_l3(struct hinic_sq_task *task,
> >                              u32 network_len);
> >
> >  void hinic_task_set_tunnel_l4(struct hinic_sq_task *task,
> > -                             enum hinic_l4_offload_type l4_type,
> > +                             enum hinic_l4_tunnel_type l4_type,
> >                               u32 tunnel_len);
> >
> >  void hinic_set_cs_inner_l4(struct hinic_sq_task *task,
> > --
> > 2.19.1
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
