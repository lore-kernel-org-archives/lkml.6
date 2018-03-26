Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AG47ELtrwudweITMwxScWEgn8T10px1KD+Aj4P3giYn1Nv3p52NMNFAZPp0X5Uc22XQHSr+yfAtE
ARC-Seal: i=1; a=rsa-sha256; t=1522081314; cv=none;
        d=google.com; s=arc-20160816;
        b=JHiqReMxObzgcI9d6JL+xFQs4horW0Oc2KDEiD3CvQ/LH6365+4wo6J9ZhIbZTGD60
         9BT13089lfOhEw12Mol34jRdmCe49xVJb3IdXYM53MGfJSTYNYqLLM7el/Ibc7dfGCs2
         KbLX7ebqFoCgE3lCMX/gyFUQZx3oRzJTMsO3G8pbWWAZd51bry2RKBewgK+RT9IlQxjO
         tl1IaZ0Z8Pt6/sjqp9pkcj6AT4egisOiGYLThyHoPW3iltObd5HnQ5lPxqSc4vMclrFi
         05r3HhbAFRZ6yYap4h2QnUmzjNDyNzHXecBAP1szgO3V3zHuSvrE/iPDy2fDz3UjndSn
         8fDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=4G3onaJBCdwQH/tWWIkRlu7iOoWZ0pIsYxvG6lX+zEM=;
        b=RliropRqELVAxzSO1RaNyvQ7pl5kx0g08yp5OUcoAwq3w+EZCO8kO7Ca+nM+J+uj7p
         g28VwdYpu5qgMsK1uDNTKp+VgRPt4fATL4ShTSjkkwGx4Uk25EzdvQ2gdmXAID6K/qJ6
         wKa4Sgqo6NpP1k7B0Xl0JOI9yAgiiua9jCdR9Aj80IV/st8Q+qizplWxnIZl16oFUKUz
         DGKH+vEaQsDsZGRBJ6HJpmgy4tTART6wMuVy6U2pQSLGQGKNLehN/GrZjaKa9HDQau0s
         KU5XUSDICTzUzh+XjishQD7BS5PQ/nlXvT5QnK0hgnRY5xcN+Rq7U4zbr80Vl8hITwvR
         i91Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20180321163745.12286-1-logang@deltatee.com>
 <20180321163745.12286-2-logang@deltatee.com>
 <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <726eb143-2cca-b221-b569-e193a962e357@deltatee.com>
Date: Mon, 26 Mar 2018 10:21:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a25zQDxyaY3iVv+JmSSzs7F6ssGc+HdBkGs54ZfViX+Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: luc.vanoostenryck@gmail.com, kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com, horia.geanta@nxp.com, andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 01/10] iomap: Use correct endian conversion function
 in mmio_writeXXbe
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565968042571455?=
X-GMAIL-MSGID: =?utf-8?q?1596017936831262077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 26/03/18 04:53 AM, Arnd Bergmann wrote:
> On most architectures, this is not important:
> - For x86, the stores are aways atomic and no additional barriers
>   are needed, so the two are the same
> - For ARM (both 32 and 64-bit), powerpc and many others, we don't
>   use the generic iowrite() and just fall back to writel() or
>   writel(swab32()).
> 
> However, shouldn't we just use the writel(swab32()) logic here as well
> for the common case rather than risking missing barriers?

Hmm, I don't know... it's complicated?

Doing a bit of digging shows that the existing code was written during a
time when writel() did not include extra barriers over __raw_writel() in
any of the common arches.

The commit logs don't seem to provide any guidance as to why this it was
done this way, but I'd assume it was done to avoid a double swab() call
on BE arches. Seeing writel() is typically implemented as:

__raw_writel(__cpu_to_le32(value), addr);

Then on BE arches, writel(swab32()) would become:

__raw_writel(swab32(swab32(value)), addr)

Which seems undesirable.

Logan
