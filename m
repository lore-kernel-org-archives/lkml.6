Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A32FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1192E25012
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 15:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOzPGeu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1192E25012
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeGAPLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 11:11:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbeGAPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 11:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cXNo213cBbFS6Q4PmkrJZh3pyEvomLUW9dsL7cvkBqY=; b=HOzPGeu0hoiEUDxbfk1xasArQ
        wSliHFBzDYfMuj1ksSdJGX685drmC7mbJqs5uWzswc3A08hkg3YvR1kvlLmoOUR5zL0smEqJE0Zqk
        aRfs1UmdkgH4b3Iwr0Y+556gtnOe1K5A8t7A4QtH30fdMK0vdD7RG5Wqwm38KDtjZ4A8TGp/2wPta
        pGHQLQC8/AM45yZ3w7QbRYknjZhjn4ujoTsD8+ZN2dEeD5fLiTFjCSeN6UxRvzxn4BRxE29A5ezcf
        G3d4TuEuoqzXbcxtBAYnUtqpnNBVs9CtUv3ZbvX4IuTXsv6ATni5eLzJFIS3Y4qKe+eZaA142GbCx
        jA/2QkbMg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fZe0m-00045K-Vz; Sun, 01 Jul 2018 15:11:37 +0000
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Jun <jun.li@nxp.com>
References: <20180629145719.0d7b8fe7@canb.auug.org.au>
 <20180701084343.GA12939@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <244bd3de-4c96-d366-6d51-d3ce9642713e@infradead.org>
Date:   Sun, 1 Jul 2018 08:11:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180701084343.GA12939@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/18 01:43, Greg KH wrote:
> On Fri, Jun 29, 2018 at 02:57:19PM +1000, Stephen Rothwell wrote:
>> Hi Greg,
>>
>> Today's linux-next merge of the usb tree got a conflict in:
>>
>>   drivers/staging/typec/Kconfig
>>
>> between commit:
>>
>>   e16711c32bca ("staging/typec: fix tcpci_rt1711h build errors")
>>
>> from the usb.current tree and commit:
>>
>>   990da41530b3 ("staging: typec: tcpci: move tcpci drivers out of staging")
>>
>> from the usb tree.
>>
>> I fixed it up (I removed the file and allpied the patch below) and can
>> carry the fix as necessary. This is now fixed as far as linux-next is
>> concerned, but any non trivial conflicts should be mentioned to your
>> upstream maintainer when your tree is submitted for merging.  You may
>> also want to consider cooperating with the maintainer of the conflicting
>> tree to minimise any particularly complex conflicts.
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Fri, 29 Jun 2018 14:54:04 +1000
>> Subject: [PATCH] usb: update for tcpci drivers moving out of staging
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>  drivers/usb/typec/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
>> index 972fd1911045..ee808903983f 100644
>> --- a/drivers/usb/typec/Kconfig
>> +++ b/drivers/usb/typec/Kconfig
>> @@ -65,6 +65,7 @@ config TYPEC_TCPCI
>>  
>>  config TYPEC_RT1711H
>>  	tristate "Richtek RT1711H Type-C chip driver"
>> +	depends on I2C
> 
> Thanks for this, I'll apply this to my tree when I merge these together
> in a few days.

I suppose that I could ack it since it's the same as my patch except
for the line numbers...

-- 
~Randy
