Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B21C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E69D2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E69D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLCNql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:46:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbeLCNqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:46:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB2B930014D2;
        Mon,  3 Dec 2018 13:45:35 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 702EB5C688;
        Mon,  3 Dec 2018 13:45:30 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2] x86/hyper-v: Mark TLFS structures packed
In-Reply-To: <CY4PR21MB0773D5DFA13BFA0701771F5ED7AE0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181130125422.21494-1-vkuznets@redhat.com> <CY4PR21MB0773D5DFA13BFA0701771F5ED7AE0@CY4PR21MB0773.namprd21.prod.outlook.com>
Date:   Mon, 03 Dec 2018 14:45:28 +0100
Message-ID: <874lbuyb9j.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 03 Dec 2018 13:45:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Friday, November 30, 2018 4:54 AM
>> 
>> @@ -466,7 +466,7 @@ union hv_message_flags {
>>  	struct {
>>  		__u8 msg_pending:1;
>>  		__u8 reserved:7;
>> -	};
>> +	} __packed;
>>  };
>> 
>>  /* Define port identifier type. */
>
> I think __packed is also needed in the definition
> of struct u defined within union hv_port_id.  That
> struct has bit fields, so shouldn't it be done just like
> union hv_message_flags above?
>

True, missed it, thanks! Will send v3 out shortly.

-- 
Vitaly
