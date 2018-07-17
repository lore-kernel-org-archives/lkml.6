Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF62ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0362075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VgaVzuGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0362075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbeGQUdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:33:50 -0400
Received: from mail-eopbgr720044.outbound.protection.outlook.com ([40.107.72.44]:63840
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729934AbeGQUdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeHcqfhBmNmq3+qiRcWBF2dzjyZqhOAmxkz2chz3+sg=;
 b=VgaVzuGRCkbuLFpcfB0E5rtfE4ZL1gVy3oZfcSMszf4ZP8WGUMdMvJbR8wwRiC4LlVDzYMaSg/1+46tJ279AboPNIMTmAuYTLg1C0Ok6Ta6f3Tr9eMgZY1nANrkBJPR0Y2eXAZoUfqEp9z1Gvb3OBHm4WjRE+/qvjsj3/WVtevU=
Received: from BL0PR02CA0016.namprd02.prod.outlook.com (2603:10b6:207:3c::29)
 by CY1PR02MB1626.namprd02.prod.outlook.com (2a01:111:e400:5299::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.20; Tue, 17 Jul
 2018 19:59:34 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BL0PR02CA0016.outlook.office365.com
 (2603:10b6:207:3c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.21 via Frontend
 Transport; Tue, 17 Jul 2018 19:59:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Tue, 17 Jul 2018 19:59:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59419 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW8C-0003Ur-JC; Tue, 17 Jul 2018 12:59:32 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1ffW87-0004zI-GV; Tue, 17 Jul 2018 12:59:27 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1ffW85-0004y7-Bt; Tue, 17 Jul 2018 12:59:25 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v10 04/10] firmware: xilinx: Add query data API
Date:   Tue, 17 Jul 2018 12:59:01 -0700
Message-ID: <1531857547-16652-5-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(50226002)(26005)(486006)(76176011)(44832011)(81156014)(106466001)(478600001)(186003)(51416003)(356003)(81166006)(36386004)(2616005)(47776003)(476003)(336012)(11346002)(305945005)(126002)(446003)(14444005)(426003)(63266004)(107886003)(48376002)(6666003)(4326008)(50466002)(2201001)(7696005)(7416002)(2906002)(5660300001)(8676002)(8936002)(36756003)(316002)(110136005)(54906003)(16586007)(72206003)(77096007)(106002)(9786002)(39060400002)(921003)(107986001)(1121003)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1626;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT037;1:tlxV+FDPEl6pcebMc+m0K/TZi5dpJOCdNX2HD9ogUSTzpNMVtiDGqV6RNAdVcIVK23Yf7FjA5haTHYKeiMlbOiSHnxFHAE+Yq5imaK6VDk47zffbLPweej/HZYHUeycW
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c82b20a-1360-41b8-383b-08d5ec1fd0f8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR02MB1626;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;3:WY6toMrRjBb6wvq9z4Fmm7XVF8QTbcSkfNS8xCqcLO1d0Jcbx4aqn9Qe/QXiQVPcCaPP6QSERsR4r+yDMFB+b/QrwTq59lVa30LPAionnY/vAwo2/SKlOvl7NM61p8ezXaH5Iqre2L9O7jpgDw4zLjvB6BYiwcYoPXARGnpHPk6kncFIaQ9orHWNLllqGCqBbL09cWCgz5wFRY9If3j3snS7XHOFKiMHlOTPK4LQKh3OtVB0ZFJLRLJlBG99Bgv5NsoKtRFBHjRga0wwLi4F7A5BYDWcaMHpoIzU3oYrza+nd6AE9a5ciLanRQt4jQpY9Geuxe5jqjYxJd3/+WLNKIOdJkYej9DplBUNvgjgOeI=;25:7m15pCPsn1x4vH4+AISGBw/OjKnYK62V3irpW5PspZY3M6cosYvXbc6BTLkxP+GcMKszf3scfIXO442e+C182TStDzDBi5Yt04KvpEqWuBn+FKtWOLhaaWjsaI0CU3PqXnyD1cp+ifdmK2cWM27Ve8pK5ARbh0BnSa9tjmUD2Lu5JcyBQO7bNUaDpOiN4P2QT+q9BUsOZ4SiIURlNOjbiVWNKYS1OIzuUylt6D7SgYW2EjPBRZckMGXwY3iGoYq59AvQsePzu5jwF0YwYzHRa8iyTWmgCjGe9iQMdVrImz5WhLLx++2WhxaG0uK3f0wYMMYu4oDiCUO/accqWTCDNQ==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1626:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;31:6fVOPaD0VKgAO1XcPXyfEhjs+EIidEbgEqVCiUMs6YxAZY8un4pM7TM1MLF8HqoQNaDbH1f5dsxFuyusR4Bf+puyfiBrC9t+0+arLwzmER5SJ3eVjZbVpU3V29hbk06Jn5ee0AMGcpse6gGKKOUN3kqNKDaRF3jG5i5kasgJxuGYfPYbIxtjNgxN0B9cPxQ+TDvb1A9CO6nbit/6Gyllp3xL4ZxR9lvJNzuB5XBPeN4=;20:BxtmaadN8lETyzh9zX4myFwLNqRJso2mtAXlIn2VVh6oT3HAlshfATwKU6dPlQi0cDwVq8YLBAJkXR+Ckbl7UwDMnK/n65Gs4I4E6fSLs6DcNC1zUku7eqCBi29kjnGPEbqtK4uMhTJpX8I2kSN4YKoM160z7eED8Vwb9v8k6gqUeubCkVenRc4ypfSX7n2BBj5aUtz3aYKc7yVQpKUlAzsVxk70Iet+ro09JZIW1rr5i6phoTvtHfZpKzjfHhvrA5kS3Y0i1GOM5BgKfX50J9j3CziUWDqSZLXlkVYldQkFMNITF+cNPsT1BN5DqpexsFCtHRqzMK9avskmopHEUrZFzWnA9RuPuZzn3CLsXNl3A7S/yyvZawOgJO0dzfDzKZR3mzXMYVfiBmzVtuLkOuZrHk1wcJvrt5LQ3xNYjQ68y9/JkBs9Q+bLycKh31FbQosiLKc7Kn9tRreWiC/tqw4RvGGPLbFT33c2Dq7rtbevJDuH8C7yj9q73Kxs+AV+
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR02MB16262FC362A890FF50554CC7B85C0@CY1PR02MB1626.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR02MB1626;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1626;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;4:cZ6IVWaomMjeHtSMErP257agCW/tfPoZ8EjErLwtSyjl8gbrCy6ulKVkWTnMcAUxgdUk+E8zmFNnyo8tdeqJ8fSaY+FwiCm+uQAP9TBDhh3glsSBmQUvYvOSRrsJeHP2r/Xy4hS9ZMHBjiMViYoHiYQg9bB0gY/5MvtlpXHf42MmEvxOonR1MjgPm22CHgBnztPgLyriLyC05/cKrk4AAf475nu0ZoGI9nNPM2zprnpjKnJ87K1hnRKWZJrmSTnKxl6Uv8mt8hcGDr1TMg7fOQbJpzZKgGGZz1Zu9/muXAJu+HJCSRPC6xFHlOyjd3G/
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR02MB1626;23:4UeU0BFT2jFxUaEK0mET27RIa+dg9RkuUHM/4mcH8?=
 =?us-ascii?Q?ehO9oSlNAExXoBNHXUs9JGl5XUEYsO8ohikokKDVdUz0KV7gROAkt36HYQab?=
 =?us-ascii?Q?EnUnyKVmuQR+sfYocrTl5D2IwG3nU23WAYyJqXVTcsp5FDEG1zPwypHJLGdj?=
 =?us-ascii?Q?CNU9t6bg4rvgstgf8IW8wHSAxet7TpqbRQnfiVR/GzubmtAQFoOkSqm4t18c?=
 =?us-ascii?Q?sPfpHyNDgOv0Q1gi7KW52FLAfhy4bXEf5rYurfVzAEeMl2FYtWzxDDQVZB2I?=
 =?us-ascii?Q?sLEfMVcWbjdqiKnmGSeFxsDy9UBo5R3799lkhsFkTawP3IP5UfmIl7o3EjM0?=
 =?us-ascii?Q?t4P8W+uRgQzkj2uCTqPxZuXTWeWNBui6JaBC+rV1RBguG1ocyGSmG0AePY8h?=
 =?us-ascii?Q?yW86tr9wff4yWax2uoEZqZB63I3jWwWSDJkbJjsYFJf95nke1eD3ukioRnMd?=
 =?us-ascii?Q?+OhsnxgWt6Ye3jY5bXRCfcDDBMFMLkfT9/8zVDtNn7F/XkSE7gnHyUwk2lfX?=
 =?us-ascii?Q?++glpYpYTPgoxK69QLzvsHJhjm+4n9mS1nYmObxw4XG4qh7AxI+JcCn7+C7k?=
 =?us-ascii?Q?kBAMJPrso0uLYL7wOmA//gwW8bhf7in9AdruapsGTQcAnTkvjB2YHw2cSEFa?=
 =?us-ascii?Q?311hHKW9t9jjYYwv7QvEIluk6ZGUxKO9A8gdMG8tu/pdcqznR+K3/TPHj1ZI?=
 =?us-ascii?Q?i78dp4TGUT1D0dzy4D7KjTgpriJYe/u957icQ5FLLJZhuiMqmq0l8QFk7cHB?=
 =?us-ascii?Q?lhHoZ1xucK4lXj5pGb1Sa3S4bgNW/L2Sh0kp2HYvfqwTgD++rdmI8GyWI2Za?=
 =?us-ascii?Q?52m7pjI0W03vch8c+yXlmJ9whhGOMTuD5scp37ytxriOErX3n/P6Js81f3IU?=
 =?us-ascii?Q?JUXC1pxy6dNhDYRYqeyzknl9rxen+9fqVMRRy7zRheqkyFLOjLoBw8sdVGk0?=
 =?us-ascii?Q?EVlX/5brVA8c/Ru+GtXqkpVKXOMIUBjoRq/AOJZmjjYnawq1eJji01vFRQWW?=
 =?us-ascii?Q?1rhF2/J75obP/ebaKmwpetKLOZSxPrHxxU0V8Ik+3yFsh65u8g+T2FXaGOKW?=
 =?us-ascii?Q?a5m6OOqGQOcQHi5I/vzkssqSF+PunnzVbUwzr49S54QG9OUXTqpd3RKK38+j?=
 =?us-ascii?Q?LWoXqWqdo2GSbSC/JMNFNhvGYvvWFygY4CLSbiH+7Emx7b1aE7N8jPmNhitO?=
 =?us-ascii?Q?2th1m6y6ExtgjqARyGmVC6zliG00OPSYpAeg+EQ35OKiLyW/e/RAE8zJvXoh?=
 =?us-ascii?Q?loMsJzeHDBEeFdjGYny0QVXZCXfLl/3WjKllt0A3HlTmPaoDer6gY5ctdBlW?=
 =?us-ascii?Q?O3McHr9ychy3u62xWtSgsom+YhqGhn31Kczlkvtjbq3+04v7al6lPoTpxXFI?=
 =?us-ascii?Q?byB3c3Ri3LYqjSv4HLTu8ZQXzvyJHvudKWZYSmN4h6+uSCd?=
X-Microsoft-Antispam-Message-Info: ogGEkN13asStDuGAyF5Z5KDBsIWY4uxYafSJtTH8MvslPTUYeTHBPNi9hE6UPVrf7+GQb5l1/RUjWqWVm5rgrtdC2AedRxUI/5CW0EB/Nz+ORpwCkzTuBcBTfnFJTojelkth5HZP6/hMxTDIl0PqS3lNN/t5pGUtVTB1ZkJrtzLtRYn3e/m8S6gvjzDz6K/cLSdps4T1pwnBnzSmN0MAhcM5pzKAIuJMlUBh/KiuTP4Sonr9OCYgPuxzUTO4Ezbd/L2o1Q0ELEtiAu2lwFXMNWPwHp3alYf4sP9QiU88vGNnA2zIkxRp/y3a6y+bgMk340zLYDdPsTq66v0ieezY106Z/7PwEUKrRsvLQ2vQVvk=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;6:sC4LtpydgHIoR8CpbJCYuj7CMkj6WAmZ9GhItccEuISxnvAJzZvLz09avt6923bUJ+JpefAKWn8As3JTs82/vkVAJGaWN/hl7QlZ9eObqdjam/CeaAlP7AVKd4QC04KkWcPxrNQcsBxtU2B3PHV69b+8oITJjxzatZMaofk3kNOE4ndsfAn2Xt364H/yzpjjdgRMex2A3Qo+zAQRaMWdFCHNtfqABoUDGAMz6ugbVRGhABU09MgmNGsnxhrocIndYzRs3aVePzKOGf5k95Jv8pkZ4nrr+5l5+lhilysoCLTnrMpv1MAnaarszMhOi2YgiWSQ0C2SGPLOXyyfPWxe0mrBnUMqchrzhXDgXmqvsi03dE1R5IfOHNUjgae4RtrEOLZJWE9U78UREuMQEJrimaAPNdnvWV3hRlCsi8uoq5zTuVtnun6jap/2nhWQOtFKtIJKNBDPrK+CViYa09QsBQ==;5:/Oe3wUEghHRc3hshSbaXdfmgH2PWjeuK7ZhDoiiSMALwnFqtqGUt4hgFlxge3vR75wIeVipKMOx4D7V2Z2/AI8+YmY3wFBRnu+PAFPsfsXkAqhKPMJ9ERdAWNumnhv1bdr8st0ubNwO6kmoYjk3ePGldpQp6Int6p6OM24BAQS8=;24:fO3umrYaOi3X2OJeqaFHrtJ4Mt1Pw3tKpVS6nSf4DlpeznmpNxwpA9X/ob+lp37Acr0E+E/vEH7glymavtid/+d1Aj9FeeBMshNMbGiWCYU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1626;7:FGZDAcP8SzStXwfVbNiR0K99+5gk85mcyyZE2ytMRQmI3/CJyla7bWVOEqgVNn1xkl6/RHrw/f9HNNq2AP/Eq/8fVKZndSNvH7JohdjvchpCWwan82ZDANmk2QjkFsDQajhp+ni9SIrx5YgReEedvMC/FpS5lD0czrKRQ01s4hr97lsXzvU/Vqo2bR1XLCzgmd2kUJ6S0Mb4JH5ayQx1wuq6siEBR8Q6Cj4RAWf9A3YQkzyV96iBr2dbbFMG7kki
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 19:59:33.1237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c82b20a-1360-41b8-383b-08d5ec1fd0f8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware query data API to query platform
specific information(clocks, pins) from firmware.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 ++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 24cfd9e..8ec5682 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -260,9 +260,23 @@ static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
 				   arg1, arg2, out);
 }
 
+/**
+ * zynqmp_pm_query_data() - Get query data from firmware
+ * @qdata:	Variable to the zynqmp_pm_query_data structure
+ * @out:	Returned output value
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
+				   qdata.arg2, qdata.arg3, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
+	.query_data = zynqmp_pm_query_data,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 2eec6e7..55ed2ba 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -35,6 +35,7 @@
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_IOCTL = 34,
+	PM_QUERY_DATA,
 };
 
 /* PMU-FW return status codes */
@@ -48,9 +49,28 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_query_id {
+	PM_QID_INVALID,
+};
+
+/**
+ * struct zynqmp_pm_query_data - PM query data
+ * @qid:	query ID
+ * @arg1:	Argument 1 of query data
+ * @arg2:	Argument 2 of query data
+ * @arg3:	Argument 3 of query data
+ */
+struct zynqmp_pm_query_data {
+	u32 qid;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+};
+
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
+	int (*query_data)(struct zynqmp_pm_query_data qdata, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

