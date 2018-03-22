Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCVWC6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 18:02:58 -0400
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:47200
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751656AbeCVWC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 18:02:56 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Sinan Kaya <okaya@codeaurora.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: SWise OGC <swise@opengridcomputing.com>,
        "'kbuild test robot'" <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Steve Wise <swise@chelsio.com>, "'Doug Ledford'" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Werner <werner@chelsio.com>
Subject: Re: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Topic: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
Thread-Index: AQE8ydHJf7R4NETjQ4ju1lsYxD0xYQEyUahtAa2s6g8ChKTXb6TfHhywgAAD0wCAABrxgIAAMluVgAANcICAAAIMB4AAEdMAgAAIIXY=
Date: Thu, 22 Mar 2018 22:02:52 +0000
Message-ID: <BY2PR1201MB09833C062294345C829E90A9C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
 <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
 <BY2PR1201MB098352CB012D8AE8084882F3C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
 <20180322201649.GC9469@ziepe.ca>
 <BY2PR1201MB098367F8F217A8BF66AE68B6C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>,<f676414b-20b7-d724-4fcd-d2b4c24259b5@codeaurora.org>
In-Reply-To: <f676414b-20b7-d724-4fcd-d2b4c24259b5@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leedom@chelsio.com;
x-originating-ip: [12.32.117.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1201MB0933;7:DfZWCAYlme3nJw7cn2c9LRLV2Qu4/7TaEfWNrGC1rQsxk7ReuRioW31hmGzgfGmoICFus4Lbf/NfpSjj/b5dOdNed7KbvQrb0glDr9yD3I49VSeEF8w8PXO5jRHuir3D5ZQhOlp1GqkRI1xJtBvk1Opga2XPxRSnTQn3M4nzYzut47ygeR5InYTPyGoK3YVQQVYAhTfgzJJFbICjrx/0JGIDf34Sq3rpzbEYkM7Dp9joBY1V0Z4AyeXbehAJciIL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c29ec063-8048-400f-84c7-08d59040a88d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY2PR1201MB0933;
x-ms-traffictypediagnostic: BY2PR1201MB0933:
x-ld-processed: 065db76d-a7ae-4c60-b78a-501e8fc17095,ExtAddr
x-microsoft-antispam-prvs: <BY2PR1201MB0933E7D4DFF5E7CDEA9AE991C8A90@BY2PR1201MB0933.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:BY2PR1201MB0933;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1201MB0933;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39840400004)(396003)(376002)(366004)(51444003)(199004)(189003)(305945005)(99286004)(81166006)(81156014)(5660300001)(7736002)(4326008)(8676002)(86362001)(26005)(9686003)(14454004)(53936002)(6246003)(107886003)(55016002)(102836004)(446003)(3660700001)(11346002)(54906003)(316002)(110136005)(7416002)(77096007)(68736007)(8936002)(6506007)(76176011)(7696005)(186003)(478600001)(93886005)(74316002)(33656002)(97736004)(106356001)(6116002)(3846002)(25786009)(66066001)(2906002)(6436002)(3280700002)(229853002)(105586002)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1201MB0933;H:BY2PR1201MB0983.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: GAW1owWnJvHOJasl3yjmXOR1aE40Iwk3UDIpkOV/tZBcMIsUYzZJ4sq3KPw/7c4Mno8I/Z8FqT0kVmdKV0ITCPB+uSkfEh8/TcJ5ksBl1e86B1R6/QvBfLFfNasK/wLoEiwHI/PTZn6Jlv6yOhQTVrHBES6eW8rN9q5Tykudyg+zXKYsA3FN8kh61uIaR9T5Cnez9zs1ntBWZ3IPJQH5+0EHyBwl6pbhjfQXysKClRzZF/c3St+UN0MWwE1C+H0kpw5G4Tg080WiEcExnxZumNCLALmdvYNcVfNNQUDuAYHcFc19/P5+IWHHD5hv/hS718xBfgA+r5s7tLIHnvpkMw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29ec063-8048-400f-84c7-08d59040a88d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 22:02:52.1696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1201MB0933
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MM34Sp026265

  Okay, thanks Sinan.  I ~think~ we're on the same page here.

  Our guy Michael Werner is carefully going through our drivers with Steve
Wise.  I'd like to let them work on the changes with a lot of thought and
testing before diving in too far.

  We had thought that we could get around the lack of a real Relaxed
Ordering Write on the PowerPC via the __raw_write*() API, but that isn't
really part of the defined API and various platforms define that API
differently (some doing PCI Byte Ordering rearrangements and some not).  I
think that we're going to have to work with the PowerPC platform folks to
get a real Relaxed Ordering Write.

Casey
