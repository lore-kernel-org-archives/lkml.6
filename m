Return-Path: <mathieu.malaterre@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521097730; cv=none;
        d=google.com; s=arc-20160816;
        b=Zpw0VZ2RuBIZTjy49crA7yzEsFduS5RsEghi+5Qx2CBqme+Et1mam8yS+ctqVuSiip
         BCJZ66YYhhIRp57C1WbmF1w6uefnepm0k9o/KpRM5xu85qBYo7mUyykUryzDw95TidMI
         CGLvJ+qqpyW84fN6IfIGFqfKTSf5Oqobo/BeUUq0dAnK176TwkuuAmQKrByiRQTJW2ow
         3b+CnFgTvAVZDuTAJ/61jJAe2TCaiccShRogUXB2pMbny98hAZqkKOBBrDk0alezhr9b
         EdTwaCAvbbF7BTdEBBgwiM72jVJp0N7JT9Uw6jbPMn5fiLh34VYmbWNawuyu/T7Ii3UT
         s6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :arc-authentication-results;
        bh=IUH+XzlI7K4+MOMO8b1kbjq4CvrATaQ+mvpmLhZ4ubM=;
        b=j4+ENhx/JbSfuvm/ATZsVyPDA9r+uLRf7ZFV2tSRteMpzRwzNpVEzLLowMDbshIBmF
         TQynWmlvuGUW6v1Uho69d3rYSvc0mF26IJ1a3n/tYDB82KVYx3zTyd0k/NLHKsykuNk6
         3l/YYi/uGGw4tetWUgp1jlYTHKMGaNJzLkR7/hVx9eD2O5qUSmPMBj5w0nDmf2Tisylv
         mKEPTCvIA2QJxT9//1tuTjJ4Rqh2vB2zEsRTanHJHuojgeUtqaQHsw7wl8j9nXhWHX+G
         lPBKI/nA7a+IMJB0xcDExWeCXF59Aq0mXUYKP+z9i0n5QvoNecPYdGezCJDYHTU1jJPh
         N/yQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IGEtKVKy;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IGEtKVKy;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
X-Google-Smtp-Source: AG47ELsh7vA6bLbdipZ6rU07RjMH+sgBRGHfqSWfjPu8+i1ZohKZAofAH0RFgfVGssapQAyg0nSZ6Cu1JCtNgg7Uauw=
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <87lgeuf9ap.fsf@concordia.ellerman.id.au>
References: <20180310180645.7014-1-malat@debian.org> <87lgeuf9ap.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 15 Mar 2018 08:08:29 +0100
X-Google-Sender-Auth: 1vAahNKs4iV6SzDdrDTgi6y3TNs
Message-ID: <CA+7wUszUs1X8b43KLYXT_U4EbcDYv-927c2B3yV_N4xe+UHXvQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Mark the variable earlycon_acpi_spcr_enable maybe_unused
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594575013229600361?=
X-GMAIL-MSGID: =?utf-8?q?1594986573595940557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 1:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrot=
e:
> Mathieu Malaterre <malat@debian.org> writes:
>> Subject: Re: [PATCH] powerpc: Mark the variable earlycon_acpi_spcr_enabl=
e maybe_unused
>
> You're fixing an error on powerpc, but the patch is to the serial code,
> so the subject should probably be more like:
>
>   serial: core: Mark the variable earlycon_acpi_spcr_enable maybe_unused

Ah, right. I should have double-checked when re-sending this one.

Greg, do you want a v2 ?

> cheers
>
>> Re-use the object-like macro EARLYCON_USED_OR_UNUSED to mark
>> `earlycon_acpi_spcr_enable` as maybe_unused.
>>
>> Fix the following warning (treated as error in W=3D1)
>>
>>   CC      arch/powerpc/kernel/setup-common.o
>> In file included from ./include/linux/serial_8250.h:14:0,
>>                  from arch/powerpc/kernel/setup-common.c:33:
>> ./include/linux/serial_core.h:382:19: error: =E2=80=98earlycon_acpi_spcr=
_enable=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>>  static const bool earlycon_acpi_spcr_enable;
>>                    ^~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>  include/linux/serial_core.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index b32df49a3bd5..1d356105f25a 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -379,7 +379,7 @@ extern int of_setup_earlycon(const struct earlycon_i=
d *match,
>>  extern bool earlycon_acpi_spcr_enable __initdata;
>>  int setup_earlycon(char *buf);
>>  #else
>> -static const bool earlycon_acpi_spcr_enable;
>> +static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
>>  static inline int setup_earlycon(char *buf) { return 0; }
>>  #endif
>>
>> --
>> 2.11.0
