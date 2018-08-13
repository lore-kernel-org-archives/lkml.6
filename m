Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB985C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B97A2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="HGmDXKul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B97A2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeHMOyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:54:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42701 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbeHMOyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:54:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id r4-v6so8110391edp.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=fdwuIoPicO1bGLVAUl+Pe5nZ/IJbxbWNu/xXePeBeKI=;
        b=HGmDXKulLTxApvWEd3jOEF8G76AlkNutNE/qMf3u5ik1ySFvxSPr6W0cb6nxYiVS/Y
         2Cd1HVO30Qch2FEaB3nVuakgo+SH5tp9Dx3hoPD8rU0TBU3GwVSSHTiEbQgbn7Fde0jI
         WlUE1CcXQ0RvRJRwkO7WD9qQ4xPMCgyUnkqcpzu1dksJg1DMAFqGwKtS/oJIUPltjlTr
         rXd7MECacx196vcg62oCr/ZilDOx2Ciy/bLmM6lUqesC39xNfF1d4OPwKDSEqcU3dB1x
         s8PQnEbYaML0ySH25YanMhxBJ+7N10QKE4G2RQiV+XyeDqkdiRLl5I4JwgqjuR3t0+/Q
         cAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=fdwuIoPicO1bGLVAUl+Pe5nZ/IJbxbWNu/xXePeBeKI=;
        b=aSHCSdLrdUGQ+JFzsQFlqcyjitxizyBIYaOxQy5FbAQIU3j923BDtHmlwDFnSnNt9B
         bjDaqtDb6wd4SG0IpAci2Pvv+uVlc3o7aBHHtAfqviHTahOay7UN86sYysg0qwg/H59Q
         sEv/QYVmH31h6LDNf0y/kwm/7JFNiZM/0+jJNI01HcXkxW5yX/57QLRx+fl8RAGf46uq
         bot5+xjxwv6suDYkAVqXbVxP5cIPMYO29YRcdS28SwYzDdIuA/3r8IUMI5Qxxo2NdCp4
         EirvSY+XEhnRBg8TvYg8yvHoZNwsBOHfu8zYBI5DxjXH/liuATEuFa1qm/VZv+MzErYo
         B3GA==
X-Gm-Message-State: AOUpUlE7h+DYf1qK/SiIyvINv8lYGzl3or1RVQUtNLE7SoBbrmD0ZCMn
        uX+7/tlsVOfpC/vEtupklooNaQGTzXA=
X-Google-Smtp-Source: AA+uWPxSwh7W/tMJIWA4ZVg6N7OKbwmGhuzZMrrmnQBqmJzBmjaayJZ2TXCrmtDjG/lyq86fO+fUog==
X-Received: by 2002:a50:9226:: with SMTP id i35-v6mr21682729eda.27.1534162328957;
        Mon, 13 Aug 2018 05:12:08 -0700 (PDT)
Received: from mac-halley13.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id x7-v6sm15768732edm.23.2018.08.13.05.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 05:12:07 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <61F640FB-E38C-41CE-B95A-D2CDAA0008EF@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
Date:   Mon, 13 Aug 2018 14:12:04 +0200
In-Reply-To: <CANr-nt18UvLY7YjUqTDtd-mi+Az-WTMvcbCTC1uVgBpddS=zxQ@mail.gmail.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
 <CANr-nt18UvLY7YjUqTDtd-mi+Az-WTMvcbCTC1uVgBpddS=zxQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 10 Aug 2018, at 10.04, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Fri, Aug 3, 2018 at 2:05 PM, Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>> semaphore. At this point, since we only have an open I/O stream for =
both
>> user and GC data, the semaphore is per parallel unit.
>>=20
>> Since metadata I/O is synchronous, the semaphore is not needed as
>> ordering is guaranteed. However, if the metadata scheme changes or
>> multiple streams are open, this guarantee might not be preserved.
>>=20
>> This patch makes sure that all writes go through the semaphore, even =
for
>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>> simplifies maintenance since changes in the metdatada scheme could =
cause
>> ordering issues.
>>=20
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>> drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>> drivers/lightnvm/pblk.h      |  1 +
>> 2 files changed, 13 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 00984b486fea..160b54d26bfa 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>        return nvm_submit_io_sync(dev, rqd);
>> }
>>=20
>> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +       if (rqd->opcode !=3D NVM_OP_PWRITE)
>> +               pblk_submit_io_sync(pblk, rqd);
>> +
>> +       pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
>=20
> This will only work if rqd->nr_ppas > 1, better check if rqd->nr_ppas
> is 1 and pass &ppa->ppa_addr on to pblk_down_page when needed.


For this particular case, we will always get > 1 ppas, but you're right,
it is more robust to do the check for future cases. I'll add that to V3.
Thanks!

Javier

--Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAltxdZQACgkQPEYBfS0l
eODZnw//V7Q/gZ+s59nT4Wb4mt57BNSa81cogmG/6ge8L3ao+vFGLR0UN8udtAx9
cHUVTQpdtBLRlxQEYlOefMP7YYcWyH8vChO8Vg2eZHie0ivLpf3yfIv86Y7cgmSR
dzkQwbJqrw11WDgDv0FacAQeGPfr7pODMxw7JX5OaxKUP2QHm/5cWflmqTyAt/Qs
1C2G3vguI+BufHu4oMQkw42MpKgMtCMe1IRrwnVzA37tNPuxQJ5h6LAe1heohbNk
blCk0LEBVcwXUrKyawzR01Z5tIOpDS+Q7oDaV+MoMPS9fIBR2x1KlijIGIIeruc+
QRSKdxGPgaU7okbnMFJc1jgKHXPhUtyqLC3WwWjm7ebMS5qCGIjCmxwUoETR8T4I
szaa4LYBZ3iojlDAK1Pyo0SVbd+LRaUI1y+KlylH0hXS6vvq5bUEVr5QAiJKPpVE
i10XbMmVF/RiKxo4HZg84ipLifu15u61J29tJigcIadqG3Z3NIxwfVF4/cHczFCo
z3uBZFXqp7e/JhDmCZc3iLx78Mr9U2da9WXfOYMtRnZem3VqEHvRwb68aMvFTnG9
av0H6oZ6ZjAKutNP4ET2ZGl647thxTqBkeR7IXsxfQTMhoVbETwOGH3EmYuc4lnM
5NpgJ2fM9/HXQZY7F+QsM+2P0BB+vFraFyQewF55xP5wpU4vvRw=
=PtHW
-----END PGP SIGNATURE-----

--Apple-Mail=_0C412472-56DD-42A0-87DE-E5A812CD2C81--
