Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BBEC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA520C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 01:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECA520C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbeHTFMD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:12:03 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:43616 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeHTFMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:12:03 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95b7a2035914-6033a; Mon, 20 Aug 2018 09:58:13 +0800 (CST)
X-RM-TRANSID: 2ee95b7a2035914-6033a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.16.200.163] (unknown[112.25.154.149])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b7a203457c-0e372;
        Mon, 20 Aug 2018 09:58:13 +0800 (CST)
X-RM-TRANSID: 2eea5b7a203457c-0e372
Content-Type: text/plain; charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ip_vti: fix a null pointer deferrence when create vti
 fallback tunnel
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20180819.112753.320024709787799108.davem@davemloft.net>
Date:   Mon, 20 Aug 2018 09:58:11 +0800
Cc:     steffen.klassert@secunet.com, kuznet@ms2.inr.ac.ru,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        edumazet@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <92EF6630-83A9-4F42-8444-8E67C801208E@cmss.chinamobile.com>
References: <1534662305-16734-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
 <20180819.112753.320024709787799108.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 2018年8月20日, at 上午2:27, David Miller <davem@davemloft.net> wrote:
> 
> From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> Date: Sun, 19 Aug 2018 15:05:04 +0800
> 
>> After set fb_tunnels_only_for_init_net to 1, the itn->fb_tunnel_dev will
>> be NULL and will cause following crash:
> ...
>> Reproduce:
>> echo 1 > /proc/sys/net/core/fb_tunnels_only_for_init_net
>> modprobe ip_vti
>> unshare -n
>> 
>> Fixes: 79134e6ce2c9 (net: do not create fallback tunnels for non-default
>> namespaces)
>> Cc: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
> 
> Applied, but please format your Fixes: tag properly next time.
> 
> Do not split up a Fixes tag into multiple lines, no matter how long it
> is.  And enclose the commit header text in both parenthesis and double
> quotes, not just parenthesis.  Like ("blah blah blah"), thank you.
> 

Okay, thanks for reviewing.

