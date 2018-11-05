Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC50C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8261A20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="CcvxmVC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8261A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=scalemp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbeKFCA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:00:58 -0500
Received: from www.scalemp.com ([169.44.78.149]:47312 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387583AbeKFCA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WralRNJwXXyuqUmV/K0cRPyssQL+v9bybI84Dz7Y6B8=; b=CcvxmVC/5mu9h9arWAFJQ3tMwp
        rpc10p9aDy7IldZqPS3HlZ7GwTqSKUVUMfmwhC1SZJTjlu65y1pJOWTiw5Fg+6yWGacC+Nvdva3KW
        34g6YWKujryWNjRuZj+BKY5101OhdpqPDl618ZGkCO5SY+fNEAu6pyb6r4hGmTKq3QC0=;
Received: from bzq-80-45-146.red.bezeqint.net ([82.80.45.146]:18493 helo=[10.100.0.120])
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1gJhvO-000ruJ-Nc; Mon, 05 Nov 2018 11:40:26 -0500
Subject: Re: [tip:x86/urgent] x86/vsmp: Remove dependency on pv_irq_ops
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, shai@scalemp.com, jgross@suse.com,
        hpa@zytor.com, linux-tip-commits@vger.kernel.org
References: <1541404864-31603-1-git-send-email-eial@scalemp.com>
 <tip-7f2d7f8190d856949d8aaab55d3902cd10ea1048@git.kernel.org>
 <20181105154139.GA124398@gmail.com>
 <alpine.DEB.2.21.1811051644040.1566@nanos.tec.linutronix.de>
From:   Eial Czerwacki <eial@scalemp.com>
Organization: ScaleMP
Message-ID: <c2b4c397-1789-aef0-e7fd-28abb0104c6d@scalemp.com>
Date:   Mon, 5 Nov 2018 18:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1811051644040.1566@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On 11/05/2018 05:44 PM, Thomas Gleixner wrote:
> On Mon, 5 Nov 2018, Ingo Molnar wrote:
> 
>>
>> * tip-bot for Eial Czerwacki <tipbot@zytor.com> wrote:
>>
>>> Commit-ID:  7f2d7f8190d856949d8aaab55d3902cd10ea1048
>>> Gitweb:     https://git.kernel.org/tip/7f2d7f8190d856949d8aaab55d3902cd10ea1048
>>> Author:     Eial Czerwacki <eial@scalemp.com>
>>> AuthorDate: Mon, 5 Nov 2018 10:01:04 +0200
>>> Committer:  Thomas Gleixner <tglx@linutronix.de>
>>> CommitDate: Mon, 5 Nov 2018 12:33:47 +0100
>>>
>>> x86/vsmp: Remove dependency on pv_irq_ops
>>>
>>> vsmp dependency on pv_irq_ops has been removed some years ago, but the code
>>> still deals with pv_irq_ops.
>>
>> s/vsmp
>>  /vSMP
>>
>>> +#if defined CONFIG_PCI
>>
>> I don't think code was ever tested with PCI disabled?
>>
>> The above typoed sequence of code accidentally evaluates to 'true' 
>> regardless of CONFIG_PCI.
> 
> Grr. Indeed, missed that
> 
> 

actually I've tested it with CONFIG_PCI unset but evidently I've managed
to mess up the test somehow.
thanks for pointing this out, I'll send a patch that fixes it.

Eial.
