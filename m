Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000821992
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0000821992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeHFFPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:15:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbeHFFPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:15:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4EDF387A87;
        Mon,  6 Aug 2018 03:08:47 +0000 (UTC)
Received: from [10.72.12.33] (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 125D676F3;
        Mon,  6 Aug 2018 03:08:42 +0000 (UTC)
Subject: Re: [PATCH net-next] vhost: switch to use new message format
To:     David Miller <davem@davemloft.net>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1533279891-12249-1-git-send-email-jasowang@redhat.com>
 <20180804.132110.184608716461100739.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <db3d09f6-c707-1749-2874-3445c36f7272@redhat.com>
Date:   Mon, 6 Aug 2018 11:08:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804.132110.184608716461100739.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 06 Aug 2018 03:08:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 06 Aug 2018 03:08:47 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月05日 04:21, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri,  3 Aug 2018 15:04:51 +0800
>
>> So fixing this by introducing a new message type with an explicit
>> 32bit reserved field after type like:
>>
>> struct vhost_msg_v2 {
>> 	int type;
>> 	__u32 reserved;
> Please use fixed sized types consistently.  Use 's32' instead of 'int'
> here.
>
> Thanks!

Ok, V2 will be posted soon.

And it looks to me u32 is sufficient.

Thanks
