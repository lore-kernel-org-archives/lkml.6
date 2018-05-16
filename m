Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbeEPQsA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:48:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:57708 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeEPQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:47:58 -0400
X-IronPort-AV: E=Sophos;i="5.49,406,1520870400";
   d="scan'208";a="174872170"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "israelr@mellanox.com" <israelr@mellanox.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Thread-Topic: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Thread-Index: AQHT7J9I+R4Obm0ph0ykTEpfLVCTKqQyT+IAgAA5sgCAAAHrAIAABoOA
Date: Wed, 16 May 2018 16:47:54 +0000
Message-ID: <bd17181940994eb459e84e4d5940b1af8a725ded.camel@wdc.com>
References: <20180515225124.20428-1-bart.vanassche@wdc.com>
         <20180515225124.20428-6-bart.vanassche@wdc.com>
         <20180516125110.GA32078@lst.de>
         <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com>
         <20180516162432.GA4398@lst.de>
In-Reply-To: <20180516162432.GA4398@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0783;7:6RnFTm+D5jOv1zzZJ5GedKhcsgv1/RYhii43BP47/OBliUbhy1YBXO8M5C8d9xZf4R8EI01Cecxj/UPSa7WE5i9BcGEhZErScbPyPy5EgDsh7lJBghYhdA3RJGMG6N0n+BgkG/b/bdlciS6RKztxnSAGOc7Rm4yx6HaKj+rh0NJFedaThNxGeWRkfgBXgQcRVG1GClJFTA1eqPZZ6OGNK14ugu+kpqC4+MCHPo8Ttg3DEdC+FuwmLotEaXL8OLsx;20:8zkwKI8+OaUftlpvf8jnmXjKhM4KHliuG0efT2CExpm0srFb+vs6LUuc7t9argeWVlX1wG93bxfDOAzoqldyuwOhp/7KcJRXieLqCPgDNdaA0XKh+AOXF27qHzjkTMKH7kFWf+I72+SdBmJxfl+TXzIA4FIynNgw/Wy5cC/jqLs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0783;
x-ms-traffictypediagnostic: MWHPR04MB0783:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0783AEBFCEE0C9D75FA13AA898920@MWHPR04MB0783.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0783;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0783;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(39860400002)(366004)(377424004)(53474002)(189003)(199004)(99286004)(305945005)(316002)(3846002)(6116002)(2900100001)(102836004)(4326008)(6486002)(26005)(76176011)(59450400001)(186003)(6506007)(3280700002)(6436002)(2351001)(93886005)(54906003)(106356001)(5250100002)(2501003)(229853002)(3660700001)(97736004)(105586002)(118296001)(6916009)(36756003)(81166006)(8676002)(1730700003)(7736002)(81156014)(25786009)(486006)(476003)(2616005)(11346002)(446003)(72206003)(478600001)(53936002)(5660300001)(7416002)(86362001)(66066001)(6512007)(2906002)(8936002)(68736007)(14454004)(6246003)(5640700003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0783;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vZOcEIrtpgyunPmcSK8/EZ8rDapW6fx0geLLTVVwgUG0C1vJUYN52zXgS2XT/7qxe29l1HsurcI7kzKoj/K/2fBjeEtV5VywUiGJBGijo8x1HxhazhwaVNu19CvA5Cyhmz9Hgw0CGS/gQPBTE2MZ5jJpeuRtk+Q5QD0BMuZbEzK1yd6UB+/HtLoD9UvdYwbt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9B37603FC5D5B4DB36C6A3060818F32@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 61c386ce-0ea7-4788-4ffa-08d5bb4cc57f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c386ce-0ea7-4788-4ffa-08d5bb4cc57f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 16:47:54.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0783
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GGm7Rd020632

On Wed, 2018-05-16 at 18:24 +0200, hch@lst.de wrote:
> On Wed, May 16, 2018 at 04:17:42PM +0000, Bart Van Assche wrote:
> > There is another reason the deadline is included in the atomic operation,
> > namely to handle races between the BLK_EH_RESET_TIMER case in blk_mq_rq_timed_out()
> > and blk_mq_complete_request(). I don't think that race is addressed properly by
> > your patch. I will see what I can do to address that race without using 64-bit
> > atomic operations.
> 
> I might be missing something here, so please help me understand
> what is missing.
> 
> If we restart the timer in blk_mq_rq_timed_out we also bump the
> generation at the same time as we reset the deadline in your old
> patch.  With this patch we only bump the generation, but that should
> be enough to address the rest, or not?

Hello Christoph,

I think your patch changes the order of changing the request state and
calling mod_timer(). In my patch the request state and the deadline are
updated first and mod_timer() is called afterwards. I think your patch
changes the order of these operations into the following:
(1) __blk_mq_start_request() sets the request deadline.
(2) __blk_mq_start_request() calls __blk_add_timer() which in turn calls
    mod_timer().
(3) __blk_mq_start_request() changes the request state into MQ_RQ_IN_FLIGHT.

In the unlikely event of a significant delay between (2) and (3) it can
happen that the timer fires and examines and ignores the request because
its state differs from MQ_RQ_IN_FLIGHT. If the request for which this
happened times out its timeout will only be handled the next time
blk_mq_timeout_work() is called. Is this the behavior you intended?

Thanks,

Bart.
