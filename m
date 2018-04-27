Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeD0VsT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:48:19 -0400
Received: from mail-co1nam03on0049.outbound.protection.outlook.com ([104.47.40.49]:57424
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932265AbeD0VsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:48:17 -0400
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        rientjes@google.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 0/2] x86/CPU/AMD: Add support for Extended Topology Enumeration
Date: Fri, 27 Apr 2018 16:47:59 -0500
Message-Id: <1524865681-112110-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:405:39::46) To BY2PR12MB0132.namprd12.prod.outlook.com
 (2a01:111:e400:585a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0132;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;3:vZMP19EacNGcYk7uiy5Hxp2oskIMMQvp7/d5uiVdeiqdVIDBQcFgFT/pNUBxRWOheqU6IkGsMepZEKW6dtp5uGhnJCX5HjmnpAUeKODB/EyTgP2Yu/x3LtVu6Pui2BQ0/EG+8Si7ScNnX0XQjal4r6Yfne3SeuOiTxMryJMJXfyyeXfp5uEuz/F2agpZ9ovreTMYaVS6+Bmh4lPy3EwyVLDaOX3WyMxZpzSERK7XR659sYhkpPMf4jFGdcMzu1c3;25:3xw1QlY7tFvJjF0xcoYB4fO8j/ZkSQ1c2Hh2+zz+OjNJhNGu+dv97PFdkrcGQfgqmLpWlQptSqMvkZ5AB31JoDJ4olv943ITU7Hq1n13a+pgTVKpcArf6cx/EbsYux7/v5KQNkVfHqbJN4tUaYf0Q4/XIxN4qeRPcLw5K9q+0D5M5Lp+JabHeffWjJSoHb/5MQPazfDQYDchIbC9w7M9WVhG5UJG+yL2juDwGzuHmUI/68hThaqnSa3WvkNpWpzyL3539A3PKDHqjB8Vfxg1V0dAKy/ZpXxtftoSldmvGNNJ8BZR0TaOGfS9hxmrYOs+eJGb/heugFiHTICRrW6bXw==;31:uAnkS9FwIBZzNcYIQlg0obQFkJd295X8fFjffm8yWT7H8DvIAo6o68C+ZOHDkbkB8D8Ff74Y1NCvelqDnDk2EhUMaviH+p0FCAD+1XFsQRWrqzu4mZ0IzL8TPhtsRrI2GAULDO75J0I5jCn7cJKD/zNtMUx6JLgMWXioBLDwVpvoSqFDSIoW/HiKAViUrRttyJ35lRLEKqV29a0EyNd09c3pgwyY6qNSo9V0kXTa9Hc=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0132:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;20:OTEwjXV896Fh7ccyRYZuKh/YYCeij55KtANZ/47bAzbIG06IX4ws+698hhVsQncBLwSuf6vwD7DG6gAioB+vW+An7aG91u2pKiE/1eWHPq6nbx3SxVKlqfa+g+I2SJoqa7YZb3tT01CFbsUJo8Eu2ygitehAib5xoG12G0WXJpA5ffwhz2aHVVmPs6mRyMImUUP8IFWG64xDYLpsxPjrfpFEsz8w7oHnMMgOK2SZ5UPqJDxPLyfAUlMbvO45E7gSUSbJlS+piOB0QtCPiCEEfSl075EILEneXzofauUS3myFcnG90xTSudJJH5z0GU6OCMdjcQSNGel/q0NXKW4W910l83UTz+8WkMJypZHtJIpdbyBFe2om5ts4p4FqAYI3vGGc9PCwdub/su8h/x+c1pVvGQzTJ3R9rcBYtYsW48W/uDx9xChv5mcB+Gc9DhzgXr/llSGoaO3oiEpd51kGpAWkScwI8i6Z+ZjbMSLZ34osexj93OYrslQJdZPHBVzP;4:K1zcLfGklET+23Oh2TVNFLVEPu55RQvbe2M9doJRXwqpxpafFwOgEhUpSNWwoYkSopLVubZIjh874h8NlZkxTEj0fJvRtdT5mejgJf1s9FKDyNDubGRTu2zNDHAtpAm42B3/4RlMK0lMkz2k9KWrIAy6FAH8C6M0S2FCcDk+ax1r5ywGufRLSOfub+z3jSO6rE5mIPgOCuVhWJzqveANY1lG9DZwe5tJKnRRq2Cet3C0Pyx6OmlWSIm6gK8v865YCX5MrbH6yleddUsrxm5LnA==
X-Microsoft-Antispam-PRVS: <BY2PR12MB0132275E69326BAA023FADF0F38D0@BY2PR12MB0132.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231239)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0132;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0132;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(39380400002)(346002)(199004)(189003)(66066001)(186003)(105586002)(6666003)(16526019)(81166006)(51416003)(81156014)(6486002)(106356001)(48376002)(486006)(476003)(68736007)(53416004)(50466002)(8676002)(2616005)(956004)(7696005)(5660300001)(8936002)(52116002)(2906002)(36756003)(72206003)(386003)(7736002)(59450400001)(478600001)(44832011)(305945005)(97736004)(6306002)(53936002)(26005)(6116002)(575784001)(86362001)(50226002)(4326008)(16586007)(25786009)(3846002)(47776003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0132;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0132;23:acpG6PdKObgsrSCdxDUepBr+tU0wOZ/hhkW5Ttz8O?=
 =?us-ascii?Q?B/ceJhQ1ayHm2QUhmXeHLkaZcL+NO0wbosu1JUxZ7i+oqq2J4WYU+gY9+Ng7?=
 =?us-ascii?Q?/8CyFQPfhpmrrAey8Y/dVAfNcxKXcmGLvd0rDop+DiIfYQ1zKn/7HrNGiDxU?=
 =?us-ascii?Q?uTKkaSkA9wVEF366JiZjQhh68MX6Sn5lM4fn+Ld4ANntKxhm2HbQo66g/eyv?=
 =?us-ascii?Q?amXLV8rbeXmg6BSC1mtk1EeOQng7ZXxUuLy1QY1F+Os2IFz0bX3fXSoNfVeW?=
 =?us-ascii?Q?S4OzPLdi08GktX9uNEgUOfRqZP4tm2ahyistVyZZ5hAac8c4usK3BSZVJxGj?=
 =?us-ascii?Q?npZ0wKdSoW0L8zn6Bbr/zburAsE+1Oma+dU7zELWktl/UqRkXquxRqawzwyn?=
 =?us-ascii?Q?CpFOhBflJ9b2R5PGdIkhKb8QwHaMC2bum9oC4YqRiyjX6UY1NcpG9x9RBwoZ?=
 =?us-ascii?Q?EPGt9gDpQ8PZ1Xekif76WL2mJ9VXHvu5akmn5MNWrzUCg7wMfsKK2+ehGOP2?=
 =?us-ascii?Q?lsSElMdRd1OmNoyj3u4q5aRWfsZOK8vywuRacLpkfLvFAHkFXjvxqeE917i1?=
 =?us-ascii?Q?jKRLGNA1Jjt83jvo5Ueb5e/v4m3CNpIWaZODvyj3lgAdsGKLFROufQli83B/?=
 =?us-ascii?Q?iEq6nBGaRJBdmh7zmrHTsMYeyAeQVv/3xYzAt22fuTDShCNctVdro6syplEj?=
 =?us-ascii?Q?bTmiNxPsI+X81XjBWBOzPVOxijuqrvUWYD4yYf7/c2aLWPUy/bDc1j3vFKp6?=
 =?us-ascii?Q?GrNU0d5zBoIFFbVsLe3BSSmGYwhBZAUPNADISPVzEJxAqGw9tc13R5MKZOgt?=
 =?us-ascii?Q?YFy5iH3p3FByFU87CvDgFsjnd0kEDYhzgxXqLybiyNApbzC8m6huj7tZACvQ?=
 =?us-ascii?Q?IZ6HJlRdUUjgfNvgXPdPy9nOI8OenbQElkFe5WZxB6/E+uk0IAxC5VTOQBfd?=
 =?us-ascii?Q?DwoHKebVPEGvtTdpDOu6GCvY+V4z24gjSQHuIcIPbNub6Dj7yO6RpvlsFMiq?=
 =?us-ascii?Q?+9stYhZfF3IzK0LHDDj2HqThqqEweOHnu5AmDnUhVM6/wMh3Y2exNhiaeZdI?=
 =?us-ascii?Q?P96JUDXhPp8XXw50INP4FY2lmK1ppXKntt6Xua5eKy+1RWnu5KTdyZw0qp82?=
 =?us-ascii?Q?W1CDRT0wAaPYyoRyqjbhhl/qJpUzzMJkQtdjjb1P70EZwQgh5I9HdhhcDtNF?=
 =?us-ascii?Q?+Y5DaqvB6M+Ra/YR/bmH/oD18hcwJE/sWpRoTYnmYhZCuHFeuykaDZnEA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: IzFgGV0nj0zZEzr0Y/XBpEdF49bFfwRJlu9XZpum8R/clpk/JoB5D/RZYgVBr52c2b9/7r8Q3cLcz6iCUjonniO1TXVtwx6LCLY0eqYCN1B+UWrHoOpOJfbaVfozKWbjRRpZzRoWRMH+68jwnW5X5la79eTeRV+x1EBifVlAo4PoqbJUPBWbItVDXhC480WD
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;6:UMIaJSMO+HrUzXzo20w3fJFJbZP7Y4WTIjahzCoYMowpCYmXuyQhj/xcYM/TMN66U0Pbk1mMtqwL+f8ndwGIg+PcOKC3PoqhGH8Au22UlOtypIcpsB3YAMFBUwPyY8kJlHfJg4ml5ANAS8q5ZsbNV7PxjBRkB9e63kXR4cna+zR6twKE7Z3eEpk6Kc7FOZzliMlk/x4yxlsMauwwYsVL8bTrnO9BAKRGSxHeBSJLhvqTAmH9j44sCMFnelXb3a/+VLeZYfejfuYpEM7iIK6wD4KmQB8i6gypKiiNnZa6u+YxtudoxBvGZkCl3o7okGWOdMtDiEHVLeskKSiSllfkKWG8/Cdcqa1dUgtxCIrf4wbQ2CvgNrfFW9+XrC+zjx40FeGtwUYV1vrx2RBJX38RqqtO/VGzIeAIGS97pmAgPJJkUEG7ctFM6Q+NgxIQ6ZVC3dd6BwvCOMHt64gPfTz+nQ==;5:yI5cj2jlj7G0r8lpvG1NBRgn5d1ifJD++WslUUPieM4hiB6MfULNlfu+1BEO6DQsfVWJWetnHWxWc1g+VCDMWMtMVQN7d56tyXWRNAPv60//rZGKHngc92K4FXC8je8Cb9Eo4E88ETjbYfFmVNNpeqqo+0jun6XUisFvgNjUXC8=;24:FfyNF72Qv0qkBUDE/3Euqiz5lg6SZ+cu1YA+0zPpzQLVoAteSLARwEFpzu4C8ZSloE7DBmEgpTaQLPzdO97dMNq4H1yG0kNaj2G9SxgOUf4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0132;7:NSdnUWwhcDYFkrJHNFlE94gxokjsmBjXQK2szdWkuWZHTQr4cbB6CRaLg0vOGl+o3tpqZlJMSwc7sprCWEhcQbvHw/4BV5dnyXnySlRAIsSjKGOJ4zm9micBlwiXlY4Whk4zUELnlImm9sj/sp6Mwrpux4uItEdaPBCFh35vOLBV28XomLO2vhABRHgeNBlx2AItDlJJ6DXNaWHHWxxlJGiq5MgbC1R+wYlQV2MdaBN9gKNhASO/kpFBx6Kz/neV;20:4BERoN9lHbI1/qSUxFRh+DEu11UxUPCkvAAyFwTzxh/T92y8hAQ1YMRuByCiDogYGBNQeV58YJ0aZiojCDropRhsTzT49D5SlXDrLRBkSfOzFI8lzC4o9Ixp9KUxfQYEr0vhGcUIE0fVc3EhaIY4KJjgvPpBPsO0YhRym6kGFpC4A/uKH6VxQg5qUSkLuuoUpyY0wlEO1gOWobvDoNZw/oyrvWZTz7iJcnHYUoJX7rvCFm3knvZVW1YVNliOJG2z
X-MS-Office365-Filtering-Correlation-Id: 7fd3c9a7-3511-4591-bb04-08d5ac88940b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:48:13.0060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd3c9a7-3511-4591-bb04-08d5ac88940b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux currently provides function detect_extended_topology()
for parsing CPUID Fn0xB and derive CPU topology information.
Therefore, also call this function in AMD code path.

Please note that this series depend on the previously submitted
series:
  [PATCH v2 0/4] x86/CPU: Update AMD Last-Level-Cache Information 
  (https://lkml.org/lkml/2018/4/27/1112)

Thanks,
Suravee

Changes from v2 (https://lkml.org/lkml/2018/4/4/55)
  * 2/2: Fix typo in comment.

Suravee Suthikulpanit (2):
  x86/CPU: Modify detect_extended_topology() to return result
  x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available

 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/cpu/amd.c        | 11 ++++++++++-
 arch/x86/kernel/cpu/topology.c   |  8 ++++----
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.7.4
