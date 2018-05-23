Return-Path: <mr.nuke.me@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1527086012; cv=none;
        d=google.com; s=arc-20160816;
        b=hp2rnvNUugqcyXCF2AzKebfgC5X4YFpwTkRFE8YNJbVaBWftFpKLqyk5BlPawPCwZ/
         0an0SFmVcpar+0GaOA9snlY8X5MN8KO8i2MhyvJ43qrAnPnju4I8VoCQyPHZA/uEnxf4
         4r3srmAQh784oybqVnOr03fM3cxjHDfKwymc+4Kr/6GehzJ/A6UU8O7cJkvYc5Rc6/gv
         7MYjvSUoJvq8OeAT1mpqVENroylD7q/IqGnPbPfzW4dnDRe7NAx1+eJ0Fup+R/QrtnTl
         7TXVaKkGSn9DYhoBLoDQ2+S1qxKrqBzJe+iJzePh2/eYszHtweWd+WUqlVwFoqivBp1y
         OaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=l+w65klDHCvyTNJi6v/ef0iEN3gJDGJoCXj0g6kqToE=;
        b=WxfDmAL/EZ3jU/+7dlyQIHCP/CWIRTNIKKYcaiM4fOaUCTPOPj1wB5R842MllmhB1l
         bXw66hB9PZIykqcrpz3jIcSjhxDx3wV7Zw7JMWFyIK17dvm0bI0M8ILzMa4JNzMG+quv
         I9Pyh/BR6WzTD0msd+2b0U9rG3e8yEbd92gb23VPM1W0kjh97MSjAvDG5TrkWb4htR//
         6RTIcjrOOoryOT4teIWMF3rOUXBRwQ7XbI0izn4+OvMchvxJBskSrjeq2xqNnI/u0lZ7
         u20/8j9fHzIwrGdSmTJhs+tNIf+o1I0jlQ+OxNPysJ5lb9zDbis6E5tDnf6A5hqF9glL
         mc0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dcaR6e4l;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dcaR6e4l;
       spf=pass (google.com: domain of mr.nuke.me@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mr.nuke.me@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoRSI8RU6d743RYWfMRz8/mg7mmc3pXhHy/RBLZO/JOltxkxtCHxK6Ly4r1N2T0NzY4pRbffA==
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
To: Jes Sorensen <jsorensen@fb.com>, Matthew Wilcox <willy@infradead.org>
Cc: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Philippe Ombredanne
 <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frederick Lawler <fred@fredlawl.com>, Oza Pawandeep <poza@codeaurora.org>,
 Keith Busch <keith.busch@intel.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Thomas Tai <thomas.tai@oracle.com>,
 "Steven Rostedt (VMware)" <rostedt@goodmis.org>, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
 <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
 <20180523142656.GE19987@bombadil.infradead.org>
 <46f0a2fa-9b48-c6d3-05ac-a75168b1998c@fb.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <ffa4e203-f320-b9be-c0d7-8432e949765b@gmail.com>
Date: Wed, 23 May 2018 09:33:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <46f0a2fa-9b48-c6d3-05ac-a75168b1998c@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205015185558067?=
X-GMAIL-MSGID: =?utf-8?q?1601265743046923631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/23/2018 09:32 AM, Jes Sorensen wrote:
> On 05/23/2018 10:26 AM, Matthew Wilcox wrote:
>> On Wed, May 23, 2018 at 10:20:10AM -0400, Jes Sorensen wrote:
>>>> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
>>>> @@ -0,0 +1,64 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>
>>> Fix the formatting please - that gross // gibberish doesn't belong there.
>>
>> Sorry, Jes.  The Chief Penguin has Spoken, and that's the preferred
>> syntax:
>>
>> 2. Style:
>>
>>    The SPDX license identifier is added in form of a comment.  The comment
>>    style depends on the file type::
>>
>>       C source: // SPDX-License-Identifier: <SPDX License Expression>
>>
>> (you can dig up the discussion around this on the mailing list if you
>> like.  Linus actually thinks that C++ single-line comments are one of
>> the few things that language got right)
> 
> Well I'll agree to disagree with Linus on this one. It's ugly as fsck
> and allows for ambiguous statements in the code.

You misspelled "fuck".

Alex
