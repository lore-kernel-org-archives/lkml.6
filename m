Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94395C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3643A208B9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2ANPBtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3643A208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbeG0Ods (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:33:48 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38268 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbeG0Ods (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:33:48 -0400
Received: by mail-yb0-f193.google.com with SMTP id i9-v6so1971388ybo.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 06:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VYLq1MFx6VmVRPVY6LVuaxQpS1GhjNQH+/DSyY4aH5s=;
        b=S2ANPBtwSEGoRsoymc1J/LusMaQO96mKauTn3x9N2w7iIt5up06mQCyFrvJrZuSy3X
         65t8mpd3aijrZZ2naRID1/iB5M2uK+t4eX7+fAFCY94+BhwipHyakCibdhgL7FS8nb2X
         lUEq+j5C766j4/HilwEZYlXOzFoM1ElGglJaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VYLq1MFx6VmVRPVY6LVuaxQpS1GhjNQH+/DSyY4aH5s=;
        b=ojAFqrRixPnx/2hF0bRz20rYWyIcQt5pCeQ8+ZYpo8kGBzt9pmRntEkyPmSYqYgsg6
         QEWpK48IxTtivXaGMOtQt20Fq/slLC5vO4f1w+7Uko0lG9K5NyZaXBQKF5Cy4koi0y1E
         3G2NmuMa1g3CTfYoFXXnQRNjNep8yi7+mYCjkqIQsp/eA9iZR7pEAv1R+nQJb/XMqkMn
         74GAuFD8RCOTuDiV5+5qMx0ZYZooskTpUQBbcqbQLSuPjWx/FLcKLE7bQuwQTvy8dpaH
         AKdQhC6jy4zCxUuxCq2vXW174UQKdw0G3lwozXM9xmAsitbs/AqwA7vrdzZftqDE+pKc
         nZLA==
X-Gm-Message-State: AOUpUlEJuNhsBIHRt4DIAjmTUOQnEuqgIoKWa4kMZRk+9prCYxRYEXb4
        cxSr0ciONe3z6T7kxLPGPjnJ3lu3Or5aBmyy2l/tFQ==
X-Google-Smtp-Source: AAOMgpcmhBw3iYeLcHd4HFhLkPE37ceZEQuTIWR2EwOnM251yUPCgOfEBSRr31ht5LWSZbJ3xJIFNtpwzEih1bp1kbQ=
X-Received: by 2002:a25:2bc4:: with SMTP id r187-v6mr3298718ybr.377.1532697115794;
 Fri, 27 Jul 2018 06:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180725222008.32186-1-anders.roxell@linaro.org> <68f68676-0d91-125f-5697-31cc459ab24e@gmail.com>
In-Reply-To: <68f68676-0d91-125f-5697-31cc459ab24e@gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 27 Jul 2018 15:11:44 +0200
Message-ID: <CADYN=9+y5tzO8c1B7yiyTYTtt4jJT2hFc+6qtN=jFoqHbQje-g@mail.gmail.com>
Subject: Re: [PATCH] net/rds/Kconfig: RDS should depend on IPV6
To:     eric.dumazet@gmail.com
Cc:     David Miller <davem@davemloft.net>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        ka-cheong.poon@oracle.com, Networking <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018 at 13:52, Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 07/25/2018 03:20 PM, Anders Roxell wrote:
> > Build error, implicit declaration of function __inet6_ehashfn shows up
> > When RDS is enabled but not IPV6.
> > net/rds/connection.c: In function =E2=80=98rds_conn_bucket=E2=80=99:
> > net/rds/connection.c:67:9: error: implicit declaration of function =E2=
=80=98__inet6_ehashfn=E2=80=99; did you mean =E2=80=98__inet_ehashfn=E2=80=
=99? [-Werror=3Dimplicit-function-declaration]
> >   hash =3D __inet6_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
> >          ^~~~~~~~~~~~~~~
> >          __inet_ehashfn
> >
> > Current code adds IPV6 as a depends on in config RDS.
> >
> > Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation =
to struct in6_addr")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  net/rds/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/rds/Kconfig b/net/rds/Kconfig
> > index 41f75563b54b..607128f10bcd 100644
> > --- a/net/rds/Kconfig
> > +++ b/net/rds/Kconfig
> > @@ -1,7 +1,7 @@
> >
> >  config RDS
> >       tristate "The RDS Protocol"
> > -     depends on INET
> > +     depends on INET && CONFIG_IPV6
>
> You probably meant :
>
>         depends on INET && IPV6

Hmm... Yes, I'll send out a new patch to fix it.

I'm sorry.

Cheers,
Anders

>
>
> >       ---help---
> >         The RDS (Reliable Datagram Sockets) protocol provides reliable,
> >         sequenced delivery of datagrams over Infiniband or TCP.
> >
