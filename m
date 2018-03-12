Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AG47ELtGZYkO1fcqdEDkRSmKGTJMYZ3PfbU8q+nLBjaTFxnp4JFJnRsMq8xvnxcgT2FqrjllVsc5
ARC-Seal: i=1; a=rsa-sha256; t=1520876470; cv=none;
        d=google.com; s=arc-20160816;
        b=mHT5wNQWg0twhfq/EfkuoSn01Z4PMy1fpVAPPFKYVdpBhkCZRRfkuhbVdh0RI/L3Y2
         EU1UTrVuY7hRqRg8fCEjpX/dxu8+WCJumTGyPaOgp75GkUgguTBw8gadmL8p2uHu62Xm
         eGipoO2zjHcQy9WBlm1gJNCReCHBcxGmQBtelNHkb/hoRtsDo53F/Dtwurtw9d9zkbqs
         +GRZm8QccKg+m6b0LVbpuZbQOjX2q6GfoIE11GIZ04IjtHJ6qNNhg6WspMCWPl1xasnS
         9gaJEl1hcbkQfJGf3FfG1r7eIHQlXCXiMdELXauLLH/WLBvQiKRISfBO3ScugrYUme54
         eWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=3snwbSBCmzOtfFBsXLuv2LFLiiAThbzIVirRJ3XkbZ4=;
        b=PDpXqITXGhwqifac50qOPKAWjDy3gUQoq1FDCeKmrJ5RkVo+C0cNyWQIWJfBoGDOdm
         zm4Qs68PUdNh/9WKxLhKSwvfzNpkABFhS8ppw8fn7gZ5VLtaAd94+rzi+tpzByt5pIXD
         ZkUY1D/1O8cylHBCt9Deaj9Ls8J61JubBew9xbb0UIHdKaKWeiZM3qJkzGeWNocwEpD5
         u8XF/6g64woSWHwDgc192Ot9NwfALYI4ChjOdyGnJrnoMhpVhOKfffmw0JyaxdpzeKcV
         qNPIDb2oe094NXx/DLDQq0WrfNM3ikZtgXlqkfhteK7Mu45xFTnz4c/fayu3ilGeeZ/E
         K6tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=E6E8NCw5;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I/EMYGRj;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=E6E8NCw5;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I/EMYGRj;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 52C856016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
To: Keith Busch <keith.busch@intel.com>, poza@codeaurora.org
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
 <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
 <20180312173301.GD18494@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <57d0b245-aecb-1518-c8bb-df8b69a86bcc@codeaurora.org>
Date: Mon, 12 Mar 2018 13:41:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312173301.GD18494@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593665102741565714?=
X-GMAIL-MSGID: =?utf-8?q?1594754566227785526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I was just writing a reply to you. You acted first :)

On 3/12/2018 1:33 PM, Keith Busch wrote:
>>> After releasing a slot from DPC, the link is allowed to retrain. If
>>> there
>>> is a working device on the other side, a link up event occurs. That
>>> event is handled by the pciehp driver, and that schedules enumeration
>>> no matter what you do to the DPC driver.
>> yes, that is what i current, but this patch-set makes DPC aware of error
>> handling driver callbacks.
> I've been questioning the utility of doing that since the very first
> version of this patch set.
> 

I think we should all agree that shutting down the device drivers with active
work is not safe. There could be outstanding work that the endpoint driver
needs to take care of. 

That was the motivation for this change so that we give endpoint drivers an 
error callback when something goes wrong. 

The rest is implementation detail that we can all figure out.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
