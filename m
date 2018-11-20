Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364ECC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B0020684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B0020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeKUEyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:54:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33639 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbeKUEyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:54:02 -0500
Received: from hanvin-mobl2.amr.corp.intel.com ([134.134.139.82])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id wAKIN1l13067053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 20 Nov 2018 10:23:02 -0800
Subject: Re: [PATCH v5 02/10] x86/jump_label: Use text_poke_early() during
 early init
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20181113130730.44844-1-namit@vmware.com>
 <20181113130730.44844-3-namit@vmware.com>
 <76c41854-b12d-5c4e-cfa4-f448e102860b@zytor.com>
 <20181120181830.GB2131@hirez.programming.kicks-ass.net>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <34f7e083-218e-dbdf-73ca-47dd11e750cc@zytor.com>
Date:   Tue, 20 Nov 2018 10:23:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120181830.GB2131@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 10:18 AM, Peter Zijlstra wrote:
>>
>> Can't we make this test in text_poke() directly, please?
> 
> He does that in 9/10 iirc.
> 

No, in 9/10 he does that change locally for the jump_label, but there is
absolutely no reason not to do that test in text_poke() proper, and
simply use text_poke() everywhere in the kernel.

	-hpa

