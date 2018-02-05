Return-Path: <hal@dev.mellanox.co.il>
ARC-Seal: i=1; a=rsa-sha256; t=1517836617; cv=none;
        d=google.com; s=arc-20160816;
        b=sCf+goKe6VItAJASZYbN3FkJ1gfS370/WmhhQx3gl9wm2w729aBU1ocnP6tBX5/noq
         mH8h4VU2SMpsew+yShR7L+mM/jdd2dV6ixHbjLF6FrLrXxwU9/Yn0XRpcJdXPPwGNusE
         B2NweaFWejXdzCj4NcQT2QETV5FD71XhaDkhfkOsus5+0uf240q16lw4fi1rocKB2LHm
         z9jwHsUbSZ6m4+1NAvKLHv88+fYDrXmP1rfNmoudiuFXKO9+2X/StTKN51bN/sV/py8Y
         joQBU7EOck/Z3CXruZ9O1f2BZvKVocuvqXcOj41ITdYP+EzGSmtvrv07ZviPzFP5kiZI
         wQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=Vm0JmHttD2p3FYqD53xpdp/kko1lE7Puw9FD8HsWPbw=;
        b=yfm8pSvA+C4iIyUWaU2jUSySkXZijqwX+zTYrij9mSCp8aoRo9n7J7Vw8t9t6zyitr
         nrezZaNxU9kLM0VsbXaPbhIYAuu7cIQw8onnNa4fVigzOUcHIm/Dtosr8y/sEr81ki/n
         P4Z3wTYWn5OFOQzdCD3ea/z8fAHH2XonVvWa7tiCb4jZBcKOEnVsuWSjGetbV5i8yXov
         U8skDJlh15mnMTeHkmVPIVrwi1IhdNxP2POSQ3dIvHwHmJ0KRjoZq9eDh5LIGJ+1z4Qm
         c0uXpSbz6gIPKb1qTq34Heiao0DoCqvxFZibHQH1aajXfPdY+B23gcrjAfsVNEGPJcWg
         GCiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.s=20150623 header.b=qjoo0Z/2;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of hal@dev.mellanox.co.il) smtp.mailfrom=hal@dev.mellanox.co.il;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=mellanox.co.il
Authentication-Results: mx.google.com;
       dkim=pass header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.s=20150623 header.b=qjoo0Z/2;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of hal@dev.mellanox.co.il) smtp.mailfrom=hal@dev.mellanox.co.il;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=mellanox.co.il
X-Google-Smtp-Source: AH8x224/p+Hez2arTIns9bxdzntqvWkxDZjefmrg2xF3KWprTMcflW18/eTuOQF0b2JMenTTGrsMug==
Subject: Re: [PATCH] Documentation/ABI: update infiniband sysfs interfaces
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
 linux-doc@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
References: <20180201133233.GA21266@mordor.localdomain>
 <64f953cc-7831-1164-28b5-5319e72e600f@dev.mellanox.co.il>
 <20180205071934.GA9185@mordor.localdomain>
From: Hal Rosenstock <hal@dev.mellanox.co.il>
Message-ID: <6aca6ebc-4e58-79c7-6767-9e370c8ef71d@dev.mellanox.co.il>
Date: Mon, 5 Feb 2018 08:16:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205071934.GA9185@mordor.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591205652334607577?=
X-GMAIL-MSGID: =?utf-8?q?1591567049412705067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/5/2018 2:19 AM, Aishwarya Pant wrote:
>>> +		cap_mask:	(RO) Port capability mask
>> 2 bits here are settable: IsCommunicationManagementSupported and IsSM.
> Hi
> 
> Sorry, I don't quite understand this. cap_mask is a read only value which
> indicates the supported functions. So the two bits-
> IsCommunicationManagementSupported and IsSM, should not be setttable?

In terms of IB, PortInfo:CapabilityMask is RO from perspective of SM.

In linux, IsSM is settable via open of issmN file. An SM will do this to
set the IsSM bit.

It is similar in terms of IsCommunicationManagementSupported bit where
bit is set when CM module is loaded in kernel (in cm_add_one).

-- Hal

> Aishwarya
> 
> <snip>
> 
