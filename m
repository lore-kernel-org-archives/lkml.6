Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FA9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800192087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800192087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeIYLvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:51:16 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:53850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbeIYLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:51:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 546E7100E86C1;
        Tue, 25 Sep 2018 05:45:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: price76_2f030183bad1a
X-Filterd-Recvd-Size: 1633
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 05:45:22 +0000 (UTC)
Message-ID: <ad3efc558479ccfc1f36fcd936d2e58d1c290019.camel@perches.com>
Subject: Re: [PATCH 3.18 104/105] IB/nes: Fix a compiler warning
From:   Joe Perches <joe@perches.com>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Date:   Mon, 24 Sep 2018 22:45:21 -0700
In-Reply-To: <20180924223952.GA9157@sasha-vm>
References: <20180924113113.268650190@linuxfoundation.org>
         <20180924113123.002918395@linuxfoundation.org>
         <6f7ca3c205bada768c3918b1feacbbd5ce23a64d.camel@perches.com>
         <20180924175902.GB19402@kroah.com>
         <6d6f31c87b0c9b1a551d352439183c8c9c4df04c.camel@perches.com>
         <20180924223952.GA9157@sasha-vm>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-09-24 at 22:39 +0000, Sasha Levin wrote:
> The reasoning behind it was similar to the "no warnings" reasoning of
> upstream: there might be real issues hiding in the sea of "harmless"
> warnings, so we want to get rid of all of them to catch real issues.

I believe this to be a poor idea for -stable acceptance.

It's impossible to know when gcc or any other compiler
would decide to add any new warning.


