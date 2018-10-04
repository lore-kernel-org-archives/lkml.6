Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B9EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A682084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A682084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJDUHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:07:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38489 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbeJDUHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:07:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5AAC82090A; Thu,  4 Oct 2018 15:14:00 +0200 (CEST)
Received: from bootlin.com (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0F3F3208B5;
        Thu,  4 Oct 2018 15:13:50 +0200 (CEST)
Date:   Thu, 4 Oct 2018 15:13:50 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: mvpp2: Extract the correct ethtype from the
 skb for tx csum offload
Message-ID: <20181004151350.11dfb626@bootlin.com>
In-Reply-To: <13fb6bd4-db67-6c35-9e6d-09ed89e10a45@cogentembedded.com>
References: <20181004080308.7687-1-maxime.chevallier@bootlin.com>
        <13fb6bd4-db67-6c35-9e6d-09ed89e10a45@cogentembedded.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergei,

On Thu, 4 Oct 2018 12:50:17 +0300
Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

>Hello!
>
>On 10/4/2018 11:03 AM, Maxime Chevallier wrote:
>
>> When offloading the L3 and L4 csum computation on TX, we need to extract
>> the l3_proto from the ethtype, independently of the presence of a vlan
>> tag.
>> 
>> The actual driver uses skb->protocol as-is, resulting in packets with
>> the wrong L4 checksum being sent when there's a vlan tag in the packet
>> header and checksum offloading is enabled.
>> 
>> This commit makes use of vlan_protocol_get() to get the correct ethtype
>> regardless the presence of a vlan tag.  
>             ^ of?
>
>> Fixes: 3f51850 ("ethernet: Add new driver for Marvell Armada 375 network unit")  
>
>     12 hex digits needed here.

Sorry about that, I'll resend with a proper Fixes tag.

Thanks,

Maxime
