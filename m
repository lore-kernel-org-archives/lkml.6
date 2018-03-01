Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELuFGjbBWaWPbZmt58OriI1CSQRl4RQvdI9lMRRqEblLBfBMusNlw2BalhmRQUJHg+A8f15+
ARC-Seal: i=1; a=rsa-sha256; t=1519905983; cv=none;
        d=google.com; s=arc-20160816;
        b=WqV6SuZhZML1ixy9e3LCTXZlKZ+olCIZhElbbdsjB1bvyV6mmIMxcfnYMr5F3UgSQW
         FkOefYhUMhaY7KRPDPvZBnfmPmPkI6OavVgFPNyvcoHnV1JYQd/D/Qj5gouKv8aOMV4n
         1Dx7b+lpTz6FgkHV48snQLnaRutBv204zXvGKNZu46EpAUryYJK7phellwoYVfupXvp+
         RsKT+FukmPzTIFLdbxzCSTEkLxAMU6akkCTTWcdjMS7+UABE9b1Dp0DcH2IdXtqjY9gB
         zkprydfZCi9S4HTrKpALXvYkyWR3q2eAMAw7uLMVNuNYyc0+Tm9z3pFsUI2BZZy+IhPf
         4taA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=c50YE5Nt9DeHFll5JKmiBkIQwjW/EKhUIK9V8kcDnHo=;
        b=UeG3zVXxUOGC5FlyGT9u7rSR6fkf+J5JM0mj1RLD359ehlEnk5WcXfHXjmAda5IeN3
         tykiXVIvts6n2KsvryYCcvfyov/Zq5L87gRjdDlIQEruJkqIqgkWsskP0xirQBR8/rH1
         Auhe24YDItofunLPXjFZahJgtx9I9yXLzv3+T25R5/BF1fBarZHqcbCvXBH3jFvDNSZq
         DfZL8DLaO+3PuDkRBigD5liDs/eTBQ3kKpl2zfgUbH3rH/eAI+PSM9MchZlk2kNezuyb
         IvA+puiv3dkLa+vBBtqVisnemezn1wnQv+xIGQOLqI4OGRIKOzWK3AexfLJAumys+bJj
         lyhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com,
 catalin.marinas@arm.com, gregkh@linuxfoundation.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 dietmar.eggemann@arm.com, morten.rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com
Subject: Re: [PATCH v7 00/13] Support PPTT for ARM64
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180228220619.6992-1-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <8b5bfd7e-57ea-bb34-85f8-69007a3847e6@arm.com>
Date: Thu, 1 Mar 2018 12:06:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684134324692162?=
X-GMAIL-MSGID: =?utf-8?q?1593736936986878742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeremy,

On 28/02/18 22:06, Jeremy Linton wrote:
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to describe the processor and cache topology. Ideally it is
> used to extend/override information provided by the hardware, but
> right now ARM64 is entirely dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the physical_id to the
> PPTT node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the
> system expects. To avoid inverted scheduler domains we then
> set the MC domain equal to the largest cache within the socket
> below the NUMA domain.
> 
I remember reviewing and acknowledging most of the cacheinfo stuff with
couple of minor suggestions for v6. I don't see any Acked-by tags in
this series and don't know if I need to review/ack any more cacheinfo
related patches.

-- 
Regards,
Sudeep
