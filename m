Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELtS6rGZKfS+KrRrrjytp1Ac9Pg26L6uLLOwCf0tSeURt03XBQYtfCDFbukE8AW2bWGSJljs
ARC-Seal: i=1; a=rsa-sha256; t=1520441589; cv=none;
        d=google.com; s=arc-20160816;
        b=Ut24j4v0pQ0bVXzy+kqFPaWq0ir+ogLCCU1wcrzJ217yTT8MnsE0H8BT4b0hJsQwO+
         wRl23Cf3g6NyNgOdT/i8bYHvHLDUry/zng/Yf3zkBBwZXswV9iuY4vFp6mDPhwkXceSL
         tULXNBNRzQ+Ob1GbyeAK1z3jWCnuHIBTYQE+WXm7fDo99D45Zm0Ese0JmjckRoMhTN1Y
         8oUC1gOeUcvK2NRxpWzfaTPREudnfP/8s4N8qN9nCFQg8kCCfrMIxrZExx9+/5frqRCo
         Y93AhtEFjCyeiFzFHEghH/nJkqLaosUo7I5SKYMLckAPEkvZvFEJh9VZ+5o+ICLsYkK2
         fY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NYci2n4IWSUPAY+EKj6wqCdzS0Z0Vl0jS9rX8pDBPd4=;
        b=OkMPPfbrDC9BGNURl1RVAKXEC0GFppCQCJ/uLsrlLhJa+l+awG8jfOy+CtuNG0149X
         WLNIO5VcpKTIfVYtG2ZwkJkMN6lZZfWWvBMAXPWIdOn+92kEwjbynYW/uQBPJ3yaXjde
         Flrd10xICpRm7fv2PyC76nihl6BuoM8WNe9dhsk9mJs660dx2ot+y50F13g7rdsee0QG
         iMhQQksFdS0p4ISHS4NapW3nXSJnaI2O1j8uYtd+cdyhz1DcIB71th6Ja+ienlDE5Okm
         rak5hboW+fJ6g4smBId0nXxxO8kxf1MbhTR3hcF6nJR3oN0I7fXYaynEfR1CR74j70mk
         vXhg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=A8qZ9sMs;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.47 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=A8qZ9sMs;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.47 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	arnd@arndb.de,
	upstream-release@linux.freescale.net,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] bus: fsl-mc: enhance Management Complex userspace support
Date: Wed,  7 Mar 2018 10:51:34 -0600
Message-Id: <cover.1520440367.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: BN6PR1001CA0023.namprd10.prod.outlook.com
 (2603:10b6:405:28::36) To HE1PR04MB3210.eurprd04.prod.outlook.com
 (2603:10a6:7:1b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42e7bf02-2e96-4c07-d21c-08d5844be640
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB3210;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;3:96hwMnemsK6LgwWNQIltUdZ2OjJ4Q0uN/6Tp2PB3akOiIe/7MEvLsdPvG4NHqZxVGCY9JRBs0fuRApNdKAsh9XiPJsa6aY1TT2TIjehUSubUlHFErMucmp3ecRu+j07lGmoiREusCKESvCug2Fgx3+8j/sPvAjtr2uuynhoSEIzsAdOxwWFyizIlSJJ0RInj8QnrZYfdlb5FXOqCnUeevOZf2nPLwb16f85HptMkVGyv5K6Q59CdNuNmc7NzTiiD;25:/P7R/xdTAK2pw40yR62m27xVvPfnWsB1hx+OH/KtCfU3bTJ7b+uOiuMVDg6evNGPULrQmGhdoxzflX63LD0TKQLyI9dU3X1EQKBT25mEsZsJDEldTvQICm86Wm/BXZAvuGWZnabB52JJJGVpLmr33Fw1mdVKuJguKnXRznzLG89gMOh9yffqARx+G/RlHRBRskDMFNKxsD5+duwrY95ibFabJ4klyA7qxte8Py2lWZ3e4fuH7hzyKhp1XPDvYvPk9D/U06mLwK1KB8K0yS/N++H4PaYhlU9iG14YsHO2UQW8OP1Wnaz/Kfc2/0EoK2mgLJIXAnweSrzXq6FU5CZ4Aw==;31:YKwDfgO5ee685PLGzUhGXb1wiaJVg4vyloOW+rk5C0TxJK2ZAkz/5lABFHlv0PWRrUnheo6/uZtsd8lFSsNU1aN1E32aTGNeyrDIju/MlTcMuXqkR3jAa5WyDixapfai4Vrh2bLTcJKH9i6NdSEAlXGF/ThrtUB5phdLnvuf57Kp2hAbxXp80cESdfG4OPge4mKGfmWeJXhNivcUgUcLX/2oW6zdRmm1p+bB9dpEtAM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3210:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;20:EYXoqXaGsEScHW9XZWI5tyDKn/0ZXnVgiDQL5/P0S2trEe4I0JvxhsAv2WC5XPsOT+ejyVacM1eBuPavDaTBQv3E5tW01C9XqtvqsIxYQEd/bzOYchJjEjc+/5WoyMNQg0lmbsZaIRBvCQMjTYfBJC3jcruEKDhJqCtErh5bBoRjgpMTOAnE5S9ZCRj7wFSBneqFDsoG+MWC7yDu13jocporbYs6nGVUsdKmcA5kgjWWwILgc2Wv2C6WayTJxPgxH/Ys8zjZYzKQF/AvgHo3PJ25p09w/P9RBmZoKiPN8u0Ac3eqbxTmF98BuKakYFaOznQR6P+xOzTp7BVz37GvTRtU4BIK23FtZ0e6W1CutxXeE9TakzpwrFi17BFDhMKv34ExqeNBWNUmtUfEg8g6s2djFchKI1G62JVflR3CEIodAZcRXL7l9IFqa2d2dgLjlLFq2w7MFEWxid/hJ9BtbXhwBOYpEyflzBKWO7P3cU6u06l0DAONTPHk8AaCR0Dx;4:2OCPIJHvKhRg9nFlQ3kT5AqoBIcGAxULtvnoOXrrcgjWmDCK7Uv/4F/CWzuZdQV1W4TTTDsCJpgaO7k+xVJywGN8hoog+XYRpOU7FF0eS/wXR0RFJOpsUJcokITDatRHtXuuXeEqhNWYWl3Kh79DQtxMfeExV30AWW4n2X0SNPhF081XskhDJkueUodOq8OTbYKNXwHcGSAxlvpTMdarV0RRQLqqRkMB1cqua2OQrsoaA0zmMmfxXsXa3+7yY6dm/hS7vooUwX84f3xK8ylFRg==
X-Microsoft-Antispam-PRVS: <HE1PR04MB3210198C48286CB44D176054E0D80@HE1PR04MB3210.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR04MB3210;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB3210;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(39380400002)(346002)(199004)(189003)(6486002)(36756003)(47776003)(6116002)(50226002)(3846002)(66066001)(8936002)(68736007)(8676002)(50466002)(48376002)(81156014)(81166006)(39060400002)(52116002)(6506007)(51416003)(386003)(7736002)(305945005)(2906002)(478600001)(25786009)(86362001)(53936002)(106356001)(16586007)(16526019)(186003)(105586002)(6666003)(97736004)(4326008)(6636002)(316002)(5660300001)(6512007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB3210;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB3210;23:PWwk/tlNpphTY8PqC9Cgq6Ncit3LK5QXtc6IFRLrZ?=
 =?us-ascii?Q?7MIPtsnDInvxYx5oJNPTi1TluNLayznI11kNLSjgEIz5oOmployLjauaJhPD?=
 =?us-ascii?Q?J/TvQOOwkE8ZkaUzaGrtN0zNnzyiKQTX4mNPEP2XjvKsTRTqd+2zVv/wrryx?=
 =?us-ascii?Q?Ws8pqf5Yjv5GMUyHsXvrGoag6RV+JAr20squvP1VKWKg9+S3dhdzms9ngG+r?=
 =?us-ascii?Q?qIQMD9NZ0RJHob5AY0pRHQ6l5fVFLMbkAQkGJXhs1eTciT08hwen7LgdUdvC?=
 =?us-ascii?Q?NnXe+KO6xb1Nt3ni9HLeXApomUTHPcPjiwUW5FDYgPkU3qndjbtZIFADHCj5?=
 =?us-ascii?Q?1dK48riB7uTD5e56BqUum8wLJ5WyuxpXQ5U40y/cfXXihTAymwLdDmyAaSmd?=
 =?us-ascii?Q?wANI0tNNJ2xBwktXFsAsx021kfrOflw5CpOBGW8kqbiqJv95V8VEv8Ai036v?=
 =?us-ascii?Q?Z8+Fu+FzGN6sklfM58SJDqAUXVk85kUMkeS9lAO263adgj8D0d55pSAyA4o/?=
 =?us-ascii?Q?qHVLjuQf70CdBO/ssAroJ2zk3UbBc7gVmHEYOdMRMpIiiAMXOtxFq0JSj1Z9?=
 =?us-ascii?Q?cIGUfdu4WSt/1KvdojLSf+6Hhl/qZrPzuj5Nkbeo5ev4HDUoXA7j/4a5ZUpN?=
 =?us-ascii?Q?InoVexYRKymMVu3m7MpsJeqQRPPdOV/DLZ2v8TybHPUblYFJw8dJlBZ77xIc?=
 =?us-ascii?Q?IQlOoLb9rMvidsjJzvC2rS1x1HEXlEwTzT8p1nUsr/5LsEGDNl1ergBRLlaE?=
 =?us-ascii?Q?4933uCB6lnkjwl6Lm26vxMhfFtFdBgr1VMK4BpBTCFoXdFPaRXQc9UOpvoQK?=
 =?us-ascii?Q?OSS6wzBMbDz0ZPxWkQHmtbB6gKoGC8ZhcfSRvIWaHXa32XmVErTXjJO4yAeX?=
 =?us-ascii?Q?pAoKgJoipk9YNvFjZ1r+Wjn6RcyGcx/z58xdbhTVweHYqQpimPvyaNSeY5Fp?=
 =?us-ascii?Q?4Wfwf488vwNnjqSdZyN1ctO5ltFce4SnBUWIfBpeEInatGxfVWV68FJVzzCJ?=
 =?us-ascii?Q?weI11mVXEIPdVlf7FwS+FT4cjDamdtr1VyiReMJscrmJY9zP1XOidRsmc79W?=
 =?us-ascii?Q?A/+MUexP3eOZpk12MQO+CPk4HQI?=
X-Microsoft-Antispam-Message-Info: 5YByfm6Mu53hJ036n6D9RJEReHYIpngkNqkhK4igXJoa4ayW78kgeALC98z0mNN1pfB6vTBsDNhvNAYmAVjglGqyEWnldrdPU4jgVV8r46PoWOpgUVNnPyrt9jSQs92kcRjbgBUH7qRAzeXhmeGG0AR+9nYtx4OY8izjE82X5KM0hjRDMqlZeFNsXBo8nUzr
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB3210;6:Z3RMdB8cb0/JvFiFR+iXNuL9SsWkbsdYVlPfV91MJInPCbfXvb1Yf6R38T5VX3HRL6hfAoslve1ctz8jh8wZj7fQNL9fBviAr7neawRjhak9FylnCHJdAFBeT/SBX74qFRIodsnlUVmVrpPThYQGxcwUwsbmgUO8yMxLVCnP/vcXXVWXF7jF4s8OPTK/YdOdR2BEEzQuBCsCSWfJ67OTCMuD1brjwPpheW2K0Zql7PXh9pMU7PHSaVbGYgwz0w8DJCTKJglOgYcoKxe8pFy26pmGmiK9yN+skmO7WHeOoj6VPLtA3e4aR88wGjtGb1Cqlt/IBZXXBp7gQvApawZRMqNrNQas1AOIqQ6L6+xpdtQ=;5:V3lgJSHIRufwJOTN2i+WD0VdS3tcpAtUT3iir7FTxV0/efwMPx3iRpgY9HQr0VbheAjwsCXT8jeMdC6VV2hflouivmPEhaDQWgIeqBZ31HLGb8A0LqJh1MFKCw6Z4wzRN+J67WjXGWgkYxg+0nWgJyD7GG2VkkZj6hikH1IUH3I=;24:rQcyx9dXglEYxQwvmA2VgT4McoIazhDe1ulXOpEfQZlAO8yALfaw7htI3Xgq7JNKJjiB7XLTs2ZE278vwc8k6iSr7xN5v3Th+1Cfd7Y3Y7U=;7:bvWpxlOrUw29ZCum5V00jPD9uZWACA/8KTHysLyw+/rYWKTLMUeWg5Id9u00k/UJdq8tzpXGwd3xoqP5i8XOFs44YAASgAGFUFOEjQFLhKjNiHgvrdODLTjdPsHGJvdsLGmUqi9zcnOYv0DkryLzpr91Tn9m8ii+gKjjW5I+Llht0kvDD1oroh1ZnJJf+LSkXc6qwhRCRPOf9YYhPtWVQ/LsnkOnYoZ5t+psrQF16WyXX+h89kNM8/WSz+dCP22F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 16:53:04.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e7bf02-2e96-4c07-d21c-08d5844be640
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3210
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594298560720880371?=
X-GMAIL-MSGID: =?utf-8?q?1594298560720880371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set adds restool support in fsl-mc bus along
with a rescan attribute to the root DPRC container.

Ioana Ciornei (3):
  bus: fsl-mc: add restool userspace support
  bus: fsl-mc: add root dprc rescan attribute
  bus: fsl-mc: add bus rescan attribute

 Documentation/ioctl/ioctl-number.txt        |   1 +
 Documentation/networking/dpaa2/overview.rst |   4 +
 drivers/bus/fsl-mc/Kconfig                  |   7 +
 drivers/bus/fsl-mc/Makefile                 |   3 +
 drivers/bus/fsl-mc/dprc-driver.c            |   4 +-
 drivers/bus/fsl-mc/fsl-mc-allocator.c       |   5 +
 drivers/bus/fsl-mc/fsl-mc-bus.c             |  95 ++++++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h         |  59 ++++++++
 drivers/bus/fsl-mc/fsl-mc-restool.c         | 219 ++++++++++++++++++++++++++++
 9 files changed, 395 insertions(+), 2 deletions(-)
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-restool.c

-- 
1.9.1
