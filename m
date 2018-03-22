Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELu4wvjY9z02qEfWSC8x6rOa247rP+ZedoI+j+pYesAxQpBwX2jtjIxnzval9wPtW03EK+8m
ARC-Seal: i=1; a=rsa-sha256; t=1521728323; cv=none;
        d=google.com; s=arc-20160816;
        b=aPYX654wfbdZOYlTGr4eD39VCTAjCYwd1tz3ENOT2gbhCy5hGD+B+/eVsUA7kcFybd
         ZSWhyYmi96PiV6wz0hcXJRTljCshQFtVdM10adUQnJi/8l5oPkmPjzp38aLb0hSFuaoT
         IUwlaT57aqfTu1MQS9JpqNKUuVCxNRaBl7pl80/qGk1oBznXGajZ1r+au4vYLR3Va9f1
         YYot0ap6Kj989sIXQHcwzt6BGNxWVGVOhc0t4cgXjdChCC+qgupfpsk/pjszQBCHvBPM
         /W+eU59f5S4nt55N3WicAO9T6Sttf+8iQFqwBksYYtTG6nRzM97yinN9Tu6rpAhKRLHy
         4dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=DULTr8mCIc+/NOkNluHimEokU2sgurgX6zw2N2AHRAw=;
        b=DFFnX+o6Druq49U0Usz86kByQvYJeng9A+lXhSmwK6zuBFQ5zrjAmzrvKJy8rGMr9F
         MfMbkkictqqsqNq60q02gcIcGpzDHVZEPzri1GDecJ7vzc5iGfYsRuodQ5cKDL6zKpdO
         X6V6w+pO5NBUnNUz++gsyQrOhj7F5fMi1Y2vyfvqWgXIrEINOAhhOckme/05kFKJokMX
         Rq3+5cDDkBgfwk0whzp13HPp8li+Ig/leq/PkwsK4quFW+bve1E28eF8O2mbYAa8wUbQ
         yYcCFeYK1SyPGN64hFLZmPAsvp/oJr3hudw3+yaVkhyq5w5/mk2umr3FhNL4G7IRAsVn
         UkfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v17 00/10] LPC: legacy ISA I/O support
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <20180321233940.GI38649@bhelgaas-glaptop.roam.corp.google.com>
 <334da3b2-5233-5ad3-728e-7ae95231bf01@huawei.com>
 <20180322133544.GA236400@bhelgaas-glaptop.roam.corp.google.com>
CC: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>,
	"dann.frazier@canonical.com" <dann.frazier@canonical.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "joe@perches.com" <joe@perches.com>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linuxarm
	<linuxarm@huawei.com>, "minyard@acm.org" <minyard@acm.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "frowand.list@gmail.com"
	<frowand.list@gmail.com>, "agraf@suse.de" <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <8cc028fa-e4b5-514f-b2f6-a6bbd2ea57a6@huawei.com>
Date: Thu, 22 Mar 2018 14:18:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180322133544.GA236400@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938019590734035?=
X-GMAIL-MSGID: =?utf-8?q?1595647798315223505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>>
>>> I applied this whole series to pci/lpc for v4.17.
>>>
>>> I made the following whitespace and other trivial corrections.
>>> Hopefully I didn't break anything.
>>>
>>
>> Hi Bjorn,
>>
>> Super thanks for doing this. In general the changes look ok. However a build
>> issue has appeared, below.
>
> It didn't just "appear"; I added it myself!  I fixed it and repushed the
> branch.
>

Hi Bjorn,

I repulled and tested, and it looks ok.

Thanks,
John

> .
>
