Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9BECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE452124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mozilla.com header.i=@mozilla.com header.b="AVmzewKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE452124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mozilla.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbeGMCf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 22:35:57 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45167 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388044AbeGMCf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 22:35:57 -0400
Received: by mail-qt0-f173.google.com with SMTP id y5-v6so25913589qti.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mozilla.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Vsv3qpAvJkmZOHDzdGNm9IaPKBF4C48prZZ+dQrnWlk=;
        b=AVmzewKYyFXqrfXZdnw3RSaUErHZmN3EtZyiTF+ERXHneyofIDJD/F/jfqXFtnFRB+
         0+8DSkLrsh9zg8spDTZCO886uZ+rqA63pAaI+2DNlR4kiSvOgyBkVxd6zOY7ntZz5rum
         XMzR4y+B95axigbakjvxpQiea/BbCC5WmJ+5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vsv3qpAvJkmZOHDzdGNm9IaPKBF4C48prZZ+dQrnWlk=;
        b=sC2pzJgZTNaIJWQ92sXrueECH+QZJlOMqYmv2OXls2W7MesTX10DlurHqPYwSeijwQ
         9Q1o0yiETpLWdUFn5OGm90/hNGvfrNfysba57bDL8UjvcoflCzKKYm30mQJ8GUloYDAN
         tXxRDqjzYvM4x6Bjl3mGJuTFoY0BoS3m16BAD1kaoi1TP1IKPXtRoQcIXkoAP39JN7Ig
         DeaCKbYxO8UHUwU5Lie/OYMRT0Q0G0gEWTPwtTHLtNpyhRS2bGeGYC3MP038baiP1izU
         YqpgVEDtimUaszjq7CQkdfRYLX2WE1fqYeqxtXDsbLfq0oq5mgXRkxLk9r/98XFlzEAn
         LUAw==
X-Gm-Message-State: AOUpUlFyfzmsQM95cE1/k2tCmtVXEAe3mvBbXshj+jfk3/gnM3ug4QRZ
        pncXQqC04xyF2a7NGKobjIFeufCSwv0=
X-Google-Smtp-Source: AAOMgpfPXoknx8PanSYtVcGsaNAaDGbuVORoNrRY5COJ0CSFWoq5wpDcU3R9ah5WbqoJeJmdcf5XKw==
X-Received: by 2002:a0c:af04:: with SMTP id i4-v6mr5120980qvc.125.1531448612423;
        Thu, 12 Jul 2018 19:23:32 -0700 (PDT)
Received: from obelix.jmvalin.ca (modemcable231.101-131-66.mc.videotron.ca. [66.131.101.231])
        by smtp.gmail.com with ESMTPSA id w43-v6sm15630323qth.58.2018.07.12.19.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 19:23:31 -0700 (PDT)
Subject: Re: AMD graphics performance regression in 4.15 and later
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        airlied@linux.ie, alexander.deucher@amd.com,
        Felix.Kuehling@amd.com, labbott@redhat.com,
        akpm@linux-foundation.org, michel.daenzer@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
From:   Jean-Marc Valin <jmvalin@mozilla.com>
Message-ID: <b7d904c9-7f1d-1906-b2ce-4420847445f1@mozilla.com>
Date:   Thu, 12 Jul 2018 22:23:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Sorry for the delayed response, but I just thought I'd confirm that
kernel 4.17 (4.17.3-100.fc27.x86_64 to be more precise) seems to be
working fine for me, with no performance issue.

Cheers,

	Jean-Marc

On 04/09/2018 07:48 AM, Christian König wrote:
> Am 06.04.2018 um 17:30 schrieb Jean-Marc Valin:
>> Hi Christian,
>>
>> Is there a way to turn off these huge pages at boot-time/run-time?
> 
> Only at compile time by not setting CONFIG_TRANSPARENT_HUGEPAGE.
> 
> Alternatively you can avoid enabling CONFIG_SWIOTLB which will avoid the
> slow DMA path as well.
> 
>> Right now the recent kernels are making Firefox pretty much unusable
>> for me.
>> I've been able to revert the patch from 4.15 but it's not really a
>> long-term solution.
>>
>> You mention that the purpose of the patch is to improve performance, but
>> I haven't actually noticed anything running faster on my system. Is
>> there any particular test where I'm supposed to see an improvement
>> compared to 4.14?
> 
> Mostly crypto mining, maybe some games as well.
> 
>> I'm not sure what you mean by "We mitigated the problem by avoiding the
>> slow coherent DMA code path on almost all platforms on newer kernels". I
>> tested up to 4.16 and the performance regression is just as bad as it is
>> for 4.15.
> 
> Indeed 4.16 still doesn't have that. You could use the
> amd-staging-drm-next branch or wait for 4.17.
> 
>> Unlike the older hardware reported on kernel bug 198511, the hardware I
>> have is quite recent (RX 560) and still being sold.
> 
> That isn't related to the GFX hardware, but to your CPU/motherboard and
> whatever else you have in the system.
> 
> Some part of your system needs SWIOTLB and that makes allocating memory
> much slower.
> 
>> I've also confirmed that neither nvidia (on the same machine) nor
>> intel GPUs (on a less
>> powerful machine) are affected, so it seems like there's a way to avoid
>> that slow performance.
> 
> Intel doesn't use TTM because they don't have dedicated VRAM, but the
> open source nvidia driver should be affected as well.
> 
>> I'm not saying that what Firefox is doing is
>> ideal (I don't know what it does and why), but it still seems like
>> something that should still be avoided in the kernel.
> 
> We already mitigated that problem and I don't see any solution which
> will arrive faster than 4.17.
> 
> The only quick workaround I can see is to avoid firefox, chrome for
> example is reported to work perfectly fine.
> 
> Christian.
> 
>>
>> Cheers,
>>
>>     Jean-Marc
>>
>> On 04/06/2018 04:03 AM, Christian König wrote:
>>> Hi Jean,
>>>
>>> yeah, that is a known problem. Using huge pages improves the performance
>>> because of better TLB usage, but for the cost of higher allocation
>>> overhead.
>>>
>>> What we found is that firefox is doing something rather strange by
>>> allocating large textures and then just trowing them away again
>>> immediately.
>>>
>>> We mitigated the problem by avoiding the slow coherent DMA code path on
>>> almost all platforms on newer kernels, but essentially somebody needs to
>>> figure out why firefox and/or the user space stack is doing this
>>> constant allocation/freeing of memory.
>>>
>>> There is also a bug tracker on bugs.kernel.org about this, but I can't
>>> find it any more of hand.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 06.04.2018 um 02:30 schrieb Jean-Marc Valin:
>>>> Hi,
>>>>
>>>> I noticed a serious graphics performance regression between 4.14 and
>>>> 4.15. It is most noticeable with Firefox (tried FF57 through FF60) and
>>>> causes scrolling to be really choppy/sluggish. I've confirmed that the
>>>> problem is also there on 4.16, while 4.13 works fine.
>>>>
>>>> After a bisection, I've narrowed the regression down to this commit:
>>>>
>>>> commit 648bc3574716400acc06f99915815f80d9563783
>>>> Author: Christian König <christian.koenig@amd.com>
>>>> Date:   Thu Jul 6 09:59:43 2017 +0200
>>>>
>>>>       drm/ttm: add transparent huge page support for DMA allocations v2
>>>>
>>>>
>>>> Some details about my system:
>>>> Distro: Fedora 27 (up-to-date)
>>>> Video: MSI Radeon RX 560 AERO
>>>> CPU: Dual-socket Xeon E5-2640 v4 (20 cores total)
>>>> RAM: 128 GB ECC
>>>>
>>>>
>>>> As a comparison, when running Firefox with 4.15 on a Lenovo W540 laptop
>>>> (with Intel graphics only) the responsiveness is much better then what
>>>> I'm getting on the Xeon machine above with the Radeon card, so this
>>>> really seems to be an AMD-only issue.
>>>>
>>>> Any way to fix the issue?
>>>>
>>>> Thanks,
>>>>
>>>>      Jean-Marc
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
