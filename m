Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD8CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB1820882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="AznNn7eL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB1820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeGILB1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:01:27 -0400
Received: from mail-db5eur01on0126.outbound.protection.outlook.com ([104.47.2.126]:1632
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932427AbeGILBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppOEhQCoxdGBcIdTXJM//dHQZIy7UEociU3v+S4cOd4=;
 b=AznNn7eLHDWXggH13R1WYRNJ0lsFSvFN4CYdvTmsQn8Zxq67BVKzNnvVT/OQXMU7+AQVJordhLeAcao9p1B3wQAM0Ah4AZtJuEiDa/gxOfGKelzXTCMiXCZ/p/6o7UXvwez3wG/WW/iARemFgprt4IrsN6n+yxGhRlkJWjOlAxI=
Received: from VI1PR07CA0121.eurprd07.prod.outlook.com
 (2a01:111:e400:7a52::47) by VI1PR07MB1279.eurprd07.prod.outlook.com
 (2a01:111:e400:5a02::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.12; Mon, 9 Jul
 2018 11:01:22 +0000
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::202) by VI1PR07CA0121.outlook.office365.com
 (2a01:111:e400:7a52::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.7 via Frontend
 Transport; Mon, 9 Jul 2018 11:01:22 +0000
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 VE1EUR03FT043.mail.protection.outlook.com (10.152.19.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.16 via Frontend Transport; Mon, 9 Jul 2018 11:01:21 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w69B04oJ010759
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jul 2018 14:00:04 +0300
Received: from my-server.emea.nsn-net.net ([10.21.14.139])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w69B04gk010697;
        Mon, 9 Jul 2018 14:00:04 +0300
X-HPESVCS-Source-Ip: 10.21.14.139
From:   Janne Huttunen <janne.huttunen@nokia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Janne Huttunen <janne.huttunen@nokia.com>
Subject: [PATCH v2] perf script python: Fix dict reference counting
Date:   Mon, 9 Jul 2018 13:59:50 +0300
Message-ID: <1531133990-17485-1-git-send-email-janne.huttunen@nokia.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <20180709094159.GA7615@krava>
References: <20180709094159.GA7615@krava>
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(438002)(199004)(189003)(2906002)(6916009)(6666003)(2351001)(478600001)(54906003)(4326008)(48376002)(336012)(16586007)(86362001)(5024004)(5660300001)(107886003)(53936002)(50226002)(106002)(44832011)(106466001)(2616005)(305945005)(26005)(76176011)(97736004)(81156014)(81166006)(6346003)(8936002)(47776003)(51416003)(8676002)(356003)(316002)(26826003)(68736007)(22756006)(36756003)(11346002)(77096007)(476003)(446003)(50466002)(126002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1279;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT043;1:ua+QfReM6r034QaH/C5IB6A90YXb3I8a1r7MwnSfpEpj/NGv0+tadsGKya5kSOzzPbNZto10JTgMPLHVg1OtvA4HD713NsViiysjXRPehtACP4JnzlsPK4WPCE3DBy4Y
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39591a7e-6303-4142-328c-08d5e58b4e90
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(2017052603328);SRVR:VI1PR07MB1279;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1279;3:G8RNZgjix5leslKo3Smdyp74y54XzfVnpCswacCVzlVz6fDHED5ILY4/JFxkLktcYI2kgSMV2exM64nK9CaoXgxtYTTUVO5Yw4uqYfGfbRmqpGj1yM5VBuGjZ4KPdQCFyCYMS7axDalwTes1yFLWEOvqqH4J2wskTsxNb1VI+h+mkFgOzztX4c573WpXkTC7YEybQrsi5Zoe+aFyK75p/61tND5bPZd35CpN1hee4BoQ5lq4ayvNAt6emqNsQrdMkglhgF8G8ugilMOsHcPALvjelH6cwiUyhfYrYVTbZbG0FkCgRoCwF8A+QYRuq0puw3Fq6RjfHH0qHoFynjvMGxcCpwBQ/FjEw67JguGGdPczzW2//qTXbm58S1mXHSW8D6H7+XZc62G2uKKZVZRLsg==;25:PoAooOG829fqxtm2VhojFf0JZZqOh5HTPH/GcJ/GQcrJ62caieN/3IAUYTO37pZqu+dTRribcb2WcwtNYlv+CZrQP8J5VIzOEtRmyo6/oCYdLIqe4lzIE/zTOkSOSWh8JnKbXOiT9pNHwHri4boo9j9CaBMBKusapph8aYYi9coEJTONkfHZViHo4YOqVKeCNgTnurtfDcJQ5hGAz7jIqZO4TIqOMtJJARKgXaAVxVhcFo1d6tqZgm1GxBvfGDGmwiuMZZy5atI+4GYSdajPcIdEuhtT0Z0qlSifPtLOPgTmM4LjZdbThemRSByiujH109kFQXnswYm8DEQsDQdHjA==
X-MS-TrafficTypeDiagnostic: VI1PR07MB1279:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1279;31:kTJuT5ss7KUG1mFOwy9UYgfH9QdaA02VDuHntP8eP8WRepfFZjZAOBvIrOmRgCzrKh2IbtIbHH/vxAWtOrpJw7g/oJcMdQcGIv7Pbzcu2JhUUOazJoQzUQFeQgC8ABSxhmM7/C2TIY2fRtZTODpLDbCUjd0zrQvKAW6s1Xd0gorP+TJn9qxjLD3BwcEo53DUvgJzLVTHfCbwAaHFNQsZeezyUFX6sVOxx5EGLKN/Ow4=;20:gzVdO+WAU+eS0k3BnvBX2H/Ut4/bwhCQoyfiffHYuXvcu+8B4EGBYo9qWlse1HSlAe6NqdJyQrnywX8+xuUg8IP8MBeLSN3FazWosyvQGVWbKcHleHI/ZgOl1J49Z0c5FlIcdNGBQB3sFoclDvhtaAQhs4nADaq3a5QGQSx3EylIwctkSE9/4T60KdUN3b+juHWjwIiVhfYNP/AwbRTERlAwZB3FkbwP15sshXROZLJZ7VUTkQHgbSjesqCys1iY0EIvMZumjsCdmV+FL2riIfJt4V7h+FCzBL8p1IhVtX5h8gENH1jsPgUUgkOeXwfPbNadYQ8LI1KvYDt4Lrp4wOZH1f90kYBE3x+NcGDzl+cEOvlUEtP5NpUKPylbxsDaHd/Ft31ub33d35kdnm1fUUv3FC5C/R9RIImjIz6x6yqe2SpLpuBbLxlfFXgikx6VkGe8HYdqM8kipmGZJK3q0TPXEcHnOWLJhEGYpw5aU/TPQ9brk9cBtW7GjhtPOKN/rHEC/aQFSLVzu9oo0yIZLlRKU/s3U0eIB43PGrSnewk1fJDZ58+VpXfyrjfwkPBeqjK7vHsvj+v/0r807DMaRp5AF2jfFb/JtARUGXPCwgA=
X-Microsoft-Antispam-PRVS: <VI1PR07MB1279846C0CB4D1B33F1B6C6B9A440@VI1PR07MB1279.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(806099)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR07MB1279;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1279;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1279;4:UdfbFmpN9Bwtrf4U4+woXhODrc6jSNJZjVirlUEq78QIl5HyOQp5RrX8WEOzrGCghWWGVg9kDNCWDK8BKTOQkhyJx4wd5pRi0yLWfTpkprLzgojtrfp9nAZBNg0PleiIpCWf1jrgCcyJM2D6M7zDV7G1XrA3D6b1GaiDMG69Px7YdeLsKcmqaUjPWJEJVnkwAPyFsXBUgcJq7AAwKNzpjWjgqDcfBCLdh3j/vmE/EHHzmgf1q+WtP1eoqRT1OlU72zVtUYaE6shUH5wuDiRIxH7qKO6O+Hf36im9mcwO/UIcKvFIkRrX4khHESjWhMoJZ4nDFO0psy+yCDpntZPeZ4tkygCBLjd/M6+HFu26KQM=
X-Forefront-PRVS: 07283408BE
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1279;23:3tswoPV0TwUsEsCtGMn+7LqMbfjOXcWSscZsTmehy?=
 =?us-ascii?Q?Tu82mbqAgj62qTpe3gslvG3PCiHej5T1P7dGbLNrkcv3pIL3IYk7MRwFXqea?=
 =?us-ascii?Q?GrRgG8WDDyxaQo8MBIkWqHW89MGUOeJ1iQZTzI8O4FtmZsHzXSOz2Ovy3OTu?=
 =?us-ascii?Q?hH9fplKUtYnkdm+FFzwOPk+lv9HAPxbWBJQZauWkeDVbkFGSdtHqtdvYlHEz?=
 =?us-ascii?Q?Q/NSgxxh/EVZUeufRXv8oXpC9WWf3QQ+o51e5qGxw3J77LZ0ROPCFjF0QbT2?=
 =?us-ascii?Q?9WAJUuPOXOaLFBO4RdyunVwcOD+wGxSBt4EPvzxFw0rf2ws4gkiE+mAzbE+a?=
 =?us-ascii?Q?UaHgoMoNQEIZXKYD2JT1JZlGsGI16AjaWYmQWxyCCTEgpWkj7+mW7LjIYzde?=
 =?us-ascii?Q?1CzryMLaoCZxVM8u25PN/vzpaSdPaWpJ+S4W8EBjLjgmLn2HqnJRfPUviF4i?=
 =?us-ascii?Q?nWuxQw6Q6L5EtmzPYTkfbenZiNtJ8aKxF6TtzEyo/0ptAWoT0j8D8wpmacLc?=
 =?us-ascii?Q?iZXBvuBEkGLMUohkrDvfAi0MObBmFmPH4Hvn1BRNyy5vfp50JV2MM1KX3col?=
 =?us-ascii?Q?8vV1hn+nj+7VwQhVbL+TmnpTe5KhHJ6J4vthvWmcR+0xBL4rmqH5WSKAvGKL?=
 =?us-ascii?Q?3wlZVAkkUj6PwL6tzURGyC5kqyUHJmxVrnezVhexmlu00Eiz05vX7viQtQ/6?=
 =?us-ascii?Q?vkzR7vX9eElXcYZN7JBoIAnpozoUs/3yauWtdQIUbWkNI83rnjhXlzogpdB7?=
 =?us-ascii?Q?u4ifdy4/DxuuFfgGU4FmBWYLrF2ft9Oc/mJZxeY8yLkY+NVlw5jV1ECDvTpz?=
 =?us-ascii?Q?uqeJAPkZnWyNtMq9SvYf+2Gm8tCrGyR0w2ZcVc9H0B+0gQGxX0DarWE+I3bE?=
 =?us-ascii?Q?WWqcRAs0fWk2YSve6eDDykc+atLxdsXhhwXWn7j+f69zHCBpcMew0oB8xkb9?=
 =?us-ascii?Q?YV5JZBTxi8obp0jDBhTP1r/mXWy3WHUZU5VJsWDH4FPOYyvWjE1FxRhwRzP8?=
 =?us-ascii?Q?OAIoiWPtN6ULdgqdrAgygFPFZvGzW+oCBqpSLNRBLKjZFjY3hLvQBjtBy5rg?=
 =?us-ascii?Q?nbKAXTu8PFGFArosxyBipMaD1LnIRYYzTxpJ4fc+25K8YLyPLAvgxJk8LcwF?=
 =?us-ascii?Q?F25alAteE0Dh9IqvYz7uwTK+bV/mYIjKrzR6uhk5+SYpuzWfe1uGUV9IkXx0?=
 =?us-ascii?Q?pxSMf01A6iz31I=3D?=
X-Microsoft-Antispam-Message-Info: gHq+klX7aLvuV1BzoDCGRFQZ4kWqpkuTaMOY/VzUCovzgMwB3QaZK2vdmLltfbfQZsOFL0hnq2ghploDHtllptw0Mq8iKNvCK15Qzi8Tjw/uN03qSzD1mBP4PQf/WjR2zWY56sfrye5vH0nunrlEDspIHNLCLeesNCp0KYP78vnV9f7YbkS7BM0iCzCOBq4DGfhKznF6WheYxcmrKWy91wlHxXvA1K9R2yPei9J6LPHCwuAqmdsLsbZ990hEIZykII/pmMjpma2Ca8g1/aW4i4CFlDYGeKs6dC9Wz2P5Alk6Pv6uhpPQ7+gWlvZgXbHzhxRDheitLe8oiuCYH6qJYZ6OtSId/Q2Eq4eGQAvI7ZyGBXjX/YdsGrFH4u7cmedRF1hegWbRowphnljbuyDSXo5vnCRiNlKGCZlcBC26XIpDW3CyerQg/yhmhfOvyWIE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1279;6:zBqy1zrmT/tYJiv5Ux718trkzPCccfsIycPkw77lvPUMRsmpXgarl3R24FY1+28nCEMZ28pzEICon1vkb/L/dq0ZjXW/c86BrSMb0Ub816R9NNjvbg5ev/WBE4/mgRVRpXJ6f/F8dbOmL+zw0RQc/FMb7OEGre9x8/0fGjc7VHNn5r6kuEFEGo3oQYUb7/yagavDnmAf6wdWa25vxWvNMwNdMKlXIASixmCKQCmbHHsV/SMJcUTXRO6U6oWIR4UJWuksWpLP2XbpRX6qAjVP/5CC5bP1p5HtmlqNdFlc7uLqdx/+II+7KEtFPETR8LjiqpWXbYNey2j2WnqrZuYBr45eYB69KshNrH5JdkHpd3ZFfp8n0lOsDrPbHTINcVZrbIHAnNwWwe5hA+WbCt4Mh1TSql+3zsW3FmJCuOyCJ9hcmHhFtwRx8s2C3t8hOVWYUZLv23VhBzmba6ijHay/xg==;5:RK7TuB0wsWD9l4+pQv79fQw9mOTUhcVpkpEtBY9+98M8HiyxyAXzULV3SgweQQbZsHBD6uY53W5tFPNSXQKRIKcgT1+w/Cm0XLgJTkEh0mXoUqJQ/tAUXVCXZetQvioy2GIg+1/inHD1RBQpRPTe2CCpRT/fwnDLRzGeRmsVnJI=;24:zj34MF+ofRwDEGTZdskrru9E67/83+NhAZK8jOj8KGo2oATLSn9G0JCUHC87qbkCtSXgxCBU2NPf6w9W8/8tY/QkivMJFqyK7AFQPwJ/DNU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1279;7:CRqm5zMFkjxjzkuGimq2y/B1t4J8zr9UU4JA9Tk7SvB6U6APlH9TyQ3iCZhz7FO6rX/G4N67K7KkY8oVHd+giiKlbf7tB44noYUDSh4UNAiia4bltVkCPDX7EHGhQs4FaIbjBKCzpfGEx8oLBNYJ/FHBaufdQxbdkvkqzD/pqpEACfN0gDhIOarjtTeBwQgRbEKCcF4QcMfJga+KkHtqHAU0LvUHN89dpDfOEqdwotxEbyRUuJ38c1DmSaBSYcqy
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 11:01:21.9549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39591a7e-6303-4142-328c-08d5e58b4e90
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dictionaries are attached to the parameter tuple that steals
the references and takes care of releasing them when appropriate.
The code should not decrement the reference counts explicitly.
E.g. if libpython has been built with reference debugging enabled,
the superfluous DECREFs will trigger this error when running perf
script:

  Fatal Python error: Objects/tupleobject.c:238 object at
  0x7f10f2041b40 has negative ref count -1
  Aborted (core dumped)

If the reference debugging is not enabled, the superfluous DECREFs
might cause the dict objects to be silently released while they are
still in use. This may trigger various other assertions or just
cause perf crashes and/or weird and unexpected data changes in the
stored Python objects.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 46e9e19..60fce44 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	if (_PyTuple_Resize(&t, n) == -1)
 		Py_FatalError("error resizing Python tuple");
 
-	if (!dict) {
+	if (!dict)
 		call_object(handler, t, handler_name);
-	} else {
+	else
 		call_object(handler, t, default_handler_name);
-		Py_DECREF(dict);
-	}
 
-	Py_XDECREF(all_entries_dict);
 	Py_DECREF(t);
 }
 
@@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
 
 	call_object(handler, t, handler_name);
 
-	Py_DECREF(dict);
 	Py_DECREF(t);
 }
 
-- 
2.5.5

