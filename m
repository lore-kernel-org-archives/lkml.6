Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DBFC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5D123E8A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnlnBiLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5D123E8A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeFVH5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeFVH5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:57:19 -0400
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com [209.85.128.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA9323E8A;
        Fri, 22 Jun 2018 07:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529654238;
        bh=jvjprDMX9GpPMx393uxZq84wrqsZ3tTidiYsUDvqRe8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mnlnBiLUFoa6PHJ7EYzOXlRlzE9KLkJhF5mO6mIoLrdXgnMUQhR4AP1qB+1Fuan9n
         D6h+8qUK/fOdMJ4TPTYqkt4DfioS1JFqqtVZi2YqHiM6gir+aYgZ6K3JLohbfipGl6
         UEGsWtzOst9Ax/aMlwZ0Kh9cU5l7Kwr/OF0YOig8=
Received: by mail-wr0-f179.google.com with SMTP id k6-v6so5704722wrp.4;
        Fri, 22 Jun 2018 00:57:18 -0700 (PDT)
X-Gm-Message-State: APt69E3JqIVLXdJ0wyewKK6YwtA+3OLURGf+ktVb4voQ2Ycg++OVTw6T
        yAF0pEwwyDYrnpDz3Qsx4iBXDmbjAEJK2SWW5IM=
X-Google-Smtp-Source: ADUXVKL6E7aeFzW64DuEDzvXhEpS9YSffVRFJnhTntT7GbU/wNxWQf+1tlcS2fJZjUaH7f8XB/7U45X4w9jAsUWZ3As=
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr578973wro.279.1529654236997;
 Fri, 22 Jun 2018 00:57:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:57:16
 -0700 (PDT)
In-Reply-To: <CAJKOXPdV+UKKnntcrXQ15aOB5eCehyxqVEJfvZp5faTw434rPw@mail.gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPdV+UKKnntcrXQ15aOB5eCehyxqVEJfvZp5faTw434rPw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 22 Jun 2018 09:57:16 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe-Ty6OdHwGGMvrxmRkfBPzkicFZxWHTy=zzMiZZMFBeg@mail.gmail.com>
Message-ID: <CAJKOXPe-Ty6OdHwGGMvrxmRkfBPzkicFZxWHTy=zzMiZZMFBeg@mail.gmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: samsung: Document bindings for Samsung
 aries boards
To:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 June 2018 at 09:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 21 June 2018 at 21:09, Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.c=
om> wrote:
>> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>

... and commit msg please.

BR,
Krzysztof

>> ---
>>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-board=
s.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> index 14510b215480..edce6602de50 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
>> @@ -2,6 +2,8 @@
>>
>>  Required root node properties:
>>      - compatible =3D should be one or more of the following.
>> +       - "samsung,aries"       - for S5PV210-based Samsung Aries board.
>> +       - "samsung,galaxys"     - for S5PV210-based Samsung Galaxy S (i9=
000)  board.
>
> It is not strictly speaking Exynos-based board (as mentioned in the
> header at beginning of file) so maybe change it to "Samsung's Exynos
> and S5P SoC based boards"?
>
> Best regards,
> Krzysztof
>
>>         - "samsung,artik5"      - for Exynos3250-based Samsung ARTIK5 mo=
dule.
>>         - "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 ev=
al board.
>>         - "samsung,monk"        - for Exynos3250-based Samsung Simband b=
oard.
>> --
>> 2.7.4
>>
