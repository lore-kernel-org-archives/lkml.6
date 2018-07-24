Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7116AECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD3C20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 01:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D3TbXVpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD3C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbeGXCqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 22:46:05 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:33600
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388308AbeGXCqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 22:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7iezUwyjPx5tcUPDN+jHbe1xrZkBTOpJ/7HxYaiiT8=;
 b=D3TbXVpilD7G/URvgiqH5iIJQyantw5Z6T4KsPmEqZTa2WGjl3A3a+CEuIzZ0RwE1lmf5V60xpkAH8+Z2VZulTFDlEsJNHQN8gj4sWSLKVjX7f0t5CnO0Jp0Bvxc/uosnDy6ZF+6Ne69887nyayst+wKzFWS6KW8ykY8UsFSOHg=
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com (52.132.114.24) by
 SN6PR2101MB1102.namprd21.prod.outlook.com (52.132.115.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.1; Tue, 24 Jul 2018 01:42:06 +0000
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::10ea:44ff:21c6:8c07]) by SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::10ea:44ff:21c6:8c07%4]) with mapi id 15.20.1017.000; Tue, 24 Jul 2018
 01:42:06 +0000
From:   Yidong Ren <Yidong.Ren@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Madhan Sivakumar <madhans@microsoft.com>
Subject: RE: [PATCH v3] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Topic: [PATCH v3] hv_netvsc: Add per-cpu ethtool stats for netvsc
Thread-Index: AQHUIu18DGIjsI0UhUqLbw4mP+Fz5KSdl72A
Date:   Tue, 24 Jul 2018 01:42:06 +0000
Message-ID: <SN6PR2101MB11359728E41C4B2AB8E7736D84550@SN6PR2101MB1135.namprd21.prod.outlook.com>
References: <20180613193608.444-1-yidren@linuxonhyperv.com>
 <20180724012622.26873-1-yidren@linuxonhyperv.com>
In-Reply-To: <20180724012622.26873-1-yidren@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=yidren@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-24T01:42:04.9289885Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:3:5198:7fb:df76:5c2d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1102;6:aQJLGM1ij5EDRwAQ6D7slZnisn3HPWDbOE3IYX2lCNf0lfMsYuVAFst9YwqTnd5SPjkntP7ZYsQNQvAHNrlE8/hkccDPIwT5ptkZsSmG5nKuok8Y+uchudwHafE07GM4mWFW/VRRBRJq1ZWRUi2hPqxAlrMd/+vN9ATAg7DDqcPTsU01L5BXM6icFOs+8f6Xzp7FBxXMFk2mN10BAWK9ldf8aswr/QCnujn223Zb55PKvO2Gz7adEGu1HPkRqIGvnfLk2r88C8kzOCtgnSPVgzG9sQm8zTsmCkySWtq+yjgRAwlzIEIyySm4ctu5dF9xkYpO62sfi1MD1lGtdzo8hSOtVXUPIhZPPaUdKiolheJ5VI+PJQUrSF5ska6dhlby5uVyH+Yy5hBG+tNLUJ90a2STYOC7HbLrdlyLFTL35FE5rGT6Lwtu0jPSh8DEyd/YCiQW7XbHF2kXrEcpT2f2tw==;5:bjMEUwfDn1gzoXokHmxDNMFT7EVoWKfDMI5tDoznJMWeCzZnd3wHCOE2zwCjUAdDyZ/nIxCbJdKcZDzJH11HTjXVKqQVg+UQCNjIyct7OR0Qcx0/GT4PlDcUuA0t0GhUmuIu5gzEOwuOf1xp1zyJQ7IKv/flbV0jHMiuq88Xr5Q=;7:cH/tLuCfBgOynqJ3w10txAldcaIak1tRAndMGVIX2TWOLbc6Mv3FOGBMQBmpuADOMOdMK8wwI9/DOQmKEzDK9betjkUcIA1P6fO9LYt1zCBwJVk1nbqOoZszMUCdbb7LK53xDzVx+cS8strpqXBJLz8o4ww21iOjINeMdhhEOMysttNJlMmrUirqfbg+GQFBLXdjyrFkpaLM3CzRVjxlydm14xNaDuVLwTsxWy7wBZwhSioeMEGLPrYf+r+LKDUY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1cd3857b-0e73-4cf8-ca3f-08d5f106a9ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1102;
x-ms-traffictypediagnostic: SN6PR2101MB1102:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yidong.Ren@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB1102EB488EF6014A651E344584550@SN6PR2101MB1102.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1102;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1102;
x-forefront-prvs: 0743E8D0A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(1511001)(4326008)(25786009)(106356001)(8936002)(8676002)(81156014)(81166006)(8990500004)(105586002)(2900100001)(68736007)(7736002)(305945005)(5660300001)(74316002)(10090500001)(72206003)(14454004)(478600001)(10290500003)(6116002)(6436002)(9686003)(55016002)(2501003)(5250100002)(229853002)(2906002)(86362001)(2201001)(86612001)(102836004)(46003)(446003)(76176011)(6506007)(107886003)(7696005)(53936002)(99286004)(33656002)(476003)(486006)(256004)(316002)(22452003)(110136005)(6246003)(11346002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1102;H:SN6PR2101MB1135.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MwwQehlZnCiOsjZDPrh7SxkLb0YPN4QmuUICk7V9ronfe01xXkTbkFtmmX4bvPvB7ORwij3A/HFC1akoEJcHfAFtObwHjAO+h1b5hE4K6IQixfOFERVoP0+RvcOfJjA+WgpSGCCxzzqlfVllErQ26iOPuO42eOnoQDTdnARlc5xucwsjKu6oR+TrgExoMvmzSzgcVMKLY2ZQOAVrEPVBQZmaCzTcC6hMqR+3Mf5mO+FnopOdc5RNV99oK2C+m2Gb5EjQvJAEEFZSCLAJ2ShZTBPeMjFQ6SR9Rovr3hxiT3vGFcHLLrEzy6iw/ohZDsd8zyJbPu3GhhXAksXyY2yBMmsaGYvj5zoJ2S7TrSOuyEE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd3857b-0e73-4cf8-ca3f-08d5f106a9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2018 01:42:06.2701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Yidong Ren <yidren@linuxonhyperv.com>
> Sent: Monday, July 23, 2018 6:26 PM
> +	pcpu_sum =3D kvmalloc(sizeof(struct netvsc_ethtool_pcpu_stats) *
> +			num_present_cpus(), GFP_KERNEL);

Since there is no plan for CPU hotplug in Hyper-V in short term, it is fine=
=20
to use num_present_cpus for now. We can move to debugfs later if necessary.
