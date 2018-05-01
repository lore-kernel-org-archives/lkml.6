Return-Path: <okaya@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqkFwPOmAXwMu5I7UmdUanFZVTNzbOd8/MXq8VY/4aV9a6rPAhFrN6dN7OXcKmluhxXA6or
ARC-Seal: i=1; a=rsa-sha256; t=1525214886; cv=none;
        d=google.com; s=arc-20160816;
        b=PlUDsR2zvqjQyGqhluZzFEcqPrrUdTU7XGlSkD9V2fEcXLx5GbIBuNeCfPeuvWvkTN
         LDVRV/7UpwQEAerx2hgHIwhAgUdawPYGxkKhvGOPepVILlc8swi/au4nP6Qo1Eb8NJR0
         Mlo/jUwwztKXvhH56BO2sIKOttMN1ay6YKVh5AJqTYuS1+2oXUpfpBnqoCmsjyhaZi0V
         a9RiMKE71zppr2ilv2LkeDtTJK266hn2U6qPxa0RKuPuyLl+Uf68e9y5Zk1Wp63bYyao
         Df7bheNnlGTAAvDnF5iz9Sg4r0iAfX91e1LjqKE7D0e0d2rDt6+igd6TR8ZMJDkPtvMP
         2IKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=VJtp1yWIAEEoko//hRZ5gFnYMy/19+kYBJAZYyHWbNE=;
        b=I3HSTr5iXAnUio8NzlFVOZEIGUVb6tCO3KsLAXIJdhPrlXyLB4qXGWs86VHbvxpXzw
         RJrR0D8ZkgHZfiMQOOhsRw5/nuTj0ToNK1ZM2X7E4hqu69x0OPcA11+2vYrXqt0pM5IO
         gnRZWRr81gDTbKjRBhBpNlb/Qz3WA3kjmArlVbvAd972yp+Z+azSedrUkWGUFpFn/52a
         kK3/du0rrEDVIwCAhzge6Y8D8FKfqYlMT3hWQYIQ+iTcfYIwvuMHZNAYumEo+4vSzNfC
         n/jdkG98I5T7h3Gv33+03MmvS1/mWz5sxtPavEQAHNTRx8ge/79xZ7nr/wCrHeTuIWeH
         XxiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n/CvrOzv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G/4y920V;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=n/CvrOzv;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=G/4y920V;
       spf=pass (google.com: domain of okaya@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=okaya@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5121F6028D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering #2
To: linux-alpha@vger.kernel.org, arnd@arndb.de, timur@codeaurora.org,
 sulrich@codeaurora.org, Matt Turner <mattst88@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <1523917017-28084-1-git-send-email-okaya@codeaurora.org>
 <b9d845ad-62af-d300-53d9-2b62f5da6c44@codeaurora.org>
 <2fd54f7c-ff73-5935-a253-c924f4373cc6@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ca5f0ecf-bb2b-15ab-1fdd-6a117c223837@codeaurora.org>
Date: Tue, 1 May 2018 18:48:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2fd54f7c-ff73-5935-a253-c924f4373cc6@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597942817277668063?=
X-GMAIL-MSGID: =?utf-8?q?1599303724355139718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/20/2018 12:20 PM, Sinan Kaya wrote:
> Hi Matt,
> 
> On 4/17/2018 2:43 PM, Sinan Kaya wrote:
>> On 4/16/2018 6:16 PM, Sinan Kaya wrote:
>>> memory-barriers.txt has been updated with the following requirement.
>>>
>>> "When using writel(), a prior wmb() is not needed to guarantee that the
>>> cache coherent memory writes have completed before writing to the MMIO
>>> region."
>>>
>>> Current writeX() and iowriteX() implementations on alpha are not
>>> satisfying this requirement as the barrier is after the register write.
>>>
>>> Move mb() in writeX() and iowriteX() functions to guarantee that HW
>>> observes memory changes before performing register operations.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  arch/alpha/kernel/io.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> Sorry for catching this late but this also needs to go to 4.17 after
>> review.
>>
>> I missed the writel() implementation on arch/alpha/kernel/io.c file
>> on my first patch.
>>
> 
> Can you also queue this for 4.17?
> 
> There are already drivers checked into 4.17 that dropped the unnecessary
> barriers. 
> 
> I really hate to see Alpha broken because of this.

ping.

> 
> Sinan
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
