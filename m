Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ED8AFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB58208D9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ejuzm6WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB58208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935761AbeFMWDm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:03:42 -0400
Received: from mail-eopbgr690112.outbound.protection.outlook.com ([40.107.69.112]:23814
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935524AbeFMWDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+GurbtQbXzYDcGLjk7LUqycmuhzNAOSsGYtJ2Bifos=;
 b=ejuzm6WS49wHyQncyFPek9KK0vPGwehtmkjJWLh9dxrOC8beIN4SwYbOeiwGvOMgHMKEPTbE+TnfcewH/IEaRwEpRipPzip9GpjG33P7hNX0YFWx1yfW+6qy0bqOO4iO6bgudp9Zqle+0dXV+qNgPFxpJPZ0yyMCcRbkNDhmGXk=
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com (52.132.114.24) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.9; Wed, 13 Jun 2018 22:03:34 +0000
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::a8d3:afc9:87ec:813a]) by SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::a8d3:afc9:87ec:813a%7]) with mapi id 15.20.0884.010; Wed, 13 Jun 2018
 22:03:34 +0000
From:   Yidong Ren <Yidong.Ren@microsoft.com>
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Yidong Ren <yidren@linuxonhyperv.com>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Topic: [PATCH v2] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Index: AQHUA03xJw7BTbCmTka+qtF/PXCtsKReudiAgAAAajA=
Date:   Wed, 13 Jun 2018 22:03:34 +0000
Message-ID: <SN6PR2101MB11353820325BBF4712076573847E0@SN6PR2101MB1135.namprd21.prod.outlook.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
 <20180613144813.708f26bf@xeon-e3>
In-Reply-To: <20180613144813.708f26bf@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=yidren@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-06-13T22:03:32.1325252Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [131.107.160.111]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB0909;7:cUdU+xauKKalm+EKXBM//Dt1RXPh5oM+mtKkcfAfT12Q+Tn7AHTH6guLpJxrBTYTo5xg2JyxEXH8Nrf5T4wdl25D/RBGpTVbmgol/z8zIfwnNSskBVZ4VlZNCzb/RAJzMvGhskyQQRNEu6I4+OGNkuOGiXudLDmpTHCXqXLCng2Rvyp9ocam+3U/tsYoMff9JCrsO46u9FSrnCqlhpOwFwK7M1KCC3RsBJKZgzTK7sKg+UF0U6WPM++2UF0EO+ta
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: a115ec0b-4984-450f-b3ac-08d5d1798214
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yidong.Ren@microsoft.com; 
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <SN6PR2101MB0909D1069484E1BFB6C3C0D5847E0@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB0909;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0909;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(199004)(189003)(74316002)(486006)(305945005)(7736002)(102836004)(5660300001)(25786009)(229853002)(4326008)(6506007)(5250100002)(7696005)(26005)(6246003)(105586002)(66066001)(97736004)(186003)(11346002)(446003)(86612001)(8990500004)(76176011)(86362001)(476003)(316002)(2906002)(8936002)(99286004)(10090500001)(3280700002)(33656002)(478600001)(6436002)(14454004)(55016002)(81166006)(54906003)(110136005)(10290500003)(81156014)(53936002)(3846002)(106356001)(72206003)(8676002)(68736007)(22452003)(3660700001)(9686003)(6116002)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB1135.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QXLIk0MtvT51nN1u8Rf6FSt6sAc2Oi1yJXWDVaqrQYOAHLOrNq6qjF6hZDd/bhh/JpDJxd0M0S2x3OZHFBkGUbKx+9IO3zXlJXclwrDJtFmVfrbhMGu68p3DnGc+toiSYARnLyIyIE6jnhjEAnw/VVkByPb43C4N25v79vUSwJgoIss9uEGPp43ssavat3Vc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a115ec0b-4984-450f-b3ac-08d5d1798214
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 22:03:34.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf
> Of Stephen Hemminger
> > +/* statistics per queue (rx/tx packets/bytes) */ #define
> > +NETVSC_PCPU_STATS_LEN (num_present_cpus() *
> ARRAY_SIZE(pcpu_stats))
>=20
> Even though Hyper-V/Azure does not support hot plug cpu's it might be
> better to num_cpu_possible to avoid any possible future surprises.

That will create a very long output (num_cpu_possible =3D 128 on my machine=
) for ethtool,
While doesn't provide additional info.
num_present_cpus() would cause problem only if someone removed cpu=20
between netvsc_get_sset_count() and netvsc_get_strings() and netvsc_get_eth=
tool_stats().=20

An alternative way could be: Check all stats, and only output if not zero.=
=20
This need to be done in two pass. First pass to get the correct count, seco=
nd pass to print the number.
Is there an elegant way to do this?=20
