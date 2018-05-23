Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeEWOeM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:34:12 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:40396 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeEWOeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:34:10 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
        "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "pelcan@codeaurora.org" <pelcan@codeaurora.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v9 3/4] arm64: Implement page table free interfaces
Thread-Topic: [PATCH v9 3/4] arm64: Implement page table free interfaces
Thread-Index: AQHT4FbVq19ZZy5kvUykUaDFFbJcE6Q9fIwAgAAInIA=
Date: Wed, 23 May 2018 14:34:06 +0000
Message-ID: <1527085967.14039.10.camel@hpe.com>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
         <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
         <20180523140157.GG26965@arm.com>
In-Reply-To: <20180523140157.GG26965@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0708;7:M98sDonxhg2u/ZN1j1ERZey8c48jM0JUSDcOWUeKdLNsNRWvUeIq93wcGyaGIM61kG/RcglRMaSf6wrHelegMRPZNEQj3ZYy8nWB/ONbsJJ5T1KsrYXP5eVlFTatEeCUs38eKfDl0HBJMH9JSREvtBnrO56XEtBSxt0gbP8S1L7wES88FWQLzVp/K3ySAmlJH473d6fPkBxBCr56SW3LyvJ+kBIZAVi3jxaQdUkK68kiY9+jSeXcs3e0g3fL7eJz
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0708;
x-ms-traffictypediagnostic: AT5PR8401MB0708:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-microsoft-antispam-prvs: <AT5PR8401MB070868367092870D97D22514826B0@AT5PR8401MB0708.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0708;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0708;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(366004)(396003)(376002)(199004)(189003)(377424004)(5660300001)(76176011)(7416002)(6506007)(2900100001)(8676002)(6306002)(81166006)(81156014)(2906002)(8936002)(229853002)(97736004)(305945005)(53936002)(7736002)(6512007)(59450400001)(86362001)(110136005)(102836004)(54906003)(68736007)(6486002)(316002)(66066001)(6246003)(446003)(26005)(11346002)(14454004)(3280700002)(25786009)(105586002)(103116003)(99286004)(2616005)(186003)(6436002)(106356001)(4326008)(36756003)(486006)(966005)(2501003)(476003)(6116002)(3846002)(478600001)(5250100002)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0708;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: p5sEDMDg+7UY46RZIjVNQwcsiYA0Yl/XiTi5kRRKAPH3QwO7TsPr4hmrWVevcNGBCOQrJzoZlhPKxF1EX+WvldC0GE+U7Q77rO6krGYBIvp9Fuo1IySXs/13eVXby3AKQldQwIepyCU75EH70F9viVRwA5uU4rA1++tPf+ytKKiUi6frEfqYaMv2/C1yJVkM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B70EC0430CDD48AEAFE53AFF6E7F8E@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 664c3d6d-b79c-4457-37c4-08d5c0ba3d71
X-MS-Exchange-CrossTenant-Network-Message-Id: 664c3d6d-b79c-4457-37c4-08d5c0ba3d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 14:34:06.8932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0708
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4NEYI5f001502

On Wed, 2018-05-23 at 15:01 +0100, Will Deacon wrote:
> Hi Chintan,
> 
> [as a side note: I'm confused on the status of this patch series, as part
>  of it was reposted separately by Toshi. Please can you work together?]

I do not know the status of my patch series, either... That being said,
I made my x86 patches based off from Chintan's 1/4 patch (which changes
both x86 and arm) so that my series won't conflict with his.

Chintan,
If you need to update your series before mine's accepted, please make
sure to use the updated 1/4 below. I've updated the descriptions per
review comment.
https://patchwork.kernel.org/patch/10407065/

Thanks,
-Toshi 
