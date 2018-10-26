Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF86C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B332020831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OJlwV9eV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B332020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJYU6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:58:33 -0400
Received: from mail-eopbgr710051.outbound.protection.outlook.com ([40.107.71.51]:25578
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727244AbeJYU6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIIed3e0GPDThN/U9z27vg/O+Oz3JN/Q6JQvwMi5uSc=;
 b=OJlwV9eVVdhDSLG2+4S+HOzSTWcHus3OyJM2Iqa6F0fWlYBiYtzRzFXM7NwJzTqRWIfVZAKrl4y9pjqWsUDpN5A7iEPINI30arIbIjq1CKTm29a8Cp0w/WbKSBs9y4TRZlKp/V+LWCsxztGlsvHkEGvPZfNApKj5gt9yfCTJz4o=
Received: from BYAPR02CA0060.namprd02.prod.outlook.com (2603:10b6:a03:54::37)
 by DM6PR02MB4331.namprd02.prod.outlook.com (2603:10b6:5:2a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.30; Thu, 25 Oct
 2018 12:25:57 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BYAPR02CA0060.outlook.office365.com
 (2603:10b6:a03:54::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 12:25:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 12:25:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40024 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFei3-0000Ob-Io; Thu, 25 Oct 2018 05:25:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFehy-0004yA-Ew; Thu, 25 Oct 2018 05:25:50 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9PCPm9j021446;
        Thu, 25 Oct 2018 05:25:48 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFehv-0004vY-IS; Thu, 25 Oct 2018 05:25:48 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 0/3] Add reset driver support for ZynqMP
Date:   Fri, 26 Oct 2018 17:54:21 +0530
Message-ID: <20181026122424.30831-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(346002)(376002)(136003)(396003)(2980300002)(438002)(189003)(199004)(126002)(486006)(476003)(2616005)(47776003)(50466002)(48376002)(106002)(36386004)(77096007)(81156014)(51416003)(336012)(81166006)(186003)(8676002)(39060400002)(8936002)(7696005)(50226002)(426003)(2906002)(16586007)(36756003)(110136005)(316002)(9786002)(1076002)(478600001)(26005)(5660300001)(106466001)(305945005)(6666004)(356004)(63266004)(2201001)(107986001)(921003)(2101003)(1121003)(83996005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4331;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT020;1:Q3a019ggA5JTpeI+6f5tzIUiQDkv8PTSJm5u7ERhY8Jf1NJulXCLqzBFYovA4cTmtQchQ530yHD6NM8u05IaKh8bwJ5qpb1fxJVp7bHK9kVz+MAEPyNBonSUR1AZEqbu
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82a38e9-1a30-4a2e-4fbc-08d63a750375
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4331;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;3:XdWcLSdRVtNJHi+rJVGHSOpKIBdmb41wV88DT6IiVGr+N7Q+pTbSxp9oWDbznDcwobwBwTB1Z9885Mc8kEE25/fAPGu/bOrLtSxqqFuf0nsbG60IgdbGncipNQeugblJrmcvLE2ehZ7jiImtEvbF1x37uI9TY/tJTPEPOSSZoobRXy53TlkQubP+YyOVCts+s6sro8buNN5bGrc0s73JBWI97Z038+ibY/3ltb05babCdOGyZa+0efSQUR0/2fIaQiMvFgSHAYEm7vtJEcde+dYeMhRHrH41JDswDObeswOD52g+JFPg/+bhK5dAMMV8K+agGFsT/CBabsBOC8pGNe5nuPErUyMTgaMrjD/uFyI=;25:RzkcWkJeoznuL20NOmQNQV6XMMGd0nOuT9glrZvFFhIw+FE4cSFL/FKC9O0FD++tHaB2S4te+CdR9wP0E0Dw5aPiDXvXDDGxXTE+K/xgX11nl2aVb4QTvMSRSFpjSH2UqjNlBYKMI0WhE7PU5wKGg3e4qjSN2RKgmRj93Vy08j9F36gYocVaKI3IiYiKpl1iq27oBCLeXhYSLU10sGlnmLSRQVQLggCuJhUh/bGjZB0ijBVxie63pdsAHVaGxQ7Riu4DX3fMI71cFQe5dlhtK5v13EO8La3Uc6CeZdLxQKjAIp1F92rmNWoBmQQnZsf9JsaT3XMRAj+WIpsOcfvJzA0LNp0HhT6pPwAk6UuidgY=
X-MS-TrafficTypeDiagnostic: DM6PR02MB4331:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;31:i1NzlVxG4tO1ZQL/JIHQ6ai/qXUwyXS020oRReOjTitQRveMl0WdYRPv/P9OxCRFOvN+bHvXjKQDbsxehKNMHlVP7ufFc8MeRXe8HLZu4Fk/HEeSS3CF5mzXnbZDaHTN++wHd0eQU9FlUvfIZizmBBoMDdVQMaUbGtZqc5Wrv5JElZHQ49c6HBS45ZsQ0J1Q07qGQomvqNl4gd3Gcru61WVwgcR+FIkrxZGusu4iHk4=;20:lyaeUUr2Uvkms5CnQMgBKDRW3rOJk4lzfDN/XDwk0G5GMht2KyWXRxuvD871ZxUDKqjmeKCmTpJ8EZxMQnBsFD4DrPc17QPpY+dTCA53hV7n98wLDfITPaFYtX/sL0ufLKEApV5rPy7T8ynVqN6BxAfEFD8m9dhmAcEA5kO70B8wlEEDvp0QJFfVsewQbnQ7b7lNVnx439jpoEE+SZAVDVQT9tGpZfOlz6Jpn8/fiUhCN6arfrMG7U4ZfX8+grlLeeS0UX/haBNCpCTa+Fk+qQ1o+x0HEwfM4pXQ6oy4qwp/ImfPn8VVKDMfg996YQWWei0AyrgcWwKHAakUkcEBrUyz50MVg5NGdTYVCI6YkQR90cH+ZhIR7KeWUhg+lJzmOV8ek5oXG70rc710bHA37JkpPHD++KZ1vg2uR4NdUiedA+xkcls1PmgVBtNWFB07Kjnb2QW4eUcQZfK9TTPf5TrEDGjDzDBPqspIAFNNTqP+EcGs0YHTx7pchdQRVofQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB43310EA7928C64F2FC0F189BC2F70@DM6PR02MB4331.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB4331;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4331;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;4:8FP1TphbeLgrTm65U08d7Eiu9XtDBCiQ/SPXUhbof0V7UD6tH9Z/sX1wnU41JvdBcCWEqStnN7shVlduV9eyb6tAxYT/mIKIil6/pA70oSTZw3Ziq96Bhx1SFsx4sIvkSkJEwzXqLYa/smIkvJrpZjSwNXsEzKNPZWhI/AwLjSDb7cZg+AkrR7ll5zY9NCCE1BsbyuX6oHm4wK7pjH5qlj5p0zhr7/c6UFRwc6eQG85yneABgw/LKEtQvLp0zqlp4/5CJgYeK7mNW5escK26J6vq/94q3B49vz/jDisbWdl7HAKNrz6TGmqoEOTZxDJa
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4331;23:a/8pbWKpenW9a650NybrMztBNPJiHXSN5XlbjgMf8?=
 =?us-ascii?Q?mtT27/n9m2KFtHHvFSdFJl3H6oq75IvGqldmO1cftvMTW2td72UaGJO84cmF?=
 =?us-ascii?Q?22LISotVfpVbTyge5KhkKVQvps4y5nJBjb7OZ/WvbJq0+53KKj6OlkLqfTOn?=
 =?us-ascii?Q?7vqJvsho6eAVFYaT+y8idzv3OSnV/Rwt2XaLBky1UqNeb6tv/JR7YG3HDjX7?=
 =?us-ascii?Q?MqHRtcLAkJR8mZqAFFTahV++8aviPXHjqfrMd8m9Psho4Ue7QvyVvltJCNgK?=
 =?us-ascii?Q?5GOtJ3Vb1eo3EIZnOPfs6ciojxkBcdkzElN1Fq20WBAtyxge7xP1z0cXXonk?=
 =?us-ascii?Q?X9lJaaA53N5r4iUlsRB1aj1VCqAADmL+1D6D7R8qAIn9Q6yDmOwJnK0hIN0N?=
 =?us-ascii?Q?ntwBGCF3qOQ/Z+B8xzIkRAZrLZ6hlbkrUl7FRA5eEva6YGJQHiOWaDQ5eb4v?=
 =?us-ascii?Q?zlWyg2Y37unyiTv7+ar/OaZGjlE7Ml81fFhFQ4Fx4FioSwFufPxwHmpWLrEF?=
 =?us-ascii?Q?w8dw4JZpslfORo8tcjE/05mB8XPTbInhuUMInCx3mzBQw0basY34rY/P3dBf?=
 =?us-ascii?Q?SrkMQn0hu/pWcSrnpHs6Ulsujc1A3JUwp/ZjMkSW1XFKAks0I20k9MZatRgz?=
 =?us-ascii?Q?d/nD1G86XFMDYYIs7lDn3YYeuc7yVfz17kdLUMavxbZqRhQ7ZEohjFIciNM/?=
 =?us-ascii?Q?a0Xn+8eadvohGrXloXfI3V6w3b24oFzlFFO2sckOOSazDIF9iydTpF5znsiC?=
 =?us-ascii?Q?5BQdHwx3FDx75auATZGz39ZcsWZQ7Gp/NpZzD433DRsTp8hRIHM8WaVk9a6R?=
 =?us-ascii?Q?UULNTc0S74KyUElWQIxhLUz3QamjqmwtJBWqAau2RkyiKQ8Na4+W0oS2yzDo?=
 =?us-ascii?Q?eryBU65EI4Y3QGGfbSYUkMzVEzHAw6IW8asiwSPUjlOK4n5sP0hMkXu9XPfz?=
 =?us-ascii?Q?nEq2lI3VSPEj+KCg07jrOi/h2SqKkUQ+muBvSdPJGbXDuYt4b+/RMDevHhd0?=
 =?us-ascii?Q?hHEEVn1yWCRIMP58E3te6AsN6qiiS8TlMFBHKTFYGlgvDDfG+O1q5sFHAB/S?=
 =?us-ascii?Q?pqBG+ksfjDQRcaclvg3tTchbsXRlI+AI8IXPADirHYnwHe/1/+aE5Sd86FMz?=
 =?us-ascii?Q?c6OXnvwQvdzpPVaezCb+3i8Vob3VX7n/vKXnziv82VGQRIczR7nYg=3D=3D?=
X-Microsoft-Antispam-Message-Info: /WA4fB9Xm2lK+v+eqG0M9Yzn1bN4SJnDkf2RJVMMCbdf4qt5e4GTF9IFEl0gY1U4RMtLjTFF/sqKOhWx6NbW48l6MSFOb9Tb3BW9U5W9HyszR2QNXVjbaDT12yG5XIlSs3GVkX5KOhEtMI1oZa12w69J8K+IONVb0ILo921O/r4/E3SjTE39sOqyGU2oknPLra5cN3NkfFd7ZsVIrN5AKSaimgZUBj0Ugkzrz9hSxt1qUHMcamakqhndf6C3lO2y6EU0kdMH6ZMNlzEjb5Sg99/qxTaoGqG/Qxo8+1/rvi1cuOzFPtw8AAaw22XMTuFZZxK8jjeffjYRMVoOmYAe+qBsU5b/F4NxRl5sHa0I54Q=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4331;6:e6hAXZUJkUJW/6XivCB3jt1l3LRu3nrpStYuP9zA29OdexGsPCiBZQeptbq6MQUtpqF8+DMkBi/Z0rSE/eERagOQo9zC1VHflIA8WTlj3R+HIU2vpLqDXh5qR2CKuOJdp9+mody8nOBaIFJ1QWyDOviGlhIyj/BA11AEeKPfZOU4RwT/S4N0/iq+XOSD3qZfE9yifyZTi93tDXVQKxXmfqMBOfLFZwd2DUA8N7rIeRed/UbXdelwM6VzSpgpPsGz92/8505WBzG9HBUjXApW30RRKdqeBL52fSfTYo5j8sbl/CRdi9TliI/0aUAO5z+BO55hGhGVt5/vWNXE7EahAgPmAZxNjUqchaNhUL9La4aZVNxvWKZLHeE4XypFbyolTUdxvoGqde7i163znF0PjddU2uvzVro2ja/87u1ymUPyuIbCfzGd9oJm0jZWR6nZ2kL7Ft62jiJmwVtjQP3VTQ==;5:iXvjBYPxSGwX9BUhoMrPI1hR7/6v4sMZxb5Gy+o31/9cVwqJPsPB0wO2d5ZbcjnVX22qUowN4cInlj/LnBLANbOZsBfQ3DWgjor/dP53DjVL1oC3cIY7hRm4HHpt1x82U9RmPCFZw6whMpMyG0vuDJzu0u4mYHKoE2O2xRSBw5g=;7:sfRK+j05n+oU9tHFAfA6JKm2bOZIAsOoQkTI/IyicjThl6hhzkOeWJgfgBmgL0T2h4t7npgJS57MhHmS4tkLqYArKRKD2TIm5M+KMS0rlLz9ZOkjiB8jGg/h8/0ol4y1J7FrenhmYuGH9wciijpQiJip/QuQiSS5Qazvm2QSVXhgRGTuI/SsJiwEWzmwFWIGtI7iVLB1/XDhrZ06Ma6JL6ivDIGVbjwStCE+cNs2u7ZfmPKJIRyHZzZgMvC2qcT5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 12:25:56.1389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82a38e9-1a30-4a2e-4fbc-08d63a750375
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4331
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are created On top of the
below repo.
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git (fetch)
BRANCH: next/drivers 

Nava kishore Manne (3):
  firmware: xilinx: Add reset API's
  dt-bindings: reset: Add bindings for ZynqMP reset driver
  reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
    controller.

 .../bindings/reset/xlnx,zynqmp-reset.txt           | 146 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  40 ++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-zynqmp.c                       | 114 ++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 136 +++++++++++++++++++
 5 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
 create mode 100644 drivers/reset/reset-zynqmp.c

-- 
2.7.4

