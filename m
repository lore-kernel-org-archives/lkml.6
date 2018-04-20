Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524237970; cv=none;
        d=google.com; s=arc-20160816;
        b=vZ9cYnRJH7X4nJP9SX+qkY/yZa9ZssS2+MbtgLc6NFL6liRey9jKL3/VxeWOvDe9A4
         rrZeFeau/tBdUkMfZAJrRU2FewJVcYhvGVcr8XSHC4Izh3JR2Mp4GU18ehbajsE8pGaW
         IJXRa8UP550i/WD7DpK8L4woaFajZk+l7aGhEVMD5LxDMObcL+NmJsXaIvAOkLWWPzRQ
         QjyTFyVvqaxUDccP31a+qbxHskPruWwkUpHkZT91KHu40hlV3fy11hsJNjYuxNjuf5dW
         CzRFjbiG/RLPU9iHfCtFkST0BtpS71eS4DoFJmbdD85dc5gQ7kJ4wcKUZ6ANG9JQ5iaS
         eWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=CyP1EJqXjqmFw/Kh4PH8s6bdg75GcZhLALy945yCAo4=;
        b=PXM6Po3jAwViaqR5cyZJrgGlVsErl7lKj4RT7pzA5zvj0AywE1GvzQQyAub6OEW5VF
         XBScznnb/oTeiSTV0IDA6aMONRS1krg7GGs8ucYxfTlIPIumciTGG34tie01QLMR6EGF
         RQ14SDy8wkUH8I0SwjmRLxlGq1HKXTjQ/Bpv04KKp+rWG/DqFH1GI7laQTOHfkwW2njg
         d3HfqBjx1HQy1/Etbp0mxjNEB2Imd+Xtdk0whxGf8VM09bxC/5rjHCSyXk7kpv+yfzBp
         fA7I2/nW0kWsenIPIv+FY3sDv0/wJYc25DAEwjCnTis4Z5c8YqfG+JBDNxHFyaFlGIoE
         xQBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NYy8dM2z;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NYy8dM2z;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZrRS4DLIo+Y9v4t59ugQ8j9fAkVk+8ILL2m9H75am3diu4sY9hClhB1YWEoNZvL2m2C3xYz2MgzI9nSiqKoNlY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
References: <0b52cfd4def5dd0287a1fd48c632a32e7cc3117b.1524122311.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 17:26:09 +0200
X-Google-Sender-Auth: N8YcutgJ7sNr94zJbIXwkDoM4Q8
Message-ID: <CAK8P3a0BFJK-byNXC8jzxNHyPAC4s1oop06KhrXkr25Dund1Uw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: sni: Remove the read_persistent_clock()
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>, gregkh <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Mark Brown <broonie@kernel.org>,
	"open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598158286152327391?=
X-GMAIL-MSGID: =?utf-8?q?1598279353897180237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 9:21 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The dummy read_persistent_clock() uses a timespec, which is not year 2038
> safe on 32bit systems. Thus remove this obsolete interface.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Looks good to me. I have a larger but incomplete patch for arch/mips
handling of  read_persistent_clock(), but yours is a good start.

Acked-by: Arnd Bergmann <arnd@arndb.de>
