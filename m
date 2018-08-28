Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A98C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D759020897
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9RzLIse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D759020897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeH1RAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:00:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36518 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbeH1RAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:00:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so1330481edq.3;
        Tue, 28 Aug 2018 06:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x2+AoSWpwUx7JN5dxFBp6o7zKMYNDR/Z0YJR35uQPrU=;
        b=U9RzLIse/sx4NT0D8bR0RyrZUwRxd37E4smYTnuPtln8/wWqNvDIaAqtxYIsmHdRpn
         8YRxc0nlgSGIZ93f33xdM1lp/uHl+x92NKDw2HzbcYT++tWXiC8Z6AjotBzHu91jNnkb
         Z/OnXzs/dVo/5+sLKkFo6uGHpFrT1Y9jASpJBZp9sQnZWh6SdtymCZ7aS7dUmrK/1Vo2
         dO3RNiawyoScTHT/e8xRCvzMf77ATQXSnF9afuevvoKp8KCAujtYB/vWWlzxeqRyD0ak
         EBYk43W0siSXLkq7TuwNENIV+Ko+aNPqvhvfrGxhfzr+G+49CpO0/G5Yw+PByfTtEXC3
         7mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=x2+AoSWpwUx7JN5dxFBp6o7zKMYNDR/Z0YJR35uQPrU=;
        b=EgyF06DVQvEh1oISigetGDKfNfviDcpNLZLeIRH1fvKyKiYvf9GEUuronqBN8vI02/
         JWTYD5VEY1YJheDCGZ2P6YwJR4wbRju9YqrcABMcHMGXyXYNO+XfLE7ESlEnys66VkvN
         vfi1D+rkDY19BYW5Az4b5z6J+N7b2ZW5mIowzpdFDQt3zx4wvTRAdbD8QDp8Nrf0Zz4t
         aNs0HYs6aO5S3x/r15Jcy1C195DLICzpGqnWNleJjkmUjQF0NyzSX635eNPl0kcYyg2L
         yqqHXOJ8cn/5mUtThSr/Pzdngy4KMH5XQG5OpJmSmwBxfRWH19DKU1GHrC0SOw23Mto/
         oT8g==
X-Gm-Message-State: APzg51DkRu1GH7Ef3bWaH1uQlHfH1l9Otbyy633CoBLuC09ntTzM0LKY
        zdGCgi/PkOX1USxFtiMjOYdc7vCL
X-Google-Smtp-Source: ANB0VdYXWEc7qdCPSPXSMzeCVL7YaONIApHGlRYSezalh+ehf9dKueiwGqUVy/CBjFc+1+r3DVqanw==
X-Received: by 2002:a50:97ba:: with SMTP id e55-v6mr2412679edb.58.1535461748602;
        Tue, 28 Aug 2018 06:09:08 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.90.13])
        by smtp.googlemail.com with ESMTPSA id b58-v6sm687874ede.37.2018.08.28.06.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 06:09:07 -0700 (PDT)
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180818155430.5586-1-digetx@gmail.com>
 <20180818155430.5586-7-digetx@gmail.com> <20180820191209.GA28618@bogus>
 <b46cac22-9b31-9aa7-7eca-4725156346bb@gmail.com>
 <4538309b-fcb3-73ee-04e3-6cefcedd376d@gmail.com> <20180828104755.GC9386@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=digetx@gmail.com; prefer-encrypt=mutual; keydata=
 xsBNBFpX5TwBCADQhg+lBnTunWSPbP5I+rM9q6EKPm5fu2RbqyVAh/W3fRvLyghdb58Yrmjm
 KpDYUhBIZvAQoFLEL1IPAgJBtmPvemO1XUGPxfYNh/3BlcDFBAgERrI3BfA/6pk7SAFn8u84
 p+J1TW4rrPYcusfs44abJrn8CH0GZKt2AZIsGbGQ79O2HHXKHr9V95ZEPWH5AR0UtL6wxg6o
 O56UNG3rIzSL5getRDQW3yCtjcqM44mz6GPhSE2sxNgqureAbnzvr4/93ndOHtQUXPzzTrYB
 z/WqLGhPdx5Ouzn0Q0kSVCQiqeExlcQ7i7aKRRrELz/5/IXbCo2O+53twlX8xOps9iMfABEB
 AAHNIkRtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT7CwJQEEwEIAD4WIQSczHcO
 3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
 gAAKCRDTNNaPsNRzvFjTCACqAh1M9/YPq73/ai5h2ExDquTgJnjegL8KL2yHL3G+XINwzN5E
 nPI7esoYm+zVWDJbv3UuRqylpookLNSRA01yyvkaMcipB/B128UnqmUiGRqezj9QE20yIauo
 uHRuwHPE2q+UkfUhRX9iuOaEyQtZDiCa0myMjmRkJ+Z8ZetclEPG8dYZu47w04phuMlu1QAt
 a0gkZOaMKvXgj21ushALS6nYnvm7HiIPQXfnEXThartatRvFdmbG4PCn0IoICkQBizwJtXrL
 HEjELIFap0M8krVJlUoZTFaZnaZkGpUDWikeFtAuie2KuIxmVBYPM4X7pM3eP3AVvIPGS7EE
 UUFuzsBNBFpX5TwBCADFNDou220thijaLLGaQsebWjzc/gPRxMixIpk856MRyRaQin+IbGD6
 YskMb5ZSD3nS88LIKNfY4MMH0LwfYztI++ICG2vdFLkbBt78E+LqEa+kZ9072l4W5KO3mWQo
 +jMfxXbpgGlc7iuEReDgl8iyZ27r51kSW665CYvvu2YJhLqgdj6QM1lN2D1UnhEhkkU+pRAj
 1rJVOxdfJaQNQS4+204p3TrURovzNGkN/brqakpNIcqGOAGQqb8F0tuwwuP7ERq/BzDNkbdr
 qJOrVC/wkHRq1jfabQczWKf8MwYOvivR3HY8d3CpSQxmUXDtdOWfg0XGm1dxYnVfqPjuJaZt
 ABEBAAHCwHwEGAEIACYWIQSczHcO3uc4K1eb3yvTNNaPsNRzvAUCWlflPAIbDAUJA8JnAAAK
 CRDTNNaPsNRzvJzuB/9d+sxcwHbO8ZDcgaLX9N+bXFqN9fIRVmBUyWa+qqTSREA4uVAtYcRT
 lfPE2OQ7aMFxaYPwo+/z5SLpu8HcEhN/FG9uIkfYwK0mdCO0vgvlfvBJm4VHe7C6vyAeEPJQ
 DKbBvdgeqFqO+PsLkk2sawF/9sontMJ5iFfjNDj4UeAo4VsdlduTBZv5hHFvIbv/p7jKH6OT
 90FsgUSVbShh7SH5OzAcgqSy4kxuS1AHizWo6P3f9vei987LZWTyhuEuhJsOfivDsjKIq7qQ
 c5eR+JJtyLEA0Jt4cQGhpzHtWB0yB3XxXzHVa4QUp00BNVWyiJ/t9JHT4S5mdyLfcKm7ddc9
Message-ID: <80ab7d8c-8172-2521-2eda-a235bfcc2824@gmail.com>
Date:   Tue, 28 Aug 2018 16:09:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828104755.GC9386@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2018 13:47, Thierry Reding wrote:
> On Mon, Aug 20, 2018 at 10:35:54PM +0300, Dmitry Osipenko wrote:
>> On 20.08.2018 22:27, Dmitry Osipenko wrote:
>>> On 20.08.2018 22:12, Rob Herring wrote:
>>>> On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
>>>>> Splitting GART and Memory Controller wasn't a good decision that was made
>>>>> back in the day. Given that the GART driver hasn't ever been used by
>>>>> anything in the kernel, we decided that it will be better to correct the
>>>>> mistakes of the past and merge two bindings into a single one. In a result
>>>>
>>>> As a result...
>>>>
>>>>> there is a DT ABI change for the Memory Controller that allows not to
>>>>> break newer kernels using older DT by introducing a new required property,
>>>>> the memory clock. Adding the new clock property also puts the tegra20-mc
>>>>> binding in line with the bindings of the later Tegra generations.
>>>>
>>>> I don't understand this part. It looks to me like you are breaking 
>>>> compatibility. The driver failing to probe with an old DT is okay?
>>>
>>> Yes, DT compatibility is broken. New driver won't probe/load with the old DT,
>>> that's what we want.
>>>
>>>> OS's like OpenSUSE use new DTs with older kernel versions, so you should 
>>>> consider how to not break them as well. I guess if all this is optional 
>>>> or has been unused, then there shouldn't be a problem.
>>>
>>> That's interesting.. Memory Controller isn't optional, I guess we could change
>>> compatible to "nvidia,tegra20-mc-gart".bled in kernels config by
>> default and driver is functional, but it's okay 
>>
>> * I meant it's not optional in a sense that it's enaif MC driver will stop to probe
>> with older kernels as it is used only for reporting memory errors.
> 
> Yeah, we don't really regress at runtime. The errors reported by the
> current driver are very rare, and even if you encounter them, they're
> pretty cryptic, so I think this is one of the exceptional cases where
> breaking the ABI "for the greater good" is acceptable.

It's now became apparent that factoring out EMC from MC isn't a good idea too
because MC need to interact with EMC and probably vice versa. Looks like we
should consider restructuring MC for all Tegra's.
