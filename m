Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A13DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7072B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfAVXIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:08:36 -0500
Received: from gateway23.websitewelcome.com ([192.185.48.84]:34155 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbfAVXIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:08:36 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id CBBE341E9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 17:08:35 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m59ngs8p2YTGMm59ngamlC; Tue, 22 Jan 2019 17:08:35 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=58238 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gm59n-003Ush-B9; Tue, 22 Jan 2019 17:08:35 -0600
Subject: Re: [PATCH] x86/platform/UV: Replace kmalloc and memset with kzalloc
 and kcalloc
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20190115173713.GA31031@embeddedor>
 <20190116120647.GE15409@zn.tnic>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Message-ID: <941b300b-c1c7-ae50-33cf-1f5cee788360@embeddedor.com>
Date:   Tue, 22 Jan 2019 17:08:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116120647.GE15409@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gm59n-003Ush-B9
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.130.205]:58238
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/19 6:06 AM, Borislav Petkov wrote:

>> -	vp = kmalloc_array(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
>> -	uvhub_descs = (struct uvhub_desc *)vp;
>> -	memset(uvhub_descs, 0, nuvhubs * sizeof(struct uvhub_desc));
>> +	uvhub_descs = kcalloc(nuvhubs, sizeof(*uvhub_descs), GFP_KERNEL);
> 				       ^^^^^^^^^^^^^^^^^^^^
> 
> I'm changing that back to sizeof(struct uvhub_desc) as it is clearer
> this way.
> 

Okay.

Thanks, Boris.

--
Gustavo
