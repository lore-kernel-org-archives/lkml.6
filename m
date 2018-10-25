Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFEDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEDE20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkZvV9Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEDE20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeJZBxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 21:53:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43047 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbeJZBxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 21:53:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so4160609plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pEfABltU7vYm5S0hDIPXm2W3dLw5de7ieA4PWnHAd3s=;
        b=bkZvV9NtyyjaGTWFtvEI1rBL2g5nhjl5Nip3aK+/pEtewSWgnJrbs+OtJMhrciUXYc
         xswx/TRR7MZ2oildK3u9xnI/bafkQ0fgQgwB8CGMz+Osrh4GxQ3E5WpJ1QJhIoK8YLcd
         vALxs+v/8mAVNiPI0QOROYybc6XPZh76h0hu8RnI0eyepTiiN06IZpT7HHwPMg4m/275
         ZeieMcjSKJOSvd3xDW6N8o+3SmvC7NPy7TOYwJUmvVSraLWLTynG9xab/5c3FRGGlF0U
         aXQTynsES7SPI0NIHyufO2OovIlmlPCxsdWuUKdIQkkf1uKlJShQzSkab3bZh4K1VOGs
         qX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pEfABltU7vYm5S0hDIPXm2W3dLw5de7ieA4PWnHAd3s=;
        b=eqNXSt94SOXN9EMdTWFIatOtjpwDt52AxIsuc27VgjuU5UrU8abH6Sd/s5311wGTu7
         +nKGoNfHjuQZTwGNA4fKehavK/4kZ0bzLF/iBrp1F54Zj2RUzfBgLlS0ryOq4XRFAvSL
         DjjUugct4nnib7fA8kOfTRrsgEX/mBtAKJ0NQk6xSOQWYjhtBlPB2I6J2Hd6e+6vcJeB
         OFTEoCYJG97q4C/jw6R+QzZVMvSPbiLT7HJvzNfzM5DS2HyWFNUqts1utN8azNccvv0j
         UFwhFdCDA7MoPX1+BzG+BXbsOI3DHyykzS+Mpfwr+wJuSS6/GMa+Y5/Kx30PI2p0MVjR
         8EoQ==
X-Gm-Message-State: AGRZ1gL5kxq0us1qOYy6dwkMoUsB65M2eWGF1mndFHf7ho5Atv9k5vk9
        SggFklmTdDSnsT3h1ujRijI=
X-Google-Smtp-Source: AJdET5dk9GOjbLZYS2B0LNvWllIwbMV/YFrpanv92s1YkgHSNdzRflftNkhl/eBkmkIePI7qyTy7cg==
X-Received: by 2002:a17:902:54d:: with SMTP id 71-v6mr113218plf.80.1540488003183;
        Thu, 25 Oct 2018 10:20:03 -0700 (PDT)
Received: from [10.67.49.121] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x36-v6sm7254226pgl.43.2018.10.25.10.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 10:20:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        rmk+kernel@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>, l.stach@pengutronix.de
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com> <20181025021013.GA30116@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
Message-ID: <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
Date:   Thu, 25 Oct 2018 10:19:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181025021013.GA30116@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/18 7:10 PM, Andrew Lunn wrote:
> On Wed, Oct 24, 2018 at 05:09:05PM -0700, Florian Fainelli wrote:
>> perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
>> independance with respect to the ARM CPU being used. Add a test which
>> tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
>> turned on to help asses the system's health.
> 
> Hi Florian
> 
> I've suffered the pain from missing CONFIG_KUSER_HELPERS. The
> segfaults give little clue as to what is going wrong,and gdb is not
> much use either.

If you have a working backtrace, you can typically see the virtual
address being in 0xffff_xxxx which gives a bit of a clue, but yes, this
is not particularly helpful.

> 
> What i don't see here is any clue to CONFIG_KUSER_HELPERS. If the test
> fails, could you print a message suggesting CONFIG_KUSER_HELPERS on
> ARM?

Sure, sounds reasonable, thanks for taking a look.
-- 
Florian
