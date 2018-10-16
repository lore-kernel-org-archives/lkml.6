Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD283C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846252086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846252086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJPSKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:10:11 -0400
Received: from mail-by2nam01on0061.outbound.protection.outlook.com ([104.47.34.61]:6289
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727002AbeJPSKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:10:10 -0400
Received: from BN7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:20::20)
 by SN6PR02MB4686.namprd02.prod.outlook.com (2603:10b6:805:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Tue, 16 Oct
 2018 10:20:08 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BN7PR02CA0007.outlook.office365.com
 (2603:10b6:408:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.20 via Frontend
 Transport; Tue, 16 Oct 2018 10:20:08 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Tue, 16 Oct 2018 10:20:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQd-0007KS-IJ; Tue, 16 Oct 2018 03:18:19 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQY-00029D-DN; Tue, 16 Oct 2018 03:18:14 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9GAID8N005672;
        Tue, 16 Oct 2018 03:18:13 -0700
Received: from [172.23.37.106] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1gCMQW-00028h-Gc; Tue, 16 Oct 2018 03:18:13 -0700
From:   <shubhrajyoti.datta@gmail.com>
To:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <jacmet@sunsite.dk>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [LINUX PATCHv3 0/9] serial-uartlite: Add support for dynamic allocation
Date:   Tue, 16 Oct 2018 15:47:59 +0530
Message-ID: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.493-7.0-31-1
X-imss-scan-details: No--4.493-7.0-31-1;No--4.493-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131841588082252873;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(54534003)(199004)(16586007)(86362001)(4326008)(87572001)(105596002)(83322999)(316002)(336012)(106466001)(2616005)(126002)(86152003)(63266004)(426003)(107886003)(51416003)(76482006)(82202002)(476003)(50466002)(8936002)(450100002)(50226002)(36756003)(8676002)(77096007)(61266001)(54906003)(47776003)(110136005)(9786002)(486006)(26005)(305945005)(2906002)(5660300001)(6666004)(48376002)(73972006)(81156014)(356004)(81166006)(2876002)(73392003)(55446002)(498600001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4686;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT020;1:ueAIZmNGmFoig/clxo3i9FI0uPX+iYTojbfTPVee7BQ3RAFMIq9m+WzXIpgUeifiZ7KA9IlvLYLW7CklTutZq4UrDZf+aCeGHYcJJCDRr0sZQL610lHRH7l1hE0YgSAm
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 462416fd-f68e-4e67-45e4-08d63350f284
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(5600074)(711020)(2017052603328);SRVR:SN6PR02MB4686;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4686;3:CRUdjpdzM4WB/eKtD0JD/kC0fS7G6hxKbu4fKJSCojKoORt8LI9ujqyiqQoqKK/qaenHTj4LdJr1veNwnOzmMSUYtgaUxdHNp1wiRkKZ3CtQ+/Zm5Q39C4yZBzqMagASuZs4J60LsbmEzYnfrczo81/OkSeV46S77BrXbvJ4yfM8mLKtbZ07tfSmKhuGbCItQZBxv3TZWrqNnm+ivPC3u9/dSN37UnbNUSXAy9pEldPmvdqeXDJHN/Tjm7OFkicuIcZMiJrEA4iKWsvAHZZNnY9etZaiCCMihWfU78QYqyuW5wijCIlSrqXE6KTxZzBVvGzaDUvadiXTabm2ypXFLD+0kH/Y7YQa03EnNMbAqDY=;25:NBTpI2cZIYWYcqhWIoaatQhaLFoqTDKPPOJ6ft1jg+WU36/xtYXUVziPTDPC8yZo9ZakdhqarDHb8mmlgJ7DjNq/YBZxxJVHesJBqAtsthUjimKjFd7gRIY1/cujLuPoIghL0jHsduHxcg4D/485wvBjmnFf+N12H9pCyKTnHPIAh9QDleSck02UnHRokDB05iQtvxf6XtwxqMdlXw7qjNvWQTjoyxk62vS19nchp39NwpDunHSrzE0TqmJJ0+PosT/Cb1yDljm9a0DrgEwYeD78fA/J6/ami9GPe8TN14fmCoewdfpKCQWjcc8Id1o6qHdPIgBjn5DjFl9yuN6d/byKbhqYNcE+94Lxde76MDM=
X-MS-TrafficTypeDiagnostic: SN6PR02MB4686:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4686;31:Zcz2mZ2IkB4YSymw+jYecP8sbWp36eK1aPJ5HpKquTuozNPn8oeP0C0G4Bi30rEIx/3v+gGo4tg+7KTOvQWzBd/FF5rSgWSBXpJIVHS+iXra+AoIuY4tzoaWfgy4omD17EVB2XM5IUbFVLyXsO1uyBE0Mf85U/SsmDEgy/kqXUqMEuAU9zoumld9u65W+RhkMvKgbNXWle1yIcD6bj8vms3+8WO7QMpBHOuV7MX4Kqc=;4:igCf0bWt7UWRk+4ec26c9cZgw4QIpU5JXkN0oHbpjr0RRJ5GoDP3Ui9ew9CNUs0GGGW+sEm7sooZ2yWJAOFxFgB+wcKvVC9DQcB3UDQEfPyc1Q4+rgFtBH5zgkPWnbuJtWktdBf7GvdOVOWwCPKL2uem0Y9G/qGSFzjeNmUY01lTQiDtkIIqFcnYPdQ0usou8fwJvNDhh7N/vuRR64sfFT23x9N1eSqLgBCkj//iINJFogZA9l9rm4a/uUnkv6BYhFH34Ophm3szzUX6vhwUUUhUeyyzNK9s84U15mXU+29bx6VZpXD+xP95Z/l+OJVB
X-Microsoft-Antispam-PRVS: <SN6PR02MB4686D5AC9386E0740670FD7287FE0@SN6PR02MB4686.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(6096035)(20161123561025)(20161123563025)(20161123556025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123565025)(201708071742011)(7699051);SRVR:SN6PR02MB4686;BCL:0;PCL:0;RULEID:(400006);SRVR:SN6PR02MB4686;
X-Forefront-PRVS: 0827D7ACB9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4686;23:uVqmL2fWNZ/2pEFQw6II1rkyfJvT4N7u5k1tf0qEh?=
 =?us-ascii?Q?OiHRjg9S/fdcKjOROzitdX1GSDq4HQ8Q1zcJMKrKluAlN+pmIJiXmSNtkjvs?=
 =?us-ascii?Q?uM+VjCodQpBoxmmgZoK+Y4XVzMuicriTL8/Dva+ehmashF3pFk7cyIMIsbDT?=
 =?us-ascii?Q?4h4eW6ihfz5gF+pvkewPrE32lGWMLWjWCb5uKkgEkD9A9OlCACN0ge9WmLol?=
 =?us-ascii?Q?btstl5vqOpTnMez1ORAoG+HZuQSq0Vp8Ike04Wbr/IpbO/+2p5KGiXlTc2c3?=
 =?us-ascii?Q?bOKeHdPQ2aX2tfPs7fDmZBDjWwPVJ4BrnjuBfSxUXjp9pwvrMtHQ+0Hhylup?=
 =?us-ascii?Q?3XJsUYmBD36aVmluZNoMuREDiEOZ0MWFfEg2Rr534SHEEXDA/QJlhnj+uGRf?=
 =?us-ascii?Q?OKjExD0IuTZHYPlF4aSfuv7gA6l9Tfr6a5Qbr4qEOuxaFozSxjtPwHK6/PqL?=
 =?us-ascii?Q?1nvwXYz6V+GevhCkoGCSuW/M/h/noC0/P4vl5S4C7+kwo+3TImPVFgpICAw5?=
 =?us-ascii?Q?qJwCsMpl/QmbZ77Qy2bpuxhlUvCW0NHVdqaWDPMD+V4XKLLXslLF2zOokqut?=
 =?us-ascii?Q?UQMh1BUDWTZV/ELkh5n+wGKFoWiZEi7YRy+bm0smfimR1p8cijSW3D3ghpWK?=
 =?us-ascii?Q?zW3Q7OnMpiZIwaDl1ibVhXvwRNkudWzhSbrfd0CCQY6oyOAlevsx7bCuYZbZ?=
 =?us-ascii?Q?WY/44TFc7L7RFw+vQNhzq4xC0s0Q4YqsNxcMnmYwxWe31AkGCxJhx0LJ3Z2d?=
 =?us-ascii?Q?09x3oOy+lQQrjxsBwr5atYT2oKCiC57pBWVOYpaRyaq1+5ehSSknw9J2v/Ft?=
 =?us-ascii?Q?MP4vExrfxDse37Fjd++AOTY/TyY9opl19pReDvGGEn/Wu2LWgIY0lF+zxXt7?=
 =?us-ascii?Q?8bHiU3UJrAI1MoMbYa7t3Rz44noU+VzwEzDZtXIfRtnfeyi+XVtsV5LhVO2s?=
 =?us-ascii?Q?11+coOn8qD5Ny5THlsrEtx88cPhf335+sRRPeXZri3+i4NYlF2SilqVUKEB4?=
 =?us-ascii?Q?9Df8oWBsFodXjOUJx6IZRrOGf5aYA/+ectujPihTffk4MNn5qL39muM5R5uC?=
 =?us-ascii?Q?4gId3qv1iBcMFMaxCsr+na8FkSM42WroJ/AgJy0jWnI+jCbRNBnN0rI5OwlK?=
 =?us-ascii?Q?wHl4T+SXTxD7eu2cxs1c7Bq/8hzhbrb+NFtLVvw/WPU0bIyZ1HQydzZzgll5?=
 =?us-ascii?Q?XDO9zqF8NWcZoTpzXG26mg6OxRKobw65wQak2g7K5Q3EomjLD3TK+7Sce3L0?=
 =?us-ascii?Q?ZFjcO3cZSqdHPIG8p5gbrg4nJfS0dWP66WQ6Fe+?=
X-Microsoft-Antispam-Message-Info: gRjfVPr0U28vWj8YnEMr8+7zEuv+docqyYNwXYPs2oDocczl5OAFGur71PvUNh4EYioSxri00y8OSPuwtzOerO5vBBZHUb9yxvwpHlK9sI7kdE7ht13IskdaXfMQ4X6fmfvdwkAMOuAnY/AVSMuSG+aeE/pc9QFeqh1MS2zGI3BF24Ubngw5YNZnZ6EoyeHRaJkv41rY7MwFws/gqe3cRHFMJBMywCsCPMasIWSm+a2DsFbEEgS7PAAXPbX0eQGRZaYKxGg1sq4yztflnl4ZQa7JpdP6//d6nfRHHzPaW5m89bGw2UTfN1HP666B32HJP/pFS2ucEbZ1ZIEn9n0mYiuBzspwVrmDc3CofEh79MA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4686;6:R+e6V4PuTTlf9j59hhyTYeZUqsYoWcseWSpzfmdxd/Vu1+3ZI6K3JGvelowrDstnGAqaIbLvtUD/m6Rdm3Fbeosub1MmwZRBA/a57Cc1H/O2y65S/+AtqAYq3VCpxD4gcInr/UI4j9w40B0305yrZiUbdIu50WqVoCOt1qXntb6GFOo2V+nNwiEvkEhNLxwFZ+Oo0IMRVtRfUnomjHsaO4kIpm+/glAUGgHK35s50xQI+K7u5O+Ji7p/5QcJ2e6L63HySmZrQgkaYgNXfVnWSvegLENOPWm18oIm36HILPqPlA+/vAtzIaLHk0aK7s8T2RKAUI3al1/ZEjzrYeu8Cm3+PCtDPFTpyJmo2yzWiRtRzIMX7K4ypKEF0TxiAKRc/67MHeVuPviHaUlfsB+eW28rFdRmoF+YAoVFsqkThbmK4pZTwLV0KotVvPFzSuIRXNYUmn47+42zeIsjhdsG3g==;5:MOeOvkz0PE/Vk5wD7UFbBTKJdq5wno/wecILe+eAhZcGhLwiCQkRiQff3sl9loDRH0cC2tR80K7S7zNEpanzPftia8UqZpGcv3YX24qXOZ2o37RTWk1VHNeYhe8IZVIIn2aiY9RUgggrv6Du0J6waHYAZ+YDzLVZe0U93DcFs1c=;7:UyHMyrzpUq30SImPyjCvpDG9WQ4m/Q91e2eCFQTXOns2pWwuXpvMO47fj8gcWac2HC8pW5ab4Dca6wVReTdOOYiY6NG/FIhO4xhjqG8tby5/HKiHx9cty4hEKPYUpPiUFOqMPs6mc+kTs1+ZDBaATZ/ORffBIXb3C+fZJXuRK5D5PY4m8ZCn6J4oc8D1at9ziC0SFvotEPxOpM0tYhce5tBgdbEFyWAsbgjnbAG9+CPvDYTSgT3jzLSLn+52trVz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2018 10:20:07.0690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462416fd-f68e-4e67-45e4-08d63350f284
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently the number of uarts are configured through a Kconfig
option Make it dynamic.
While at it adapt to the runtime framework.

It is based a similar series on the uartps from Michal

Shubhrajyoti Datta (9):
  serial-uartlite: Move the uart register
  serial-uartlite: Add get serial id if not provided
  serial-uartlite: Do not use static struct uart_driver out of probe()
  serial-uartlite: Add runtime support
  serial-uartlite: Fix the unbind path
  serial-uartlite: Change logic how console_port is setup
  serial-uartlite: Use allocated structure instead of static ones
  serial-uartlite: Remove ULITE_NR_PORTS macro
  serial-uartlite: Remove SERIAL_UARTLITE_NR_UARTS

 drivers/tty/serial/Kconfig    |   9 --
 drivers/tty/serial/uartlite.c | 325 +++++++++++++++++++++++++++++++-----------
 2 files changed, 243 insertions(+), 91 deletions(-)

-- 
2.1.1

