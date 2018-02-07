Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeBGPk3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:40:29 -0500
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:3552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754150AbeBGPk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:40:26 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chad.Dupuis@cavium.com;
Date: Wed, 7 Feb 2018 10:38:20 -0500 (EST)
From: Chad Dupuis <chad.dupuis@cavium.com>
X-X-Sender: cdupuis@administrators-MacBook-Pro.local
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        QLogic-Storage-Upstream@cavium.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Nilesh Javali <nilesh.javali@cavium.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] scsi: qedf: fix LTO-enabled build
In-Reply-To: <20180202131225.1658853-5-arnd@arndb.de>
Message-ID: <alpine.OSX.2.00.1802071036410.1266@administrators-MacBook-Pro.local>
References: <20180202131225.1658853-1-arnd@arndb.de> <20180202131225.1658853-5-arnd@arndb.de>
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Originating-IP: [100.0.162.75]
X-ClientProxiedBy: MWHPR01CA0031.prod.exchangelabs.com (10.172.172.145) To
 BN6PR07MB2770.namprd07.prod.outlook.com (10.173.27.144)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1970fc0e-e506-4ee4-c4fb-08d56e411a54
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR07MB2770;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2770;3:juO5F71JkW0dG0DDMKHa6vIWkpXtKkcKccbwSIehYpRLUvRCd6YDWMt8IJZ8nM1NjxQiU6Cu8iRsA6zA0DkvcUxIMSAG7MK+VaArTQWY2tftZwVinwEnJueVKlNNfSuVhMc3C05hOyXNoNQiIR08y/S4d1rh7D2RAMErQC50ooTSeX5Dxg+D9A5N1w14GGNeOPp76KblD9J2FKDtZnsq1twsOMb6UHPAlt85bAx1lVH0ktLvsjjrVoYhN5HPec/1;25:1VQfCd9CQh+Qwb5dJiF10oMutpgROqnrwLGXYOWqaJg7neg8tOyOxvhzKxFs/22vZygYV0Ben59Zjnyc1PqLLokMsZmQgudA+/vs/VIJnBF+gZ/7/dn2sby0iiyBzkNAO1S6x/Txiu9ab5N+9wKrNmvyZMtWwhgMVSOZ68BIGAyYlDOeUTP1hUGWNy0VLQsR7r19KusWI66rgyRPUCP+82zfBt6bphIXPDMXi4125bR27Z0lGIUjkRUVghAO7s3Yzrc6uuIydhDMPScKaXHrlVmXCiZ/nlfIUU2v6VVQbthhSFnkp/MZNkCPJjwvPyCoANpq38yM6JxKRwX+2LHxzg==;31:YUo3gI2xUCQyKmieAsemho8tisBxTwrVfGBkN3chzxAN2yzv6dR2G6C8MmamIb9MdSStmCB33zpwpUdPKLj3Lqtgs8ZMaNvEaDygRaCgIEgUdNjPQy6o62ux9hA8/+CylCmsMUPv/er/b/XOjTDYo2yxUsPylsPnk/APHkG4NeinPSafdrLRectA3a0o2zMKgvXeoaqGJO/qIIE9J0cUZgoxQRJFv6SX6JPB03qgOJ8=
X-MS-TrafficTypeDiagnostic: BN6PR07MB2770:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2770;20:OJLxXWUriQ74rhV7ZBWTmQ+N23mgWlnT38M1WwIw3Y1L4lDykPw3nKzt8jge3cEu5ZLdA5Eh+d+sEup8v0ftlJz03WzRl2vY0Y2q11KCOLnybmSGENR5pWTn050BAZwNTxqoywbOrv/vjFaXn5ssuAHqr6sYVJAY7A+LkXLPV0o4k/pdNZkFCnzUpJAXbXXJ5+ifO4cmkY+dZqtfjvaw903vWfiij7aighuS5U4FW1+RHKhp4nQvcpkIMSYCuclCBW8aNgi9gX32PXXcGm6qDmgm9CZIKKtpspjZHQG0O6iwcIeCAqmKqGwOm/6CIddwl2huhY0uj4c7RWtXdtHRi+lXHM9O0KwUEG7eDFhBd7Y38j1mk/oxeKnIOxPV8mwI9TfUPAbrm5GpH9JySX2W3A5G0IZS2mEeH5L09BhubQiajKI2cl/tmNOe7iBd1O2edP5/MpNchW4Rn8U9oOl7qPvcnLwfe6NsEros4nhM9Ezfl4V/qpZU1XfLWA/enjMD;4:JgeZUWasgfFdAKuFWiVi+pLVrYmBuB0qTG6/amL/SyPsqT6fx1S8Xl6en3Z9qNzN57VmHfrgXfdVTnsxeHRmDy/CvalEzHGprOYhTZz2453IBEi4T24yTVpC4fMWd3CNKYMmm6W7DQRzWOaoflQxL1KThoGZH5X3koZ6QbUAzEexr8NKDyaKCU/41eNUYnIgiYc1iGAN5DiO21g+/V6URX2qt+U9QJQV6/mHWlAnc0pb6btucz+0BIEUvobAEG6EG2cSjpuODOkISUGAQlLfhQ==
X-Microsoft-Antispam-PRVS: <BN6PR07MB277099041C1658FB262E45019EFC0@BN6PR07MB2770.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231101)(2400082)(944501161)(3002001)(10201501046)(93006095)(93001095)(6041288)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR07MB2770;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB2770;
X-Forefront-PRVS: 0576145E86
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(199004)(189003)(117156002)(83506002)(52116002)(9686003)(25786009)(26005)(77096007)(16526019)(33896004)(47776003)(105586002)(5005980100005)(186003)(66066001)(53936002)(97736004)(76176011)(386003)(6246003)(23726003)(90366009)(3846002)(106356001)(68736007)(86362001)(8936002)(5660300001)(72206003)(81166006)(81156014)(8676002)(6486002)(478600001)(316002)(16576012)(58126008)(4326008)(16586007)(2906002)(6116002)(54906003)(6916009)(2950100002)(98436002)(7736002)(229853002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB2770;H:[192.168.1.225];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB2770;23:9J1/upEGjmZXw+p3ErBmcritOr7IRhSRdDRZo+b+I?=
 =?us-ascii?Q?/NprO9QU7HrwJD+RwlEBRM25qHY6CCxbC7LqAa5Vi2cmPYKQpJhIjL81njnu?=
 =?us-ascii?Q?NPbJFc22tGtsPwDJN1dh7dYEtsIriWfYdqBkeIBzyIeG4aydJXsh1ZdWr7VW?=
 =?us-ascii?Q?x8NFodWxsH7rMFZ+gSRmfhRg1sYFtSXkb5UdoOMR9jGPgTySOb4qnYYDK2G5?=
 =?us-ascii?Q?cFEwZ4MaGJ0DcISbrRDjpLANaUQ7+EVb6xmORCs+13eiD81dXgTN4XMd+2SV?=
 =?us-ascii?Q?Fv0rtrh6v93g55WLXfNNfm3WuETAHJQI89O1vp1IwoVdKM6m1upVPiGcSyAE?=
 =?us-ascii?Q?Iw4aLhioas2yJUKsRXrll9uZSN6eBzcq90wQ+OSMxHtSvtLkbscfJaZblamo?=
 =?us-ascii?Q?QQyoVcWu0jdlkVg3Jp/NxhzK7rfrdexw+Edls4UD4S4GEx4GCm1HSUkBHDfl?=
 =?us-ascii?Q?P6kw0U03pobaG0JLm3UjEC+93gVod1lQqQvdHj7KLxzNOmpuxyz0f6WBxYJW?=
 =?us-ascii?Q?RuGm2FqkN6/wqrBuUUHmdvkkIws9Pk+fK18erTXpdD/p27ocbrpeqmm2cWCD?=
 =?us-ascii?Q?PmYiKoAuIJKiXsskSRx2FREXhSxZ8x9mmwfbYU87OfAHvQRmbovRDM/Ng11l?=
 =?us-ascii?Q?Tgt8iemlGoU5y1B0T7NWEzio7zebBqKzFSS6H7qZzPG/HLNaUuExbKXRLE6u?=
 =?us-ascii?Q?iGM7pWdyaztEHj6x3ZId5aBCt4weYb+sO72YnuDHEIJXOMS08CRz9FT7DyrZ?=
 =?us-ascii?Q?gwWwQlUbyy3a/MbRNJO8PtzQ3RqdIMLk3e1oe/OjMEExyBUY0/rGzZk0y2kv?=
 =?us-ascii?Q?5TDexUvvZrJ8vWQ11WefEA/LKI3k+i0tvMtZM4ji4FwVX0W7JC6F2YFSpZ6P?=
 =?us-ascii?Q?Cx6G6UsLaWhAzq24UZUwpNJgwNR7RcW2lLh/PYGV7ELfLao8Ulxg0/1grMws?=
 =?us-ascii?Q?RIhffn8rSbE/hutGGdSUJLbe7bjlk+O1L0UA9I7m178TSj4DTXiBCR8gQp5i?=
 =?us-ascii?Q?gqcC1jEN0Iso0wIfKEX2+1WUjQSTSVZUnsZCxMWbjEd59wXHuNDxoIA1q1pC?=
 =?us-ascii?Q?HDYwUlpCnghJktaEMP/zrQbWZYKdjsricJLOpyAjx85T7WpnUVNknxyofEZD?=
 =?us-ascii?Q?w0IPZuNZqFC35ooIP0zGKjd3/rQjZSb6aDh88TNYNYg7SH29vpUUsQc5nt/o?=
 =?us-ascii?Q?o4PkPP3Xdr35kZtfZS7kG2z94bxJgntOkG6CCW40W6EmdI1eJEDV0l8iV7/m?=
 =?us-ascii?Q?kU/hgfhU+ziYeDJuEtE+7GWkOWuCD52oDx++htc?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB2770;6:tx++w3/PIS9hHOfHcu3SB5HCQuQppKXwSsviJFp7Zyr03afh8J7n/Z7W8+EIscBYtSbB8bXjDyqwi+s46MQIR1U3mUDLXWTI7AUeXyvbtGLm/mUaUB5I0ssQTWsK7GLvL1JaPJfs2+h2MUqjiov1s2Yber+xMiRGgijN9jUqpPJHDW5pEjEzVo997BjjrqWU3wSyy8pOeQQZPSGF+pY4LcXxgV9pkY3QUYm5pKiXW61z+BcMuTJdY/KOiiWLNAwYfoWlDqYWP3pJVJrSsQueT4HggVbu1gSJ+L4Sf4H8iz3FRa5HdW7IpBQ0wpwLAvSUeuuaOAuvZACp3Z1yqZvYdVxu49wb7+KRtFfbYbwpkPg=;5:b5JEe/Dzk2VTULmH8DXFNp+xG5KdxVOfptOF8i2P343eFVVy9efnYhgaBbjKtjuQKle++jp59zU0+cLuWMeffvkSyJMMQ93HBKul+jc9XQd6zYg4WtOSOCoB+zLVVddJhNmHn9l8yKALRW9xBH7VkvBpmvU3/9ixNxxG9yWx0KM=;24:GAGtA2T905w57I6yqI1WnLBuwx+2vxl+DCmB9E/1VPNZQ9MABL3UX3q4uQDrou+GOCZjVMFe3KTRtHWTXH6JjcMCn7kcbwSfqRluu8j3o80=;7:jQxbfAUrnedjM9XGVTFJ875J2pKg5ar0TSBygPDiMpF9MKTTAEf7Oh0HxBulU2wQ9R5FgEakFbKBHA3sEd4AhqQEvFqKhLf5/LvCk2qr6dIHo9zW41zOqgKtOF/yp/cNdy4O3kN2uXvQ0VW64P5FwurX7A1jULYNumscDzRWjLl08jrpE+e0zEwup+zk49TmVM1reRpixL8tsRmITYo62paKMxh5jVoRz/JQRlqsiHp5NPZoX/i7HnH7Zcp9X8nJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2018 15:40:21.9453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1970fc0e-e506-4ee4-c4fb-08d56e411a54
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2770
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Feb 2018, 8:12am, Arnd Bergmann wrote:

> The prototype for qedf_dbg_fops/qedf_debugfs_ops doesn't match the definition,
> which causes the final link to fail with link-time optimizations:
> 
> drivers/scsi/qedf/qedf_main.c:34: error: type of 'qedf_dbg_fops' does not match original declaration [-Werror=lto-type-mismatch]
>  extern struct file_operations qedf_dbg_fops;
> 
> drivers/scsi/qedf/qedf_debugfs.c:443: note: 'qedf_dbg_fops' was previously declared here
>  const struct file_operations qedf_dbg_fops[] = {
> 
> drivers/scsi/qedf/qedf_main.c:33: error: type of 'qedf_debugfs_ops' does not match original declaration [-Werror=lto-type-mismatch]
>  extern struct qedf_debugfs_ops qedf_debugfs_ops;
> 
> drivers/scsi/qedf/qedf_debugfs.c:102: note: 'qedf_debugfs_ops' was previously declared here
>  struct qedf_debugfs_ops qedf_debugfs_ops[] = {
> 
> This corrects the prototype and moves it into a shared header file where it
> belongs. The file operations can also be marked 'const' like the
> qedf_debugfs_ops.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/scsi/qedf/qedf_dbg.h     | 17 ++++++++++-------
>  drivers/scsi/qedf/qedf_debugfs.c |  6 +++---
>  drivers/scsi/qedf/qedf_main.c    |  8 +++-----
>  3 files changed, 16 insertions(+), 15 deletions(-)
> 

Thanks.

Acked-by: Chad Dupuis <chad.dupuis@cavium.com>
