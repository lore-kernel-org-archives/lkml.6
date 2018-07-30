Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B284913F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CBF20893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JMEd5Zxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59CBF20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeG3Lrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:47:52 -0400
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:52128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbeG3Lrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUY8AvTdDj6PsvlgG5PCbcCYwgP2c3idF6R6Xj1SvPQ=;
 b=JMEd5ZxvYsNrDWcjF0JaEUOcy5TNzV0jt7yascHtRH6lYyYcjF/aPeE5Gg78cec2z14n8/Q9DIza6aIlhIKXosch45Ngynrr4oIj9zFniH/F8Sbx1Lt3NbbpHVWz8YfyWDqvqEbgYyPk9pPBPaqvV/J62eMKnh/g+zL7sSR0zm8=
Received: from SN6PR02MB4959.namprd02.prod.outlook.com (52.135.116.89) by
 SN6PR02MB4191.namprd02.prod.outlook.com (52.135.70.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Mon, 30 Jul 2018 10:13:29 +0000
Received: from SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7]) by SN6PR02MB4959.namprd02.prod.outlook.com
 ([fe80::fda4:6729:248f:71c7%5]) with mapi id 15.20.0995.020; Mon, 30 Jul 2018
 10:13:26 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency value
Thread-Topic: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency
 value
Thread-Index: AQHUIpY1hAfLUj3oQky4SeVrr27tVqSmH7EAgAF1gLA=
Date:   Mon, 30 Jul 2018 10:13:26 +0000
Message-ID: <SN6PR02MB495915F6DDEC42F4F44DB13BC12F0@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-3-git-send-email-manish.narani@xilinx.com>
 <20180729125106.05692a44@archlinux>
In-Reply-To: <20180729125106.05692a44@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR02MB4191;6:3O+S8zE2My6UnVYXuac6Iq7d/3qSfE5BbETiyRJBMzae1HVzBTj/OULvyU/C2SsvY9hlkNj8bxvM03p+v7+8Cc2Deyzuw5Qz8cXfaDdZutTYXP0WKT+tyHCI3HLiUiWkBd82q5fYOxfkg3k/t8RGGfjnFlGbtorNAfKBsV+3FGwnaPVF70MdbPh5x0R6pPIjv16lumdGDJPyLhsUrJ8NHOaTEQkOHU9dYgY6HEzaNk0/QXClcNLZAOSxcUUhQhVe1+iAKbiv8aLNyN3z1uuJj3pBZHuZ6UUxAnXT/LYxagAN+69McDKegFyp2ofNcYvrbyzbXfLwPQyyiEAP1V/o/uFsNUNuh+de1f4LniD2bgpMcbiu+gMWrCIC/Tr2EU1EOSqO4WsmIsNDLG/pQS4UQl4A3+7Ota0vBuj2duoMhjGtL0q+lUw1C+zW8hbWbdPIbtfqvlfUO/hv+B2ktxPUVQ==;5:5HCkE2pol/e3AlgHpomlxk40bKfPkeCkwIuQ9+ftRE6OQVkGrwIDnCTrHeB0XnFFpa8jgN9wBUbkMfdMgubos8S9o0bCfcA9HnNTP814iF11k53nDjMvsLB/cvDiMwaplWDPRAB4P3e7AlXEWfurfjROvMZuoIM8ETlw2ANpxGs=;7:dwMmmxe0OEUEMKEnm8HH/A99UK820h0eBSOUXBVLvk4YOw5Rsrq+zOPBMtsq6conRq+CEIQop7+/oMVIoYj1I77OWtM8FQlMA4+RTKDPzBBxAP9KUu3k5Nwwj88Du7/VlvAFa+KtZGISid7xw4O/L5cOMG9mTUL95wANaSacSiAzpbwE+XaOBcqHlsowTamUvY9ZvJG6tJI7LIlVk+YjBJB39DPQnJ1rdY6MSIp+GPyNrjSbwWAdbCf8LzF90Xqt
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 7a779b6f-4e0a-418c-ec1e-08d5f6051719
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR02MB4191;
x-ms-traffictypediagnostic: SN6PR02MB4191:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB419134DF733977E3FD541ADCC12F0@SN6PR02MB4191.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4191;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4191;
x-forefront-prvs: 0749DC2CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(13464003)(9686003)(7736002)(53936002)(86362001)(6506007)(102836004)(53546011)(76176011)(305945005)(25786009)(7696005)(55016002)(14454004)(54906003)(106356001)(2906002)(4326008)(11346002)(446003)(6246003)(97736004)(8936002)(6116002)(3846002)(26005)(105586002)(2900100001)(476003)(6436002)(8676002)(33656002)(229853002)(478600001)(68736007)(66066001)(74316002)(486006)(5660300001)(81166006)(81156014)(186003)(72206003)(14444005)(6916009)(5250100002)(256004)(316002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4191;H:SN6PR02MB4959.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6Gl88oLO0bX9pn5tvM30WDFmCBUVDh0MFn5W9cApJl+DkWoWDt03GGgND64E71IsELA5WJ24XNej8BJvVE+oNEMmm3AEeREsPKNiZ8yQJFibHU48B8iu/IRLukR5iS2rd+X+ABqw2Plgg1yIO5jZMo+hTQtgzKYqGAu80HxwLMmU2x1yiobVbzBIk4ypntLdNsii64ZvstUeG0KhwJiH+jDnSOFv0E8vUtx7hm7Bdin3vSkhS5fAuV/GXa4EhS5lRU3pmEUu0u1s8FGVUSEl73E5h/C+ltzcK8iCsRwWXjpP1n0kSbRylVHO20DtQPtZDMwdlNwVcICtpBd026L9HlgDRul3PJdbqUitFje5eg4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a779b6f-4e0a-418c-ec1e-08d5f6051719
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2018 10:13:26.3355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,


> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Sunday, July 29, 2018 5:21 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: Sai Krishna Potthuri <lakshmis@xilinx.com>; Michal Simek
> <michals@xilinx.com>; pmeerw@pmeerw.net; lars@metafoo.de;
> knaack.h@gmx.de; Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> <sgoud@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency =
value
>=20
> On Mon, 23 Jul 2018 20:32:01 +0530
> Manish Narani <manish.narani@xilinx.com> wrote:
>=20
> > This patch limits the xadc pcap clock frequency value to be less than
> > 200MHz. This fixes the issue when zynq is booted at higher frequency
> > values, pcap crosses the maximum limit of 200MHz(Fmax) as it is
> > derived from IOPLL.
> > If this limit is crossed it is required to alter the WEDGE and REDGE
> > bits of XADC_CFG register to make timings better in the interface. So
> > to avoid alteration of these bits every time, the pcap value should
> > not cross the Fmax limit.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>=20
> Applied, to the togreg branch of iio.git.  If you want this backported to=
 stable,
> then request it once this patch is upstream.  It may be sometime given we=
've
> probably just missed the coming merge window.
>=20
> If you do need it faster then let me know and I'll look at moving it over=
 to the
> branch of fixes during the RC phases.
Thanks for getting this applied. There is no concern for this to be in the =
stable
ASAP. I can wait.

Thanks & Regards,
Manish Narani
