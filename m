Return-Path: <onatalen@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521530482; cv=none;
        d=google.com; s=arc-20160816;
        b=P+uB+i5EGK2jd612he2D/KN2TRuMDClCMyD9umtLNq33sqLB5wT9/dQliSjd03sAJ+
         MoSUH8VEpG6YNoQZuMMgPcpT92Hq0fEqBFDSxuWlyNUzK2rrgkA1Lw4vqdYlYC0nIgjO
         5TwECrrAaPJnWKsZuhvzFsEA53bzDDMpyDFc1aanQNblQr8pirhYAvM9McQzSD+iN7Ta
         YS8ilGg0KXbPOrCuC75Rjf2AL46nff5jJ42GWr5uluJ4pDR6HsgL4seGP/HD+2/VsFPu
         pECz3QWiPeXtnOWpuLN9pLrO7Alct5Z8QLQJqOkqN6pL2yrLeTnAXQkPGhGnuhh5hAEz
         dHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:arc-authentication-results;
        bh=fjjDE2K/zfX/y5OjeXEM4Vhn1f2Koj48VcOCwv1s058=;
        b=aZSXixDckpFXz0fPshltojbOarCgn5k40lY2dIVjoUNRXnDEHxhJ9eS9nEVPKmG6cZ
         JDuaZGHkP58ZnTf5XxXhYbNZKcL1kw89iv9QkPAqM1EcSzyg04LuXKa9GURFMIXqD817
         HJrv9Jn/ITRwHKjCToq1Fkt3wkuxiTsCKnE/KV038HRnj+SbcNGsDIU1lASDytq2y1hJ
         2RgYMgAvcFw4os+4ZbC+rXe2J6u71+CPDIT/VZu6atKrDnxo98WDlwjFoJ6rmI8+6XHn
         4lOg8SzKzmkw1rJW0Rn3iinyvK1OyDvJtNrhqT+VbDwJZnaPa8pdgWtMWkC02ak3fXJk
         aR3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of onatalen@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=onatalen@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of onatalen@redhat.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=onatalen@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AG47ELuvgd8AKNaQK5gu5f3sWEKTvMOPNxKBfxgQ6/BvqKWByLs1H42ElmGdUzB9wMPERHtvgHrhI8aSpKADFOAtLRc=
MIME-Version: 1.0
In-Reply-To: <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com> <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com> <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
From: Oleksandr Natalenko <oleksandr@redhat.com>
Date: Tue, 20 Mar 2018 08:21:21 +0100
Message-ID: <CAHcwAbSijSmeU3WnznAC+ZaF9iCmYkizqiJNuvLcrYm-YCWxRg@mail.gmail.com>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is off
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xavier Deguillard <xdeguillard@vmware.com>, pv-drivers <pv-drivers@vmware.com>,
	LKML <linux-kernel@vger.kernel.org>, Gil Kupfer <gilkup@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, ldu@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594760746388076540?=
X-GMAIL-MSGID: =?utf-8?q?1595440347072257872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi.

On Mon, Mar 19, 2018 at 7:52 PM, Nadav Amit <namit@vmware.com> wrote:
>> Oleksandr, if you can confirm that it fixes the bug you encountered, it
>> would be great.
>>
>> Greg, Arnd, on your free time, please let me know if there is any issue
>> with the patch, and whether you can incorporate it, preferably in 4.16,
>> since it is a bug-fix that was encountered by Red-Hat customers.
>
> Ping?

No news from me (yet). We depends on the customer here since we are
unable to reproduce the issue in-house. If you have a recipe on how to
trigger it reliably, please let us know, and this will speed up the
verification process.

Thanks.

-- 
Best regards,
  Oleksandr Natalenko (post-factum)
  Software Maintenance Engineer
