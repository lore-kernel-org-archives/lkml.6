Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAB8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1CA20666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dNNapWrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1CA20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeJBDtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:49:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43382 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeJBDtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:49:20 -0400
Received: from dflxv17.itg.ti.com ([128.247.5.93])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w91L9Jbe101369;
        Mon, 1 Oct 2018 16:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538428159;
        bh=YFdF/QUPHeQlxd5BebFmh4/k+hLy5ZOlDhe8RPPmm/A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dNNapWrTcF7N9+uXkO58DyzirtMMN/YXiSaFf1BzMaNDxgH6uV1ew+JG2nI52+E14
         jHIEtQDRH5MXsPvpIHFoSPbN67Xjvh8w9VCan4n2/OPbcQOvHZyxi5a17T8lrVmYP9
         /X340MKilI+ZpwFHhjmY8G4BlW/hblo3doEABut0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv17.itg.ti.com (8.14.3/8.13.8) with ESMTP id w91L9JkY008943;
        Mon, 1 Oct 2018 16:09:19 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 1 Oct
 2018 16:09:19 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 1 Oct 2018 16:09:19 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w91L9IhT001703;
        Mon, 1 Oct 2018 16:09:19 -0500
Subject: Re: [PATCH] samples/rpmsg: Introduce a module parameter for message
 count
To:     Trilok Soni <tsoni@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180911174643.26199-1-s-anna@ti.com>
 <2d904881-ec72-dd68-48ff-b8307642bc63@codeaurora.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <2134784b-8645-cbf3-41af-7c9cc800a146@ti.com>
Date:   Mon, 1 Oct 2018 16:09:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2d904881-ec72-dd68-48ff-b8307642bc63@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trilok,

On 09/11/2018 01:17 PM, Trilok Soni wrote:
> Bjorn,
> 
>>     #define MSG        "hello world!"
>> -#define MSG_LIMIT    100
>> +
>> +static int count = 100;
>> +module_param(count, int, 0644);
> 
> I thought Greg KH doesn't want any new code to have module_param call,
> right? Are we Ok here or I am missing something here.

Can you point me to the thread where this was discussed/decided?

regards
Suman

