Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1157FC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9549206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="xGHoW/Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfAFNtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:49:21 -0500
Received: from mail-eopbgr800118.outbound.protection.outlook.com ([40.107.80.118]:47055
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfAFNtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukNPm5/QWj0r3ZJFQ4m4E75UkoZmj/YHWH7baVtuF9Q=;
 b=xGHoW/WqEY4H52eMr23PgmFNGfchpC5uDL0D46AzHBv8t12PRnVO6amgLXMtT2CbZBs2fdhKzsVEmzr7Lx+3JU4JW12PBqm5Rz1sGY/taCmLH5ypKR+TcQeVPpidTUgTjSTPiZhfFsnvVMHjQ4E2wX7QdgDIB5xaRHMghUOUGrU=
Received: from MWHPR01CA0042.prod.exchangelabs.com (2603:10b6:300:101::28) by
 MN2PR01MB5534.prod.exchangelabs.com (2603:10b6:208:118::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Sun, 6 Jan 2019 13:49:15 +0000
Received: from CO1NAM03FT033.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::207) by MWHPR01CA0042.outlook.office365.com
 (2603:10b6:300:101::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Sun, 6 Jan 2019 13:49:14 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT033.mail.protection.outlook.com (10.152.80.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Sun, 6 Jan 2019 13:49:14 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x06DnC1V001624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Jan 2019 08:49:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 777D57A4BFD; Sun,  6 Jan 2019 08:49:12 -0500 (EST)
Date:   Sun, 6 Jan 2019 08:49:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>
Subject: [GIT PULL] fscrypt update for 4.21
Message-ID: <20190106134912.GA27028@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(46406003)(88552002)(33656002)(2906002)(75432002)(86362001)(52956003)(356004)(47776003)(486006)(6916009)(8936002)(476003)(126002)(97756001)(5660300001)(103686004)(1076003)(106466001)(8676002)(4326008)(106002)(54906003)(246002)(316002)(786003)(58126008)(36906005)(16586007)(42186006)(336012)(23726003)(90966002)(2616005)(6266002)(305945005)(36756003)(4001150100001)(186003)(26826003)(50466002)(26005)(478600001)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR01MB5534;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT033;1:cqxBiI05yXA8Sb705AHujtQVZIlL1giialXkXBM2J+vlPfWcjx3yJtcu09jbAYjxA1P//FI2BfaUvgVAGAkdwkYxNv680LEIG3yp7ARkbW4AWWlPhbh6IKwTRT1ThSu1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f2e18fe-cfb0-407d-bc8c-08d673ddbeea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:MN2PR01MB5534;
X-Microsoft-Exchange-Diagnostics: 1;MN2PR01MB5534;3:WCytshM3K7shWfky83r8ibXBw1fC8RnHA6eTJU0rc4ZYIbtxXAWWNBex1OJ2CHKAL1dNOOw5+aO6aHOmAhEX4IJzCrEwmFqalfSNM7ctq6sOWUF8W8DLEaH5vMwhG9btsguESFtgmHhOk4XYf6/nZTI+p4CxsIXxK0TFx0P4lMG0u+bWUpuDHIsNh9PJ660N5oY6v2b6F3ySrmCzWD8lMO0wLyCX8bIYIqXwQioPIap7tBQaOHp6tmvIDbCEqQoMOKlMW1jorQW4vc6cz6YvPP13rNnlPAcMRrmaLQvuqSP+zlwoIlnz5vRWJ6RmN7IUJlq/AW3rBKSd4S1DL6zB2DbWef9DIQZ0N4csircn8m5uEYiQ3zYF/YZ/++FEYlcG;25:jVGjdC65uJLLw21e47zfY3FWj8np1kHMBlJ3ZKgArcP71ETWNkPbm5ruZ74SdP8rnJ7JjoIXxjGKb4M6GGza2NsKKxu2B4rFn9dWl2ytnVRHRP0iY8HfMDiow++Ho7TlsCBAb5FnKfY/9rsAJKvuRpENit44mIQfp+U0Ti4b3PjHG4Q1B1achfp8jO6KqNgUa2QiQou5UgotT+vpyMNYPaoANcfsd7KYtfIlhozTX+OXNk+Vrd/NaZExMEYtz0LYxYg2Mom9NDCtxN4kClEQyvulsoEnyIN5bj2UyarYzi539GmTEkzAgXWz+yEgAil7OiqHq1O/DGaMPnYasSZkhw==
X-MS-TrafficTypeDiagnostic: MN2PR01MB5534:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;MN2PR01MB5534;31:8nWeOR4j1V2ngEWE0LlhFKy9PpLMGawOnk6xxbm7ILumBaRq3B5t6Chk6ZYcQ5+kZ8tYzFk4SYYmc8pc3scwuzJ3QC8VH5OSIUT3ObB24w67xcDICcdxLpwcQv3J55cVvDdiatt+NFfqImNCgfLxTMSWN2+b7Z/IHPq4LQeILjIFIPALJ2uM5tNV3f9zD4ai5BMUMrbEgaSCRl3vYTOFHKZTsu7v2sz8mmIw4ztXEuY=;20:XUDPT31zD60zH8ThUszo5m4YD43Hae2G+Qb3Gi0zfig/iTULutjGL9MX06oYytU5yDSB539vFdRkTvbwBzVuUtD2D7LBfqAZHyCUhCSTKBWziyD7Y06BXvmhyE7yh2/Ro6RWju+O7COjeHZf3gpE5bmYgfcmBtvYY6EZeB2VSt1PPIRmWmgG3wURA0sP9JDdH04igS1xuMe4YH5CG7/C6hU70Gop/+Tc9S/Uc5nDtzhtnszjPPUTN/vEBhkVv5LIytGxxjqQHq26YqZ+8nWFpmaWlem7xXtPpx6MHe+TQ9xfUYbTzTOYUz1QfYq4KmT3Rojmf8ryrJPDRzZgPGCKc7TfwLu6pkmMzoLp677NgMvNawVOvRMJuq9cHnunDwG/k8yNfw8Y3r4V9E8E27FAwQCp3G20RqzflpJ7bW7CjNLsg+rNX2qpptA8R/A25Cs4gzuQGm9xHus++gVjGZVjV6h8CGe7M4cTI9nTDC9XgImVriPREIoXbJwzMfYjijBM
X-Microsoft-Antispam-PRVS: <MN2PR01MB5534CA069E944BF84CB2B0DDB5880@MN2PR01MB5534.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93004095)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:MN2PR01MB5534;BCL:0;PCL:0;RULEID:;SRVR:MN2PR01MB5534;
X-Microsoft-Exchange-Diagnostics: 1;MN2PR01MB5534;4:aHRzBj5fntO/l7kOY8BU3vKW5M5RiDYZ+ARNGx3LeZvJrQj7g+o1dwgmTBaVcQL/ENYl0cpeDkwL025+xnki0q9dYdMkARyxrxifH6RrPgw9c7TukNhoNV0stGYH1Opme3koPaeW21O/oev+qCLPl7DA7ArPvvfIAhM86JCulRy7KKXROlbytp7/YeYla514b7hKtyJV9PqKYmcpI3jlPrYoBJuuRUN+iNFYbwa4SMhT238WIQOy3uKnoOptD47LuYZh1ocT1gzRWfAdznGFfebBWX26cGzZhg9BfcQrY2w=
X-Forefront-PRVS: 09090B6B69
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MN2PR01MB5534;23:4fx8Gu0IB3zE80IMtYTbe+1Tekl7ujVlkfgwWXMg9?=
 =?us-ascii?Q?hc+YKvalvf7KDww8QLpgWPnYBlIuedWwy2D0P6MKan6soIEOk+pEnbDllglX?=
 =?us-ascii?Q?VI8wTmEyauNXemFbDq/rdQwxRBnYRececG5ZUtN3d5fr57SKMEuejZliIspQ?=
 =?us-ascii?Q?9LOnjj6ovGK+mY3m+BJw2LXGdPaI1pK/vyHPyTGsJe7SzeNwylgToXf09F3B?=
 =?us-ascii?Q?eqk1gSylj+qllpBE4GkI3Q87fxDn1tniQf4w7O4lmde7wltCmEotDsvuQm+Y?=
 =?us-ascii?Q?nO6COEjKoW4B4Z/hKZ5h//CeYZ595+eMYTsUEmz7sP7Pl9yRpcF0dC6PbQOG?=
 =?us-ascii?Q?52FAXpn+0xPDeF76wAaLcSoGIMAKLUfKc9502gGyMcyuf3uSWn0kuRZdLBDH?=
 =?us-ascii?Q?evRy1sxJANug+8JFHYPNHSf9MMe8eEzLhJh7OdiR/6PSxERfotvPQyYNv67/?=
 =?us-ascii?Q?GgYfey/LhMlKvHz4V/Zs1a0sTpJKF2B7+GgfJtzkP6luzbOBt4Rdv0D52QI2?=
 =?us-ascii?Q?kGM2WjtNUFiT9lHFnjrEzfbWTRQ5ox87prOWGW/qy3qpvWg9kS7TzEG3/fYn?=
 =?us-ascii?Q?6UHp7+mn4EG++twx7WrQxqzjoc/qoWx64GXu1vO0z0DHmenHSDY1Wa96oE97?=
 =?us-ascii?Q?0tc1kIe16XUmPe6rNnDE4zQ919pk00lcFAwUJ7hrBI7flx4D0cjQf1FiZmfc?=
 =?us-ascii?Q?7ug4zyBM3hTg4gqo1iTAyx8ippmVAAWX8jvR77ypsszF9wiAPmGAdRu04a2U?=
 =?us-ascii?Q?X5k7jklEX7K9+iaQuIqlRD+sN/BiBIK2rO/Z/WgFww5vJIFFogEPTOqy9DVB?=
 =?us-ascii?Q?GcVDpA92mdvqdHLouyuYNwngzMrJw9lrJ7W4eN1RCg3AW5N6dnL8qXlOIRpF?=
 =?us-ascii?Q?E1+T8kjZfDCRARdAtzZ7OMzm7+/XkKgBSs2UyCUklwTHnCNQ7a0na9tNwtbn?=
 =?us-ascii?Q?fW2iZNNdpjC8kDNVVirijK67RESVHMUnb6WSij3JkfMSwR9eMNXGZdX5+6us?=
 =?us-ascii?Q?Ra04A9eLJpvs+WBRZWgyXCxDqHuF1C8fzkSJcpNHA4REY93Kg/nHnJEkRXqF?=
 =?us-ascii?Q?mky2iIwF0xO+lymR4Kzb06dD8M+F3YmYSNpzMQnYeaw0Fy2TVuwrShsaX8sq?=
 =?us-ascii?Q?8PQ/oYrT+UnT3Q2znOUNqhOBO5yevVYhlLrgprER3fRyZqM7RrX8A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: O70xr4lMMGVIcuFqpxjR29qeT2yq3W+4EG86J2l7DVgS3Ju2trCxRg8U6rKuw6jjLEWQw/VeuCL05YZ3ZTnpF/zG5VBxWCIDIW1Zl7k0y48mhu4xtj05BwwAE8V3rd+RNxVpnUxb9UoAaz5DTItetd/YjL/S8JLO0b6Zt9+5xiuPh7ctGaHCx7CKllpUnlLmoPuFAB9yTMKl3xH8loHp+Gq/4pOq5JGpVJkdI3Kyw0k47nmbTYizmaNCBWIL66hrOfHJfYY/Vb5oMcZODmC8SVjXOTNeYmUM560oVCgsSQWmvV1GfAx2c5KijpwoErjP
X-Microsoft-Exchange-Diagnostics: 1;MN2PR01MB5534;6:Zwi3NlQZdPDMzq5SayWZlmVRsp8FriXU+RsJXU0BWAFeo/SoR8M+/xgzA+xuZ20xR6Mm+oBU4cMXqNyrx6Sjjkf2jiCC+K7RCuMojs8vU31z2xQRMeL/jsTpm/8IHwOa3NPIxBWnosWPIV84DKU9jj/OKzLFZsX+kD1YbaeMXizjCKjwa4fAzOd2QjYgt4Ogi9Py7t6W/x7BRmIkLugcAiq0t1hbSnx6dOvYgzCaoTwrSiv9zvDfZzeNwRJbcbmQrrhUp6P1CzSucYfrpXajwVwaFo/N+yXRMXSrucyGpqho6tNS6poBzDLC6KbGXSERX+auNCxOPsPHI7lO88ruqHvDfPSKWSDvZegk5XIIB+GjokFgv52UxhkiEGavj1pJebv4B2o3dH9qpRd7f2rNQbap+MQlU0RA60dZGSU+Jr1wndviowlZfbGtETFXmPUKdc5ZI12nJnvADWSSo3JCTA==;5:KolUUvH2l7c88AxPTwKVHNb86yi2732E2iVV+33ksFOwopmt294Bf09zmXDgq870Fj7Hva3aqixzCvBNSriejKrUUfoDF5cIcOv9NcH8CuYmubSPvFfu8lTQdJyg7ojIvFxqScDzOGGGFyTzlhYtEKcyMbrYJnMvVognSnH3qF/B2yM20CGRNymD95eUTW+bD3Wh2vqHeCbqok9KY1SxiQ==;7:MaKrSXgfeYwyZbmbxXnTdpZAhFDduXpGKgLYSNltEgfy8Q2hNHnBEOmn1rrpV+IkaJyacfQVWhWjvewHKJBxDJ8NH/D0XnPRtetCi21IEeHTuf/YfSLpib/RFonYHt9bxoT8+b8fK+wCXbN87thjSg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2019 13:49:14.4243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2e18fe-cfb0-407d-bc8c-08d673ddbeea
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB5534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7beb01f74415c56f5992922b5b902b45d365e694:

  f2fs: clean up f2fs_sb_has_##feature_name (2018-11-26 15:53:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt.git tags/fscrypt_for_linus

for you to fetch changes up to 8094c3ceb21ad93896fd4d238e8ba41911932eaf:

  fscrypt: add Adiantum support (2019-01-06 08:36:21 -0500)

----------------------------------------------------------------
Add Adiantum support for fscrypt

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: add Adiantum support

 Documentation/filesystems/fscrypt.rst | 179 ++++++++++++---------
 fs/crypto/crypto.c                    |  28 ++--
 fs/crypto/fname.c                     |  22 +--
 fs/crypto/fscrypt_private.h           |  67 +++++++-
 fs/crypto/keyinfo.c                   | 351 ++++++++++++++++++++++++++++++++----------
 fs/crypto/policy.c                    |   5 +-
 include/uapi/linux/fs.h               |   4 +-
 7 files changed, 468 insertions(+), 188 deletions(-)
