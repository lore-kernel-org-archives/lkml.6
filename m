Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE706C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDDC20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 20:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJxopnUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDDC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeIFAk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:40:27 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38330 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIFAk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:40:27 -0400
Received: by mail-qk1-f195.google.com with SMTP id g197-v6so5789580qke.5;
        Wed, 05 Sep 2018 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u8KG/K3ouVmbrEcrbbZBzn5HA653GFFakFqhXccE8qo=;
        b=FJxopnUet+W5p1qUdRQRX4spr1E83dGM6OmkfmyAxt/2prRLbosLRCIG2oco/3rv7k
         NfZHAYy9aMe9N/z0jCtyE3ZiqIEFOQuAER6mcQmqDCt7P4OzAtWtmEupXKSBHXnKmq0v
         UwW+NUkTEKkOlHIIbqB42c+gybHlq8ZRHRfrxd0lewpaXLwBw5l5CuApIKkt37R+Ce+p
         Ip3QpLt6cqo9HESt/9DX/lEmvEWZLBxh2qlKy+y0Gx2Li7zN/aLTc0L5YbLjjja4/eQz
         moJ7oPfVMZN47HsAmGbNQO9c1I6ZYcCh+zVSy3nRyrtoQyaeR05y6oKVsYVhsp3sw+3l
         4VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=u8KG/K3ouVmbrEcrbbZBzn5HA653GFFakFqhXccE8qo=;
        b=bKXro2Dkj26U9XEn7JyQ24snWfTOtT8SBTjRulEFdzLkp1Bb78llkTaPJStF++F+no
         9omJv+XL/x2iSLjrnd2Nvx+OrzZNq4nAP1c1eg/82CAg/zaqjawrZ/Mvj90WvGZldkud
         P2eSS/tHTlZUA2bSiSxUurKyQP/3EeeN4Hi2WvyvLStTlU8UysnqSAALMOmlzGBbyYsg
         RFAaZ5v4EdSLInSck/CMawKOQ4BRojdCvUn4t0u5Ouz+b5SgMvGY3s/SVULxsYu57roU
         gJq2hJ14S/EjsdOoGTDBP8YO5wpjZMYqqayGhd48XPOVw9z2PXEi5Uq6eEjakox80qQt
         AsqA==
X-Gm-Message-State: APzg51AmuAlu1r7UX71b9Vg6s4m26df8dIMd8NKTfgTXkjMYDzwYElR1
        rXE/if74+nYkavaPCQbKqaQ=
X-Google-Smtp-Source: ANB0VdYAn9w3LSe72osNPod2X+RObBEkoPzLx7kI52iZF2T6pV8PruNGzhtkISzeEhGBFT0A4u1JeQ==
X-Received: by 2002:a37:e216:: with SMTP id g22-v6mr34273373qki.61.1536178120989;
        Wed, 05 Sep 2018 13:08:40 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id x32-v6sm1934847qtb.70.2018.09.05.13.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 13:08:39 -0700 (PDT)
Subject: Re: [PATCH 4.9 52/66] Revert "perf tests: Decompress kernel module
 before objdump"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        stable@vger.kernel.org,
        Pavlos Parissis <pavlos.parissis@gmail.com>,
        Lei Chen <chenl.lei@gmail.com>,
        Maxime Hadjinlian <maxime.hadjinlian@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20180417155648.152933169@linuxfoundation.org>
 <eff5b3dd-5a43-a424-d32d-b9065fd6424c@broadcom.com>
 <20180905192954.GB13608@kroah.com>
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
Message-ID: <22024334-b52c-2f79-4b99-6eace998d0e9@gmail.com>
Date:   Wed, 5 Sep 2018 13:08:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905192954.GB13608@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 12:29 PM, Greg Kroah-Hartman wrote:
> On Wed, Sep 05, 2018 at 11:50:02AM -0700, Florian Fainelli wrote:
>> On 04/17/2018 08:59 AM, Greg Kroah-Hartman wrote:
>>> 4.9-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>
>>> This reverts commit 7525a238be8f46617cdda29d1be5b85ffe3b042d which is
>>> commit 94df1040b1e6aacd8dec0ba3c61d7e77cd695f26 upstream.
>>>
>>> It breaks the build of perf on 4.9.y, so I'm dropping it.
>>
>> Sorry to hijack this thread, I was not able to find the original email
>> when the offending patch was included in 4.1.52. So kernel 4.1.52 also
>> has the same problem, can you push a 4.1.53 tag with that patch reverted
>> as well?
> 
> 4.1 is long end-of-life now, I'm not going to be going and updating a
> "dead' kernel for a perf build bug.

Meh, fair enough, I reverted the offending commit, it still points to a
more fundamental problem, there is not always build testing of the tools
being shipped with the kernel unfortunately.

> 
> You shouldn't be using this kernel either :)

Fortunately 4.9 is what we are mostly using these days, still getting
occasional 4.1 kernel support requests unfortunately...
-- 
Florian
