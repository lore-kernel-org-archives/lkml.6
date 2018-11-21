Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CB62146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CB62146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbeKUT22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:28:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeKUT22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:28:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 768337AE9A;
        Wed, 21 Nov 2018 08:54:49 +0000 (UTC)
Received: from [10.36.117.231] (ovpn-117-231.ams2.redhat.com [10.36.117.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48B615C22C;
        Wed, 21 Nov 2018 08:54:32 +0000 (UTC)
Subject: Re: [PATCH v1 6/8] vmw_balloon: mark inflated pages PG_offline
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        kexec-ml <kexec@lists.infradead.org>,
        pv-drivers <pv-drivers@vmware.com>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Freche <jfreche@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20181119101616.8901-1-david@redhat.com>
 <20181119101616.8901-7-david@redhat.com>
 <9F78496F-EBAE-4248-80F0-0CB55CEFA238@vmware.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <b62e3d4b-f8ff-8e6c-c1b4-b36d5d32179d@redhat.com>
Date:   Wed, 21 Nov 2018 09:54:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9F78496F-EBAE-4248-80F0-0CB55CEFA238@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 21 Nov 2018 08:54:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.18 04:22, Nadav Amit wrote:
> Thanks for this patch!
> 
>> On Nov 19, 2018, at 2:16 AM, David Hildenbrand <david@redhat.com> wrote:
>>
>> Mark inflated and never onlined pages PG_offline, to tell the world that
>> the content is stale and should not be dumped.
>>
>> Cc: Xavier Deguillard <xdeguillard@vmware.com>
>> Cc: Nadav Amit <namit@vmware.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Julien Freche <jfreche@vmware.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>> drivers/misc/vmw_balloon.c | 32 ++++++++++++++++++++++++++++++++
>> 1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index e6126a4b95d3..8cc8bd9a4e32 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -544,6 +544,36 @@ unsigned int vmballoon_page_order(enum vmballoon_page_size_type page_size)
>> 	return page_size == VMW_BALLOON_2M_PAGE ? VMW_BALLOON_2M_ORDER : 0;
>> }
>>
>> +/**
>> + * vmballoon_mark_page_offline() - mark a page as offline
>> + * @page: pointer for the page
> 
> If possible, please add a period at the end of the sentence (yes, I know I
> got it wrong in some places too).

Sure :)

> 
>> + * @page_size: the size of the page.
>> + */
>> +static void
>> +vmballoon_mark_page_offline(struct page *page,
>> +			    enum vmballoon_page_size_type page_size)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < 1ULL << vmballoon_page_order(page_size); i++)
> 
> Can you please do instead:
> 
> 	unsigned int;
> 
> 	for (i = 0; i < vmballoon_page_in_frames(page_size); i++)
> 

Will do, will have to move both functions a little bit down in the file
(exactly one function).


> We would like to test it in the next few days, but in the meanwhile, after
> you address these minor issues:
> 
> Acked-by: Nadav Amit <namit@vmware.com>

Thanks!

> 
> Thanks again,
> Nadav 
> 


-- 

Thanks,

David / dhildenb
