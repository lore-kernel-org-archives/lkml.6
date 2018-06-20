Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5810CC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070F920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPZ4sFmY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cxLpWmxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070F920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933299AbeFTUgs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:36:48 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33614 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933097AbeFTUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:36:46 -0400
Received: by mail-yb0-f194.google.com with SMTP id e84-v6so357871ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GjbkdrkSlpS4x2MghtNByd9Ojj9LDwgDe7Am1Bo4DNg=;
        b=ZPZ4sFmYdJWz/ke14L0wj2tN794pRng34Ev7XtqtL3Snq17PmI2Q8yowfnLaD0hDpC
         qy26wuxEFa8yzILVCs0mTk2nux3OWWDnJeb0xH26rmXLJVg5rVqhVDlJQZRS7SSv85wB
         JEM8AorrcoXohBul4j1J0WpjuWeRkTRaSzf0mvHKieY04/acq825crnVMFrZ1OK4t2PZ
         aMh3y+7Kg6DbRxdypH2IfBVgdMCAQag8X/VvAUp3Et6n5trH5fKfmnvlWUGT+IeJueTr
         xdAvVcNbiIszrk/EhDqJffbuXxcK4eR2UuK9MB+xD/g1jPEDtQn6yIQMNoVaQZ0eiCzR
         7MAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=GjbkdrkSlpS4x2MghtNByd9Ojj9LDwgDe7Am1Bo4DNg=;
        b=cxLpWmxHBIEAxj3u3xHMeTGK7kUNNJsdr3wZo3DDHQpZq20hOmCb09EgLfxyTjzXeD
         KrSRpiS3scZpNC9GYgcK4VG822p3vR27hae72hQgPoXKpr7F4ydW4DWRmO+7YZq11/wo
         n/ZdsKKQLfHHmkhyrbhUU7QyalLKm5rqgqsLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=GjbkdrkSlpS4x2MghtNByd9Ojj9LDwgDe7Am1Bo4DNg=;
        b=IiES+X4Uubr5e41NFURJqtz2DRlBP4RUSiTe8x6UNC/Yb0qlmsUjOcby9DIYV7tvBF
         vFeUrvjClhaCIvHIWVP0Wi4gmqmKU7dnkce/Tuufz7qvBlzFX58/gNK2riCSWiB+TEiK
         EuUNLHXcNoUv/e5tc2hRc5PRv+/TgzTmD6QzA6LQdgO+nmQnuBVf/C1VdW3ualRvPcGa
         NjiIoFdzjEu+ubiPa9adgljP8TSmfUWcLseNZXMU8sL0KZZcRtOraRBrurkITHF1yPko
         pu5Ty3TTObai6DVGqjZI1zIiM+jGLDkTrhu/7qQAJaGmxo6XdSaze0QGKkcrbDBBjEN9
         15PQ==
X-Gm-Message-State: APt69E052sCqej51Ym7kf9xayYoSiQxVRRUR4j3LiOp4VfJRLPXZytMg
        vpdV0n6/J4Gy3/1aRWusVYS6isLpWC7XDvKFa64n0A==
X-Google-Smtp-Source: ADUXVKKrbVAQrQGYDVATdIsfBYdio36paLvqOY3lyjc8UukrUZAhbjXOpGdfHV3bFBbWnqJOJBdVv3XIDMEGWuHkR2A=
X-Received: by 2002:a25:ab10:: with SMTP id u16-v6mr11868158ybi.112.1529527005757;
 Wed, 20 Jun 2018 13:36:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 13:36:45
 -0700 (PDT)
In-Reply-To: <638faf05-946a-1345-dda4-f75fee5b07d9@c-s.fr>
References: <20180620190408.45104-1-keescook@chromium.org> <20180620190408.45104-2-keescook@chromium.org>
 <638faf05-946a-1345-dda4-f75fee5b07d9@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 13:36:45 -0700
X-Google-Sender-Auth: FlIyMv7-DIDfrGCCFjcdBJP1EG0
Message-ID: <CAGXu5jKmZ2jn1V8rd3B5BcS0z_WOj0x4eThSG=DYdxSj+fnd2g@mail.gmail.com>
Subject: Re: [PATCH 01/11] crypto: shash: Remove VLA usage
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:30 PM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> On 06/20/2018 07:03 PM, Kees Cook wrote:
>>
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> removes the VLAs in SHASH_DESC_ON_STACK (via crypto_shash_descsize())
>> by using the maximum allowable size (which is now more clearly captured
>> in a macro). Similar limits are turned into macros as well.
>>
>> [1]
>> https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3DqPXydAac=
U1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
>
> Got the following warnings:
>
> crypto/testmgr.c: In function =E2=80=98alg_test_crc32c.part.4=E2=80=99:
> crypto/testmgr.c:1896:1: warning: the frame size of 2088 bytes is larger
> than 1024 bytes [-Wframe-larger-than=3D]
> crypto/hmac.c: In function =E2=80=98hmac_setkey=E2=80=99:
> crypto/hmac.c:88:1: warning: the frame size of 2088 bytes is larger than
> 1024 bytes [-Wframe-larger-than=3D]

Ah yes. I didn't do 32-bit builds. So, here's the issue: this uncovers
the frame size problems that were hidden by in being a VLA before. It
was always possible for the frame to get this big, it's just that the
compiler couldn't see it.

For qat, I raised the -Wframe-larger-than flag. It seems we'll need to
do this in some other places too.

-Kees

--=20
Kees Cook
Pixel Security
