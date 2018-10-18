Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93546ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EDE2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EDE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJRRML convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:12:11 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55260 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbeJRRML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:12:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9I948CV013925;
        Thu, 18 Oct 2018 11:12:02 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2n36ftqmmn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Oct 2018 11:12:02 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC21631;
        Thu, 18 Oct 2018 09:12:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96B2327A8;
        Thu, 18 Oct 2018 09:12:01 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Oct
 2018 11:12:01 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 18 Oct 2018 11:12:01 +0200
From:   Pascal PAILLET-LME <p.paillet@st.com>
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: stpmic1: Return REGULATOR_MODE_INVALID for
 invalid mode
Thread-Topic: [PATCH] regulator: stpmic1: Return REGULATOR_MODE_INVALID for
 invalid mode
Thread-Index: AQHUZsKglb6iNfmbm0OveLleAMTNsQ==
Date:   Thu, 18 Oct 2018 09:12:01 +0000
Message-ID: <5BC84E60.60501@st.com>
References: <20181009085221.31137-1-axel.lin@ingics.com>
In-Reply-To: <20181009085221.31137-1-axel.lin@ingics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0C62042A1A4854479F3D64C9621DD794@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-17_15:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,
Thank you for your comment. As the driver is merged, I will make the 
change in a future patch-set.
Best regards, Pascal.

Le 10/09/2018 10:52 AM, Axel Lin a écrit :
> -EINVAL is not a valid return value for .of_map_mode, return
> REGULATOR_MODE_INVALID instead.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/regulator/stpmic1_regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
> index 96f18083a3b6..e15634edb8ce 100644
> --- a/drivers/regulator/stpmic1_regulator.c
> +++ b/drivers/regulator/stpmic1_regulator.c
> @@ -441,7 +441,7 @@ static unsigned int stpmic1_map_mode(unsigned int mode)
>   	case STPMIC1_BUCK_MODE_LP:
>   		return REGULATOR_MODE_STANDBY;
>   	default:
> -		return -EINVAL;
> +		return REGULATOR_MODE_INVALID;
>   	}
>   }
>   
