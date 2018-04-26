Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeDZGcH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 02:32:07 -0400
Received: from mail-bn3nam01on0116.outbound.protection.outlook.com ([104.47.33.116]:45152
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753041AbeDZGcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 02:32:04 -0400
Authentication-Results: spf=pass (sender IP is 117.103.190.43)
 smtp.mailfrom=sony.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=sony.com;
From: <Yasunari.Takiguchi@sony.com>
To: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tbird20d@gmail.com>, <frowand.list@gmail.com>,
        <Yasunari.Takiguchi@sony.com>, <Masayuki.Yamamoto@sony.com>,
        <Hideki.Nozawa@sony.com>, <Kota.Yonezawa@sony.com>,
        <Toshihiko.Matsumoto@sony.com>, <Satoshi.C.Watanabe@sony.com>
Subject: [PATCH 0/3] [media] cxd2880: modified structure declaration and optimized the driver 
Date: Thu, 26 Apr 2018 15:36:35 +0900
Message-ID: <20180426063635.31923-1-Yasunari.Takiguchi@sony.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [43.25.41.244]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.43;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(7736002)(2906002)(336012)(8936002)(86362001)(72206003)(6666003)(50226002)(246002)(49486002)(66066001)(47776003)(356003)(2876002)(8676002)(106002)(59450400001)(2616005)(7636002)(126002)(476003)(51416003)(486006)(110136005)(54906003)(50466002)(26005)(48376002)(316002)(16526019)(956004)(4743002)(426003)(106466001)(5660300001)(16586007)(107886003)(39060400002)(4326008)(3846002)(6116002)(305945005)(478600001)(36756003)(1076002)(186003)(86152003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2028;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg103.jp.sony.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT040;1:cpKZpkS1PIwG23G1bdSNMMt/xsx/rrRc1RpjTmo+qLlfPo7uRf/5LpvchFvZ+pzkp1itARnI8kmx2mEaUvWWft0VgVD1aTeGk1+2Ny5GZUcEXVqB3ZAR0n1uIcRUl36R
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR1301MB2028;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2028;3:jARc8Q8q0VRAtvKUUmYHb3SxNxOq3Q2za7VVGNXaFgQ4GGz789J+l4Uxq3qDEk3qQvmlb0rZtWR1tM2IPUqhDZA1llC90NLGm1Zp5zmKwhUDucqSOvePE+svLGNTNL7BRmfrInkX7JaznmjCg51T/X3FlNVlUdMPclOocSEe8s0SmNWRmPJWj2mxr6xB3LKo4DwVWUTCEjRw8hGIrVij+9t+uEbKXZeo3rl7WmrWE8R772MqcExLY7bHWX5H81JHb1bZAc6XgBCEI/6klMDQmZ6C4N6r+mDblhr1QPZ0oue2uYwqNgDtkaMI4GEOoyKP3yOSIbIVjWkYS14w+cilKtgoSXZKkXK+kqd0pzT3AB8=;25:BAhq2rH0GjS6Pm4eOAQFOGOR4+qh271H7j1R6fKSm9Pn3q3YQ8x7D+ywB/FxH3ZGri86a69D1rbTKT05Dl3/4AQ7w19QAZxKjSJwvgqrxJKuLVztXeniOK8Bhj0vnTjyWaXK42qqpqWRC+mV+aOImH8JSEfZ4E+Q3B3a4+yB1F3rUPIyEHifaZkM0mXqHHpnXJh6lUpe43DR1XvjQaYIo/ujWN+kREqsZ9Uqvmn2wbFQB7N4y2qS6Xo55IcbaxNkioetcibDal3vuRRvBidDW/zZclbKJJ6ftrLqS50Jy0e+sPQ0fAtyy7KSlmeVl8NkPkfKH3V2CEYf+u5L+IZQYQ==
X-MS-TrafficTypeDiagnostic: DM5PR1301MB2028:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2028;31:Di4utsA1j4cI/4vcIxa6jLcqq82jiwjVyONsmY80NrwGslCCeRyxnc8AGVo97p6WTWkoiFHP0OLsL9lun2jzO4kLgKhW/ag4eAW5AsD2BCg6BcOngoyu40SVxeCxKU0NIFpqHBiRTNRHVhAT8W5Eg1OsWWR4CtWB2KDodh5yXKN47sYuFOtFiQrBcZF+igBDFNxi712nG/ie5sxD5hyo4wLVec9OG9Ggbfjx5T8No78=;20:GgToe9p9kMZ0deGk5cGWwRJDMYzECjFViLD/WGVDUHjPz/L7KZesXcLpQE9aQBQewJIpTu6O9pmgDfEDlcLPuDgL8Ab/CyIa6lnPEOgeY7q4s5TxEW1SaK59wKUU2t5D8Fn8rWKHadkfEu7ODjo3oblClx1wWvbBtmakboeIrny03WAOXn9gk9Id7nJGyAP4xlqkx00wY9SsgZ6SwAb5PH6QnLu670gtyOXV2VBubLD7t66YAwwciFcWCRwhc2arubJYyob7DcY7e0Q/xe0g+aWHz7jag3qUjK0fNMVk4EyLFpNaB0Lw+yn8/34gq/AHg1VzikbdCM7ML2IjAADxKFWbPHFAIGAWdYPadLBEaQqNrFiX3bPb+CHu19Rko/DMyCzl8JOD8vQEMl0XVURd3ZovP+ZEK6iCT0680MK5X1IdtRa477Fiw94O7XhasogY5QUKxgc3yhkrF0eOCqbZoyy9NEAALSTdFO9Bz9k8/9qAWE1MiWWgrY3L3Jx50CxH
X-Microsoft-Antispam-PRVS: <DM5PR1301MB2028F96AF8E59DFFB236858CFD8E0@DM5PR1301MB2028.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(11241501184)(944501410)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR1301MB2028;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1301MB2028;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2028;4:muCcoMUq6uCe31TPJpCJqoDgkjp42VPYBB+w0on48l69k0LIDN42cxdVlskqtouk527YevOGJncQpQYunHu9oOCoWxHIZDoYlPnXLzlkJv9L88VXtlCjJFBBLGlpa443V9JlHH2V+8mDdI915kXg9JZ2y+2Hv9Y5PzqfNzYyUZ3qdP+E3oahWU3PkKqh7E2JzK25ZbHsfBHMbfcaSm9yXoxMPiZWD81VoNo60/Xj683x9k6zM+R8IBhqWdc5+pNGfZQsGOLU7JFm6FNPA/6QP8exSutxiI3Qq9ws8Qegx7lJSbMH/yPWZSUs7n00frfX
X-Forefront-PRVS: 0654257CF5
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR1301MB2028;23:vHmMRCLMK47/zcPSxzglGefuWyyloqsCIwwA0Ay?=
 =?us-ascii?Q?QiIun+HXefSM/etBMAOLVccy5wUBSzDIVtce0v5kDCyWXauKGtfgeTOzCXIs?=
 =?us-ascii?Q?ps2C+m0wC9IFRv/XTo8V3k463xyYjuUb34nuGXkS/VXP+mCfuYkvIy9FM4Jc?=
 =?us-ascii?Q?/l7hQGNLG0BrBhf2A4Lg0VV6pPZ4M+8qAfLmUU0TSzvpYQeGRfhni6JrL7FI?=
 =?us-ascii?Q?m/2TL6Xvn32Iwcsnt6TT1yOPSIDfmh2fTwsZ49p9m/HDoEbNpm71+JRBLLkO?=
 =?us-ascii?Q?xN0Zle0eb5WPeJvRLR92wPO/KBcCTTd7QYw0IO14a3RH3omaET7B3gxpQZe5?=
 =?us-ascii?Q?9vXulzbSODPx9r6bYiY8QtXkXhh1fud2OKmk9ItZ3aP4d4l9AHYAdL+AvDMF?=
 =?us-ascii?Q?fs2fa1QXMWrnIq7nBoSasn7BgcSD8zZRAKs3oFOaL2Ovy387Ufi/zkZPCdUF?=
 =?us-ascii?Q?QF3nSirIwyt8Rbl6mtwp6gS5LNHXKyk5LLkyxN9hFjDQPFdmzL5vwvlbbCQW?=
 =?us-ascii?Q?HThj72nBJTKSl7VQENHZXPLwgBjjEWUrtxpBnNQHLyEcqkgfBQlerRjIJGOI?=
 =?us-ascii?Q?yFk1hYJuSzen48VifX6BJbGCe6SxgsUvbiLVDvs3oshzB4SgAMGd/atu8/TR?=
 =?us-ascii?Q?bkFMzyjwrfyCaOX/fepaOqaoT74yfWDNjLzPR+99I+7B31/XvVOfwq2VaC90?=
 =?us-ascii?Q?E/BsjTX0PlE51e2GMVRnsWEUFd2Os+i9e+YSraHiUWGf9uQX+etON8vZY9r3?=
 =?us-ascii?Q?Kvddk1A8eiA4/jCuq8rv98MG0hAar7EgVAtS1NziY+Y52YLvGMmVFQL0z8An?=
 =?us-ascii?Q?vhAI7M8TB6xfuPqmDhfTkP7gulonoeqH0d+1qapE5NCkCGOu01Z8STuHW/zh?=
 =?us-ascii?Q?3zSaUvQpiilwafG2AagLDCZ7xTBtSR58nUiJYHHJtwtat8QqyvLDhOofT14D?=
 =?us-ascii?Q?uy3CAzz8Xeme8ThzX3v/1Mp04QOa10NBbYp0s1ehZMYGABmGJ10qZBgZ2A9z?=
 =?us-ascii?Q?asIiHNFz9HW9KjRhDj2eIoD79p3ZbeTxtQnvkbxv/1DTiOzjONg9MBdug1AV?=
 =?us-ascii?Q?gReHnYwPRJCrRt/BJ7FNzms2MCLfb1Yr1ImNFpiGlADoxh9nr8oCRuQExDIx?=
 =?us-ascii?Q?NYJ9SgrlAzW5BTU8+bBG+Gom0DEgo32qoJiIvcNhhKhB2qlmexxwMG3WSCPj?=
 =?us-ascii?Q?obzPhD9N+JbFqdtBra4NsIi2OH8aP/n5WhoFvVzDsC2fsV7VWd7BPW/+uqA?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: LXziBOhHI7NarmVWhiywEy2XFU3uy/nw1/qgbvXDvfwOJ+P1Eyp6KamxcOqYMFkCzTG/F+eh1DGtFQvVPYM6KQ21dXEoLwqoTlkAPbfTQcQA2t7ZyEagUD39w6qj5ECdlKi+pw1ZwF0SBMJnb0U7DitnVTA+hPL1qflzhYAsuVGTOxFY4pC4OYOi+J+Z6niI
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2028;6:syqUf1cf6figMybfyMDbrdUCuuyGbMpca6qd6MLghT34nBdACMEmUeBiVDTaSmI8dDX3j3qdU3eNWWEKP+mm5cte206v8TP3l+bA2ToV/nKBGrWTl7CkollrExqQDH5TyefPcTv3Q3z2htQrmS/U1BC2blMARUh0nc28UC/LzRuDDpAEmCU+MuOG7nHDixP8MmIZKJtkEGAvpNzZxCuumyTRN5Uue/1W9vnBGCC98fxq6PMREZ8noU8BdUUulYWZGx+xkvlJbPXNVKVjfOndLe/n8bE9CSHCKAvDAkzQ/Z3ZXzCVjMIOhD80yN7WTjD8U1De1yV3OVRhBajeiIY7BungY+47JBeCuJ2LDfBgD0OhBlFQvmo4n6ckGdKYkp1AzPwN6Czdb3ng71RtSPYXqU+yvQikii5QXo5ETYfgKRWvhbRhmmzNBHdZ4AWTnVt05LfyUq8/nCV64f2dM/IUhw==;5:WsSYrvXZNtomt/gqD4BLzH8+lqfrKi7kSCCvEWUvcpOsjwdbkyblZsZ1K8rACooeNostvvFDqhCUhAI99++C5hg7Dbr9c2bOL4j0yX/q+cSzV18JxEr71cQBNh9/gNCiv1jh4kfpX6BwRQ2+2+I9ImJueWWd+36L1a0dVvbxu7U=;24:+nL9ukka23p8xyUltUJMRCZH1SfUvxz1Jv8aqs0CnoCujythqOCEIfsIzaCq5zNkFAPZq0b/7/K0Vu2ySqd8F04QRygnP5lqLCY5qZMVEow=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2028;7:fu0mLR4nbwYeXH9M4isOljH8p1G3cZLZ8F0KLdYgulxCJKKOqd2PfEYUJfH++r5ET+6ww/o8m/xeGyUGq0BAGJYiND2hVtfow9O05v0gwHvthjccHOyDIktQrWOeLJwCIGoN4/xskXKy1bCS/NdVaMKA5IDhikx4F5esEpHbi/HTFqZyfZMpf3yIEvVOPCbaE+lL2cPekFmMgayxx1ga1wTUhLLdh5nQESCW9slwHtiIV+s96M99mkOjP1NVgftZ
X-MS-Office365-Filtering-Correlation-Id: f4fe65d9-7f9f-4700-7e9b-08d5ab3f6b9e
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 06:32:01.4631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fe65d9-7f9f-4700-7e9b-08d5ab3f6b9e
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.43];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2028
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>

Hi,

This is the update patch for patch Sony CXD2880 DVB-T2/T tuner + 
demodulator driver.

We modified how to declare structure and
optimized spi drive current and 
signal lock condition check part for BER/PER measure
to ensure BER/PER are stable.

The change history of this patch series is as below.

[Change list]
(1)The detail change items of each files are as below.
    [PATCH 1/3]
       drivers/media/spi/cxd2880-spi.c
         -modified how to declare spi_transfer structure

    [PATCH 2/3]
       drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
         -reduced the SPI output drive current
         -optimized signal lock condition check part for BER/PER measure
          to ensure BER/PER are stable

    [PATCH 3/3]
       drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h
          -updated version information

Thanks,
Takiguchi
---
 drivers/media/spi/cxd2880-spi.c                                     | 8 +++-----
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c                   | 14 ++++++++++++--
 drivers/media/dvb-frontends/cxd2880/cxd2880_tnrdmd_driver_version.h | 4 ++--

 3 files changed, 17 insertions(+), 9 deletions(-)

2.15.1
