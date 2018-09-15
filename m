Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575D3ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54FF2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 23:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GXhGrduz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54FF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeIPFEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:04:02 -0400
Received: from mail-eopbgr690096.outbound.protection.outlook.com ([40.107.69.96]:47471
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbeIPFEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9s115vHs0XtEBZvtq1tvePoixHvuBZBbo00ZCHUKNk=;
 b=GXhGrduzuk3q2+vDbRIVElCVCh0+d5M7o0GfyGYgu8a4SqXXQsSDABcsTox8Te/EzzTSFNZ5Igaeg+6cwxY2M1wq2h2M9HbnFURq+dVlhWoGDL64oZAbliJRbB4sgGBnbgYva7CAEozlUXuLzAz1RA3p8ciGQoencvRFlZO304s=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 23:43:12 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1164.014; Sat, 15 Sep 2018
 23:43:12 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Yi Sun <yi.y.sun@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "chao.p.peng@intel.com" <chao.p.peng@intel.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "michael.h.kelly@microsoft.com" <michael.h.kelly@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: RE: [PATCH v1 0/3] Enable PV qspinlock for Hyper-V
Thread-Topic: [PATCH v1 0/3] Enable PV qspinlock for Hyper-V
Thread-Index: AQHUS0WDN0wqvgXo+0iRNhmLe1uLJ6TyA9yg
Date:   Sat, 15 Sep 2018 23:43:12 +0000
Message-ID: <CY4PR21MB07735BAA5C00C933C4E00C9FDC180@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1536830005-37260-1-git-send-email-yi.y.sun@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-15T23:43:10.5965432Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:vbqUGy2ecRYaYmkbTRQJxGn2bkbSmcK5xT4M6nowVjhhn9zLE2x93pSWIt5sH7j7NnhbNwU9XaMDkGPmx70jOvQ/Fpe/iM5Y6FM7bOnCAirCx2p/N8wi8JjF3x10FnZYDWmHdKlXOSswbrasp++FwObfTLXVqeLIORCIwLUIxS9WbVv7JpWgEvVWS5vgDdkvbEexdkTLmiFAptlbAd/WZwa5xNq+9rEJ0lpSYrr0E9EziLEQu6OgL3GaDbCHn51oXZRy+qMpEvI3OOiPSbLSG+JLh0eRR60CECMjcUKAd8Ke9OJ3y2GVSif/9ygDmjH0Nla8aqdcCgi6/msB6+a1vhr4ZZIO3CC2rW4dzz0t9TRQMGBFysud6Eu4UoJ6XmsydhB5ExYlATf8Haq4nJGTwK2zH/fZRHeE3OLJcdzhUa21DgIEwnzkIvkNoW08/0hvjUz+gPqGknrWDYB9ojRo+Q==;5:gf7YBxdYewvbrEoS2R4ZVP1yIp2HoAKwnSA25ITVpL5nZMMMHguitu81os8JNf8nUuIvXJ7Smaj7bXMDzg4O3f8jY08ubUb24L81h+Hn0tkTteSGeVQ5/DLKeLPrE8D84hA1f58XAkLL4bRx869T3cHvwLaCdR2x8jZhQJ08mH4=;7:UxToomyPaXM8lHemRvnisYmb0OysgtXc6rfm1A+0UnLNxUrYh3guYqt0rO6sauzGUNhoRvXQQkwuRaAP/0bcHrx5T9bjwC8+WOmibvwAqz4M9y88pXy7hqOLqzhftwOzW7oA3qVnqeSlIERPLkbhegd9wLmz4++ewnePrBb9ZepqLX/4caIzspGRoaVzjrhggR0egcAUp3r0RZQA4QDwXLr718tR1V5iTy/4JSxOTdc3d0ATMlFihafPm8bIwbfH
x-ms-office365-filtering-correlation-id: 36fd5399-9874-441c-0f8e-08d61b64fff0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469F67899FFDED5F9230C1FDC180@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(396003)(376002)(199004)(189003)(6506007)(8936002)(2900100001)(68736007)(4326008)(7736002)(5660300001)(10090500001)(6246003)(74316002)(316002)(305945005)(33656002)(53936002)(22452003)(9686003)(14454004)(3846002)(81166006)(81156014)(11346002)(8990500004)(486006)(476003)(2906002)(7696005)(229853002)(8676002)(6436002)(10290500003)(99286004)(55016002)(105586002)(256004)(106356001)(86362001)(97736004)(72206003)(478600001)(446003)(102836004)(2501003)(5250100002)(66066001)(54906003)(26005)(110136005)(6116002)(86612001)(25786009)(76176011)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QZg4MJbrZ3JHk5m9lG+myZbjoMDDwCBKWUCF5XDQOvdefLnhpMidrBb/Bvuk7tMjFQOzaACO4538FU2BTZaylTFXlk7OHh82b/usrBTDHGwiJUGKtci5edH7UGMqL3rH9tR/bjWsGFJI+K6Lh9sHJ+ufr7G0Tkv+zCMsihaEiKlguQFShs/BQZeUfMfTrJkRKpaODcJt3NRKj+HVOrwyLmLbtd0FXjbOhi7aWTTCiyIyaOCBmW1qefdghNAb6yA8xvPKBbDOMlC2pIqRd7RCDpPF5WhOnD/SU9zMc4B7GmTBzGdfyJ82U6VZJfNs0LbJ+z0xQz2DXNZbVMHs9Ya7WVdYByIYqEkTgiemwID/hSM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fd5399-9874-441c-0f8e-08d61b64fff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 23:43:12.2554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yi Sun   Sent: Thursday, September 13, 2018 2:13 AM

> This patch adds the necessary Hyper-V specific code to allow
> PV qspinlock work on Hyper-V.
>=20

Have you done any performance measurements with this
new code, so that we know whether there is any improvement,
or even potentially any degradation in some circumstances?

Michael
=20

