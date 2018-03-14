Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AG47ELshYJjzGUumAzSBwtC8uFGY5rtWgmLxosE+0keEwspLPjj6MwyXjBnmOYfChiExHlO1JPMu
ARC-Seal: i=1; a=rsa-sha256; t=1521061221; cv=none;
        d=google.com; s=arc-20160816;
        b=R+iaI5WnuV1d5EYCKEKu3UBsEFYshadCprJMjAppxoCoF9ucz7Wc+W4t5ifQCT6psa
         wiX7TguVue4fht7EHKUxEG2OAQSwTU6h3pnH/q7C648TKpbjjblGywnCk3G5knCxmqGC
         YNKTu3udV7fvZ9RRmhXqFp/qPX4qCZElTUnn3STmeyp0SzPSc3YJumu9Nhtz/yQ8zFke
         1b8+Aq3f1pR+DiIN07xpUkdyIpvG19wH/XNWTDvreAPYrHBaZjQjg1uQoM9N3T16QEPe
         iji4ML9PIornG7cdRpAaDGya2wbpoCDQ7Wfe0EUIe22/zVU1X8hqObyUOE9aJ5FaokS9
         Guaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=SYBKs2m2TUPuJbCLCokC8dFHBKuqNeFATkKQWgAI+8M=;
        b=fOVh2NNmevrQZ226EB96ldNowDNUsSrARkVpTZFgMMSWFhKQ+QZtPgweMmCMcYBE7Q
         6BAeTvqePFHzqAqQZ0tA6YdeaDpqcaYVvxLTA7ykDaSEBbuHjcQEDFbpGkUhQuoITaT9
         Vew9Kp279SKjmHY32xqmUhJjdO3Md3H6e/TIhOwOTYrUi5BWpEvH23880RXgHR8+uU7m
         Y9GxDrgj/tKRp1W+cG6ex8vQhR+5zl1kvYHCxB31oJM2dX9hfTjMyzRiAjN06qhL+/N8
         c+rWcJiZBO6zKtqpBpuOalIBbbycODvNA0VLb46yiMU1XcbC9EvmBgB43W6f2WihCGpq
         D+OQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ql5fXiYi;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ql5fXiYi;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ql5fXiYi;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ql5fXiYi;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4EB960591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
 <20180312232626.GI18494@localhost.localdomain>
 <a52d2e0b-d319-bb34-8610-455d8c7ddad9@codeaurora.org>
 <20180314205049.GE29867@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8553ab27-b805-b995-068b-09857b875967@codeaurora.org>
Date: Wed, 14 Mar 2018 17:00:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314205049.GE29867@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594948291077736365?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/14/2018 4:50 PM, Keith Busch wrote:
> On Mon, Mar 12, 2018 at 11:47:12PM -0400, Sinan Kaya wrote:
>>
>> The spec is recommending code to use "Hotplug Surprise" to differentiate
>> these two cases we are looking for. 
>>
>> The use case Keith is looking for is for hotplug support. 
>> The case I and Oza are more interested is for error handling on platforms
>> with no hotplug support.
>>
>> According to the spec, if "Hotplug Surprise" is set in slot capabilities,
>> then hotplug driver handles link up and DPC driver doesn't interfere with
>> its operation. Hotplug driver observes link up interrupt like it is doing today.
>> When link up event is observed, hotplug driver will do the enumeration.
>>
>> If "Hotplug Surprise" bit is not set, it is the job of the DPC driver to
>> bring up the link. I believe this path should follow the AER driver path
>> as there is a very well defined error reporting and recovery framework
>> in the code.
>>
>> The link comes back up automatically when DPC driver handles its interrupt
>> very similar to what secondary bus reset does for AER. I don't believe
>> there is a hotplug possibility under this condition since it is not supported
>> to begin with.
>>
>> Should we plumb the "Hotplug Surprise" condition into the code to satisfy
>> both cases and leave the error handling path according to this code series?
> 
> I'm on board with this, but I think you mean "Hotplug Capable" rather
> than "Hotplug Surprise". The former may co-exist with DPC and handles
> the link-ups, leaving DPC responsible for handling the link-down.
> 

Yes, we can go with "Hotplug Capable".

> The "Hotplug Surprise" capability is recommended to not co-exist with DPC
> since that capability may suppress the "surprise link down" notification
> that DPC needs to see in order to trigger.
> 
> If the "Hotplug Capable" bit is not set, detecting the link-up after a
> DPC event would have to fall under a different component's responsibility,
> so I think I'm finally seeing your point.
> 

OK. To simplify our life, we can check if hotplug service is attached to this
device or not and follow two different paths.

We can get rid of re-enumeration and stop devices for the non-hotplug case
and make it behave exactly like AER.

Bjorn, will that work for you?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
