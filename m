Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226j7yp32HIM0ORRmw5k5FyN4StViTIG8soPxSXCAflhhlIxKgHp+Vpdch3rHqSoMaMqHBhJ
ARC-Seal: i=1; a=rsa-sha256; t=1518069726; cv=none;
        d=google.com; s=arc-20160816;
        b=BWtlmT2+EhB5pOMB4UyQM4zGEZAc6s6HpejLm+83RfEYLgY8fzeeEHV9MAj3G5+Pvw
         yMK1GPZ35uojGXQAK1KR4iFgICq+79El4WAlLwxqWkDamGmkfRZSVGODzs/JO83MjMPq
         eYrgd4V5J/8yED5o7/40c2HIwMMkgrS5CvWueQ7HmyveYaA7VK+ZrUHeRS0EpTZLilYC
         PMRV9UDWN54Jn/NOrcWU0prUcbSQoHgfp7lHxjxff0hh/WZPIFSI1PvHlEIumYs+rttz
         KlmTPibVh2jhLLFxlLsXP5QM888aEhB4KboFp3uviY+sg6zT4jOu11hDpzjMRPi0AqSP
         uPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=IGhjm1XrIn9Iv1L/Thg9FttGt1ZWJhZ3bw11PEZDunU=;
        b=nsOszNCczIHIenETNvwkgI7T61+cGfxez1tcrrGChtSUjhIY86n+MJbb6zjQrkhP1B
         gldzdU0U7dQV6FQFoc0zWXweLAHmezsAcVRg722cNRPTwQGjnSZoM+0P8hhJSdus5YfQ
         uLojK9WHnY2N4vpyjB5aaDU7Ic6yYg14sEbgK9BgCbE8JWwCWQx1vN0UIdO6gERfj8nE
         eN3zm9IYxCngUrS5FLHkW/oYdYlPxpvzaJ8m/PD4oXmIvZTDNcOxwSEksaqcJksp7UaS
         KTLv1thI4D9hAJtPottlv07t0wacb3ZPd9TA6PiD/GeR34/DgmutSjf56sSY87kPa/xT
         t77A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hJgVthi5;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hJgVthi5;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.90 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w1861b9S002305
X-Nifty-SrcIP: [209.85.217.181]
MIME-Version: 1.0
In-Reply-To: <CAFkk2KSA6L_Ti_rFN9waJWZvntNT6qnvW1bzcbAbfnHpZM_wyw@mail.gmail.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
 <1517877294-4826-5-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KSA6L_Ti_rFN9waJWZvntNT6qnvW1bzcbAbfnHpZM_wyw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Feb 2018 15:00:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNATE-8V=00-6g2AM6ymXR5mkc_GkL=Y-YU=raZhSG8MP1Q@mail.gmail.com>
Message-ID: <CAK7LNATE-8V=00-6g2AM6ymXR5mkc_GkL=Y-YU=raZhSG8MP1Q@mail.gmail.com>
Subject: Re: [PATCH 04/14] kconfig: print additional new line for choice for redirection
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778754475982?=
X-GMAIL-MSGID: =?utf-8?q?1591811481099334303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-08 8:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> If stdout is redirected to a file, prompts look differently due to
>> missing new lines.
>>
>> Currently, conf_askvalue() takes care of this by putting additional
>> new line, but conf_choice() does not.  Do likewise so that prompts
>> after 'choice' look properly.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  scripts/kconfig/conf.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
>> index d346642..6ce06c8 100644
>> --- a/scripts/kconfig/conf.c
>> +++ b/scripts/kconfig/conf.c
>> @@ -317,6 +317,8 @@ static int conf_choice(struct menu *menu)
>>                 case oldaskconfig:
>>                         fflush(stdout);
>>                         xfgets(line, sizeof(line), stdin);
>> +                       if (!tty_stdio)
>> +                               printf("\n");
>>                         strip(line);
>>                         if (line[0] == '?') {
>>                                 print_help(menu);
>> --
>> 2.7.4
>>
>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> Maybe this could be moved into the xfgets() function as well.
>

Thanks for your comment!
Yes, it is better to move this into xfgets().

I improve this a bit more so that the redirected stdout
contains not only '\n' but also input keys.

https://patchwork.kernel.org/patch/10206611/


-- 
Best Regards
Masahiro Yamada
