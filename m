Return-Path: <deller@gmx.de>
X-Google-Smtp-Source: AIpwx48q+XupMlp77V1QL0Yb/W/wJkay60LPmCMf8nzhYaeEpHlnEYSd5ptmh/hNPn3AW8ge3bf8
ARC-Seal: i=1; a=rsa-sha256; t=1524248022; cv=none;
        d=google.com; s=arc-20160816;
        b=MeSirMDnGqlCbb6ahTrk5MoofebtNs2313zeOlm124RzxUXGm9X50uDh20Qiofc9ZW
         EuI5d/z+sIo2NUBK2XpF5/+Xy9iDgcSI3Ct8f/65K4qNL3+fFgtnEb0xB6kTDaIjYgNv
         4FDMcjvXS2J6RDhiSNU4yyAFnuSN4b22couAC5w09tBkmJFIPl2uvZxAm8pNU6hRqxX5
         ir3SnUoQwPcEhgUoJghwZulNB1f117sivc+YTMYB+FNKkDQRHZwnR2ScObALBfWljTrv
         zd3tkyjxrCA5rlViPNib3nK+U0uV1xKaEs75NHD7QOirgTMQXfWd9iJagGV6bqmHJT8R
         w/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=oBnh76Uhz6gH7jVmPat6uli+IY89dY52kv6wnnF4DEk=;
        b=WCF4xCNtRSk4hVCERI13V/6E2Qh7DN+wjeCjW0uNlBUUM8uTXGciZ813nU8eLdIusG
         3n4FA9d/Sp0BbDHIZ8Ug3/yh2N+2gnoK5dvg8fJP72rRN0w3HtedBMCTWurLqtduJR7H
         nBnmBa7kgj0SyMcQ+sD6cJ5KDNpAWJcNGEsf2SfJKy4Ju/1uoOeJRa4LioS3ZDNa+k5k
         XHbQ7dRmJwt2hVQfeWSgMLm0ESZHCRPNX9tMYPEzy5bkZhpiiX8RBzk762b/gm9mrJO0
         r8FVbDNkYPPxougf/srUohwRsuIOxWkHyNsJEMT/fwKXXOvRHk9+wyZGF/3sc0dZUp+D
         oy6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of deller@gmx.de designates 212.227.15.18 as permitted sender) smtp.mailfrom=deller@gmx.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of deller@gmx.de designates 212.227.15.18 as permitted sender) smtp.mailfrom=deller@gmx.de
Subject: Re: [PATCH] parisc: time: Convert read_persistent_clock() to
 read_persistent_clock64()
To: Arnd Bergmann <arnd@arndb.de>, Baolin Wang <baolin.wang@linaro.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 gregkh <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Parisc List <linux-parisc@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4914b33abd8969906d2db0ae5c3da4f205f0bfe9.1524120572.git.baolin.wang@linaro.org>
 <CAK8P3a0PWLG4XZEMU2XoYiKirdq1nnkOVTLyr=S59cxvNvHuTw@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <7a243faa-14c8-ec8f-9f98-cda6dc58d6b3@gmx.de>
Date: Fri, 20 Apr 2018 20:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0PWLG4XZEMU2XoYiKirdq1nnkOVTLyr=S59cxvNvHuTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZssoM/DGpvyoCkRg6jZSNYUgAdJ/pVNLMJnaVcdmw4UHM50Z95+
 EKGz7ILn/f93qEq18+NKSCDskMzWMvzsGrwTnAS+2MgtNBEQmcuyM0Z8dlA8yBhNO006I0o
 WjpzQM9bh1CAziusLZaejzWG45VuKMGY/3a17TwNW8yjP160GEZpfDRHjlTZGEt75ZQpo3d
 chCQEC5PUVuSDbP7yH79g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B4eahmyzBuc=:VjUjb4OroGUPa2hNvVF7ds
 O/ZHfA+Yo2K3VtTySyXhIkQcLIR6+3IKSPWnCRojaF4PxNGkcBaZ2jvliZyXFDXll4af+GMi4
 fdZ/yj3luFag1ScjM7sGHUED6XLxAm1bd1flxN1lifRIFZTJSOjao6ofaRQMM/m1hNp6jOBZV
 YMgntCqn+39k9HVCsykij2/1HwqpgVPwT79z2zsRKqRlOxUbYc809t+VQ0tUBOGDflV+OP2Rg
 Rj5XDfehGfukfdX2LG7rTy1I/szjoQy0XgWDvxzRDgZtaemlvEqy7wi/16bDKzmVs8TmUI6sN
 zB0MgJCmccGv8JMV+gm/8uddmcx9QMsir5+oKmRC04AbE7prnPfjQdo8s6rDSlzFfColh5XLb
 Wu9ATZ+qOqieXVNV4e9E4CNS2Kc8jxaSO/52GtlYPYVvyBTw5GXem1lABO8x/wyE9mE2ljzqf
 k2imcMxukpCBxwSFcbkUYpzsE40ir/8PQxTtVU7wz1NAF7X6XdaPMfBJeGxDfiA8L6dnZAq7r
 FUL8S7WlG2ndDC1V4sSmhoSUfqZjMPkBvk2poJzmQsLJGHqcUbkEc0kVVd2c9aNhkMUoZyuhz
 mH77mSsdRscFEjainyK31nHMtzktNlOVrcdxbPLu4RkNSiQyJRrOILL51apV475HiOnbPBAkR
 /rdpFR24ZGIOjp/Zy9LGsbaDX9NNs6aNODZ2l+DcQEwFVZVnaPxL828m/L4ZYRTGdJyvwBPd+
 3/W8KE/okwAfFdclH7eslxTVQ3Q4Hk5eRPaJnbzpiAdEohAge+dmrDqCXGfn91uFeBb/mPcO6
 KH3N89lf+PJB4wHP71szbXaNOAnY3gFdBZ65f8oULJtzaXp7/4=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598156395055112064?=
X-GMAIL-MSGID: =?utf-8?q?1598289894193075936?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20.04.2018 17:23, Arnd Bergmann wrote:
> On Thu, Apr 19, 2018 at 8:51 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> The read_persistent_clock() uses a timespec, which is not year 2038 safe
>> on 32bit systems. On parisc architecture, we have implemented generic RTC
>> drivers that can be used to compensate the system suspend time, but the
>> RTC time can not represent the nanosecond resolution, so this patch just
>> converts to read_persistent_clock64() with timespec64.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> 
> I have created the exact same patch a while ago but never submitted that.
> 
> If the parisc maintainers want to apply yours with my Ack, that
> would be appreciated.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I'll take it through the parisc git tree.

Helge
