Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCVT6v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 15:58:51 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:1939 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbeCVT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 15:58:45 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] nfit: skip region registration for incomplete control
 regions
Thread-Topic: [PATCH] nfit: skip region registration for incomplete control
 regions
Thread-Index: AQHTwZl7MKwVYtvBDkWfW6QrPo6m5KPcrRkA
Date: Thu, 22 Mar 2018 19:58:42 +0000
Message-ID: <1521748710.2693.233.camel@hpe.com>
References: <152169374458.19742.14326187212131249042.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152169374458.19742.14326187212131249042.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DF4PR8401MB1322;7:xK1lwBvjsgz+Hvn46NfqLPjBuGpcDuT9Ig2vSFGZf9hd8OhzwOu1qO2I8C11TCZs6Z26lpxs8g/+LVsVLS1t7shMbmdttD+nHCZJ/qdJ0WetxF8otWkv3yludsGCKdLuTs6ri0FvZMCNuWt0Dt9lPnfRlYYIxOXkb0steCEbSOc51Vp+wGmOHIkFU2suu4LJzUYe/27rByE43bC+QcoRQWVZ8rPPVLhx4ela+XVMLbx1NsClZ0lO50GDvk3v19Mq
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3d62e14-72fb-494c-57dd-08d5902f5068
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB1322;
x-ms-traffictypediagnostic: DF4PR8401MB1322:
x-microsoft-antispam-prvs: <DF4PR8401MB132285A0EBFDF4A17F4E797A82A90@DF4PR8401MB1322.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DF4PR8401MB1322;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB1322;
x-forefront-prvs: 0619D53754
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(396003)(346002)(366004)(39860400002)(377424004)(189003)(199004)(103116003)(54906003)(105586002)(99286004)(86362001)(66066001)(8936002)(2900100001)(229853002)(6246003)(76176011)(106356001)(2906002)(6116002)(446003)(3846002)(11346002)(36756003)(3280700002)(3660700001)(6436002)(68736007)(6486002)(478600001)(25786009)(53936002)(316002)(6512007)(8676002)(81156014)(4326008)(14454004)(26005)(2501003)(5250100002)(110136005)(7736002)(186003)(59450400001)(5660300001)(305945005)(6506007)(81166006)(97736004)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB1322;H:DF4PR8401MB0396.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: dlnSXREIb785wOQYbSJdZZBRZs6qR+5TVR8WSfVT1/Svsk4iyJmOYDrKSxWceL01w0doW+HIm2hQLxPrZuGbyQ4ZuovNyWGxnQOW1ABFy2GeuQ24aUo5Pz6/k9dk7egV0AiYwUWvns/LXYsj/hbgPNG+CDWJC1fnsP/z3YaxeFg4tbto0dg79IxB6rkxjuCbXi2MsmOs4Jw/1I3MxRANhGS25QgUp9xCGfq6FqyavroF4KhEmxm02YIGwoRjEnRe7ttLgandBv1284yGfPoyzKgQCbK/wwRkivo14ewWFHDq3EFq7AWi188X8/awTHtp8w1j+8tzoq8Vc/D+CaVa+w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD9FBE9C81AA15478E37727130F579CC@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d62e14-72fb-494c-57dd-08d5902f5068
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2018 19:58:42.9202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1322
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2MJwtAe017029

On Wed, 2018-03-21 at 21:42 -0700, Dan Williams wrote:
> Per the ACPI specification the only functional purpose for a DIMM
> Control Region to be mapped into the system physical address space, from
> an OSPM perspective, is to support block-apertures. However, there are
> some BIOSen that publish DIMM Control Region SPA entries for pre-boot
> environment consumption.  Undo the kernel policy of generating disabled
> 'ndblk' regions when this configuration is detected.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

The change looks good.

Reviewed-by: Toshi Kani <toshi.kani@hpe.com>

Thanks!
-Toshi
