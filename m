Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeC2JRr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:17:47 -0400
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:3325
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750716AbeC2JRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:17:45 -0400
From: "Elior, Ariel" <Ariel.Elior@cavium.com>
To: Sinan Kaya <okaya@codeaurora.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>
CC: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
Thread-Topic: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
Thread-Index: AQHTxEcZZxtoEOu+xkGnixx3V0bVgaPm8sKA
Date: Thu, 29 Mar 2018 09:17:43 +0000
Message-ID: <CY1PR0701MB133742146E2848330CA89FB290A20@CY1PR0701MB1337.namprd07.prod.outlook.com>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
 <1521988761-30344-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1521988761-30344-4-git-send-email-okaya@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ariel.Elior@cavium.com;
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB1744;7:pDSza6keV7wt4gZH/MQgw6w2GFwWbtBXVJ4Ydn6rEeATGRzXOAhAManM25AyMbqegpzBVZSAGKaEYOwBivPS+e9Ea4Gy60DJf7OpsMaK4tgGhsGW7EuZGrgmCdou+mqxv6FThYTNKaj4eSUNfUUqrFhYLlqysXmeS6fG59pqZunHO3k6TQSozKdRGxi+GhzIC+oKRwOcwJuJTwKrm3Ttmp39JOf0k1/vKYcybxe3F/OvJz3BD1MuObruHl0rD2oX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d067abba-bb2b-4fc8-1e61-08d59555ed75
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB1744;
x-ms-traffictypediagnostic: CY1PR0701MB1744:
x-microsoft-antispam-prvs: <CY1PR0701MB17446C37CAB3996F0CA17D9D90A20@CY1PR0701MB1744.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(190756311086443)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0701MB1744;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1744;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(316002)(229853002)(446003)(81156014)(305945005)(2501003)(5660300001)(8676002)(74316002)(33656002)(66066001)(26005)(54906003)(105586002)(106356001)(81166006)(110136005)(68736007)(486005)(11346002)(186003)(486005)(2900100001)(97736004)(7736002)(102836004)(6116002)(9686003)(6436002)(5250100002)(4326008)(3280700002)(6246003)(2906002)(53936002)(72206003)(99286004)(14454004)(76176011)(59450400001)(25786009)(3660700001)(6506007)(476003)(478600001)(7696005)(8936002)(86362001)(3846002)(2201001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1744;H:CY1PR0701MB1337.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: wB1y68OnmobmOnfyLn4BtE3H0r0oI2Glp7lAX9g87avTj9gAdPNVFukwDZ6/37hLikliLxBNPRoN5YzvyCJrC9016g8+RQhAFt5oja4oeipP32/sYZaptIjItI69Nv60nXmh/tcrZyQZqh7yQi2gnTDIOckhHLQAG2WqWKfFWMY/D5/NcxLc15itlOFpJbqaS2limVytx07+kmhNOqLAOQq+jvAsIsZmv8k1/tzvtPvytZLnVT7HJfzWLXO5SkPmgMLufNioVoe6ugFSvEc3bTmwA8g24qqhYlveNNZHQxthwzviwC3+WlrzA0HZstTvVIJn8uUQRW/gwO/KHpFuHg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d067abba-bb2b-4fc8-1e61-08d59555ed75
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 09:17:43.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1744
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2T9Hr10030274

> Subject: [PATCH v7 3/7] bnx2x: Replace doorbell barrier() with wmb()
> 
> barrier() doesn't guarantee memory writes to be observed by the hardware on
> all architectures. barrier() only tells compiler not to move this code
> with respect to other read/writes.
> 
> If memory write needs to be observed by the HW, wmb() is the right choice.

The wmb() is there (a couple of lines above). Your modification adds an
unnecessary fence which would hurt high pps scenarios. The memory
writes which the HW needs to observe are the buffer descriptors, not the
producer update message. The producer is written to the HW, and exists
on the stack. The barrier() is there to prevent the compiler from mixing the
order of the prod update message preparation and writing it to the host.
A possible alternative would be to move the existing wmb() to where
the barrier() is, achieving both goals, although in the existing design each
barrier has a distinct purpose. The comment location is misleading, though.

Thanks,
Ariel
