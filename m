Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26834C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BD52080A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 23:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Xt2BREZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfABXfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 18:35:46 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:51621 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbfABXfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 18:35:45 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2d4acc0001>; Thu, 03 Jan 2019 07:35:40 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Jan 2019 15:35:40 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 02 Jan 2019 15:35:40 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 23:35:40 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 2 Jan 2019 23:35:39 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2772.namprd12.prod.outlook.com (20.176.178.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 23:35:18 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%3]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 23:35:17 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V2] i2c: tegra: Fix Maximum transfer size
Thread-Topic: [PATCH V2] i2c: tegra: Fix Maximum transfer size
Thread-Index: AQHUout6tntEaJKJCkybVGr/nm8PJqWck86AgAABP/A=
Date:   Wed, 2 Jan 2019 23:35:17 +0000
Message-ID: <BN7PR12MB283637DD2AA8882E46B76EDFC28C0@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546468519-2128-1-git-send-email-skomatineni@nvidia.com>
 <20190102224512.GA2750@kunai>
In-Reply-To: <20190102224512.GA2750@kunai>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2772;6:0De1ER1iRnDLrwsRFHUmzbmf0flnzZtP7qqftaEZZsrjSgNUwAIIcGXzGHqF2Mn12DY+wZRlWkNQ+qAm6A8FYTIVZ5Xp++Q6+RitgWqhQ0SCauK1NcGcjTMSp5UOwxHcs/ePSy97w79tBc7gjy1jmFbGs9PBwF4l1CBmRlNG4hdLmcTZbevLlHWBdcGd0tkjvU467JuSkPpfJ/vDCRUJmyeJc3Sgoqz8KHO+fpWzaSW3OGRHJUzkP86aPEf6J0b1SQoxKdfTGINXg0JTQ4iRFBVvEh3oKukMrMkETL90hPIHmeGViIyPo0L8o2zUo0doHkjND3CtOzCzgswP79ynsRtwPOTaRFLvM5j/tkqLBUGQG0+eEasU6/DtJTyueCcD9yUZzoiYVSf6XNJX53Mvk9+KqNbhKNOYy1Iiv5/bcTo/a+sV+w2phi6ALbSuuU0JgvabMsbadf7ds47LdYXjCA==;5:aww5WhDuAlIURcsByJg7cb/gJy6/r5+jnIFBdy52F0Eap8kElDPLVkx27EN48yov0jiSyJKX7ETnPwYzWEqE3les3wdOmdzaY9mQE6MSjx57/Wfl5KXSSfc/U1bO5Wo6wp8F8DB4wWHV7DmWnBtQOwfjlak4p1se4OjVuhoweutzQo9l3Tw12l1kUuWs3s3sSyNJo0+Qq/vCPl6jnafyPw==;7:qfmfY1YhrKFLFGTCJPYEfhPTAMhDy0+Vc7KyPbJ4lW8RFVnYXf3EUIXkNAzlioGP/s+irQvPcdTQ9JQ7YJlSEBaAIlFJEr9baY851N9lJpIooSTrkTFeYQc4Do78FSDEU6h2a+tvdkxmY4pfnmLv4Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(396003)(39850400004)(346002)(189003)(199004)(2906002)(53936002)(9686003)(54906003)(6246003)(55016002)(97736004)(68736007)(99286004)(316002)(81166006)(8676002)(6116002)(3846002)(305945005)(81156014)(8936002)(7696005)(76176011)(7736002)(5660300001)(33656002)(66066001)(186003)(11346002)(476003)(86362001)(74316002)(446003)(486006)(256004)(14454004)(229853002)(6916009)(478600001)(105586002)(25786009)(71190400001)(71200400001)(39060400002)(6436002)(4326008)(106356001)(102836004)(26005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2772;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: bb9dfe72-eb65-486e-c65b-08d6710af401
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2772;
x-ms-traffictypediagnostic: BN7PR12MB2772:
x-microsoft-antispam-prvs: <BN7PR12MB27721C2AD683C79F41735BEFC28C0@BN7PR12MB2772.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2772;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2772;
x-forefront-prvs: 0905A6B2C7
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kVn1fOQZcng8byCbnI+DMLrJluYWob3PcblZ3sqATchnQ9N2orIP9kTurKeRuTI89nRq+pjXAnYU3NIUM5ysaCGk2ZkYKBvrAJaTiB9qvQZ6s9mzr07+U7kF+FpKXx9tIbcDzAzIGBO+WR365XdK97lJQ/HeGVzETvCaTqCKKN8IABcHyJg5hBSXkXuGTNwWps+8Es3gO0wQcHoo3DTX7y0Zxq/+m3bRdUD6ddADgMzEnVep8pNRTJWfpOiubhMdjoqLdRhPPjR4/8RsNVG3kb49Z8oPpIOrtLly+t1ZHDstFhwYHoMkJKRSUqH4PHuL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9dfe72-eb65-486e-c65b-08d6710af401
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 23:35:17.5401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2772
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546472141; bh=TCmT6IU03iLtqg6TCj6UD/+tS9rUKKFhEoqPpcfhrto=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-exchange-antispam-report-cfa-test:x-forefront-prvs:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Xt2BREZIbYTSV9ezWoiq2Z9Tr1zACJAju27KZutH77s6p/YlefZW8gw7VALEnqF9i
         nLBFew7W0kUaY4riuxkxyKKrpG4YYe4287t92yOX72KKlc4UYFut71NwhW6RHzRVXK
         y17iYivSwYuaW/osW/8hbW0yws2e3cr/WgaVXdPqEDVofdr/tpy0Qll5zdQXhKQSeH
         BJWp8cyIpbzF4Fiz8GOCNI6X6a6dolW1x6TZeA1O1B2+5PiJfAMPZpfGgGiCXvSpk+
         VhKo2ejPhISgQ7RdbL4jIbw9htbqx1ExAIhV2LC3YZ2hR95skjNdoP4lBRgllbhG4d
         qrMDUDzY9VJiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Wolfram.=20

>> Tegra194 supports maximum 64K Bytes transfer per packet.
>
>Linux I2C doesn't support more than 64K of transfers as well...
>
>> +	.max_read_len =3D 65535,
>> +	.max_write_len =3D 65535,
>
>... so you can simply drop these lines.

Oh Yes right, msg len is u16. will fix it. Thanks.

Thanks
Sowjanya

