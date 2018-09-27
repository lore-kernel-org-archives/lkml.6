Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5156215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 12:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5156215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeI0Sju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:39:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbeI0Sjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:39:49 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F332308A963;
        Thu, 27 Sep 2018 12:21:48 +0000 (UTC)
Received: from [10.72.12.27] (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B32E63091390;
        Thu, 27 Sep 2018 12:21:39 +0000 (UTC)
Subject: Re: [PATCH net] vhost-vsock: fix use after free
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        stefanha@redhat.com, mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180927084301.573-1-jasowang@redhat.com>
 <a413a8b4-302d-7fbc-092d-95e8aa421c4c@cogentembedded.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <a05604fb-74c7-5a6b-2af1-702da68ffbec@redhat.com>
Date:   Thu, 27 Sep 2018 20:21:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a413a8b4-302d-7fbc-092d-95e8aa421c4c@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 27 Sep 2018 12:21:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月27日 17:52, Sergei Shtylyov wrote:
> Hello!
>
> On 9/27/2018 11:43 AM, Jason Wang wrote:
>
>    Just a couple of typos...
>
>> The access of vsock is not protected by vhost_vsock_lock. This may
>> lead use after free since vhost_vsock_dev_release() may free the
>
>   Lead to use.
>
>> pointer at the same time.
>>
>> Fix this by holding the lock during the acess.
>
>    Access.
>
>> Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
>> Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
>> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> [...]
>
> MBR, Sergei

Let me post V2.

Thanks

