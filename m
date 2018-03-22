Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCVUpS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 16:45:18 -0400
Received: from mail-bn3nam01on0137.outbound.protection.outlook.com ([104.47.33.137]:18787
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeCVUpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 16:45:15 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: SWise OGC <swise@opengridcomputing.com>,
        Sinan Kaya <okaya@codeaurora.org>,
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
Thread-Index: AQE8ydHJf7R4NETjQ4ju1lsYxD0xYQEyUahtAa2s6g8ChKTXb6TfHhywgAAD0wCAABrxgIAAMluVgAANcICAAAIMBw==
Date: Thu, 22 Mar 2018 20:45:11 +0000
Message-ID: <BY2PR1201MB098367F8F217A8BF66AE68B6C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <03d201d3c1eb$b71fb460$255f1d20$@opengridcomputing.com>
 <83484a3f-d3f7-d763-e4f8-e4fec3bb8cc2@codeaurora.org>
 <52cbc9d7-5a6b-5c8b-b930-058f5be62079@opengridcomputing.com>
 <BY2PR1201MB098352CB012D8AE8084882F3C8A90@BY2PR1201MB0983.namprd12.prod.outlook.com>,<20180322201649.GC9469@ziepe.ca>
In-Reply-To: <20180322201649.GC9469@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leedom@chelsio.com;
x-originating-ip: [12.32.117.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1201MB0951;6:MO/eJaS0nI1GwVrXdGZ26eswwNiUsBuMc3x3Sb5VtNpxNEOcKfYNWQi5pAvt5AbCPE1My+/9Nu4tGMi97sIygQFYU+hYuZFcaFBi3jyBgf8/Xapa1y68uXpQE+xEzWjBsgy0G8aT/ItkaLXN87d28xKLjcXtLza/rYvY5T7hsaAGPLOCnq7s07XbUXh6WfNBgwlVAuRx/Mw+PNvHtY1kKiTiDeJGGjOAnMMjWlp1px/GZ+JxBexUWX8RO+/F0qFscru739gdwvG4sQFsO1i6AviHDJC87ZHAyLS8Fxc4x/eCEGioGmcV8LffQFcM9lKduc1j9m7GF6sFRUKJgWSR1l01POFXBOtsr6iGS+6YcySVsh/ee8C8tbP7ldI8yLMS;5:03L3bo2jZszpwhdmdl4LhPhpkTglLZM5sXlh1hGpHxGcIfPIBrwlfCaP0NTnuGnXty5//oltwsNCLd9611BuA8mU9o5TLhpCgFeX3xaOVMmPGyAEtYi8wQbhXdrZd5RAkLaCap+GMfGLnbmt8BiYnMDjnn0I0mvpop5KcDF76xk=;24:1GHv3BXfRh1guniLXPViwVTKF0+7USipv/OxUxdreItED4m+P7ZVHzaXZMfBxJOToxWc4tyv2zpiVePwVnpedDA2hjsWdItyaz66RB8qrjs=;7:JmCQV6tw18Gn5ia43IYpKY/IQ0A5VFWqe1SIARiIdPqpiN8p/B4F6BfWQ0HgvTlBe4a8KoFpI3mb2xqmT7StiUgIgVS8k/oUShg6B+86WyZKk34KNFBXtwuRUzWEOjsd5duPNF7ZOXh1+ei6XK+Ei8zeI3gjaDWaHlsAB3bSLcIpqms7Cx4Cp7alEPiTcjuYO1O4frcKITi3eoX6JoxynTY11y6uLPidhGwVjerpvgnWZxfh/3KZx3zjFMgDYAv8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aea15c63-0e0b-4ac4-3b33-08d59035ce8c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(3008032)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY2PR1201MB0951;
x-ms-traffictypediagnostic: BY2PR1201MB0951:
x-ld-processed: 065db76d-a7ae-4c60-b78a-501e8fc17095,ExtAddr
x-microsoft-antispam-prvs: <BY2PR1201MB09518376C63B0E4751F0C627C8A90@BY2PR1201MB0951.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123560045)(20161123558120)(20161123564045)(2016111802025)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:BY2PR1201MB0951;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1201MB0951;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(39380400002)(346002)(376002)(366004)(189003)(199004)(93886005)(6436002)(446003)(26005)(6116002)(3846002)(3280700002)(229853002)(105586002)(77096007)(102836004)(186003)(316002)(97736004)(76176011)(25786009)(4326008)(66066001)(6246003)(5660300001)(3660700001)(7696005)(7416002)(74316002)(8936002)(86362001)(9686003)(68736007)(478600001)(54906003)(33656002)(8676002)(14454004)(81156014)(99286004)(55016002)(81166006)(6916009)(305945005)(7736002)(6506007)(2906002)(53936002)(107886003)(106356001)(2900100001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1201MB0951;H:BY2PR1201MB0983.namprd12.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: T1vZMwk3WKY7OWBLshVk2lt9B03SDCVEgRjHqYrfKnhOtR+TjNCrmv9TcslB6qFnvCrj2J0qBKNdrSovWVhmGaEw0FnxqXVos5ijWo7mnOi+9u8yJG1K4MvTmDVsQyAWXUwlpHVpDIEW0Uv0PNdlFZ1LMrZfYIOPlcXUX2HLemJJrbMc5bzLp0vqLnmAk93nYh7h8v96R2AT7qKPYt7D9+AzaBj74tDbKwRceJ1b3pb72OjBtSVljdf9Z31N+UVtDXxyP+2C/UjrNeaU5mwbI/s6fdQ0g5VY2XULK0b0wCtnnGVmRWUD+5x/aDT+797WPWcxrnYHM4sQUBxP6XTtiw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea15c63-0e0b-4ac4-3b33-08d59035ce8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 20:45:11.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1201MB0951
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MKjV1I000750

Yes, but ...

For instance, I see that the x86 writel() has "memory" in its asm(), which
prevents GCC from reordering generated instructions.  And it ~looks like~
arm64 ~sort of~ gets that with the inclusion of __iowmb() (which translates
to wmb() then dsb(st) which finally holds the GCC "memory" barrier).  Is
this part of the documented semantic of the writel_relaxed()?  The PowerPC
stuff simply defines writel_relaxed() as writel() and I can't find the
bottom of that Rabbit Hole ...

I'm guessing~ that this line in the documentation ~may~ imply the GCC
ordering:

     ... Note that relaxed accesses to
     the same peripheral are guaranteed to be ordered with respect to each
     other. ...

In any case, we really only have a few places where we (the various Chelsio
drivers) need to worry about this: the "Fast Paths" where we have a lot of
I/O to the device.  I think we should leave everything else alone.

Casey
