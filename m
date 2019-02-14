Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4712C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A207C2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="qZDePCak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394532AbfBNIOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:14:24 -0500
Received: from mout.web.de ([212.227.17.12]:37889 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388919AbfBNIOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550132041;
        bh=uvEiNLmvtbYEiazy+HrVZrIw9zHZXTjAyr4MfWITstU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qZDePCak9KQFkox+Ikx8vJjP186AOE4ElHHx4B1aGekcJ2BC6k85TTIaaEvj06VGX
         iJ81c4K3UCgBnNb9rXMYl5d0Rwt8M5+9bVHs1hj0SYPTNmX2/Z+ILs2y38CU0uWNDF
         8F6kdUxJiZ6a4l40Z/1uCJ2VXs0K/AmoyDkLMx9Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.97.110]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MejmG-1gjI2r2plw-00ODvj; Thu, 14
 Feb 2019 09:14:01 +0100
Subject: Re: [v3] Coccinelle: semantic patch for missing put_device()
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
References: <1550039015-5587-1-git-send-email-wen.yang99@zte.com.cn>
 <c10e0bf1-4830-7ee4-5b21-70b521dd6c36@web.de>
 <alpine.DEB.2.21.1902132050200.2655@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75cad101-727d-2e6b-b6ef-a6a4d0ab4130@web.de>
Date:   Thu, 14 Feb 2019 09:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902132050200.2655@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NdzkFnAuNVFgRnhHRKaphDKrTcKJEjVEek0lluUUrzbdodLsrbu
 dcEWJVDvLKxLYP3NG9nxCmSLtaEw5ndao8xEVPjZ2D0O2p54QYMnCPk4ajLUhoOlots9UIy
 0s8B+8gSk0bL2u32wvx/Zj6vSYrLH/dc15PhjjtjWHG1Xh5atdppRQf85YWM4OO4zsltrv1
 5WMVfpi61CUqCwNf3oHuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6PXK73sdqLM=:rhW2l9V0LYqd2hOJcDYrVD
 0dfQdyiAovc42cvSdyrrotI9mGCSkt4Ssz6jT/eU1lrHiXs1hUHzMzQk4UoiYVi6dpv2fJZSN
 hWzlkh/54rYPHcMJgm+UPAGgBWBAsDrp5Sd20b/5V5DAy4nS6Jx7MTLbt+TgcCre3Nl5ZUW1f
 Pgm+at4/6+hJWERxt5/xsy88x95DKRUETZ6qVVw9ekrxFeEAYUOYjbsa7d7Lf3CW676sz2HlD
 2lRmR2N3o98GS6g25xq6PAZt8M8Ac3bJ3eMEkJ7x3Wr4KTX/c9Te4EkDhfDgacBLBVO26U9R2
 UiS/PVV+eJGCsFQD978bOiuMfpbz0bwcN77vEqAGR7yhMjz3VMwUBwrWYZi+AQdr/YvfmLt57
 uAf8/OlkfcJeyomvdFxbeAvUgLvfhMn7Z5miDKgFwOdZnpj0y5qNH4GRPFXQRpOSkav7nJ2Sp
 bQE3OYpqn5t1fUesPFVK1Yu1h5pzXet6qFC+z3AaxfF51eZjaDkehQylmfH0EvD2h5cvaNeDt
 h4f/CQWS3cSKCXdzKA8g/5subcbB5GpHhpGMj24EAkPnfgtC4oIjAeGeKmt3+7bTHIs4ho2z7
 XVdQfUME04fLR+VphIbtuoyTP5180FaH1p/Ra9do4u7bvJwqNSebigyW/bFzuNZXq++Pob2ks
 /UfW7jHBghdG1MaNGToYZu0q/jk5a1yzm3IcxkWzOxEv5p1ykp6PcVRMwijjYFj7n6hMUUaxG
 HcpYVQzGdLmlTgEUAM2eMH3mN4RsJzzH5lEnClR22irLlyPjUpWb11fWqZhuD8K3K5Yraj4hV
 BBcn64/scYSOFEF/BlhhriTaPIAsJfIlZnJI43WHlBDRAqjsqbNg83+z7Qew4OlcqtQdk4vyZ
 2z48G/NV+0DMJHKrrnjittIQ3ygVJ04dwBFPwm4Di6Du3T00VxnKoaFM+N59FZ8JcTa1TM28B
 T5ql9dADzHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +    when !=3D ex =3D \( (T)id \| &id->dev \| get_device(&id->dev) \| (=
T1)platform_get_drvdata(id) \)
>
> There is no need for the disjunction.  There is also no need for the
> different variables.

Really?

Would you like to distinguish the shown assignment expressions anyhow?


> Different variables are only needed when the when conditions are on
> different ...s

I find that this information will need further clarification.
Will any additional adjustments become relevant for such SmPL when specifi=
cations?

Regards,
Markus
