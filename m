Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B9C208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dIwX2fCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B9C208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbeG0RIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:08:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52232 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732981AbeG0RId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j97HSwSohy+z/WZgacLHtQOvtWFHjrrR7dz/jfs0qNU=; b=dIwX2fCo3x6x/kWI3gkA7TsAQ/
        NM7IUH1DJuoc7MJDCgdyGuVKxKBvtMI1eVCydHkwUk4tOzZFn3FM5/1i4Xn1zt7pmzcngqnjx2cyA
        gs4/geUuK7pawmBc3YEviXvwNZZuIB5c+A8IIBt2ajrOSJ1eCfMJSp3S7wz6CYvwbC7rD8nHTjKpn
        JNZLWOIRZC3OwEuNsITsCCSNo/QI7eAEuJos6h6QASx2ugRlDPkex7aQUFHUdPLR8CEFVg30+/xx1
        ty7jZ4GvFmXeEoKoKc7+Q2xaDfRhQK5qAXQDCkrsZ4aKyJEfk9BhS0yl1Pws8NB9qd1TXQEAqRDJ1
        hY40in/Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fj4wM-0004Ln-KJ; Fri, 27 Jul 2018 15:46:02 +0000
Subject: Re: [PATCH] hostap: hide unused procfs helpers
To:     YueHaibing <yuehaibing@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     j@w1.fi, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, davem@davemloft.net
References: <20180713070317.6724-1-yuehaibing@huawei.com>
 <5B485441.1080305@broadcom.com> <87r2jpvxme.fsf@codeaurora.org>
 <9c6401cd-c04c-1230-d360-922b476c6541@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c6fda6cf-3041-66f0-71b8-f86ccadc9260@infradead.org>
Date:   Fri, 27 Jul 2018 08:46:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9c6401cd-c04c-1230-d360-922b476c6541@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 03:03 AM, YueHaibing wrote:
> On 2018/7/27 17:25, Kalle Valo wrote:
>> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>>
>>> + Randy
>>>
>>> On 7/13/2018 9:03 AM, YueHaibing wrote:
>>>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>>>
>>>> drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: ‘prism2_registers_proc_show’ defined but not used [-Wunused-function]
>>>>   static int prism2_registers_proc_show(struct seq_file *m, void *v)
>>>>
>>>> drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: ‘prism2_debug_proc_show’ defined but not used [-Wunused-function]
>>>>   static int prism2_debug_proc_show(struct seq_file *m, void *v)
>>>>              ^
>>>> drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: ‘prism2_stats_proc_show’ defined but not used [-Wunused-function]
>>>>   static int prism2_stats_proc_show(struct seq_file *m, void *v)
>>>>              ^
>>>> drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: ‘prism2_crypt_proc_show’ defined but not used [-Wunused-function]
>>>>   static int prism2_crypt_proc_show(struct seq_file *m, void *v)
>>>>              ^
>>>>
>>>> fix this by adding #ifdef around them.
>>>> hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
>>>> into #ifdef.
>>>
>>> There was already a fix for this posted by Randy Dunlap taking a
>>> different approach, ie. use __maybe_unused classifier. To be honest I
>>> prefer the ifdef approach as it is more explicit and does not feel
>>> like a cheat.
>>
>> I also prefer the ifdef approach more so I'm planning to take this
>> patch.
> 
> It's ok if you prefer pick this.

Right.

-- 
~Randy
