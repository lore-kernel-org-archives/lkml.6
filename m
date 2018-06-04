Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeFDXtX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 19:49:23 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:46589 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeFDXtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 19:49:21 -0400
From: "Kani, Toshi" <toshi.kani@hpe.com>
To: "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-xfs@vger.kernel.orgw" <linux-xfs@vger.kernel.orgw>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] dm: remove DM_TYPE_DAX_BIO_BASED dm_queue_mode
Thread-Topic: [PATCH v2 5/7] dm: remove DM_TYPE_DAX_BIO_BASED dm_queue_mode
Thread-Index: AQHT/Fst6jX8i9D7JkCHf1uiuEmRt6RQxCiA
Date: Mon, 4 Jun 2018 23:49:18 +0000
Message-ID: <1528156065.14039.113.camel@hpe.com>
References: <20180529195106.14268-1-ross.zwisler@linux.intel.com>
         <20180529195106.14268-6-ross.zwisler@linux.intel.com>
         <20180601220443.GB18712@redhat.com>
         <20180604232416.GB10666@linux.intel.com>
In-Reply-To: <20180604232416.GB10666@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com;
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0371;7:3VIjFHwiEiqyk3bfbM+/SLTNP9xP2mwAh7m8eYv+ym0Tjo8PXBI0DBLP5gmectYhiMVi/hKVWv60ix4Uv9mEKrKYjvmInXEM5q+JQh/zhx/f3Xg93l1soaxQlFBamkETvcZHJAkoMIRmxUeuyQqAso3D3tHbLeoUxaSTkkL9IHlAmtWDUGEgbO/2Tuvde/Rb/RmO2vQ7/8k2lN9OnYJ5wgGuLbai3Y4LunJmnFTCzG6uVGB4OQt+eFIpCCOwVWbb
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989080)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0371;
x-ms-traffictypediagnostic: AT5PR8401MB0371:
x-microsoft-antispam-prvs: <AT5PR8401MB037139028ED87C0D10685A0582670@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AT5PR8401MB0371;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0371;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39860400002)(376002)(199004)(189003)(52314003)(8936002)(53936002)(3280700002)(4326008)(66066001)(2906002)(11346002)(3660700001)(25786009)(2616005)(110136005)(476003)(966005)(93886005)(14454004)(316002)(54906003)(446003)(486006)(86362001)(478600001)(6486002)(5660300001)(6436002)(3846002)(103116003)(26005)(6506007)(229853002)(186003)(99286004)(68736007)(6116002)(76176011)(7736002)(305945005)(5250100002)(8676002)(97736004)(6246003)(2900100001)(6512007)(2501003)(6306002)(59450400001)(36756003)(105586002)(102836004)(81156014)(81166006)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0371;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: C34bij1gYWpg+DWvaTz87UX9xsHukDvzRAl1H7Pimcsdf7gzu7RYKqrjIoSWp0TG4P2sq3XhgVU5dlOHl96Gh5pnFGa4l3ANYJi3ccHVV2y+feDpyWmETt6cTDCgJdza6OLEg+wqwwMDL9fKHOmZgDPzMVR5KU0rWM9dEpXLdr/3eIBzNPea7SX4uZKSKnad
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D4ACA0B174EA340BD68FDA59FFD6084@NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9f6dccaa-f30b-4eff-b58c-08d5ca75c9b1
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6dccaa-f30b-4eff-b58c-08d5ca75c9b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 23:49:18.5393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0371
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w54NnSqu026225

On Mon, 2018-06-04 at 17:24 -0600, Ross Zwisler wrote:
> On Fri, Jun 01, 2018 at 06:04:43PM -0400, Mike Snitzer wrote:
> > On Tue, May 29 2018 at  3:51pm -0400,
> > Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
 :
> > For example, the following transition will currently fail:
> > 
> >  dm-linear: [fsdax pmem][fsdax pmem] => [fsdax pmem][fsdax raw]
> >               DM_TYPE_DAX_BIO_BASED       DM_TYPE_BIO_BASED
> > 
> > but these will both succeed:
> > 
> >  dm-linear: [fsdax pmem][brd ramdisk] => [fsdax pmem][fsdax raw]
> >                 DM_TYPE_BIO_BASED        DM_TYPE_BIO_BASED
> > 
> >  dm-linear: [fsdax pmem][fsdax raw] => [fsdax pmem][fsdax pmem]
> >                 DM_TYPE_BIO_BASED        DM_TYPE_DAX_BIO_BASED
> 
> So we allow 2 of the 3 transitions, but the reason that we disallow the third
> isn't fully clear to me.

I need to refresh my memory for the code, but here is the intent.
https://lkml.org/lkml/2016/6/22/1000
https://lkml.org/lkml/2016/6/22/999


> > >  dm-linear: [fsdax pmem][fsdax raw] => [fsdax pmem][fsdax pmem]
> > >  		DM_TYPE_BIO_BASED        DM_TYPE_DAX_BIO_BASED
> > > 
> > > This seems arbitrary, as really the choice on whether to use DAX happens at
> > > filesystem mount time.  There's no guarantee that the in the first case
> > > (double fsdax pmem) we were using the dax mount option with our file
> > > system.
> > > 
> > > Instead, get rid of DM_TYPE_DAX_BIO_BASED and all the special casing around
> > > it, and instead make the request queue's QUEUE_FLAG_DAX be our one source
> > > of truth.  If this is set, we can use DAX, and if not, not.  We keep this
> > > up to date in table_load() as the table changes.  As with regular block
> > > devices the filesystem will then know at mount time whether DAX is a
> > > supported mount option or not.
> > 
> > If you don't think you need this specialization that is fine.. but DM
> > devices supporting suspending (as part of table reloads) so is there any
> > risk that there will be inflight IO (say if someone did 'dmsetup suspend
> > --noflush').. and then upon reload the device type changed out from
> > under us.. anyway, I don't have all the PMEM DAX stuff paged back into
> > my head yet.
> > 
> > But this just seems like we really shouldn't be allowing the
> > transition from what was DM_TYPE_DAX_BIO_BASED back to DM_TYPE_BIO_BASED
> 
> I admit I don't fully understand all the ways that DM supports suspending and
> resuming devices.  Is there actually a case where we can change out the DM
> devices while I/O is running, and somehow end up trying to issue a DAX I/O to
> a device that doesn't support DAX?
> 
> Toshi, do you have a test case that shows this somehow?

No, I did not test suspend/resume since HPE servers do not support it.

Thanks,
-Toshi
