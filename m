Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x2263rh1GE5ipPJG4V1ViFGJ2td6gsdwEEQ9mqvbZsQMj4YC5X+fizee0m7RegN1q3zx4UjC2
ARC-Seal: i=1; a=rsa-sha256; t=1519250821; cv=none;
        d=google.com; s=arc-20160816;
        b=E4kZX0m3q+HNF4171JQson3HniXiwG9A0JyvF2MH911GoSTn8whtyKuGlEG4UoOUVN
         ROrSlqc1+rFhU/Am9/GWlnSm+ToubmD6lJxF2yKWWMv/rLULpUT38ajvPrMJb7xy9pyO
         pRDwnk/dWvsAQjlckYUkTfZYcEBRR4iupGqG91s+G2tgvvnWHBbi6Zar9rcwp/dHonoY
         m9yPMv00kda4f2vzMJz17SsoEAGPcfibf1lzNS5Lzg6sWJayvOjT4Hpvo8qr1tOVG0bs
         uDU5bItf6Gl4WTGrvkdB6+gGDIUL5sC34K2goEiiIfFvLFUDOflqF/drB3A/e43739L8
         2WUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=CfawAHCuCRvK7jyCwGhLfC5HRJKrCNOPBzvChHzEdNY=;
        b=BYpj1gX7UuWku5co1KPc1P87UtUfm00xR6ONt18nkom9Uij1v15ekvZQ21UmLGV4gG
         WPEITJECYMxU29xvozgOXcC+v7HN/N21xvjaULNVZamlX9MtPCVicg0C20aU+ULFqGrU
         X25Lymy6dkKFuAKsKfn4gMLNlBaw71Lfze5SpzTEyS34TsYd6plIrTzSKaadSKOtfFe+
         my9Ik3E2/nJm6rcvsMO7UA2HlATbXfMZJt5Bc3v71xQvEicZ7DvsfrSV3gr8tMgcTzrh
         UfILEFCOHEhFsjNVKjpZrf/6tWOnD7hhlfHhd18Br1V1rnnePNFGii+RA5hiJtAMoxW5
         Y1nA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=odgTnhir;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=odgTnhir;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750752AbeBUWHA (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 17:07:00 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34112 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUWG7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 17:06:59 -0500
MIME-Version: 1.0
In-Reply-To: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
References: <1519249964-1630-1-git-send-email-daniel.diaz@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 22 Feb 2018 00:06:58 +0200
Message-ID: <CAHp75VdceMCPw1b8NNoNLTqU-7b7gZ6b8i6eS1MF8eUTH7Lcjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: gpio: restructure Makefile
To: =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        Fathi Boudra <fathi.boudra@linaro.org>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shuah Khan <shuah@kernel.org>,
        "open list:GPIO MOCKUP DRIVER" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593049130388691991?=
X-GMAIL-MSGID: =?utf-8?q?1593049948477976827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:52 PM, Daniel D=C3=ADaz <daniel.diaz@linaro.org>=
 wrote:
> From: Fathi Boudra <fathi.boudra@linaro.org>

What are you doing here?
Why?
What is the benefit of it?

> Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>

--=20
With Best Regards,
Andy Shevchenko
