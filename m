Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeEPSGX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:06:23 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61951 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeEPSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:06:20 -0400
X-IronPort-AV: E=Sophos;i="5.49,406,1520870400";
   d="scan'208";a="78045143"
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
Thread-Index: AQHT7J9I+R4Obm0ph0ykTEpfLVCTKqQyT+IAgAA5sgCAAAHrAIAABoOAgAAMVACAAAmQAA==
Date: Wed, 16 May 2018 18:06:16 +0000
Message-ID: <4797ba1736ce53e799a799846704a53af05d2035.camel@wdc.com>
References: <20180515225124.20428-1-bart.vanassche@wdc.com>
         <20180515225124.20428-6-bart.vanassche@wdc.com>
         <20180516125110.GA32078@lst.de>
         <8058d72fef475caffa78c962bc4220f5f8fa3dde.camel@wdc.com>
         <20180516162432.GA4398@lst.de>
         <bd17181940994eb459e84e4d5940b1af8a725ded.camel@wdc.com>
         <20180516173158.GA6022@lst.de>
In-Reply-To: <20180516173158.GA6022@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0847;7:h8uO5BlXoXiMdm8vsdImPy3346FDno/qgomUwW0CN7pvYCHQ8j1md6s2ve5bp9ASROj61Gotd8kX+kxdoNHOKZvSja5NW/Oq97GkjRbmz28HV41F2TpIWjOZUPr+FHMIYN+g4/TctRFcribjB6LYJVOsXWD9BeLRxp80aYiaOZQSTZSfgY7DF9ToLVizFV3kxdDCieSmH/jAYnV6Po140SfUdeQnmtVrkTzLZDxXZpomP2utubwem2Xs7AvhahFx;20:oyLOpuGlZzQcQc6xsa3s744jRCb1ChFh7cxZfSynRwPQsqw+m7fVWTqEGAiHzmGo/IcY+JDYuuq/S5nwQI1YkOIm53A/rx0dS1sgECN3YvW4AYB7gYgtAWT+Sg7mgO1e2pxOFeGeUILdo+S+USizAyepfpAV4fd6UssQM4ojULc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0847;
x-ms-traffictypediagnostic: MWHPR04MB0847:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0847EC4BE57B7E4EF5CECC9298920@MWHPR04MB0847.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0847;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0847;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(377424004)(189003)(199004)(7416002)(4326008)(54906003)(3280700002)(86362001)(5660300001)(186003)(106356001)(14454004)(1730700003)(81156014)(81166006)(2906002)(8936002)(105586002)(99286004)(25786009)(3846002)(118296001)(102836004)(6116002)(6506007)(26005)(59450400001)(76176011)(8676002)(2900100001)(305945005)(7736002)(478600001)(66066001)(229853002)(6916009)(97736004)(5640700003)(476003)(36756003)(2616005)(11346002)(446003)(486006)(6436002)(6486002)(5250100002)(6246003)(72206003)(2501003)(93886005)(53936002)(316002)(2351001)(3660700001)(6512007)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0847;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: SmaVmdPgQCxRSgGaoLFacoHovOyxZZBkViaN83aiMV30s1UGPHYXzpEpxg4Wxf0HPfXrdwGbroWzuPz15i9pD7m4zBd3985R0Ml39I1eskWeER3PePl3ECdzTOwnpcxNwrD/AqmYNIIPM4l7KbkLeEyrIlhzoZdZTlhWU0NDP54Lj5t134Rsufml3xUEZ2HN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <150D67DCF58ED04DA76F206AF9EAF570@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c7c26aca-4223-401e-958e-08d5bb57b7d3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c26aca-4223-401e-958e-08d5bb57b7d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 18:06:16.1251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0847
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4GI6Uo2025938

On Wed, 2018-05-16 at 19:31 +0200, hch@lst.de wrote:
> On Wed, May 16, 2018 at 04:47:54PM +0000, Bart Van Assche wrote:
> > I think your patch changes the order of changing the request state and
> > calling mod_timer(). In my patch the request state and the deadline are
> > updated first and mod_timer() is called afterwards. I think your patch
> > changes the order of these operations into the following:
> > (1) __blk_mq_start_request() sets the request deadline.
> > (2) __blk_mq_start_request() calls __blk_add_timer() which in turn calls
> >     mod_timer().
> > (3) __blk_mq_start_request() changes the request state into MQ_RQ_IN_FLIGHT.
> > 
> > In the unlikely event of a significant delay between (2) and (3) it can
> > happen that the timer fires and examines and ignores the request because
> > its state differs from MQ_RQ_IN_FLIGHT. If the request for which this
> > happened times out its timeout will only be handled the next time
> > blk_mq_timeout_work() is called. Is this the behavior you intended?
> 
> We can move the timer manipulation after the change easily I think.
> It would make sense to add comments explaining the ordering.

Hello Christoph,

I'm afraid that could lead to mod_timer() being called in another order than
intended. If e.g. the code that handles BLK_EH_RESET_TIMER changes the request
state first to in-flight and next calls mod_timer() then it can happen that
another context completes and restarts the request, resulting in a concurrent
mod_timer() call. I'm not sure reordering of the mod_timer() calls would result
in correct behavior.

Bart.
