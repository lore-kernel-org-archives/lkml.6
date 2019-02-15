Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58CD21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="a1dfpSid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391225AbfBOIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:20:20 -0500
Received: from mout.web.de ([212.227.17.11]:39181 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387869AbfBOIUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550218798;
        bh=rNzcPYcDoJ19/vjvrlsx2haosxif1x7Bu1wc2hdSzCI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a1dfpSidHLsoS4hyqPnt/znNoFRi+FkgZoBufIVOJetMG6yiH/PFTSUiKqyEhNGuc
         cLQ43q+RkVBms2M0yl/jvuNdDJeOdtOT2h0WZmJHjmlLBBmI/Ma3zKVOJW5T07bEum
         1OxuIN8UBluLQRpVqfU1/oS6QVsgEyHPjW7dPAe4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.88.109]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6mL2-1hFVQP3GB2-00wWwu; Fri, 15
 Feb 2019 09:19:57 +0100
Subject: Re: [v4] coccinelle: semantic patch for missing put_device()
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <201902151452197117145@zte.com.cn>
 <alpine.DEB.2.21.1902150754380.2896@hadrien>
 <f4bc7f71-efee-5e0f-3209-82681ddc85be@web.de>
 <alpine.DEB.2.21.1902150900270.2896@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8041ca90-5328-19ea-633e-e0b591c5723f@web.de>
Date:   Fri, 15 Feb 2019 09:19:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902150900270.2896@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:OSmmYkmk5/rG95FLfHkdBzb67IHjH4gC5tSDGuZnOlhzEKNbzWX
 x6NBT646ncTDo7oTtQESa5G/N1vdvXsBTLy6t71C3FmmlTQvJnP02pllreavPfZmg8u6fOj
 yPYKyxacy5sisb6DZHuxQogRHQPUREu8r1pECA05GOE+j5XhRaDPZmv6K5PGJBbm2+WiRaC
 alFuaEdpjm8l9q1WceHjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eJtc0r+E3JQ=:89v1VNQEOaWFim3/cu8EzU
 2imcjIFA45s0hwbD0JWl8TrpCdGWhXSyU+BgqquZ64UwW68mtPhPJx8mE2ZN7wGtTNjB5jext
 XUWab/KOYDczBvNgLv3F2wEn2Lk2kB/Em6fpaFWz5I5o9+d76WWIPdjOq1+copkKm4N8ptI3u
 Cr2Pi4ry3HIYywLMGYRvM9i+W8fM5p3agGts2/pNVdMtUiQqo+a4Z6UgwC4HYPfXfSoh8pnt3
 1N5Pn49LTBQCu6YVyyiSmFdvzirY3/v4csWKrZ/9xN3uJMMq6rKyCA0WLSdzkVo156rz5FKbk
 XDAD8mTfAmKq/tqhQwJIVjbkfSofo+tT7CXm+uaftCLrzkdu7SlPZQQEwZ4Uq81YB1qkFyOjU
 52xPcFbV1YI3KGIVd5UdNObbgsCvs3A8b62vSV++TuzcPc01d46wA2Xg1aADEgqmjXQpqc4YY
 J/kQNrpd2fHzrRFXq+Rb1O9bQ0TI550XReZMNDuOAnm5uToUnpp8+bSFkWIH75ejnE0fNmTVD
 /wX8+RG8SD61V4npup70Vo39cRzy0hgb99Z1o2WD/vKetYzMD13ofsQ0ZAcPMb0MXnnkLadcu
 sOMpu2sqKBxQnPQFOtmct0Y9ZnE3JMBxyLzSVDCA9cY1ptjQIb7GplNQlwwlqDwjP/t7tgIIZ
 gY82zyZRAXVg5G9vCihWKfIbDxwATIZUQL1U9Kdy+iOcJt90RSH6/U/0NOWYbrKWTvnpOcVqG
 JVp039DCk5Ie5HH8xIbtCvTAz9rTgIpoS0VBKWUbfyc9yNqT+H5ryNIQJwunLfYxrFm8OWXpk
 EZqoB1OJvmwtStLzJ2M12/g0ru27ofm3i+ZhULq+gaCmW4V7M6n6iP/RD3U3zJsZWil2KA/mS
 tGF88W19YhorsbY2hyieaQ00JdTy6bkcThl81+SSGVPvwWCaBLRAWbrkhA6/Q3cxAFpK+WMoo
 GeN/z9SI36g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The whole goal of the semantic patch is to ensure that put_device is
> called when needed.

Thanks for this clarification.

The software development goal seems to be clear to some degree.


> If the value is stored in a structure,

Will any further means become relevant for the discussed data processing?


> then someone else will likely take care of calling put_device later
> when the structure is destroyed.

Such a view is reasonable.

Are there any additional source code analysis and software development challenges
to consider for safer resource management?

Regards,
Markus
