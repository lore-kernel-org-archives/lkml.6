Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525249454; cv=none;
        d=google.com; s=arc-20160816;
        b=05EomUXYhwyXt6n4z67oPKeR3huhTsaNJNo4BXCoUgRQ9a9KduJm1UvdR+rjIQ7qEl
         aRW7X3fwHFQPnGJVGIgA0qGV/p3rxKyICZRhdNw8yw2Jz7hJb5SHW03N8gg+2KNSelLw
         4mmPueGEu2ynG3e36zz+HPoIuOQhY72oS9/0/4BQvOr2Bk/qHqx1jmYCk2mmRw8ZENTu
         9wnu8lNiBiacR874crncrOPFaQbvkxxtpmSZuO2lx1tJhaBb9+gSXBIZjqIHMhyzuTOF
         +833J6epCxq2hF844Ff5ciZJFlJ0LLCqzIJCI5XLIJ6MNVm79Hqhql7TSfuCm90fVEkX
         AECA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YB4k2kQ7dqgXWvo2sQvH4wpdLxwjjbqOmTVHYxIe0zw=;
        b=sCL1h4QOBlClIzW/VGuUnmVH6Y5VmUAi8PvjIkDP+DxITgFYAadjYY0fQy7bsxeMlP
         bQqbRJUk5qFIjjOfBeMsss2zejbI53tleoWyUlOgeUcVfYirW6G9IaAZnTcG3Qep/maY
         1Z0lovTxwW+zJ9o28L7mU5GKberiboRvH+tzIlBHm24PGnBgjTeT8DlxRSxcdOQsAurb
         YR3o6WZ7xnBt/NoLoM4Dgh/BpUbLR90ERVyiL8DFbJu58dsEZ5tn6QujpfqoKusOJv0A
         /IxJvcdmPgukCrz13BpSmRl9M0crK3M4LIYJdZ6tZ0X0nnQL8Kc3hC+HfD+tQaz4cquu
         LbTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dJMZxHfV;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dJMZxHfV;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AB8JxZp9Z+NRSlYlY/uakmpuy5Rf4GRH9wQySOZ8fMmrnVT6Yv9TLSbLjDnI9uRRo/kseBmCc9LiOoI/rcUuYBnAXR0=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com> <20180425233121.13270-12-jeremy.linton@arm.com>
 <ab8357f0-61d5-2996-46ca-5bc5d3e097cf@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 May 2018 10:24:14 +0200
X-Google-Sender-Auth: eDUwdnTEj72kYdBEr3yfvl6xZWY
Message-ID: <CAJZ5v0jwtSkw1x+MQVYo60YDeW0+jxLy2d4spQOu+i=pY7fjyQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/13] arm64: topology: enable ACPI/PPTT based CPU topology
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
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
X-GMAIL-MSGID: =?utf-8?q?1599339972119607679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 1, 2018 at 4:46 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 26/04/18 00:31, Jeremy Linton wrote:
>> Propagate the topology information from the PPTT tree to the
>> cpu_topology array. We can get the thread id and core_id by assuming
>> certain levels of the PPTT tree correspond to those concepts.
>> The package_id is flagged in the tree and can be found by calling
>> find_acpi_cpu_topology_package() which terminates
>> its search when it finds an ACPI node flagged as the physical
>> package. If the tree doesn't contain enough levels to represent
>> all of the requested levels then the root node will be returned
>> for all subsequent levels.
>>
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> [..]
>
>> @@ -304,6 +345,8 @@ void __init init_cpu_topology(void)
>>        * Discard anything that was parsed if we hit an error so we
>>        * don't use partial information.
>>        */
>> -     if (of_have_populated_dt() && parse_dt_topology())
>> +     if ((!acpi_disabled) && parse_acpi_topology())
>
> [nit] not sure if extra () is need above,

No, it isn't.

> but I am fine either way.

The redundant parens need to go away, really.
