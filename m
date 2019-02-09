Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC2C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993ED21929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 23:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="eQdv9n7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBIWyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 17:54:14 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:58914 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfBIWyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 17:54:14 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 888515C041A;
        Sat,  9 Feb 2019 23:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1549752852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlQkmw8s4mquGYq06cl4PilEa3gn5EmC0waOUU6hVHA=;
        b=eQdv9n7j+d4yR9YNPEyUqziwhfY0OpKssWKWaIXZ6MJpdm5iTUmojvYKSRt8yoO4irYrPM
        yieWNk0IQ8vxh6IlSnED8hNEPdul5mkTcTfgeZvwujrV2rShYmQ0Q8XOU8FmgWrNLAVDv8
        OSID4dda6jQCOSXzimzW9wKtwRdw2nk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 09 Feb 2019 23:54:12 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     linux@armlinux.org.uk, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] ARM: use unified assembler in headers
In-Reply-To: <nycvar.YSQ.7.76.1902071055380.2213@knanqh.ubzr>
References: <cover.1549532513.git.stefan@agner.ch>
 <b670feebd5e0bbc4c93d3f31f45bd0243b32425f.1549532513.git.stefan@agner.ch>
 <nycvar.YSQ.7.76.1902071055380.2213@knanqh.ubzr>
Message-ID: <b79145b3420212e0ff04dfa0da200790@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2019 17:10, Nicolas Pitre wrote:
> On Thu, 7 Feb 2019, Stefan Agner wrote:
> 
>> Use unified assembler syntax (UAL) in headers. Divided syntax is
>> considered depricated. This will also allow to build the kernel
>> using LLVM's integrated assembler.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  arch/arm/include/asm/assembler.h | 8 ++++----
>>  arch/arm/include/asm/vfpmacros.h | 8 ++++----
>>  arch/arm/lib/bitops.h            | 8 ++++----
>>  3 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 28a48e0d4cca..60465b55683c 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -376,7 +376,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>>  	.macro	usraccoff, instr, reg, ptr, inc, off, cond, abort, t=TUSER()
>>  9999:
>>  	.if	\inc == 1
>> -	\instr\cond\()b\()\t\().w \reg, [\ptr, #\off]
>> +	\instr\()b\cond\()\t\().w \reg, [\ptr, #\off]
> 
> Similar comment here: you added a \() between \instr and b as needed, 
> but the one between \cond and \t (which was already redundant before) 
> may go.

Thanks, Nicolas, fixed this.

Also noticed that the else branch has such a null token in excess.

Furthermore, the "t" token actually needs to be before the condition
token too. It should look something like this in the end:

.if     \inc == 1
\instr\()b\t\cond\().w \reg, [\ptr, #\off]
.elseif \inc == 4
\instr\t\cond\().w \reg, [\ptr, #\off]
.else
...

--
Stefan
