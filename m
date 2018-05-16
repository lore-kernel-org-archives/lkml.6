Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AB8JxZqtNGjDFS/poL4tG0olMSAfjOJWfN/u07w9pu7937RTSLsEVsRp5ueNywQp8BjbhM3CrDto
ARC-Seal: i=1; a=rsa-sha256; t=1526469149; cv=none;
        d=google.com; s=arc-20160816;
        b=YUQC+UB+XG3c1sEY2ad/hzNYKbD+nkx1N6z6nHw6w3kh1k5b9QeEQRb/oUuRtXC4Nd
         Up5zJNP0z89GRACxfBUNk1xTEa16eg98MlgD+RMuq92IiHxL7GopXXWAH/0bc9j+sEZH
         DDDeCz4+neaYhDVc6+SlhBC0rxEWlR7rsXCo8UwYVunuX1wtsVCqgIxnx7wCOaS5j5JQ
         bFuzjZLN0dQZ+f8Pf0DFpUTFIkXY5m8F53lqsZdoAKrUKaMKWvk3/hl4+uaQGmGflvoF
         NiFRpZmyRxmuK74T3vmu+mqk7MEbKSDKZE/Rw5tAwZ9/qtHKTFWpwbklYm+SK0+6oYG7
         ju/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=nvZTuQjWTSaiqrNJnp/s/GAFMn4BdTPw49ZdstHxhGA=;
        b=RN2NtUw/O7byxjr/1K8xSBU0WPRL/T7lmq9bzsx6JC0Kz8pFMYhAZp24n/qWPjrVgd
         qhw5s/O0e98WC3Cjhe00XeVAGBmrfppiof8vZTSByYTlYDMEo4+MrzwdSVderXYbhAl+
         Uxv94dGWx5rncMTXK75D11IXec6Lu0Fd0EjLC6fkPznLv6G85hOJ13mu5j/B3/OvjJTw
         D3wWq6XGKm4KvKe7Vrs6EYYtf92cImlodfaJ9RQYopEVNRNzGb9X0hGwMIXicIFAne83
         kf/kRW58EoFAeCcT7ePqfUkc2jdUKFK0QLCreLhJI6FqnHH/kgNV6WF7q9kHAcMm8Cyw
         9miA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 1/4] amba: Export amba_bustype
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kim Phillips <kim.phillips@arm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Howells <dhowells@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Gargi Sharma <gs051095@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Kirill Tkhai
 <ktkhai@virtuozzo.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Rik van Riel <riel@redhat.com>, Thierry Reding <treding@nvidia.com>,
 Todd Kjos <tkjos@google.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
 <CAHp75VfGpS_QkLj4XM8uHW0BAJV0EBWZ_yLP0R2D+ok4Mt=SQg@mail.gmail.com>
 <20180516091841.GH16141@n2100.armlinux.org.uk>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8ad28c9-df7b-5211-dbdf-bce4f24ece94@arm.com>
Date: Wed, 16 May 2018 12:12:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516091841.GH16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599923962072715113?=
X-GMAIL-MSGID: =?utf-8?q?1600618915000405663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16/05/18 10:18, Russell King - ARM Linux wrote:
> On Wed, May 16, 2018 at 12:16:28PM +0300, Andy Shevchenko wrote:
>> On Tue, May 8, 2018 at 10:06 PM, Kim Phillips <kim.phillips@arm.com> wrote:
>>> This patch is provided in the context of allowing the Coresight driver
>>> subsystem to be loaded as modules.  Coresight uses amba_bus in its call
>>> to bus_find_device() in of_coresight_get_endpoint_device() when
>>> searching for a configurable endpoint device.  This patch allows
>>> Coresight to reference amba_bustype when built as a module.
>>
>>> --- a/drivers/amba/bus.c
>>> +++ b/drivers/amba/bus.c
>>> @@ -197,6 +197,7 @@ struct bus_type amba_bustype = {
>>>          .pm             = &amba_pm,
>>>          .force_dma      = true,
>>>   };
>>> +EXPORT_SYMBOL_GPL(amba_bustype);
>>
>> Oh,
>>
>> What wrong with the approach let's say similar to PCI bus?
>>
>> Whenever you have a struct device you may use two helpers:
>>
>> dev_is_pci() -> is the device of PCI bus type?
>> to_pci_dev() -> get's container of struct device for PCI bus case
> 
> How does that help with bus_find_device() which requires the bus_type
> structure for the type of devices to be searched?
Not to mention that dev_is_pci() still relies on pci_bus_type itself 
being exported anyway.

Robin.
