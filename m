Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeBFP43 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:56:29 -0500
Received: from mail-eopbgr660125.outbound.protection.outlook.com ([40.107.66.125]:57376
        "EHLO CAN01-QB1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752286AbeBFP4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:56:23 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Keith Busch <keith.busch@intel.com>
CC: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate
 q_depth
Thread-Topic: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate
 q_depth
Thread-Index: AQHTntE5A1jmE7IvrEqtRXiOa02FVaOXelIAgAAOHDI=
Date: Tue, 6 Feb 2018 15:56:21 +0000
Message-ID: <6ECB1B8A-A08D-466D-BD04-297ED26738E8@raithlin.com>
References: <1517869943-3655-1-git-send-email-sbates@raithlin.com>,<20180206150552.GD31110@localhost.localdomain>
In-Reply-To: <20180206150552.GD31110@localhost.localdomain>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [207.228.78.184]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB1869;7:fvPQud5XmPEJlWqNVGOvhU0wyAvtnyYrryDbzeUZ5XgT6JCMTMoPLDdJG7CxMpiAsjmNInS73bIqJgQsqZbTSQ6ezQ4LMIMHipXmIUZOJeR23FLuM9rG/ZzlDvh/RTja26Er/UPg+V3eAOpvnad6iY36pCnDgy3KFCULXaI8dT7fQs9jx4uVutCZsYBtaBMgsR4YJ8oy6QsStpBta10h18LVasVQKREpSpsq1I45yQR1b5c3Qk/hlaI2btVU1+Vl
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 6a176c98-0374-4eb9-9c47-08d56d7a2ac8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB1869;
x-ms-traffictypediagnostic: YTXPR0101MB1869:
x-microsoft-antispam-prvs: <YTXPR0101MB1869B5812188C5A1038394BDAAFD0@YTXPR0101MB1869.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6041288)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:YTXPR0101MB1869;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB1869;
x-forefront-prvs: 0575F81B58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(376002)(39380400002)(346002)(396003)(51914003)(189003)(199004)(2906002)(2900100001)(99286004)(4326008)(86362001)(3846002)(6116002)(68736007)(229853002)(106356001)(6246003)(97736004)(54906003)(25786009)(83716003)(6916009)(2950100002)(186003)(26005)(478600001)(102836004)(53546011)(6506007)(14454004)(76176011)(5250100002)(3660700001)(8936002)(316002)(53936002)(82746002)(33656002)(305945005)(6486002)(5660300001)(7736002)(36756003)(3280700002)(66066001)(6512007)(105586002)(8676002)(81156014)(81166006)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB1869;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: i1mvVZCDO2Q/s3i0z9X1fDioiJlfidMrb3ggs2qFm6iYne9+4rms5lto6R7IcQYGx0Ns8VbTVVwB84OrXXR6+g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a176c98-0374-4eb9-9c47-08d56d7a2ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 15:56:21.3396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB1869
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w16FuY3Y001194


> On Feb 6, 2018, at 8:02 AM, Keith Busch <keith.busch@intel.com> wrote:
> 
>> On Mon, Feb 05, 2018 at 03:32:23PM -0700, sbates@raithlin.com wrote:
>> 
>> -    if (dev->cmb && (dev->cmbsz & NVME_CMBSZ_SQS)) {
>> +    if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
> 
> Is this a prep patch for something coming later? dev->cmb is already
> NULL if use_cmb_sqes is false.

Thanks Keith. 

Not sure how I missed this. I was working on OOT patches to enable WDS and RDS in the CMB. I *thought* I’d confirmed this patch was applicable to upstream. Looks like I did not do that correctly. 

Sorry for the churn. We can leave this patch out for now. Thanks for the prompt feedback everyone!

Stephen 
