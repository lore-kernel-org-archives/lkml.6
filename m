Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE631C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CE520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="bGsTPBBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CE520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbeJXAhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:37:40 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:24560
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728034AbeJXAhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtKVwKm1RytM3kwFLau/gSZVIzzMvQodGqzgmYKAwLA=;
 b=bGsTPBBW8WHhNW5qWW+9+rRCqHBwFGldEv3Zes5/d/sazUIA9CWhXPlIxxz+6mjioQpjpXuaJJn7vvFQ9NrFRDnKVClglnNbPVKNOnf3bRQP2mLtuXJ+xkx5Ay3kxznqDHemtmr9I5eE2OPyPsIxBlTeEjkeYXrd65taPGYzADU=
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com (10.169.135.8) by
 VI1PR0501MB2431.eurprd05.prod.outlook.com (10.168.135.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 16:13:33 +0000
Received: from VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::b487:46d9:b391:cb3]) by VI1PR0501MB2271.eurprd05.prod.outlook.com
 ([fe80::b487:46d9:b391:cb3%7]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 16:13:33 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Rami Rosen <ramirose@gmail.com>,
        "pandit.parav@gmail.com" <pandit.parav@gmail.com>
CC:     "tj@kernel.org" <tj@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: [PATCH] rdmacg: fix a typo in rdmacg documentation
Thread-Topic: [PATCH] rdmacg: fix a typo in rdmacg documentation
Thread-Index: AQHUauFEaB6WV+4Klk2RCNmuRl7KpaUs/9Cw
Date:   Tue, 23 Oct 2018 16:13:33 +0000
Message-ID: <VI1PR0501MB2271192C00D2E25E0AB6950DD1F50@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <20181023150106.7332-1-ramirose@gmail.com>
In-Reply-To: <20181023150106.7332-1-ramirose@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [122.171.149.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0501MB2431;6:AGnkNTRzFZQNHTrFuHHshhlKBJkRF8dQZjrVSRbTW6hzFLZRXoHZuzWoTy48ML2EUtd7ulU+Mt91uFhTZcpqhw85bs2z5uEv74q88HwqPqiDEAPk8AovwL+dz7bV4BsXXuRqJ9vTDnTT7svIwusMQmd1fC5nSMSZUhaN4lcpXkqMva0Pcn+mducZcyrhWJDPKB7dq/vHLdTQcdiNGcLtzw+p708K8vYHj+abcnERjARc3VgfMGAC0oXMVt0aLgTKvdz2BUH2KsDhM0KB08QBKxu5xfk2hCgjEQo1RlQDRjFd0LwVhsdASnr6SycquSJuijq8AE//F0SVaG/Sk4RMVXScHQ6z4SRDpWDOGDrnpjXiYlPknScPBjEmzSnAq40yUm+Bm3TawrMSRasJksbomX5v1Sm0OKdOmvbqMkF/cmjOFg1gySkHoBwDu+sk5txjeGuufdnxeeaN129fdZz/Ag==;5:4p4/oDclpVVDzUXLmAMEUkVNQdWEC6vFcTVtzkMQAwTSQIrd65KWywN7cEprVAwENL74xZ2FqKFeESKUC5Pvtvce2m09ipAdPMV1+Eu14Y6jKaS/Fk5FGX5hZ5i8zQc0ns7IUHMAgWYNVMk/m4Pt7+mYM60DcHE78ofBLeqbuTk=;7:CU3Fpvg+TwtsoSIGFY643Zcb2Hk0cnQFY1Pq8KdWVAz0VZsKfXxsW5AmUIblUQkf9CVRCPr3TD1qA7+Sr3FGJ8+uCxp+/+3t/tBQzrhxLrY+u1LvRaMihcXQrlmM7fuG82zZvRIjiM99tQvWkv8gH/c9axiT3MBXOMuV2s+5pDPdMs/CGQxOfs4IfNQ7XgC92vct8i0gZqQiwQ1KtWEQaV9swCv/rZeAwh/h0L5FdqctTYPvyae6ivPg7yTl8JPH
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 35ba2077-2acd-450d-52ef-08d639027ae7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2431;
x-ms-traffictypediagnostic: VI1PR0501MB2431:
x-microsoft-antispam-prvs: <VI1PR0501MB243144442B5B4E978D986DA1D1F50@VI1PR0501MB2431.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0501MB2431;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2431;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(13464003)(199004)(189003)(78486010)(102836004)(2906002)(25786009)(478600001)(305945005)(7736002)(26005)(86362001)(575784001)(71190400001)(53936002)(74316002)(53546011)(76176011)(11346002)(81156014)(476003)(71200400001)(486006)(6506007)(6436002)(110136005)(68736007)(316002)(39060400002)(6116002)(66066001)(256004)(14444005)(55016002)(97736004)(81166006)(8936002)(14454004)(5660300001)(33656002)(6246003)(446003)(106356001)(99286004)(3846002)(2900100001)(186003)(4326008)(8676002)(2501003)(54906003)(229853002)(5250100002)(105586002)(9686003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2431;H:VI1PR0501MB2271.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CdxH7+183Zb1Kyg7iX228otge2SLHct72B3It15qtaiGuH2TFhjIynQNiw2yq4F7w1gp6ojBl3GoToF1zwYvTiS0DjxCVQtbyn+X6dZtmP1eROW4o3NpXHwNS3Dcx1i0l0e6cYqCyn40qINLplP+Rh//Zf/66ev8k2zK1rmGqXuM1kKrlYyVrCBn1WDDAbwJmrEOIREIZZTcoI7AFoqZas9ktSSDObrkcO0vhfkga5EPQmg5Pgp/xIIacyE8/GemCESFw843A3AuoCzykfIkzvQjGNNUNCZHQzhh0BQay/G8noZumdioVhwyipDQD0DzYwO2hdMhi5kIrkGz5bU5NwkcAmmEihSzC36bbfFJdDg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ba2077-2acd-450d-52ef-08d639027ae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 16:13:33.3108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Rami Rosen
> Sent: Tuesday, October 23, 2018 8:31 PM
> To: pandit.parav@gmail.com
> Cc: tj@kernel.org; linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.o=
rg;
> cgroups@vger.kernel.org; Rami Rosen <ramirose@gmail.com>
> Subject: [PATCH] rdmacg: fix a typo in rdmacg documentation
>=20
> This patch fixes a typo in RDMA cgroup documentation.
>=20
> Signed-off-by: Rami Rosen <ramirose@gmail.com>
> ---
>  Documentation/cgroup-v1/rdma.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/cgroup-v1/rdma.txt b/Documentation/cgroup-
> v1/rdma.txt
> index af618171e0eb..9bdb7fd03f83 100644
> --- a/Documentation/cgroup-v1/rdma.txt
> +++ b/Documentation/cgroup-v1/rdma.txt
> @@ -27,7 +27,7 @@ cgroup.
>  Currently user space applications can easily take away all the rdma verb
> specific resources such as AH, CQ, QP, MR etc. Due to which other
> applications  in other cgroup or kernel space ULPs may not even get chanc=
e
> to allocate any -rdma resources. This can leads to service unavailability=
.
> +rdma resources. This can lead to service unavailability.
>=20
>  Therefore RDMA controller is needed through which resource consumption
> of processes can be limited. Through this controller different rdma
> --
> 2.17.1

Thanks Rami for the correction.
For sake of process correctness, below fixes tag is good to have.

Fixes: 9c1e67f94101 ("rdmacg: Added documentation for rdmacg")

Reviewed-by: Parav Pandit <parav@mellanox.com>
