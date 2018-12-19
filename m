Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8938C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471BD218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="flcXG1Gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbeLSRTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:19:20 -0500
Received: from mail-eopbgr710085.outbound.protection.outlook.com ([40.107.71.85]:2112
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLSRTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKFyYWEzEZgUbnzw3sHmqqupY2vyGJm0LnRqWben14o=;
 b=flcXG1GuHHFVdXUos9oi1jQT6ZX3RSeFVvgruQpBmuLTU++/o8+d0EFaj3oTQ4nfTMFWlbRp8XMh913IPhQiAmmQou4I9M+KLjUwuMo5tx0Yzam8c2Wb6vXCFWIwjK8F6BzP8wuc9QyJurdng5MzdT/sB7QQpehnaO9IvsEQEzo=
Received: from MWHPR02CA0046.namprd02.prod.outlook.com (2603:10b6:301:60::35)
 by SN6PR02MB5232.namprd02.prod.outlook.com (2603:10b6:805:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.19; Wed, 19 Dec
 2018 17:19:16 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR02CA0046.outlook.office365.com
 (2603:10b6:301:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Wed, 19 Dec 2018 17:19:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Wed, 19 Dec 2018 17:19:15 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51177 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfV4-0003mf-UO; Wed, 19 Dec 2018 09:19:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfUz-0002l3-RF; Wed, 19 Dec 2018 09:19:09 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBJHJ6iG030256;
        Wed, 19 Dec 2018 09:19:06 -0800
Received: from [172.23.29.77] (helo=xhdyacto-vnc1.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <maruthi.srinivas.bayyavarapu@xilinx.com>)
        id 1gZfUv-0002k9-Jk; Wed, 19 Dec 2018 09:19:06 -0800
From:   Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] add Xilinx audio formatter driver
Date:   Wed, 19 Dec 2018 22:49:06 +0530
Message-ID: <1545239949-112845-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(136003)(2980300002)(199004)(189003)(5660300001)(7696005)(8936002)(356004)(336012)(81166006)(81156014)(7416002)(8676002)(63266004)(36386004)(2201001)(106466001)(106002)(50226002)(51416003)(2906002)(2616005)(48376002)(50466002)(186003)(39060400002)(476003)(110136005)(478600001)(36756003)(426003)(77096007)(316002)(47776003)(9786002)(16586007)(26005)(126002)(486006)(305945005)(107986001)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5232;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT031;1:DszXVlYkRtWjAtIITtlPK4VSKD8wxeJFxTm1Ip++L6OYCZpGBH3vGiLz8uocVK4PR7MyXw5debyi0CAdmZ/iBoHxqCMgrqLE/YsXwHhhu5IQxoFmd28aJninBKbqD5aN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5794eadd-fc27-4b55-c108-08d665d61a3f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5232;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5232;3:lFEEhAwANr4RqQw/tGYh2ZfxbFCgRZGqU54mgrZvm/CB0otHNXTEfgOPrmt0kV3pxFt9o2BLWmF295ukaJ45iOOHNAsqbUdxvhGQxlPT6ux3K293Sr7Dmn2wgGkTccwUaGLWn3mVWYeB+Hysek5jA2gGx8XOJ+cGmGH0GmF5b35FxUhx3s0/tyOcRnTcxMfeV8sa3u9x1R1tM/CC1sRZKz04hoKo5FeIjInMG09Tv32FlcwGVNQZVJaakiKTY9ppZIC/IS7n+PBoZTryPTX4pH85LCC0g8suQlU/1hJy+xLw5pJrX6TN1YyC+Ndn4OjcV6yre/UUwfSlG3lj4CJdWc55uh/1CwARVM+8cgePIDA=;25:tt0v9nNyraZxHmfyZ/x9udKCkQZD5ddsl0MbJUS1kmFA9DvYR9vzbM2alBLH3B8w1MEnrdZp0WOK1JzY7kSy/WSYWONKOyPFx3muk3TLE+ViOcSfeY+U/XQ3S9St7/OWUfqB0G4IyUrFRLHKlWfZnvpg8eWvhu56Bj5Pxu9sk6hOyyAXKiQktWtC4ddOrwpAnc80CnKegFLYiiuydemlRYFpFhjhA7RPyK/CbPKjLTfPWMlBv1xUxFIKA7Gp9mB7quwDnFhjX3lDn5osEBBsG40K4emheKSdaaL9UNGaOnQNnkk99rIaseiC2WmqZ/DGw4nuvIk9to2ws8kR+9U2uQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5232:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5232;31:5TK5vesUYNbgbOz9gTkSjwgzxxGH4RrlIusDJFDRdyzTbGUN2j3pkZA05NSsHFHUMpr+tzaZhehU6WGEdhqxcKH1fceqq9XRZnF+ME/eK6qZ4SNisHO/5MhBM8KeSdB0kLHw4zn9WxZBhOUVuekxq5XPg4uInT8lvO+fkLo2unx7MFkg4CBZS6C1bPIIoLiIDajbMEbtez7xu/kS5rR05//WAEnK/8qIKpHSY9oH6uU=;20:9ncZV8AB3AdP5Qz3L/fq1F1p83fiW/0337NjX+3Wh/veSubYc+bMyRseN6F07lARNcojr58BXYOMGYLByES2f3zBrhSteQ+J8AmUOcseSD24+f4/cvSS3KGzg/BHhtlAwUMgjJkahzBa1LcO1ZKIGkXF+bNk1Tpylx1OpjpeDi+KeeYREwLWL3Q6IemRvqQIXEOHEeIatkU6+QVr8ULqvadQenkbh5LvtDZ6WOMM6zfK8hEmEz7K0vnKJ7yjB7jee3i+UjO/inE4ZgLzeKWXqxDsEkEQV0eZKPOJ/x8VpVotFRSdM3zBcVKRJtH6ujsfQ9wkKrXfdRSxBvDJjLM/7Liu0NsGSeVGQ3a/eQtmQaxpwgEj/8TWpFimz0EPwbS/eUmpQ3D7s7wDxRWf4meWzvbrSr9PliP3QaHYkxsyt9NtY8xEMEMa1hmuP48uM8RqI3Y5s9kwIp85WU9/pA746V+hk4OaZmqcnmlQ837/m49sv5jRjErGRmC1M2N3Dwme
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB5232BA01F6D11C97706526B3BABE0@SN6PR02MB5232.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR02MB5232;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5232;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5232;4:1ibl3Ghk52CDa1fPMKHTEjmJ+hNApL1gL+SW7fuic5I7/YPG/rHLr6ZAVpWdFHe01M1E1jKls25egqt9pM8tCZJ5RnEZRBc1aU0EKw9iibTWb3air0/CuzDo0nqHbJNig1uWGzDQjzAAr1CtOSpODd3pam1pA+gmB0Otq4/cZpp8/PSIuKCXbhIEYX8Q5FiT4ROVKQWW40Lajm5xI/KWJutUWWH/kCeanvkF81T0+17wm/pJKfldNqRvDzlJ8J7YqWZqiwgsPZIw5B9GC7jyog==
X-Forefront-PRVS: 0891BC3F3D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5232;23:xsHpZY0MACr3uFmFZy4n+MIQw6u1RCG0C3pZxFwBZ?=
 =?us-ascii?Q?4MnDRuZ61ILyb+bmeZVZ63hcOG7SoIAenkx9XqW+saq+smNrjKbki+uiCSRK?=
 =?us-ascii?Q?9uBOW1vo/y5z2c/tRr6rwcUrm95YF7HCZVzUW1HcMpp0nfeid0+4Z770fk0Q?=
 =?us-ascii?Q?0g5R6RxArayPa7x7oN3JGNon3WB3cYI7laYqSV1kb89PR3XOmmbd8grgMaR6?=
 =?us-ascii?Q?EIZEdx1p9TYhE7mAjh6wp60j9m2YmE+z9nKaf7T71NgWSfsQH039jhIn9o+U?=
 =?us-ascii?Q?HSjxqcKbBfmunkP47CeM4CPkwE7QzwG/k1QBqXP3vn5fqpq9dnY0/VrfRML4?=
 =?us-ascii?Q?BxC2AWXvF+mbnlrPjBQXVEA8nokIS1p6tclq1gokVEtD0IiPMvHywl9SJb4W?=
 =?us-ascii?Q?NPt+NgeUiMmyq+qIONR8jeg6yQmspUGKQeEi9zJLM+QlY529kKdJNBmF/eMR?=
 =?us-ascii?Q?uzjQ3vN2nzOip+XhfnfD2429OrIKfxG0oM3GIWqkrgyQT9VoeLETjVmfW47A?=
 =?us-ascii?Q?C1rmQLqQHq0T5pdS01RYZwdfIX+2PPmokOf+MDrv25tk5YG7QF9H1vfHOJZn?=
 =?us-ascii?Q?5ZaSvuiYuFBUhIle3z63+Rv+NiF4DZ59HKaU3l6Dfxkpj/HbPLdkNLqztcot?=
 =?us-ascii?Q?TqeKWeshfyzE2Roe0L+QzKdhhD/Ln55DDqcpbfY57RpbrTJs5N12O2tst4Hq?=
 =?us-ascii?Q?wDhgVWtVoaVVLpZrIYk0Gcf5CYac+SERjACh1ZlsNzI2Sf2fioF/N6qK5HR9?=
 =?us-ascii?Q?OngPaRxgTIGKOcK6BBraAf7ewk000Fq483zcygLuy1sCpHo8Oo8zwsJY1JPO?=
 =?us-ascii?Q?TetTEur2B8bFuMdKgDAzsYWdGulSecjvV+fGkeaOZZmtSW4f1IOhJkQfUC6K?=
 =?us-ascii?Q?IGyqp0P2jr9IoYdvFzoTISF9iwIH2/v/Yts7f7dDMV1/kNaxyKBnqn5wez6g?=
 =?us-ascii?Q?p8g0ruKFGm+guYH4pok+/x6KH+wi3logM1rGZmeS+FHZqmayV9p469CBIf1s?=
 =?us-ascii?Q?Ng9QALzaL5gtDavZHmunhPyLZCyoP9c7wnVGomt0Z0BrxQPRBasVNz/Gfois?=
 =?us-ascii?Q?+xvjyWiCZfqksJzIKgobTvUbxWU?=
X-Microsoft-Antispam-Message-Info: bHHEyr78ssRciYYLT0RFfXUtlUZSb3jL1HoQQIu6FMJ/MSvoMCsX5wTfNYfmJYaoPfqmQK4B5H6KhBmiPPXLij80MewKoJQmnu4WdwC0etreHoGyyehsRNruugzQ/3Sb+r0pNRLrfxrP76XXOFD+fWuhTM3W3shBURaWTbifCDG0IZR3rUqNuhm5JWie2Nww0PdoJeQygRvDAQ+SdDordTPdaszOy+81C8hYyENyh4KQmv4nz2BySA6UfNnPlLQyvNnwpgQCFUBKIXVGSVuJ7atDp4Tn4/ydDHbIAiHGnlcZOxjcD6lXg6ownWhN4MY2
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5232;6:zDk6cqoEDBCO/kq/Nb3g6cwjvSePOmT6A6IlyvYYOAeG0YnRr4Q6dsezWXoUn+fj5LqMhxjFKHfyQUPm+8bpczLbEfSJlulRNmjnvyjXKfoLD5GaTg8JZAVvVqmEWOlGBVa4hNZPZq4w/RqDdfRh34sou1SQ0VB82mfvVt3Pfc97I0kId54vG7YBszkMYp4F30AimD9s7aPSnh7OGgLIChoRkN7ufyfyCX1VXBhx0bvnOxqquNtUT1K3YNC95P0eICbH3I9BjpX2JYcc1ETansLduNd1x7tGZc1eHB2ZFwYU2VxfduFO7ZJEBak1H1oS+QkKC3AmlBbCiJLORSI1AXnDM6r7onJnVd6vDn02t/izQvIVxsiVxlT+OVGhtoMox8zEC9OnpUh9n0i82KQD1/hNTSGTP0t9CyV5wTyipi7zRiXufM143JY59WRZqtrCEpfnkH/cdS7Sbre3fgDhpQ==;5:+/8izxtiADtOW78t9a8bucdAHUrDtKCREjLH7Dc+wzO2BkV6fzv4q/tgk0ehHpShb+tmewRJFlMz8ll0HyxQpM8qjt5Ee+5kmKm3k/8utVklJzmjFMsGSQ6nci+n3pPNMF2oztSYLQCSTRnU6+qvuR2Iq97CbVpF0SExswAZUPg=;7:uxWqiZaCKVbvKlzV5ZicGqPJ/t+k3H4BnHuNzcPTSlBhD9ystS72Ei+QC6Io76737mpPOYU0QOU4LltV9Hm/E9vQdQrpvR5LxIANqwim1n0Po9EZeX7S/yKVqqlckUbkTIO/mtzklu8BGzOtmjCqjw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2018 17:19:15.3546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5794eadd-fc27-4b55-c108-08d665d61a3f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio formatter IP supports two streaming interfaces - MM2S for playback
and S2MM for capture. The driver enables DMA functionality for both the interfaces.
Patchset includes devicetree bindings documentation, driver and build enablement.

Maruthi Srinivas Bayyavarapu (3):
  dt-bindings: ASoC: xlnx,audio-formatter: Document audio formatter
    bindings
  ASoC: xlnx: add pcm formatter platform driver
  ASoC: xlnx: enable audio formatter driver build

 .../bindings/sound/xlnx,audio-formatter.txt        |  29 ++
 sound/soc/xilinx/Kconfig                           |   7 +
 sound/soc/xilinx/Makefile                          |   2 +
 sound/soc/xilinx/xlnx_formatter_pcm.c              | 561 +++++++++++++++++++++
 4 files changed, 599 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c

-- 
2.7.4

