Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752570AbeBBUi7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:38:59 -0500
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:6123 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBBUip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:38:45 -0500
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi, nfit: fix register dimm error handling
Thread-Topic: [PATCH] acpi, nfit: fix register dimm error handling
Thread-Index: AQHTnGKPRzadXDuBXkueZRtqEFZ796ORkL0AgAAO1YA=
Date: Fri, 2 Feb 2018 20:38:41 +0000
Message-ID: <1517606653.16384.106.camel@hpe.com>
References: <20180202210036.3153-1-toshi.kani@hpe.com>
         <CAPcyv4jPNxSKxb-kzaw8njhDHGUs7DOPASS_GBXbPGOFP4RN=g@mail.gmail.com>
In-Reply-To: <CAPcyv4jPNxSKxb-kzaw8njhDHGUs7DOPASS_GBXbPGOFP4RN=g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1026;7:SfhhE3tLBUkjYrCqT0j0ZeaKQXatYhCH0+xWmYWyJDAmb0K15aktyNGoFCxgjxopSMvwgQpUkTepzuD2DFhblnVX3u/j9cfqxYqRlqJCfvqPSXIgZUh1st58OSW9FtbNcOibnSrbYf+WY0Oe2K7u4H8pZdoD+lttLezhPouXAS4oE8ZkaoJaoTLGyF+SAeKFIubd8XIAk+ivvAx4LJZ64jQjtOvlP1wAcrMLB0WWBCGQBOxeKcTOoxUGBymbl0ab
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2a8af41-13f2-4b8b-67cd-08d56a7cf217
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:AT5PR8401MB1026;
x-ms-traffictypediagnostic: AT5PR8401MB1026:
x-microsoft-antispam-prvs: <AT5PR8401MB10263F8822B7CB4A2B5C23DC82F90@AT5PR8401MB1026.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(9452136761055)(222181515654134)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AT5PR8401MB1026;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1026;
x-forefront-prvs: 05715BE7FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(396003)(39380400002)(377424004)(199004)(189003)(14454004)(59450400001)(97736004)(76176011)(105586002)(5640700003)(5660300001)(6486002)(66066001)(6436002)(3846002)(102836004)(7736002)(2351001)(305945005)(6116002)(26005)(103116003)(6506007)(53546011)(2906002)(229853002)(81166006)(68736007)(5250100002)(99286004)(6246003)(81156014)(316002)(4326008)(2900100001)(2501003)(2950100002)(6916009)(478600001)(54906003)(3280700002)(106356001)(8676002)(3660700001)(86362001)(8936002)(186003)(36756003)(6512007)(25786009)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1026;H:AT5PR8401MB1297.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: eye0bQwS+mawx6gGxqdw6jUepSdmYaiVnDBeAn5TN6vBID6CtWSHEcWIWeC+SXTvN+HQKb8hUgQyuHoeh5d0ig==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BFE654EBAED554581D358397ED5DB90@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a8af41-13f2-4b8b-67cd-08d56a7cf217
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2018 20:38:41.1808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1026
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w12Kd4CX021712

On Fri, 2018-02-02 at 12:31 -0800, Dan Williams wrote:
> On Fri, Feb 2, 2018 at 1:00 PM, Toshi Kani <toshi.kani@hpe.com> wrote:
> > A NULL pointer reference kernel bug was observed when
> > acpi_nfit_add_dimm() called in acpi_nfit_register_dimms()
> > failed. This error path does not set nfit_mem->nvdimm, but
> > the 2nd list_for_each_entry() loop in the function assumes
> > it's always set. Add a check to nfit_mem->nvdimm.
> > 
> > Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > ---
> >  drivers/acpi/nfit/core.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index abeb4df4f22e..b28ce440a06f 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -1867,6 +1867,9 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
> >                 struct kernfs_node *nfit_kernfs;
> > 
> >                 nvdimm = nfit_mem->nvdimm;
> > +               if (!nvdimm)
> > +                       continue;
> > +
> >                 nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
> >                 if (nfit_kernfs)
> >                         nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,
> 
> Yes, I assume this also needs:
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ba9c8dd3c222 ("acpi, nfit: add dimm device notification support")

Right. Thanks!
-Toshi
