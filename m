Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0DEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9896214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RXydNzbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9896214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLGMhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:37:23 -0500
Received: from mail-eopbgr750089.outbound.protection.outlook.com ([40.107.75.89]:29815
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbeLGMhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwZTVeTSpdjfhhc6pIbc3kU12d1AccKECOCcDt3K0f8=;
 b=RXydNzbOzx+lUWz7Rl3p96VpCl92TwBbUi0XzWvn8lB2+ED+HH72SMre+EHhBoXFY1OVgwSh14PsOUE4kjNwTXpZOgCOi8VpZaZ7ey9cm0kDouzZPzt0rdN+r4nHYMcn1D8i44m9dwZyB6JtCF8PA9QGS4txAmm7E9//hLKTr/E=
Received: from CY4PR12MB1717.namprd12.prod.outlook.com (10.175.62.139) by
 CY4PR12MB1381.namprd12.prod.outlook.com (10.168.169.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 12:37:19 +0000
Received: from CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::6191:9608:ceb9:9767]) by CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::6191:9608:ceb9:9767%11]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 12:37:19 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
CC:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Thread-Topic: linux-next: build failure after merge of the drm-misc tree
Thread-Index: AQHUjQvv0Ll3Wmh/AkCB37sEQ79bQ6VzOQ8A
Date:   Fri, 7 Dec 2018 12:37:19 +0000
Message-ID: <43146de0-7401-b174-b96a-c8362e0b65f1@amd.com>
References: <20181206133219.38831da4@canb.auug.org.au>
In-Reply-To: <20181206133219.38831da4@canb.auug.org.au>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM6P193CA0031.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::44) To CY4PR12MB1717.namprd12.prod.outlook.com
 (2603:10b6:903:121::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1381;20:u/ATa7U+JiSroQiogi66VaN4TTS5Tk5MVWInN+EmxX9bf8Z0uU6nfBepV91xBeJRU0HExPFOETqU9I6zeq7/Y3rH5W4vtM4eAGGCQtT48BUoeEBNTqwwYXSzO6SOi/GE51ktgFOmiqbYLN/v5laL+qMhAWtdkz9qYeJRcmanu4u1N55VT5nXuEbEm3if473CspahwgvcsynhPAAofz02d45lKy5grrnJH9ebPquG/MzYXgUFfRLBgI9Zg1HxUM2O
x-ms-office365-filtering-correlation-id: 1599a23a-6fdb-40fb-0539-08d65c40b9f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1381;
x-ms-traffictypediagnostic: CY4PR12MB1381:
x-microsoft-antispam-prvs: <CY4PR12MB13817E1EA012B7F3CD26C61683AA0@CY4PR12MB1381.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1381;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1381;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(136003)(396003)(53754006)(199004)(189003)(229853002)(31696002)(52116002)(76176011)(305945005)(186003)(386003)(6506007)(7736002)(6436002)(4326008)(6246003)(53936002)(14444005)(46003)(71190400001)(65806001)(102836004)(6486002)(486006)(105586002)(68736007)(2616005)(65956001)(106356001)(11346002)(446003)(476003)(6512007)(256004)(6116002)(81166006)(8676002)(25786009)(81156014)(8936002)(65826007)(5660300001)(31686004)(71200400001)(36756003)(86362001)(72206003)(14454004)(2906002)(64126003)(54906003)(110136005)(58126008)(478600001)(99286004)(97736004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1381;H:CY4PR12MB1717.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9d9gtxf6gV9OJgS4EYxJvIgfE1HHuNugUyN+U9NJFzbV3AOyLUFvMv+r2M4BOEOiSUZcSC4regqwK9pzr15Kc9DqiVwTbAsJqWJaq+JsX+SmVFm62408O6Cbo/ouAbOsU/nzBQW5k9zkSbqJskHh+G50ciBLuOfKkVm6uNXtZS5b909E/IufD9klKMbRst4kmY0U/EGsgsg/M0nm3muJ+17jdHnyisv9FFoFrCKRLVpd7ngh67Ih6Iq9dbEPKBL9oRWGtGRwxZVfWUHYcIize0TNOSREBz8W7KNN0kE660BVSflNX1Ww7vSLLNi3SUlGnP+Ot8Zh5GhpR6kp2CCIESGcLLlsQdkc8HjKk5iX7ck=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <5A23EAAF7AF7DF48AF8F2000352C0EFB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1599a23a-6fdb-40fb-0539-08d65c40b9f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 12:37:19.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

yeah, that is a known problem. I missed the change during rebase of the=20
revert.

Please see patch "2312f9842854 drm/v3d: fix broken build" which is=20
already in drm-misc-next and fixes the issue.

Christian.

Am 06.12.18 um 03:32 schrieb Stephen Rothwell:
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/gpu/drm/v3d/v3d_gem.c: In function 'v3d_submit_tfu_ioctl':
> drivers/gpu/drm/v3d/v3d_gem.c:719:3: error: too many arguments to functio=
n 'drm_syncobj_replace_fence'
>     drm_syncobj_replace_fence(sync_out, 0, sched_done_fence);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/v3d/v3d_gem.c:5:
> include/drm/drm_syncobj.h:134:6: note: declared here
>   void drm_syncobj_replace_fence(struct drm_syncobj *syncobj,
>        ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Caused by commit
>
>    0b258ed1a219 ("drm: revert "expand replace_fence to support timeline p=
oint v2"")
>
> interacting with commit
>
>    1584f16ca96e ("drm/v3d: Add support for submitting jobs to the TFU")
>
> I have used the drm-misc tree from next-20181205 for today.
>

