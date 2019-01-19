Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E996CC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9D12084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HTMDKqoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfASBNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:13:11 -0500
Received: from mail-eopbgr690097.outbound.protection.outlook.com ([40.107.69.97]:24608
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfASBNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=835MfIaD9uytNpKq5OanacCBZ/q9HVgUi58g/tKeoX0=;
 b=HTMDKqoNMXiM9b3DrGEIo/w7BAJ78zQ6c6S4cGLWsev4Tw4FL0IcFaKijrP/D1gvb/BcOKyNP69VniHPCpFu3Evggr3+kB3qieBy9fcHfb3hSCW4mNkt7f/fnZ/j6t882xjx8ZtrPcDg9+bZOmc++yBygD7ipyWrXqAjtiC6C78=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0837.namprd21.prod.outlook.com (10.173.192.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.8; Sat, 19 Jan 2019 01:13:08 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::e596:e32f:3aa3:2461%7]) with mapi id 15.20.1558.009; Sat, 19 Jan 2019
 01:13:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH hyperv-fixes,2/3] Refactor assignments of struct
 netvsc_device_info
Thread-Topic: [PATCH hyperv-fixes,2/3] Refactor assignments of struct
 netvsc_device_info
Thread-Index: AQHUrGzJE7xwL7gOHEKsXWq9rspx5qW1zxCg
Date:   Sat, 19 Jan 2019 01:13:08 +0000
Message-ID: <CY4PR21MB0773B3801530A66E72B84BE7D79D0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20190115005144.4494-1-haiyangz@linuxonhyperv.com>
 <20190115005144.4494-3-haiyangz@linuxonhyperv.com>
In-Reply-To: <20190115005144.4494-3-haiyangz@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-19T01:13:06.4543055Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f62b4c45-4d13-4147-a327-0dcbc2230f5f;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:a:e112:b8a4:906c:6906]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0837;6:2NwyWkVq6jgFoTDvmvjxJ7DQSU8Kd6VDt9qD2pY/8n7nro657uFm/qzZm/9MaPUHtw4hpZCYI9t+J4fi3mZ0IwJJb9Wa/Es57OxCBdru9Ywt3nz3HuWROA0bN0A7GvmqeY6e3JvWFOy+3vdJHggpAU/1v+TxNz2V98YUzlob0rUWN9Hftobtl5B55oZK5y+If7BcsNDsBiWmedcC2RrkWaRMFea9JOeQnpziwYyk0GoEr1xp+5HYgq0URO7P7S3KQeD4MuCEqNrGRaC/qFfp8yxZCL139//ucry2BJaKH4cdW/i+RmEiaXeXdtbja3/3KuYsXM6DpFMtKyTbQNq3ExuRHJKD0bhiEvXUWaWtlQqoDm9shlmBSDVItosc5CGRFwaqPPkEI/9k6qYqO7+k8q7+I7WGlpYhzXpmJQM2APys4qS0486Qt2AHdcWriutzhai3/QT6/GWfKM+OFmwWDw==;5:MKM73npDZeghyGqm5OBjeg7fRoLwfT0H+tBwk6zwxN2Jhj9uAQpuBaxqh84wT93ULfnKnYepKC18XQhrE5PeAm9zMkYfiyNthjux+1uBaqQamXn8wEi5rYGrPlXT2XZJn7o+J1ivVkRjvDXiHNtAtK/vHupNbHXG3EnsZMHzhBI+Ew1XW+qd2JDl4shHBaLnsu+f0Lics5HVixoHvtl++w==;7:kZ+QocUXPjkUbiBt97b3GIufS1p14eYIQD1tCnKPSh7+sQWGNqAKslQcsfDRN8qoihxWzjcfZLYRPG49TFsop/eJBdi8aSz4D09aBWsOejDr/PSK0N274U2M5j6XoHvpLgDa6KCoJUiVJrV2QcUNuw==
x-ms-office365-filtering-correlation-id: 6c66ab33-178a-45a8-7a5a-08d67dab45fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0837;
x-ms-traffictypediagnostic: CY4PR21MB0837:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0837A935160EADEF22EC1B35D79D0@CY4PR21MB0837.namprd21.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(186003)(46003)(2906002)(6506007)(486006)(105586002)(71200400001)(110136005)(74316002)(316002)(478600001)(25786009)(10290500003)(86362001)(7736002)(54906003)(256004)(2501003)(446003)(71190400001)(97736004)(106356001)(6346003)(11346002)(476003)(305945005)(9686003)(76176011)(86612001)(53936002)(8936002)(81156014)(102836004)(229853002)(55016002)(99286004)(81166006)(6436002)(6246003)(5660300001)(14454004)(4744005)(22452003)(68736007)(8676002)(6116002)(1511001)(33656002)(10090500001)(8990500004)(7696005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0837;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VOLvAMgQBMscSm7gmBKNLxvUWveycY/Rf3edic9lZZ4I1Faz7B0fAPq+mrrKp9x+wBI3ToqOgNfwLuVepXpfaarOcglqjNDaSZpX7U7UwEldD5IJ0h1pRb988FDLUWZgcWO/Qxw8edC7McyDdUpyLPjHEVeWBQ97FJVP4xj0go0JwqFdteeLM3BvFkAfDwc8uVPspMRA3DMwetUw7s2tjNbE+JZpFJ0rDlMVjnjYYraN9m+IT4Nf6oiwnSHGdITeEm6d5DXde7iUgVkfFQqVUAHC9VA9jrnxLAId6i242cob/HPDx/CCF6tCTIshbfiBbBBAGuFsrVN3/f/MqKgdAtDZpdGGsFXaSq3px6eS8JQq3glYOEDSMRm6tHK6DzokqCyEiPZUIymBXhpCLsQZ6eDVXGckyoBynkqbfzDCMik=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c66ab33-178a-45a8-7a5a-08d67dab45fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 01:13:08.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haiyang Zhang <haiyangz@microsoft.com>  Sent: Monday, January 14, 201=
9 4:52 PM
>=20
> These assignments occur in multiple places. The patch refactor them
> to a function for simplicity. It also puts the struct to heap area
> for future expension.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 134 ++++++++++++++++++++------------
>  1 file changed, 85 insertions(+), 49 deletions(-)
>=20
Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
