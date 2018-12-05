Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED54FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07EC2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rjELGdlw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07EC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeLEM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:26:02 -0500
Received: from mail-eopbgr10050.outbound.protection.outlook.com ([40.107.1.50]:46691
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeLEM0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuLqS4g0Emv55FsWCawQ9TY2xX8G6BR4Fr9LN4WvIHs=;
 b=rjELGdlwJxOMFhxV4+kU+R9gDq1fTUCu+oIS3dCmdfM4UCS04PNF9ssK/pMhuPe/UQdpCrg9tgjD/ISu33JECOh5RsFpxLauA5Jhb4jc7MeBSvs2QD/IuohQUXBEOq5GEnnAaE54jn/HGm9Ge3I04hTNH/PDYiqLe9WoURTbOwQ=
Received: from AM0PR05MB5331.eurprd05.prod.outlook.com (20.178.18.140) by
 AM0PR05MB5652.eurprd05.prod.outlook.com (20.178.116.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 12:25:57 +0000
Received: from AM0PR05MB5331.eurprd05.prod.outlook.com
 ([fe80::25:5d94:341:3542]) by AM0PR05MB5331.eurprd05.prod.outlook.com
 ([fe80::25:5d94:341:3542%6]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 12:25:57 +0000
From:   "Guy Levi(SW)" <guyle@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: RE: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHUi2r6bkNNxjrJlk2T6ekPOdpK7KVt0U4AgAJCpjA=
Date:   Wed, 5 Dec 2018 12:25:57 +0000
Message-ID: <AM0PR05MB533192C82AA04E89004251A1C7A80@AM0PR05MB5331.eurprd05.prod.outlook.com>
References: <20181204114731.48b18bfc@canb.auug.org.au>
 <20181204015247.GR12288@mellanox.com>
In-Reply-To: <20181204015247.GR12288@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=guyle@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB5652;6:m387WDFbHosIA9lGu1KTlY44LvQ4Av7TTybZB+zzMwdQq8ZAcdtyT/ga23D9EZfbepWNcqLXf+pP6I2h5Jj29Jck/jg+Z+7habsnNHElgBFsDn3iZ8uUxcv7HJIl7uVnQey8K5SO4R07G3cYaVjVM06u2P9FZk/vEYVelTUPcFgFVj1x+c5JkofnS44L5hu9rSzH70y0vseUZrzzeWHHjRuD8kX/hDSux65IlEQU7wdqV+o1uVh2tF10qR38G4mdtsXKDXt7gNMsrqpSO56q/0xUo/aU7b2Bh8ugAwDSPP9fwAL22f/9nQNXr9pcCf7dowIYjeYInHLalFc3M59ILBz6VgKFUcxxqWxDpc1lXRTPFgxWeMmp8mgaM0Lkv0WHKW/6MzTIvE4ooOMraiMMtIa0qmJhssVMq4umxMBXWY0p9L0r6Otowxw8rJRMSy7OFXhM2ufHEPGGpK12MO6JnQ==;5:iAcryHBBhVjB5Tyk8BjkbexJIBpDlsNSsGrDBO6sWblBbV5jOZDyjGMqdpoTn7eJyabN7QumrtvVNq2VC1rGgBg9TBQlSi5PLXplmqThIyMBREMarYPWO3aBliq8YYlzJok75bEa0nDu4e45eOmohx7tTQyAkjSO9/YySoJKvf4=;7:v0jmK7fDl4x8jaOmXrh7LHXl0hHTSrEFnDFXqdKWaGujzO5IbBqxQoumtyk1E8ZdFc+CKdL5ADp93nEAc4gThl6kjcYoeb8MXkgdfaQnzNPXPIBjC9wtebcbJcRGrzUGE1it85ZKFDMoPZna6kjUjQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a6cdc9fe-c206-4af4-0dfd-08d65aaccf0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB5652;
x-ms-traffictypediagnostic: AM0PR05MB5652:
x-microsoft-antispam-prvs: <AM0PR05MB5652DB59472184CAECAE4754C7A80@AM0PR05MB5652.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR05MB5652;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB5652;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(9686003)(74316002)(478600001)(105586002)(486006)(7736002)(446003)(110136005)(54906003)(186003)(106356001)(33656002)(14454004)(6246003)(26005)(107886003)(68736007)(102836004)(55016002)(229853002)(6436002)(305945005)(11346002)(66066001)(53936002)(71200400001)(71190400001)(81156014)(81166006)(8676002)(76176011)(7696005)(6116002)(3846002)(476003)(6506007)(97736004)(8936002)(5660300001)(99286004)(14444005)(2906002)(25786009)(316002)(4326008)(86362001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5652;H:AM0PR05MB5331.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: GzXw+jX8Sx1aAi09E2eEuonXOuP61WUXLVkx9Jgx0AtCuh97NZbfV7O3TNVnP7uW4dV+yytKatyaKnRtCFOmWVLpisfZ1pGoyK7SiVFtMExCMz+pMteaop3u5GzZoDIzrx9uWNkVncQh7/A5rYV9Ba+fhWKF3vUiBltrRGRrI5dLDFvLERfjMxxyQYk3e+0ApwSj64yivZbPzeKLo+wMZ+L/p8io7Vq9flypFLaRUEjkrsu9ZBB6j+dr5YW4tmyRouPZIfSXHESssP7wGrzBtdSvAxiDwY+3fuT/OYeZbmmGRPHD7iCZJJvwLNGkZk9k0Woog/NSIlN+Im0F/55WHVXrEBUXHkiX5SGnU+b++Qo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cdc9fe-c206-4af4-0dfd-08d65aaccf0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 12:25:57.3021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Huh. So apparently every compiler that tested this patch (0-day, mine,
> the submitters) optimized this call away because is_atomic_response()
> always returns 0: meaning mlx5_get_atomic_laddr is never callable and
> can be deleted entirely, including the call to mlx5_get_send_wqe.
>=20
> Not sure what compiler setup will hit this, but it is clearly wrong
> code..

Flag -o0  ?


>=20
> Guy/Leon, please send a fixup.. Maybe just delete all this
> handle_atomics stuff?
>=20
> Thanks,
> Jason
