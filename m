Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A9BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C854221531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="QbrhAFEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C854221531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeHTRwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:52:51 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33230 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeHTRwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:52:51 -0400
Received: by mail-ua1-f66.google.com with SMTP id i4-v6so9860197uak.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fH+i8pRfg0nbB2m88oq4W1kCxYUFJkurjeXrZA2aAZc=;
        b=QbrhAFEMyCipI8lZIjFcKpSArNrD0KoEHg9ClO4ZTqnm6zwE73Yf+A/eKabJFs2JEZ
         cJ0OfKZfE92pZm/JT4Te1eCpbUk1g9WfoM/27u3+wP2i9e07pC6i+k0ni3IJJwfYfhDt
         /zeUHE7v1G+NG78VbDEwGo00FwhP/zcF/ga/hNpCREWm5yQesu1StFdQiTuKJ6fkH+wG
         +97i/45EVuGycS3oiC6tVrYtWqitiw2sMDxV9JEtX+F3O0rmiKrUdUQPNSQwoflQpBK+
         Nl8FXQhdT5hqMLXHN2e9Bcr1IKWO7HJ9XknzIWu/7X1LtfR95s4E+wRkHgyKx7awEN8i
         WwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fH+i8pRfg0nbB2m88oq4W1kCxYUFJkurjeXrZA2aAZc=;
        b=ImEKqZlHyfTZIFO1ijOdzSs+qV/FfQ+NMRoI+L1kLUxytRjmCfRJ5ZckU2aP3aQnbN
         Xu7kpBi/TZPun25+H4CVJklWrtqwGuYr1ND4/KZRVdalezuEk39dAlQQd780Q9Gm0teI
         zptI7hXh48i+i3VT+1Qibq7QtlMezqGUBWR4WeEk3LZ0Pfh216gYX6nD1BxUYno93iI0
         yC3u9qOxhKNZ4ry+lFxQzrxKSw6jzg8ZRudBX0G2i3MVq6vNYNEm/xDZKLdLylgCjTLj
         3AMPxF8+gLLBHTHcAk2ZmVaWKett4qOokgJj6RrE7+hSRB30XZSWV/fzMn0TfAyjkegc
         kLlA==
X-Gm-Message-State: AOUpUlE6oVakDsu4fBzR4nmsBkq8+092ukj1+SbhPgi8nbU9u//aWj/2
        BwwC62fKBrLTeLxL32Dv93jlTRcc53CbKXzvzTwwmQ==
X-Google-Smtp-Source: AA+uWPypiQdsVFRrtBDFGBMTK6bH+6heOZbhi5ppBNW6C/QDd4mPoJQedu4JMbXkU6IaGcBK0hgtKN4oUf03LSwikHc=
X-Received: by 2002:ab0:6583:: with SMTP id v3-v6mr30372803uam.107.1534775816217;
 Mon, 20 Aug 2018 07:36:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:984f:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 07:36:55
 -0700 (PDT)
In-Reply-To: <d03ed26c-cb06-d9b7-e7ee-d0b78316641a@lightnvm.io>
References: <20180820121217.11393-1-mb@lightnvm.io> <DA2F1D94-23DC-4739-9056-351992D972EE@cnexlabs.com>
 <d03ed26c-cb06-d9b7-e7ee-d0b78316641a@lightnvm.io>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Mon, 20 Aug 2018 16:36:55 +0200
Message-ID: <CANr-nt0_3WxmG7=8XDjkii_1KrpX1XHk2N5P3fSSCgYdF-TGJA@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: introduce nvm_rq_to_ppa_list
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Javier Gonzalez <javier@cnexlabs.com>, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will do. i'll squash your patch with my two. Your commit message is
better, so i hope you don't mind me using it :)

All the best,
Hans

On Mon, Aug 20, 2018 at 2:46 PM, Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
> On 08/20/2018 02:38 PM, Javier Gonzalez wrote:
>>>
>>> On 20 Aug 2018, at 14.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>>>
>>> There is a number of places in the lightnvm subsystem where the user
>>> iterates over the ppa list. Before iterating, the user must know if it
>>> is a single or multiple LBAs due to vector commands using either the
>>> nvm_rq ->ppa_addr or ->ppa_list fields on command submission, which
>>> leads to open-coding the if/else statement.
>>>
>>> Instead of having multiple if/else's, move it into a function that can
>>> be called by its users.
>>>
>>> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>>> ---
>>> drivers/lightnvm/pblk-read.c  | 4 +---
>>> drivers/lightnvm/pblk-write.c | 5 +----
>>> drivers/lightnvm/pblk.h       | 4 +---
>>> include/linux/lightnvm.h      | 5 +++++
>>> 4 files changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.=
c
>>> index f275c7e5abe4..696d3a9c9cf0 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -175,11 +175,9 @@ static void __pblk_read_put_line(struct pblk *pblk=
,
>>> struct ppa_addr ppa)
>>>
>>> static void pblk_read_put_line(struct pblk *pblk, struct nvm_rq *rqd)
>>> {
>>> -       struct ppa_addr *ppa_list;
>>> +       struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>         int i;
>>>
>>> -       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_add=
r;
>>> -
>>>         for (i =3D 0; i < rqd->nr_ppas; i++)
>>>                 __pblk_read_put_line(pblk, ppa_list[i]);
>>> }
>>> diff --git a/drivers/lightnvm/pblk-write.c
>>> b/drivers/lightnvm/pblk-write.c
>>> index df99c45778d4..a92450ec7698 100644
>>> --- a/drivers/lightnvm/pblk-write.c
>>> +++ b/drivers/lightnvm/pblk-write.c
>>> @@ -212,10 +212,7 @@ static void pblk_submit_rec(struct work_struct
>>> *work)
>>>
>>>         pblk_log_write_err(pblk, rqd);
>>>
>>> -       if (rqd->nr_ppas =3D=3D 1)
>>> -               ppa_list =3D &rqd->ppa_addr;
>>> -       else
>>> -               ppa_list =3D rqd->ppa_list;
>>> +       ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>
>>>         pblk_map_remaining(pblk, ppa_list);
>>>         pblk_queue_resubmit(pblk, c_ctx);
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 64ae0c7ed3bb..bda098c7cc3b 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -1335,9 +1335,7 @@ static inline int pblk_boundary_ppa_checks(struct
>>> nvm_tgt_dev *tgt_dev,
>>> static inline int pblk_check_io(struct pblk *pblk, struct nvm_rq *rqd)
>>> {
>>>         struct nvm_tgt_dev *dev =3D pblk->dev;
>>> -       struct ppa_addr *ppa_list;
>>> -
>>> -       ppa_list =3D (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_add=
r;
>>> +       struct ppa_addr *ppa_list =3D nvm_rq_to_ppa_list(rqd);
>>>
>>>         if (pblk_boundary_ppa_checks(dev, ppa_list, rqd->nr_ppas)) {
>>>                 WARN_ON(1);
>>> diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
>>> index 0106984400bc..1497e275f90f 100644
>>> --- a/include/linux/lightnvm.h
>>> +++ b/include/linux/lightnvm.h
>>> @@ -487,6 +487,11 @@ static inline struct ppa_addr
>>> dev_to_generic_addr(struct nvm_dev *dev,
>>>         return l;
>>> }
>>>
>>> +static inline struct ppa_addr *nvm_rq_to_ppa_list(struct nvm_rq *rqd)
>>> +{
>>> +       return (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
>>> +}
>>> +
>>> typedef blk_qc_t (nvm_tgt_make_rq_fn)(struct request_queue *, struct bi=
o
>>> *);
>>> typedef sector_t (nvm_tgt_capacity_fn)(void *);
>>> typedef void *(nvm_tgt_init_fn)(struct nvm_tgt_dev *, struct gendisk *,
>>> --
>>> 2.11.0
>>
>>
>> Hans made a similar patch some time ago. There are a number of places
>> where you want to use this helper too, also outside of pblk. You can
>> look at it here [1]
>>
>> [1] https://github.com/OpenChannelSSD/linux/commits/for-4.20/pblk
>>
>>     fdd88185bfed
>>     17609afb2db9
>>
>> Javier
>>
>
> I like Hans' better. Hans, could you please merge my patch with yours? I
> prefer the nvm_rq_to_ppa_list naming, rqdata -> rqd, and if short-hand.
>
