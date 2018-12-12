Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185FCC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D301D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sTPP34Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D301D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeLLF3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:29:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42976 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbeLLF25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:28:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBC5Spq5023258;
        Tue, 11 Dec 2018 23:28:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544592531;
        bh=8Wp7UT9EZ3O1sw0avGOQExzpjhJ2PW7qPtbFoh8GirQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=sTPP34LtI2A0LRe5PQnyxQwMttqSYv4gXxT78A0Uyj3N75fTBCdMfR8m4L+Diukc5
         x0ZU6YwOA+YP1WXo7UV2ozr6npuzNLLsl/KMLYGxtBxd7RlVYGgWSCvKWjt0wMjUZP
         D1KRAhmCmsjxOXCER7zyqo7SDz3jt4gm05EHZzjk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBC5Spi7119705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 23:28:51 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 23:28:51 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 23:28:51 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBC5SnCp002268;
        Tue, 11 Dec 2018 23:28:50 -0600
Subject: Re: linux-next: manual merge of the phy-next tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>
References: <20181212151647.71a5befe@canb.auug.org.au>
 <c868398c-9410-fa2d-26f4-dd86102a3584@ti.com>
 <20181212161217.6858c3d9@canb.auug.org.au>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <470d74f1-2778-db77-641e-97310335ac42@ti.com>
Date:   Wed, 12 Dec 2018 10:58:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212161217.6858c3d9@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/12/18 10:42 AM, Stephen Rothwell wrote:
> Hi Kishon,
> 
> On Wed, 12 Dec 2018 10:37:37 +0530 Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> I've rebased by 'next' branch on top of my 'fixes' branch to avoid this conflict.
> 
> Why didn't you just merge them?

Merging will create a new merge commit which I can avoid by rebasing. Also the
patches in next branch will be above the patches in fixes branch.

Thanks
Kishon
> 
