Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CEBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD732174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIYRvwIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD732174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbeHTWoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:44:46 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39909 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:44:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id j201-v6so512010lfg.6;
        Mon, 20 Aug 2018 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hL89Ql98CrjJjurml443i61Z2zwUkGv5eEqXqLMcpsg=;
        b=dIYRvwItf3NjV1lS9ZIhH9n12cmnYcipqZut2wCipEPdlG2oytl9y+R8TjICXzjAsR
         uBeNUMz4lIDWGDr5nCHSX/JUm+UR8n6YuH3Y+KTAzGQrjbA11WMA6lmTOLec/sop87MW
         o65l/O5tQ4k3pDpyCdwhj27Ht5fqa43a8PnWgZ4yNGC4gm1by3kTEqFVXH9VfzdShfM7
         Cmuq//UgfyBNGwuOroYTZy6IV0CJ8geqIcMHit35dT6qkttnVOFTa5467s7esTYhS7+o
         FcwU6eCESyJGGrLwmEghQekLQo04lSyQ/LYRp4RXw4jBF+yNWOr51oWsak1hdgxMnVWM
         SHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hL89Ql98CrjJjurml443i61Z2zwUkGv5eEqXqLMcpsg=;
        b=qBvuIyTS17PNQN+o+Vw5bIjH0hU3lAZ/mnZCXlUAtpy9PbEbulizhmwo5Q3C0nGUEj
         sDBcymdKUlgWA7PN/48FZfQPFMd39qNwoneSQnuYQvdthVvP9KZQN35l3N5J9OmwTNL/
         wtgDj0MMMLP43bmRMg/z921xQmRbPpSkW9NJiKPtLsZ1zLXdWPwsWGOI3J5ItI7cpi65
         IONntkpA1U0J1Da8tGKk6cmmISmmtrGAAFVl6COEAQ3T1pRZbXYMjoJE65uhUg/V4kl6
         zq/DtC192jTF5HNthFNKrahfbtmDnHC3CbSP3Hq93HfPjSmy7jwSJKKqQtgEMGIcjUL6
         2/7g==
X-Gm-Message-State: AOUpUlHeD4e9YqpR3eRuioTSGMi4NCiAjAA3lOEmlivkA/KhsePCKM4o
        FTz1jLDjw0En0XSTptyH2DKFumPq
X-Google-Smtp-Source: AA+uWPyjBxQFS1MRh0QvOu9QGTGmBrHuhUMhAz2jmhRXd+LwaFWbPlL9UXWxdhCORHbdcsw7+U2wCw==
X-Received: by 2002:ac2:4141:: with SMTP id c1-v6mr6451593lfi.11.1534793271964;
        Mon, 20 Aug 2018 12:27:51 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.90.13])
        by smtp.googlemail.com with ESMTPSA id u86-v6sm1923125lfi.90.2018.08.20.12.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 12:27:51 -0700 (PDT)
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: tegra: Squash tegra20-gart
 into tegra20-mc
To:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180818155430.5586-1-digetx@gmail.com>
 <20180818155430.5586-7-digetx@gmail.com> <20180820191209.GA28618@bogus>
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
Message-ID: <b46cac22-9b31-9aa7-7eca-4725156346bb@gmail.com>
Date:   Mon, 20 Aug 2018 22:27:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820191209.GA28618@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2018 22:12, Rob Herring wrote:
> On Sat, Aug 18, 2018 at 06:54:17PM +0300, Dmitry Osipenko wrote:
>> Splitting GART and Memory Controller wasn't a good decision that was made
>> back in the day. Given that the GART driver hasn't ever been used by
>> anything in the kernel, we decided that it will be better to correct the
>> mistakes of the past and merge two bindings into a single one. In a result
> 
> As a result...
> 
>> there is a DT ABI change for the Memory Controller that allows not to
>> break newer kernels using older DT by introducing a new required property,
>> the memory clock. Adding the new clock property also puts the tegra20-mc
>> binding in line with the bindings of the later Tegra generations.
> 
> I don't understand this part. It looks to me like you are breaking 
> compatibility. The driver failing to probe with an old DT is okay?

Yes, DT compatibility is broken. New driver won't probe/load with the old DT,
that's what we want.

> OS's like OpenSUSE use new DTs with older kernel versions, so you should 
> consider how to not break them as well. I guess if all this is optional 
> or has been unused, then there shouldn't be a problem.

That's interesting.. Memory Controller isn't optional, I guess we could change
compatible to "nvidia,tegra20-mc-gart".

Thierry, do you have any other suggestions?
