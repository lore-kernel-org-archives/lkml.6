Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65941C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B75214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B75214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbeHGNtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:49:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbeHGNtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:49:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64FF240216E4;
        Tue,  7 Aug 2018 11:35:20 +0000 (UTC)
Received: from [10.43.2.69] (unknown [10.43.2.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E88E41C5B7;
        Tue,  7 Aug 2018 11:35:18 +0000 (UTC)
Subject: Re: [PATCH] Use Kconfig flag to remove support of deprecated BE2/BE3
 adapters
To:     Christoph Hellwig <hch@infradead.org>, Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, Sathya Perla <sathya.perla@broadcom.com>,
        Ajit Khaparde <ajit.khaparde@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
References: <20180806121230.23690-1-poros@redhat.com>
 <20180806162153.GA22040@infradead.org>
From:   Ivan Vecera <ivecera@redhat.com>
Message-ID: <e70d9925-0836-cefc-0cfe-747067c6c948@redhat.com>
Date:   Tue, 7 Aug 2018 13:35:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180806162153.GA22040@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 07 Aug 2018 11:35:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 07 Aug 2018 11:35:20 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ivecera@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.8.2018 18:21, Christoph Hellwig wrote:
> On Mon, Aug 06, 2018 at 02:12:28PM +0200, Petr Oros wrote:
>>   Add flags to remove support of deprecated BE2/BE3 adapters.
>>   BE2 disable will reduce .ko size by 2kb and BE3 by 3kb.
>>   Disable both will reduce .ko size by 9kb.
>>
>>   With dissabled support is also removed coresponding PCI IDs
>>   and codepath with [BE2|BE3|BEx]_chip checks.
> 
> deprecated seems like a really odd world for hardware.
> 
> Are they just old?  Did they never ship in large numbers?
> 
> If you just make some cards optional why not also add options
> for families of newer cards for those who only have the older ones
> in their systems?
> 
This also makes sense.

I.
