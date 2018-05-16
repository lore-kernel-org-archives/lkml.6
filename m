Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526459095; cv=none;
        d=google.com; s=arc-20160816;
        b=GEIs4hf/mbg15rFTRGYnbOyqs6ybgM2gJFBtR4+NRyua1MtToDTDH1oqPMDTblV/8z
         jwsKXe1EB3ZI60vkRVvg46Xd7JzfVm5ea5uZ4wZ27HUNFzq8jlm4Z1tBwdBu1+UzVyhG
         djFGmlboyk81Ww4dW/8hdOcvMAJlK80H2sFs4GFEhYYDe8h5vOaE4U4f2oKxR/PBSEj6
         I882bJ/iasqh+WA8y9O2s8hXhnd3Jl/1s8oKQRh8Ah+aVeQIIyPSuAIH5lYdDvWPewOG
         Z/qzlOMmckEXkXnvokJuGf4+gPVSylS7rI2oopfSgIwv7a5FYcli4vcUEvAuZ4/oBEz1
         BhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5HTdC3vrAWvcW0B8TLcR5QNYLyYOGQIsMv1pVaegYTc=;
        b=MDMJsfnxV/L6tDx1y4i4VLlIutxtWlmjjbltThiNr5Kqt7Bmh7B2meXVChWT1Jc8xB
         883bZIIyZc/vfDa9N7+zb69Cbs2J0it+ImryRM4RpCP+yz9UqiE2I+qjXetXw0HS5NZZ
         hohiy+mIuUCYtu7h6przO2rC01qPa/NftNWk7F1aX5cs+TJR2OaT5g8IbFrVm2LfEpNJ
         0LeVySOTkWs9AZQcWQANzZpgoYpV0dbxIBSICU1/9qTF7XSypIPcgjdTFbpMo+VDQpCp
         B+RVGgmMVPnsgnCdXZhD+1vlI4gZFuUPsa2RIQJwQsS7lWGaJNt7GBJv6QYlN42FrGBc
         oGaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=trSuaeBe;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=trSuaeBe;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZpZ0yBZJNE3hXftCNF9iFG0gNTGJ6aVQGL8CxQ0gXT5V2wjyOje82cy5BCuWKtasizxJCBFgojhR9QehrEaQ8o=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <7cefb087-f41a-0a73-ef77-b560d338be4b@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180511235807.30834-6-jeremy.linton@arm.com>
 <CAJZ5v0h4OeTaG2h0Q1c8zX93tici_nfLftpEyKWSkXoztHuUDg@mail.gmail.com> <7cefb087-f41a-0a73-ef77-b560d338be4b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 May 2018 10:24:54 +0200
X-Google-Sender-Auth: _DaS3sCrvVFCrP0t70737kxvWqc
Message-ID: <CAJZ5v0jE4JJbcK-BiFg_JVf00JZCvbMFRnrkTdJTOwz0vW_ZMg@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Sudeep Holla <Sudeep.Holla@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
	Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com,
	Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, jhugo@codeaurora.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214162685472859?=
X-GMAIL-MSGID: =?utf-8?q?1600608372519483261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 11:42 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
>
> On 05/12/2018 05:09 AM, Rafael J. Wysocki wrote:
>>
>> On Sat, May 12, 2018 at 1:58 AM, Jeremy Linton <jeremy.linton@arm.com>
>> wrote:
>>>

[cut]

>>
>>
>> I don't think you really need the explicit type cast here and above,
>> but that's very minor.
>>
>>> +}
>>
>>
>> Please feel free to add
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> to the patch and route it through the arch tree as needed.
>
>
> Thanks for looking at this (and the ack of course)!
>
> As an FYI, the in my build without the type cast, the
> -Werror=incompatible-pointer-types (sourced from the root Makefile) triggers
> an error.

Fair enough.
