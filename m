Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C95ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02FA208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iQEUMCI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02FA208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbeGMOOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:14:43 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:45129
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729634AbeGMOOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ymd0URkkK5xZNQT/FrUXRzVFNSKFnSALZSmwdS9jN4=;
 b=iQEUMCI6HGatgfjHoY/QE/JErYCbpAUYcUDrnOq3oyOte2WwYfUV1i5Tk5xGW+Qmclb0Op5+bSkgRC7f85p1wMN5hwHtjs14cD7g7GquBjAbFEKObVzg0mfne9sGvmKPOLDuMAVog19p9Xe8SQtUue7r+WCblb1W7ycT1oyhZEI=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB1086.namprd21.prod.outlook.com (52.132.115.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.11; Fri, 13 Jul 2018 13:59:54 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0952.017; Fri, 13 Jul 2018
 13:59:54 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'" 
        <driverdev-devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Reset the channel callback in
 vmbus_onoffer_rescind()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Reset the channel callback in
 vmbus_onoffer_rescind()
Thread-Index: AdQabZD2BvGNy8mQSA6EBi8Sb0y3RAAQ80cQ
Date:   Fri, 13 Jul 2018 13:59:53 +0000
Message-ID: <SN6PR2101MB11206000A6F0B4AAF5BDA2D0DC580@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <PU1P153MB0169A44E23292552EF7CD317BF580@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169A44E23292552EF7CD317BF580@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-13T05:53:25.2012762Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1086;6:Q1Y8r18xz/vwd+2FVQN0RNt6lft5cYhj01kSiPIR1xJrq/O3Hor+jEoSVz7t8VFId5QYF0IQC23zLTo91qf7NHH92lqQXStW2FHzLUaur4c0yZa+qghHhVc5hy23DssxdniSs74oVtI0imLQxNcotvvz+Pc7me3Nf78qz1q+OJVSVVrY6FjfkiE1Nna4GqXtx4Z3+Ua8ZDO11sDQujPkGZrsDmbXwKWVpW1Q72a3DVTV7tzBtgszgqJpbGfHwxzUz2bWZ41mV0a5zET1bWdk+c3frzM0g3rsasvBI8aM73eubQWChIS/FkM21uZ4PZlsNR6QDQKhucGi1hC8Vp/qPg/lZO12Se7ZrqeawYgTe7OKFAClGT7s94cB98u5C0tvm2DFL2JEhsY13UlUWA3QjmL408FywPoOUZYaFUXfJQ+WsytrQO9BzJ7WEZSHKlMmKy9KjSvL5ebEi5onVWN+Ug==;5:2aaVYRlN354Bg0Qkl2yaYcGQpJx/x18idDDS0VzH0Ddn5JJRLLHwwZkM9kAOqYJn50674pmt7yUaG0LJZe0ZX6sFW1UR4lJDU0mz+J2/rA/125KPHDawb2ZSBH4BSUgDbmDj1YpYyCZDRRXwxFT541opU20qyCzh381VuO64y1U=;7:JtN7hmfckuF9hRY+YPj9JILr2gGPx02FesdeOs5wxVZvv9ilvYEUNovXpReoya4HnOGduCOaVqB3MR0u9c2BtzqRAvt/gW8o3EDYWjGHRgMcLFPyKsj6Nxfrx5QoFrU7y82Tx46QI3XIBp/8hu1HrT7ENNBZ39PyevGSPuMyIvHsfPpDwmgPUn3+rbUQkOa+IHiMRtfw0s1uDT9KZuXba1urmqNxLkpGm/eSAcHNwqp7kI9hXIcfq/WN6k2UNhqA
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e7193465-d082-48a9-4bc3-08d5e8c8e8e2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1086;
x-ms-traffictypediagnostic: SN6PR2101MB1086:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB10860E3205587158DD416490DC580@SN6PR2101MB1086.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB1086;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1086;
x-forefront-prvs: 07326CFBC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(6506007)(4326008)(105586002)(72206003)(66066001)(110136005)(25786009)(86362001)(54906003)(76176011)(229853002)(68736007)(8676002)(3846002)(6116002)(106356001)(33656002)(1511001)(81156014)(6636002)(81166006)(26005)(97736004)(102836004)(53936002)(14444005)(256004)(14454004)(305945005)(10290500003)(74316002)(316002)(22452003)(86612001)(7696005)(7736002)(5660300001)(486006)(99286004)(55016002)(5250100002)(9686003)(6246003)(10090500001)(476003)(8990500004)(478600001)(2906002)(6436002)(446003)(8936002)(11346002)(2900100001)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1086;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qD0pKEPY1X5xYtNXbr/Ij2Uuj9nvZQc79jcDtrI/anZJhnqgyhgWwmRveKUKK8aG7V7nwJWuDyQOI0kxZXksgPD0PUMICMm1ODVcYQneUtoWpebbMGXWR8UvqBDijlsqQFXsm//kKCFEGDFp2QyO4FvLcgodN89Vz1HnH4zAIVkwkWBqXwrXG/ovXxgOwNFgU0Bg7l2nRrKRHQnCEwbeP82Di8UMNzgYOBo1U5YIREVNy8yqhT5f7PHmlXXsZQ1gWNgPNZPNUBMRsLtnGsUsilYvPQqjZNI6sBnI8ehCR7INO4kGdD/nOyfZ6WpckJ8iBNxTvFDflpLjzdjYLrQWJMVxC4eJczwEi/KreCxxXUA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7193465-d082-48a9-4bc3-08d5e8c8e8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2018 13:59:54.0060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui  Sent: Thursday, July 12, 2018 10:53 PM
>=20
> Before setting channel->rescind in vmbus_rescind_cleanup(), we should mak=
e
> sure the channel callback won't run any more, otherwise a high-level
> driver like pci_hyperv, which may be infinitely waiting for the host VSP'=
s
> response and notices the channel has been rescinded, can't safely give
> up: e.g., in hv_pci_protocol_negotiation() -> wait_for_response(), it's
> unsafe to exit from wait_for_response() and proceed with the on-stack
> variable "comp_pkt" popped. The issue was originally spotted by
> Michael Kelley <mikelley@microsoft.com>.
>=20
> In vmbus_close_internal(), the patch also minimizes the range protected b=
y
> disabling/enabling channel->callback_event: we don't really need that for
> the whole function.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
