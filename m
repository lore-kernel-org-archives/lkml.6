Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92242C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EFB20835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y213uGWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EFB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJCNR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:17:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbeJCNR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:17:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so851782pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJ+x0j1ZqUyIQJ+mmUgq6vFgh8pHPZe/S9Q9U/fZl/Y=;
        b=Y213uGWn8udyuGZhlTAB0lV9Zc01AwIkar2n0+4i1W7YsTxn9VZwX04YYZ2GzyqLuO
         lCMiHo+Ia3LBu8OWexiTKkk4oUSd4f81c+JEWd5lbuK21/yvfwqL1v9T/51y47+qcAsP
         y3Nsv0ZsbSQ+j2r1/zAUZpQN0oYhGGz4CJUiYrZjsDNz2UwzFiCs4KN4+dfkUu2GUhYc
         5asd7lUkDD3RGUEehxm4/1w45W7i5wrgJBRvf59GQPm8RmKpp98VBfAaaBp8xkvGaPAI
         vIut2v4Kf0EYH3HSKNwDxGlLb6JhRI8Zj85VR1Azftx/+5sCySJZzN0skNQoFJpdbO7t
         U6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJ+x0j1ZqUyIQJ+mmUgq6vFgh8pHPZe/S9Q9U/fZl/Y=;
        b=dtWKU3cMMQBS+YOzB8Z5SOX3ds/E7RPDP9GJSPbs1AJtKa0ecI8900a7iStDis0NpG
         XLEE7wOz0KVEy0yjCb3PLVhRP1Tm7MmOCGZ7+1HW0fK0iaaR9oTxIYD7d4F9gtqKICDe
         hmPsqMX9vhMYNtWeKSWglZJHbteZU8fWkdhsK21Jt52/zplJo2/fg6XDZKGSzeS40i58
         mKiqoRKq/jXz+aO21rLec0AEUth0+j5XNAI4ShgPhRYekYyBsA/EiC4T1Kei70LFtk9J
         vowivTmAKP589GKGXiecPRTFFF8QsgWC1XvDqQj2heeN6hvyxohD4dy2zsTTkOSqSriq
         lGXQ==
X-Gm-Message-State: ABuFfoiULulxh5ynzJb1DQAdfd76vxgJRUcCk2AM0eDOlnZj49pCJhUS
        nDePiEccSNh+LQ9WvcqPU24=
X-Google-Smtp-Source: ACcGV61EyxPtLOHsDgLSd11V37DD2fHuIzZU0AlanlBC9O4TiYZ4O/E3G4u421aeeaVXNeg5biId4A==
X-Received: by 2002:a65:4849:: with SMTP id i9-v6mr27519pgs.350.1538548229812;
        Tue, 02 Oct 2018 23:30:29 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id 76-v6sm1063253pfk.134.2018.10.02.23.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 23:30:29 -0700 (PDT)
Date:   Wed, 3 Oct 2018 16:30:24 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 4/7] powerpc: regain entire stack space
Message-ID: <20181003163024.281254bf@roar.ozlabs.ibm.com>
In-Reply-To: <6a539614-abb6-d468-ccba-2e3c1fb8b680@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <8108de51846b7b34e4732753b2b65e435b6a2b7a.1538396659.git.christophe.leroy@c-s.fr>
        <20181003153448.3fb64e19@roar.ozlabs.ibm.com>
        <6a539614-abb6-d468-ccba-2e3c1fb8b680@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 07:52:59 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 03/10/2018 =C3=A0 07:34, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Mon,  1 Oct 2018 12:30:25 +0000 (UTC)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >  =20
> >> thread_info is not anymore in the stack, so the entire stack
> >> can now be used. =20
> >=20
> > Nice.
> >  =20
> >>
> >> In the meantime, all pointers to the stacks are not anymore
> >> pointers to thread_info so this patch changes them to void* =20
> >=20
> > Wasn't this previously effectively already the case with patch
> > 3/7? You had thread_info sized space left there, but it was not
> > used or initialized right? Does it make sense to move this part
> > of it to the previous patch? =20
>=20
> Not really.
>=20
> In 3/7 I changed the prototypes of two functions that really used the=20
> pointer as a task pointer only.
>=20
> Here it change things that before 4/7 were really used as both stack=20
> pointers and thread_info pointers.

What uses it as a thread_info pointer? It seems more like a stack
with some amount of unused space in it but that's all.

That said I don't care to nitpick too much where things go exactly
if you like it better here that's fine.

Thanks,
Nick
