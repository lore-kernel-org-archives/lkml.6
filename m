Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D582C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFE62082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tb7KyShu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFE62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeLKNdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:33:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49118 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:33:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBBDWdDA086348;
        Tue, 11 Dec 2018 07:32:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544535159;
        bh=Y+yfj3rJdcOxf0IL9jSvKQdzDMJM+vVEZXfNt4j07Uc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tb7KyShu+CJ1Sr/oQVgZ9B3QFWgEzskbta27jwI/5VLuU33+JalBvQEk8i6d6p9gV
         ADZ7gewfuw4pgfKaYXMe9mZjd7LVofLGnQtOCwAy3dtt6hT+nmb7ca2rJivBi51Sjq
         OQuS+9W7TJhWnI/GTEVaTXvkmkfVldM9MQ69Ukeg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBBDWdua082186
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Dec 2018 07:32:39 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 11
 Dec 2018 07:32:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 11 Dec 2018 07:32:39 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBBDWZLB030930;
        Tue, 11 Dec 2018 07:32:35 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am654-base-board: Add MMC/SD
 support
To:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
CC:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>, <kishon@ti.com>,
        <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>
References: <20181207084233.13700-1-faiz_abbas@ti.com>
 <20181207084233.13700-3-faiz_abbas@ti.com>
 <20181208155427.jmidz4vsw4k4qj36@akan>
 <c1dd9783-84dc-9dad-ea94-9a14a4ad814d@ti.com>
 <20181210120647.i3ply3p7umvedb3u@akan> <20181210234730.GH6707@atomide.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <f2f31347-3aa3-8dda-84a3-bd112aa3ff9d@ti.com>
Date:   Tue, 11 Dec 2018 19:02:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210234730.GH6707@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/12/18 5:17 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [181210 12:07]:
>> I really am curious how Arnd / Tony actually pull this one off.. If they
>> have continous cron job for checking if your patch is ready... I doubt
>> it..
> 
> The only way that works in a distributed manner is for the patch
> authors to resend after the dependencies have cleared.
> 
> As some people don't know this, at least I try to reply with
> something about tagging patch as read and assuming it will get
> resent after dependencies have cleard.
> 
> Otherwise the todo list just keeps growing eternally :)

Alright, if the preference is to resend patches after dependencies are
cleared, I think it will also be better to mark the initial review-only
version as "RFC" (as Nishanth requested).

Thanks,
Sekhar
