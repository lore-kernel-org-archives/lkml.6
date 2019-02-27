Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA04C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAA520830
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QVkXwNiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfB0KdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:33:15 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52764 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfB0KdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:33:15 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id A68A210C10DA;
        Wed, 27 Feb 2019 02:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1551263594; bh=7fW13SS4AFOQkasAkFki8wa5dUGNFVXdIIMrd447xng=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=QVkXwNiBUxlmy0R+63pJuU7S14UwwXlz1cWkH4Y/nLNqZAICIuCPAcVYfi7H0Dgyo
         68nHwCqGZ7m+nKvijnIQC+va1d8ghqQqFg6o9xUK+PKZIPUMRHsTcawR0Cp4UALbxD
         FgZPHrk2IYP2r1A9HR5y7WIDiIqlm0Yc212+jSxDpF9yDS+Irw96kHTGsqifTri2BL
         JhtoQKgkjG2P9Lv/lZ0LJ18QDQVdfaIKsjWD0cJpb82YHGeklnCfC0T1FW0pjhtfdk
         OIOIA62HZJabYLGWuENh0A2czZZum6cGV72bWMK8QElhDRBh3I44JZLX2xkOphpiTZ
         JfxkecjCj6sGg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2AF33A0093;
        Wed, 27 Feb 2019 10:33:14 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Feb 2019 02:33:14 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Feb 2019 11:33:11 +0100
Received: from [10.0.2.15] (10.107.25.89) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 27 Feb
 2019 11:33:11 +0100
Subject: Re: [PATCH] i3c: master: dw-i3c-master: mark expected switch
 fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20190211221413.GA21822@embeddedor>
 <87e0a8c9-82f6-3f41-bdb6-162a4c264132@embeddedor.com>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <0edcc5fb-6b7b-65cf-227d-af510cabc29c@synopsys.com>
Date:   Wed, 27 Feb 2019 10:33:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87e0a8c9-82f6-3f41-bdb6-162a4c264132@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.25.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

Sorry for the delay.

On 27/02/19 03:53, Gustavo A. R. Silva wrote:
> Hi all,
>
> Friendly ping:
>
> Who can ack or review this, please?
>
> Thanks
> --
> Gustavo
>
> On 2/11/19 4:14 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warning:
>>
>> drivers/i3c/master/dw-i3c-master.c: In function ‘dw_i3c_master_bus_init’:
>> drivers/i3c/master/dw-i3c-master.c:603:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if (ret)
>>       ^
>> drivers/i3c/master/dw-i3c-master.c:605:2: note: here
>>   case I3C_BUS_MODE_PURE:
>>   ^~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/i3c/master/dw-i3c-master.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
>> index bb03079fbade..59279224e07f 100644
>> --- a/drivers/i3c/master/dw-i3c-master.c
>> +++ b/drivers/i3c/master/dw-i3c-master.c
>> @@ -602,6 +602,7 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
>>  		ret = dw_i2c_clk_cfg(master);
>>  		if (ret)
>>  			return ret;
>> +		/* fall through */
>>  	case I3C_BUS_MODE_PURE:
>>  		ret = dw_i3c_clk_cfg(master);
>>  		if (ret)
>>
Acked-by: Vitor Soares <vitor.soares@synopsys.com>

Best regards,
Vitor Soares
