Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4955CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDB02133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDB02133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbeK1GFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:05:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44807 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeK1GFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:05:14 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.45])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wARJ5eMH1980947
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 27 Nov 2018 11:05:41 -0800
Subject: Re: Sleeping in user_access section
To:     Julien Thierry <julien.thierry@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
 <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
 <20181123105034.GQ30658@n2100.armlinux.org.uk>
 <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <691acc7f-6ce1-69da-d56d-4d3c0fdad9ab@zytor.com>
Date:   Tue, 27 Nov 2018 11:05:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/18 3:57 AM, Julien Thierry wrote:
> 
> On x86, the EFLAGS.AC bit is also saved upon exception and I think it is
> cleared upon exception entry so there is implicit exit from the
> user_access mode when taking exception/interrupt.
> 

No, it is restored, not cleared.

In summary: on exceptions, user_access regions are suspended, and on
return the user_access status is resumed.

However, explicitly calling sleeping functions is not supported.

	-hpa

