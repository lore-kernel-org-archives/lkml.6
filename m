Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeCVTo5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:44:57 -0400
Received: from mail-cys01nam02on0133.outbound.protection.outlook.com ([104.47.37.133]:64714
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751729AbeCVToz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:44:55 -0400
From: Casey Leedom <leedom@chelsio.com>
To: SWise OGC <swise@opengridcomputing.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "'kbuild test robot'" <lkp@intel.com>
CC: "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Steve Wise <swise@chelsio.com>, "'Doug Ledford'" <dledford@redhat.com>,
        "'Jason Gunthorpe'" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Werner <werner@chelsio.com>
Subject: Re: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
Thread-Topic: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
Thread-Index: AQE8ydHJf7R4NETjQ4ju1lsYxD0xYQEyUahtAa2s6g8ChKTXb6TfHhywgAAD0wCAABrxgIAAMluV
Date: Thu, 22 Mar 2018 19:44:51 +0000
Message-ID: <BY2PR1201MB098352CB012D8AE8084882F3C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>,<52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
In-Reply-To: <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leedom@chelsio.com;
x-originating-ip: [12.32.117.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1201MB1029;7:u0kQMwwUPac1pjGsxm9pC9gKUA44rmH4yLbjDpKkitTPPiebV95ve5unZ/meawwQMTd0kyVc3dQtm+Eb/R9p3A/z4TZu5Qzs3mOGSFCQfObqbxzX/acVDFKncUD3T4+5wDygiLfShSZYxMIaSHAUXddJtIUOtcqOJr9E/uoRBIRtU+riMWZq1VyRkYpbMZtfchytcdLmu5NqHGhTWwcIg32ed4aVGQcAY5JaQVIaJhYKvHol9xm2JQRZwDfvnFNe
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 10ca11e3-f67d-44bf-a2df-08d5902d60e5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY2PR1201MB1029;
x-ms-traffictypediagnostic: BY2PR1201MB1029:
x-ld-processed: 065db76d-a7ae-4c60-b78a-501e8fc17095,ExtAddr
x-microsoft-antispam-prvs: <BY2PR1201MB10292199352EF17795336B04C8A90@BY2PR1201MB1029.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:BY2PR1201MB1029;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1201MB1029;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39840400004)(39380400002)(376002)(366004)(189003)(199004)(8676002)(55016002)(14454004)(99286004)(7736002)(305945005)(478600001)(9686003)(110136005)(54906003)(33656002)(68736007)(106356001)(53936002)(6506007)(2906002)(93886005)(107886003)(229853002)(102836004)(77096007)(3280700002)(316002)(186003)(446003)(26005)(6436002)(105586002)(3846002)(6116002)(7416002)(7696005)(74316002)(8936002)(2900100001)(4326008)(81166006)(86362001)(97736004)(25786009)(66066001)(76176011)(6246003)(3660700001)(5660300001)(81156014)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1201MB1029;H:BY2PR1201MB0983.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: o1Hnqsv2RfKbETwoQ9l/019WQ4eKBRkAedq8Y3iwqdgBYxR2+1Kyotlu6J5Mt4RlKze6ksFlL21Cn+CyyRxUD2dhVwlZGRZOHHKHaOW3itMnPATpCVOpPacsPeSzaldfcdDygzgr5Q7RXbmNuD5q2Fifg4oO1EnBadoE6tNQ/CDew+GdtXyqLghuLFtjCD8JYvcj2mSZMYEUPADcruU0rT+kT/l4nequapar5Y9epb+ugxuyn/uSOqI//ikwB1cSaWCMqUW/MPeiZ1i5EPKryqh5eNXPr380iJIK6UZ6IpRBJ/OFYBUOLwWEIfrK9TQJ3g3UTwmHfGj7FqTiWNr/8g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca11e3-f67d-44bf-a2df-08d5902d60e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 19:44:51.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1201MB1029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MJjeBV009149

| From: Steve Wise <swise@opengridcomputing.com>
| Sent: Thursday, March 22, 2018 9:28 AM
|
| | From: Sinan Kaya <okaya@codeaurora.org>
| | Date: Thursday, March 22, 2018 7:52 AM
| |
| | Isn't this a PowerPC problem? Why penalize other architectures?
| 
| I worry it breaks PPC.

And all other architectures.  Aparraently there isn't a formal API
description for writel_relaxed() and Co., nor __raw_writel(), etc.  What I
think we need is a formal semantic definition of exactly what these APIs is
supposed to do and then we can make sure that they all do that.  Till we
have a consistent definition/implementation, trying to use these APIs in
multi-platform code will be a problem.

For instance, and this is merely an example not a prescription of what I'm
talking about:

    writel():
      -- Ensures correct byte ordering.
      -- Ensures no compiler reordering.
      -- Ensures instruction level synchronization with respect
      --   to previous and succeeding reads and writes.

    writel_relaxed():
      -- Ensures correct byte ordering.
      -- Ensures no compiler reordering.
      -- Ensures instruction level synchronization with respect
      --   to previous writes.

    __raw_writel():
      -- Ensures correct byte ordering.
      -- Ensures no compiler reordering.
 
| I appreciate you doing this.

As do I!  I'm just worried that because the API semantic definitions don't
seem to be formalized for writel_relaxed() and Co., we're in danger of
getting wildly different results on one platform or another based on
differring implementation semantics.

Casey
