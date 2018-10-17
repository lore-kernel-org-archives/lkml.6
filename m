Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB67FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24C421523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAGiO0Sy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24C421523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJQVQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbeJQVQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:16:01 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB24521523;
        Wed, 17 Oct 2018 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539782421;
        bh=QdYca3m+5VCf5CWCISHBrFraVoSGQxrTT8mI5zcaQJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAGiO0SyXLhGSuOhOyfMV6VV51K1SKml/FJHhamZrhre0KMDHYEQHwXaAaSQdOhLX
         l6QofFFUWr4Wu2K5T/dDeQBFkA4euJ8Kl/L2FrEvYHINxT2fi8gdoTbuQrUQtJtFxy
         ipUzQyFvtUjCITR4U8vgSiTQ9JyhBo0rjhTIjhxw=
Date:   Wed, 17 Oct 2018 09:20:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH 4.18 101/135] hv_netvsc: pair VF based on serial number
Message-ID: <20181017132018.GA135013@sasha-vm>
References: <20181016170515.447235311@linuxfoundation.org>
 <20181016170522.303317746@linuxfoundation.org>
 <DM5PR2101MB10138BCFD40D703FEE14EC35CAFE0@DM5PR2101MB1013.namprd21.prod.outlook.com>
 <20181017074629.GD25537@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181017074629.GD25537@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 09:46:29AM +0200, Greg Kroah-Hartman wrote:
>Also, this really feels like a "new feature" to me.  Can someone explain
>what bug this is fixing?

Reading the commit log/code it seems that it was possible for 2 (or
more) synthetic devices to have the same MAC address even though the
current code treats them as unique and uses it as a lookup index.

Let me confirm with Stephen. This came through the regular AUTOSEL
process and I don't really know more about this patch than you do at
this point.


--
Thanks,
Sasha
