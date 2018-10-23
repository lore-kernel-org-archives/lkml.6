Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F64C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCEE20813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BCEE20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbeJXDG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:06:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:06:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6DED3082DD1;
        Tue, 23 Oct 2018 18:42:23 +0000 (UTC)
Received: from [10.40.204.227] (ovpn-204-227.brq.redhat.com [10.40.204.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58196177BD;
        Tue, 23 Oct 2018 18:42:22 +0000 (UTC)
Subject: Re: [PATCH] Revert "be2net: remove desc field from be_eq_obj"
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, sathya.perla@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, linux-kernel@vger.kernel.org
References: <20181023144026.26180-1-ivecera@redhat.com>
 <20181023.110305.461689764889182451.davem@davemloft.net>
From:   Ivan Vecera <ivecera@redhat.com>
Message-ID: <ffdc9846-e500-247a-8cd5-8f8a1a7102c3@redhat.com>
Date:   Tue, 23 Oct 2018 20:42:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181023.110305.461689764889182451.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Oct 2018 18:42:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.2018 20:03, David Miller wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> Date: Tue, 23 Oct 2018 16:40:26 +0200
> 
>> The mentioned commit needs to be reverted because we cannot pass
>> string allocated on stack to request_irq(). This function stores
>> uses this pointer for later use (e.g. /proc/interrupts) so we need
>> to keep this string persistently.
>>
>> Fixes: d6d9704af8f4 ("be2net: remove desc field from be_eq_obj")
>>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> Please do not put empty lines between Fixes and the other tags,
> all tags should appear together as one contiguous group.
Sure Dave... sorry for that.

Ivan
