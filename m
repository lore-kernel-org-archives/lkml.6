Return-Path: <elfring@users.sourceforge.net>
X-Google-Smtp-Source: AG47ELsjo/z2hh5N9vVAI6DCyrFtYtPW8pFoW024QLS2xZUok6FwO7cP1ZgYay1Zi5zc/3yoOHhv
ARC-Seal: i=1; a=rsa-sha256; t=1521361203; cv=none;
        d=google.com; s=arc-20160816;
        b=SyljhVkELvQFaw+661l6dpGjKKHo1IhNXqkHmM+1kpYbbjvwEf6L3Yk4kVm6IrVN1K
         fx1jfXBHmnnnS4VKQ5MwWaQjCLDcKFbuvPqJP6s5doJnSxYgmInMqVarrLNyOT58DtwA
         7cpL0P+1jnWxvVdGyWfFIi/hCG+KyExtxN2RccMUorGqYFm+8scuzyBMcR9ySIKeV0GS
         eVef6oGkOIRYfpzobaA3wnSnhjv4klBDMp5AHqAFK7XKdP+z81aRLupcjpuva9hQK1vL
         4r83x6yY6a3wQWPS6uj2Npq5o2vod84yMtjL28YSxIhPsp6V3JnweYIU7lPsQl8Kiq8z
         wfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=07tg9M55K9J6e9drItaOn95EoApNhMEhm/bDTsSJv/Y=;
        b=DW/owKgK9oQATkLL3ViDMEfhOiG1Qzj6gTL9SDlYGYg+UNFYhYYDwnjtDBA23hS2Zp
         oIml9Zl8kxNf63WdvoFbQ7Du18beBtjlgwqVODeCd1t4Zsuv5dKnsAfBmQUqMXnmEL6d
         znJs73fl9ks/VMjuf1hta4WTjQya+ceWpIiKYJ3PKvWNxk/peaPXDN0KiVvWeVDDuHTT
         lIcU0INIejqUE7cZ/FAy6CzmPTU/vfp7I2VHVEJvG6vAMdJ3m1KHBpIS8WzafvUv9B+i
         4gWS1s4rQBaHmXdmq9cNL590zkkgAWHQ8nnESOcpBv/y0wTdhR2XCaERSVa9U92yX5LK
         i3og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.4 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of elfring@users.sourceforge.net designates 212.227.15.4 as permitted sender) smtp.mailfrom=elfring@users.sourceforge.net;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=sourceforge.net
Subject: Re: iio/gyro/bmg160_core: Improve unlocking of a mutex in five
 functions
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>,
 Quentin Schulz <quentin.schulz@free-electrons.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
 <20180317195422.037a8b57@archlinux>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <73f0a187-57d1-c877-ba9f-3b15f6a61640@users.sourceforge.net>
Date: Sun, 18 Mar 2018 09:19:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317195422.037a8b57@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:leiycwqSa9zdoq+6LLLuqOv6VQ0y4j0L9yLmUJEQd8S3Stv8A1i
 VH8zBDjHOKq0vyuTZlGoKYY6xZk5DjipZpfFsBkqC3e6D6loHQzJUp7AYH8wMUBZRyBmYC9
 VkWjRBqVBCBRiPttz5IwLc+WadE8MbXORacz8y7hIl1gToGGUnoj5v+3afbTU1OARxuay0O
 82ZpgtUGwLiIxU3xhlK6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/szo6LFP7qI=:bZrL1wRxuYG5jlJAumRP+/
 pe7kTZxdw/oAMRzawlfV7z8Pfl3ZPrAEh/eSHzizqxVA5CtNV0JIBTJDJQpU9qcdRtzTX19n/
 rsTyWb/ccQ+PKyo7UOhnq7csvJ5iac4Hi1X4yNbWJzgdWyVkCEpm4/i7lsDq5UkA+KslHZgob
 iQqdKuLjTD2jucw6hHdRlWNEuVOv9Wx81hoSjaduf7LcVRrJauCtAXfFokyOKEG/iKdpMR/Lo
 GSoWeF4kIs1j9jL891gGf0q+qT+8AkNLEU/9ePGWXKFA+QwGh+dAoX+dA/baew1xwcEd4i7V+
 0PymjooLS11bHA0+pRJkurTqSSPNHvVWoZTSeSprhomu5Sks20M9xQnS06rg5NicCSK7OOUGx
 BE6ZPm4GeK75NtwO/B8kE/6di1q46c9M8sL7gYzGTcKKEOQV0D3E9LjynnaSSAnceE3223/sk
 jziC1l6pXMy3ItCQWafxalT3atdND/HiFfVO/lN1HMaKbCiqwjLYXcoZBU9EAH39uM31Dbqvk
 ahSTB2dWwOSl7w1LteC3aBTfIM9gRse69LL9DQmi/ydkg80KQmf5WEr+puuChv04YDseRwWFD
 p04zX9vDkMKf14PlTAqBno9t69gRL9ZF2LQYvGky9JqOoMTuux7vlJEJGPTSgLMtL6krcHDlY
 ndrGAJFzdhxiW1f5FHiscK7vwsur4maG++wuCmqQdC7qS6h9goGbLwaoyuyUwmZvedvDniVwK
 UeAquH8/nrUX5W1UdD5QWVU/eiJlX9VK4OcZkHxFTKpH533pbzOnhGRt/vLVhc5cIVLBINBh9
 KCwSV5z3Dx7Q62RLnZVrWB5bVCW6QZ2knpf+Z7c3rgCpAb5EkM=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594926606648991207?=
X-GMAIL-MSGID: =?utf-8?q?1595262845153676826?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Am 17.03.2018 um 20:54 schrieb Jonathan Cameron:
> On Wed, 14 Mar 2018 16:15:32 +0100
> SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Wed, 14 Mar 2018 16:06:49 +0100
>>
>> * Add jump targets so that a call of the function "mutex_unlock" is stored
>>   only once in these function implementations.
>>
>> * Replace 19 calls by goto statements.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> 
> Hi Markus,
> 
> Some of these are good and sensible changes

Such feedback is nice.


> - others break the code.

Which concrete places do you find questionable here?


>> -		return ret;
>> +
>> +		goto set_power_state;
>>  	default:
>>  		return -EINVAL;
> We exit with the mutex locked now and it should not be.

I wonder about your source code interpretation here.
The mutex was (and is still only) locked within case branches, isn't it?


> 
>>  	}
>>  
>>  	return -EINVAL;
> Mutex is still locked here and the return is wrong.

Should this statement get any more software development attention?

Regards,
Markus
