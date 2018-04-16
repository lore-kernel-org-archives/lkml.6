Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbeDPVbC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:31:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20837 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPVa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:30:59 -0400
X-IronPort-AV: E=Sophos;i="5.48,460,1517846400";
   d="scan'208";a="76121338"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "rostedt@goodmis.org" <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "rajatja@google.com" <rajatja@google.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVj5Jy/9Ew2ExTSbalJ+RQV0SXDQANMyuAAAE+SYAAADZkAA==
Date: Mon, 16 Apr 2018 21:30:54 +0000
Message-ID: <4cdc179e652f8e2b2d7a069029101224779522a5.camel@wdc.com>
References: <4650cbf668fd4853ad98dba834141e08@SIWEX5A.sing.micron.com>
         <bee7c8b15b7cec3d4b1442f414e766539fac2491.camel@wdc.com>
         <20180416172447.5166f854@gandalf.local.home>
In-Reply-To: <20180416172447.5166f854@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0814;7:G1qQp5VDRPde64c2YeZHx1Vsyp+arA6KYZPql7aVqXPVRy+wFs+9iFqzCMQnB8sBTENLaXXU5sydPr1UPzMu4tB8TG1MVorqciRRvuNiXhGomhMdGCHUOzghQuvYsgzy2fStBmsb17wE44yiKKTFlqYJjWvf0GjnoqLbMBEWGPbAU8heUikD/Uxu/7pu5qIrLe927nOGMOD1B+9VbwYO3MxPMoLDKuxVog4ZfBz+xYWYg3LZGOpu9iVXU1f42vYX;20:JkRwGb7H9rSci8AtfARtoV1WuiqGKBjLjjVLJXnXZWZsez/gF6e6ps2ME+vZJT28TW1spcQK5rGedus/H6dExQCxXs4ACeoRQWRh9G3Uf7SqoKp1hWqIeHJNzwoNZ/f+7qhXnJlJijoRUq4wWIQfEnMnzYPdfq8sE9PNGvKK+rw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0814;
x-ms-traffictypediagnostic: MWHPR04MB0814:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0814472095A6966503E8D40398B00@MWHPR04MB0814.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR04MB0814;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0814;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39380400002)(39860400002)(366004)(189003)(199004)(377424004)(81156014)(5640700003)(118296001)(3846002)(81166006)(3660700001)(478600001)(6116002)(72206003)(26005)(97736004)(5250100002)(2900100001)(106356001)(76176011)(2351001)(99286004)(6916009)(53936002)(102836004)(6512007)(6506007)(6246003)(5660300001)(11346002)(6436002)(2616005)(6486002)(3280700002)(305945005)(36756003)(66066001)(7416002)(105586002)(2906002)(446003)(186003)(7736002)(14454004)(54906003)(476003)(1730700003)(86362001)(68736007)(316002)(25786009)(229853002)(8936002)(8676002)(4326008)(486006)(2501003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0814;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: hCnRk4BWjtMufopC7d+UFTMMZwHW9/5u2r3z408JwOdMIgSL8GdWrjd1/Jq+EHLAqiUqRBprhH2cKtCSdWNsSw+L8F7rQD5cvOQzBn2YquFEPA/dSu9Y+AC+GEsk3OFb8mOlMo/KH7g342a43qBRqejkCUK60aySXgU7x0D0MlFaKGavPmKXsBZKkX2LeGwB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <06FF26D96319134E8DD776FCE84939FB@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a31a955f-b0ba-4aac-d856-08d5a3e1561e
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31a955f-b0ba-4aac-d856-08d5a3e1561e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 21:30:54.9530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0814
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GLV6bI014442

On Mon, 2018-04-16 at 17:24 -0400, Steven Rostedt wrote:
> On Mon, 16 Apr 2018 20:49:12 +0000
> Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> 
> > Which tools process these strings? Has it been verified whether or not
> > the tools that process these strings still work fine with this patch
> > applied?
> 
> Ideally, tools shouldn't process trace event strings, but I'm sure some
> do. :-/
> 
> Getting libtraceevent out as a library is a high priority of mine, and
> hopefully I should get something out in a couple of months.
> 
> Ideally, tools should parse the raw data and then new fields will not
> affect them.

Hello Steve,

The tool I'm most concerned about is blktrace. I'm not sure though how this
tool receives event data from the block layer core.

Thanks,

Bart.
