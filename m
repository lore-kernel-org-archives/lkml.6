Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6A218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rYhlZ03V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfBRJzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:55:49 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4178 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbfBRJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:55:49 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6a812a0000>; Mon, 18 Feb 2019 01:55:54 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 01:55:48 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Feb 2019 01:55:48 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 09:55:45 +0000
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Yangtao Li <tiny.windzz@gmail.com>, <myungjoo.ham@samsung.com>,
        <kyungmin.park@samsung.com>, <heiko@sntech.de>,
        <thierry.reding@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
 <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
 <20190216151826.11584-4-tiny.windzz@gmail.com>
 <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <abb56481-0cc7-3d31-2dae-ba602a423811@nvidia.com>
Date:   Mon, 18 Feb 2019 09:55:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550483754; bh=7uSAy2SuOQBOFcmGGzEeUxw4F42Wkz6Q4MRCL20hS7w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rYhlZ03VoCxnd3Kzo80BdBR5ZVR990+NlU4FGnCmj+PadjrqTGZ1W2p8XqTFThKF2
         Gx6FsT1Ra8EzcqiF0LK8AgmpK20o/LPqAd6nChDDJhHFOeRCbdIZqziHWp3SMca8qR
         /Tps2D31qoEUXWuhorAzhhIPUJYPUTXAILI1fi3/Fdn+56qTlHgq9JPgAMcUNDMgp3
         hNzaB3rBtPRXFxE5oOAL1NNoxVVNwwS58HweNDcmIyQd78HX/o0/rtVElBdWHCltrM
         JSe9SQfuDxTWyxYNeGAxr/so6pmcB/jYQFLlGGIDEg1xIBRk6xsq6QnnWilo3J/UmT
         SpNT49hCbMlMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/02/2019 00:38, Chanwoo Choi wrote:
> On 19. 2. 17. =EC=98=A4=EC=A0=84 12:18, Yangtao Li wrote:
>> This variable is not used after initialization, so
>> remove it. And in order to unify the code style,
>> move the location where the dev_get_drvdata is called
>> by the way.
>>
>> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-dev=
freq.c
>> index c59d2eee5d30..c89ba7b834ff 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq=
 *devfreq,
>>  static int tegra_governor_event_handler(struct devfreq *devfreq,
>>  					unsigned int event, void *data)
>>  {
>> -	struct tegra_devfreq *tegra;
>> -	int ret =3D 0;
>> -
>> -	tegra =3D dev_get_drvdata(devfreq->dev.parent);
>> +	struct tegra_devfreq *tegra =3D dev_get_drvdata(devfreq->dev.parent);
>> =20
>>  	switch (event) {
>>  	case DEVFREQ_GOV_START:
>> @@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfr=
eq *devfreq,
>>  		break;
>>  	}
>> =20
>> -	return ret;
>> +	return 0;
>>  }
>> =20
>>  static struct devfreq_governor tegra_devfreq_governor =3D {
>>
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>=20

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

--=20
nvpublic
