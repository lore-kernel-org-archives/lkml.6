Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D352098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D352098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJLN6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:58:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbeJLN6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:58:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 306378830A;
        Fri, 12 Oct 2018 06:27:49 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-201.brq.redhat.com [10.40.204.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C750842CD;
        Fri, 12 Oct 2018 06:27:46 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "davem\@davemloft.net" <davem@davemloft.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot info
In-Reply-To: <MWHPR21MB0176EB148DC772F9DC5845D2CAE10@MWHPR21MB0176.namprd21.prod.outlook.com>
References: <20181011201434.30737-1-haiyangz@linuxonhyperv.com> <MWHPR21MB0176EB148DC772F9DC5845D2CAE10@MWHPR21MB0176.namprd21.prod.outlook.com>
Date:   Fri, 12 Oct 2018 08:27:45 +0200
Message-ID: <87k1mnptlq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 12 Oct 2018 06:27:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiyang Zhang <haiyangz@microsoft.com> writes:

>> -----Original Message-----
>> From: Haiyang Zhang <haiyangz@linuxonhyperv.com>
>> Sent: Thursday, October 11, 2018 4:15 PM
>> To: davem@davemloft.net; netdev@vger.kernel.org
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
>> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
>> olaf@aepfle.de; vkuznets <vkuznets@redhat.com>;
>> devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
>> Subject: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot info
>> 
>> From: Haiyang Zhang <haiyangz@microsoft.com>
>> 
>> The VF device's serial number is saved as a string in PCI slot's kobj name, not
>> the slot->number. This patch corrects the netvsc driver, so the VF device can be
>> successfully paired with synthetic NIC.
>> 
>> Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
>> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
>
> Thanks Stephen for the reminder -- I added the "reported-by" here:
>
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks) 

The difference in the hack I sent to Stephen was that instead of using
kstrtou32() and checking the return value I opted for snprintf() and
doing strncmp().

-- 
Vitaly
