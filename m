Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E27ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D9D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSvLzfSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D9D20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKIBZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbeKIBZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:25:11 -0500
Received: from localhost (unknown [63.64.74.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2406F20827;
        Thu,  8 Nov 2018 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541692146;
        bh=i19at21Ymc3PPnL6nh9DZCQPxyrNmn0SuRjtKMSDlOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSvLzfSp4AVTLpjfKcBZBxfcbJ0PKbIR184ZFY7LtQ0xHJl5HJIfX34Jki9lt6vzo
         XZug0I/+ntIt8YVvQ/x8rIa4dmkLseunAACiHfwrncWTFbwIEh/5Z0jQ8hJMa0T6Jb
         W30TcLWrmX7D5ePReHq6uf92SEc4gd46Q/GqbOgc=
Date:   Thu, 8 Nov 2018 10:49:04 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Paolo Pisati <p.pisati@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable, netdev 4.4+] lan78xx: make sure RX_ADDRL &
 RX_ADDRH regs are always up to date
Message-ID: <20181108154904.GD8097@sasha-vm>
References: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
 <20181108001751.GA8097@sasha-vm>
 <20181108110127.GA8415@harukaze>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181108110127.GA8415@harukaze>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 12:01:27PM +0100, Paolo Pisati wrote:
>On Wed, Nov 07, 2018 at 07:17:51PM -0500, Sasha Levin wrote:
>> So why not just take 760db29bdc completely? It looks safer than taking a
>> partial backport, and will make applying future patches easier.
>>
>> I tried to do it and it doesn't look like there are any dependencies
>> that would cause an issue.
>
>Somehow i was convinced it didn't build on 4.4.x... can you pick it up?
>
>commit 760db29bdc97b73ff60b091315ad787b1deb5cf5
>Author: Phil Elwell <phil@raspberrypi.org>
>Date:   Thu Apr 19 17:59:38 2018 +0100
>
>    lan78xx: Read MAC address from DT if present
>
>    There is a standard mechanism for locating and using a MAC address from
>    the Device Tree. Use this facility in the lan78xx driver to support
>    applications without programmed EEPROM or OTP. At the same time,
>    regularise the handling of the different address sources.
>
>    Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>    Signed-off-by: David S. Miller <davem@davemloft.net>

Can you confirm it actually works on 4.4?

--
Thanks,
Sasha
