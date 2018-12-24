Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3F2C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 04:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0FB21783
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 04:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="r3LgSaH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLXExq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 23:53:46 -0500
Received: from mail-eopbgr730095.outbound.protection.outlook.com ([40.107.73.95]:21136
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbeLXExp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 23:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GITXw0einPJKnlPg6IKgClsfjDSWU2ycL6qog8BB1yU=;
 b=r3LgSaH3m6Fo02cLjZFP8nZ2Dkf8HkxUBOp/KFPnK0nvK3EVIB/lT/oNyawipG5o7GmkwcFqQyeYMzX3VJDjaiQivBTxqsnFz8nqESyJ7/GnyKQEjRfMSKAspF0cslxa+FLp9zpTiDPcnpchoflU3GqudqQR+CcLJUJ31IqYYrw=
Received: from DM5PR0102CA0024.prod.exchangelabs.com (2603:10b6:4:9c::37) by
 BL0PR0102MB3315.prod.exchangelabs.com (2603:10b6:207:19::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.24; Mon, 24 Dec 2018 04:53:40 +0000
Received: from CO1NAM03FT042.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by DM5PR0102CA0024.outlook.office365.com
 (2603:10b6:4:9c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Mon, 24 Dec 2018 04:53:40 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT042.mail.protection.outlook.com (10.152.81.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Mon, 24 Dec 2018 04:53:39 +0000
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBO4rYcA020589
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Dec 2018 23:53:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C5447A4908; Sun, 23 Dec 2018 23:53:34 -0500 (EST)
Date:   Sun, 23 Dec 2018 23:53:34 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for 4.21-rc1
Message-ID: <20181224045334.GA20828@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(199004)(189003)(75432002)(486006)(8676002)(36756003)(26005)(126002)(476003)(2616005)(8936002)(50466002)(15650500001)(90966002)(336012)(186003)(551934003)(47776003)(4326008)(23676004)(103686004)(2486003)(33656002)(786003)(316002)(42186006)(4001150100001)(305945005)(36906005)(52956003)(54906003)(26826003)(2351001)(58126008)(6916009)(478600001)(88552002)(2870700001)(2906002)(5660300001)(1076003)(356004)(246002)(14444005)(6266002)(106002)(86362001)(575784001)(106466001)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR0102MB3315;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT042;1:ilZDdscy4vTFkasjkskUpdlK5jwZSMvzXBea2y9Ia6QN60Lze2AxTrIC5dovvrsF19CJhTo+PNBc8BlU/be2MM84pm3BcqWDEObMFPxGSTxybbRq9xGRttwbdRdG1aLt
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f128e58-1a88-49fd-6de8-08d6695bc586
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR0102MB3315;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR0102MB3315;3:2MiuYX8EzbbcFZLt8UOekKAi7KLNOA8dkvE1mMB3FY6vRuJaR+hW5+5UloDpfoS6MkpvlNZxEoO3JrsOmHj3E5TbfV6/hgLQgqsECN+6R3JOwZgo39Pjx2t9jcydiFjpFbq0Gq8XSJYtB2R+dECv6ghb1Jg3vatstrXrBiqOmIzPcrHudxdAOSKmyH9sH54o1ZVfZ+BPkquoB4UsBHQ+07aRrTcasx0hMYg2u7VMWr5EtoC+VnzoYvurDU/LKsR4qZcZMX4zOiRF7gC/7vZfjbY0pSxu5Glbaw2ipYc6wMcGTemubDXEZ6ALVKTffN61AygjilJG1uGrrLv3SrQZog==;25:ARzh4WToOd708ccYrWhCgT2DJYJIQmXo4xQKqS9mA1VyE1xUK6hQdpKdV2rvOzFYLhxzAF11S7TdEz/wUDefbDbhPJu0oMW5O/XHCu9BX6HRG2nIDzBCkM5rzTEi9aq7+55K1vPoN/x9ZIZNps98/IaoG2fMChju87GKrUx/rsMRDPh22nsFT10c83lGmBzwBhllDEkrURnXJWuHV7Ib7lxRai1WvYnjwza9ONurirKyhPxTkKs4MrkODIHE4l3kpmPUR0aE+cC1pPNudZuxdc8hNd9632FO27lr+TyXWLOLwglNEKFC2kHmgDe8BxQzKWT3vIWrIQT1ONl62N6mzA==;31:CmoDWh3DwZpokH+SqcjP3FYyw1atIXWbP4CFDVzr19uR1EVZtwxZ+ZJc3DhnwLx24FbZtWyo1vzoZkCy4zNTyq1Ow7m8zmMZ4xVkO9cACyjdqcXb09wU9+MriNyRduBNpkM5VXW5UraoQYitmulyxjrHqOExVNVm42xLuFREax8DkVwjo6h0UyNkAe3CUftHs3Tky+nbpYyc3Gm84W//Ipg4iH+PQHpdCeTbUMDm1wk=
X-MS-TrafficTypeDiagnostic: BL0PR0102MB3315:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR0102MB3315;20:VapRap0jEmkhK/Z5g+lu4Z8nhNe8oA2ot2HRny585wt0BJjSPLZ0zPsnIiD9YYPVpq5uy253OFLdJHIPRVYfgMyU5gRMdEs0YSuweKYK1zNwiCrK5KjK28ooyrgWePLP3PpmaZhsmuRC/PxQDOU3epcarcO0XeUYgadK77HxHWUjtgD4ZEU9/2NiBAS9WDmeQSXORSfvtfvYh8O3CSm3cJdi8f9c14q92AeevGyvtMQ+m81sk+36Tn47oczDAChwJujtk9uj+2yHlM2QKRwZx8ncGKN3AZy5kKJVmR06K1eTFN28lRrke38tVebJ7j0aT9LouO+CNEqqY73j6p3bl1VmJRSmmcuT7WwmjJnjZm8pfQBf6hml/AHFWyZQc2P+0HGVPZfM0ywpBJwpHp7HOyUfBpWhFM9B5EOmdCPsUjK55OqUoZuKHf5eilnNPUyhVlWCWN38pTCNk21Ni+T/wQPcY/Zdaoo4Rr+ewRdEm1Wi9taxj4DgMGsx1hVwRzOk;4:g5OtO/DJv6qu1tDJFmLCD/KuQb571HqoSP0CeZGReaVfqpbMzOVdEuWcdpmfFFREfOsk9XXtRNusOixyx4S++wS57A+GV4V783jJt+GJNM2M5eQz4AzcoX+CYCAizaqQHQGB/EbkkA/JRn6g/Vaj5hQGVv2jGOHtW05S3xPltuJVbqDnlgqf7f7aRSh9b5M7eNIh0gQLW6shLeEEeqMB6H4sshq5d6/vgruxwlUFsM5q1dsw5YPoHnUXlEH+19knXIySxIFTpe4jx1JJGuT4pQ==
X-Microsoft-Antispam-PRVS: <BL0PR0102MB33153283E294EDE2D1932ED4B5BB0@BL0PR0102MB3315.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(10201501046)(3002001)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR0102MB3315;BCL:0;PCL:0;RULEID:;SRVR:BL0PR0102MB3315;
X-Forefront-PRVS: 0896BFCE6C
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAxMDJNQjMzMTU7MjM6K2dFZjRaMkpDVEdhZ1RlNE0xWmxpR2ZM?=
 =?utf-8?B?Z1B2bXUvTTE4YWNhL2JDWXdLYWFSaWZlaS9ScFFPd0hmdEFHaE92RGZaM1lk?=
 =?utf-8?B?UllCUFR2RVYzeGJ3NFVPSmJPUUhkOHhnWmpIOWZhTHdyaGhVeUl2TmozbE92?=
 =?utf-8?B?WVdJZk9CZllZbTNDaGdxTFVZbHdFdVBrMnpYZERYV3I0UkNxSFV2eUpFSjZR?=
 =?utf-8?B?dGZHWjZKMlR3dXpHK2Flc1hyRFJ4MDFGWXZrN1RFYXYweVRLQm5ESCtMZW9J?=
 =?utf-8?B?SWg2Vml6VVJKTVRzRUNON2g4aWtNRCszMWczVW44bDNMWXBGdlpYVk5KOHVT?=
 =?utf-8?B?ZFUvTlA2VDllQmlVT3lTZ25CU01HdnMwKzNsUlBUSmN2cjdFcDJOaG01OFB0?=
 =?utf-8?B?Qml5WVVic3BuelJQZGRIS2VsR1piT1pBdEdQa0dheEpwWWFFU1pPbjBpdXEz?=
 =?utf-8?B?aEZWQzB0dFZ1NzZhaE5qMnVmVGpvSGx1cTg3NVIvV2NZbXhCYk1nMlpQSmJU?=
 =?utf-8?B?c1BxTldkbmpPQW9lS25ydmxEamlpSHBWaHh6di9ZMGJFdDZEdXFEby9pQlVo?=
 =?utf-8?B?V3VUQkE2eUs4dTI2VzJUQzZpTWxNTTJUWlp2RFJkNE05VG9rb1lLQzIxU3JD?=
 =?utf-8?B?emg1NHZkRldaMWpnKzJvandGVFFwb0xpbm5lbXNlaTZYNURvcHhuQUFnMGpu?=
 =?utf-8?B?TFUra0ttWlNFU1BEanhWOU1kUitVeFpZT3FRS2tzQkxMQkNCcGJJTXcvK3Uy?=
 =?utf-8?B?NTNzek1hVFNUbDVpdHZLcDBtRm5KWWttYnZjRnhpZktXcDJmOGZEWlYvajhh?=
 =?utf-8?B?SVdIMWkwcG5sMDVVbWUxanRYamlmY2RheXk1d0t3eXEvRjBicklOVlkrT3Nv?=
 =?utf-8?B?aDNvUG1waVFQSFdnMFgwVnNTcDEvbFhKM2VpRXI4dmNwL0FWZHpGbjZBYUFa?=
 =?utf-8?B?VnF2WHhINVZIeW03VkhJOStFZEVPY0tzOGxzT1p0WGFpVG9WbjJ0VXFkYXli?=
 =?utf-8?B?VGYxOVo1S3hRdlEyU1BoK2QrRExpMjdIV21CclpFNURXOGt0cVZKWStvbHZk?=
 =?utf-8?B?dUplRkFlNUY4S1NvWlFzclI5b213SEdEbGZ1NGpSMEgvL281VDJKNlBCU0RT?=
 =?utf-8?B?V0xsQmNUVVBuQUhodllZc1IrVCtIRVlwTWtYZ1ZRYkVqOGdDazFWdmhlTGt1?=
 =?utf-8?B?Z0J2MWtmaCtoVWNYMEh1L2tvTldLT0wzeUNkcThCLzA5Zi9ZY3lBaGdxMTZo?=
 =?utf-8?B?bTI4QlBIbXRqdlBxdng0Mk1sSkJJREtncGxMZkU1dEdvT3VwVlJUSnp1VUky?=
 =?utf-8?B?cDdOeTdQQytpU3c2bUV2UzgwM1VSckJhQlk4Zzh6aGZWYThjU212dCtZWnVu?=
 =?utf-8?B?YS8xQjFIeHg2di9qM2xWSnRMYnY5WTNwcjJPRUtGZW54SzlweUtXdVJjSE5K?=
 =?utf-8?B?UGhEQThFMk9SZmZXNTl6SU8vTE5tY1hvdTlzWnZmRjhhZ2xhQW16QWpDWThX?=
 =?utf-8?B?bmJJSFk2SklwWFR2YTkxZzh4V2sxVm5Dcjd1ZWJzd0RkQUJVRmI2MmovR1Vr?=
 =?utf-8?B?M0FsbGR2V21iZTBxanVZcjFETHR1T3BlbUtKVXhCcFlRaHEyOXVQT25Ecnow?=
 =?utf-8?B?TTdHTGFtcFFVYW8xQ0pQZ2ZQRUpNUUV0MStEOWtZR3ZyNU00ajBLU2p0NTZz?=
 =?utf-8?B?d24rQ3Nkdll2NnpTS0RTUCtnTDlOMGRnRjB5OHcvUlZiVnNhSTNHZ1pkK1Uw?=
 =?utf-8?B?WVFpbDYyUmVTVUQ5RDlSSU1nPT0=?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5nevtiW2pkeebvJ4JEqxilQSDaPZLUqcgXyCLQraMrZThvqGHzoPH2diqlAL3/f0o6wEESlxTHLy0JIjG6mlXOBd8ekilJKnSkBFIuZ6uxincBnf4DsRdsvxk/pNCyav4D71PdIRUmhBWSTLC6Om+0VNzfoPIo7ECQRtwfSdjaRS5GYtqHvRFhF9idbrNTAi9OxyWCOf1rmYOb8Eoaw0AUc/ehKEWaHXxIsH+9OEcGl24415RrhLvWsdCE7y3guCm/A4hDW3ZI+xeh5lzvsLdfGxhjnqwgSBf6mW8sMAgPWSdBU3UosleS1CbvqOzulo
X-Microsoft-Exchange-Diagnostics: 1;BL0PR0102MB3315;6:UiIo6d59VI5nDd9bN1gg8Ey15mGORAkjAP5yvIMAiuVm8gybdWNiF2f5S9YEccmXV2tCdKEWs/aTbLRRgfkwjTYAhX2t07HFJQP3zTh8Gkwgtbla20sv5MNtZ2RmQs9R/AWC18rSBfk/RCyGAoIY6LN9FS+D0Xe5I67wsqNnRmp5aJ7XR+DnA8q9qiWAB/l6y7k+IH7bs0LX1ADewWVoyx2R4Q+7juAk8ni6ZgQRtPixVVaaZiqvGkfJQC6h/6cvkNku7tvbcZ1sWyo0/Rz4GTTUJFFScVSpx2OhALQpuIvg2t4liMZLAhU+dPi3pTCvU6X3+O0k7euH4uymAJUy3ESX57d4u7cSTQEim8u8kdlklD7fAD78UOieQ0Vufb7yMNYXFP3tdYRsRozdNb1PJKvcUv57ExzIhiM4MBnPgYkzre88CYA9AUG3g/p7h03jpganHaL71+t8lymI2LP+tQ==;5:6wu8Tdo0hETSPqrZVFzFuedFdq+THClrSvqt/+61aB8oSe1T5b6oXRxRGh3QJCk4HckAzCgAnFqh6RR0Q08RExoddaf2ZA+aNxzGkVNiJhLfgrqFlttF9b8vyj1u5OBfvdm4syavTaYahw5Ho9kPSaAV8T+wj5CGbgl85amnOrk=;7:x1AfaeA6fdhW8j5UzH3LKQcVyIWsyLbObM0hxpJQOKQe8UQhngecooBmiu+GbLVXjtia+i4dSMa2NyYiIm4eIjPOxnyO1fK+BLsMBldtNdyc8LwVZxom8hQ6FfjJA8d5D88Cfg6sMG8RKPJLNTuO9A==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2018 04:53:39.2303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f128e58-1a88-49fd-6de8-08d6695bc586
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus

for you to fetch changes up to 18f2c4fcebf2582f96cbd5f2238f4f354a0e4847:

  ext4: check for shutdown and r/o file system in ext4_write_inode() (2018-12-19 14:36:58 -0500)

----------------------------------------------------------------
All cleanups and bug fixes; most notably, fix some problems discovered
in ext4's NFS support, and fix an ioctl (EXT4_IOC_GROUP_ADD) used by
old versions of e2fsprogs which we accidentally broke a while back.
Also fixed some error paths in ext4's quota and inline data support.
Finally, improve tail latency in jbd2's commit code.

----------------------------------------------------------------
Alexander Lochmann (1):
      jbd2: update locking documentation for transaction_t

Chengguang Xu (2):
      ext4: remove redundant condition check
      ext4: compare old and new mode before setting update_mode flag

Colin Ian King (2):
      ext4: clean up indentation issues, remove extraneous tabs
      jbd2: clean up indentation issue, replace spaces with tab

Eric Sandeen (1):
      ext4: hard fail dax mount on unsupported devices

Jan Kara (1):
      jbd2: avoid long hold times of j_state_lock while committing a transaction

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Pan Bian (1):
      ext4: fix possible use after free in ext4_quota_enable

Theodore Ts'o (5):
      ext4: add ext4_sb_bread() to disambiguate ENOMEM cases
      ext4: include terminating u32 in size of xattr entries when expanding inodes
      ext4: avoid declaring fs inconsistent due to invalid file handles
      ext4: force inode writes when nfsd calls commit_metadata()
      ext4: check for shutdown and r/o file system in ext4_write_inode()

ruippan (潘睿) (1):
      ext4: fix EXT4_IOC_GROUP_ADD ioctl

 fs/ext4/acl.c               |  3 +-
 fs/ext4/ext4.h              | 17 ++++++++-
 fs/ext4/ialloc.c            |  2 +-
 fs/ext4/inline.c            |  5 ++-
 fs/ext4/inode.c             | 63 +++++++++++++++++++++----------
 fs/ext4/ioctl.c             |  2 +-
 fs/ext4/migrate.c           | 48 ++++++++++++------------
 fs/ext4/namei.c             |  4 +-
 fs/ext4/resize.c            | 79 +++++++++++++++++++--------------------
 fs/ext4/super.c             | 92 ++++++++++++++++++++++++++++------------------
 fs/ext4/xattr.c             | 83 ++++++++++++++++++++---------------------
 fs/jbd2/commit.c            |  3 ++
 fs/jbd2/transaction.c       | 45 ++++++++++++++++++++---
 include/linux/jbd2.h        |  7 ++--
 include/trace/events/ext4.h | 20 ++++++++++
 15 files changed, 296 insertions(+), 177 deletions(-)
