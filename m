Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FD020700
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="RqZvgRfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392472AbfBMPl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:41:28 -0500
Received: from mout.web.de ([212.227.17.11]:44069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732059AbfBMPl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550072464;
        bh=0pZlaYMCSK6QRJS3D6BlXVTlIGZyi3BqLCvNhXMXfGo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RqZvgRfdqd8knsuHT/DR6b3OybHn6BHwPFcXa6w4+Rh7zCul6ydNXoQagTy//PFv9
         wzQS7XISi+OntIgM/8CWC/iO2wAwXZ9Egb5kR4K+CASaW9W83zi+OZ3TIpi2GiTWqd
         z8QM5C1fZ555Ylo7AnU9vP7UsKS43Tu8YubF1Xm8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.74.172]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lb1wz-1hMuhF1yeH-00kgdh; Wed, 13
 Feb 2019 16:41:04 +0100
Subject: Re: [PATCH v3] coccinelle: semantic patch for missing put_device()
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <1550039015-5587-1-git-send-email-wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <63ed130e-7764-3fc6-88b5-5965bf12c790@web.de>
Date:   Wed, 13 Feb 2019 16:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550039015-5587-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ImzlekzBlGgS91LUY1bK79XPP5jDzL+sqq5tJu8PRi+8r9MafoL
 TfjYXP0AaJ9BogSfmz8EPkkFStR8fCOXQ1b+sVr2Q2y6KqnCQmtMUGF3TE9yhaypYv27OKa
 SQBTdae9bWRVv1cWrS1zDUTHKDOUEjCA+KnR486glO1qn2P3829UFqspf7q81R3fBNkxuRV
 u82UvyDt20dhWuX4vVn/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NmFv6P6Bk3U=:0IfgTRz7gulPhQlObd0E50
 5Lo+YF385gX8j7WRRsUb3fVNmlXsLPYv/NIwTjySB96vK4nbmOCZqeZp7UwdpsOo+lelKOCBP
 zfY8mCMigSZEbaXYWuW8Dc7RMLdrNE3Df6IhfyRgvfBcRU8Y/nk7P9BgxBoEPzhfmFunM/WLS
 o1wG7VILOHIVQaewpYxVJ44MCWe5VRzGjRiIakzLyUPO9DS12/56fsEBLBmrbI+VfCSDw5iDX
 HhMSrs4JofD9Snpb0ZlsqSuVi1R9OF3P2kc5uhbpDyGQ8hNLVFSWw4Szty5iKBTXWDaCSl76e
 IcFYDSf9VnUhddzaCad/EpQlpmbug72bRZ8rsyz8/K1LqX3pUtyAKX3rkisr348BjOn8/Lk20
 eN1SSa9STTK1oUn5ZgWWUsDbRQSnrrRtOOgsvgWwoZoo4zSXyySw8JnkIgI5f5D8Sc2Wrd2IO
 S56mCeedoDxeUG0A9X5MPbEaa0soTc1iWQPjwBXRJIZnj7p+rETGFeD8dkdH8YAECNTOjnshG
 P83ctq79RYds6VFT2+NaA/ilbxoqzD75drTV6bhr2gunPGUPN2bhfUZeo3zE+RS8D/w0SjC5l
 9pMDXZeAMfduYN0NQOCBDezS6OtWDf+5T+jw/7S6vCyjDdTkW0qSk//yVShb7APFQ/PlF/OEn
 ZV52jZMFqzgNfv1H1lAvPNAiQdCQah5kbj1e0pRO70YlRQiSC7zfy0gBbWoLXwRxdb/v4U5HF
 YYlRwKfFBNI5Vp5khhrOsXK1ewiudHqVu1uqOqBUflcc87GCejS9ZWGDppq2CIC8cvXj7inHo
 GovyBW4ZSJlWn14P7jq5uhudKjNbkiZghHZX/7omB3XrHL2SQ5MCX45IBMPRwfcxtwBqKdlDR
 FllkTBhpoOS0ezm+/bAem708PNpB1N9LdrD24NCl2W6PXafzeAqv9KxCbaO604Tzooae/UY1G
 HoMHE/LXz3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Markus Elfring <Markus.Elfring@web.de>

I have got doubts that my code review comments qualify already
for this tag.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3D1f947a7a011fcceb14cb912f54=
81a53b18f1879a#n565


> Cc: cocci@systeme.lip6.fr

I assume that Masahiro Yamada will also need to get explicitly informed
for a possible patch integration.


> v3->v2:
> - reduction of a bit of redundant C code within SmPL search specificatio=
ns.
> - consider the message construction without using the extra Python varia=
ble =E2=80=9Cmsg=E2=80=9D

I find it nice that you would like to take this information into account.


> +    when !=3D e4 =3D (T1)platform_get_drvdata(id)
> +(
> +

Should a blank line be omitted at such a source code place?


> +  return
> +(    id
> +|    (T2)dev_get_drvdata(&id->dev)
> +|    (T3)platform_get_drvdata(id)
> +);

It seems that you would like to express a different coding style.
Would anybody like to reconsider the position once more for semicolons
in nested disjunctions for such a SmPL search specification?


> +coccilib.report.print_report(p2[0], "ERROR: missing put_device; of_find=
_device_by_node on line " + p1[0].line + " and return without releasing.")

Your willingness for such a rearrangement is interesting.
How do you think about to move the long message parameter to a subsequent =
line?

Regards,
Markus
