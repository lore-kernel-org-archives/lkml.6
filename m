Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeEPHvL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:51:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30092 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751182AbeEPHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:51:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,390,1520870400";
   d="scan'208";a="79549618"
From: Avri Altman <Avri.Altman@wdc.com>
To: Alim Akhtar <alim.akhtar@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "olof@lixom.net" <olof@lixom.net>
Subject: RE: [PATCH 4/4] scsi: ufs: make ufshcd_config_pwr_mode of non-static
 func
Thread-Topic: [PATCH 4/4] scsi: ufs: make ufshcd_config_pwr_mode of non-static
 func
Thread-Index: AQHT5STZSjTSVdzvzkOQZqLbyysIQaQyCfYw
Date: Wed, 16 May 2018 07:51:04 +0000
Message-ID: <DM5PR04MB1085F180B84B88B4D10FE83EFC920@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
        <CGME20180506102643epcas2p24ed80d7ede859db73c2595724d9c2414@epcas2p2.samsung.com>
 <1525601658-31989-5-git-send-email-alim.akhtar@samsung.com>
In-Reply-To: <1525601658-31989-5-git-send-email-alim.akhtar@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0908;7:uAY43vbzPlpsvdcPIjfOsB4X7St9rV0tmSHjLDysQcDcX4ThbapiIkOTGra7CCZmXOVN92t3L94ZzlcYPxHw9zRP9fHELOYt1JcTTbr2RYcjPO4iPFo+s8w0HBmcecLE0sF4syhCKqqc7Rv10cXL0EViA5DyuqGgZeUubCJ0FKgRqMmRBHVdNcJ905ffGuZJv+Lw9+qHhdjnSVGSpO7Qd+9uhkH7eXdXGp8JaPwPOhC6/FLVYNMyT85nI2EoWdKp;20:mBmI7KNgDMIQMIhH6QGhAGSznHLg5YRzSFqF4ghSP+dfqw5BuVlZk7Mcj68DCD216TwGLSwKbfW4gLl3lJF13+VqHyfkm3SsIy9xuKI2y0cSgu3Wp61sQFmJefmMuQEaU1TQK7V8qtT4nbgKknQfXROnNL/MhGcdv/iDOb8IY+c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB0908;
x-ms-traffictypediagnostic: DM5PR04MB0908:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com;
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB09084BA6501BA040917967D0FC920@DM5PR04MB0908.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR04MB0908;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0908;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(346002)(396003)(39380400002)(13464003)(189003)(199004)(66066001)(4326008)(26005)(316002)(54906003)(110136005)(186003)(106356001)(229853002)(105586002)(74316002)(68736007)(6436002)(14454004)(33656002)(305945005)(97736004)(6506007)(53546011)(76176011)(39060400002)(7736002)(6246003)(7696005)(55016002)(25786009)(72206003)(478600001)(3846002)(6116002)(8936002)(53936002)(3280700002)(99286004)(9686003)(81166006)(102836004)(81156014)(8676002)(2900100001)(5660300001)(5250100002)(2201001)(86362001)(3660700001)(11346002)(476003)(446003)(2501003)(486006)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0908;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: d7/NrsxN6E11RTARiRyOPs3wd3AyUvIwbV2dU++vU0hNlSa6F9G9r2dzhiQckRiRQQlkje/qwype8EE633xF8aIpg1zxa8XEc23LdE2hwD2Yvamfqngvm6c8jc3XcilccdRFS+QyRvnjSGI0Bfr2Hq+M1a3u5Dq7qDV8j5Mv6gs6f3G9j2L/r7SSzaBKiAhb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1c8fff63-4a41-4b4d-4541-08d5bb01c6e7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8fff63-4a41-4b4d-4541-08d5bb01c6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 07:51:04.7637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0908
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G7pWoc017434



> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org>
> On Behalf Of Alim Akhtar
> Sent: Sunday, May 06, 2018 1:14 PM
> To: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
> vivek.gautam@codeaurora.org; subhashj@codeaurora.org;
> vinholikatti@gmail.com; olof@lixom.net; alim.akhtar@samsung.com
> Subject: [PATCH 4/4] scsi: ufs: make ufshcd_config_pwr_mode of non-static
> func
> 
> This makes ufshcd_config_pwr_mode non-static so that other vendors like
> exynos can use the same.
> 
> Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Avri Altman <avri.altman@wdc.com>

Might be also useful exporting an API for all uic commands?

Thanks,
Avri 
