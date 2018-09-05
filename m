Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E266DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F652075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGNx2Jp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F652075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeIEX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:26:02 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43266 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeIEX0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:26:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id h64-v6so6896247lfi.10;
        Wed, 05 Sep 2018 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L40QfUfqELILge77L2Oi58OVOgVXdMv16buiRzoMXJ4=;
        b=TGNx2Jp2yqfrFAJUb5JPmzQuF9fru33a5k/BWR6zhA3k7/cC7xvOEQK2EhE7EUV5yj
         alyBPO/7/aoHRevXXNQG8VqBA1GTt6VAcRr7GRxgR+S8KfOLBs90RG1oUf5uluB1j2cM
         OVw638fG9YaEk2v68HgpOSKEzQ7+rxn7aiEBYtqCwLLZDTK7oS6zc/EPVovZ1rSmHQOC
         UnjO/DiqX1xKRfchlSvKAtzeT6Oeu2bObvk6718Uy2/ZIZpgw5W60PlZBkSfdw54QkP8
         bLx4WhdkuY9PIWE6TC/QZRMSrZZA2Hznywgz76x9fzXmmkDfYh8q5j61e5AOGeRL7uTh
         2w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L40QfUfqELILge77L2Oi58OVOgVXdMv16buiRzoMXJ4=;
        b=cdcM7jQpsfatnPKRwP/8OXtKrNcETrklfGnbSqyA5qdetDrjxaFPOisUWgmkSYuwDP
         +ivLuyqwV/GsW2yZ/YklK4+ozmPifq5vpVpS5DC045p6O+duLEl9KRv1T5X5YICz3JK1
         VUZ9thqW4rI3vxrH9IHz3/sqafmNVDKQ99brn30F5lS0asLSIYRCcNlZDx1xlRGLs73X
         KxqpEXnd1hdexVxhabJjEdzCJI2HdU24TRqt5rDfxEjULDWE32/Y9GyhCtiy0mdNHZ3E
         r5wuPDPaL8FteonfcUnnMBnBExpzBl1Sip0qu0STUpBqjM9wB7CDBGqfhmUEp3RU2FE+
         Ztkg==
X-Gm-Message-State: APzg51D1/HJPcL8HppoS1jAtqqGzcN9y2wd/iNhlcDxV+Hldvzsxy0/j
        tFfGtH0CrPZJed1clbAtnuiRg348
X-Google-Smtp-Source: ANB0VdZAsp4Rbg+1NDKxhlf9YXvmvRjaRDZcPJ/SVXwsozTOwkXuVSig97sz4i/fNLO3BRjRCSloYw==
X-Received: by 2002:a19:db94:: with SMTP id t20-v6mr24197473lfi.126.1536173672742;
        Wed, 05 Sep 2018 11:54:32 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id 6-v6sm439233lfv.36.2018.09.05.11.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 11:54:32 -0700 (PDT)
Subject: Re: [PATCH] infiniband: nes: add unlikely() to assert()
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Chien Tung <chien.tin.tung@intel.com>,
        Roland Dreier <rolandd@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180831192418.12346-1-igor.stoppa@huawei.com>
 <20180905060106.GI2977@mtr-leonro.mtl.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <62351491-66cb-0541-85e4-481251433a19@gmail.com>
Date:   Wed, 5 Sep 2018 21:54:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905060106.GI2977@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/18 09:01, Leon Romanovsky wrote:
> On Fri, Aug 31, 2018 at 10:24:18PM +0300, Igor Stoppa wrote:
>> Typically the assert is expected to not fail.
> 
> This whole assert can be removed.

ok

>>
>> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
>> Acked-by: Doug Ledford <dledford@redhat.com>
> 
> Most probably that I missed discussion, but anyway, does this
> "Acked-by" come from internal or external discussion?

https://lkml.org/lkml/2018/8/31/456

--
igor
