Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbeBEGJQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:09:16 -0500
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:12186
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752510AbeBEGIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:31 -0500
From: "Rangankar, Manish" <Manish.Rangankar@cavium.com>
To: Arnd Bergmann <arnd@arndb.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Dept-Eng QLogic Storage Upstream
        <QLogic-Storage-Upstream@cavium.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        "Tayar, Tomer" <Tomer.Tayar@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        "Easi, Arun" <Arun.Easi@cavium.com>,
        "Javali, Nilesh" <Nilesh.Javali@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] scsi: qedi: fix building with LTO
Thread-Topic: [PATCH 5/6] scsi: qedi: fix building with LTO
Thread-Index: AQHTnCe04rWn8hkoFUyc4uam/RE5N6OVs1kA
Date: Mon, 5 Feb 2018 06:08:28 +0000
Message-ID: <D69DF242.54308%manish.rangankar@cavium.com>
References: <20180202131225.1658853-1-arnd@arndb.de>
 <20180202131225.1658853-6-arnd@arndb.de>
In-Reply-To: <20180202131225.1658853-6-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Manish.Rangankar@cavium.com;
x-originating-ip: [114.143.185.87]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0701MB2075;7:VWX/3/tuobvuz/mHdDNXXg+zPVGwdamsx+TdkND5bZ3nHd5SBlWh95UeahJqTYHWx1jyGohQlQUB3PQExEjdjOnotwlYktuv50NzL+zuHotjr9BRP29xP46Px+H/I/MnvkSmHZGmWMt2/enElcHxpAF0UkWvxP1meYZO29Qg9vVFs2WsaR/3cn7qNb+im0hrr55WcEtr3WtY5XSTU36eB8GunFqJ3MM7HO0lvhSkVgrHh4AdO2jTyzV6Eyd01cQJ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-correlation-id: 9b216759-69bc-4fc8-4a0a-08d56c5ee03c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0701MB2075;
x-ms-traffictypediagnostic: CY1PR0701MB2075:
x-microsoft-antispam-prvs: <CY1PR0701MB20756E1E646335B165D76977E3FE0@CY1PR0701MB2075.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0701MB2075;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB2075;
x-forefront-prvs: 0574D4712B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(39380400002)(396003)(346002)(366004)(199004)(189003)(5660300001)(2906002)(54906003)(26005)(110136005)(77096007)(68736007)(76176011)(25786009)(7736002)(3280700002)(106356001)(2950100002)(53546011)(14454004)(305945005)(316002)(4326008)(6506007)(105586002)(102836004)(229853002)(3660700001)(6512007)(97736004)(8676002)(86362001)(72206003)(6436002)(66066001)(53936002)(3846002)(6116002)(6246003)(8936002)(36756003)(186003)(478600001)(6486002)(2900100001)(81156014)(99286004)(81166006)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB2075;H:CY1PR0701MB1257.namprd07.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: MVJkClm2xN60jzMUSdFyTisw2/GMsD7Xv2HNIfIVdRvBh+ZZDDHybdv1gnCwdmD6LdevZotTs4wTlWfx0SeKjw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D093491A855B64489831983D522ED5A8@namprd07.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b216759-69bc-4fc8-4a0a-08d56c5ee03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2018 06:08:28.2722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB2075
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1569Y7v004890



On 02/02/18 6:42 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:

>When link-time optimizations are enabled, qedi fails to build because
>of mismatched prototypes:
>
>drivers/scsi/qedi/qedi_gbl.h:27:37: error: type of 'qedi_dbg_fops' does
>not match original declaration [-Werror=lto-type-mismatch]
> extern const struct file_operations qedi_dbg_fops;
>                                     ^
>drivers/scsi/qedi/qedi_debugfs.c:239:30: note: 'qedi_dbg_fops' was
>previously declared here
> const struct file_operations qedi_dbg_fops[] = {
>                              ^
>drivers/scsi/qedi/qedi_gbl.h:26:32: error: type of 'qedi_debugfs_ops'
>does not match original declaration [-Werror=lto-type-mismatch]
> extern struct qedi_debugfs_ops qedi_debugfs_ops;
>                                ^
>drivers/scsi/qedi/qedi_debugfs.c:102:25: note: 'qedi_debugfs_ops' was
>previously declared here
> struct qedi_debugfs_ops qedi_debugfs_ops[] = {
>
>This changes the declaration to match the definition, and adapts the
>users as necessary. Since both array can be constant here, I'm adding
>the 'const' everywhere for consistency.
>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/scsi/qedi/qedi_dbg.h     | 2 +-
> drivers/scsi/qedi/qedi_debugfs.c | 4 ++--
> drivers/scsi/qedi/qedi_gbl.h     | 4 ++--
> drivers/scsi/qedi/qedi_main.c    | 4 ++--
> 4 files changed, 7 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
>index c55572badfb0..358f40567849 100644
>--- a/drivers/scsi/qedi/qedi_dbg.h
>+++ b/drivers/scsi/qedi/qedi_dbg.h
>@@ -134,7 +134,7 @@ struct qedi_debugfs_ops {
> }
> 
> void qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
>-			struct qedi_debugfs_ops *dops,
>+			const struct qedi_debugfs_ops *dops,
> 			const struct file_operations *fops);
> void qedi_dbg_host_exit(struct qedi_dbg_ctx *qedi);
> void qedi_dbg_init(char *drv_name);
>diff --git a/drivers/scsi/qedi/qedi_debugfs.c
>b/drivers/scsi/qedi/qedi_debugfs.c
>index fd8a1eea3163..fd914ca4149a 100644
>--- a/drivers/scsi/qedi/qedi_debugfs.c
>+++ b/drivers/scsi/qedi/qedi_debugfs.c
>@@ -19,7 +19,7 @@ static struct dentry *qedi_dbg_root;
> 
> void
> qedi_dbg_host_init(struct qedi_dbg_ctx *qedi,
>-		   struct qedi_debugfs_ops *dops,
>+		   const struct qedi_debugfs_ops *dops,
> 		   const struct file_operations *fops)
> {
> 	char host_dirname[32];
>@@ -99,7 +99,7 @@ static struct qedi_list_of_funcs
>qedi_dbg_do_not_recover_ops[] = {
> 	{ NULL, NULL }
> };
> 
>-struct qedi_debugfs_ops qedi_debugfs_ops[] = {
>+const struct qedi_debugfs_ops qedi_debugfs_ops[] = {
> 	{ "gbl_ctx", NULL },
> 	{ "do_not_recover", qedi_dbg_do_not_recover_ops},
> 	{ "io_trace", NULL },
>diff --git a/drivers/scsi/qedi/qedi_gbl.h b/drivers/scsi/qedi/qedi_gbl.h
>index f5b5a31999aa..a2aa06ed1620 100644
>--- a/drivers/scsi/qedi/qedi_gbl.h
>+++ b/drivers/scsi/qedi/qedi_gbl.h
>@@ -23,8 +23,8 @@ extern uint qedi_io_tracing;
> extern struct scsi_host_template qedi_host_template;
> extern struct iscsi_transport qedi_iscsi_transport;
> extern const struct qed_iscsi_ops *qedi_ops;
>-extern struct qedi_debugfs_ops qedi_debugfs_ops;
>-extern const struct file_operations qedi_dbg_fops;
>+extern const struct qedi_debugfs_ops qedi_debugfs_ops[];
>+extern const struct file_operations qedi_dbg_fops[];
> extern struct device_attribute *qedi_shost_attrs[];
> 
> int qedi_alloc_sq(struct qedi_ctx *qedi, struct qedi_endpoint *ep);
>diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
>index 029e2e69b29f..e992f9d3ef00 100644
>--- a/drivers/scsi/qedi/qedi_main.c
>+++ b/drivers/scsi/qedi/qedi_main.c
>@@ -2303,8 +2303,8 @@ static int __qedi_probe(struct pci_dev *pdev, int
>mode)
> 	}
> 
> #ifdef CONFIG_DEBUG_FS
>-	qedi_dbg_host_init(&qedi->dbg_ctx, &qedi_debugfs_ops,
>-			   &qedi_dbg_fops);
>+	qedi_dbg_host_init(&qedi->dbg_ctx, qedi_debugfs_ops,
>+			   qedi_dbg_fops);
> #endif
> 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
> 		  "QLogic FastLinQ iSCSI Module qedi %s, FW %d.%d.%d.%d\n",
>-- 
>2.9.0

Thanks

Acked-by: Manish Rangankar <Manish.Rangankar@cavium.com>


>
