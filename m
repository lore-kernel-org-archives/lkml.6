Return-Path: <prvs=604e35b7f=Richard.Leitner@skidata.com>
X-Google-Smtp-Source: AG47ELslRQqVzk6ApGhUhp7oru7iOZPvPBMak/J23C+/J2NzgmSGC33YJ+svIsk4F48RZxQ/qUdJ
ARC-Seal: i=1; a=rsa-sha256; t=1521042279; cv=none;
        d=google.com; s=arc-20160816;
        b=hkkxIP6EJDK5LoPJpEQjrpQiN0+/Keg1zfIjymgFSVu3zchwM+dGhw4UNKHMZW9zTO
         7J/lx9gbqV1dTiswZWu+WENdcOU02Bcm9eYraf5Rxb02+XP/oLzDqzFbF6S4FlloYQ5Q
         DzoG7JKR7lebH88POGa2brNOfhej0OeSl11cXU6R/9Y4bjrNqJjXVG0Vp6tnX21T+gyK
         t3nOX1WsE4iLAqEZY85A9h66rqm5grKwuY1NrcJN9ngPEyRay1mC2smYjLBF5y+9nItp
         PwbfBamISBrrP9/SpoBv34anmFD0kp6k7TE2ac0635noVJ3R4XTU8ctEbdGcA2hcew3X
         DcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=4MUXh2NaAb13QExaS1mKpm5AUg7ekqzmuUmPmLrhnQU=;
        b=sXqmx9pD4tXdOjWsD8V4FrnOw4HT8S591OzAsxbq6hBVrnox1MGq/OlU7/BbbIhaj3
         SrZ3rkwKrLeTDNiKmBLzapeuMbeSEkYb1Y1gpUXr10QWCrEQrRacHVEoHi9/Y5PPOVdv
         m1HnJFtsxyHrB9lLoSgqZqlaKOWlH8z5ecu/8SV2U5O43HAK9oozwy5pZKoRpbLPwDPW
         ZYijT1Bv712l+IOcafCeKx4PkFoY2DAnzLjAyxz7aHnliBMNKfrsnkajWzz5yGXoh6RK
         PPDFY3MRjFkMK3hTc49BEoHI/STjsYkoQsdwnzCXOw7Gooqnok6aTFw8L/uvupgpQqno
         KxMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=604e35b7f=richard.leitner@skidata.com designates 91.230.2.99 as permitted sender) smtp.mailfrom=prvs=604e35b7f=Richard.Leitner@skidata.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=604e35b7f=richard.leitner@skidata.com designates 91.230.2.99 as permitted sender) smtp.mailfrom=prvs=604e35b7f=Richard.Leitner@skidata.com
X-IronPort-AV: E=Sophos;i="5.47,470,1515452400";
   d="scan'208";a="9218762"
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
To: Oliver Neukum <oneukum@suse.com>, Richard Leitner <dev@g0hl1n.net>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
CC: <bhelgaas@google.com>, <mathias.nyman@intel.com>,
	<gregkh@linuxfoundation.org>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net> <1521029854.4511.12.camel@suse.com>
 <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
 <1521041253.4511.16.camel@suse.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <377fb9d5-1cc9-7ab8-c965-2fb0a4dc20f3@skidata.com>
Date: Wed, 14 Mar 2018 16:44:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521041253.4511.16.camel@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594908624828665894?=
X-GMAIL-MSGID: =?utf-8?q?1594928429330958895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 03/14/2018 04:27 PM, Oliver Neukum wrote:
> Am Mittwoch, den 14.03.2018, 14:31 +0100 schrieb Richard Leitner:
>> Hi Oliver,
>> thank you for your feedback!
>>
>> On 03/14/2018 01:17 PM, Oliver Neukum wrote:
>>> Am Mittwoch, den 14.03.2018, 11:29 +0100 schrieb Richard Leitner:
>>>> From: Richard Leitner <richard.leitner@skidata.com>
>>>>
>>>> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
>>>> pci_ids.h
>>>
>>> Hi,
>>>
>>> in general, why?
>>> Does this patch generate any benefit for any developer
>>> reading the source? I don't see it. Does it cause an
>>> issue for anybody who has a log file with the nummerical
>>> ID and needs to grep for it? Yes it does.
>>
>> I'll send a v2 where I also use this definition in 
>> arch/mips/netlogic/xlp/ instead of PCI_VENDOR_NETLOGIC from
>> arch/mips/include/asm/netlogic/xlp-hal/iomap.h.
>>
>> Therefore it will remove this definition from the iomap.h
>> and move it to pci_ids.h
>>
>> This will IMHO be a clear benefit as it removes a redundant
>> definition.
> 
> Well, but it does not. Removing a redundant definition is a clear
> benefit. But you are not removing a definition. You are introducing
> a preprocessor constant. Why?
> What is its benefit?

AFAIK pci_ids.h collects PCI vendor and device IDs in one single 
point. As the PCI vendor ID of Netlogic is used in multiple files
IMHO it would be a good idea to add it to pci_ids.h and furthermore
remove it from arch/mips/include/asm/netlogic/xlp-hal/iomap.h (where
it's currently defined).

Or am I getting things wrong?

regards;richard.l
