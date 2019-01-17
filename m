Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B52C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E143820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="B5a3vESq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfAQHdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:33:55 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28557 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbfAQHdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:33:53 -0500
X-IronPort-AV: E=Sophos;i="5.56,488,1539673200"; 
   d="scan'208";a="23503860"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jan 2019 00:33:52 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 17 Jan 2019 00:33:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9ezR2jqfJBE2VTL+fXeOPbD9gebiRbJ4FwApehaaT0=;
 b=B5a3vESqBnwwNSNvwpU5ZkWjrlNhkF57B9V1QOcVhObgtMhEFZe7oqRcflzzzQqqturbALjmUD+BqCs+TuTiR1M4TL/adnFiJS4gwNOEG/GXkqtpoiPdbKAWKKk/lKiOF7zzM2NvukPiwRujbO8whBfs8+cno9Oc6jW9uTzLt2s=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1889.namprd11.prod.outlook.com (10.175.100.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Thu, 17 Jan 2019 07:33:50 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::79d8:b977:b90a:76fa%4]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 07:33:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miyatsu@qq.com>, <marek.vasut@gmail.com>
CC:     <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <hauke@hauke-m.de>
Subject: Re: [PATCH] mtd: spi-nor: Add support for Macronix mx25u3235f
Thread-Topic: [PATCH] mtd: spi-nor: Add support for Macronix mx25u3235f
Thread-Index: AQHUmOTzoXcLuQXTbEmD8bft3GV60qWzPCiA
Date:   Thu, 17 Jan 2019 07:33:50 +0000
Message-ID: <e42d76a0-3e65-d34d-0711-7d003749f8f1@microchip.com>
References: <20181221041957.84474-1-miyatsu@qq.com>
In-Reply-To: <20181221041957.84474-1-miyatsu@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0802CA0026.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::12) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1889;6:Z/k67FVyMGbSr3XKAQ5snLM4WJ6cuoDew5SnvbxzJUZaQidjiMRU108GFvpKQvlJBg5k/qzkbQo1yK4EKcCZ/HY6sRalV6Tiu2F+SVu5EKX5DbO8JM4+p4kp+H5byIU1s74TJASJ/DPpzuPLv3OtYbrmAqmOVN6QUb1FerCIPrpkMS68mc764pPVc1fUc0vmFHnWg1UTQ3MjCBROcDPRDOfiAXNjJVVytHfpuF4hWZ3OUIm55q7rhlno/numIk1C58A/PF+NiOn7RnsxRMYzXNiZuHPSAPDYOuT4kpscDEQ9PVmqWLdv6hq7I+8BMrBRq4kYv71OXodRthmYxl6oKGABi3r5QFQA0VxObYMT06UJ623TX+RdHp7e9yFq8GaFp5k0a1JP4Uza0/7P7TG0u7h7Yhnza/3rkHDditufWjRs0QIjEcWNjVS4kg32tUCgI+ut6p7RqDgqBFvLQhOb4A==;5:Eu+vpp8TsR5CNtYV0Zo6RR+B5aep/qSf5AzVhTk2Ix8GKsNdTtiewGLRLCDeUSagk2Q/CYZXqrCgTGcFLUP3l+lFSEgsOcEdShZGimjyr5pJ4j374bQAanU7/1VxT7PxVRy+TFInmC8p3ojCHuUWNeet6rGoSiVIs/k9b16jsj3H8NlYg4oJVz+8rZbiaFEt3Oq2c3z/ZEg6njKJBBKFdw==;7:lv3vE65x1PjzFwWz7q14M/jl1Ezh983lSBBqAu4N4c2yxxP4LyQ88pa3FXkN+gku1N2fAULD2OX/BOI4Fn+v0koLpJ1c+pW41cR2kz0PmVv/L+GdCJ1ezbvAg399fl+TDF11z9Jo7vdhAiQ6aD5PJg==
x-ms-office365-filtering-correlation-id: 3ee20e39-408c-45b1-0c2e-08d67c4e1f9d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1889;
x-ms-traffictypediagnostic: BN6PR11MB1889:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-microsoft-antispam-prvs: <BN6PR11MB1889A402B13B3FA552A2C671F0830@BN6PR11MB1889.namprd11.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(68736007)(256004)(6436002)(6486002)(2906002)(229853002)(486006)(97736004)(93376004)(36756003)(6116002)(3846002)(558084003)(66066001)(31696002)(86362001)(53936002)(186003)(54906003)(81166006)(110136005)(81156014)(26005)(7736002)(11346002)(99286004)(25786009)(71190400001)(4326008)(386003)(52116002)(2616005)(316002)(6512007)(76176011)(446003)(478600001)(305945005)(8676002)(6306002)(14454004)(966005)(5660300001)(71200400001)(6246003)(2501003)(72206003)(106356001)(105586002)(39060400002)(102836004)(6506007)(31686004)(8936002)(476003)(5003080100003)(15302535012);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1889;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dvk8f7XmntU7G39xtaAtd6PbIGzz4BcEoM4CDlP7GAe/Wgu0oAt6G0LNH3vazkMMw1AjgkOpfdjCbjyjSpIVFRW1jJgqF5jb4l9r2gjOTQKMTIHfF3WNlAVTgvNSAv+RS0kU64uIv/cy6tzBpGA7VVk7JWSbx1mDeZu6ThFT//5d6Y8qrQkqKCUil+sIHBhxr8TVH+RGteXQ6R2hj9JzsVeX6Qcp4ujv1Mhi8fU9eQfceN329UWmNaLZ9tCYDDBimuCBnbpGPsqn9X336ZUn7Dj3Lu6JZR9gfXKWAA2CUbpYBTaVULrJOZSDbTOGd3egXCvp/GpNuXmeWS6dTExSWD2E8U+33v0R+5vnCV10AtNaD/ujrZt9BuSmN2fOXH2eeYBn5k0dNW4JE76ifbEgI/cgZ3kttIQKeQc5UPP1Kv8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <145588134C40334199963267E36AD2D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee20e39-408c-45b1-0c2e-08d67c4e1f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 07:33:48.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1889
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERpbmcsDQoNClNpbWlsYXIgcGF0Y2ggd2FzIGFscmVhZHkgc3VibWl0dGVkIGJ5IEhhdWtl
IGF0DQpodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMTAxMDAzMC8uDQpDYW4geW91
IHBsZWFzZSB0ZXN0IGhpcyBuZXh0IHBhdGNoIHZlcnNpb24gYW5kIGFkZCB5b3VyIFRlc3RlZC1i
eSB0YWc/DQoNClRoYW5rcywNCnRhDQo=
