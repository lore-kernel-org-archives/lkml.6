Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbeEUCa7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 22:30:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751094AbeEUCa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 22:30:57 -0400
Subject: Re: [RFC v4 3/5] virtio_ring: add packed ring support
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
References: <20180516123909.GB986@debian>
 <ecb50c84-b412-ff0b-6c52-fd789b6c8a86@redhat.com>
 <20180516134550.GB4171@debian>
 <eaf946f1-abab-c4e5-1ab5-ba7912986d58@redhat.com>
 <20180516143332.GA1957@debian>
 <bc38e5a1-e920-7055-dc22-49ac98455257@redhat.com>
 <20180518112950.GA28224@debian>
 <e247b46a-183f-3959-859b-aebb0bf81c07@redhat.com>
 <20180518143334.GA4537@debian>
 <1a661df0-8ca9-b31d-9c17-8684d608a33a@redhat.com>
 <20180519022938.GA18888@debian>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b8c0d147-2711-cb26-a084-e7d3d32d0002@redhat.com>
Date: Mon, 21 May 2018 10:30:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180519022938.GA18888@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年05月19日 10:29, Tiwei Bie wrote:
>> I don't hope so.
>>
>>> I agreed driver should track the DMA addrs or some
>>> other necessary things from the very beginning. And
>>> I also repeated the spec to emphasize that it does
>>> make sense. And I'd like to do that.
>>>
>>> What I was saying is that, to support OOO, we may
>>> need to manage these context (which saves DMA addrs
>>> etc) via a list which is similar to the desc list
>>> maintained via `next` in split ring instead of an
>>> array whose elements always can be indexed directly.
>> My point is these context is a must (not only for OOO).
> Yeah, and I have the exactly same point after you
> pointed that I shouldn't get the addrs from descs.
> I do think it makes sense. I'll do it in the next
> version. I don't have any doubt about it. All my
> questions are about the OOO, instead of whether we
> should save context or not. It just seems that you
> thought I don't want to do it, and were trying to
> convince me that I should do it.

Right, but looks like I was wrong :)

>
>>> The desc ring in split ring is an array, but its
>>> free entries are managed as list via next. I was
>>> just wondering, do we want to manage such a list
>>> because of OOO. It's just a very simple question
>>> that I want to hear your opinion... (It doesn't
>>> means anything, e.g. It doesn't mean I don't want
>>> to support OOO. It's just a simple question...)
>> So the question is yes. But I admit I don't have better idea other than what
>> you propose here (something like split ring which is a little bit sad).
>> Maybe Michael had.
> Yeah, that's why I asked this question. It will
> make the packed ring a bit similar to split ring
> at least in the driver part. So I want to draw
> your attention on this to make sure that we're
> on the same page.

Yes. I think we are.

Thanks

> Best regards,
> Tiwei Bie
>
