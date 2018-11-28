Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37F4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE8E2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI6Xek/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE8E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeK1MtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:49:24 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35373 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeK1MtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:49:24 -0500
Received: by mail-yw1-f65.google.com with SMTP id h32so10062560ywk.2;
        Tue, 27 Nov 2018 17:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/WnK4iS4uKrhGPb9eE+OEABPEtDB3y6wOcJ7r6VE3is=;
        b=CI6Xek/AM5+wfbFuW/5TNB2KKQghBXl4qgm4eI8EyxzmFwc1bZkGvHDNRfpxBskO0D
         3R/3uvdT8pwbYHPWfQTqpj7EA/WhaclAXeLC0lmHs3ZQ0+rg0UBqvMQ8CLQyAHY7cuAe
         DW9fGG4AChwCFQ1422WdBREuNNPl6u+WsJnKGbjOHQwM4ArOeVSEOtQMercFZhAIaKlk
         BKsdgpcfQvAP2WY6vfq+88kqKd7uWFqF44d+8hgfWyypfBmfW3G7eizhbNXcLOwmaFMO
         GjLKR7/IMVBWsTVh5UxtNjpKbzmENrEnRoavXCPmUMk9GU3MgA0Sg9p4wDcxoOwo3+Nb
         846A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/WnK4iS4uKrhGPb9eE+OEABPEtDB3y6wOcJ7r6VE3is=;
        b=VAO7Me4Sn96vJjBHxlterJM3aBMovDn58AppdsErRJifGozJTWN8IpSUi74d6i49sg
         39yc9CgKKceIGWW2kixGDWSGmJCZ3PfSqAtGHrPmvtajfLsQoUxelWzk14dW7RwAoakN
         YgO/CTOX7z76+nQ4xKEEPtVM4Q5jfo3e5VLo63JXgV/u3k+DIF2XkH9ld4+uao+q1aI3
         EegAmOGdT3JbmgXSWhIwVJdmIKYg79RG+7wvEZcP8NY5NuERR4v8RU0utJxJ++jyLbJp
         8IsaloTTx2bj+CPLEMhCLA2uNBpUYuJdV6qyWyGFoRQX/AfkezZFeoSVKoXl0P5la+oI
         9JUg==
X-Gm-Message-State: AGRZ1gIVIgQbCig4Gt7ue0uyA2/PweRtRu6qLB4ocyNpOPzj59bFquVm
        iGTrnmzTqyGYdNTS6ZjVRL4RkCqx2MM=
X-Google-Smtp-Source: AJdET5fef24t+SutTUA7dOCECmLJPyQr1Li4IzpefFH3e4+NXE0B7WWDE6LYT15a83BPEttiumYSsQ==
X-Received: by 2002:a81:1492:: with SMTP id 140mr36171255ywu.333.1543369772582;
        Tue, 27 Nov 2018 17:49:32 -0800 (PST)
Received: from [10.33.114.204] ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id e124sm1364619ywf.17.2018.11.27.17.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 17:49:31 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20181127184835.GA5147@rkaganip.lan>
Date:   Tue, 27 Nov 2018 17:49:29 -0800
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A215F49-BB8F-4E93-AC62-EC33B4734F24@gmail.com>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-2-vkuznets@redhat.com>
 <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com>
 <20181127184835.GA5147@rkaganip.lan>
To:     Roman Kagan <rkagan@virtuozzo.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 27, 2018, at 10:48 AM, Roman Kagan <rkagan@virtuozzo.com> =
wrote:
>=20
> On Tue, Nov 27, 2018 at 02:10:49PM +0100, Vitaly Kuznetsov wrote:
>> Roman Kagan <rkagan@virtuozzo.com> writes:
>>> On Mon, Nov 26, 2018 at 04:47:29PM +0100, Vitaly Kuznetsov wrote:
>>> I personally tend to prefer masks over bitfields, so I'd rather do =
the
>>> consolidation in the opposite direction: use the definitions in
>>> hyperv-tlfs.h and replace those unions/bitfields elsewhere.  (I =
vaguely
>>> remember posting such a patchset a couple of years ago but I lacked =
the
>>> motivation to complete it).
>>=20
>> Are there any known advantages of using masks over bitfields or the
>> resulting binary code is the same?
>=20
> Strictly speaking bitwise ops are portable while bitfields are not, =
but
> I guess this is not much of an issue with gcc which is dependable to
> produce the right thing.
>=20
> I came to dislike the bitfields for the false feeling of atomicity of
> assignment while most of the time they are read-modify-write =
operations.
>=20
> And no, I don't feel strong about it, so if nobody backs me on this I
> give up :)

Last time I tried to push a change from bitmasks to bitfields I failed:
https://lkml.org/lkml/2014/9/16/245

On a different note: how come all of the hyper-v structs are not marked
with the =E2=80=9Cpacked" attribute?=
