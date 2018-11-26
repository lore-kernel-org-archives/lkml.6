Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E15C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ABD20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ABD20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeK0Gp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:45:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34009 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeK0Gp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:45:28 -0500
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAQJngPC1524699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 26 Nov 2018 11:49:42 -0800
Subject: Re: [PATCH] x86/fpu: XRSTOR is expected to raise #GP
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        kernel-hardening@lists.openwall.com,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20181126172706.184008-1-jannh@google.com>
 <20181126174945.r2ubrlg2gzwog2ez@linutronix.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <4d4c4f1f-72e3-0182-151e-8bd455ccd143@zytor.com>
Date:   Mon, 26 Nov 2018 11:49:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181126174945.r2ubrlg2gzwog2ez@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/18 9:49 AM, Sebastian Andrzej Siewior wrote:
> On 2018-11-26 18:27:06 [+0100], Jann Horn wrote:
>> commit 75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess
>> fixups") incorrectly replaced the fixup entry for XSTATE_OP with a
>> user-#PF-only fixup. However, XRSTOR can also raise #GP when the supplied
>> address points to userspace memory. Change it back.
> 
> The #GP is raised if the xstate content is invalid. But I guess the
> details don't matter.
> 
>> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Fixes: 75045f77f7a7 ("x86/extable: Introduce _ASM_EXTABLE_UA for uaccess fixups")
>> Signed-off-by: Jann Horn <jannh@google.com>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 

It does matter -- please correct the patch description, or we might have some
serious confusion at some arbitrary point in the future with the result that
the bug gets re-introduced; it would not be the first time.

	-hpa

