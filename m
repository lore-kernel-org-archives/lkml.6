Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A29C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F432082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="AZSvnBn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F432082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIDSwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:52:17 -0400
Received: from mail-eopbgr720064.outbound.protection.outlook.com ([40.107.72.64]:28305
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeIDSwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xluowa1FBts237AcOQMwAz3IOFoJ0Mn6A6PnTy1sWaY=;
 b=AZSvnBn/2VBF3pat8PW3pg5P1dJKEJ7O0hJa4s6Ap5g/wLRSVehU6SSXiqVDVGtQBT7TYSjQwN6zm/s15TcbqwAy+5o9xWPJHWxW5HrV2FWxGomUD/Mry+w6O41gSKDtfQZJ4Er7CGbvX9NrJN3JIl1BlmdnotZcGGyb/4oaeWg=
Received: from CY1PR03CA0002.namprd03.prod.outlook.com (2603:10b6:600::12) by
 DM2PR03MB559.namprd03.prod.outlook.com (2a01:111:e400:241d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Tue, 4 Sep
 2018 14:11:52 +0000
Received: from BN1BFFO11FD005.protection.gbl (2a01:111:f400:7c10::1:160) by
 CY1PR03CA0002.outlook.office365.com (2603:10b6:600::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1101.16 via Frontend Transport; Tue, 4 Sep 2018 14:11:52 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1BFFO11FD005.mail.protection.outlook.com (10.58.144.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.11
 via Frontend Transport; Tue, 4 Sep 2018 14:11:51 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w84EBpQj027439
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 4 Sep 2018 07:11:51 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 4 Sep 2018
 10:11:50 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <pmeerw@pmeerw.net>,
        <davem@davemloft.net>, <mchehab+samsung@kernel.org>,
        <gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH 1/3] iio: adxl372: Refactor the driver
Date:   Tue, 4 Sep 2018 17:11:31 +0300
Message-ID: <1536070291-5335-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(476003)(48376002)(2616005)(6306002)(126002)(7416002)(26005)(186003)(426003)(50466002)(77096007)(36756003)(336012)(107886003)(486006)(966005)(5660300001)(316002)(51416003)(72206003)(106002)(16586007)(7696005)(54906003)(2906002)(478600001)(2351001)(50226002)(106466001)(8936002)(53416004)(1720100001)(14444005)(44832011)(6666003)(6916009)(8676002)(7636002)(47776003)(356003)(305945005)(4326008)(246002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB559;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD005;1:WsIfy+ZpCALVxXb3f95mzAeurdg9KVFDGzDi1rmC/DEa78FeBQqpgmWGXmyO3d2rbsMBfzJHyG0b5O1wwMDd/8aA+Yf7LZ4pNw4DqfZLCRrsMQwMaeyr3Ji41vkwxT05
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdea6578-95dd-474c-dd5d-08d612705cc4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM2PR03MB559;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;3:ngMyxigj+jvAzin6Vh8J/5GXP0L+jFmSt6zg5zaoznys4pvlIobGq4SWHw6vfuFzjyyxipwasEFBE505MOPa3avUzmPmGEVI+iD+u21W3APNcCkU1YFZvSFiSyBWuAGdVAgAI1SZ7SulCd0Ng6LdBWUfW4rSzlaZq9vsD4Y+F7+pcQCKX1U3fmBjRSmUJHO1SDDRRAxs4QGX4RrJlyxBS57B7yz06IhavtghLrva6GWVXRsrTaONobLVYF4jgkFmb37MYQyCN/gKo2/phXM7r19l93ahuFIPPeRY+o7HMY0mwIsGvvHHEjp8t78P4CKcEQ37lepIlGhkBfuQDKvhX1HHiNI+I4aplfiRpO1p4FI=;25:0Xe/HKiCQoc3sjof/gOJTGsnEC/9mtPRhViPXkY56Y+muwIJrpxJ0/jqs0rMnvtT6E9y8/vOCpj2QKAbWszryHmtbFVQXRstjTdaEro9zm9n4oZNvDlmyyLr2lAc3EZComIOuVt1fjZDwfy7XECjLic94kXU6cl4AAwpGzYB/9vjaMxEacpmLlrLEL9IGcNgC/O8toy2t19lx3Y1C3E0mLFmtvqb5hmZk0DDRd5G3F9o2ByTrVk9rIPxv9iD66tfnan8aPEDR44l39Ps8905B3NGPNFuMIhawCxPvmSXSoNj5dB37MycVHnKe3vZ7h+f9tDJTh8vnVul6YDiFHIIcw==
X-MS-TrafficTypeDiagnostic: DM2PR03MB559:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;31:3RJMW/XnDMF1OOWF2QfK30S7WS4FPIHO8JO+NcwKzBqsD79Rl0iqpg8Wk4sZIGFJI0uAyC9KDd5X7/Hv7FySDLcPdygV8Ofbb/9VLKHq9cR4LX3b5rGKnPkQSglp6Mm9jQezwu11ANn/UIokLMDr29b5be9Y43jXWzu12SvU3oWmuV6lgaOWrSXnfZDA1U0NfyY+ShTGdV/o4tfYF5EGOiXtLiQBAGSbSf28L25W89k=;20:OjaEwfI+Ta+24AyPNZZOaFXVAZHdE9ALv5tVtVxngRIuzQgZE1kUKeWeNttop2nf2cos01ItYwSyL7T+rkVWBlytwXq0YHrh5FdxbNiKFhHKrX9Wvm+qvwhEHotkRQpeuPiT1wfUYd5LvliLBfC9FF6x9kB9QJOWDdoyYwGul12KiGVPPRYCDv9UpCXTXdKiBOqPVBuBja3fYLmHMqoEKj1tuEMQrrIdjlYrORBSYbx8Inxb2Oaf2XTNgjZmPUIaZHiwO9NKysZ6W/xn2QVVIogOKbPBS2kBjximrv4lGcFqJuQp1L6kry8p1H+HtVjzWYDq5alkOczxoIt8hAbHbc6eTtrfudFRgIH7W5lyorfXoJvrEzO283lK5Lex+9iE6IOnytnJgKcOUNYhzaWswwCM0VZyySKeod5TDCiEpZ57I55JZXnqt6NSK+DUwJLXXHWyclwmf1z4NelIMWwKOcR8oYqLUjIWPL6VaCbpHOwtX/Yh0yO8jm4+5NyOxPVA
X-Microsoft-Antispam-PRVS: <DM2PR03MB55975D504181969FB8512039D030@DM2PR03MB559.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(170811661138872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:DM2PR03MB559;BCL:0;PCL:0;RULEID:;SRVR:DM2PR03MB559;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;4:iWR9kc1u2YAoga73d6gWQh0mmddb3B6CduRoRfgYBeuC5AAewBC2sUhZ2zc8TEsiDPRvZNT1+AcNBkIlWGCenoDP5NPp33pSxIo0YB3nYnWq84PxSFpvDZLea64TR7RpZ/dk+i7JidiWY4KJYCgIMVFlE61Yn1JglAU0mzW1S9X4KfF2pCiFfrI/E/sIuu3V1ZGS8KLt9OXY2iFCKa84paAFHcSpHJMgp/CZ6jbqWAucz0vzOGQ8LfiyscAK/Fy9sMoIADE0hdJIENCQlqjTzcRd4Y9jZ6GVn5FvJKR8zDWA1RbV2JpGEtgmi6u5OLeTalQK3WldRvg8ntWgo7zSrtRkxA4PkF3G/4KudX5RBkY=
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB559;23:s/PGcBo9v0y9ypWwqECO3EthaL2C/nIMtRuOmjVmsY?=
 =?us-ascii?Q?OoymtHjuG3TIi52Yq+EJT34Oz9lA7obT8LtzESxpdTLHbEusfdGud1YOgpPP?=
 =?us-ascii?Q?vnF4PllR9Csat8fXJV9mkTIqhxmlWihc9qrPKaOwWHN4t585wLlOyDdSns2E?=
 =?us-ascii?Q?naxwFav/PGYutfw8+x3El1WmrcvmNRrmzrQ13Xkoe+EYejwcyyYIb3CHW+UT?=
 =?us-ascii?Q?BOVVapE3HArBWfonUtjUOg7U/q87Tk4AJ8Eeq1lo9vBDZJQAgnlkr6S7Eb+7?=
 =?us-ascii?Q?pHBnVGqzuM05HUO1SCeX9RWp3kPRV7ePF9pB+UsKNg5F4bewgCOBsXqekz+1?=
 =?us-ascii?Q?jS7XDCbjRCQ7f0rZyN4cAhrCvkIgSk129cCE1weRXfN4NT2hSMIGsiamdqkB?=
 =?us-ascii?Q?TVbwvJ1oE3XHYZ9+UG8lvIHCHpmdVewMj9YokSqWpmdPAyhJyQn2yJDEURwb?=
 =?us-ascii?Q?W9K8noiCru5+Yf5lFDpsMtCZ6cYKKbI3cs2TF23faFaejstzl797/v9nraxa?=
 =?us-ascii?Q?c0NBy72g+AYtzxEWLxaBTv8ZS91FXNtbMUfwOt4LUe07A66k6f4YWJjmleTq?=
 =?us-ascii?Q?jzfes1a4RH8wQqRa20US+6ndaMgfQUSrVEsh3Ejq48bfidODW53LKQwwaI+i?=
 =?us-ascii?Q?79t+lx+WJa6Qlw6jqNfkRR594UPJSbdWHiELanbHFrpCK+CbmJF4snLvfIZY?=
 =?us-ascii?Q?JidEMzA1fDuwl0VQVR/moPIT1GnscYS2wqOaGjlYqIdsY0uFkwAQLYQQWozb?=
 =?us-ascii?Q?JZpAZ2WPQsjdvG4V8p4PublJ8r/OY/3EXtnm+B91wx6pgQjrY6rQgGLD1R+1?=
 =?us-ascii?Q?3o3AxyBQz0GUGlZmB0bnAEOtwq0Px1V4pdwp7WNso81R9NOrQDwl+3C8UE5L?=
 =?us-ascii?Q?8HJ26hp1fAxQKmCZXZ1EQgj3+luvP5MWgzNJ1lXtKApm3nZPmlgw0lXUIF2M?=
 =?us-ascii?Q?gzpYNDDwDYOAL1BOdDK719sRKPrJtWmgnd0r1ZN75EXgn2OsX/ibBh/nIhjL?=
 =?us-ascii?Q?lbb1OoHG8OW0vWEWFNpaGDGZZuelnfNMnlwtV59/sPsRr5Kv5bYhizhGJvN1?=
 =?us-ascii?Q?fPFup7Gk5IVcXADQsqbv261J1PdE6DL6nmhDIOwwgvaU6EuwW5o8oRoqSM5F?=
 =?us-ascii?Q?NYZ/bzuCLuwRrJwn8ufdZXS+9tFRAuRCqXJ1powcW8VZLafyL5Bvr5DpfsFK?=
 =?us-ascii?Q?c+EndEzNrzK7gP/UqKm5GwUO/v7Y60InL/oWX5GEUEs9Oo4W4ym+O7VA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Zwe6RXHGudzm8YY9kcRS6bFxWo5AKbHY/J/Gr+Lw0ZJZfhHmjYJNoN/AyV9ns++mMwNmHvs2vOzHb+9Dzy0JLyIfKX+2iHMeUoByXVTuGUVWg2thLMmuApwpSJxwU3A/ByCka1/hTimk6eGjtkehf+ZDlZqoD5XhP6ag3oc4ZE9oGpHzF2VluocMipfFEYJhIB96EiYbE4DPINHwvxzFzmnJWmWmYpNDWsmJB3seF7FUBL/thJXxERS3EyuQ3MgOyQqok39MB9uJKY1RpSWPeSAqkLiWoUzNPtkGovkvcNnxOeEmPp1RP82nlv8HyvgvFgKaCkCC+5TIF/iAEykIshUm8DwtL8ZT9yQpQzh1uvQ=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB559;6:WfexUs0ZL8JcwZxJ7TZVqe1h3vNrwo2yFG8vAjYUtHIqGaMwdRd76R2afkGQlIcL9qpIr+GYcqqS+PBFV2AwN8gwGb0eK6E7uuC1zOGIGhHUIGA/6pj/AbsHeYr9zj0ohN2pVz9prNXgv+hrUtgwK8GOvz0QbQhJH+BfwzvIcEQEgZLImFdymTxIE7j03ze9W9le0xEs//txs/LKjTYQ2nUYKi+rlIXz6UiMzsLssvNy2Uu6bVPd1HdBIyMHujcB96Z4YqITsHMXOegc82MOgvbC0cZtZrT2TWWithzX+ZbOcEWUs0U9hakfF4EjCGd3MYXm6+iNWjG3OgqnI0wfzyJw+SyRYSSw/C8OxLTfnUWAQSmcZ+S3MKzvYEWmX2tyltea0Gl5RTUIy8y3A2TNk8esL2/xvyhr64chyIaC0pMbrgFQMGkdbpb4SjruZxlm+u+voAGXi4rwl2j9FZBz3g==;5:sAeMGPT/PxeeYrQ+rgSlml9eSY+MXvwXV9WPH4+IF6efqfF5PL9Hg+SjjHmgZxcqIlE1GqIk9+M0s1HXo9GSFxM3ZuHasqqM4z57DAeboVz33nwlhbIdgNb6M4UNVLTDH7qJPYpM4mnCpg6qlu2RDXIwpAodNTE50NTDtHTgPGY=;7:3dfvVe+iwsplSMNbFxNbDE6X4jPgC58w/AQVnFZHWlRf6YS8d+tM1GBtCX2eGbQ4lfFZdr6F0TgOYG8UH7THaxPfigr9Dl3+IjbJyykGXaFT3xmQmi2snKakQ5RKKBLr6cIMFl+JDFytJnVLow2VV1dxIYhtfpR6z7tO2m4lVIgghXag/Ps5qdj/E44WGJeSKsc9p+A8hoKm0InZbnENee4FQERbr5h6ot6br+PnZqJVPmsZKrCW2aj7upLExFzT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 14:11:51.9828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdea6578-95dd-474c-dd5d-08d612705cc4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB559
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch restructures the existing adxl372 driver by adding a module for
SPI and a header file, while the baseline module deals with the chip-logic.

This is a necessary step, as this driver should support in the future
a similar device which differs only in the type of interface used (I2C
instead of SPI).

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 MAINTAINERS                     |  1 +
 drivers/iio/accel/Kconfig       | 11 +++++--
 drivers/iio/accel/Makefile      |  1 +
 drivers/iio/accel/adxl372.c     | 73 ++++++++++++++---------------------------
 drivers/iio/accel/adxl372.h     | 15 +++++++++
 drivers/iio/accel/adxl372_spi.c | 52 +++++++++++++++++++++++++++++
 6 files changed, 102 insertions(+), 51 deletions(-)
 create mode 100644 drivers/iio/accel/adxl372.h
 create mode 100644 drivers/iio/accel/adxl372_spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2bfc9b0..2938632 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -548,6 +548,7 @@ M:	Stefan Popa <stefan.popa@analog.com>
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/accel/adxl372.c
+F:	drivers/iio/accel/adxl372_spi.c
 F:	Documentation/devicetree/bindings/iio/accel/adxl372.txt
 
 AF9013 MEDIA DRIVER
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index eae23d6..bed5da8 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -61,15 +61,20 @@ config ADXL345_SPI
 	  for the core module.
 
 config ADXL372
-	tristate "Analog Devices ADXL372 3-Axis Accelerometer Driver"
-	depends on SPI
+	tristate
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+
+config ADXL372_SPI
+	tristate "Analog Devices ADXL372 3-Axis Accelerometer SPI Driver"
+	depends on SPI
+	select ADXL372
+	select REGMAP_SPI
 	help
 	  Say yes here to add support for the Analog Devices ADXL372 triaxial
 	  acceleration sensor.
 	  To compile this driver as a module, choose M here: the
-	  module will be called adxl372.
+	  module will be called adxl372_spi.
 
 config BMA180
 	tristate "Bosch BMA180/BMA250 3-Axis Accelerometer Driver"
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 5758ffc..c9c5db9 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ADXL345) += adxl345_core.o
 obj-$(CONFIG_ADXL345_I2C) += adxl345_i2c.o
 obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
 obj-$(CONFIG_ADXL372) += adxl372.o
+obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index fdaaa58..f1df89d 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * ADXL372 3-Axis Digital Accelerometer SPI driver
+ * ADXL372 3-Axis Digital Accelerometer core driver
  *
  * Copyright 2018 Analog Devices Inc.
  */
@@ -20,6 +20,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include "adxl372.h"
+
 /* ADXL372 registers definition */
 #define ADXL372_DEVID			0x00
 #define ADXL372_DEVID_MST		0x01
@@ -246,7 +248,8 @@ static const struct iio_chan_spec adxl372_channels[] = {
 };
 
 struct adxl372_state {
-	struct spi_device		*spi;
+	int				irq;
+	struct device			*dev;
 	struct regmap			*regmap;
 	struct iio_trigger		*dready_trig;
 	enum adxl372_fifo_mode		fifo_mode;
@@ -565,7 +568,7 @@ static int adxl372_setup(struct adxl372_state *st)
 		return ret;
 
 	if (regval != ADXL372_DEVID_VAL) {
-		dev_err(&st->spi->dev, "Invalid chip id %x\n", regval);
+		dev_err(st->dev, "Invalid chip id %x\n", regval);
 		return -ENODEV;
 	}
 
@@ -891,56 +894,45 @@ static const struct iio_info adxl372_info = {
 	.hwfifo_set_watermark = adxl372_set_watermark,
 };
 
-static bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
+bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg)
 {
 	return (reg == ADXL372_FIFO_DATA);
 }
+EXPORT_SYMBOL_GPL(adxl372_readable_noinc_reg);
 
-static const struct regmap_config adxl372_spi_regmap_config = {
-	.reg_bits = 7,
-	.pad_bits = 1,
-	.val_bits = 8,
-	.read_flag_mask = BIT(0),
-	.readable_noinc_reg = adxl372_readable_noinc_reg,
-};
-
-static int adxl372_probe(struct spi_device *spi)
+int adxl372_probe(struct device *dev, struct regmap *regmap,
+		  int irq, const char *name)
 {
 	struct iio_dev *indio_dev;
 	struct adxl372_state *st;
-	struct regmap *regmap;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
-
-	st->spi = spi;
-
-	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	dev_set_drvdata(dev, indio_dev);
 
+	st->dev = dev;
 	st->regmap = regmap;
+	st->irq = irq;
 
 	indio_dev->channels = adxl372_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl372_channels);
 	indio_dev->available_scan_masks = adxl372_channel_masks;
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = dev;
+	indio_dev->name = name;
 	indio_dev->info = &adxl372_info;
 	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 
 	ret = adxl372_setup(st);
 	if (ret < 0) {
-		dev_err(&st->spi->dev, "ADXL372 setup failed\n");
+		dev_err(dev, "ADXL372 setup failed\n");
 		return ret;
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&st->spi->dev,
+	ret = devm_iio_triggered_buffer_setup(dev,
 					      indio_dev, NULL,
 					      adxl372_trigger_handler,
 					      &adxl372_buffer_ops);
@@ -949,8 +941,8 @@ static int adxl372_probe(struct spi_device *spi)
 
 	iio_buffer_set_attrs(indio_dev->buffer, adxl372_fifo_attributes);
 
-	if (st->spi->irq) {
-		st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev,
+	if (st->irq) {
+		st->dready_trig = devm_iio_trigger_alloc(dev,
 							 "%s-dev%d",
 							 indio_dev->name,
 							 indio_dev->id);
@@ -958,15 +950,15 @@ static int adxl372_probe(struct spi_device *spi)
 			return -ENOMEM;
 
 		st->dready_trig->ops = &adxl372_trigger_ops;
-		st->dready_trig->dev.parent = &st->spi->dev;
+		st->dready_trig->dev.parent = dev;
 		iio_trigger_set_drvdata(st->dready_trig, indio_dev);
-		ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
+		ret = devm_iio_trigger_register(dev, st->dready_trig);
 		if (ret < 0)
 			return ret;
 
 		indio_dev->trig = iio_trigger_get(st->dready_trig);
 
-		ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq,
+		ret = devm_request_threaded_irq(dev, st->irq,
 					iio_trigger_generic_data_rdy_poll,
 					NULL,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
@@ -975,24 +967,9 @@ static int adxl372_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	return devm_iio_device_register(&st->spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
-
-static const struct spi_device_id adxl372_id[] = {
-	{ "adxl372", 0 },
-	{}
-};
-MODULE_DEVICE_TABLE(spi, adxl372_id);
-
-static struct spi_driver adxl372_driver = {
-	.driver = {
-		.name = KBUILD_MODNAME,
-	},
-	.probe = adxl372_probe,
-	.id_table = adxl372_id,
-};
-
-module_spi_driver(adxl372_driver);
+EXPORT_SYMBOL_GPL(adxl372_probe);
 
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer driver");
diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
new file mode 100644
index 0000000..5da89b1
--- /dev/null
+++ b/drivers/iio/accel/adxl372.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * ADXL372 3-Axis Digital Accelerometer
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#ifndef _ADXL372_H_
+#define _ADXL372_H_
+
+int adxl372_probe(struct device *dev, struct regmap *regmap,
+		  int irq, const char *name);
+bool adxl372_readable_noinc_reg(struct device *dev, unsigned int reg);
+
+#endif /* _ADXL372_H_ */
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
new file mode 100644
index 0000000..e14e655
--- /dev/null
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADXL372 3-Axis Digital Accelerometer SPI driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "adxl372.h"
+
+static const struct regmap_config adxl372_spi_regmap_config = {
+	.reg_bits = 7,
+	.pad_bits = 1,
+	.val_bits = 8,
+	.read_flag_mask = BIT(0),
+	.readable_noinc_reg = adxl372_readable_noinc_reg,
+};
+
+static int adxl372_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &adxl372_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return adxl372_probe(&spi->dev, regmap, spi->irq, id->name);
+}
+
+static const struct spi_device_id adxl372_spi_id[] = {
+	{ "adxl372", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
+
+static struct spi_driver adxl372_spi_driver = {
+	.driver = {
+		.name = "adxl372_spi",
+	},
+	.probe = adxl372_spi_probe,
+	.id_table = adxl372_spi_id,
+};
+
+module_spi_driver(adxl372_spi_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADXL372 3-axis accelerometer SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

