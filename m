Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6206EC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3B520837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEraksgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3B520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933066AbeFUL1T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:27:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51072 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932855AbeFUL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:27:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so4574643wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+VQne2lbyafF92iYBoIRJ7IVFdARW2GwqUKGPlRXjgQ=;
        b=hEraksgYhcD41bTRHTHQd6Io1b3GYq/CRE2TkJGBptBB+FRMepxz4lMWMTun3D64H5
         gpR4UhsfKZgXqf84+2YiTbSOQXiPkII4U5IcH0NExwPv1JmyvmYrOIK+LKSj9OldHibe
         6QNt1/teRsaS8m5RrSfw5GV04G8FutdzNhBmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+VQne2lbyafF92iYBoIRJ7IVFdARW2GwqUKGPlRXjgQ=;
        b=EF6u/aOn8AzCWRiyffLpuniNseRJ35A9eyky4865pBMHEFV0KUxyh8gyC3kucYX3xn
         VPavseQqefhT3MSpulImItvWNntEQzzNHjYuVDBSLQypuAhyok9qrmW2OW6uLxjcI1PB
         SUcPY8gvt9HZbpb5z5eLWZ/dePRO6HytUFCItdDMIHWmpxqcnvCXFzVX7jeKhKt6he7+
         JUsYNhcIzprAkFmpSrVNXvNW0PAVkaZbK7ecpcESNQ7S5K73HXSDogtoSnC7bmLEKdcU
         HobqJVsA3HVtbebNCt5wXAGOfz4V34fht35cvcmfFrUQ/S6XbZOrmtZQ8FLJGALIG6X6
         hIbA==
X-Gm-Message-State: APt69E0AoBcHJTynS0I5w4MFhAjC1jNI1bs7OfRJxNxcaUwAnzVmCuML
        8uIR6uBDn2KaykumWbnl29MpAw==
X-Google-Smtp-Source: ADUXVKL/UTwqNDIOauLpbEz+qrA6sKj4gofp/NVulkex+EshZJKbvIXIeDrf0x91b54mGWSdpAKGfw==
X-Received: by 2002:a1c:2807:: with SMTP id o7-v6mr4537038wmo.11.1529580434879;
        Thu, 21 Jun 2018 04:27:14 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm7177568wmi.14.2018.06.21.04.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 04:27:13 -0700 (PDT)
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Vinod Koul <vinod.koul@linaro.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
References: <20180618141259.23141-1-vkoul@kernel.org>
 <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au>
 <966e9cd4-70a3-8d54-df0f-16df3df45fb5@linaro.org>
 <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <e39deb02-8fa4-84ac-b33e-d692402189a1@linaro.org>
Date:   Thu, 21 Jun 2018 14:27:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180621101506.rnklbtapvfdev4xb@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 06/21/2018 01:15 PM, Herbert Xu wrote:
> On Thu, Jun 21, 2018 at 12:56:34PM +0300, Stanimir Varbanov wrote:
>>
>>> Is this really a pseudo-RNG? If so it needs to be moved over to
>>> the algif_rng interface.
>>
>> Despite the register name (PRNG_ registers prefix) the IP is using FIPS
>> approved algorithm and we can claim that this is true hardware entropy
>> generator.
> 
> Whether your RNG is a PRNG or not has nothing to do with the
> algorithm you use.  No algorithm can generate entropy out of thin
> air.

OK, I just wanted to say that it is _not_ PRNG and the register names
gives us wrong impression.

-- 
regards,
Stan
