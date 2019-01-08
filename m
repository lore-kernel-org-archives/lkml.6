Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C512C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD14206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfAHKMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:12:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbfAHKMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:12:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A87EA637FF;
        Tue,  8 Jan 2019 10:12:45 +0000 (UTC)
Received: from [10.72.12.122] (ovpn-12-122.pek2.redhat.com [10.72.12.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B3D52270A;
        Tue,  8 Jan 2019 10:12:41 +0000 (UTC)
Subject: Re: [RFC PATCH V3 0/5] Hi:
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net
References: <20181229124656.3900-1-jasowang@redhat.com>
 <20190104163516-mutt-send-email-mst@kernel.org>
 <68727e1b-1d51-0596-29c3-931475dd5dab@redhat.com>
 <20190107094516-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <682d520e-00e3-cdaa-d51e-23524ae48854@redhat.com>
Date:   Tue, 8 Jan 2019 18:12:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107094516-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 08 Jan 2019 10:12:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/7 下午10:47, Michael S. Tsirkin wrote:
> On Mon, Jan 07, 2019 at 02:58:08PM +0800, Jason Wang wrote:
>> On 2019/1/5 上午5:41, Michael S. Tsirkin wrote:
>>> On Sat, Dec 29, 2018 at 08:46:51PM +0800, Jason Wang wrote:
>>>> This series tries to access virtqueue metadata through kernel virtual
>>>> address instead of copy_user() friends since they had too much
>>>> overheads like checks, spec barriers or even hardware feature
>>>> toggling.
>>> I think it's a reasonable approach.
>>> However I need to look at whether and which mmu notifiers are invoked before
>>> writeback. Do you know?
>>
>> I don't know but just looking at the MMU notifier ops definition, there's no
>> such callback if my understanding is correct.
>>
>> Thanks
> In that case how are you making sure used ring updates are written back?
> If they aren't guest will crash ...


I think this is the writeback issue you mentioned early. I don't do a 
followup on the pointer but it looks to me some work is ongoing to fix 
the issue.

I can investigate it more, but it's not something new, consider the case 
of VFIO.

Thanks



