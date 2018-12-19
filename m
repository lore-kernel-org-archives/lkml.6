Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB59C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73F320874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545258081;
	bh=RLADdjcKtj1yfYyD1MrTgqWs7rZshn1/U93urKThF48=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=cIV7CmuuN0ggteSplN0OvikZUZl6znZR1SQ1prR0xgLLi9FcbuZAlcaOGu5zwPyFc
	 hG/h7OlMAwBcm6HuwW28s3plN2qqUIyvXPS1IS6vuGG23R1nVHZPitSMpMuZGJoRKy
	 mvcmaUqxexbv8DQYn7FI9zeEMbtKbBPTGv5jivQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeLSWVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbeLSWVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:21:18 -0500
Received: from [192.168.1.29] (host92-112-dynamic.25-79-r.retail.telecomitalia.it [79.25.112.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82E302086C;
        Wed, 19 Dec 2018 22:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545258078;
        bh=RLADdjcKtj1yfYyD1MrTgqWs7rZshn1/U93urKThF48=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h1HitGH+9jlinwCgyOmpaN0IT0YpOwOciqIPQwhJf40ZSnvqaJ/x1UlxUQZHFwwHv
         NXyMRZIZylT9pqPVubz5kzAItEBSgc5ik5z6t9P/vXDirIcrH/ZiJ2T5pCi1Fq8G23
         pEkpSDwBl0g7uE25mhfcl2/9R9+ZqThkaVXDRPGk=
Subject: Re: [PATCH v11 1/7] ACPI: Allow CONFIG_PCI to be unset for reboot
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
 <20181218025606.32668-2-okaya@kernel.org>
 <20181218073139.GA8612@infradead.org>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <0fe1a7e1-216f-9a75-df48-09bf7eca7a64@kernel.org>
Date:   Wed, 19 Dec 2018 23:21:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181218073139.GA8612@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/2018 8:31 AM, Christoph Hellwig wrote:
>> @@ -44,8 +47,9 @@ void acpi_reboot(void)
>>   		/* Write the value that resets us. */
>>   		pci_bus_write_config_byte(bus0, devfn,
>>   				(rr->address & 0xffff), reset_value);
>> +#endif
> This would be a lot cleaner if this was split into a little helper
> function.
> 

done.
