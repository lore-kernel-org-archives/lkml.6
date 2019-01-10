Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B9FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A260B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hTh7kIwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfAJXAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:00:05 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6613 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfAJXAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:00:05 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c37ce650000>; Thu, 10 Jan 2019 14:59:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 15:00:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 10 Jan 2019 15:00:03 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 23:00:02 +0000
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (104.47.41.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 10 Jan 2019 23:00:02 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2803.namprd12.prod.outlook.com (20.176.178.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Thu, 10 Jan 2019 22:59:46 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%3]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 22:59:44 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V1] i2c: tegra: Add Bus Clear Master Support
Thread-Topic: [PATCH V1] i2c: tegra: Add Bus Clear Master Support
Thread-Index: AQHUo8PEPupW6HXIj02E5aKJ0AbfZ6WoqOAAgAB8WyA=
Date:   Thu, 10 Jan 2019 22:59:44 +0000
Message-ID: <BN7PR12MB283699DEC4D5EF468B0404F4C2840@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546561418-10230-1-git-send-email-skomatineni@nvidia.com>
 <20190110152148.GE25353@ulmo>
In-Reply-To: <20190110152148.GE25353@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2803;6:rYCxws+flwXYVSLpIA3YXchRJcfBLzAeQRLgd3D6GKk5ZVV+5JOswtW/63HnlX+7C8Ob3OHxbQbAz4I7/ONEQ2dOBCgnuiRO9g9q/0gJoj68MumEotQPkF1HpJxljykC5n1ctvXhVCdZB5+au1M5tho96xbS7B79eGLLZvEoc3e5Kmxj1WSQSMs93DgRGUqlLuWKjfQFRtqUHzERfWxyd8xOxFzKQUyZPwRy32uRzHDc7Nu7aZri+O2WQ+cw3uiB/E0AQSI7+g1AfdoEZbOgD6Wb6PiUh8zZviqbNXM+9gIx64q36BZr5UhjehVKhHyGvPJBIqj86Hc5fGUwnXDZpTzEFPibeKLnEMV8JJN+p17yqrR9j0dHHHMjIBrxGHwCBIO/zdDiz72b5F/OIrKVOgNndPGOABpVYPB62WeScNuqFCobOYNw+isFheSLpwWGpFOWN2Md0FpVxPLYJFIvDg==;5:6+OZBcWbylf/TF3blC0WB9ciQ3jqaQtPF+iGhAa1P5WLYFmCoPJ5IwyCpiLqVNAyQgvg9pPYyQB9UjZVQrobicMxgGsyqbHBmP2zfDEHSAfKFvek7fyqwm2nUwUrxFa+LQVszqe1GeRvHE3q/Ul4JcJ5LamJPjLriPTi+fusyPay0qYdxqpad1WKzgw2Ix3rZ64UNnexX+7oNkSKbqeNuQ==;7:vIf5kQFm/W+f2CI2oZF06brOF2NMMF8TifV5xpQYnGRSOw7DI8ydADVnpPJObk1DuioFvLtAMrJP4Iw6pWuSTnac+YHC1TGKVHtN4vX9Zix+BXR7wYqiekPe1XH6mgRMWtc+yUzbv+iHOiLLEkZ62g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(376002)(346002)(39860400002)(199004)(189003)(6246003)(99286004)(7696005)(6436002)(86362001)(105586002)(74316002)(486006)(97736004)(14454004)(106356001)(9686003)(316002)(76176011)(305945005)(66066001)(54906003)(551934003)(33656002)(7736002)(68736007)(39060400002)(229853002)(102836004)(8936002)(6116002)(256004)(71190400001)(71200400001)(5660300001)(476003)(6506007)(55016002)(53936002)(14444005)(478600001)(3846002)(8676002)(26005)(2906002)(6916009)(81156014)(81166006)(25786009)(11346002)(186003)(4326008)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2803;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 0dcb335b-a65a-478b-d134-08d6774f4fb9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2803;
x-ms-traffictypediagnostic: BN7PR12MB2803:
x-microsoft-antispam-prvs: <BN7PR12MB2803C53D18FAD0F7A4D6A182C2840@BN7PR12MB2803.namprd12.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IQE0XSr20AqOJ4Vnv1LqdTtRPsXzOxS6VfeEAriWAeKYpXkVlXmgnwB81cPCxcaE7dwkzu2JPmH7Qk1TiqgJF0wJYkWQSjk2cDgEBPPuQbHNLDJqfOyC0pfHFPiMnLUO+euTOvjZGrmGHsEW7rajDfbPeLZRahLjtK97oQVBqL+Wy8qso/o28uNYNtzVXr4CDZ1Yd6U4SXQLlS3LWg4S4M+4VAuCnPf2qPZt9P/+jW2tm3tmjrtbcy0P444wglP3T4oB62ZvkR6LtZ0G7rbn53zOrV//INx4h4Kly7z+OZWQAcUr78tWJcSkDpL51Z2jlgcm8neA41eodF5gewVVQbhvEOCzu2bYJWqswuyyH8qTaYy1nIQoOgXFq9sHt8pSdAydHWA4DN0Xg1dX+2aTjf4io70hKo/8f0bXv28t5Yo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcb335b-a65a-478b-d134-08d6774f4fb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 22:59:44.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2803
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547161190; bh=gXOPxMgnGtL+72n5b3HT3mdovkmzwQ84ooO7sV9lAgM=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:received-spf:x-ms-exchange-senderadcheck:
         x-microsoft-antispam-message-info:spamdiagnosticoutput:
         spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=hTh7kIwmyRzyLTSjiZgp931XFr7hpOGfNXf1lV53YzGWXhqCZq35Xn2ZhQqRlb9XI
         ub7i19qqhFFsiYcXyKgrbyYwRyREC5yTRo4K86Olv5kEElYNitczASZfNKa5l30R84
         EA7BvOxjVVpkNy/xsIADjq+XSy2e6a6BnA1TcKvl07hgkzWPLSSuPfwx5IWwdEclWP
         WU9r314tHmgYv7TQ5G5Jb9iecBVrxrehvubtQJ7Ni0UvUwwxJImtB+i9hqG6PAwk12
         s2gERDGkWuLrnjZCMQ6B4qZK5jNehmqknvSeBg9O19khB6kZB/D6M1FiyYXFWbj7hl
         uTRzB84zPvyGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> @@ -636,6 +649,9 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_=
id)
>>  		goto err;
>>  	}
>> =20
>> +	if (i2c_dev->hw->has_bus_clr_support && (status & I2C_INT_BUS_CLR_DONE=
))
>> +		goto err;
>> +
>
>This looks odd. If we support bus clear and the BUS_CLR_DONE interrupt is =
set, shouldn't we still process all other potential interrupts? Or was this=
 meant to be inversed:
>
>	if (!i2c_dev->hw->supports_bus_clear && (status & I2C_INT_BUS_CLR_DONE)
>
>?
>
>
>Thierry

Bus clear mechanism is to recover master from I2C Bus hang when I2C master =
loses bus arbitration due to some slave devices pulling SDA LOW continuousl=
y for some unknown reason.
Master performs bus clear operation and once bus clear is done successfully=
, I2C_INT_BUS_CLR_DONE is set in interrupt status.=20
During this time, no other interrupts will be received as it is already in =
the process of recovering from bus hang thru this bus clear operation.=20
So transaction during the bus hang obviously is failure transaction. But ma=
ster tries to recover from bus hang so transaction can be re-tried and comm=
unication with other slaves on that bus and further happen.

Thanks
Sowjanya
