Return-Path: <deller@gmx.de>
X-Google-Smtp-Source: AB8JxZrckEKbNu2Z0gm6NQ5NuukaUXblPd9I3JlLlZ2PU9HJ+BZ6B953S5vONJ6bVU1y6q0CO/fE
ARC-Seal: i=1; a=rsa-sha256; t=1524331765; cv=none;
        d=google.com; s=arc-20160816;
        b=YvVE355D96dA7wVeoPHsQIzC+MkKTh6OljEsXY9xGuujPT09JhQkAjfQM9BhfDcFTA
         VnVaZWEMyF6ouiQAp6OC70uu/+C2F/26C4XnXjZJcMv8fctbVyxtzhh0FSWA/lhwZ5Ml
         anilqzWbEe6SUrmhU+AxJvrul8Df+MpH5yM9CribKcMrkkqqeGHIw2OI8Iohkscxn3m5
         3xo4oe1QH2j+ZzhrZalUhNnbFs6PMvYB50nFIdJn/mD+qxmBsqMh9KrUaYUlw3yzi01M
         9+jQHPzakbpZGKHNK4diRuoIC0OlayPlUQ7waIw4TV2RFAJGrY+yPfU4+exO/0ILJnhS
         5lrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=MbUdC+NUUbbW8L1fpHtz2x7a9lZcqdrSLW58rvbQw3U=;
        b=n0Jw9TfBcTMt6jjtRckucNG/GlF6MnhlOBd7fwH92WmlGUfRr5YDvYSzlkBVyzrQk3
         Y2x7LNR+Tx4Qf7RJdCgSWydETZxvejUHrTqzR6dKE9QhWmkbO4zlNeMbUALgPZ5HNw8Y
         SO8ZZqqXBNcaqZfjWU/lsl3FRBPRh7qcgWqM0fbmd2a1JBzht2VQXSnjxfE3LOUHlLbE
         rC2PbZLuivoyXHpQGRkTKQCsEgfSvkJXJ8xDL327kHgC+1GJVsSOMfveEXO1IAVtKOto
         Kq0H5Dp9z7eTK47nk+IacormdLhsNFFYbnc5EIv9IAcgcCCQCEOYJzGcUOS1v3fx4rpS
         dgYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of deller@gmx.de designates 212.227.17.20 as permitted sender) smtp.mailfrom=deller@gmx.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of deller@gmx.de designates 212.227.17.20 as permitted sender) smtp.mailfrom=deller@gmx.de
Subject: Re: [PATCH v16 2/7] parisc: iomap: introduce io{read|write}64
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-ntb@googlegroups.com,
 linux-crypto@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20180420182403.9691-1-logang@deltatee.com>
 <20180420182403.9691-3-logang@deltatee.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <4cf30fbf-4972-2b1d-f327-99c20f07e84e@gmx.de>
Date: Sat, 21 Apr 2018 19:29:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180420182403.9691-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1P3JdxeM9adZQ+6fAF8ZgFXHgZq20NyIkPfh5g5VIhgNOa9++0O
 kAciezjNUcFlRuWl9cadcWKx4R9BT0AjnEDaxGiOXAyW9NJOc8Y1XMyiUnkD71FknWejnxF
 EszrXOPvWBxVyS5R6+g+qG5NFij65t0pYJspd/vg7ZIWlifLm8oQ5KtiZTo+4D4+aJQK+I/
 /C8f7XuH7KtGRo/4MFkvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zc1Mqf3lKC0=:LUtow1XgpFLOcLgOqdga4Q
 TpY/qpNJhczgZAXjF/8gwjT648EnJ0rfGbyKBD3eGq6+y/cZhnrz8XUIGFYAj8j1Zyl5+A126
 eQ45ygndIGFfpyE5LANOIGql9L6OG/2LtyEuY3/8oE4vpRWbNrzT7tJFB6c5SCErmIe4wr0Cn
 NESmJTAiqkDGrCXEQxvC+CpXZMZ3ULBnl69hdNWeHNNnwqo+2U5M2qDgITS8w9hHQZmak+kOb
 4uLvHYlywJ/K/ItqSilC6QNlfIsOoSalrAbuPXr/W0xXgNxwrq6n7MUmfnN49DwEY4R53FidK
 1PbedpgSNTolqo6dQd6ub81PJWAQ/ftoKZ+6Yety6e9pX2YGBypXJ7LCFboU0Wl8eMnE2CGYw
 7n6nDc+L+/as9KuQyAujukuvTdpI8vt2rYV6MAss7rQZRb21YQJbH2nXbzsIEi2DxhL0cVCVe
 c6wqNWxyuvoM+8ziezUnUynFOkZlUhGRLZweDcuGb2Di41m1YQUhgyUEFme65D4GD1UlqNzpG
 w7vh65xQbR4eTknTx3b44NAgL9Fz7poVSKTvqQGlMmbohqkPNRjLpWEuljLwDXb7ZK7Kx3aDI
 Vc5cNSuuXX0tiZHrQojCNN2PDXETVMmRUWu3Ww19SowJpmVn1309g4ISkIylR+a6oN8rQWjSq
 U+a2pOMHlgqxcQvGROQP0rlQpBh0q0MSEeciLl9Sk8dWEN2JyE9e8eo01U5R1GNHAJvhjiRF9
 Tz/r/OJRrv+g9wf/pdandt5HOWJUN5MH8y7vH5SP1pxy77h/tgM3dtboYhgRWcjHfWMk0qqGc
 eqQnn/B5jbGukkYza8R76VnEfcgO8qOxbeQL7QDWx4wa7+vPBs=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598290563713613159?=
X-GMAIL-MSGID: =?utf-8?q?1598377705433134067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20.04.2018 20:23, Logan Gunthorpe wrote:
> Add support for io{read|write}64() functions in parisc architecture.
> These are pretty straightforward copies of similar functions which
> make use of readq and writeq.
> 
> Also, indicate that the lo_hi and hi_lo variants of these functions
> are not provided by this architecture.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge
