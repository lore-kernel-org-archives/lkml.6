Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518126616; cv=none;
        d=google.com; s=arc-20160816;
        b=0nSkK0+oLTayLTvuNykv1jWl1243QSWWNueOx8Amph4FBgjhJJREvgaV4QhKtvvDb9
         THdoa42NrEBRoOaVp5xkxRrlSK5meue1acgZtt9bSQlCxOJWDHmbri+Qyp4kRTyy5d6N
         YaI6aXtD8KjpcNxgMQs3V/WMFHNkQmnsI4t7d1GR1M3jfOuUeTwECylhDuZQSuoIWymN
         apT08I6cDSeqP1G4ZgJ7Uqg57BQnUxYM54TXF+kwp9mfuA05b7nNQZZJQ+ZNuOuSHtvU
         bX5DkrM1JBuXjs/G7B/aLD7oU0JLMJTLJin5zqZ2BVYYm8P/d2BO/t27N5CfX4CwmyrF
         wf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hljc5hBHUQYv0kg9gxsCVdsI336KPxWtm5Oru1wG9wc=;
        b=zDEPpCmqAVXOctNpPUNhfRU30EHKJbtttCuHrs3COS/T0zLzCNgaOeWSZD+fZ+Hk7/
         zwN6wjsONtcdPuutZbfnkm8MpuEGqJnF/n9VBLBIO2Qy1gmz87J/8Q/3LhyyAsESJokF
         syOnRsEhAn5KESLAmJJjHCyxTM5eRZbd/3f4wZdxXi16hp1jmqgHoYNv9heeMIM/Wr5y
         3XgYsZVQY5fhrTAiUb0HRMb72Itq2iLzXf/2QxRInHy/Ywm8m5oWI2Z7kAbCNygMS/BP
         ip7zWffj+G31Lkb+xB7KhA1RI7VWRb8Fcs+VyM7wlj3928MFJawsacce5BqVP6r0jCE8
         +OHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IQcuOFZk;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IQcuOFZk;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x224ZXyFpcD+Cb199besxPQeqcjjik4ofpSl6fGDZ9xpv0AmUbqMEIs/Gm1q94QTtYv7oQc9snSLDKESxVicfQY0=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517950494.3677.30.camel@infradead.org> <CAP8WD_ZaewC-NE4szBzU3brvNhvV9PwoVo-uDFcEMTMWVbsxQQ@mail.gmail.com>
 <201802070918.18978.linux@rainbow-software.org> <20180208134908.4b516794@alans-desktop>
 <CAK8P3a2kuHXpJOVKux2v-B_=CrpnQBTMfV24sJqY+nQaSMf+KA@mail.gmail.com>
 <63ca28c5acb64de5ba33a81b6da5c507@AcuMS.aculab.com> <CAP8WD_YujTxLjMD_iXMzmC0V=JVPZQtXfqD7aEEr-+SVaUaaLg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 8 Feb 2018 22:50:15 +0100
X-Google-Sender-Auth: SJYGRsGwGaXq_XgC5EiX6abtH8Q
Message-ID: <CAK8P3a2kgsMmSnK5W1NiLG5m-KYkGEuSBsSf5iNcaJ1vG5SpMA@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: whiteheadm@acm.org
Cc: David Laight <David.Laight@aculab.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Ondrej Zary <linux@rainbow-software.org>, David Woodhouse <dwmw2@infradead.org>,
	Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugh Dickins <hughd@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
	Jamie Iles <jamie@jamieiles.com>, Eduardo Valentin <eduval@amazon.com>,
	Laura Abbott <labbott@redhat.com>, Rik van Riel <riel@surriel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591871134906430437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 6:27 PM, tedheadster <tedheadster@gmail.com> wrote:
> On Thu, Feb 8, 2018 at 12:02 PM, David Laight <David.Laight@aculab.com> wrote:
>> From: Arnd Bergmann
>>> Sent: 08 February 2018 15:23
>> ...
>>> The Winchip is what eventually turned into the VIA Nano, which does
>>> have speculative execution, but I don't think the earlier C3 and C7 did,
>>> they are much closer to the original Winchip design.
>>
>> We had terrible trouble getting (IIRC) the C7 to execute functions
>> that were called in 16bit mode and returned in 32bit mode and v.v.
>> (for boot code bios calls).
>> The problems seemed to imply that it was caching return addresses
>> and the translation (to uops) of the instructions that followed.
>> So it would effectively decode the first few bytes in the wrong mode.
>> So there might be scope for one of these attacks.
>>
>> OTOH these devices were so slow that I doubt any are used for anything
>> serious - and certainly won't get a kernel update even if they are.
>>
>> Also worth nothing that the difference between the cpu and memory
>> speeds is much lower - so far fewer instructions could be speculatively
>> executed while waiting a cache miss.
>
> You might think this absolutely crazy, but I would be willing to test
> such systems if I can get my hands on the needed hardware that I lack.
> I am already doing sanity testing on Intel
> i486/i586/i586-MMX/i686-PentiumPro systems, I just don't have the
> clone cpus (Cyrix, etc).

VIA machines are available for pocket change in many countries,
this one is what I'd get if I wanted to test over here:

http://www.ebay.de/itm/IGEL-UD2-D200-VIA-C7-M-500MHz-1GB-1GB-Flash-Memory-Thin-Client-ohne-Netzteil/301860030372

Similarly, the 6x86 (Cyrix, ST or IBM branded are identical) is really
easy to get by itself and should fit in many Socket 7 mainboards, which
you apparently already have.

      Arnd
