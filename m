Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2FA16C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAB520863
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 12:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5TAJjgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAB520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756109AbeFOMXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 08:23:43 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38486 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbeFOMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 08:23:42 -0400
Received: by mail-io0-f194.google.com with SMTP id l19-v6so10544091ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 05:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UXxx1FczAPdUqatoh53nERhVr5wb6NSsUiCtqgbJ2ao=;
        b=Z5TAJjgXUGZuS4tksn1YI0S31u4BdihJjOXTdnI6jZSkhvm+wCyCiuJ4iXzuZu/Vsh
         lxc+VP8/iAnLt98frt00egXzs2vAl1iZ24vOH2iLokpCLgtJEgbNsbafpCbTaFWGzp6n
         CnvZh6+mu8JIkO1yxVtvPcxH6gmzrlyO3S6orB4RqKi9byl3AWZB3NRKEUWcu9bpAjkS
         Qj4tMEL7UNRIlRhw5BTQVqA457X7pXED6WIESpTD7bTVpiRzbeLHqJGALuhmxpWclOzn
         DMBcARJZH/ng3fFhB3oAqmhAQP6ZSYnUL45PLX6/mfVmac6JBGV9m0pQIfMKwyHBjgiB
         wG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXxx1FczAPdUqatoh53nERhVr5wb6NSsUiCtqgbJ2ao=;
        b=PSig6XGEANogO18EZNy1vBOlcSiXGK3A9tu7ogGRQm9ogyqukQRt5Q5XCls8t2DU4k
         W7iuxZ7wVj7xzHrVwikrIBFUDo4uR1u7qeQ+pML5hu2vxfR2abxSifHirA4rOmJOyAU/
         SvTHT7hGKDgx2oNMQPyT/bPEMa1SzG8ulEF6Pv3GwtQ/17sSMm8/kc3BJyRWhzk8/mAQ
         SIBTmLWRxhdNLjmpOS1akw0O8n2E8/hEvHhxDT6AyWNBzr694Yjhb+eZjrC6wPvJBoGi
         +HYoErBz0g8gyc0fhXYdLMPjDKUF7qMJPEabZVhfAR1Im3t6o7bf2U2vIWOcyIdgSpCp
         nyHg==
X-Gm-Message-State: APt69E1w/AHR1irApOzEhJalmzD0i/2pVwNWGVZklaQEfJB0pOX2GaiE
        P5Dt3817BbDjNsPqDTVl+Md378AG
X-Google-Smtp-Source: ADUXVKK9vIQjfGcK7Yn1RnJJycrjNtp3IyzdZJMFamGRUMJv2NxK/3ebxi9NA0rAtR9vPUtkzPX4Mg==
X-Received: by 2002:a6b:bf01:: with SMTP id p1-v6mr1266167iof.67.1529065420876;
        Fri, 15 Jun 2018 05:23:40 -0700 (PDT)
Received: from [191.9.206.254] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id y13-v6sm2736686iob.53.2018.06.15.05.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 05:23:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] x86: x86_64_defconfig: Enable KSM.
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        x86@kernel.org
Cc:     anders.roxell@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <bc4cf4cb-e2b5-47c3-e29f-8ddf27a6a307@gmail.com>
Date:   Fri, 15 Jun 2018 08:23:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529016629-2948-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-14 18:50, Daniel Díaz wrote:
> As per the documentation, Kernel Samepage Merging (available
> since 2.6.32) is a memory-saving de-duplication feature,
> enabled by CONFIG_KSM=y and activated via sysfs. More
> information can be found here:
>    https://www.kernel.org/doc/Documentation/vm/ksm.txt
> 
> When enabled in the kernel, the default is to not do anything
> at all, until it is activated at run-time with:
>    echo 1 > /sys/kernel/mm/ksm/run
> 
As pointed out by a couple of others, this doesn't explain why this is a 
good idea.  All you're doing here is giving a reason that it won't have 
a negative impact on most users.

Two points that may be worth adding, but also don't really argue for it 
being a significant improvement:

* Pretty much all of the major distributions that use pre-built kernels 
have it enabled in their kernels (At minimum, Debian, Ubuntu, Fedora 
(and by extension RHEL and CentOS), openSUSE (and by extension SLES), 
Arch, and Alpine have it enabled), so enabling this in defconfig would 
bring it a bit closer to parity with distribution kernels in terms of 
core features.

* Software other than QEMU is starting to take advantage of it if 
available (for example, Netdata [1] can mark it's in-memory TSDB's for 
deduplication, which usually cuts it's memory usage roughly in half).


[1] https://my-netdata.io/
