Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeDCRDb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:03:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48892 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbeDCRD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:03:28 -0400
X-IronPort-AV: E=Sophos;i="5.48,401,1517846400";
   d="scan'208";a="75168534"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "wakko@animx.eu.org" <wakko@animx.eu.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: 4.15.14 crash with iscsi target and dvd
Thread-Topic: 4.15.14 crash with iscsi target and dvd
Thread-Index: AQHTyTSBb5uvLpZh0kGvcKoLkXFdJKPq6GkAgABbqICAAIUdgIAAU3eAgAAfGYCAAw0ygA==
Date: Tue, 3 Apr 2018 17:03:24 +0000
Message-ID: <595a10cfb387e6b2ab4d2053b84fed9b3da9e079.camel@wdc.com>
References: <20180331015903.GA29398@animx.eu.org>
         <CAFLxGvzbA9XzXLsH56iyqYkitrSnBbOzD977u4266=w5zw0jNg@mail.gmail.com>
         <20180331221252.GA25573@animx.eu.org>
         <b68bf187c9cde1c36489fc5ab2187ca8750a1292.camel@wdc.com>
         <20180401113721.GA8471@animx.eu.org> <20180401163604.GB25011@animx.eu.org>
         <20180401182723.GA31755@animx.eu.org>
In-Reply-To: <20180401182723.GA31755@animx.eu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0497;7:GTj3NXF0QMhrO9GhGXyA3WpSqkjYhS0JF1YhU3wb6ycjxo1CMrBQrc1RPJ1X8LAFdFY3Hxy3gYw4PS22w04K0YXe5wjVv4K8jV1qtKYLPzG7l702hzXSA4PhClm/Ch86/MjgXIJu0Sjeuv85RTNQiReTSIa1z1U/wVhhWRcQlVgOPX1fSg3MNe02knOdZpStELh2F/0u5CLEsNSX8q+tG9oD3vwBR38jKPO41NB7QHWTnrsYiNA4rMTGuslER/8B;20:AmBuspmj5RXYmGxMCfWNiSd9ub1KhF7APCCVBIKIlNw1VKzm7OsGQvPtW35koV07EYsrePz1ejLBpqBkqU69g5Zfrfk1cZ7cmWX3GO96sZdI2w9wdJ8nQhgRgcSD3eEUGZkZgvXvVQZr3HPopHb0mC7s2Uj0weJSTSwwTmFNmho=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 151c6fcc-d614-4b4c-9c55-08d59984cff7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0497;
x-ms-traffictypediagnostic: MWHPR04MB0497:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB04971660E07AD19FB7E34A0D98A50@MWHPR04MB0497.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0497;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0497;
x-forefront-prvs: 0631F0BC3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(346002)(39380400002)(377424004)(51444003)(189003)(199004)(25786009)(72206003)(66066001)(305945005)(99286004)(6436002)(2900100001)(97736004)(3660700001)(5640700003)(93886005)(102836004)(3280700002)(316002)(478600001)(7736002)(105586002)(76176011)(229853002)(6486002)(54906003)(6916009)(5660300001)(14454004)(68736007)(39060400002)(81156014)(6246003)(53936002)(2351001)(6506007)(3846002)(6116002)(186003)(8936002)(446003)(345774005)(11346002)(6512007)(118296001)(59450400001)(2906002)(26005)(4326008)(2501003)(8676002)(486005)(2616005)(36756003)(476003)(106356001)(486005)(86362001)(1730700003)(81166006)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0497;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 3ZGthnRlzGb1jLbAprRCOaqFzk4X/32YvalrZ+FauwqECSBBWSedHIddG7yJbpfWX1gYqvzosZJhBxXkM/DNTvP1MxWBkGXbWDi3mU0c3LUltlfh1HoaqdO0sdflOjvDwV6jODVtKPmU5RW5ntsa8CGwlqidBIa55D1XGjVgEFYs+6mki0XJMAlDBbZWV6QJQPViILxfRcL29sWCDHLdXwglfff+ejujAspPOIluBhiLB0iadKekrQrmivXKHl7dOdBlVrEmkCA5oUMwCUkEwWoWcIqLgGOzWM6JkSZ1/25lD6d59CZb/5awNrBheSZM1avEPSd9ChGTjXgmu1yG4K8Rw4p2f6nOVL7XVMhJIpQJABkcAvoRSlPPL5H6RLXOVnT4AfOcgOjw2UI+/imbXgga+UyITaIQazUQ+rpkYBI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <975FE1C936EAA14D9160DD23BCD90BCE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151c6fcc-d614-4b4c-9c55-08d59984cff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2018 17:03:24.5543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0497
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w33H3ZRr013781

On Sun, 2018-04-01 at 14:27 -0400, Wakko Warner wrote:
> Wakko Warner wrote:
> > Wakko Warner wrote:
> > > I tested 4.14.32 last night with the same oops.  4.9.91 works fine.
> > > From the initiator, if I do cat /dev/sr1 > /dev/null it works.  If I mount
> > > /dev/sr1 and then do find -type f | xargs cat > /dev/null the target
> > > crashes.  I'm using the builtin iscsi target with pscsi.  I can burn from
> > > the initiator with out problems.  I'll test other kernels between 4.9 and
> > > 4.14.
> > 
> > So I've tested 4.x.y where x one of 10 11 12 14 15 and y is the latest patch
> > (except for 4.15 which was 1 behind)
> > Each of these kernels crash within seconds or immediate of doing find -type
> > f | xargs cat > /dev/null from the initiator.
> 
> I tried 4.10.0.  It doesn't completely lockup the system, but the device
> that was used hangs.  So from the initiator, it's /dev/sr1 and from the
> target it's /dev/sr0.  Attempting to read /dev/sr0 after the oops causes the
> process to hang in D state.

Hello Wakko,

Thank you for having narrowed down this further. I think that you encountered
a regression either in the block layer core or in the SCSI core. Unfortunately
the number of changes between kernel versions v4.9 and v4.10 in these two
subsystems is huge. I see two possible ways forward:
- Either that you perform a bisect to identify the patch that introduced this
  regression. However, I'm not sure whether you are familiar with the bisect
  process.
- Or that you identify the command that triggers this crash such that others
  can reproduce this issue without needing access to your setup.

How about reproducing this crash with the below patch applied on top of
kernel v4.15.x? The additional output sent by this patch to the system log
should allow us to reproduce this issue by submitting the same SCSI command
with sg_raw.

Thanks,

Bart.


Subject: [PATCH] Report commands with no physical segments in the system log

---
 drivers/scsi/scsi_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6b6a6705f6e5..74a39db57d49 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1093,8 +1093,10 @@ int scsi_init_io(struct scsi_cmnd *cmd)
 	bool is_mq = (rq->mq_ctx != NULL);
 	int error = BLKPREP_KILL;
 
-	if (WARN_ON_ONCE(!blk_rq_nr_phys_segments(rq)))
+	if (WARN_ON_ONCE(!blk_rq_nr_phys_segments(rq))) {
+		scsi_print_command(cmd);
 		goto err_exit;
+	}
 
 	error = scsi_init_sgtable(rq, &cmd->sdb);
 	if (error)
