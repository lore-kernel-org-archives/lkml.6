Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B1DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4594820645
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Hr2cJyMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfBSIMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:12:55 -0500
Received: from mout.web.de ([212.227.17.12]:33541 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfBSIMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550563956;
        bh=HcNCexWKzixXVPB7/Xd1WaaVIctiTzp1VwIqMu6CMbs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Hr2cJyMyx/gekdEX1lTGArU/JkNvquiHebIZZV25bI0JOS0vQgGrKM3tjkusgqU6Z
         I2jEl39Fsr86RAYSadQMVZHUETAbmSQ4enliDLrL254ISVJIJxZhrm6Z1NrtEzuXz9
         uG7redd65bLv4stY3a8Bl9QckxHx8C0Qkb4bj1tU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.74.8]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgYG1-1hRRlx0Btt-00nyJQ; Tue, 19
 Feb 2019 09:12:36 +0100
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
References: <201902191014156680299@zte.com.cn>
 <alpine.DEB.2.21.1902190804150.2570@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fc48cfe9-3d01-8ab6-7bf0-a481b72f4a1a@web.de>
Date:   Tue, 19 Feb 2019 09:12:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902190804150.2570@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:msZVpyyQUpLhLihtedfxAeQTQKHhRH1jPwO59u6c+VwmVaOD2PC
 k6A47BThUeRVAMffsxO7bDy2b+TjrpTy2ahD3yfH0GSguWG8HVbA7EvrAeCGohfQNs9eNag
 OviZ4RAJnXAww1Z8wxgmz4o6hCuNnrcCZu+yqIRNwjEmzIiU0ZGYG9dU5zyX4HrKiOSnzuY
 k/NsvvF9CuKchU9Icg3NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vDj9WKj5tYM=:bnjhBuyiRgsQ3jKX24+GxH
 cFyhxX6Oi7iOGnpOmmEnjOuFu7duAc0jQv6lOncbeRYwerqBoGz1Atyob2W3lfclg86xCPwMA
 /9VJlZRAKXHV0FdJGnkd7Z27Nlhn0Qb5q1d/MQAsleLBvUpdp9dDshoYe5nVnYyg0NMwHM0EL
 VBlVRXLwo4ihi5cD67/zHDoWLmfz442Oz/7AqylWJ+ufv7qzQJcOjEFzfkBlhRWFc9rDCtByC
 oPuitbae50KO4wcE/Ys7WviGHmSkRPjdh8sLlBeAOloDnfLnXvUpRrmHCLGvh5BmoS0HeP/C5
 lFe153Vr1IT/Ee9WEFkKMdHNsn8FDasmyUf0bcUE7gBhQN+xxtxC8pCN0fgfMIJUiKRh4T+rK
 AjUkzG0Nn5jWHyLzxEWHArBwZPk2u2Cc+r6TU8oQBU0puwqkqubDNVrwBINSQT98EanAOH0g1
 24Huf8CpeiZkMChwd491cPUaGUIVfdAbJSo265S5VQjLrQ2W/u73v6XEs1W3yOrUn3VkdGJds
 NqpT3teDGk5XBL3T8xtMO9VDWUfMGBw+LRn3z81MfkHrAgcMHkaaFRVcSl7SvjeHgUPoWMN44
 jsE2h28gZZ05/fGoySiq3TQHZeUpJrU+0UfaemqXDjCv8Sm2XXqCeCmE9ffcATN0k9/Nr5xER
 h2pub8hFCLHztII57VBPpoLrecFl6bCWyBQ8BUWWFmvQNl8OGq6g1IrskEEVInCcLOLfO66YU
 mFJEi37dsFq+RhLdEDwU1n+MktIjWpl3rK3+lvbvl/4jyM0d81Whx2/fV4Y9adFLeNVpp1kgw
 DqEJXMlN2icCNqrFSmszIISZIiJ+92+EJJwD3iswrGAesIhJYUbHw0Z5AzWxFH6Gtc54f7XjB
 iHHNLANRqtzQ1mI2olVHQ4Lb5NqVMm5EdKrA/XghUMegpEfk1ijYxuEa15lvB43HrKH3uvTCL
 EPzHL58+XPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Although we have tested these two methods in the existing kernel code,
>> considering the evolution of the kernel code, these special cases may o=
ccur, so we are willing to take them into account.
>> We plan to modify the code like this:
>>
>>  id =3D of_find_device_by_node@p1(x)
>> -... when !=3D e =3D id
>> +... when !=3D e =3D (T)id
>> +    when !=3D id =3D (T)e
>
> This change is fine with me.

Thanks for another positive feedback on such software implementation detai=
ls.

Regards,
Markus
