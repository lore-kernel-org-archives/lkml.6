Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeCBFMl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 00:12:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12440 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeCBFMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 00:12:39 -0500
X-IronPort-AV: E=Sophos;i="5.47,409,1515427200";
   d="scan'208";a="73272828"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "opensource.ganesh@gmail.com" <opensource.ganesh@gmail.com>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi_lib: increase {host|target|device}_busy count after
 dispatch cmd
Thread-Topic: [PATCH] scsi_lib: increase {host|target|device}_busy count after
 dispatch cmd
Thread-Index: AQHS3d92zLNWsDeNvE6P9uZ5cIsMfqO9qWKAgABgggCAAASDgA==
Date: Fri, 2 Mar 2018 05:12:36 +0000
Message-ID: <1519967555.25932.3.camel@wdc.com>
References: <1496655478-4039-1-git-send-email-opensource.ganesh@gmail.com>
         <1519945861.2675.9.camel@sandisk.com>
         <CADAEsF8OySXKpqBmN-Vi+8md=RpHAyUghO99UnrwJRdD72yWCQ@mail.gmail.com>
In-Reply-To: <CADAEsF8OySXKpqBmN-Vi+8md=RpHAyUghO99UnrwJRdD72yWCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0943;7:5n2Z6qgd4d0sezwrmcV6FcrYRnXC6l60oO/qNPYaziTr124WDzqAwWeRlrQ5ccoBXl6M9yubAgkJwO5DoKQpkC7gXpCnhC1x78Auryan8lGOvO65p8EN9S+oDMk6pxfV6SvTkWCoaHFxSZf0qOULsexQJY1lWqe7+5ks+arJ5jl78dxm78eZhrty+VaslG01L6xR69SnYQgIiS/M2wfkrTV4hn0X7k8/lIFKAtQt1OHWK8/Q9O311rXmd9ugqx+2;20:YOlxz+1nzvFC3oE/O0tWYj9qcVaXmqjm+whqzuy25dQTGhlVkF/e9lmKUsw6aLJsU4U7IYwIUAvzFcd4qkFEHTNLV4+sc5M2fq65qP9QZXbPfD+HdXS7U7rR1KrAC7htbMTJi2QKPoJ2ftHG0hDE5/lK5yHYgb7zxYcQpIJBjEs=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49675c1a-5ad1-4e70-1de4-08d57ffc3691
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR04MB0943;
x-ms-traffictypediagnostic: MWHPR04MB0943:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB09432B77518EA23C76F3E4D298C50@MWHPR04MB0943.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501161)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0943;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0943;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(346002)(366004)(39380400002)(396003)(189003)(199004)(51444003)(377424004)(478600001)(5640700003)(316002)(54906003)(1361003)(5250100002)(2501003)(186003)(36756003)(6486002)(2900100001)(26005)(6436002)(2950100002)(6916009)(3846002)(68736007)(6116002)(6506007)(14454004)(86362001)(2351001)(53936002)(305945005)(7736002)(102836004)(97736004)(229853002)(72206003)(59450400001)(2906002)(8936002)(99286004)(6246003)(66066001)(76176011)(3280700002)(39060400002)(6512007)(4326008)(105586002)(103116003)(81166006)(5660300001)(81156014)(3660700001)(106356001)(25786009)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0943;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GjC3iLmkJzhcziMujVJeTsoynX6hBUlGUTO9ZCF9LMIngyE7L+E2cNwthw524osdxJWJ9mZ87wtrHG8I2MG2kqYxJNqxthOcyuFpjpSnX4iv+IZGIULXlNq3x+1mqBTGTjcMNX1h58iyDaM+txDraluuYXIc1F1atnYpLKgpKsM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <6930C493EC1BC64093922311B04894FA@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49675c1a-5ad1-4e70-1de4-08d57ffc3691
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 05:12:36.5665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0943
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w225CpTN030381

On Fri, 2018-03-02 at 12:56 +0800, Ganesh Mahendran wrote:
> 2018-03-02 7:11 GMT+08:00 Bart Van Assche <Bart.VanAssche@wdc.com>:
> > On Mon, 2017-06-05 at 17:37 +0800, Ganesh Mahendran wrote:
> > > In android system, when there are lots of threads running. Thread A
> > > holding *host_busy* count is easily to be preempted, and if at the
> > > same time, thread B set *host_blocked*, then all other threads will
> > > be io blocked.
> > 
> > Have you considered to insert preempt_disable() and preempt_enable() calls
> > where necessary to achieve the same effect? I think that would result in a
> > much less intrusive patch.
> 
> Yes, preempt_disable()preempt_enable will also achieve the same effect.
> But I just think preempt_disable()preempt_enable may be a little heavy for
> this problem which can be fixed by increaseing {host|target|device}_busy count
> after dispatch cmd.

Hello Ganesh,

If the {host,target,device}_busy counts would be increased after dispatch,
could that result in scsi_device_unbusy() being called from the completion
path before these counts have been increased?

Additionally, have you noticed that your patch does not apply anymore to
recent kernels since some of the counters are now increased from inside
scsi_mq_get_budget(), a function that is called from inside the block layer?

Thanks,

Bart.
