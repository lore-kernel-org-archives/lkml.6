Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525906870; cv=none;
        d=google.com; s=arc-20160816;
        b=SISrkovq24XS4Tui8unUDN6onKlfxsVnXBARgyCh9fEZ4rjHWkEpcvEnu8CXAMQeDX
         Nv+rXz/zByzgsYZjY0/ywd5JSihGqXKNrDnYeRGBHi1RR2pLbFvTV68Pc4VHKnx5kzRw
         I+O+jYqbrqLYgWFI6mw2RD/flRc7k2vMhrhBvyL3EgW7by9Qf6odYwLzij73rfxlmwlY
         1Snp/XyAsQ3e/0NUDx4VUBFgal5Y47aM9FC+Uk1NTr5zTpW9OfT9jHMFOmL/0aA2iUk0
         KWxb9AusairQEnjap85AETO00aSHLgDkQ5fDvNp4LsmSS03DkVCnkdjRkoJxu7s+HzZS
         ysgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=c88J0plQn15b7ya247cNDrY1duaxE9AnhchJIC+bcOk=;
        b=H2CiWXtZ0XZ+DiIZ60SCKO15TpXN/C7fNMrpfn2mMQ8tx/BNOnFtSgy1AMybOCu+2U
         PLo8ndpVdcgQGrOIHIHIP3wYXYr1+q/ExLZiwe0Zax5tUxt4xufAGvruYEkNW6hsDgua
         MIvowrmqxuYVthjtzR/gusM+9L/EJX5D4bTYBc9uCiP3Xj5rXXM8Q2tU+c4CsJn4qGiX
         6+hr8VI3C3Rj+GNY4lkHifYhumWfl3Bn0kyc7C6H6vPDxp2KfghWHnBLUQwoluuIbaOC
         +IJXCnLl7qTBh/ijTpJXDDZQ94o5/dISJBgssWWHkuuEPYUhU/X0kgw6IkzuP5RddMz7
         PmEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=K+MixRI+;
       dkim=pass header.i=@chromium.org header.s=google header.b=RX0B+rBh;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=K+MixRI+;
       dkim=pass header.i=@chromium.org header.s=google header.b=RX0B+rBh;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZrrq/vCrlp6SKjMRlzNUlugN+KMrE8gMfsAgcB36BFxkg57AvGUNVKNPbZQHWHbCuOB6qAYP7afyyJG/4Fgd0U=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180509205544.GW27853@wotan.suse.de>
References: <20180508181247.19431-1-mcgrof@kernel.org> <20180508181247.19431-6-mcgrof@kernel.org>
 <CAGXu5jJXMxx2Xna_M_g1wsS59XnYKqHAGdxhzDtk3PhnLL-gQQ@mail.gmail.com> <20180509205544.GW27853@wotan.suse.de>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 9 May 2018 16:01:09 -0700
X-Google-Sender-Auth: i_NHrvIrQLIOVPdj7hwzuU8PvoU
Message-ID: <CAGXu5jLn0m_9j=r=x1JefRVEYMvR4Q--e8pCufZyoVQkWe507A@mail.gmail.com>
Subject: Re: [PATCH v6 05/13] firmware_loader: enhance Kconfig documentation
 over FW_LOADER
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>, maco@android.com,
	Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
	bjorn.andersson@linaro.org, Tom Gundersen <teg@jklm.no>, wagi@monom.org,
	Hans de Goede <hdegoede@redhat.com>, Andres Rodriguez <andresx7@gmail.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Jakub Kicinski <kubakici@wp.pl>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, Kalle Valo <kvalo@codeaurora.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Nicolas Broeking <nbroeking@me.com>, Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, jewalt@lgsinnovations.com, oneukum@suse.com,
	Bitterblue of Monsea <cantabile.desu@gmail.com>, Alexei Starovoitov <ast@fb.com>, hare <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, khc@pm.waw.pl,
	"David S. Miller" <davem@davemloft.net>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	tkjos@android.com, Jonathan Corbet <corbet@lwn.net>, mchehab+samsung@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-scsi@vger.kernel.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920594318435232?=
X-GMAIL-MSGID: =?utf-8?q?1600029322523185613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 1:55 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Tue, May 08, 2018 at 03:42:33PM -0700, Kees Cook wrote:
>> On Tue, May 8, 2018 at 11:12 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> > +         This used to be the default firmware loading facility, and udev used
>> > +         to listen for uvents to load firmware for the kernel. The firmware
>> > +         loading facility functionality in udev has been removed, as such it
>> > +         can no longer be relied upon as a fallback mechanism. Linux no longer
>> > +         relies on or uses a fallback mechanism in userspace. If you need to
>> > +         rely on one refer to the permissively licensed firmwared:
>>
>> Typo: firmware
>
> Thanks fixed all typos except this one, this one is meant to be firmwared as
> that is the name of the project, the url is below.
>
>>
>> > +
>> > +         https://github.com/teg/firmwared

Oh! Yes, hah. :) Thanks!

-Kees

-- 
Kees Cook
Pixel Security
