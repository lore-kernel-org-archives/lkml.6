Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5037ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6842083B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRiEFt6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6842083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbeGMQ6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:58:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40012 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbeGMQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Nm04pnDekcA+lc3AskuXThditEW148sN/pMoikKjFE=; b=aRiEFt6OWlllsepPLaJWId1ua
        I/jgn7m2S+fNj58Qk+aAp/E+mDKevkc5CvhudfcGErY84aN38QHJUvsAbDL1ZPo0CtMtIyykXVvjL
        iGjAb9xBmPS+bSP1qkf2qBOPfExRZVAE+Z+ShCDgPzFJui5b/GqLut6wimM8oXUvbH/KSMn98dcew
        0m9Q377EQ40ZNotJnxgDniBAu6aOtjDLSGLiJJvmJ2HVjZ9+p5kQ7k+42VZM7Sz72q9wrxWhVDcHB
        EOUBVTENwP4sJue4tBwqv4Bq7oVhaHsKqXyZxuCEd/ySn37qXXzXiW0WXIIaJZ1gLlADlwhcaB/Ub
        BvRGoZ2Kg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fe19u-0005ah-0o; Fri, 13 Jul 2018 16:43:06 +0000
Subject: Re: [PATCH] hostap: hide unused procfs helpers
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>, j@w1.fi, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, davem@davemloft.net
References: <20180713070317.6724-1-yuehaibing@huawei.com>
 <5B485441.1080305@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a2dee6c-eca3-ca0f-8af6-2ecc14f6d0a9@infradead.org>
Date:   Fri, 13 Jul 2018 09:43:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B485441.1080305@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 12:26 AM, Arend van Spriel wrote:
> + Randy
> 
> On 7/13/2018 9:03 AM, YueHaibing wrote:
>> When CONFIG_PROC_FS isn't set, gcc warning this:
>>
>> drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: ‘prism2_registers_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_registers_proc_show(struct seq_file *m, void *v)
>>
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: ‘prism2_debug_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_debug_proc_show(struct seq_file *m, void *v)
>>              ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: ‘prism2_stats_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_stats_proc_show(struct seq_file *m, void *v)
>>              ^
>> drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: ‘prism2_crypt_proc_show’ defined but not used [-Wunused-function]
>>   static int prism2_crypt_proc_show(struct seq_file *m, void *v)
>>              ^
>>
>> fix this by adding #ifdef around them.
>> hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
>> into #ifdef.
> 
> There was already a fix for this posted by Randy Dunlap taking a different approach, ie. use __maybe_unused classifier. To be honest I prefer the ifdef approach as it is more explicit and does not feel like a cheat.

Hi,
You are welcome to merge (or ack or have someone else merge) either of them.
I'm not counting patches, just trying to help out (in this case by reducing noise).



> Actually some of the functions are between a flag already PRISM2_NO_PROCFS_DEBUG which is in a private header file hostap_config.h. Seems like this would be better placed in Kconfig and depend on CONFIG_PROCFS. Anyway, this driver is old cruft. Maybe some people are still running it, but it is probably not worth the effort so fine with either fix.
> 
> Regards,
> Arend


-- 
~Randy
