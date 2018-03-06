Return-Path: <ruxandra.radulescu@nxp.com>
X-Google-Smtp-Source: AG47ELtP88P1z8zPBwdzVGem5JxkJBwhz3uAP+z2elQRhum6GXSFnWjZ3n5nOkEgDloalYGw5fRy
ARC-Seal: i=1; a=rsa-sha256; t=1520358252; cv=none;
        d=google.com; s=arc-20160816;
        b=tkQG6+CRes9IS6IOW7DeKzYqRrUPkifpuOlDFQPPMiZkM54O1uOFnakl6CInM42nTh
         QMgCMOxQ1eD3oi6AJpsnfOPeWAA2goAvnaZ1lTh74H3Dr9NlCRbkgkwMLkN6pAqREA9x
         7NzyeVjUdCw1UIL64ZfxOMESZRpAUMo62r6XzeIwKpyxaDDxmMJZufxLipoq6cm1upK4
         q4oTLcHTJ/vJaBTBKuzbAUltMekug5FnfXjRJ3AuZIt1lbqJJYWOif7CVVQvHj1qSk9D
         yoFAyyhyTHzS+8eBR8ZkqdU7jyRgLqim7YDmTVVXLAA3h0yHRl2gfBu9D+8Eh2aD+T4w
         lcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=B4uPZMpCdH9hSASKtwLn+ef1PTT/8B3GLBQrIOJlyW0=;
        b=xTK5tPyHi0XusQvXXsQvvm++M2fVMfToMg4BfgwxhzG572GJUYl/gZxPKEZYoDZk0+
         ytlYBLF9r3BadUbh9+QN32QMGCcuVhblrFhNgjXpKzoIdAPgsjNL9H2Max4PLnp3roZG
         j1JRQ/RTZ1yFrcCNwFOdHvL9wlRPYXYyD7AdCUWAE6+TpjRUjkMGYX+GGYIMZJVAG9l4
         tB1SMww+8LeyLQmJv7Hosjj6VDoQhh3/dWqHtpousv9345a9bWkZ9nn4Z9ogp1Mp2t0u
         3IrXJAfwXk7b4YS2gXuQEQFmPm6PkmC4XmM/uNeY9JTMJ1lbJqu7L1fe6EbAYtaUzv3d
         rFZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Z+uEcxpN;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.67 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Z+uEcxpN;
       spf=pass (google.com: domain of ruxandra.radulescu@nxp.com designates 40.107.5.67 as permitted sender) smtp.mailfrom=ruxandra.radulescu@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	roy.pledge@nxp.com,
	laurentiu.tudor@nxp.com
Subject: [PATCH 2/5] staging: fsl-mc/dpio: Fix cast truncate warning
Date: Tue,  6 Mar 2018 11:43:45 -0600
Message-Id: <20180306174348.26095-3-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
References: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To HE1PR0402MB2700.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18888376-c991-444c-4727-08d58389dd6f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0402MB2700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;3:M+AEkiUpaO/QeKsfPKWG4Hni2PV0obEjKKyVUuV2+BimyOsNbCG9uA5OdKGDXncObJccLqH8vzIviWBZXwBg7Bu3WbKI9nAg9N8Q+8OGyQSVif4glKzjgvXC5Y904zoTRlX0iNUr4oIh5rjkhzOzVM9CIn8Axqc18zbjnuMShqUi8CeE50zzU+GAqq/YA2kCmfg7Lc1W5KC2e40wO5Lzp2yyAp2hyT2D0jzKJLje6oiQnemYe/W0sXsiyZ2zh/yO;25:DKu06KkzJSKOnzK2iaFtFuVgwBEoMcWtP+ZDwnY1OEvtAp5xMupmrPMuMQQRSoUCSBp9y7yaJrz5PnolgRwa+ITm+E7VdTMMfCicYS6gAXQvBr/H5oUD2QyT8bMVOq/u5i6yYCDBf9XAfbXZRzhZs4fcS9b8LloMIcVFH6uiUOKAtmF2cbYw7NLtQsFvVdGhRgrz7yHRIwQ3BxAnNz4uvIJk9Bdsd6wgkwHqhcYFZBavVF4MPq8SDf6U2OxuZavJsKc5jum/dbs7zmjWl/H2H1+7bN6mZ5f9hK/ZsxbWK4zIl5YjStBP1YTfHZSeRk6BzU4sTwnq+v6QkmRYD0R89g==;31:Kg+17QyiKSbVi8KpuzTMW/QcfzhKSKOTG08QaZ38W1JMxi5C3AF4MrKeHQvTg9tNGVd7nAiz3XyHEtYag8At8KaXuwc8KVssc/INVrmXDjBLb+roU0eLK7ZFYM9NjVgd/FABKnCQxLYiMalH6RZHeUuF8RxkAriok3DmB840mcnPGWxdPdLLlsvp09RQq6mJMUDDdASi4rtgArhjW5MLJM+j0YUG547/NLsjqXr/VUI=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;20:IkNBsaf6MHfoELw+81A625rSNvWES/iuetIOxFuHtRp8c8sx2K6JWtYW6FftwfTFnYxigp54U2rdu5zSf4493+r7fkomj+/Q0DyUqydnZrJiLzv2nR27vi5awP0SYOJaCTwvs6SJ+WjaUgf3bfmDKrsPfv7HE2uOynr1cZVxU5MTekBlPmo3fRZI+YWHMmOCaomqUv9qVj5I6fX72WNRvhXnKBTHh3dJ5PuFJHirWBlOHbQqwFraq0Q0XDrPClqFlfR0zHjPoZU0A1DK4t2xdxhZX0zHDaPVubKaqRforRhGwRX1rreTEh2YrEP6uFkBSNKDuNqxNt2MDXvSQkemMDkkJej2TWHQ2+jlcxD+B/AbwPbJO3Fy8rEXW3N45bu7y9ZY8u8IJn39G2u3Osx1l6bFFISKsOZFlEEeL2cxg4+68jrgfj5rFfCEQsw71fHO4WEfIkYRv9Gb8PpOWju792petsHXuuRRxCNqQhmxCzrZrvvC5c35aI4j0XH7Vuu+;4:zj8i18WnCxL1/EdNLDwU1u/8yTRKVLOD2sNtxxeBXZ7AAdCMC35ALtrbN1TXL8JnenDyHRMyvr1CgTpzqt4644PmqZuS9k1qoVwrm+Ke2c5hRzSz/QUs2OxIDnmtNBVH8WZfbpATPlht3/+OG++x0fkD21OTi4NNKW4oV0UwCWBgcxMhvctdscXplImGy+K2a/dLzrh9tfrraiIfjFrGt0Ep2DdCRFm7lSuUTSZr6SOwQLyL+nKCQajlqgc4grqfN6U0usVK1Fqi3pDEzQLEFW+6WVDV+kh2pbM86zJzZtKjd6+g6e66GbbZAIUIuaUCH7DqJY3EZ1YpGhiHYNclt+cEoUC23veKwEVu6aKKTik=
X-Microsoft-Antispam-PRVS: <HE1PR0402MB270053250F05E9F3D2C3847E94D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0402MB2700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0402MB2700;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(189003)(199004)(6916009)(106356001)(3846002)(48376002)(68736007)(53936002)(6512007)(47776003)(2361001)(66066001)(7736002)(97736004)(51416003)(6116002)(2351001)(52116002)(8936002)(478600001)(76176011)(105586002)(2950100002)(316002)(26005)(8676002)(81156014)(5660300001)(50226002)(2906002)(4326008)(6666003)(50466002)(81166006)(25786009)(6486002)(16526019)(16586007)(6506007)(1076002)(305945005)(186003)(86362001)(36756003)(59450400001)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0402MB2700;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0402MB2700;23:JaHM86WBOsq1fdgSSLXTgalrQ4WnDyI7swielIF?=
 =?us-ascii?Q?Do2KamBcYWStNV12cqbLcjzoAZMPVlBfgxrMSw+0FPVbOzfZnTvEynX3S5HS?=
 =?us-ascii?Q?TkYi0kC0859roFZFNrF6lsaDr9XAL43Ga3XuX/s3y6F1a5TPWj871Jekq4+R?=
 =?us-ascii?Q?h/zihZoDjTUW9MS/BM3DSLff9on4uQTb1PNQ9GjD4Q2sUGYt7KqCuA0ZOkXU?=
 =?us-ascii?Q?XyY9HLbwWa/3TWMAgBOalBnXrfbYS+urJ/iX7/TNklaOIZsSf2s12dcXzrNv?=
 =?us-ascii?Q?gcLIhIkm7F98Hj3s0h8jEwNZ4w7qmjfcqcRkQ42fENUqW9LRv8dVdU1NEqLR?=
 =?us-ascii?Q?32BsrECZpbklDL2AgsUqrzyM4uFxe7V40r8NAps8xEWLcbO6Uthvla1d8igr?=
 =?us-ascii?Q?dstQNiulkgx70EMZWpmLeuiwm/KvhAOl76FODJvDtV6KI4iaCtrxbFijJJkI?=
 =?us-ascii?Q?Z02bv/ijHAobiTRK6LNycNkF6fr0UbQxa1YWFIW3Ki8c64H1RD3epHe98sYr?=
 =?us-ascii?Q?c8r/uaB0UG0tCnUuXtWsKoHgRngWfvajA/h33D9xtg/HxueOC+OYOqHAJ9yM?=
 =?us-ascii?Q?JtFY18BMku4oWoAIDuFFMnTufosaXrHIWyjx1dcZhSKc/yTN5ciqbBGImyIj?=
 =?us-ascii?Q?HmeNLH0PeHSOV8GttNT9yo04pkVgfDCWo4bhvWdsMOf6wEa8HVuR3UwRKRnb?=
 =?us-ascii?Q?V7PEopc3FzLcBDpLgQ0BBzGn1CyAdoX06yGb5WzDXjeCbUcZHUz/V7YhjXML?=
 =?us-ascii?Q?e39Q0qFV1wZkgGV/cXWuxCA5RZKy7jopc1v+GpMP1Jd2G97Ol5OahxAXjCCt?=
 =?us-ascii?Q?3nZyg7AJJMNGoVy1pbTSEeSgnUKMyT4bnTIsilfRZONlqVvgZlzVLQrkZs01?=
 =?us-ascii?Q?aZhx+03wI0PxE18bqI4HDQTuvpgmP19902Ppnj+1qj1oQSE4hz7btsYs04//?=
 =?us-ascii?Q?oQsIM/W/6uMSTlk8KJhphPPZR8yrLYVukkCoFD3HcRwe5+VEV0vvhyXlaQBe?=
 =?us-ascii?Q?DKyfn87csaKsvszBaeteSvbIe7NW6Zi/X8HYauZYtjZbkh8EHjsR8qsvUNjL?=
 =?us-ascii?Q?w1+1NakY3NH/PfQ5EPrcrqv9m32k2/yHaG286vxLbg0byi9e5u56TRrkS074?=
 =?us-ascii?Q?MLz3wMjYgHquzTBDYjsm1/WZJGNik2T75gK/p1A3e6Wly1zbE30Vkvu/w+wr?=
 =?us-ascii?Q?pQcuOkUqICrp3ABU=3D?=
X-Microsoft-Antispam-Message-Info: ijHZH8UIzHwVXDddztwiNkP0IUzOxeFRpS/f9+VPHhfZXHpp2wCf0uTYPyWzkNGRBFWDR3Yw9EGE+hDEhI+SEFQqDlS9oUPTxeKc4YQtAc66VkJ/afhiujKJRsFd0dYri/IXbTgGkpNoXRqg+OV0uJOSdJr3ZqwCA1jWa/Z8NbuPGaBDHh7FGyjEiqg8ZqyS
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0402MB2700;6:lFpIUZwAG9qAaPNPXPLb6xbYUhCoDpEd3GUzSPKOuawWjdjDSrY9TjCG5mnNXgDFYpw6DpxjKSwU+99xRv92LMZn5/VMyyEh1zJVez39b+I78Cp9FRJhugC3xeQVNi4c5HUHNgCm9ohb++3Yqzrrbolud6x3VSCaeXMATOq8DipKKjsjF0aFu8d+dqdQDjMqNlkVcETiZQGG+EMYBggu631o4Pd+0DZQmgKdoxuxpyP3asmBEZ8V4cwAh/OEc38+xntxcmb9eyWD8y53kqJMEJ97a70mHLZsM0i/9YAYtxKKsa76ybM3fnzU8RZxKyLOi726zsSmAhzogawiRW2pYy5a75R58asQep9HuIwzbxg=;5:HiEbUsu2FcEeUmngSzdXr+0n8ePfDU871c5Ng9k0+IpAXy0Entr+s+3DNp3r8VJH/w8pFrZBPw8dh22/j77UPtEI+v/PsQYEpRpyAC131cc3aTLH29qnRQdlByQJZ2oHQQi1K+36Z23D5ga8lpuIdisAhE5VqXaxiRndCtFILqU=;24:OPqj8kp8wleKFJ4lHsjUzAO95sBIsic1Qj2Rj6iOFK2lYq1coi2Hq2t6h+txsLEEYeH5xISzJzrjb1IcEUl9TRSA2Dyi3YzaBTANtD/nqWE=;7:RB2hI5Xp79GVgbsQjVY8vZOM8NAC+C1D7aPKooxqPFKQ+14hqBzmusyW50jC87eLH3bPRpAEUIZct2rYVJukAqhbK+lMzFY56J+SNo0nebrtI3e2cE36aPFZ9eC6WefcS1VRCqWk6TSbTolW8QwxXBgDdN1TqRx0slbIX4SDfGSl1DPnqjUTwsz4OJyd4yyqFjQjtv8+ydJo9QltE7ZxOywmJuEHcb6AlNLa1phd/hSxUZyQIUKLM5at4ADYdeOE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 17:44:07.7702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18888376-c991-444c-4727-08d58389dd6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594211174842475693?=
X-GMAIL-MSGID: =?utf-8?q?1594211174842475693?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sparse reports the following warning:
drivers/staging/fsl-mc/include/dpaa2-fd.h:421:30:
warning: cast truncates bits from constant value (ffff7fff becomes 7fff)

Fix this by explicitly masking the value with 0xffff.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/include/dpaa2-fd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
index 70501d7..b55b89b 100644
--- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
+++ b/drivers/staging/fsl-mc/include/dpaa2-fd.h
@@ -418,8 +418,8 @@ static inline bool dpaa2_sg_is_final(const struct dpaa2_sg_entry *sg)
  */
 static inline void dpaa2_sg_set_final(struct dpaa2_sg_entry *sg, bool final)
 {
-	sg->format_offset &= cpu_to_le16(~(SG_FINAL_FLAG_MASK
-					 << SG_FINAL_FLAG_SHIFT));
+	sg->format_offset &= cpu_to_le16((~(SG_FINAL_FLAG_MASK
+					 << SG_FINAL_FLAG_SHIFT)) & 0xFFFF);
 	sg->format_offset |= cpu_to_le16(final << SG_FINAL_FLAG_SHIFT);
 }
 
-- 
2.7.4
