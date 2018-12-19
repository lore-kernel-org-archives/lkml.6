Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804E121871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeLSDcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:32:10 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:22721 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727176AbeLSDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:32:10 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6E6231131A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 21:07:13 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZSCXgbdGTdnCeZSCXglbB7; Tue, 18 Dec 2018 21:07:13 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=57340 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gZSCW-001578-VQ; Tue, 18 Dec 2018 21:07:13 -0600
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Kees Cook <keescook@google.com>
References: <20181129112428.45287471@canb.auug.org.au>
 <20181219134243.674b80b7@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <32bfba42-ca52-57e1-d5d9-ce1d90bafc8a@embeddedor.com>
Date:   Tue, 18 Dec 2018 21:07:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219134243.674b80b7@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gZSCW-001578-VQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:57340
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 12/18/18 8:42 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 29 Nov 2018 11:24:28 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the net-next tree, today's linux-next build
>> (x86_64_allmodconfig) produced this warning:
>>
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c: In function 'run_xdp':
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:324:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     bpf_warn_invalid_xdp_action(xdp_act);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:325:2: note: here
>>    case XDP_ABORTED:
>>    ^~~~
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:326:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>     trace_xdp_exception(priv->net_dev, xdp_prog, xdp_act);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c:327:2: note: here
>>    case XDP_DROP:
>>    ^~~~
>>
>> Introduced by commit
>>
>>    7e273a8ebdd3 ("dpaa2-eth: Add basic XDP support")
>>
>> This due to my use of -Wimplicit-fallthrough.  This is new code.  The
>> warning can be suppressed by adding a comment like /* fall through */
>> at the appropriate places to indicate that the fallthrough is intended.
> 
> I am still seeing these warnings.
> 

That's weird. I don't see them anymore in next-20181218.

They were fixed by this commit: c1cb11bcbd09f5f027cbc7fadddab169714948df

Thanks
--
Gustavo
