Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3kXpIgSeGVv5UAAAmS7hNA
	; Thu, 07 Jun 2018 21:06:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3DEEF606FA; Thu,  7 Jun 2018 21:06:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CE64960290;
	Thu,  7 Jun 2018 21:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE64960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeFGVGE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 17:06:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51147 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbeFGVGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 17:06:03 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w57L5okh2334854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Jun 2018 14:05:51 -0700
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when
 vdso disabled on X86?
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86l <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: yaomin2@huawei.com
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com>
 <5B17A6B6.70300@huawei.com> <B2D1D0A5-D35B-435C-9548-1FB5964F61BA@zytor.com>
 <5B188E2B.7040700@huawei.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <64b61360-803d-b987-6721-e9eb0ebe63a7@zytor.com>
Date: Thu, 7 Jun 2018 14:05:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B188E2B.7040700@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/18 18:45, Leizhen (ThunderTown) wrote:
>>
>> The use of signals without SA_RESTORER is considered obsolete, but it's somewhat surprising that the vdso isn't there; it should be mapped even for static binaries esp. on i386 since it is the preferred way to do system calls (you don't need to parse the ELF for that.) Are you explicitly disabling the VDSO? If so, Don't Do That.
> 
> Yes, the vdso was explicitly disabled by the tester. Thanks.
> 

Are there any use cases that calls for this?  Maybe we should drop this
option.

	-hpa
