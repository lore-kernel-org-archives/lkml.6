Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6132C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873342150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7zvoBES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873342150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeHVOq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:46:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40176 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeHVOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:46:26 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so1138953ljc.7;
        Wed, 22 Aug 2018 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6GrhX3TXT5BAFtsVMsaG6qx4/7rkYULI77PqLL7xHTo=;
        b=m7zvoBEScNiaRZhpbgiz9ZWT5p21bqSjZM3KqUs4ebJQPWFiSI0zdmqS/hPSkdGben
         gFKNeWGmrTHTEbXZfhL6Rzpf9oaKO1yKqHIKpzUByEuTGlMULgumZ0K/GJHvRwVOCoKF
         VSuhQn/L1yE5HShluQdlZhh8PibpftbvF55CT0Xp9gMeErm+HZ84tKBH0YCpQXJVZNlU
         YVt5UHx9xhmrqo2z/4FLe6KT/GupM99UQrD2ass5OMLH+HAbKkPOIjGXuM02gVeZVq1u
         QsPHzZ2pV0OyLWjalnieaO74xx9+fCC5B7pOho9PoDqEdXYjvDzb7yKmo8sSpBd6CAhl
         ZW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6GrhX3TXT5BAFtsVMsaG6qx4/7rkYULI77PqLL7xHTo=;
        b=C9rlV3FOVgo2nkbkIJp2J0+vFCjwUSKunV1f0PYwKarMxul+vTmnwsAvh7+6WGERsd
         7TB2QcVrVoplmDxGa1ccwctQpn9YxUD7G3Q5p8LDrx8lKp5iGBN4kqoSNwJ0ETOYEadP
         Elpkn+p1Tf6Lm0OSdvtUxg+XZCkiKVXdNq+0K3KxBQDzjjq16qv/GT9VHAvyy/D8IyJP
         1np7We0j6jHuFYNRgjc7UxzILOIu8l4B2EBVGVsUQhA/kkQF+gT3bfiOn4rbPs/dFF50
         nbbW9rx//TQ7GK5St5fROVvGhHCMTPkrjgT/plCzrsoJ74xO9nsuFfORBxnYZfWIJ2GM
         dPJg==
X-Gm-Message-State: AOUpUlHJIU0Tl8Pq9gqFRP5JoBL6mIQ5dhg56HojtApbtDxTPedQk6uR
        25wjGXvZ97E0gthHR1DGrsnRBUbL0/zgpAS79/xOFCJI
X-Google-Smtp-Source: AA+uWPz0pqCsU8D0RW6eTPw5J49/mQP3S/wQJVUdXMgi/99LS6gOjs7bREma9doJU4dk49sSV9LbGf9FsExuReXhU7A=
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr21655757ljh.82.1534936914627;
 Wed, 22 Aug 2018 04:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180814180551.28311-1-davidj@linux.ibm.com> <alpine.LRH.2.21.1808150427590.25735@namei.org>
In-Reply-To: <alpine.LRH.2.21.1808150427590.25735@namei.org>
From:   Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Wed, 22 Aug 2018 14:21:43 +0300
Message-ID: <CACE9dm8NbQK-1ATWNLAQA2GnE0Eguidghr0V2dcZW7+NN+w7OA@mail.gmail.com>
Subject: Re: [PATCH 1/7] evmtest: Regression testing Integrity Subsystem
To:     James Morris <jmorris@namei.org>
Cc:     davidj@linux.ibm.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org, david@davidej.com, pvorel@suze.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will have a look to patches.

Thanks,
Dmitry

On Tue, Aug 14, 2018 at 9:34 PM James Morris <jmorris@namei.org> wrote:
>
> On Tue, 14 Aug 2018, David Jacobson wrote:
>
> > This patchset introduces evmtest =E2=80=94 a stand alone tool for regre=
ssion
> > testing IMA.
>
> Nice!
>
> I usually run the SELinux testsuite as a general sanity check of LSM
> before pushing to Linus, and I'll also run this once it's merged.
>
> --
> James Morris
> <jmorris@namei.org>



--=20
Thanks,
Dmitry
