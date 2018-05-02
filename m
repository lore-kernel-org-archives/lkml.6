Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZonvp0RCcNgTjo+Cux63IOW9WUggdI9rcuXCdM87sunv9fpzY6v8GUJOqrD4pCkj87T0R1y
ARC-Seal: i=1; a=rsa-sha256; t=1525300552; cv=none;
        d=google.com; s=arc-20160816;
        b=wsNreUHxeAKxRirrxZNmifUgeD4BVejwtXG1oNPhrfNEDRGHnVxo4BrbBPlOQY2Tzs
         aAVsZuZys47MeWmuFdC5p/qAS1hpKvbZGS/ctCakhb97z5HTT8RtC5P9aKmsd+/C4bV8
         lti2I0ESAeZQ871ZqUR9lcBIDfqZEd6LCoBLJ3FfTuQMYVMjR9BICY+UkbFnAo+HFXFw
         OrrwmV7q+AVBb9uGrQw5vPZz6Ofu4DW6nxTRA/EDunz99vuehu5Z1moxfU1S2bTbENEJ
         TRtR+9z2NbaKGHYN6feZV6spAf3RvymxyuRfZ/pKtyuq9IGqxkHIwHsdZcxi2RwYhK3s
         qFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=AtgCAh0KubtLacvY9rIWyCDN/lYgwD6q/9pJSeBJFhM=;
        b=pJohQqXdVI1gPkBTGDzLgIzCZVXB+224JRALN7AMegC3GEqQwGqzi6ro8c3dDCUdqo
         ZQ7yW0CHld5k8LJRoUqI/W0tPROuaDELCBTrJp/WvmOPxxOSj9SNBPP29ojHOClXi397
         S7U06XRLXTAvB8iSQ1AhX3/lzx6baIzt6c9MYcyw9QX56+//q/B2QoZqP33g7KgH2LG5
         KAS8dU7oNKf2NAHGRfWj0lOvTzbdekwsVZxiSe2umX9d875xBV4w0azI9Pq9u2oy10Oi
         FWaqCY40HZkqnwjTQT4OCkIzZWUnFdJ1YV2kX2M8h1L/IZMvx9bdebW7ZN+MEt8sQk3z
         Yfxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU
 topology
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Will Deacon <Will.Deacon@arm.com>, Catalin Marinas
 <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <Mark.Rutland@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
 vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
 Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
 Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com,
 Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
 austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
 jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-12-jeremy.linton@arm.com>
 <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
 <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5078f4ac-74e7-aad3-1e0d-4de5da31d3c4@arm.com>
Date: Wed, 2 May 2018 17:35:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766328036390506?=
X-GMAIL-MSGID: =?utf-8?q?1599393552138990533?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/02/2018 03:24 AM, Rafael J. Wysocki wrote:
> On Tue, May 1, 2018 at 4:46 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 26/04/18 00:31, Jeremy Linton wrote:
>>> Propagate the topology information from the PPTT tree to the
>>> cpu_topology array. We can get the thread id and core_id by assuming
>>> certain levels of the PPTT tree correspond to those concepts.
>>> The package_id is flagged in the tree and can be found by calling
>>> find_acpi_cpu_topology_package() which terminates
>>> its search when it finds an ACPI node flagged as the physical
>>> package. If the tree doesn't contain enough levels to represent
>>> all of the requested levels then the root node will be returned
>>> for all subsequent levels.
>>>
>>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> [..]
>>
>>> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>>>         * Discard anything that was parsed if we hit an error so we
>>>         * don't use partial information.
>>>         */
>>> -     if (of_have_populated_dt() && parse_dt_topology())
>>> +     if ((!acpi_disabled) && parse_acpi_topology())
>>
>> [nit] not sure if extra () is need above,
> 
> No, it isn't.
> 
>> but I am fine either way.
> 
> The redundant parens need to go away, really.
> 

Yah, I missed this one, is there a linter everyone is using that finds 
these?

Thanks,
