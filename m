Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26894C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0743213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0ksWcBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0743213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJCNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:54:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46781 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:54:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id a5-v6so1104732pgv.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+cwvjhyKlRtLBu5We6UdPtBN6bnBLfv0MQtWcb1ikU=;
        b=Y0ksWcBn+GpKgYhAceI4aj4yZQUSO93TvgCVtMGBRo5m2GB1U0xS2v+dTvVn9vXQK6
         GHrxFiI4fFeJWq0DvN5CXJhbL9r9A3ESCN9V8EOCEgmbzoEsefzdTPG7JcnyuxAZ+8zw
         N9Zzb3TK+ztKJcLYbvHYNOKojvkqc4XLM2zMP2o3QeOfPOYqYIP35YR6MJxi2wyFfvqZ
         7sqdxiceLVl7sJVB/HjXemPzAOuzthM1xDDBBvsZkkZ1WPnh982JPosqqqsu+NMIeQHG
         CkbYkFLAcwDVomkCym2TlLaZp7RiVIuOjK1OJauxj4Yq3bEj9W6l53Fsmxo2mCogFYIa
         GHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+cwvjhyKlRtLBu5We6UdPtBN6bnBLfv0MQtWcb1ikU=;
        b=GgQsLQhUP3lXdGmYR5hLySC5kKnAMXOIyfZtAAqI+Ve5A3jD9oeLTOp6XB1abvLZNd
         x724wdh7LekRubdojD7Vq++hjlqKHtJGXJfmy7cnFp+zUtYucEkpvP2n9gWBJCMyDhh9
         ST89SQoAFZ35RlqhpOg3ngW3TKqBWWwfT92P7mPBciYyBRekezm+lHW53KuLe55IE1ta
         Va63P1Tqt4J14Q782j6G32Ji/HL1rz8bIS4fTedhqCUXPlAsuDCmLUgX4RNLLgnsQxYl
         TXOpYyui3QMeL+7DFoTKRi03YYhfyiLz2YcLyt9By/ckCdTDFC0v0S8vlyD4SSnrY8SS
         18jg==
X-Gm-Message-State: ABuFfojwGFXS4qkYmoqJZhNHSfHtv6QGrP+ODorGkhEMrGrn5PNo4X4m
        5AkOJNpabTcWERbnT7wnLjs=
X-Google-Smtp-Source: ACcGV61xco3QPlcjQdB34YuzoGRw9dE442MXBRdQMibRxnK0Da5MqwKMT2Ak2VhxH7eIOFxYU+CNIQ==
X-Received: by 2002:a63:415:: with SMTP id 21-v6mr100110pge.327.1538550461709;
        Wed, 03 Oct 2018 00:07:41 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id r1-v6sm1215531pfb.41.2018.10.03.00.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 00:07:41 -0700 (PDT)
Date:   Wed, 3 Oct 2018 17:07:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 4/7] powerpc: regain entire stack space
Message-ID: <20181003170736.34082f4d@roar.ozlabs.ibm.com>
In-Reply-To: <38d58749-c058-a6d7-1ca2-23abe9dd34a3@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
        <20181003153448.3fb64e19@roar.ozlabs.ibm.com>
        <6a539614-abb6-d468-ccba-2e3c1fb8b680@c-s.fr>
        <20181003163024.281254bf@roar.ozlabs.ibm.com>
        <38d58749-c058-a6d7-1ca2-23abe9dd34a3@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 08:45:25 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 08:30, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Wed, 3 Oct 2018 07:52:59 +0200
> > Christophe LEROY <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> Le 03/10/2018 =C3=A0 07:34, Nicholas Piggin a =C3=A9crit=C2=A0: =20
> >>> On Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
> >>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >>>     =20
> >>>> thread_info is not anymore in the stack, so the entire stack
> >>>> can now be used. =20
> >>>
> >>> Nice.
> >>>     =20
> >>>>
> >>>> In the meantime, all pointers to the stacks are not anymore
> >>>> pointers to thread_info so this patch changes them to void* =20
> >>>
> >>> Wasn't this previously effectively already the case with patch
> >>> 3/7? You had thread_info sized space left there, but it was not
> >>> used or initialized right? Does it make sense to move this part
> >>> of it to the previous patch? =20
> >>
> >> Not really.
> >>
> >> In 3/7 I changed the prototypes of two functions that really used the
> >> pointer as a task pointer only. =20
>=20
> I meant 2/7 here sorry.
>=20
> >>
> >> Here it change things that before 4/7 were really used as both stack
> >> pointers and thread_info pointers. =20
>=20
> And here I meant 3/7
>=20
> >=20
> > What uses it as a thread_info pointer? It seems more like a stack
> > with some amount of unused space in it but that's all. =20
>=20
> Before 3/7, we have
>=20
> void do_softirq_own_stack(void)
> {
> 	struct thread_info *curtp, *irqtp;
>=20
> 	curtp =3D current_thread_info();
> 	irqtp =3D softirq_ctx[smp_processor_id()];
> 	irqtp->task =3D curtp->task;
> 	irqtp->flags =3D 0;
> 	call_do_softirq(irqtp);
> 	irqtp->task =3D NULL;
>=20
> 	/* Set any flag that may have been set on the
> 	 * alternate stack
> 	 */
> 	if (irqtp->flags)
> 		set_bits(irqtp->flags, &curtp->flags);
> }
>=20
> After 3/7, we have
>=20
>   void do_softirq_own_stack(void)
>   {
> 	struct thread_info *irqtp;
>=20
>   	irqtp =3D softirq_ctx[smp_processor_id()];
>   	call_do_softirq(irqtp);
>   }
>=20
>=20
> So now only we can change irqtp to void* can't we ?

In patch 3 we can, right? That's what I mean by moving from
thread_info * to void * in patch 3 rather than 4.

But if you prefer not to, it's fine. Maybe it keeps patch 3
a little smaller.

Thanks,
Nick
