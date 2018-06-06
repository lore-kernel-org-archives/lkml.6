Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0pWhOEdDGFt3WwAAmS7hNA
	; Wed, 06 Jun 2018 20:25:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CA1CE6089E; Wed,  6 Jun 2018 20:25:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="S6wl98rK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1E93860290;
	Wed,  6 Jun 2018 20:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E93860290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeFFUZl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 16:25:41 -0400
Received: from mail-ve1eur01on0088.outbound.protection.outlook.com ([104.47.1.88]:27728
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752047AbeFFUZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 16:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jzrmt1Cc+9IJZH4kbltCAckiI/tDcDqvfsC+gfoNEKk=;
 b=S6wl98rKoI0QX+t8E3oOEaDE1nmv3hjSRYmONwGR2qExbCvavJvBPKeqzunrCl5F9Is+iCTHWZ4HvRi4KjgJbO+SBl62xom93H6tL5iWWoXJUTu3sZy2qfPbOJ/nwTR9p0TpqPUjGYKkiP5NXfvQMr2MbzNlamIWeJeNgR93WC8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com;
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4461.eurprd05.prod.outlook.com (2603:10a6:803:43::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Wed, 6 Jun 2018 20:25:35 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fQezo-0003FL-Hq; Wed, 06 Jun 2018 14:25:28 -0600
Date: Wed, 6 Jun 2018 14:25:28 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] clang-format: Set IndentWrappedFunctionNames false
Message-ID: <20180606202528.GX2233@mellanox.com>
References: <20180606201556.GA10832@ziepe.ca>
 <22cb30ea19ad4ab1b341836c5f672ba406cb2b4e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22cb30ea19ad4ab1b341836c5f672ba406cb2b4e.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: LNXP265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::17) To VI1PR05MB4461.eurprd05.prod.outlook.com
 (2603:10a6:803:43::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;3:K+adgdchBRCfhUBf/0ZpKIB4r5os0n5c7SKCSWTIxSSd4YF85f0EjhKVaOG48L1DjHbHn6g2xU2iyOrSgPVdzWU6Hyk+1WXQCvnOfn6Iz8bmU3cOracU+FjSCM+70MyjsrqnjvJF3d+jrWJ7hX76JP+1pGRLUpgtlTZ17FY/MZ2d5mAIULA3I0Bl3IxaOJ4fLHP1jU66LVBTXmDy2dP2EWX5QgaotXTmapeUSSZEhKDIz/j8x2ZTm+lvEh4lUkhb;25:oIXvsHC1ThHUH8VYkYMsPS+/X0+laP5+35auUGyWXcPPCnnLrVAx5Dfnw1vEpOhh4YUS0azvtLwfd9Zhw5AfwZrIhJeeiiAPgg1W4d24Ft8sO53J6bcVEbkclNnSxnIKLvDIacOxOtM9DvFuM6+BxFcCG3skhDa85lzc498qWaxJqkaGM8MBDJpoMOk8ciiwlHlcjxZDohthDJrg8bIqhSbwmhm57LfuX6C1uGTSsWroL2ECjaE77DJDYdXLFBWgD9gqvFYI8Al/GTL8oc8RWGd8mU4RL1xJVWdLeUgrrCrtYDnRjsqeZKBQZRS9xV4OpwDLrw1psryG+7wQn5erYg==;31:layxyzGe2ONyvXQrqFP4y31ha0NSsFW7XoOgK5t05U3dxQcDyP8GJNhEkRHhBwYMKrLTpqE98vi0i6saaNUy3oDibnYULu5VY5s3uHcRMioxYF8tYtn9X2RYzKoqowQ0YpkbYfqNW597e6vAVty+xbFQYVb5XH39KUk/yk4T06XLxVwuVw1406W6nmata2gp80q7NKI4fsQpDzEWhwqc+9ffAgBh3i7uCVdhZk0ydDk=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4461:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;20:eBidUWpGWNgt7qJObdohudFk4/aNd5Rtpg76HJf0/p2Hc1E0irqVSDQ8z6Jz+RRSylNiAzuorLusLh3WZu7BpxswzoxTLlqFTlQc3UCNbfaUyhcb3SVZ/1kKuTnrRlYmh+g5UGSfMtjGXHQGc4+cFBEgAqZykrKZyETqDvmGUnOkZqMYzJ/4pS5wVWTLcPGGInudGuK99yDd0Ui1SPe3pn+B6cq1rilOFVeguEWMbQsZC/1dFx16oP1dlYsqHFJpu6WuicbpQKnMqyX/ItpDASJntpL6vCUsrLCdqTVvScZRqP5c+iXryeIHDKa+GC8nu7DfLL3W0Rni57Bof2dOknhcRsvG8SsESwATdDjsPIsHV4QX8LaQ3gkQQARt1feAYzNNlrqPyWmoyIkzmK7VbPBXZ8SJcavlqUKGd+QDEJMT82J9/PPjAYJ871l5mL+a8cBiFuFCmlTgC9DKzfV2W3OoZmpVEkQHI0DvX1NQ2ba/vbXCyUQ0tAEypjjVkttZ;4:MoPnCBarF3ojxk7G/r3qJzIa+b+37eL/BMs+nkYnv3s5iuT/60EmRWNLSt7V6PAr3S+U6JB1L/lB/mkNJ2R4x6WPqn27EJukC7hItIpmKCdMBxfe3eN7Oi8dYWW1R0G/h2NDgfGrRTEg4nsa2uGKTWi1ZMhJ1sKiY2BgbcIGwBX6zk1zveBeeZXn7L2f1e3LzcO09v7cUtLzZgka5YS0EhLPoVk9KupKTo2qBLJoEEep+x+F0I/sr0SLeyqGUDwRYJeVD54txXX7FmDv3t87+Q==
X-Microsoft-Antispam-PRVS: <VI1PR05MB44616726157975E4D3115BDFCF650@VI1PR05MB4461.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4461;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(69596002)(66066001)(6246003)(122856001)(316002)(9746002)(86362001)(26005)(229853002)(36756003)(9786002)(76176011)(5660300001)(57986006)(4326008)(446003)(97736004)(305945005)(39060400002)(16586007)(81156014)(476003)(106356001)(105586002)(486006)(33656002)(58126008)(50466002)(81166006)(53936002)(478600001)(23726003)(11346002)(8676002)(386003)(2906002)(8936002)(6916009)(186003)(52116002)(46656002)(47776003)(83796002)(54906003)(6116002)(3846002)(7736002)(1076002)(2616005)(68736007)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4461;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4461;23:RuuZ/HkVYZPnukqdjYdu/Q84JVmFccIsStQ0tLnSa?=
 =?us-ascii?Q?QqqxHHNazYWsI3viuiZg3LdsasPzpyf2GFqKF+hEcGonK2xDjzAI1ScMOduF?=
 =?us-ascii?Q?p7E8RvEdLXUfxajOEHAWg1OT6P1c4o9kJhOYyLbBqU9IDxMViiFlAixoPSv/?=
 =?us-ascii?Q?NeNlwGl7v2u06Yko1ZF2xc4/dRbS9F4jM61FqI3E6huHy8IS94q0zclqF4Js?=
 =?us-ascii?Q?bGEZCM4FZPlR58Ldn7OeHnWBbHq5BOYhc08faKhDaqiOywPCe56qsggH2nRD?=
 =?us-ascii?Q?2Ex0VgllLGjj+qK2YBHoLGt7HbonPFKpBl2+ZJuaIRPLrNrPuPdjVJlgnwnp?=
 =?us-ascii?Q?re3R33SN6kfjgvBINev8pB6w3bk7022zDFY0eAVobwr9UjSqVkCxNSqnSkRF?=
 =?us-ascii?Q?b4Y0qCWjTXMjxkUBXfgPrrHt52pz7FacKSRbtF/TcAeWa0I6ILNozxDqoPJv?=
 =?us-ascii?Q?5rFJhjLdgqCuoOt1xTdmEliNm/R2tBjg5vhPnn93ZaPmWrC2TGSNxuIjlQbQ?=
 =?us-ascii?Q?lH5IGAUlbAPQVGiGt6zOlFK9QspSuFwTnzzcopHISLpDmJRiaH8ASLBRFZWS?=
 =?us-ascii?Q?Kt/oM3tqpRDUdCvBJVXHiofErS0yWXOjIsejDVULgGm+R7WEtvp3KnI1ahQF?=
 =?us-ascii?Q?q8B/npZG40maSSDeR+V1IhVILo6sctT3bzLhprYmol2/U0YwQFBCf768xfXB?=
 =?us-ascii?Q?gnoNBIqvZgxx9ZdxSg2gmDmEbKBOhQvlozlnNam9PMcd4TKkTH4ZXaT5q/Z7?=
 =?us-ascii?Q?wrOODfBAfBEyToAINrH/Vj1YwkFJC4eYjg2+WT3mpHhL1gcM4Wu/YOuxtXG9?=
 =?us-ascii?Q?7bwrZNxd1Y5f4TsJcqAI5LXX36eWUFdwLi54DxeYihJa197tmJfIr2yF+us4?=
 =?us-ascii?Q?EqzzzaJbSsaq49bis12QkN1AGXNMuZ2HarGFeMAkeEiRH43EQX3ZgQ6uPSXo?=
 =?us-ascii?Q?mRcCclXDLs4zBsVqGhSCXHMRR+r00b48sNa25+QA3hKEJcxFwcL5prn/e6qy?=
 =?us-ascii?Q?LR0fNmEczcqPktnfBfkHLVRqWOGv/bebKclmV9GiBscFsEOINCAkWLbwAXI4?=
 =?us-ascii?Q?72MSmj4T8AWTUrdFfr29QsJnYAT0nIzm9i6Yb/U3Wx+fU3d/KH69QrWsB7P5?=
 =?us-ascii?Q?kKYncLcOgoqPTYug7u8YSRKn4n4cULFbV9wxVowyEWGuP0yytImpzY3B8vKR?=
 =?us-ascii?Q?clXHHp41w7o1aBz1TdhGe2efacRGfJcKco5eVNxFmDsCxCwu7HkgIruWvyR2?=
 =?us-ascii?Q?yKhlsib9NJTw6tIvbhXRGYpza3h7BF4ky84NDqm0lE8XhjchXZ8t7HVRpgqx?=
 =?us-ascii?Q?BtTehiqAnOnALBbmJJhOEm8mP+gl41r6N0yzD9PBDWN0ImhhU5DvFR8XmIc8?=
 =?us-ascii?Q?EK07zeGYWitsBrq9LtHoyxNbOw=3D?=
X-Microsoft-Antispam-Message-Info: OF5osxuCOlTEPHvUlIqTKt/DiT1K1uiH7tGkM7wHdMQDErO1tW/kGLbJM2cGApEqGKVTkawQfcbY8BKTjv1igtP4fEQm5cd4TZlU59Oadfw2+CX7Codqc0jJ5fa7TJu7S4z+/GsNOv81H3i72zcGByxDtm5mUw4AfThtLlOYDQ6KSVKI7ZxMjHaBTjc6X0cR
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;6:0loZ4L7ZrrvX88exsRzo1EgzWM4SZh/V5DjVwd2e4Sww1PUbvr9lwcdKZi9gbnO8nQzQ0w0qr8bgm3JiiQc0o+ChU4C974Gbw+AQswxSSswJLR5PYU+rlClyznn17QGwE1knvhg0zpBTFujanhZgkOqfWiUfsuFJl7qzgNviqhiKO40tMAeAOm4bKSvvJ9wuP/BM/ODG01/r/aRUWomyCFBEjX2kO81Bbx1zNBjLQTAtIu87qLvDWtKKyfQuKc8FN8pf/ScqQJltR8/n7PT+JyJY8MTM2tOxUeo5KJjgLbBbhR/2yQ7FlGLlKmbl01QIzjhSiVhM1N5iA2cl1dntu4jtTllBTo1zk9uket+SqDtnxrz/U95P1hwib19ukOAnLlyEJx9Ifvwoh/LdbwHIDwLKdYytBjHChhm4h/vBLaib0DrYWuYWosxW0JOIyG5ccNatMl2fYXf7+9v1JyNHJg==;5:HfDG4Hl63VWVsv1hBGWOIesErCz1JlnIDXUeVB7EWHzYEehSNDTbWUDMH63MUbAT8i/CxHDX/CaRO7OB4HMdCHEsToT1hEhG5Ovf5FDXvulUOu/1psI2amA9/zCiaNP3VoUhjWKePOxOJMes1NTurlvs4l3OiCOXxl6ycV0n6+M=;24:OxKwtkfsmUeA5BdPwfUaVeL8u3xSdlbDs+IJcCQGpVnLyZ5VUpG7G1gkmUpgk1VcumkCvcBHun/f6VV+zSBubrp7XaqMAdSqlml4OLKpHIY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;7:BcIPxCrpKMIgcnNSy9GdhMyCdA46OncKIyjAjNJV+zRO+oNJAATzkVAirJEaoC7WmZ+03U3KRDLIfNMnZ2vQZJNq6BsHV+sotLv6F6Gcz0JisA3cFPkh2vsnGq/3jtin/RcIvWonFe5/6Ua0uyXw318NYSaeRfa0ynGpUDI/o/SiQNQrhp4fv/l37F8a1iY/o9714xiGK0/rRPFn4+lrZGuEOAD0Xv9cJ6O8SsUd8w624mA3F/XFPqh18Bvdes32
X-MS-Office365-Filtering-Correlation-Id: 0ae98d68-c788-4bd9-e84a-08d5cbeba8ec
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 20:25:35.2803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae98d68-c788-4bd9-e84a-08d5cbeba8ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 01:18:59PM -0700, Joe Perches wrote:
> On Wed, 2018-06-06 at 14:15 -0600, Jason Gunthorpe wrote:
> > The true option causes this indenting for functions:
> > 
> > static struct something_very_very_long *
> >     function(void *arg)
> > {
> > 
> > While a quick survey suggests that the usual Linux fallback is the GNU
> > style:
> > 
> > static struct something_very_very_long *
> > function(void *arg)
> > 
> []
> > AFAIK the above describes the more common choice in the code base?
> > 
> > Not sure who's tree this is supposed to go through.. Andrew I guess?
> 
> I believe so yes.
> 
> I expect there will be more refinements to .clang-formata
> as perhaps more people experiment with it too.
> 
> Acked-by: Joe Perches <joe@perches.com>

Thanks Joe,

I saw your note in the original mailing-list thread and just wanted to
say the way I use clang-format is editor based.

I have a hotkey that triggers clang-format to reformat the current
statement, or current hi-lighted region. If I don't like it, then
'undo' puts it all back for manual adjustment..

This way I am selective of where I apply it, and I find it is
something like 95% of the time good, IHMO.

Big time saver for wrapping long lines, moving code around (eg
indent,de-indent) and other mundane daily tasks.

Cheers,
Jason
