Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4222419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MRVt4TGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B4222419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbeKOBjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:39:13 -0500
Received: from mail-eopbgr810044.outbound.protection.outlook.com ([40.107.81.44]:36992
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387522AbeKOBjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JlpgH8phdjfpfbn6KzAenuIOBXLe8tx3n8DVdh385o=;
 b=MRVt4TGD9jqtA+9NIP2Zh236xbF+f4557K0jYl0odYzh6k2EgTuF9V6d7A9VKhccFYoB9GGfneYMFEAUggy4wVXJmvMyBKg1/O0vViBKl2VGf7yNtzrQFHtwCCM3QvNxi3L8ABChaIwcLrr91EsxFPpiAqDwmdjIMQhv87DAXnQ=
Received: from BY2PR12MB0308.namprd12.prod.outlook.com (10.162.83.25) by
 BY2PR12MB0726.namprd12.prod.outlook.com (10.163.113.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Wed, 14 Nov 2018 15:35:26 +0000
Received: from BY2PR12MB0308.namprd12.prod.outlook.com
 ([fe80::b48e:f216:e8d7:52e9]) by BY2PR12MB0308.namprd12.prod.outlook.com
 ([fe80::b48e:f216:e8d7:52e9%9]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 15:35:26 +0000
From:   "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Ravulapati, Vishnu vardhan rao" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 01/11] ASoC: AMD: add ACP 3.x IP register header
Thread-Topic: [PATCH 01/11] ASoC: AMD: add ACP 3.x IP register header
Thread-Index: AQHUekjqAL5P+hpu2UiMJ6ahAUqaqqVOG7IAgAFQTwA=
Date:   Wed, 14 Nov 2018 15:35:26 +0000
Message-ID: <125d9c9b-85b2-1283-266c-b6906471206f@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1542000903-19020-2-git-send-email-Vijendar.Mukunda@amd.com>
 <20181113193612.GK2089@sirena.org.uk>
In-Reply-To: <20181113193612.GK2089@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::19) To BY2PR12MB0308.namprd12.prod.outlook.com
 (2a01:111:e400:585c::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [125.21.194.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR12MB0726;20:cf+AtTG/HEtJkY/augfItMVjHBTK+9NBRltZrGtGfzL2l2eN4TOV7IDHnh2WIeJrFFlBRV79uKkEOpr3GqB/nGm9dYx2cMBBitR38OHBaMdPoKGfBHFyf5mDXh/rjANTKCPX/MvuOMnVmI9LREXdj5zx4LXOL8bUJCk247byQhKZ4R8uevTqrF8GiYsVXlvtqCYPeId/UQsOKdvsLv0uosyEN4d6BW9Q5OCP1IB080/ay6y7CB6/GssZI82biO8X
x-ms-office365-filtering-correlation-id: 49c885fd-e2b2-4c76-03f0-08d64a46cc76
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0726;
x-ms-traffictypediagnostic: BY2PR12MB0726:
x-microsoft-antispam-prvs: <BY2PR12MB07267B746634F2E9637CF05F97C30@BY2PR12MB0726.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231382)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR12MB0726;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0726;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(396003)(376002)(39860400002)(189003)(199004)(14454004)(8676002)(2906002)(8936002)(81156014)(72206003)(6116002)(81166006)(76176011)(53936002)(3846002)(39060400002)(5660300001)(25786009)(478600001)(229853002)(4326008)(6246003)(6916009)(386003)(6506007)(26005)(53546011)(6512007)(52116002)(105586002)(6436002)(2900100001)(256004)(86362001)(36756003)(68736007)(6486002)(31686004)(54906003)(486006)(316002)(186003)(66066001)(31696002)(476003)(106356001)(2616005)(446003)(11346002)(102836004)(7736002)(305945005)(99286004)(71190400001)(97736004)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0726;H:BY2PR12MB0308.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DiTXYcWxeV2WZhLzIzThYGpSKrC3VwYB6g+BsisnfU+dLOhkDZjP+wndiRlBroUM0ulb6AgzVpNW1xuzrXp/OtCoE+4bMq6XQvWow/UL+KCToQYaPvYRZIAOnYn8tahbTmPXDkl4mbAsEVRKWMWD/fbVZcjYIvalUINU8kUjUa+st/HG+gi3pbLXe6W6uLgkbrx4xnlxo1Y9m4swpZ/EYNs2EnVz46kZvJkdMh5KZmfu3sbcOBZIP5SFw/wbTZhZYgNd+N0EzhbbBqRlHxcBZnI02myRVi68dCCZxD5Wa/F4W0h1JlXWP8cdzxPJ8oAT8FpylBdk2y6Fx8MX0yFkcslmRtQqlbXnheY1y/kX4V4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C3B579BBED04634681EDBB8120672479@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c885fd-e2b2-4c76-03f0-08d64a46cc76
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 15:35:26.7533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/18 1:06 AM, Mark Brown wrote:
> On Mon, Nov 12, 2018 at 11:04:52AM +0530, Vijendar Mukunda wrote:
>=20
>> @@ -0,0 +1,655 @@
>> +/*
>> + * ACP 3.0 Register documentation
>> + *
>> + * Copyright (C) 2016 Advanced Micro Devices, Inc.
>=20
> Please use SPDX headers on new files.
>=20

Will add SPDX headers for new files and push another patch.

-
Vijendar
