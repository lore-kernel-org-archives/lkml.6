Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A8FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7238218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfAYJY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:24:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfAYJY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:24:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C1E97EBC8;
        Fri, 25 Jan 2019 09:24:26 +0000 (UTC)
Received: from [10.72.12.101] (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E82DE60FDF;
        Fri, 25 Jan 2019 09:24:18 +0000 (UTC)
Subject: Re: [PATCH net-next V4 5/5] vhost: access vq metadata through kernel
 virtual address
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        aarcange@redhat.com
References: <20190123095557.30168-1-jasowang@redhat.com>
 <20190123095557.30168-6-jasowang@redhat.com>
 <20190124214402-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4f4da5d5-0493-9da4-5ede-e344535bbb65@redhat.com>
Date:   Fri, 25 Jan 2019 17:24:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190124214402-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 25 Jan 2019 09:24:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/25 上午11:03, Michael S. Tsirkin wrote:
>> +/* Suppress the vma that needs writeback since we can not track dirty
>> + * pages now.
>> + */
>> +static bool vma_can_vmap(struct vm_area_struct *vma)
>> +{
>> +	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
>> +	       vma_is_shmem(vma);
>> +}
>> +
> IIUC a second but anonymous memory needs writeback too, just to swap.
> I'm not an MM person so I might be off.


Right, my fault, I mean the vma that needs dirty page tracking.

Thanks

