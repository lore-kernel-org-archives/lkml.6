Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9659C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E4121848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="F48/Qw45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfBSIaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:30:07 -0500
Received: from mout.web.de ([212.227.17.12]:33147 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfBSIaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550564985;
        bh=a6bresgUzxhE4v3oLQCy5Atk3OgYdqeO8M6tHHUYvmE=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=F48/Qw45gDcw77zTLbuGum8OjBWG5uwo4TL9hlRvDctPoeJVSJAhp244o8ufIMcZj
         a8kqkGzeccNAWnvGRMY7f69q3hdwQbU7WMLwzSuNg0R38K7K1Q6/yphy0ROxx08xfQ
         g5m+q/yB5Rdl9XoqSf970lvZZV1FMd3+YUW41A4g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.74.8]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTEQ-1gnimN2DKg-00AThW; Tue, 19
 Feb 2019 09:29:45 +0100
Subject: Re: [v6] coccinelle: semantic code search for missing put_device()
Cc:     Wen Yang <yellowriver2010@hotmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
References: <201902191014156680299@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <31a0ea02-4005-23a4-8030-47319504e84a@web.de>
Date:   Tue, 19 Feb 2019 09:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <201902191014156680299@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:hdKk38Gi30yeKUTNQl3V0lH7gZA+LtFk8b0AcAxH7QanJBjarOz
 ACOW5VScqKzsPC1IRpMsX/KkYpo51NWtD6VvnBkSO5yqYn+FQY8w7rLtZnnNgqrPGewq7hX
 RXNLvDaP+ld5E0vO0YnlCd0g7OOWUiS8PU6JTqWM8823NcdW+9yBYODKZPzaRNz4nPh1gev
 x5LHNKQ74n9fAtV0P0GtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vi7u1cBzric=:ZtHwpis1f393afVdmCfrhe
 FQtyTYQYMADrJKGsqSd4ntPu3O3TW7K/a2KBru3jhiH5nzZTjkTb1uyPgTK7/KT43XniPLc17
 jG2m6X/6yPE9Ek3OPlPYsL2CELqbDvd1HimWAK8roa6HBvsTQNcatkHvkHwP8Fn8PT7dhWSXe
 DgF5oYHF7yz6fVy1xN08L0NosulfJiYjdujwFb/ziQ20Z0KfBcNjvHBrkS5y7SZVmvwQxm1VY
 3WrM9lJ6aQAo9Ea+YbRlQpOw1Z3BBZHazsXiikdVfYHMHtm4CkmVz43Ey0My39s0igj6uiJ+d
 gra92fIqRoVvPDkuqgxuGkH1cfN9kz/qvmHQ/thyOBhub8uRLVRnFd1UKZgHBHq/OQMLeMSSC
 YxmTBXT0o+Puws599dyA9AIv6ppqHgWOtMYiz+F+ByRtUGM8OMbojJTo8dbtT03KEgcfIAoKW
 Z/cpO5v4HXMwoUX3uwjuahuJfpm8nVXbTyoXTw3h5ftEdxcpymFj6/4lfXVQRltAVx7IrAwDB
 av1l6wH07pCCY9rvz9wHsGQ+Mf+ibsDXP/Bknx7dpCcsV99JXdzWIbEhUQtOJpxtdGFHym4L5
 huHjtPA951W8Uzna+QuRBjb49yngBj5KMao1qj1K5SkyPRJGrYgrlgtNj0zx3tvV3M65xSi/2
 H0iI/y42fsnqY9x+GONKU95h1f1mRFYpULQB9pcjwU+56Hcp3Is3UetiiwZJk2KSXqZRp8x7g
 /HulEn7UzuFYxcJnvIdV/k0eOkXx7mgjL6zcO5VUiZ0ou/PlGgmu5IXA0kGxC5g/CLSvyc+1m
 7gpoykHam2aV3ViebVpb0wj9H0SL6fpefsrQTO6LhHvn2tzAQUw2t9LePTGI8h6Zw27qOuP06
 n10BBJsj9PZsh9mEdrtEVz+JvhoIM8lo7fN/UFMIIe2WW3Q2WI4D+qw2Owaasz34ImGbs7TUR
 fYvXXu12sNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you have any other questions?

Obviously, yes.

I am curious if this development discussion and code review will trigger
further software adjustments.
I guess that you will need additional time to reconsider specific items
from recent feedback.

Will corrections become relevant for specifications in (assignment) exclusions
of the second SmPL ellipsis in the discussed script?

Regards,
Markus
