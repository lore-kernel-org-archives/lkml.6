Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D2FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A147B20892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWKf2Qvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A147B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbeKJPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:14:13 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45521 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeKJPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:14:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so3335485ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 21:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OQg2uTRO76jQl+7/GF5QMAQ+eHiS6D9fitN6WcLH1SI=;
        b=kWKf2QvtKQ4x/qUbqrxTUQyu/ON9Mbxc7fUTVBvHR6UF16NTKgllRwnqbKlsNwZi7l
         iP87tN77f5MVIrrh/iv7sFao+aiTPJjZAivax6RFaDBexhHfOaV2br7AXptZkElT6iGG
         wkOCNMYxfWzF6IkA6WaiA+cAFR8gzqGAQfkKnhfPQ/6Ldwgdf5QxR9NXKptcP/kRR/Pu
         atrQSH927T1urwyIJuu6OCDbXmU038TFWsgxkIOQWTUyISd9pCNDjqWQFiM2FbI3vX+H
         MY8Nsz5kFsG3LbNbF9dr0nFxShVrmQXWe0pFqraUNwMCG6xOcA6i4NPY+oSnGGOhJnPw
         vK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OQg2uTRO76jQl+7/GF5QMAQ+eHiS6D9fitN6WcLH1SI=;
        b=kAYwT/y959PZdHr3snxXLhZvhV2140i6Kv+XhuDvX3fM0t778yu55GzUwClYoWHS2r
         57G9fcrIe8AB2bFiVwsA2aPjO56AHv6T3HorccA2S1rK5wyGP2pgkOTAFrk23d7C32GW
         /gTXW4vkQp3BoihhHOihVU/jGrlpVpcAzO4qdVwS1mOkZNqsE2JMzAm1VcWoTTB7Eyw3
         KuImFIchdZLFUACDpZ1KGUx8NLPS/Bf7jDUijjoh5zTcJhn6LqyClSFFD6z26dYAeMVj
         5cs0X3db0KuBCneqMuecHiqeXlK0/s2tS8+JPSEe9JQwB0QhQOWUTaJclULFX1KEepn9
         PYGA==
X-Gm-Message-State: AGRZ1gLJMXMZgOwC+uzXpxWlY+E86wpbQ/AGVRD4elBaUutKIslStFwx
        8JMdnAYqAqbceTaDWuMpwzcyADNifVUo52h2xR/ZsQ==
X-Google-Smtp-Source: AJdET5c5dN6tP1GVDUmLG0kYxdJJqqzhAZY1cSVjS51gB2MxJzFK3Cdh6AqeVZN5SN1OlzHBsWRhJi9s0YLUGPUg4R8=
X-Received: by 2002:a2e:868c:: with SMTP id l12-v6mr1828661lji.90.1541827480885;
 Fri, 09 Nov 2018 21:24:40 -0800 (PST)
MIME-Version: 1.0
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>
 <CAHRSSExukqyS5V=fgdBP1Jn_KXZEMsWR+wMLNtxBq8+G3wkgSQ@mail.gmail.com>
 <5FBCBE569E134E4CA167B91C0A77FD610198F8A217@EXMBX-SZMAIL022.tencent.com>
 <CAHRSSEx=z_CCfM5dmdm_cVtH-Az5eKCL5N_S-52qqSsMmGDUbQ@mail.gmail.com> <5FBCBE569E134E4CA167B91C0A77FD610198F8A4B2@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F8A4B2@EXMBX-SZMAIL022.tencent.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 9 Nov 2018 21:24:29 -0800
Message-ID: <CAHRSSEwjNYu1345KFvkTTvvy6Qb+T6=4WXEZ-t8wcGtkCUa_UA@mail.gmail.com>
Subject: Re: Re: [PATCH V3] binder: ipc namespace support for android
 binder(Internet mail)
To:     chouryzhou@tencent.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, akpm@linux-foundation.org,
        dave@stgolabs.net,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>, chouryzhou@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 8:43 PM chouryzhou(=E5=91=A8=E5=A8=81) <chouryzhou@t=
encent.com> wrote:

>
> If IPC_NS is disabled, "current-nsporxy->ipc_ns" will also exists,  it wi=
ll be a static
> reference of "init_ipc_ns" (in ipc/msgutil.c, not defined in binder.c by =
me) with
> no namespace-ization. You will get the same one in all processes, everyth=
ing is
> the same as  without this patch.

except, as far as I can tell, binder_init_ns() would never have been
called on it so the mutex and list heads are not initialized so its
completely broken. Am I missing something? How do those fields get
initialized in this case?

>
> - choury -
>
