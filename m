Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58970C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D96B214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D96B214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=koikeco.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJQLA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:00:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44270 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeJQLA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:00:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id y8-v6so15586273qka.11;
        Tue, 16 Oct 2018 20:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BgxKisD61BhLs1UtCYpfnP656KRko+9InKSH6vZ0d10=;
        b=R+DpnyVyuH1p4SixqPnjUeipIcjdHujGA9ezZQgOIG8rHh9lmFJ3Vfo4SNjHo5Pf1F
         ookRBLngcA9mDcObTfImpOybRv3zZ0d0m1DXzBGeWOZX3vGAtl/bPGkyCpKUzu+8sAFe
         HDi7r426gYyzmMwd/EuHy4AhBHC7YouHJz6AJE9DtYcEmr34Etjhzpkx0zd3f8DLigyI
         71GfXk9jmJDt9fylNpqbkHJAhbJughzXsrminVPMLgnZsP3GnGBAQfMJ6EpzQgBvQgo/
         UUJM2YmcuJHmjSokz6x1qE/rNBKsybnSSstkjNtFFltQq79UKr79hy/Ksv91C0AoXNXV
         u5nA==
X-Gm-Message-State: ABuFfoicf5XSevvQQukI2G6yAFvUjzpcBml2VdG2rHZJEYgXGjJNKuwV
        e1y8fIQO091mzU/uRZrvQcc=
X-Google-Smtp-Source: ACcGV60kE7KyLJVTuqhwNwGjX9plgUniJbZlOtPfN5SAJJ3T4/zt1AJtNAix5mPt/UDyxyEA9D6Xdg==
X-Received: by 2002:ae9:c303:: with SMTP id n3-v6mr22886648qkg.163.1539745615801;
        Tue, 16 Oct 2018 20:06:55 -0700 (PDT)
Received: from ?IPv6:2804:431:9718:6346:661:e081:23ef:66b? ([2804:431:9718:6346:661:e081:23ef:66b])
        by smtp.gmail.com with ESMTPSA id g39-v6sm11294300qtc.89.2018.10.16.20.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 20:06:54 -0700 (PDT)
Subject: Re: [Lkcamp] [PATCH 3/4] kbuild: Removes unnecessary shadowed local
 variable and optimize testing.
To:     =?UTF-8?Q?Leonardo_Br=c3=a1s?= <leobras.c@gmail.com>,
        lkcamp@lists.libreplanetbr.org
Cc:     x86@kernel.org, linux-kbuild@vger.kernel.org,
        Matthew Wilcox <willy6545@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20181017000912.GA21339@WindFlash>
From:   Helen Koike <helen@koikeco.de>
Message-ID: <d3185020-b1aa-3eeb-b8e7-ecaefd624236@koikeco.de>
Date:   Wed, 17 Oct 2018 00:06:49 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017000912.GA21339@WindFlash>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

On 10/16/18 9:09 PM, Leonardo Brás wrote:
>     Removes an unnecessary shadowed local variable (start).
>     Optimize test of isdigit:
>     - If isalpha returns true, isdigit will return false, so no need to test.

This patch does two different things, it should be in two separated patches.

> 
> Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
> ---
>  scripts/asn1_compiler.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
> index c146020fc783..08bb6e5fd6ad 100644
> --- a/scripts/asn1_compiler.c
> +++ b/scripts/asn1_compiler.c
> @@ -413,7 +413,7 @@ static void tokenise(char *buffer, char *end)
>  
>  			/* Handle string tokens */
>  			if (isalpha(*p)) {
> -				const char **dir, *start = p;
> +				const char **dir;
>  
>  				/* Can be a directive, type name or element
>  				 * name.  Find the end of the name.
> @@ -454,10 +454,9 @@ static void tokenise(char *buffer, char *end)
>  
>  				tokens[tix++].token_type = TOKEN_TYPE_NAME;
>  				continue;
> -			}
> +			} else if (isdigit(*p)) {
> +				/* Handle numbers */

Actually you can't do that, p is being altered in the first if statement.

>  
> -			/* Handle numbers */
> -			if (isdigit(*p)) {
>  				/* Find the end of the number */
>  				q = p + 1;
>  				while (q < nl && (isdigit(*q)))
> 

Regards
Helen
