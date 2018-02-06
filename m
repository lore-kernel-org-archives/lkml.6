Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeBFV7U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 16:59:20 -0500
Received: from mail-by2nam01on0089.outbound.protection.outlook.com ([104.47.34.89]:20608
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753057AbeBFV7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 16:59:17 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chad.Dupuis@cavium.com;
Date: Tue, 6 Feb 2018 16:58:53 -0500 (EST)
From: Chad Dupuis <chad.dupuis@cavium.com>
X-X-Sender: cdupuis@administrators-MacBook-Pro.local
To: Colin King <colin.king@canonical.com>
cc: QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: qedf: remove redundant initialization of
 'fcport'
In-Reply-To: <20180206140316.31453-1-colin.king@canonical.com>
Message-ID: <alpine.OSX.2.00.1802061658320.3555@administrators-MacBook-Pro.local>
References: <20180206140316.31453-1-colin.king@canonical.com>
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Originating-IP: [100.0.162.75]
X-ClientProxiedBy: CO2PR04CA0105.namprd04.prod.outlook.com (10.165.94.159) To
 DM5PR07MB2777.namprd07.prod.outlook.com (10.168.104.145)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c081007-c5f6-49e8-7204-08d56dacdd0f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB2777;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2777;3:I/nPCoBcRkamlGwOK88p8aml7WjBy0jI9TiL8vYReCILQIS9M9fNjqKsy8BIc2A8Yp49pWYWbypDj2rbCO4CPirh+r5rECbIR3mlyJKB0JDELWQU3LJ04mZKyDK3egFGQgp67+S4+NLf5tBG6qMmcBCtRzg6QVZEvOVfqVip0njgbINkf38co4Ad0HOlkfPnaijoAK7Nunpdq830GAQJSfj6nRmXZ1aDA9QSUblUzI2yyuGR22ehCme35ZCsQsGL;25:zz0EXZrOxCmbEnLWFTXhsx+7egKie6MdwgE4o45TxxoC9+EswmUlO/QE9TSAFUjmqCUSp8Hl35KvtvW/iQusueImZk/Eyq9ZXm+zUEPob+/eSps6mV15F9SMR6xMgnGJMP4TqDbOxcGNuZOsJue/MYfjGLiDiu+N/KZJjZjxLVeVogrMz2Srel2IH1oDGgOEdyb49rwWhSXBXo3ejBUrhGgCf+aHIy2/Lxa71nV3hNjQQPxv63hqhIB+mJm2Wj8z5kvKuBCj7X6KbNYrS3bHehb4GQKznOh2d6NbSMswgYRjyaan1eoAJaBKvzHO/Cj/UmiRTy2ecSWn33Lez2OxvA==;31:oPRD5RtdjkNbUanpk+ZRQkvzt8zO3cxnGI9h5AZp//QMdwZEop/w7QW+iWKb4UniSDH6gspL+ItI1s3r0ngpkS1tmzBkJDtJPYEB1LVm9fHWT1J9FzwURo9Vz/xb3aNA7mp2OXvtmAKVdVxnzJL1tFtV1bKGcZv/fCOcFEWNegIgB32RhQQPjToxoGvV9sCTA4Zbk3tC/IaxA1mH/p+Gh7kNsv/pBFzsH8+7yUEfeqI=
X-MS-TrafficTypeDiagnostic: DM5PR07MB2777:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2777;20:qE2hXZM3va52eP+whj7QhNa0IpCQfNqNuxqfi8F5v0tOKM57RZL3kJ0rD7a30fWL/PqHkeB+8khcZyR6ay52HUW5aK/PoLjUh59T8K15AU+CW41XIPwSb4qrSWMUalkew1E0QjV9OPirkDAma32pQT+0FCEhAJlX0Q3CXB6yQnT13kiHMSKYIvoM9sOsXbVMUOYJiaIB3FcCQPQlNU7pLT6coGb8tvu/oCykU/cq3g2e/3CglwXKn99W0Zng0mP4fmz/w5rHBXyXVWltvei/4CdyA/YTWWQsABCj/5DRv4LAGHhk1/tt+sEaet/zhabn/NHEXfaY+zC3Zu+Khvhk8p3ejLc3nAJNiGPeZT1whlY6HO5cngb2ggwXNIFZQNCXfDrLBdp7BHaOLGhgyk7ReCw0WPQsCQ6MKw07AaqdXfhrd6kPU+PPuPN6XhShJF3vg/tGKkQ7s/CmP8+JN374wdfIWG/NXPNEULskNH7dsGvNzCwo484FStSZK9XX1rJE;4:+GYZEjC3ueEZco4cugWvq5FTScqF2OC6LED7P8VcgleSD+bTwEQEJUb4AB4j1cV4ofbPkhGxn/KUWSJXzKodRVyo3GQt2l7Run50ZBvwLtuzhIb1v58rG8HZ7GOvV+xzHnSewR8VH8fcYO7/aRN6rUAewDGt4dcDGGUz+xuI1vJ/6FJ8ct4FTvwK0NlWHK13TK+0NDGImL02cKHmnbswMGDHV9p3O2HOFKrilZ00vxZazw6rJm3UtWju257ain1MVmtGAEkurpvExeGawBcNvlR2LzNX9xOSrgy5E9nyRmg1DA0oqlqjJR0JPzq++EJh
X-Microsoft-Antispam-PRVS: <DM5PR07MB27774E9649CDC65DA9C8D9369EFD0@DM5PR07MB2777.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR07MB2777;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2777;
X-Forefront-PRVS: 0575F81B58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(366004)(396003)(346002)(39380400002)(199004)(189003)(98436002)(33896004)(478600001)(53936002)(305945005)(97736004)(6116002)(7736002)(3846002)(66066001)(16576012)(76176011)(117156002)(47776003)(316002)(16586007)(9686003)(54906003)(72206003)(86362001)(58126008)(25786009)(59450400001)(23726003)(26005)(52116002)(5660300001)(2950100002)(6666003)(6916009)(77096007)(5005980100005)(386003)(83506002)(4326008)(16526019)(90366009)(8936002)(81156014)(8676002)(186003)(6246003)(81166006)(2906002)(106356001)(105586002)(68736007)(229853002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2777;H:[192.168.1.152];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2777;23:EZ+8ZSJu7sGcn2TH8Xp1CSA1ZSJHP+DWkVouKyY48?=
 =?us-ascii?Q?gyqwFBPf9hvVlF93QN9A+fR8nJvRHHfKJlzklIG+jDtD+NE/tNUtjDIbAJMv?=
 =?us-ascii?Q?yYe+SBYKnKNMS8c3IHZPwU3PJlhNuKrCDXLX1EhZ9lt1zmpHq26FFS02VZ8o?=
 =?us-ascii?Q?aqNUa8J2Zkd6aionTcPLm4EE7imYK1TJa2l0jmEt/1b/97gyG2UEl1Y5hnAZ?=
 =?us-ascii?Q?ZG1Sva+C4YrnAyEUfCsGNbLQgYpoVqRk1vkFvntxxS62uVu1GJllm/PBS5Mp?=
 =?us-ascii?Q?/uaSpPtOeHu/KjluKz5HPQmkki1SMLgOSytwF2QvzVLKfSA4OYPAYft76TVc?=
 =?us-ascii?Q?oGmnBZ61Lu4avuIKZH2lGKQ+3ynjosZDdCC1en0Ug1hyNNXk8ME+4ikCHuun?=
 =?us-ascii?Q?6NKAgw+rjnuzS5t3Vum831f8qrsr8sE99NZAg2AHOKBW6HtbdYK7YxwKFYms?=
 =?us-ascii?Q?9KK03swmRxnya7VGzY6OU4Mbvubwfw5tdcjAl0wrEGm4/jS9F68WhRytIQmI?=
 =?us-ascii?Q?qRfpH6WFu5UrIpYe3jqaznWy+FylD/dskwGRhzypPmGnpA18e3doQmWflICg?=
 =?us-ascii?Q?UX5QRt8l5RTvpaZgAhQtQ4L+jKK5Ihne1z8NrswWEIs9Xdx9P0pYsLokIiC1?=
 =?us-ascii?Q?sR/Y6GzqEWDtPYkPz98lTdoThJp+7gqK4H3IVwW3LOZLqU6d52CDFFwyHfjc?=
 =?us-ascii?Q?bwfrXTce5B7K0TXKV2yCCfRO6yYKFUA1H6+GqjuobZ5qrtWx2AC6l9tkmTzE?=
 =?us-ascii?Q?TzHW/JjFfPc5dI6TJP3Gf7TLB3vgH19DPCCVk99Qyo2hguwGxBmhulBujhYy?=
 =?us-ascii?Q?gO8RYUa0j/xvKJYV8L2WEaO4sYXw87hfCDEDxV+9gehcCk5OkqmYUsgLPlmr?=
 =?us-ascii?Q?S1WSwjNo7NkcKSsRRut2RtESX2HfQKX9fBMJvINLv6WjjvjDEsgyGumvrrw3?=
 =?us-ascii?Q?gGmH5sughTmPEednAHQDSodt/M83/uGz7gfgWhM5IxwFZKzt44TVNfRBey9w?=
 =?us-ascii?Q?LI+t1mG09sAZChd0muLE6IOzBhYsZNkQL43GDNWbl9q4k5EzYvGg2XdVNAcW?=
 =?us-ascii?Q?aHUVw89eFWFvh4yCCpo7Oz38c9PPsolapSS42vyXwRWzi3WGPljdYORs6oIC?=
 =?us-ascii?Q?eJUcJyoOuvLziJM65VxtLF8kNP/r3ijV1OHJBzC4BL/Plo6keVC+++y3DLpy?=
 =?us-ascii?Q?qqjHtoNEF6iRyGZ2omjcMgxjSvy/HoqUIVZBnTEP4tKWUoDFSA7AX5qtmuuK?=
 =?us-ascii?Q?I7IVii9kuT7x19ef54A2H5OIm3AAERhNf+yLskYTSMvhaqbgbQchxdcOTyCX?=
 =?us-ascii?Q?oipb0Cb2j6/3MkTeXL8Houj490+OY8oq2ONBjo7YvjC?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2777;6:Sypvvr8uPz5+ROmWeQtcIa4hHdjCiR9D0JYxAqPwdioO98RgciW1M+ClnIcTHWKL/0O2RfLO8h686TQun+/PDwimuq5zMrPrrNOhOKPoEjaaq6nMZwGIjRWafuTZMfkKzFqU8jZ1HNVsdy1eKdqvnZCtDpAxG3zlNKvgUafeVeXU83MzvUrrrdWkBqzopivrV8TMc8mLiXwDUymVa9LaLiZan5PWfWqhDspvv/+iUMkwsx21zTOBEkquC50OlPMtGvt3UzJKoh0FYwHZmNr5R/vxWN7Ad929/TmneNg3GmaffJA+5Q/VNf96k8AZi4rhrhHfMUZuKSKmXTH3R1HimD6vMZ3HIrEpJZdQmJRTqR0=;5:d7+mwm5fyf3Zg8VwBzzvggbjCNeoqXUJE8lyeRTjIeq2vLIzI33PWYjhB6IaCDr4VB86oIghzzEcUduFHXUwYgv4BAB/mIERIALdvyZkZP298K156tLZrK1cYmUgmCCkaMsSUj7cw9+wRypV9yV+uCHuCzX+0Z1csVnix8GijhE=;24:Yj5lWrjPrx7xTHWswf8Zglc5w0Ln7LP0tMAXM6J1Y2QGDzPqgxSp+ASSmGu1xfva+yxJ1ewzwh8Bwt5uoEWk6JsGiYJuCo0I6CZT1ta+c7g=;7:u0DV0OpQDxTwV74X9XtJMnNG6Y2kP5TPC2E4iiJIXUdIfXjjE3KPEmajDbKjcGLez2hhjeLx5KUKEi9lRvmyk4pn13E9d1FxwowANyT9SsPwfcxMHcyfvrKmPN8Kp5X8yA6Yoc0WnMkkGPfPSHElG7492nsSr8Q7N20Xe1KixHKbwOKWPVBHOKzqJMdh0/pjabEXHaUVD6UfacCXHWU2uMDUwSE1F1dBUB/efCwiDEalMWTy8ozT8DLdJL3PYhtS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 21:59:14.2122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c081007-c5f6-49e8-7204-08d56dacdd0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2018, 9:03am, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer fcport is initialized with a value that is never read, it is
> re-assigned a new value later on, hence the initialization is redundant
> and can be removed.
> 
> Cleans up clang warning:
> drivers/scsi/qedf/qedf_io.c:920:21: warning: Value stored to 'fcport'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/qedf/qedf_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
> index b15e69586a36..50a50c4249d0 100644
> --- a/drivers/scsi/qedf/qedf_io.c
> +++ b/drivers/scsi/qedf/qedf_io.c
> @@ -917,7 +917,7 @@ qedf_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *sc_cmd)
>  	struct qedf_ctx *qedf = lport_priv(lport);
>  	struct fc_rport *rport = starget_to_rport(scsi_target(sc_cmd->device));
>  	struct fc_rport_libfc_priv *rp = rport->dd_data;
> -	struct qedf_rport *fcport = rport->dd_data;
> +	struct qedf_rport *fcport;
>  	struct qedf_ioreq *io_req;
>  	int rc = 0;
>  	int rval;
> 

Acked-by: Chad Dupuis <chad.dupuis@cavium.com>
