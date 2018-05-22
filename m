Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeEVKNP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:13:15 -0400
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:20988
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751421AbeEVKNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:13:11 -0400
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PTP clock driver for FSL DPAA
Thread-Topic: PTP clock driver for FSL DPAA
Thread-Index: AdPxtVYsdP5f4YQ3SI+1DIE7yAR8qQ==
Date: Tue, 22 May 2018 10:13:09 +0000
Message-ID: <DB6PR0401MB253642900DF5055FC8E7221FF8940@DB6PR0401MB2536.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2261;7:j7UZxiT4xLmaS3yppR22VM46bVDgq2AC4u270+OI5XUz3UxqsvCaDEog4hSX6oB0KR92+PxzLkkLSWzJqdvi4EboEXGdUzeidYkGdQ6mpCayDlLT1sBf7OaCuNJoxp4KM/NlmjReAq9fZeTgKKKVK5TBc4ILapvOu2O+zaay1ySqmF1bCKNMuxcnM3FV43ZdYoFrpiM+9K2sHU6G/s0IW0QY1JUQG/h2XIcALZd0kudWOY2KNG3FUmjM515CjsKn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2261;
x-ms-traffictypediagnostic: DB6PR0401MB2261:
x-microsoft-antispam-prvs: <DB6PR0401MB226164752E226A8B89E79F40F8940@DB6PR0401MB2261.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2261;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2261;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(346002)(39860400002)(376002)(189003)(199004)(305945005)(81166006)(14454004)(74316002)(6436002)(68736007)(97736004)(478600001)(99286004)(186003)(2900100001)(7736002)(7696005)(316002)(55016002)(81156014)(8936002)(8676002)(5250100002)(25786009)(1411001)(66066001)(86362001)(4326008)(5660300001)(3280700002)(6506007)(9686003)(486006)(102836004)(6916009)(53936002)(6116002)(54906003)(3660700001)(33656002)(26005)(2906002)(106356001)(105586002)(476003)(39060400002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2261;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Fbriy45+dMzMFoRdlgi0hd2PRG5HpoJRlQDEHTPj2dmQZ7fLTc5KhepRGxhXv1WnO9aWzxzXDs5LD8GawFPWtbYi9xwJ3SqHw1DQ4ocMfHC51qunl/J/mkAfaPv6mABJflqAM3D6PMcWMdL+eR6nZ6xGCW8R4uw06opnkntk7wg4kAYHkdVC42v++A6QBEZd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2af0585b-81aa-4ce7-b53e-08d5bfcc9e8e
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af0585b-81aa-4ce7-b53e-08d5bfcc9e8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 10:13:09.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2261
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MADM3u024312

Hi Richard,

I'm going to make a PTP clock driver patch for FSL DPAA ethernet controller. (drivers/net/ethernet/freescale/dpaa/)
Actually the 1588 timer module on FSL DPAA is same with the one on FSL eTSEC in hardware.(whose PTP clock driver is drivers/net/ethernet/freescale/gianfar_ptp.c)

So there are two options for me I think.
Option #1, just make a dpaa_ptp.c driver which will be almost same with gianfar_ptp.c.
Option #2, try to reuse gianfar_ptp.c driver by reworking it as a common driver, renaming it, and putting it to a common place (drivers/ptp/ or still drivers/net/ethernet/freescale/).

I'd like to ask your suggestion.
Thanks a lot.

Best regards,
Yangbo Lu
