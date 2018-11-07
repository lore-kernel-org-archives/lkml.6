Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35511C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB6A20896
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPaPSMNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB6A20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbeKGXpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbeKGXpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:45:39 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334C720827
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 14:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541600106;
        bh=hZD9MzRLMavklDDVdrezax13AvtLOdXzzgYCxhKJG5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPaPSMNWya7z3z68KqPNg6vWOWxBDV03a+ZxnlL9Yx/jbr7TfrMli/8gIktO//os4
         qQuEzBsmCH1AudDKUvWLbaeoWhf/6XJnNiUZSMpQibglt6h9aF40lR/EwsYMhNUMGw
         e5a1EFNKBnXvFbfvSxMh2qxEuSwpPBOU+c9cE1tM=
Received: by mail-qk1-f171.google.com with SMTP id o125so20996814qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 06:15:06 -0800 (PST)
X-Gm-Message-State: AGRZ1gJk38MaoooEkikR8CTR2EfcOGSV4nCjlMp0WGHQ0h/47dsDmw4W
        yMjguj83KlyZzUrCcoM50SCSnSlS+z65d+YE/Q==
X-Google-Smtp-Source: AJdET5fl3T18TfGAORwrU6CXZhArU/gkkKlYPmxPmLt8q5uBvYmBaYWR01LJ1QjHgSpS3nzYUOtVv1YwFWRNxjt153g=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr392615qvl.77.1541600105392;
 Wed, 07 Nov 2018 06:15:05 -0800 (PST)
MIME-Version: 1.0
References: <CAEXMXLSGoTfEL4ARER80bXMYGmu-mXXOQ4nRwHW-4R4uby5_WA@mail.gmail.com>
In-Reply-To: <CAEXMXLSGoTfEL4ARER80bXMYGmu-mXXOQ4nRwHW-4R4uby5_WA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 7 Nov 2018 08:14:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJL9qfvKhLEArBGqygJAENWAUukYEp5S-Wzj2MtKAkUww@mail.gmail.com>
Message-ID: <CAL_JsqJL9qfvKhLEArBGqygJAENWAUukYEp5S-Wzj2MtKAkUww@mail.gmail.com>
Subject: Re: Target bindeb-pkg no longer install DTBs
To:     nunojpg@gmail.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 12:10 AM Nuno Gon=C3=A7alves <nunojpg@gmail.com> wro=
te:
>
> Hi,
>
> Since 37c8a5fafa3bb7dcdd51774be353be6cb2912b86 [kbuild: consolidate
> Devicetree dtb build rules], the target bindeb-pkg no longer installs
> DTBs in the .deb package.

I see the problem and am testing a fix. Will post it soon.

Rob
