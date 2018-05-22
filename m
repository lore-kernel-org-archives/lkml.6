Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqLIsPsU8rk8wZWg5MjakmeRakaGNUq/c4qVz19xcixLEHistdFZc9cyCwa8Nyw9ptuvoZ2
ARC-Seal: i=1; a=rsa-sha256; t=1527031843; cv=none;
        d=google.com; s=arc-20160816;
        b=F7r1BdNndW4GOpkMVWqdxL5cj/dpxkeRo+HCzvdC93R+x0nlDTBqQIw8KVy9py+r61
         cZ/c9vjZW7hDdY1rxJgAI1ZQVzVm5CTIUCF0pv5bDGo2q1NBu9aOMKSpayj1nlu9oseJ
         Vn+4/9Lz7rJy0IPPaiYfoY0VVzk3+V3SYdKRA+qJr62JQjFF+zsuXnhtFQ+n86q5U2G6
         2UPgICWvami2dNIVbW8zqau1L2kKlLXECcccQWt/x/8iRgwBuSNBPLUWedoapnXC9eEE
         BquDm3VVCvNi7jZLnfrR7K50qSCvJHfnuU3po2RpYITrsNRE93w7GPLEaHVF+KvBXZdj
         ZAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=7q0sqrwqSRlEC11/ZKteK6AmMgdTCFwSg6AHTTWEyeI=;
        b=lUcmdd/tQvsqUQGwFPOKg9zjNrAQQtqXyef4zYngqDzR2zWWV2pu1whsueE8XcVLM4
         xLjVWbS/iDtu43q5VT9mCfUHz8EM8v3eHR11Ccp5DrHXPoRPT2e1ZuvMVN2mRNaUuaoB
         61WlnWjPVkrFBYgARORZvCv7iWetW/fgprTMssOrI5jSN2GtJyEHNO/R0TBOPTuAhIsi
         Fpt0MTkmTtmNpgnSWTeDnGgVdWNmMN+o5bUjhqOX0rJFT9e2CK+aVzIGKuQw17Z7j4D3
         ANWwphoCNuycT3c/1VggIZnohhMAa6swsG8Qmwdz2KIRzsqo/LoanDtC2uoeWX9aznm3
         ps6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X8lZ1g+t;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mXcdZFBU;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=X8lZ1g+t;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mXcdZFBU;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CDDB6028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 2/5] PCI/AER: Add sysfs stats for AER capable devices
To: Rajat Jain <rajatja@google.com>, "Alex G." <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
 Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Thomas Tai <thomas.tai@oracle.com>,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
 linux-pci <linux-pci@vger.kernel.org>, linux-doc@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>,
 Rajat Jain <rajatxjain@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-3-rajatja@google.com>
 <dcbb2e92-722f-c178-efb7-8d99d4a9d99f@gmail.com>
 <CACK8Z6GNPa+15WLxJBUAZ2=+jfhtdz+85=41B56KWSWCHSnyGw@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9861c339-6784-c7ec-b1ec-6722fb0d5bd5@codeaurora.org>
Date: Tue, 22 May 2018 19:30:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACK8Z6GNPa+15WLxJBUAZ2=+jfhtdz+85=41B56KWSWCHSnyGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205018627101133?=
X-GMAIL-MSGID: =?utf-8?q?1601208943038165781?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/22/2018 7:27 PM, Rajat Jain wrote:
>> What about AER errors that are contained by DPC?
> Thanks, You are right, this patch does not take care of the DPC. I'll
> try to read up on DPC and can integrate it if it turns out to be easy
> enough.
> 

I'd focus on AER for the moment. DPC is going through major restructuring
and will only handle AER_FATAL errors moving forward.

> Thanks,
> 
> Rajat
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
