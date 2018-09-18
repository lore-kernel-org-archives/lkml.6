Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9710ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2AF20652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xreW8oG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2AF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeIRLzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:55:12 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:17555
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbeIRLzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6uVsqRv9wKQd9O5Y+BUyOBdiNXupldt9AyOTB9HVzs=;
 b=xreW8oG1W7+ASj9kYsM8u4A8wHyAkBSCpTymoXvKXwNYTqu1+oh+H4yZaXTlw1uDsHg/U9YiZ6i4xqNBjTmqeYH11E+ndt8RJY00xpQs+V/oRg9xOIQM1GzV0rSPTOD2WT5NKJPx8tsrmMtEZFZ3yHU1RQEvN93oNfkOMmqgCsg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 06:23:57 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/4] Add i.MX6ULZ SoC support
Date:   Tue, 18 Sep 2018 14:19:04 +0800
Message-Id: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To DB3PR0402MB3915.eurprd04.prod.outlook.com
 (2603:10a6:8:f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf0b96b4-a6e4-42aa-4f75-08d61d2f545b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;3:iPjGX0b8J5ObhczeM2ng5pAjOnSeHv/ZsjTrlK8/dgAr/zwcDJzUrRJuTBQnblJ4MD9Ep520aKqkspRyUMLqfu6PVL3Khut9wsE39bTlVjXjz9S7rPDJvbyeYow7kkRRpRlpNSTChXF3n3L+nNl08ecVdCv7a69Zzo7loNaQcBhTBl2z5T38lamplB9wYLYguQUKi5W2eL0A02JRywghDKPGCP1DJXHZLSMGSvvpR9cakg2dMUPZjqAnVspGLrS4;25:tND+hn0LLmF0ZBmgZKZplis4bSVPBlrdxi4RC8SdqmbyNTVZnVklgS2fBBIl0vCz6OZkzWOXKFolMJba+6gJFfu+L2LrOTKYVrO9AeZEfujF3J0yYVgp3iJ125fWdnjH4bDeLogZnP5brsfK/XaLTmj4zJOff4lgxhm1+FuLLRJqHhurKw1fr24TTCvtNaBy8qt4PSXrZDVVQVryp5/64ijwNqylFKob6bo3JEE5Pxg6XAyKfXJjTLWhJZkNCmiT0EbhoKaNm+ipVO/oRp6yUwOiov0fLCc8coOSGpZayHL2fFFJHJ9iCXn5tOjeypcFYh4sSnVaxjd6rptpAV9fIQ==;31:XOogslOqcRxyLi9k83jj4e2GMvAYmM0HFSMDtlCa7LoEU5a9doT+rekjvmlZjEhP/vI3CEPCyGEJhsTbaPSu14At7edKS5AoYvAX/hg/igifKIdRmjOndcOLwyLzs8lTztVovI74HD1CBxMhJdRQRb9aHIzEdLHwWLQBTcZwcSQ8uV2Pm8Ny2T5CL6Jw1sMyQIXzR6UBKwntLF1cZ4wIrOo7Qb6iFWhsF8UbTPLzQb0=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3915:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;20:atf63gWxfgBPi6LxgjiWCAJiTezICufvTxbYl+lturM5zn3JYICUN1TllsOKyjDSk8kdr33REVd9O8swn4QA8TmjmRWrD3B5lPp1u+cn8eH6/S5O4mjX4FshRNJxCqEiyPwHq6OC4zSTS4evj0RQU3bmOxPMM5MNQEqK9Vm/dFRMVt4EdKJKa9Ch8CFqKrdETGOX6kwbXKtxQ9zcwghMbBJoblZ4ss1GVOyEj8qPtUxJzgy7M0tc9OabdtFXkjQJ4N+zGo8uIuQWAIEPnUrbVDwUyZ3K/WyQ0jvtJXHMOO+G4vm0n1UbK6xxgeVZ948CCALHnVLT9cFUXGSwldJ0PO4L8bPzuNjRCzZlrkmf2tlhB82Hyg0AProwMM9hjDtgybmsj4qqxb7yW8QCuRS2EChSZF/ZNMQ9OqKGOz513D3S6lxX70RUCirE2KyvmExbZjHhU2F7I2lGV19YYpRsrgu9lX5clB/n5WMOA4IMl10jQt5QryHP1cLwRuB4nPMY;4:eHny50cNKOd5FBQ6el3CguSE9BHBl42/MR7j+AJvTJwj5ldDEumu3+ijdh11+9/wzTPs3qlYo0GK/1ysSruLCQMTaK86Kmm3TByKXrKJ2ud21Aq2v8JrHWe7bDte8Vuv7DlFHJIo4H9MZoB0shQTr3HHdw3GaP600ygQa5I7K1D7zbyWWPgeqLJemyS6GO/PWLL9dOS0G2p3X3HnMN+EWw6fegYE35ttbA89T6J86pubhOGfiA7tCPSZDz/Fti5Jg2wnGnX9+hYIpL12bonqdg==
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39152DFF7BDCF7ADFCCFF97CF51D0@DB3PR0402MB3915.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DB3PR0402MB3915;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3915;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(186003)(50466002)(50226002)(8936002)(47776003)(105586002)(106356001)(478600001)(68736007)(52116002)(2906002)(66066001)(5660300001)(23676004)(97736004)(6666003)(25786009)(305945005)(4326008)(7736002)(26005)(316002)(16526019)(6486002)(3846002)(6116002)(476003)(2616005)(956004)(8676002)(7416002)(6512007)(53936002)(6506007)(386003)(486006)(86362001)(36756003)(81156014)(2870700001)(81166006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM5MTU7MjM6SDMyVnpuay8yK3lHUFFBbXVxVzd3d0gv?=
 =?utf-8?B?OFQvZVdLWkFkUzRJNVhOVE91ME5GNGVRVjZJb3NheW9hQ0hpR0x3a0dxVnFM?=
 =?utf-8?B?bngwZWJLTkUvRG1tQVNjSUZsZ1NJaGh2QWpCallVVlg1ejMvVlM5clltK0JQ?=
 =?utf-8?B?WUpUQUIzMVZKZzZidTNqUVNEempFNnEvWFpSSXJDK1Zhb292ZHRJc1ozTkxk?=
 =?utf-8?B?VU5xaGZITVY1K1owZXFOalc5QVlJTXhUYjNpQTZuelRPRmIyWU9Gb0c3UGMr?=
 =?utf-8?B?SVB6VVEzM2h4dTRyQjg4KzJ4bU0yVUtNZkRaRExtWHFWYXJzRzh6Nm1ETUto?=
 =?utf-8?B?aE1OZE92b3gySk1HanVKcnRkS3VrZ2lxNi9XenI1S2ZsMDlpWm4zVWpDa0VJ?=
 =?utf-8?B?Y2pvbkE1TkxqWUkvcnBROWdYSXJiUzRDTWx3T0srbkRvQ2RmZ2JFNXQ4QjBt?=
 =?utf-8?B?dmRHbFNDeWZ4UGttWjFoR3hMbXJYTGV3djZqV0k5QWxiUkZRbnlFc2xySTdm?=
 =?utf-8?B?eEhZc0VUVjBaZ3NMeUxmdlk4KzdMbGk1RFhVTWtTMkNBc08wZjQyaFB5Q3U4?=
 =?utf-8?B?OGpGN2taSU4xUDYwclA2eURESEpmWElkZmhVa3FHeTVkeWl1Nk56cVZPeTFW?=
 =?utf-8?B?TVV3UVFNQUw4U0paYVRxZ2VIVG1DVkc0ZjVtcEZwOGtVWEFXcFV0UEs4VkRY?=
 =?utf-8?B?NlJmL1haNlFaSXhMSFlSK1I0S1F0QkZkRU1hWS9Od2tDTm5BdmdEZk1QUGNu?=
 =?utf-8?B?WHM2VHp3Y0xBejgyMDRrSU80NjdoREdLVWN5aTZ0NmdqUzBMb3d5MUR3V0sx?=
 =?utf-8?B?c3ZmSndxdEMrSk1laGUvTlFiZHEwTmtpcEpvVHpXVk41T1pVcVRJMXFTODhi?=
 =?utf-8?B?UlluY3FwM2gzbjhwY1YzaGc5RnRXaVJLTXhVTC91V0ZhaTBOd0llTjhRalMx?=
 =?utf-8?B?bS9RT3NYck5aVVZtWWpUTUt0aW5aaHV6V0lZWjZlUmR6ME5WY09tRzd0M2Zv?=
 =?utf-8?B?Z1lSMU9WVHVjdmZsUUVDclJrWTJzZmk0ZDE0LzJCSFdRSy9uYTZOblB6QVh2?=
 =?utf-8?B?SmoveWMwNUExVHZjMjR4RC83dENIa2FVdHNMUy9TVTQ3OFVzcUl3VjEwUzZ0?=
 =?utf-8?B?c2M3R2FTM2NkdnU5MlNNSUJ0YkUvVWFoNVFBMkF5enNJblEzeXlZNnZ3TmpW?=
 =?utf-8?B?NTZUSnNBZ0lSazhKRU5PcTkwcDUwdE9jbE9WWjBnN0I0emR1eEN1anZkWGU2?=
 =?utf-8?B?cDlKNVR0QWg0L042QlRJZ0U2UU9LSUtxQklSQk95YTN5T1RVdWlhZ040bWFJ?=
 =?utf-8?B?Yk1GQVlQNzhGY3VQQUZWR3Z6OU1LQ211NndLYS9jejVSSXQ5ZkdJZkhqY1Qw?=
 =?utf-8?B?R3padzd1S1N5OFJad1V0QUI5S0piN0htN0JucG9neTlhc3FKN3VWaUNBZjBl?=
 =?utf-8?B?dW45WHBxZUtiY1NaMzY5K3ZxbTRXMTE1UWs5eU5KcFJyOE9OS0NCYS9XL3dn?=
 =?utf-8?Q?1/CYbvSmq62SxCEpr7m5wx2JgOw=3D?=
X-Microsoft-Antispam-Message-Info: DCHh13ea8uQoA/+R4WBXYwzo21cY+wOKroBIeeZhooJi0sd2UYtSTLxEjK/K4e4f5cnXPfI9BQF7h6IJBNmDBrwCjIHucxbrwqQF0mujUUCOm8BhGy2PwDfgTVs2v4wL/P+DionrhKCWFFAu76VpjDlhumxrEhP/AdJxPXEXX6rTkFOp+ibtr2r5wyiV4Qp7/gwiAFN9BS3BonhRtwliqUSLf4sBnOL+ByDUiX8j2ehDUBLOfQPlUJXyrjdNoBT9fZwxfFBXSJB1BCk92/VUr1NDwRMsqRP7IPkAx4XPxVeWe4uhijzPxlasgfedvRpKiqB8ZonlBdPAKnU8GiisOX9UlZ34H3Ti3TuBfS6PW8U=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;6:l+Bj+9KUobCY/d6Dhj7I4SMfkkuU1qnZX7NGS1fKDc1+LxN/KTQvLLCzHZhANY8/cqCH8wcys6WNUh4wfzxvA1gmPlYCQflUBb1h3fvD3zLW03Se8JfCYbTniqCPR22cfMk/a89q0byJaeGbXNUFSeFiYZnxnfkVrUoQvmGb1nEx9anZF/+inp9QXtfovZD3LI+F3pl8GrvRYOXDtTeDyRodWDZZ9RB7+ICvH9xwrUCgLk+kvS8MN32iZLOIvra8prE/PTuSFvigY8HC9wqbWVmE6KdHp4x2SQoV482Z7hbffeN3qIEnHmgg/9dHxY2Q8AZqBDDb86tI4B4apxfnFVnArPlX76IeC+sM33PsuoZcP7JXQGZmZprRWfmGkIk48IgUWL82Hpl5L7RQlyDlnvaFhewCQS62JcbWwel5f2TceChuWXcH+LCXPawVy1Em7C0e+A4Iivb2Xm8JekwHUg==;5:4KZDNMBIDVnuiFB/bkUWiXW9camkIdYQNQe8KX2SRZuk32zu25/1LFND5YSjeQegN0qu5DKrBLXJYF1H87RDJNR5PRv6AMc2HT8cgBzGYGMYVvAOJ443zZ6dLv7BZEDA5VS5fZmxvUNyx2oa7KUEs4WjeOHH/jHyWdLZNp/OQR4=;7:3KjcqEnZ7efV0Dp6VPKhzmngf8o9wXZGUfExDiEK8sfN9XgzQtAD+hW2eaQeYf1qDMqTYoZ22/9DTchc7z1vVHX7ZJHxZbOl6Q8SKOmF4C+SovZd2SuZ1wB8lSlP5898WGelDRHy7mk6p2zWpSRo8AIfODYaIoOVkIUWtR3lvpwuW5fu+dJO+6HBIxEEnzXvVzHSEmQpot+4NErlwemlZnIydWlLPSD4rxBrmQP6jxg0YDfaUtwIBXQycxGqP1I2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 06:23:57.8962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0b96b4-a6e4-42aa-4f75-08d61d2f545b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
i.MX6 family, compared to i.MX6ULL, it removes below modules:

    - UART5/UART6/UART7/UART8;
    - PWM5/PWM6/PWM7/PWM8;
    - eCSPI3/eCSPI4;
    - CAN1/CAN2;
    - FEC1/FEC2;
    - I2C3/I2C4;
    - EPIT2;
    - LCDIF;
    - GPT2;
    - TSC;

And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is
to differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
just add the new CPU type and remove those non-exist modules from dtb.

Anson Huang (4):
  ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
  ARM: imx: add i.mx6ulz msl support
  clk: imx6ul: add i.mx6ulz support
  dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board

 Documentation/devicetree/bindings/arm/fsl.txt |  4 +++
 arch/arm/boot/dts/Makefile                    |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts       | 20 ++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi                | 38 +++++++++++++++++++++++++++
 arch/arm/mach-imx/anatop.c                    | 20 ++++++++++++++
 arch/arm/mach-imx/cpu.c                       |  3 +++
 arch/arm/mach-imx/mach-imx6ul.c               |  1 +
 arch/arm/mach-imx/mxc.h                       |  7 +++++
 arch/arm/mach-imx/pm-imx6.c                   |  4 +--
 drivers/clk/imx/clk-imx6ul.c                  |  3 ++-
 10 files changed, 99 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

-- 
2.7.4

