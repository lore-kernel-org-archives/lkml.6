Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCNUHo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:07:44 -0400
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:39792 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeCNUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:07:43 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gratian.crisan@ni.com" <gratian.crisan@ni.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH 2/2] x86/mm: remove pointless checks in vmalloc_fault
Thread-Topic: [PATCH 2/2] x86/mm: remove pointless checks in vmalloc_fault
Thread-Index: AQHTuu1O8NBR8jCjgUCIh54olLs4nKPQHwoAgAADPoCAAAUBgIAAAwoA
Date: Wed, 14 Mar 2018 20:07:37 +0000
Message-ID: <1521058054.2693.139.camel@hpe.com>
References: <20180313170347.3829-1-toshi.kani@hpe.com>
         <20180313170347.3829-3-toshi.kani@hpe.com>
         <alpine.DEB.2.21.1803142024540.1946@nanos.tec.linutronix.de>
         <1521056327.2693.138.camel@hpe.com>
         <alpine.DEB.2.21.1803142054390.1946@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1803142054390.1946@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB0842;7:LwUC/NsvUoJIYVE6p2hDmRLAjm0C+fLigYSkSLISOinyk93991Jjy7RQP6aZeTBsnylISSNu/DZmUn/gpXf+8YN42bV+XegU/d7iriRmwwm1ixl8YN5OmL+PIu3EF3Qr/at7LRTY3SGpqclqIt4w5ywU23OU5ClApev4JJTnGAbDG/5u382z5tK6Q46NxKNLrbr1TwhfMbLtKgCqeQtqTVTfd/9w5Vhj0GKaaFGEeK6vUnrEbOuvV33sU+LT5X0i
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a782f9a-ad4f-4feb-ad94-08d589e73ba5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB0842;
x-ms-traffictypediagnostic: DF4PR8401MB0842:
x-microsoft-antispam-prvs: <DF4PR8401MB084234B2ED1A76CC1159D99882D10@DF4PR8401MB0842.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DF4PR8401MB0842;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB0842;
x-forefront-prvs: 0611A21987
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(366004)(39380400002)(189003)(199004)(377424004)(316002)(53936002)(6506007)(102836004)(6436002)(8936002)(93886005)(2900100001)(97736004)(3660700001)(7736002)(5250100002)(99286004)(81166006)(2501003)(5640700003)(6486002)(54906003)(105586002)(3846002)(81156014)(305945005)(6116002)(5660300001)(229853002)(25786009)(103116003)(4326008)(36756003)(106356001)(14454004)(68736007)(76176011)(8676002)(66066001)(478600001)(6512007)(186003)(6916009)(2950100002)(3280700002)(86362001)(6246003)(26005)(2906002)(1730700003)(2351001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0842;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +2XoPFPljigkaocsQdIGmpSFOBINkAqxhh8kNsWSEluGRDolie2+v/QP2ESGlZNIxOllH96bOiKs9f9TJ6lwh3j6LfguqKl9xiuTFt6SUSOJ/Vq5sfHXfv3d8QaoskV9kivhlgIVWYFa+2YENsuBqpoxPeyVo+6UaL+knm0d2Jw/kcL5pSy+W0r2LO2q1ZirGC4CADxXj4a8b5YxsW2m5/wlik4XbA15OgbnqvT1UNwokbQ+s8hBRMi3oGcoJws7PM36pvfIp+n6bijlEZdUwf1tMwhnT+j8l46qki85SZl16XaIOuReJv3xeEsvOwXjak8IKCKiXHGTEaNBN7l5JA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C58D6D299981DF4EB9E396EABC60EA72@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a782f9a-ad4f-4feb-ad94-08d589e73ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2018 20:07:37.3332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0842
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EK7o6D027435

On Wed, 2018-03-14 at 20:56 +0100, Thomas Gleixner wrote:
> On Wed, 14 Mar 2018, Kani, Toshi wrote:
> > On Wed, 2018-03-14 at 20:27 +0100, Thomas Gleixner wrote:
> > > On Tue, 13 Mar 2018, Toshi Kani wrote:
> > > 
> > > > vmalloc_fault() sets user's pgd or p4d from the kernel page table.
> > > > Once it's set, all tables underneath are identical. There is no point
> > > > of following the same page table with two separate pointers and makes
> > > > sure they see the same with BUG().
> > > > 
> > > > Remove the pointless checks in vmalloc_fault(). Also rename the kernel
> > > > pgd/p4d pointers to pgd_k/p4d_k so that their names are consistent in
> > > > the file.
> > > 
> > > I have no idea to which branch this might apply. The first patch applies
> > > cleanly on linus head, but this one fails in hunk #2 on everything I
> > > tried. Can you please check?
> > 
> > Sorry for the trouble. The patches are based on linus head. I just tried
> > and they applied clean to me... 
> 
> Hmm. Looks like I tried on the wrong branch. Nevertheless, 1/2 is queued in
> urgent, but 2/2 will go through tip/x86/mm which already has changes in
> that area causing the patch to fail. I just merged x86/urgent into x86/mm
> and pushed it out. Can you please rebase 2/2 on top of that bracnh and
> resend ?

Yes, I will merge up 2/2 and resend.

Thanks,
-Toshi
