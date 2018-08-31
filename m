Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2504C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADD32083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDv/ei/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADD32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeHaNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:52:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43312 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeHaNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:52:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id m84-v6so9560792lje.10;
        Fri, 31 Aug 2018 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWgrEHp2Hm+Otn13AJo1op+yiR29O836I0b63Ezz5TY=;
        b=KDv/ei/sIJIYlgb4PvljxYyJcHRocUrghxzGhIff30R0R/sPzKlz1eWpodF3ktyn7+
         oJzFrVghILlbXbcuUyARdA5aI8N26X+E+hgpAOOGByoJnX+DpaVHQ+biuKNBjF34CR0C
         HJDwseY+qfxDmmZllpdhGkfxbHtOq+lBJPRxdba6GcAPvvx58C5xwTB5z1k306eeJAuH
         /tWYKXW0KgX7qNziA9sn5aqlDqP4BrKtGk6UHry0KrTkCjhcgz0hSxcWBwiInw5nBz8Z
         +pxZMQm98p90T2nHPqh+gzTOdc8+OBfinczp39YTXd/brmF57hKnDXKCeamThPKwVY3J
         0dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sWgrEHp2Hm+Otn13AJo1op+yiR29O836I0b63Ezz5TY=;
        b=ZIIjFw66hn8DKERDahZNLZmcWnjRADMlY9qigy1Q3m16OtYvwhYokjskd8CA4WfnhA
         x2YRiCTkJfaMHnlf+FCYItTgXbcbBa+fNHTz4TIg1UF/PpCVghldRogAi56rFwLw9MOd
         CQXNhdrMKQcscqu2Bd+RLjsqEzxmN2dOvVlDy2rPkOt9yzkV5MQZTfyk65LXHlJZtwg4
         Ibm02dAB9AzmLFbq0tScxRb1zZmTpZfPTaaG86GBRBwh67CkfOz8wXk1PGq2ti6tutay
         MPX20tERq9SeJWnFpxwfYZZhUGotaGE2ZeH7I6Ta5lgTXyHj4KDdBVKHD5tfSYhF2Iv1
         qZ5A==
X-Gm-Message-State: APzg51Duv7hTavybO1T/L514qZCC64hIVb7qisUAmHqIxe8yfDM0xfRD
        2iH0ODO3eiV5Di0b9Qwi0Jf1/iiP
X-Google-Smtp-Source: ANB0VdbXsn6C4txVEFZwYvKZ4nQ3HBQSaLTOB3Kh7exM2zc/aWM/la67s/HOKqt8tewlRIGUZ9NsjQ==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr9434673ljt.8.1535708719301;
        Fri, 31 Aug 2018 02:45:19 -0700 (PDT)
Received: from [192.168.2.145] (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.googlemail.com with ESMTPSA id m22-v6sm1795665lfc.44.2018.08.31.02.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 02:45:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830184210.5369-1-digetx@gmail.com>
 <20180830184210.5369-2-digetx@gmail.com>
 <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
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
Message-ID: <909e2a52-4116-9ee7-db23-8ea1dfffade0@gmail.com>
Date:   Fri, 31 Aug 2018 12:45:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/18 12:29 PM, Peter De Schrijver wrote:
> On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote:
>> Currently all PLL's on Tegra20 use a hardcoded delay despite of having
>> a lock-status bit. The lock-status polling was disabled ~7 years ago
>> because PLLE was failing to lock and was a suspicion that other PLLs
>> might be faulty too. Other PLLs are okay, hence enable the lock-status
>> polling for them. This reduces delay of any operation that require PLL
>> to lock.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>
>> Changelog:
>>
>> v2:	Don't enable polling for PLLE as it known to not being able to lock.
>>
> 
> This isn't correct. The lock bit of PLLE can declare lock too early, but the
> PLL itself does lock.

Indeed, it locks but can't be polled for the lock-status as it doesn't have the
lock-status bit.

Do you want me to adjust the commit description or it is fine as is?

It is also a bit odd that PLLE has "lock_delay = 0", is it correct?
