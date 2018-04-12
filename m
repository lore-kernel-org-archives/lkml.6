Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-79201-1523515992-2-13417307319712642601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523515992; b=YdgQmXRNHmjfVRRW/hG5AFFZCOkRlcMUgnj5OEf9NTOCCNAAw+
    nsKjQsjpPp4VuKC61rzqZSLg3B1gilUWqI6BmflddaB3dinh+E4cHVcvAZCPfeD/
    gmJiOj/aQf0IN95tttDljwLGi5IN3AfKcWrYMB1E4gf1Tw4AO5UusXEUHHPBPeVy
    vOJowt8U9WS41dZPOXFMF/1e3YWidEuiGDyI9SdWS1ISXwp6tMIagXcAymLnnCQm
    +hwZxCPxTmCmIUHUotpPiC8sXp80vWP1Qs4vimnN5socSIi5DLvTPcim1T3v8YqY
    Nxu/8S23GY2Rs1B3hjegoKkSJ0gdD+a4YACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523515992;
    bh=RhnvS2hIMDPbAqr9Rsv3twXptgE908x2v/WHOOSKfXI=; b=kkcX5iBnkdwl
    VJBdJxgo9ZJisY79yheoXHh0BF9iFfJzkQbsGJmDar2hZtZnZOnGenC/UZOEMcH3
    rcsPi6GdV+hNDNKFLN/znkWeNALeFozvCUKiXGMC9BoAhZvG7fwb71SPmMf1X39D
    meC9BwTZcJBzy4zkbrAeGn+WG59LUhujN/sVooeRPBpu7ztbz9IrD/wxTnvwI0d9
    UqNBaN2FtJIeKnLcq1Yx+KiSX7ISDcuiTWKUorAY8MLpYXhLyWfXCTqEdfem7zDY
    kb4d2TdYpSanrX026NrILnuAVlBCm19sqc2yTPSR8v9be/XgOfdx+dmnFdz/Z1ci
    VWO9gCyUoQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfElGFj8r0BRe0kzj/hm8I+sG4tyNQQsDu3UxZJfn3iD8dx1kMtdVIvpYmARv2aBltPM2v1UbEbSqD7VgdJhRyC/cWNbxtSTfnW9M66pT4MwsnPuZSzcm
    842oy7IePcepTDAorXbxoaNyg/6cMB598MtkxH0RM8iDbadMdhszvKuNr/8b7RJ1iqbJeHudag/GsBV/BtI6OVOylXqZ4wRhg8IwTATrX3sO7UfSCJncTbMe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FOH2dFAWAAAA:8 a=Z4Rwk6OoAAAA:8 a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8
    a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8 a=37rDS-QxAAAA:8 a=vE_eOKpJvdqFkJTlTBEA:9
    a=BoCILwACH8euEtmQ:21 a=Ifr_yHXBPsP5m1O7:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22
    a=AjGcO6oz07-iQ99wixmX:22 a=k1Nq6YrhK2t884LQW06G:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeDLGw5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 02:52:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:51996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752729AbeDLGwz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Apr 2018 02:52:55 -0400
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
To: Roman Gushchin <guro@fb.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Linux API <linux-api@vger.kernel.org>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
From: Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSFWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmNvbT7CwZcEEwEKAEECGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4ACGQEWIQSpQNQ0mSwujpkQPVAiT6fnzIKmZAUCWi/zTwUJBbOLuQAKCRAiT6fnzIKm
 ZIpED/4jRN/6LKZZIT4R2xoou0nJkBGVA3nfb+mUMgi3uwn/zC+o6jjc3ShmP0LQ0cdeuSt/
 t2ytstnuARTFVqZT4/IYzZgBsLM8ODFY5vGfPw00tsZMIfFuVPQX3xs0XgLEHw7/1ZCVyJVr
 mTzYmV3JruwhMdUvIzwoZ/LXjPiEx1MRdUQYHAWwUfsl8lUZeu2QShL3KubR1eH6lUWN2M7t
 VcokLsnGg4LTajZzZfq2NqCKEQMY3JkAmOu/ooPTrfHCJYMF/5dpi8YF1CkQF/PVbnYbPUuh
 dRM0m3NzPtn5DdyfFltJ7fobGR039+zoCo6dFF9fPltwcyLlt1gaItfX5yNbOjX3aJSHY2Vc
 A5T+XAVC2sCwj0lHvgGDz/dTsMM9Ob/6rRJANlJPRWGYk3WVWnbgW8UejCWtn1FkiY/L/4qJ
 UsqkId8NkkVdVAenCcHQmOGjRQYTpe6Cf4aQ4HGNDeWEm3H8Uq9vmHhXXcPLkxBLRbGDSHyq
 vUBVaK+dAwAsXn/5PlGxw1cWtur1ep7RDgG3vVQDhIOpAXAg6HULjcbWpBEFaoH720oyGmO5
 kV+yHciYO3nPzz/CZJzP5Ki7Q1zqBb/U6gib2at5Ycvews+vTueYO+rOb9sfD8BFTK386LUK
 uce7E38owtgo/V2GV4LMWqVOy1xtCB6OAUfnGDU2EM7BTQRWXZsWARAAyS3vr9khnfXSX3zU
 v2JIH8zP/aIwjAlIeekU7RYeIamGNm2qL1O1ZxQm4LH73YQpfVFpZbBMA6/jo+X38D+6b+7i
 Ea4f8otSBwHfTuV2mcwmo9OZjcsTsN01lq1i4mxA6fThBLJr/KDzW+kfq6lxN9/mEmhDjGIx
 cGWXvYY2Aa+QWNcMsIcXAwQWDx4ATrBvVAC5ezsuJwidNYgdMZr/1667W4jdUdxaASwYxT7N
 0rjbCfpvdEUbZ66+mGup+46su/ijlRlr1X8+4n4OYWz9AmRGe0pcCl2trZpWcxE3t2T9S0yR
 uMlCgEIU8edyGVtmhuDJ0PGzinlNYnUikdvJIfNHT0SkMdEeuwAnBArwEl+d35g6RnyQA0im
 fSTb/R6OiavZZzHm5ywrdFo0ZCcJi5cVM5YwPgh7hWtDVd3Wj644mbV1wXVcU2TyQPwG0D+m
 BARx9WEHmz2orqLZyGwolYrk/5VLuTv7N/bp9OkIVx5a+YwfNyalZvBbsR2Pu4cLVNaKHR80
 4IrZI4cX26hy8Obsnuaex4homJLR2ACl/DhBGyqv4MNMwmkHxihv+q08fzKQEkXrK0UTssnW
 eUfB0oNmZteVxphgurn2f5OtasseGhbp7DvQnsK3t7JLhzN/qu4jtZ+udqrY41axBAthI6Z6
 ShIddANj0Ly4T3u/Q4EAEQEAAcLBZQQYAQoADwUCVl2bFgIbDAUJAeEzgAAKCRAiT6fnzIKm
 ZLV4EACAu3CiyTMfJt8h85vKp86C/v1/UkcUeKwGyeVgXwdXOJH9U6uF25QCoeXd77qBb+7O
 Eksos+clgzz83WIP7R9VlfOg6NU5E+OBU1zpXpiUUwfK3n7lPnpfPN3iSVT8Qh55phuis4CZ
 PqqHbBh8FFh2wfJQzp69eQnkYlxADZ6S2/e6rUtaZQNWHUmNV3dbts1n6fAtWChQw6IOFQv0
 OzAWSNAjzk/AhS1a1jEcOD4L1AHtbQty0a6ajhwayl0MQGjD380R48mV24TQgHrb+8qoXF6A
 K9MC0W1KZaHZlcng1ArxnhKbRrTMInH/B+YaSSomayAPdt9rfnXlhy/FSRMAdAsa6Ui9wG+S
 8LyiV/EgMJzsTmQIJlF9plYd+G1QLQi8lP9C+lw6Wn92sJR5sQo719GUwXtozxOy5aVEfBy/
 hIYgXNwKMQEymAkiJAHunTmGDL0OrFY37+TvO+8Z3AcqnV04pCDzLkmDgbsBNwsqCoHRtNSh
 Gx2mu0G1U19yuDlQK92M+d4Dfb43IMuoT2c+zdMmUGeZMPhKgGc3BDBJ2UQyn2VCaxpDPgmx
 3x1zA7K5E/ZIqD5Oo71qTRRonRZ74w0JLDzgDSK7d9lLmtOobstclGT4hChSTblDuMGLFy8J
 dfyae8NugjBzvIomGBWOsmMGmCeB6tqPObIqLio3T8LBfAQYAQoAJgIbDBYhBKlA1DSZLC6O
 mRA9UCJPp+fMgqZkBQJaL/NjBQkFs4vNAAoJECJPp+fMgqZk50AQALKEAzCj6kLU6KH7dUZY
 16M74NCtpaMDO5/4Shwu+oS8H//b29GHtZVVGudfwBNmuIRSSxdpJkLsmqoLLEQTCzs2szH1
 r5+uOiZTuKbgx2HJNaCqoHuotPSOdoVsKg27UxbkJraqSNyzgex0kKNO8HQltdvF20MXvPFu
 IKc6/Y/NTWQqaamXQBZA6HoSQKfuJmM0zQy3SWdcuz79K2Q4ftR2VNuu8UYB0bfTD7LCTguP
 PpYC0ePRFmYuiMP5T8DA9NKYiN+71RtcAQTJM8WTidJQ3gaBG1s3kiyqBoqQvkLFExUOBTDi
 /qukcTh/deKpfaUSIrX+JbrlFIFcwQ0Ql3bAE24hu1nRkFiBSPcoDdDS7Iu3MOwZik3SL6ZH
 qGo/KlmKiqTyCAs0WgOHnzXeX18/sS048NuOCwqfjn5cbDdbThpX+vRoWBV/rrYMFPgHCigK
 Ertp0r/zjPaqFHtdxvChwmbTvu44ddRvcCR/3v1zmeUAtxw6guSlvmVDzLwr35czpGrbcydq
 FPbL9fuTVKAXvkmKzuY0ye5tmJAsyYqgV5l+jaGt6oFEGFj5XZQvO6ic5lmjTHz9b6lUg8at
 uInmlw5eLxByeMA81R3sJvNbtGfCcqQfVkJAn2S4RYpDtAKI7QM+ydrdH3STBRaC1IuD0YWr
 A3XDrKOXTZil3g8D
Message-ID: <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
Date: Thu, 12 Apr 2018 08:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411135624.GA24260@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 03:56 PM, Roman Gushchin wrote:
> On Wed, Apr 11, 2018 at 03:16:08PM +0200, Vlastimil Babka wrote:
>> [+CC linux-api]
>>
>> On 03/05/2018 02:37 PM, Roman Gushchin wrote:
>>> This patch introduces a concept of indirectly reclaimable memory
>>> and adds the corresponding memory counter and /proc/vmstat item.
>>>
>>> Indirectly reclaimable memory is any sort of memory, used by
>>> the kernel (except of reclaimable slabs), which is actually
>>> reclaimable, i.e. will be released under memory pressure.
>>>
>>> The counter is in bytes, as it's not always possible to
>>> count such objects in pages. The name contains BYTES
>>> by analogy to NR_KERNEL_STACK_KB.
>>>
>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: linux-fsdevel@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Cc: kernel-team@fb.com
>>
>> Hmm, looks like I'm late and this user-visible API change was just
>> merged. But it's for rc1, so we can still change it, hopefully?
>>
>> One problem I see with the counter is that it's in bytes, but among
>> counters that use pages, and the name doesn't indicate it.
> 
> Here I just followed "nr_kernel_stack" path, which is measured in kB,
> but this is not mentioned in the field name.

Oh, didn't know. Bad example to follow :P

>> Then, I don't
>> see why users should care about the "indirectly" part, as that's just an
>> implementation detail. It is reclaimable and that's what matters, right?
>> (I also wanted to complain about lack of Documentation/... update, but
>> looks like there's no general file about vmstat, ugh)
> 
> I agree, that it's a bit weird, and it's probably better to not expose
> it at all; but this is how all vm counters work. We do expose them all
> in /proc/vmstat. A good number of them is useless until you are not a
> mm developer, so it's arguable more "debug info" rather than "api".

Yeah the problem is that once tools start rely on them, they fall under
the "do not break userspace" rule, however we call them. So being
cautious and conservative can't hurt.

> It's definitely not a reason to make them messy.
> Does "nr_indirectly_reclaimable_bytes" look better to you?

It still has has the "indirecly" part and feels arbitrary :/

>>
>> I also kind of liked the idea from v1 rfc posting that there would be a
>> separate set of reclaimable kmalloc-X caches for these kind of
>> allocations. Besides accounting, it should also help reduce memory
>> fragmentation. The right variant of cache would be detected via
>> __GFP_RECLAIMABLE.
> 
> Well, the downside is that we have to introduce X new caches
> just for this particular problem. I'm not strictly against the idea,
> but not convinced that it's much better.

Maybe we can find more cases that would benefit from it. Heck, even slab
itself allocates some management structures from the generic kmalloc
caches, and if they are used for reclaimable caches, they could be
tracked as reclaimable as well.

>>
>> With that in mind, can we at least for now put the (manually maintained)
>> byte counter in a variable that's not directly exposed via /proc/vmstat,
>> and then when printing nr_slab_reclaimable, simply add the value
>> (divided by PAGE_SIZE), and when printing nr_slab_unreclaimable,
>> subtract the same value. This way we would be simply making the existing
>> counters more precise, in line with their semantics.
> 
> Idk, I don't like the idea of adding a counter outside of the vm counters
> infrastructure, and I definitely wouldn't touch the exposed
> nr_slab_reclaimable and nr_slab_unreclaimable fields.

We would be just making the reported values more precise wrt reality.

> We do have some stats in /proc/slabinfo, /proc/meminfo and /sys/kernel/slab
> and I think that we should keep it consistent.

Right, meminfo would be adjusted the same. slabinfo doesn't indicate
which caches are reclaimable, so there will be no change.
/sys/kernel/slab/cache/reclaim_account does, but I doubt anything will
break.

> Thanks!
> 
>>
>> Thoughts?
>> Vlastimil
>>
>>> ---
>>>  include/linux/mmzone.h | 1 +
>>>  mm/vmstat.c            | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index e09fe563d5dc..15e783f29e21 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -180,6 +180,7 @@ enum node_stat_item {
>>>  	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
>>>  	NR_DIRTIED,		/* page dirtyings since bootup */
>>>  	NR_WRITTEN,		/* page writings since bootup */
>>> +	NR_INDIRECTLY_RECLAIMABLE_BYTES, /* measured in bytes */
>>>  	NR_VM_NODE_STAT_ITEMS
>>>  };
>>>  
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index 40b2db6db6b1..b6b5684f31fe 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1161,6 +1161,7 @@ const char * const vmstat_text[] = {
>>>  	"nr_vmscan_immediate_reclaim",
>>>  	"nr_dirtied",
>>>  	"nr_written",
>>> +	"nr_indirectly_reclaimable",
>>>  
>>>  	/* enum writeback_stat_item counters */
>>>  	"nr_dirty_threshold",
>>>
>>
> 

