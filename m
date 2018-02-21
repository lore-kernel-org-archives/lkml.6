Return-Path: <prvs=583ab6b66=Rasmus.Villemoes@prevas.se>
X-Google-Smtp-Source: AH8x225CA77t9+qEk5BflIa9TnWzY4NnAbS5Sniby2HsOQc3h5NQGutvCc9ddfzD1vjSP6Z7II8y
ARC-Seal: i=1; a=rsa-sha256; t=1519198736; cv=none;
        d=google.com; s=arc-20160816;
        b=tjjus54o9dobe30rO3hOhC3mSu/vUZTGJFdclHU5MHD5az8AeyDxx7fB8gGxjfQDHB
         fSANJBOhGNbfyMO/jlmvKoLg8E3M1pT1XGy69iZc3PD5gIoEzmasGMHFuOgicvjO+Fb/
         YdrFPeMLVv4FZlepgoGXbqciZyS8pc+TLKzh8gY/fTodhU13teICNu0idTBcpJuSUmoX
         l0YCIVyaHrsmsphoi+g/e7NEGzjnpkc37BW06i4L19kMLh7aCAe5ukF3u3ujslk1hWFP
         /JL5HD8isc3ttRIgXfNTYttn/0ar1zuMjjNNLDtA1Iq36cz9GKOmND+OcUVE8PV2UEtx
         ucjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=nIhZ8mFRPSqbG1VJ6Yvxqp9+pChMjF25Ya0FGjPQFs4=;
        b=bCP9gsGbPgQl+hW4Us7e30iNCi0AO9u7c5Cg1jmoG88QK20Ey3P7Gw6bviNZijWSN5
         9BHYWCiaGtRccLWaYJQ824LZAIfsFFS0hZxCGAhc8K6qNoFa9zCX+/jw+kh5p6s4e/mP
         MEJ9rkxcA70DXewQI+R5r5KPbnJpJAKcGq1Jt8QHH2bGSBbJ3H9y9swIlgtdA8w6qE+K
         31Q+WgEeycneL240/O/Nae4A2e2HrC51x9+ZaxBW9z5b+0jQJ7G6iVpG3UHUX+KVngPH
         sXsaFH9qoYbGBN5dW6cPx6WClAFia/Uff3RCyaKrhlBRhZ0b5oncsjjcq5kJlRKwcG/W
         aVkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@prevas.dk header.s=ironport2 header.b=g6Z0jfhr;
       spf=pass (google.com: best guess record for domain of prvs=583ab6b66=rasmus.villemoes@prevas.se designates 62.95.78.10 as permitted sender) smtp.mailfrom=prvs=583ab6b66=Rasmus.Villemoes@prevas.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@prevas.dk header.s=ironport2 header.b=g6Z0jfhr;
       spf=pass (google.com: best guess record for domain of prvs=583ab6b66=rasmus.villemoes@prevas.se designates 62.95.78.10 as permitted sender) smtp.mailfrom=prvs=583ab6b66=Rasmus.Villemoes@prevas.se
X-IronPort-AV: E=Sophos;i="5.46,543,1511823600";
   d="scan'208";a="3099670"
Subject: Re: [PATCH v2 01/21] lib/vsprintf: Print time and date in human
 readable format via %pt
To: Joe Perches <joe@perches.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	<linux-rtc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Salyzyn
	<salyzyn@android.com>
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Guan
 Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@kernel.org>, Jason Wessel
	<jason.wessel@windriver.com>, Jonathan Corbet <corbet@lwn.net>, Jonathan
 Hunter <jonathanh@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding
	<thierry.reding@gmail.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
 <20180220214400.66749-2-andriy.shevchenko@linux.intel.com>
 <1519170907.4326.17.camel@perches.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <1eac0dc6-93b0-2e01-075f-cf62c85318c5@prevas.dk>
Date: Wed, 21 Feb 2018 08:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519170907.4326.17.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.8.31]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957911897092414?=
X-GMAIL-MSGID: =?utf-8?q?1592995334340567001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-21 00:55, Joe Perches wrote:
> On Tue, 2018-02-20 at 23:43 +0200, Andy Shevchenko wrote:
>> There are users which print time and date represented by content of
>> struct rtc_time in human readable format.
>>
>> Instead of open coding that each time introduce %ptR[dt][rv] specifier.
>>
>> Note, users have to select PRINTK_PEXT_TIMEDATE option in a Kconfig.
> 
> Not sure this is a great option.
> Not just the name, the need to select it.

Bikeshedding first: If you do keep the config option, please use PRINTF,
not PRINTK - vsprintf can be and is used by lots of code other than printk.

Well, on the one hand, I like to reduce the size of the kernel when
possible and ideally make all new functionality guarded by config
options, but OTOH, how much does compiling out the datetime formatters
really save? Also, I agree with Joe's concern about the need to select
it. Maybe if we had a gcc plugin that did %pFOO validation it could also
warn about %pBAR being used without a corresponding config option being
set. But we don't have that currently...

Rasmus
