Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeEPQRt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 12:17:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15015 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751033AbeEPQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 12:17:47 -0400
X-IronPort-AV: E=Sophos;i="5.49,390,1520870400";
   d="scan'208";a="79604218"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "israelr@mellanox.com" <israelr@mellanox.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "tj@kernel.org" <tj@kernel.org>
Subject: Re: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Thread-Topic: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Thread-Index: AQHT7J9I+R4Obm0ph0ykTEpfLVCTKqQyT+IAgAA5sgA=
Date: Wed, 16 May 2018 16:17:42 +0000
Message-ID: <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com>
References: <20180515225124.20428-1-bart.vanassche@wdc.com>
         <20180515225124.20428-6-bart.vanassche@wdc.com>
         <20180516125110.GA32078@lst.de>
In-Reply-To: <20180516125110.GA32078@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0702;7:L5/AJTK8jcEbkjeQ41H8Y1JQWNMOX1qiebfe6HsYxSNHPZnNXJpDPw9RZg7P6JPEeI36MImCHyRFQ9eULA+sT4Gyqhef4BXcIYT+edDxTmIwbw4kQxPJw0sa7mPGwQZPdwUluIYlgG1//y98dH4NDXsrrFUSdKsViXweYlF40rRFDlFSB7zEyymFH6rhYfyJ0YBPtSIUki0Gatp6vLZoTcJeQpbEWQo/57ZsGOpPj7q9xSq7tENRYvnO00+/qQ7U;20:9O85mkb8vs8j5M91G3/cjGjYjoXQ5qSDoKt0PPHiqVQ/bFaNh/Ks4Tnf3FksI/5urooacsE5x0uwPWw3iaL8SCPsA7ggjRKqSDr1RZJNR7UR/i+ltOrgq3mk6JFPYITQZOIe1BQu2TL3qK8NewciZjRbnJjazVOL5Tg7WwfXlpE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0702;
x-ms-traffictypediagnostic: MWHPR04MB0702:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0702FEB4F8940391E010E4B898920@MWHPR04MB0702.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0702;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0702;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(377424004)(189003)(199004)(118296001)(54906003)(229853002)(6436002)(6916009)(7416002)(86362001)(5250100002)(5640700003)(66066001)(316002)(14454004)(68736007)(486006)(6512007)(53936002)(102836004)(3846002)(2900100001)(478600001)(59450400001)(76176011)(6486002)(6506007)(8936002)(6116002)(2501003)(72206003)(105586002)(2351001)(186003)(4326008)(3660700001)(26005)(2906002)(6246003)(3280700002)(36756003)(81156014)(305945005)(81166006)(8676002)(1730700003)(2616005)(476003)(7736002)(5660300001)(25786009)(99286004)(11346002)(97736004)(446003)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0702;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 9IAB3h9b55nR5I0xxH832PRmRkHiSPfeSDStJELpY990gxwb+dv00oaqto0HpJtW32wKxhHrOFOZG+L+dcCzcZviUClsw6jzkZKu9iXUECc5Duqp1Wo597bPYUbP2MEEY4APP2Tfefwwl/Ww0zc4d1KbZue4yHlluNqLHIDGfMs6B4mwqPW73NXAJBc3MB6a
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C20FB846B8EB74EA76D896DB738D1E5@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6411ee8e-5561-49d4-fcb8-08d5bb488d58
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6411ee8e-5561-49d4-fcb8-08d5bb488d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 16:17:42.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GGHuFC017008

On Wed, 2018-05-16 at 14:51 +0200, Christoph Hellwig wrote:
> I've been looking at this carefully, and I don't think we need cmpxchg64
> at all, and we don't need anywhere near as many cmpxchg operations either.
> 
> The only reason to include the deadline in the atomic operation is the
> blk_abort_request case, as the blk_mq_add_timer never modifies the
> deadline of a request that someone could be racing with.  So if we
> introduce a new aborted state for use by blk_abort_request we can modify
> the deadline separately (and in fact have a common field with the legacy
> path).

There is another reason the deadline is included in the atomic operation,
namely to handle races between the BLK_EH_RESET_TIMER case in blk_mq_rq_timed_out()
and blk_mq_complete_request(). I don't think that race is addressed properly by
your patch. I will see what I can do to address that race without using 64-bit
atomic operations.

Bart.
