Return-Path: <graham.whaley@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519296171; cv=none;
        d=google.com; s=arc-20160816;
        b=vXmAcWOl2TDCmJN/igrjjII6EUuGWTpB1uudHHYOthbx9fMUH9M85aGbA1c3QrSeF6
         L0Gwn8m5nRpc7+nyqN4lyHpP2U1ckljRJ1FvBDfREditesewyZAu1vx8kIr4UqVurUSx
         xeRLV7ZK3MM4vFXG0mw1S42IGHlBUKKrUfdyFJF2fFWPOw2kLd4OHTzA8hlGU5vpmkNG
         s2leoQg3dXlunHRLRjSLEhukPMr4Hu7MMGbimooD1LsfDRTGumxa4mqjTq3EBoAOueAp
         n5ccuJt8ZmP9V/fIYg6ChdM5b9k7e7lgVzXS9R2q3YA2+AOEXF0cRbiFYfPEoYNfxtOj
         thEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=8LMqlTo/vAljRcbt3gFPTniFmmsp9zwVo5c+UzwqcpM=;
        b=dLR+pHqLxyJUxzT4714v2D1isOtxjwPJudoODBKUdARAtbyCzQepdRILUrkHWhG155
         M8gDoIMcIa7P+nQhlPH5+92QFQNdl9lzkH/OpptlWd+AqF45mB1nagCQyK7idrzVE8O6
         skiDzhmheVtjoBbU0QGmOrAEns0DWYfNsDAgK9cFXJ59iXaeZNnythuSdO9O27aXfiHi
         gTSAm7CVY9mLsX8fbYB2fR9AADlgRT4KMlAZi87cScRIoneI40TyzO32/+R6VOAWBVkL
         vnIJodz7qsWCVYJ/LYMypufArgWAfiy6gU59aOEBnJszV+SFeZ/Tou5L0BDL3wGR/LJV
         sNgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mBmOvW1B;
       spf=pass (google.com: domain of graham.whaley@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=graham.whaley@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mBmOvW1B;
       spf=pass (google.com: domain of graham.whaley@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=graham.whaley@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224i2Luhb5n6GzMx9N9vhq3t1MQw01RSG+ufBioBhfq6TrW/u2yrNpg8mBMX9oM/8rTubsptt4vd3jgm+6R1HRU=
MIME-Version: 1.0
In-Reply-To: <20180222094844.GB9891@saruman>
References: <20180221233825.10024-1-jhogan@kernel.org> <20180222092654.GN25201@hirez.programming.kicks-ass.net>
 <20180222094844.GB9891@saruman>
From: Graham Whaley <graham.whaley@gmail.com>
Date: Thu, 22 Feb 2018 10:42:50 +0000
Message-ID: <CAF9eJuk=UNOQMZpTXCNpXVYUsYonvfUt_sB-kh8yLJDfinZPLA@mail.gmail.com>
Subject: Re: [PATCH 00/13] Remove metag architecture
To: James Hogan <jhogan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-metag@vger.kernel.org,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-media@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593055859238851284?=
X-GMAIL-MSGID: =?utf-8?q?1593097502105244833?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22 February 2018 at 09:48, James Hogan <jhogan@kernel.org> wrote:
> On Thu, Feb 22, 2018 at 10:26:54AM +0100, Peter Zijlstra wrote:
>> On Wed, Feb 21, 2018 at 11:38:12PM +0000, James Hogan wrote:
>> > So lets call it a day and drop the Meta architecture port from the
>> > kernel. RIP Meta.
>>
>> So long, and thanks for all the fish!
>>
>> Nice cleanup though, most welcome :-)
>
> I thought you might like it ;-)
>
>> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Thanks
> James

RIP indeed. As I sit here listening to my META powered radio.... for
the series in general:

Acked-by: Graham Whaley <graham.whaley@gmail.com>
