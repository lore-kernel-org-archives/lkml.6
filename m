Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525336904; cv=none;
        d=google.com; s=arc-20160816;
        b=eEaoJDUbjUPy+QC8A9N+RtTJCMpyLz98iKRpYQgpYlGp+SVw7Rky82VQov8az+jMKo
         7Kh3fgB3WSNlXdzZ1eYoexl7aeWPocaRNQdErpIQIrD748nO1L22TaRDsF7mQUcg3gTf
         Lz45T4OHIB4yUb/1d1H9alTGAU8zSFhR6lhOBmuqb13ARHxDk9tfth8zVU0MIlNKb6gs
         eaIEg0ECVeLt7ZHUWziEGBDzQWOi+3rWpFVjGOWRqSiBi0fBew1fCE8AvfkjBHHQu2YF
         8qodw3NcWvvRcN+TYi/8ZyRWdizm4d9KTsJ1jmpIBv/1XeGhWCZyZlwD16xRugbx7+gH
         vzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=a910oCrvk/1P+yfZ1kqOsXUrxfQE+hXR7cfc825rAyo=;
        b=JIvkmODPMCHqcwo1y1b1VFintifGxljWv+n0FpYLF6l84W4NDWRfoIKzKHVV8Zm3EO
         HfflSUBUeDXUj7PdJ9QwKdbkL16Q4u1M/Mco5f1FwyF5s/R4x0oLwTFhJiNU4nYnnYB4
         wfvyYwceVu6Y3hO7buSW999FKDnQXx91J57iIfdidRSjuaOQ7jRa2xJxdwwX0MMji3DZ
         YVK/lufm5kSDk1JD3+lpcUq2r7AA2iYJPrLxHkjYc41sh43Xlcewr0QdUJholXg9pnhL
         Z0aKwbMXj+Hc+W6+t8WgWq2j0W2eit12xBS/nK1F8EQ8mk9yFwAAJZcExz9hb78pyoRH
         QjHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ncnDeoaH;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ncnDeoaH;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AB8JxZptAErWNbGscH3WoCZgC3L1AwVhP2+cpSA4UOsL6WE00i+exRX3IKR4fLpFHYMaQ8PI5Dl8TZF++rDEbFaGF+o=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <5078f4ac-74e7-aad3-1e0d-4de5da31d3c4@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com> <20180425233121.13270-12-jeremy.linton@arm.com>
 <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com> <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
 <5078f4ac-74e7-aad3-1e0d-4de5da31d3c4@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 May 2018 10:41:43 +0200
X-Google-Sender-Auth: 8UZflTPXP8pmfYvFXDJE5Ffun4M
Message-ID: <CAJZ5v0iiWd0eET0iuj4RZuaQ4T12W-H775SEd0CFG5hK9+q9WA@mail.gmail.com>
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU topology
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
	Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com,
	Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766328036390506?=
X-GMAIL-MSGID: =?utf-8?q?1599431669424003652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 3, 2018 at 12:35 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
>
> On 05/02/2018 03:24 AM, Rafael J. Wysocki wrote:
>>
>> On Tue, May 1, 2018 at 4:46 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>>
>>>
>>> On 26/04/18 00:31, Jeremy Linton wrote:
>>>>
>>>> Propagate the topology information from the PPTT tree to the
>>>> cpu_topology array. We can get the thread id and core_id by assuming
>>>> certain levels of the PPTT tree correspond to those concepts.
>>>> The package_id is flagged in the tree and can be found by calling
>>>> find_acpi_cpu_topology_package() which terminates
>>>> its search when it finds an ACPI node flagged as the physical
>>>> package. If the tree doesn't contain enough levels to represent
>>>> all of the requested levels then the root node will be returned
>>>> for all subsequent levels.
>>>>
>>>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>>
>>> [..]
>>>
>>>> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>>>>         * Discard anything that was parsed if we hit an error so we
>>>>         * don't use partial information.
>>>>         */
>>>> -     if (of_have_populated_dt() && parse_dt_topology())
>>>> +     if ((!acpi_disabled) && parse_acpi_topology())
>>>
>>>
>>> [nit] not sure if extra () is need above,
>>
>>
>> No, it isn't.
>>
>>> but I am fine either way.
>>
>>
>> The redundant parens need to go away, really.
>>
>
> Yah, I missed this one, is there a linter everyone is using that finds
> these?

I'm not actually sure.  At least I can't recall any right away.
