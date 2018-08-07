Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3DAC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718E0214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718E0214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389081AbeHGN6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:58:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeHGN6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:58:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77F9F87A70;
        Tue,  7 Aug 2018 11:44:54 +0000 (UTC)
Received: from [10.43.2.69] (unknown [10.43.2.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 415E710CD88B;
        Tue,  7 Aug 2018 11:44:53 +0000 (UTC)
Subject: Re: [PATCH] Use Kconfig flag to remove support of deprecated BE2/BE3
 adapters
To:     David Miller <davem@davemloft.net>, poros@redhat.com
Cc:     netdev@vger.kernel.org, sathya.perla@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, linux-kernel@vger.kernel.org
References: <20180806121230.23690-1-poros@redhat.com>
 <20180806.134620.124956510948789350.davem@davemloft.net>
From:   Ivan Vecera <ivecera@redhat.com>
Message-ID: <322717b5-6d98-6f65-9357-190af5b50418@redhat.com>
Date:   Tue, 7 Aug 2018 13:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180806.134620.124956510948789350.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 11:44:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 11:44:54 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ivecera@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.8.2018 22:46, David Miller wrote:
> From: Petr Oros <poros@redhat.com>
> Date: Mon,  6 Aug 2018 14:12:28 +0200
> 
>>   Add flags to remove support of deprecated BE2/BE3 adapters.
>>   BE2 disable will reduce .ko size by 2kb and BE3 by 3kb.
>>   Disable both will reduce .ko size by 9kb.
>>
>>   With dissabled support is also removed coresponding PCI IDs
>>   and codepath with [BE2|BE3|BEx]_chip checks.
>>
>>   New help style in Kconfig
>>
>> Signed-off-by: Petr Oros <poros@redhat.com>
> 
> Sorry, I'm not too hot about this.

Why? This patch does not remove support for older chips, it just gives an
ability to disable support for certain chip families. In other words an user is
able to customize the driver for his/her needs - it could be fine to add this
ability also for the rest of chip families.

> Imagine being one of the people who has one of these cards.

Such people leave this configs as they are (enabled by default).

> Pulling out detection and working'ness of devices from a driver
> is a big step backwards, and I'm sorry I will don't want to be
> part of something that facilitates this.
> 
> The S390 folks tried something similar in the past and I reject
> those changes too.

This patch is practically the same as "a1b8714593b6 ("net/mlx4: Use Kconfig flag
to remove support of old gen2 Mellanox devices")" for mlx4 and that was accepted
without any objections.

Thanks,
Ivan
