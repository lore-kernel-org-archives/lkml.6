Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCCAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED44B20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED44B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGZV6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:58:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46430 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbeGZV6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:58:05 -0400
Received: from localhost (unknown [172.58.43.154])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 233B9108CB34A;
        Thu, 26 Jul 2018 13:39:34 -0700 (PDT)
Date:   Thu, 26 Jul 2018 13:39:20 -0700 (PDT)
Message-Id: <20180726.133920.1400134352576859104.davem@davemloft.net>
To:     jdmason@kudzu.us
Cc:     helgaas@kernel.org, f.fainelli@gmail.com, rasesh.mody@cavium.com,
        sudarsana.kalluru@cavium.com, Dept-GELinuxNICDev@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sort Kconfig menu items alphabetically
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180724154340.GA5871@kudzu.us>
References: <153237967407.172440.6754268418710104431.stgit@bhelgaas-glaptop.roam.corp.google.com>
        <20180724154340.GA5871@kudzu.us>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 26 Jul 2018 13:39:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 24 Jul 2018 11:43:41 -0400

> On Mon, Jul 23, 2018 at 04:01:14PM -0500, Bjorn Helgaas wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>> 
>> 6c541b4595a2 ("net: ethernet: Sort Kconfig sourcing alphabetically")
>> sorted Kconfig sourcing based on directory names, but in a couple cases,
>> the menu item text is quite different from the directory name and is not
>> sorted correctly:
>> 
>>   drivers/net/ethernet/neterion/Kconfig    => "Exar devices"
> 
> Stupid question, does it make more sense to clarify the names in the
> Kconfig to more naturally follow what people are expecting?  In the
> case of Neterion, it was standalone for several years, then aquired by
> Exar and shutdown in 11 months without ever making any Exar branded
> adatpers.  Users, if they still exist, would probably think of it as
> Neterion and not Exar (as there have been no follow-on adapters and I
> don't believe any plans to ever do so).
> 
> So, this might be better as a rename of the Kconfig to something like
> "Neterion (Exar) devices".  Of course, there is a fair amount of Exar
> names in the Kconfig.  If you agree, I can do a clean-up of this to
> match the expectations.
> 
> Thoughts?

I think this is a better way to handle this.

That way, a developer can read the Kconfig file and see if the entries
are sorted properly without having to check the text of every
sub-directory entry.
