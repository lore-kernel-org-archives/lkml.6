Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D819C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C52F2085A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="Gtdwe5v2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfAFNjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:39:52 -0500
Received: from mail-eopbgr680118.outbound.protection.outlook.com ([40.107.68.118]:39782
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbfAFNjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6I1Pkil/oa5rbm56wwlh29gZ9vsl1WTvi0EtAsOCO4=;
 b=Gtdwe5v2hNtvSFMcqG0iiinWishmyjCQR9Xp6CGd+B62XcjVUfO6H+nkUy5Du0BPG4MT4BpBKatgD3UF9f8t9hg2JTQ6fgYN7rz4w1P5ZjMFacuKZevFEtTXCv1ISfM2LvHC5lIae539SHKr57ThDmAGj2M+hDsIAj0V5zc3xUc=
Received: from DM5PR0102CA0008.prod.exchangelabs.com (2603:10b6:4:9c::21) by
 BL0PR01MB4018.prod.exchangelabs.com (2603:10b6:208:41::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.7; Sun, 6 Jan 2019 13:39:46 +0000
Received: from DM3NAM03FT025.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::209) by DM5PR0102CA0008.outlook.office365.com
 (2603:10b6:4:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Sun, 6 Jan 2019 13:39:45 +0000
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 DM3NAM03FT025.mail.protection.outlook.com (10.152.82.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Sun, 6 Jan 2019 13:39:45 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x06Ddh2M032266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Jan 2019 08:39:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5CF2A7A4BEE; Sun,  6 Jan 2019 08:39:43 -0500 (EST)
Date:   Sun, 6 Jan 2019 08:39:43 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ext4 bug fixes for 4.21
Message-ID: <20190106133943.GA10099@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(189003)(199004)(14444005)(86362001)(575784001)(356004)(52956003)(54906003)(16586007)(2616005)(476003)(126002)(58126008)(42186006)(6266002)(36756003)(46406003)(23726003)(106466001)(1076003)(90966002)(2906002)(97756001)(305945005)(6916009)(88552002)(103686004)(26826003)(4326008)(33656002)(246002)(478600001)(8676002)(336012)(8936002)(106002)(36906005)(47776003)(786003)(316002)(486006)(6346003)(50466002)(26005)(186003)(75432002)(5660300001)(4001150100001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR01MB4018;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT025;1:OakKh6rChqbHvUF4t5s4a3/Gz949MjVW/vznEgv0+dPjaurYZP/ovW7/yYGKQQF1WymDJYuLNmgGMVaWE/Fvq1x5TvHpZBPJYHimNYee47d6JcaMeeRiVd4Idtz7jnmf
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c1d7a9e-3b63-4103-a71c-08d673dc6bc3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR01MB4018;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR01MB4018;3:K+0z2eURQsEI37xVqA2CGQsnHchEoNUaARBoSEMDuHKr6GBSSKZL1GpWlArt1LFYuzyqVDcbAJHeQrgYu4HYMqtwkvGPwVNb/AcdZ/eMUYPHQUyiT4WUHgaog+U0JzjP+qBpFnbmIcMg6iMwq4Q1vvrw94OZEG+TL5nM7gNiXIikfZnx1GzbFmHTjkFu7mEEVX3lr/42/KQqlclNpkHp54V/90Z1L7VCJYaFjlB3YpOsBGLQFYdFxF8iXjBmyHtHzEXNHmyDvQdkTLhzCkwEHLCDFF6KNB8YSN3WU7vEFEO7tHzQZmINmNS2BVvm2+mlHcB3iG3ZBCGN9AVIiqmUJYqcKM901qOTIRV/CQvxJhQMddJR3g5iX+Z0ya3XwI2m;25:jqzhaTU00LoStouPM/Xw1c0A4lKgLQ3cUm/0xaiLGpai86sJb8yANja88vwn6Z62Oi4Nsh2vMDkCz2kNxN/pzcJziRxERbSr/l0SlX6J4WN7duBC/kJ3wxnyAwxPVGPu/mKb84pF2HiyoggaEL+Q7Xk2veZArwNYJdji7ULrjC/xZi+WxSREAQFkHRdQUt6VRy7OwxEetnFRHtZaIO+5HxiTlH3a22eEwRUN8qqkrkAgKII4CA+4JvUDdJRCDZmL2ha5q4LwpoMSOFZf5VFKu3wkJyxhDbbwfo//iioShFEdXVZWwBwzd3JqIMGHTaAOkPdI4awSUFuVf5G5tqQPsg==
X-MS-TrafficTypeDiagnostic: BL0PR01MB4018:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR01MB4018;31:u/3JYLkj0N0gUgz3spfWNwuq++iKKbdK4rqIPQh92EF5DgRkv8ZNNDzGLB0nSLYt0xEyC2Ig0fiOR5bwV+/6s6IO8DOkX09zxhcb/j2G7xWRw4Wkx8dkbg1rePGkm4aDMsa/ZkQTKELnofPdFn3ZmMP/vKD6qB+axfiNlhRTwP9copmzFd691GW317U1ZEowdTOvHF6neee+1JKj9HO7rp7apKoWrZrcquKFaps5NSY=;20:IFvKXvGA91BAIAf3x3pqJj8g+rsyDQqE4u2CBytjW0RfBDBErFcDNVJ8pUkRFU8pWbRijK+Frz1OP9S3nc8OPdg9eHFl/SToImgg1ZAfIJ5LZo3leT/u7+vWCHkAmQTOlAljUY6SV06Z8nMBBLIPURRsPaKe083IJv13mY4l0iIAt6hQ8BjoGaVuLCwSgFEhsTStp49dtzLax4Z0nX96Byi+ow8NM5WqBroKrM21wNqDdwq9llfNa7BYvniWPsbP5WHo0dnoyqrB4SOhqu6XMw6h81PjpeTb845FvnOGjjp0IeWiowuz6doBYwNa/y8hXFapTF8rjeqQSvk1Vaan28wYWR9XacVGj8W0wMBAGfMQO/aoSS7qlmFAsbFPzQimmmfYG7Z6Gez+VLnxTsPW+xNKHk3l55wqxMGe+pcij7G520avRrayJws/tl7FThl+C4sZ5/BVZoFTb8y/aVQ1+D225AFx6/UT1M68yYNo7MV16YEJttTdl0yThRwJEyIt
X-Microsoft-Antispam-PRVS: <BL0PR01MB401877146D279C7048A49DB9B5880@BL0PR01MB4018.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93004095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR01MB4018;BCL:0;PCL:0;RULEID:;SRVR:BL0PR01MB4018;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR01MB4018;4:rtcNgfNWXk4hv/3ZFKkZC4lG1ifTg3+pQJE9T2GMJCHoLKW0WtH9DPO3K32jQtnTqfKYTmYJ0BvE8XtuMBAAH1k7pL6Xk7IEdvx3BBeBqHl2Uhczbp18zzI2r42jMHAiDsb9jqb6JI505KVK9QHQpZ8ceFFQ4xgkFQ7kv4j7t9D/dBoR5piGeDfo9KcNSUOKP0gPcvrvoZ68kWRYS1LkerZ0RBMr0ocWMwF9r7RkdzKq90O0Jlu4FBwIjJUnX2McD+OFczJcYbyMf5uR/kjtVtMkujxqYJIFdVemWCWk+iM=
X-Forefront-PRVS: 09090B6B69
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR01MB4018;23:0JzzVWWOxyp4JALj6ljIkyXuypKSF1XReG/JJ0yy9?=
 =?us-ascii?Q?W7arx7GGy8z3d6ZJECzZ2OZgQ/3EeDoShXbvbXCZNf+IbQv+hEAqnx04grZL?=
 =?us-ascii?Q?POQaskd36VHpOBfKKosJE8LyImjuov1lfIkATWrJ9cLCnlXpVrxPtGrrv1ly?=
 =?us-ascii?Q?tBh4jjcRSoVygmzslOsrKThhG6o54mS0s5qfZKTO9tc+GFEKlBt8YVEY2pEj?=
 =?us-ascii?Q?SgZWu2Q6WZ9lo37vQo7FpDDhbMTBhluugttWYAygfc8RPwbKg2ySgtW09LZO?=
 =?us-ascii?Q?WVHiWgfIlz0azafV6L7685Fk3Q3eH0h5NE6cJsQHbbD/BP+sYtegd1j8MhYZ?=
 =?us-ascii?Q?ntRpA0oEMpYsbXpPM4rTO8pzF2GIiKEMoOK0m7WHku7SFVeKOlokdliPn4rn?=
 =?us-ascii?Q?LWZ9Cghf6oKqhxbU6luYsYjMfD4EHyMM5Z7IINMshLXW9Rq7R/ZoZ3d37JHe?=
 =?us-ascii?Q?/xXFgAF4epMD4TAeuS4IkKf0nFkNCH0ltkqIG6arrjIY5DYIACa+4eqzL9B7?=
 =?us-ascii?Q?NHdoJOaeW50PebRYGRPocYzpKtWFcEtz/TmEyVyhvhKCAZKAgQnQPnh5Lkho?=
 =?us-ascii?Q?L8u1QO+BHPaWoLGeSN9IR7tDVRq4E16DnM1wEPLVM1jRIe3GV8LBaEtLektb?=
 =?us-ascii?Q?DymIgohJv0W9h4Hf22i9nZdh0cM37pW5KOzFUvmOzW/9sHxTSVcAmNvjdNfb?=
 =?us-ascii?Q?ziiESSONBrmuVglt+Ro+NJ2F5SxgIi9WPMzVfqzSWGYFI4GS/Orb2T5OUXOh?=
 =?us-ascii?Q?00RWI6mBvJfhbqQoAy86VKbZ2KdJ6zArcuC1NJW8XiMD+qyIG9ws4bluTY9I?=
 =?us-ascii?Q?fxnZJHFPj0oql8lJoPqU1sPaHHNioguUrYLMeyKmI5Am8rPZj05sKaT7mFrS?=
 =?us-ascii?Q?8BoVDlCgm3eoQiC8u487+bzW+QJplZgbCPqWPRoJibH02T1BbKY/cUUU5U9m?=
 =?us-ascii?Q?uRdIGv7ngAi+pJSP4U+R2kRxIJxFBr+OJZCJbvHbEUo/acFswnjWEnmWD/co?=
 =?us-ascii?Q?7AjRdZmRklOprOF21HZYgxvAdn1h0/HE7wPrwppuVBWtJk3UVpzPRfR8c5HO?=
 =?us-ascii?Q?Lry415u5OIL16sxHZow8uSdyyFj8K8H8z0Z+L0fbXx0WcuDcWbvnI4jiboZ1?=
 =?us-ascii?Q?XbnjHe4OW3Qr2N1ejOhOfIdcSqWpnrG2SW9YzoCBNy5M9FvBg+kDbcq+zRHT?=
 =?us-ascii?Q?oMXRAieeapBGLSMeWo2JL5kvECk04rDWf/jwQDT3IFtFvrlewuyE1gMqg=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: mW7R0PZ2xgWzVfwMGvpA6g/5R78s3DWcJ7MQ2fCjokFF71NhtKBGsoO4YAhjYECqM7j4MoQ0f5YOR7vzeta1iWEC2fGJEVtn+qqOCNBuC+QkTbbp9QNfqSLeLePMECdnCQ0XT6v/jTlnDRnnfmqWqk7NqlF22pSf2+LfiXeAEk0E+y7y1jmTylUrqYgksMS6mkgV0v4XuTiBJ3ORjdXYnn3HjBBGlqmkkkNtsAzrCXKiq6wtN3laIrVRMRPCN0tNNPYXCbfqPUaIjnmbFR/+9WV/K5JXRbVHbOfTsnMuudc1BHDfQqw47j5o1pkJkLCp
X-Microsoft-Exchange-Diagnostics: 1;BL0PR01MB4018;6:GYMXyfs70ZPU2jHUjSx3WK/MkxX0Z+cWmPgQgOGb06a8Rn0BOR/D+CVhwrtQgXal1TvcNd/fAG8xlYjdU8bO2JvVOhD7OVt43nC8goa3DiggH+ITD59DENnByZBEdJx0alXysl8wF2kzncHigA0etQAPIsMHtaNIskD1BREmn9FcuCGowyZjpcU7gDzVCzqQ5tY/nyosfj2z27+mw7JY5NjmBphcWD5LGSm9y3H/f777zSr+SeNiDwbkO0scI7G4NEIfCTns+2jtXVL9GiMytDYCirR1ulEF+LBBX1/ur2cDPOqLDAiOYw6ag7QCZ84+6y8mj1cLAIQDYBt7ep2GETaNdYBPiUSbTxjbWtJHh0F26/8gu/y9v76FjrbXDkiHgru+6N1PE2stMvApWvNXfBZfAXR1eemqWiHjljZ5xpDUZyJR3BEyBn8cAXva9XfAXVLP7exHrqvR7+LvMVMzFQ==;5:xfbjSccrC6amleZu+G5S5Sc38RKIJ/qd7ZWeqeDagrMR8pQgTIxtZa2ByvKLomIUZS4mytU998M4XCDKE4N79G8doFLZD0F3qC31emM15GWaZzSEoLdDDeAhjZYH1kdJg2HYxIgdi/SN3ZCC2JdEfgJ6vABqrKgk3EBp8Xx5zMpo7zqdIAAPQ7JcXJyM/FyBMFoNWOWj2CkNQsFeg6fJag==;7:F3mYKoJoXo/Y+EAMjketygomxv9h9T2OBWriMc0nqdeZulvKDftVf9pjeE2Y02GtIaw7dKry/z98cpLujBFASuSN+q0SRcrOOvOmCmMM7xa90LklfTqnx/eTZgYBFE5cqqrqjFkp1CI2whAOAzNRAw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2019 13:39:45.3737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1d7a9e-3b63-4103-a71c-08d673dc6bc3
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 18f2c4fcebf2582f96cbd5f2238f4f354a0e4847:

  ext4: check for shutdown and r/o file system in ext4_write_inode() (2018-12-19 14:36:58 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 191ce17876c9367819c4b0a25b503c0f6d9054d8:

  ext4: fix special inode number checks in __ext4_iget() (2018-12-31 22:34:31 -0500)

----------------------------------------------------------------
Fix a number of ext4 bugs.

----------------------------------------------------------------
Theodore Ts'o (6):
      ext4: make sure enough credits are reserved for dioread_nolock writes
      ext4: fix a potential fiemap/page fault deadlock w/ inline_data
      ext4: avoid kernel warning when writing the superblock to a dead device
      ext4: use ext4_write_inode() when fsyncing w/o a journal
      ext4: track writeback errors using the generic tracking infrastructure
      ext4: fix special inode number checks in __ext4_iget()

 fs/ext4/fsync.c  | 16 ++++++++++++----
 fs/ext4/inline.c |  6 +++---
 fs/ext4/inode.c  |  5 +++--
 fs/ext4/super.c  |  2 +-
 4 files changed, 19 insertions(+), 10 deletions(-)
