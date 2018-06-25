Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA1CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC57522432
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HymNE5ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC57522432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934683AbeFYWoq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:44:46 -0400
Received: from mail-he1eur01on0059.outbound.protection.outlook.com ([104.47.0.59]:8390
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933521AbeFYWol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqSLvX6vlq9DXlKvglwf/6cjDXdrvygG+DhBO9TmIjA=;
 b=HymNE5jazNFIHt4+HDge+YtgnviGDrt8Zx5HW9uREg39335hbT3wlrOFWi1kejGsoFS2mQlebypJpbLD8WX9JS5INwqYPByKb/u8e35+u8U4+gDtIZYMejdooawX7AvNUi2yX0YCAcfHXNvEAsH6boPMV+DY5YZU3SleNvvDTV4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM6PR05MB4456.eurprd05.prod.outlook.com (2603:10a6:209:43::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Mon, 25 Jun 2018 22:44:37 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fXaDm-0008Ma-Nq; Mon, 25 Jun 2018 16:44:30 -0600
Date:   Mon, 25 Jun 2018 16:44:30 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RESEND] clang-format: Set IndentWrappedFunctionNames false
Message-ID: <20180625224430.GA31554@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4e::36) To AM6PR05MB4456.eurprd05.prod.outlook.com
 (2603:10a6:209:43::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02a93e91-08a4-477f-3b63-08d5daed3b3f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB4456;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;3:XhkK7RH252IigL0ggMxyLzpwQKpPC9y1n0atKmDiJ/YdlpZyKEEyf+2AnCbHZlHWysDh/5lGPhv9Eg6LyF9oIlzUgM/Ha8ycOy9U9wgaD/EGe+Rg4PXAdTKDcn+i0PLSqhIEMFUH2bNPEmlQibmUUM7WnyT0VWfYGTcFSybgirMo0mFuYR1E69XaGC2ZrwTM8QaJJ5bs0WX5PANdWGYwNbQmd+8yYaL8fonE1JE/HssTCB1pZLbh+7lX3paCX96q;25:v0uOWdkEHTD880VZUeXMTTO97HNrnQGLWdK0Gbvtm/+uS+DFt/6RtJywyEXutYCSdCzXwYbv+K0hz0dgaRG6zBt/3F3QLmn+7pF2u+ptZeaXOAcEZ0/eJ5X7H5DRtcWhN5XRJ4rjps7xiATA4E8XFICunoqNPuHs1DLLsJSpV5EOLx9JdipbnMaDgGwRXzT0zQjbjCUjHiGoJIpszgCSVEJ23x3BWwHvr3mofKko65c6LPgI9e3WopK8JOe6UDrvnv7KdmSUenRHBzU8zCGz+O5HuBk9sMgXqlttWypXL4CdmMVHoTSKRW4WZEvW+zgV2K+L2kGSNk+NCS81glRo9w==;31:0GeTFWY4vV10diOKrNiPlBpvZ+x9hSDDvpJWOE5JCfjjEEoJwZDX9gnXTb8uyShLA+cBDVVz+Zs77jtgV9j7j6HdjSrjtJupvObmmdmUbCu1u4pgMoLah+p5m8uRX7z1j+ALikLT+CJJt4WPlFD/iN1uJyOxC0mKA9pzjuxGOwCFn88USuWy6MpstKALaR3hEKFKEWIYva/ZK6ctogVwtahzsab2diKOa41yADtu+9w=
X-MS-TrafficTypeDiagnostic: AM6PR05MB4456:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;20:Fi6CsE6o0W32BjPo0XVL8kPAvqtEIlVvOK9s8MFZ8a5RtMY/gVnD180SYqD4lYuXHWjhcrv0d1rUI7nbgSEJuMSXvMH4FxHZWnWrUsPBCDmgbUU4m8dpG3ibdk5bwZtSmAD7RwB1DeC7MKTDpHpHuqKkq9utYmJWK0PhtNtRqOT3qq7M0S5Ke2AC9ZX2HlFg0D2MR1Mw0q/oVrPzceXaUlluGsqab+S7jqSFsTpHeLMFQqXfb1aY1Ll2HzSnxj3bh+UTI8ZZubFH4viFJm8k6gB+6vClEmvy+keLj2ozYv5baO8p5WfjIo4lxSbdky8QJey/Hw83VjStBbiSyYEd/nn5SZr6+oIU5P6tO4wFKm6nJXFfu27Cw7WZzaVLt3vUysto7SpFN8LV1e0+yZ6l8doQZaxi/lPxibX25/ZVgpO8FdHBMH+WmjFNl9RrG5TpBg/0nHtc0NbFUhHX8dm9jldjK9Aq4h65R6OtpNrx47pZ8hH0gzbgZjo7kroY2XYk;4:X5owq3tvNu0rKwBsUhZcaPqYO73a72rouI9YAwNhnKFzgCMKgeo9qBGAOh8bpmSbeQfrve4IbxjyUUvrXiW/RMIajSuPXWeeQ7lV0pOJsELv6bxqSVcfCEQCPynC0pYJ3n7UehXyq+X8MKwoA9+vc16C17F1g6xHOhVHpGhA9wdhJaiX3J+wBL7xOhVKynQa0V3gToZSFdITwXYHmOXJXDl63ub0k0h4OcLsjvrv3KejUKDGzmCaGK4M38Iwrn0Jf3fmnyzYRlUs8rfH7hiscA==
X-Microsoft-Antispam-PRVS: <AM6PR05MB4456E549D49FED3B50926DBFCF4A0@AM6PR05MB4456.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM6PR05MB4456;BCL:0;PCL:0;RULEID:;SRVR:AM6PR05MB4456;
X-Forefront-PRVS: 0714841678
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(199004)(189003)(16586007)(316002)(36756003)(105586002)(50466002)(97736004)(54906003)(110136005)(478600001)(58126008)(2906002)(8936002)(81166006)(575784001)(86362001)(9686003)(1076002)(6116002)(3846002)(8676002)(81156014)(106356001)(23726003)(122856001)(7736002)(305945005)(46656002)(26005)(66066001)(69596002)(57986006)(53936002)(386003)(9786002)(186003)(9746002)(486006)(476003)(68736007)(33896004)(5660300001)(83796002)(4326008)(33656002)(47776003)(52116002)(39060400002)(14444005)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4456;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR05MB4456;23:xviTDTzBJanqdwMTsuzaEkxYkdpyTS6qyN6gGuYZp?=
 =?us-ascii?Q?hyDjMhTY1qznaD7AWOWx9EJatXVgJD47mXRQlbXOiSP613jgO6MA80QrD3QK?=
 =?us-ascii?Q?Mn7r6Cpt9ZliiZEJmEul+5QiRr1LKBof9V2yH9E7vlH7eEfC+ky1RTFQZPYO?=
 =?us-ascii?Q?6ipu0dLHg6gpC2voB4yJlUiSuQe9CIUBLGZQwfw/eknbxGYE+5EjrugxTJCu?=
 =?us-ascii?Q?GNuOtwVBTex4f5JUrrcIP1Vf8jNt5/AII3AT1+e+cjVc4OCrIWEobLR4oBtm?=
 =?us-ascii?Q?EITf0+zHhBipvZBbgb18PUYDGnbuBebt16+7enCYX4jdHC22epN5RzAIW/qy?=
 =?us-ascii?Q?TwMGqDBCMTI8172fbvwR4d5qKhFpU3ysxsRkLfU5cXHOJ+OzvOxnVXkBDOov?=
 =?us-ascii?Q?IoLP8THUfwC1kZZCEHfrIelOUBIjrs365WGrJg7Wy9CDFWj4TAfw4huZpCKJ?=
 =?us-ascii?Q?nVYBM8YYSXp7P6IeqfRASjVu0wa90GP7OFmL2opxQfwiLvUJssFiytS1cshA?=
 =?us-ascii?Q?3s8oPWc9TVIg5aYd+44wVOZdxHc58wZa2QeaTR/G6POCqTC68zn8ICRE15F2?=
 =?us-ascii?Q?+U2P0cx0d9cna2AunwgvsxTp6dUanTzDXFOfsZxuKig769Z4wHCjevyCjDeI?=
 =?us-ascii?Q?RlbXjjXTJ59YLe22ZXLCLPXIgMbcBgG3/gT1j88Pd56xinIcBeIrvMmpgIgM?=
 =?us-ascii?Q?2sMvGsvtdIF4rYJh5ioMAdtX2BfaKwq2SfFTttn9+kJlGxU7tXd9/Mx1bfXW?=
 =?us-ascii?Q?bnEfXb1pryTjOL62Bwk0cHheusG94eS9o8pdnCKwzisq9uYgl6ir17Adbn7e?=
 =?us-ascii?Q?tMDsUYjZ68rI68MO6HwD1Un3xh4O1IH8DFPrTHU4ZoMmMBYGkbPoXYDnpAFI?=
 =?us-ascii?Q?sO+gF11EEEggrzeCImZvj8w9bgsPjeRg3HG+2iu9TyO5W2VWUJrFTLKjQkg1?=
 =?us-ascii?Q?bg5Ea65qTl7+8L0UolGUCCGqnJtiLd459v8NCxqnyvo5sUIArO8hoSE/kkx7?=
 =?us-ascii?Q?YJDeG1U0Odc5tM7EOrcQnG/Gw3S8qbYMld81YZJjOZLwkQoiucDTXbehnGcn?=
 =?us-ascii?Q?dATf/8w68fzZBDC1gcNJriDS0OrbxspInm5R2sF2P2BRs7MYzcC150ZweTtD?=
 =?us-ascii?Q?4WzUbE7SZ5qujpv/TIEaol80nWyEzAxl7clnsaaqTkML2AcCE8d6iZX6TX+D?=
 =?us-ascii?Q?dlRx8c1QaXcCzD9X0RpKRbYjqtbaR3ZcmvFA2E9rpBnd/MYzuRzK/LOmMjF/?=
 =?us-ascii?Q?fdd2Z7evDssKjnQqoicgoSVcSWtEKo8BMZgGqMOXIo6OA8EzpGGhOJ5kGv6H?=
 =?us-ascii?Q?kQeS9QGVrdu+zzAqza6Z1qOHPUnRvjCd+3X0TRzPHcC?=
X-Microsoft-Antispam-Message-Info: mFR5vwKeBgpD5AhJ2/ARrv/teQsyOVf/pC0o64TZ63pSITUBtOeR7hEFA3dkz+5wLPYWsSI3gALji436YXNDxcjEVUc9dfdV5G6Qv9Aq0K4fdWCyYXUxLgRVK971weFHmygSKLBcs7JbjN47gNE56FkrDVlb11M7L8rXbWhL2KmvGjzFl5wGYn9ELlQdHFpdT8eVk/OYFTT+0SvAWadhLeoXy+G0T12Lmdnt5tG796y41qOoYO9Y3uZWclVdKz1IkUV1z0HOp03frVbdpUYIicfwmOuqKalm2e2XkYV9erTyNkesfDNiKFqlutsp0Mx0Jfg998XcZfMUqulWoIeUEHoWGQtzesywh1Tnm7SgvOQ=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;6:E8XMOoY1euB8x03V9E+/oPEsuJ3hGsP2mwH+JRIM0nNediqVtIlk47zRoc/AZ26S6JSHT370ShdG8xDNHozeS77aOn1FlEvx6+bZzL2Xzp4IJVy0FGEwATxxShJXfVIydUceWX8hNP2yLJCW6IZ6X+pMvBR3ERbUdvhaicYV4o56/tqOsoPTvakjOvzRu6Z2AZ/y03ora0PMvoUuS9RTg0Qeo9NyrWDYHuN4Dg5md0O05t3VFhWqJZ0qwma1ZKUDxrsl3dQvh9Q3eomeh5duiLXzLUgoLCeN43SWE6dIGbcmkHaF+/hG5bBhSYh+MakXO6nKeRSemgvRRvsD3cA4ngzMOR+nTJm8360rSfk3mt/zB9r9op2oqNokKZbFNts2ZOrpvFmxsDI4GO1Yh90LQjBtbp9M+IC+QpEckRS1nUFKLJa8t9Na8gI9vlyg9S1TTj+elo4rXNFINHwJCCmT4A==;5:VMumL4PDCa3d+Mz9BxMv5VmhqOKRke7x0WYrSISEyuE1+XE///SzJR3c3lr5YSpmaHlE6pDl4uc8YYM2sSJSqVmGhhlcyfJNmi/2prVLuJqeK/tN53edpSCFQafsmcTsX486UPTUQpTT8zhGmiwJou6xo26HeQIjJ0RVtxD5QCE=;24:0CvdXHy80+szB9GaBCxuQ2I/HuKnHxvPwh+cKIBc1PGCn58LADEy6ZLXZHZVeKEH8OQyeCVJhVdgZHWEM8Mb4rDKl5mMgEZ5/E3mYZcVtZE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR05MB4456;7:rOE20oUl8g1JSqZDaLtbl65bDAgOuUG8K19MAJLlxv5k9458Y4G1V8RdLLskASvtlQYBc6TFwzon06sUCy4jo85cvLbeyTAQant4rGfuuGTIGIwehLLYiJ33cVSYmdI1QYD3AjBZgSeb6jqbZvfyE+bIZ2l5JqDNME1FYEKZuksIq1tDNSkNElzMVjXapM5nJZF8Kvyny6K5nqRtra6LIhFRSArVvPSnewGZ8R5Jdp31UihDmUGNkAqQVkQzFpnJ
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2018 22:44:37.7178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a93e91-08a4-477f-3b63-08d5daed3b3f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4456
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The true option causes this indenting for functions:

static struct something_very_very_long *
    function(void *arg)
{

While a quick survey suggests that the usual Linux fallback is the GNU
style:

static struct something_very_very_long *
function(void *arg)
{

Eg as seen in:

kernel/cpu.c
kernel/fork.c
etc

Acked-by: Joe Perches <joe@perches.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 .clang-format | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Resending outside the merge window with no change..

If there is no clear upstream path for this file (it has no
MAINTAINERS entry?) I could take it to Linus via the rdma.git tree, eg
as a 'collectively maintained' file.

Would prefer Miguel's Ack to do that though. Looks like Andrew Morton
took the original patch introducing the file?

Thanks,
Jason

diff --git a/.clang-format b/.clang-format
index faffc0d5af4eeb..1d5da22e0ba50c 100644
--- a/.clang-format
+++ b/.clang-format
@@ -382,7 +382,7 @@ IncludeIsMainRegex: '(Test)?$'
 IndentCaseLabels: false
 #IndentPPDirectives: None # Unknown to clang-format-5.0
 IndentWidth: 8
-IndentWrappedFunctionNames: true
+IndentWrappedFunctionNames: false
 JavaScriptQuotes: Leave
 JavaScriptWrapImports: true
 KeepEmptyLinesAtTheStartOfBlocks: false
-- 
2.17.0

