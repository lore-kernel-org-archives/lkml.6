Return-Path: <tursulin@ursulin.net>
ARC-Seal: i=1; a=rsa-sha256; t=1518624687; cv=none;
        d=google.com; s=arc-20160816;
        b=JXBao0u5PMQSjXVS+9e/h8CjaZOxIiyD5aRxcZT5rq3aSlyfJcodPyThm0Hn2RVXvx
         YADsXeqaHYYGLPln79rmOCOHagUcXmgxvTI1ZnWqbI+KcsctcFnYiy5Cxw8ssxgNOh5y
         MQpTgYzbt7H6ECYbCmhZfnQL5pzdwfTPdIIGCfxWf9CWKNGSspD6XMFlDYxdFXHiOX7h
         /d0B58cBytV0RwjLLsaTli+hdae2gJO4ugqPSpBSI+4aF7nUghTOx/TJpY6XMc8sDjUz
         SVxli7vW3jYYioynrZV1zzyr/QWwy1MZHtMXpmVrbbEjsL+zt70NBpFHcmid3ld2ZQX4
         CRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ppx6oKYKN0dR5JoKeYoq0pJbba0wADN8HcShhREXBgM=;
        b=bpCqbKF3m5l3oREqR+S1yMNryTwLeC4fmTUv7MNv00SUoJL5gXipstZI8hpbjCKvqp
         9YyODXTDSMfU2eRGTdzFPfDYYe5EExMIw4ecLickzcUZp1sZUgj0QIfawmqSFPRdP+/F
         UcukKqmO7R0fh6/Yp3Q8YMm0L/crLkAL8SS2Z2ctCa6IGVSHM6MNy4RgJawIzX0wuek4
         u0l3IpJfDLxmPZR+3flXYlifSYhvmzwzXgx/Wi3NoWDq92YxI0+WFRHZNuIi8exJmXdZ
         vaUVtriEPDfq4bGRqcQhTKQv2esxBQcAd5RqBSkRYKlxmZC4X24NMEBWLpaQaTSjxTbC
         bDVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ursulin-net.20150623.gappssmtp.com header.s=20150623 header.b=2TXgyjBP;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of tursulin@ursulin.net) smtp.mailfrom=tursulin@ursulin.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ursulin-net.20150623.gappssmtp.com header.s=20150623 header.b=2TXgyjBP;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of tursulin@ursulin.net) smtp.mailfrom=tursulin@ursulin.net
X-Google-Smtp-Source: AH8x224aK6Zb1iKjAWSLsz3nMOEvVBdB2PrpjQUIto2P2mjXwCPHdxCg3bTeZamp05kWqT6Np3jZTQ==
Subject: Re: [PATCH] lib/scatterlist: Add SG_CHAIN and SG_EMARK macros for LSB
 encodings
To: Johannes Thumshirn <jthumshirn@suse.de>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 bart.vanassche@wdc.com, axboe@kernel.dk, chris@chris-wilson.co.uk,
 tvrtko.ursulin@intel.com
References: <20180214045804.9113-1-khandual@linux.vnet.ibm.com>
 <1518597168.24629.4.camel@suse.de>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <ebbfc01c-3f42-483e-a281-1b4572bc8ac2@ursulin.net>
Date: Wed, 14 Feb 2018 16:11:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1518597168.24629.4.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592351049846277975?=
X-GMAIL-MSGID: =?utf-8?q?1592393400269466430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 14/02/18 08:32, Johannes Thumshirn wrote:
> On Wed, 2018-02-14 at 10:28 +0530, Anshuman Khandual wrote:
>> This replaces scatterlist->page_link LSB encodings with SG_CHAIN and
>> SG_EMARK definitions without any functional change.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>   include/linux/scatterlist.h | 23 +++++++++++++----------
>>   1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/scatterlist.h
>> b/include/linux/scatterlist.h
>> index 22b2131bcdcd..63d00bdb2fb3 100644
>> --- a/include/linux/scatterlist.h
>> +++ b/include/linux/scatterlist.h
>> @@ -65,16 +65,18 @@ struct sg_table {
>>    */
>>   
>>   #define SG_MAGIC	0x87654321
>> +#define SG_CHAIN	0x01
>> +#define SG_EMARK	0x02
> 
> SG_EMARK sounds strange, what about SG_END?

+1 on SG_END.

Btw, just a cleanup for readability or you have further work in this area?

Regards,

Tvrtko
