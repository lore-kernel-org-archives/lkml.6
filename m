Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521812682-2-9957137918872949595
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812682; b=YzUGp/DChov2SF5fZNuKKSpe1sfuPLn2Wk8JcB8nT6l1u3D
    pugFLfi3zVWNKranb3sQNrWkjUoD7yMeWVohnN4Yk5LjW+sYzOLEuSLcEKoqMcP9
    uJeYfzFCqnQtzqP7yjt++j14TFEmb8tpFEIuwHlPEgB4IaDBEQzDohpi/jR/LtMS
    IPkmljmcyuMrw9/3hL5pUZGRu1IUnJ8kF85VReveOrOdzgxbmBR6N4btWO5qS1s9
    IVI9ZkYPb3LAThuockMRx0GNbmu2cQRPN137PmhKmSfnXfsj5Sjl38BVDTU5u1oZ
    8cv0tGP+EZ+Fsak6OUYFNkCpsnr54NyiznFbJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812682; bh=R
    VFt4HsOAuMITyVbYn91sNXtEOw4OYTKzzl1yp2C6gM=; b=JkosfPeeuLPb1yqhb
    larYrqEASC1iJOOAlVTaYtLJ/W892W9zH4KP/1Da2+CXBaizYi1nUCTagtCA+R7K
    YBLwTntKHgzkch+yO5BYtid/+H6i8QpS9+fQ0Yl9xlTjBkHYyZly/edxr4o69dWD
    As2S2Rqh01e+QYG9BstEowLWUJheQL8tq9yIUJGAGmRCHJgHb940GvotjwN1kZmM
    DM3AQ62RIs9Eb3+0L/zVoGtdtT0j6tK/bp7puE9ozv1sl+ER2IVCosDsg8xVsDy6
    xmEOuJKuwcd2ziU/3Mn4gd7vLvAlFdTtEK82g4UaPdLSwazhvnb5+sgEcY26gNHK
    ryiwQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=GP72cqzi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=GP72cqzi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 2/9] staging: fsl-dpaa2/eth: Move print message
Date: Fri, 23 Mar 2018 08:44:06 -0500
Message-Id: <20180323134413.1532-3-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:405:39::27) To AM5PR0402MB2690.eurprd04.prod.outlook.com
 (2603:10a6:203:97::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbaae382-c0cb-4165-d64c-08d590c4338f
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:SpbLdaHh+S/q/sc6+v6/5ajL611cZlH7i6cDy0AIi1ztTseciSYJ89Yr6T1mXAZFLr18e4LiwcMRazyzzc874vbYvQxnFholy17cCJJ4Ro81SRIuWXtFCEVr42+MxKNtyPlMsBHAFdgFFADYYfQ3dZhLbcnPJVq3HyV5n4oTUzjm/2X9iCdlNl8vykUgpxO9gAOkQ/uR/hfb7DiRkZdXFjJdoGRT0o2s8gjTrpYu9CveWHrYyH4J7JOXRUwpID6u;
 25:UGf7sn32m+56RgmX5bkNa6PwAr25eC0arAn8J06DqxE7MfZLOy2YN2PIU67EJfvgnMEMTKPnfC7e2nZLD6OjYAwDCWrKfkA50jqRtrttzrLi/jE2bIMT/2avyoM9OIYuQ7p3w6O+jpYZf1jzUcpy8K6nFz8zLTs5iRvf4V86WB0ewvOjTlRargnTutWlRn4PME/sxn4u/zicDLJnzZUE4pzNlf/ZT0jT5tk51QP0pCshTGOioIIIwiFC3mqWpGVM1889wK4vlT+iRFtD5JVx3UU0S57AuugafrziY/QA1fgUNTfAhZuEihRKqsKbcmO241WGqLg+LTeYuNlK6nKPVQ==;
 31:bmDdq4l6U7S3lzD80DcbD3WNYUCzQ2RWWI+nc8210KY39fQmixmcp4Nz4LRRMfXli/vLEQBnw2ZI9D65IETJqP6x0qYrjEFsEWE2R1MC+sVSZif4ikP2Y78jYI+l7G4Zw1mrqXzdTmnyiwempgvpg6oQaV5LB49LXmW5PlUEqo07WbuL9WQUMNcFfP2THbbiXd5jpENU8Ng79G/9bsppGaDeyFIjpM/I5Zlkw9NImc8=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:kDzXGlUcabaqHiP7yKQpGRzvY2Lyg/3jJBqAAMjiIXrDRRdVd5rPEYleDko4uCmoGp3n1lnW+ZkTaOfVVVGG7Ftc6vLR8vQu8w0eAMjqj1dENt96gLMD05Na8CISkFJmc1aLEJYnOgwgatS7jwW0j1ew/rN+cEeEH3S90hPqzYtq6nlyUNjjlfwAXCpiyk/xhAWU2pugS7fLsyp/JisMIO7VhYHwRWVvlPVnBM4TSJXo9hUte4Lhha4J070BaDDgojC9wlR6AZqOmsmFAJvIPh7aQCkTR/Hi/MchMKP7/IZ0vJNxvJFk4yDQ6S6dbcvBqbJvGV8K1wKqnmm01COD5kEGo2cSLdBDAQQL7Y+zcUrE0FnjVSgqaMn+8uf/NabJfBNjwkt9fdJ/vLNv0RMwaij/W/yoaqhpdJLHRQ1gsR3Cr0JPp2aLJeXWPPmg/P7X5VSoNqINJEqvX11SZHEuCs3IQKI6+l1Rx3VVq9ENxSFnDYZIY8eGNHaGGDQZIYyQ;
 4:2CjqZHtIgfhnmVR5b3Li8VUWzJ423ydsNCySs+e+iYWScfRze+xCqrAc7lILtH90j475/QMCJza1WKIBtvW5HS9MWzN7dS2FTDRRF87C3zxDpkqtXhI2aiI7qA8o3QLQKRRVUuLs2WxtOHjNncnTw3RZnnVO0SHTS/3k1s7JJVnjg0Go9ptcke6tIg26tGNQ2T/iS3J5RP/YoK+lWPQamVWWpKoHztG8HjtRsS87PQCiA/eEk/LM0anxFEEYRk5LLH2rwyps2JgxIrojfGRzq8/nvhOeJeNr+a3yrTAVA8j/a3thFiA7ABVou3tqOOwi
X-Microsoft-Antispam-PRVS: <AM5PR0402MB26904352C740738342765EB194A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(15650500001)(6512007)(6916009)(59450400001)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(446003)(2906002)(36756003)(81166006)(76176011)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:6wNgXB+2JsqrGK/hAuDnCr1bmj3NLbIrITwdyVv?=
 =?us-ascii?Q?TPx5FLpYSaQMIC0aPcBd25nTLuZPP2JUx9FIoQ36bUMbhTdzX25fFtGYbK/s?=
 =?us-ascii?Q?vZh/WcAt+VPBBA2iSthB5Cp3UISzip0ZotdXe9Zk7K+wDYemqwHmLW00wkIr?=
 =?us-ascii?Q?htVeVPB+WyLVkTZFTRj4qSxL8ZyUS47mujH17uvym2QDikREpyh1d6r+ao/P?=
 =?us-ascii?Q?tkJFg1Gpq2CVZdBpUtMyFkE+tf+6gTi/7VuUd9b22FTZs3VU7kyIcM2zuriC?=
 =?us-ascii?Q?W3O4fbPjLU6fe/v4FPcDIk0xhCzigDoI3V9G/pzTdB/6Af66xd3o/2Ygp8+m?=
 =?us-ascii?Q?zUvKHEaqi2eJn8I3GHRM5DNVhc4mxJ7xXzkbgVxY9IZKaX8xkJGbcTfOD+eP?=
 =?us-ascii?Q?0aFNk9/Cz0PnmtDNCwM/5lA6DVhJOHpuKUAV2ktIA8wkBxC7S3izga1x3q+x?=
 =?us-ascii?Q?vQ9h9bTJB+Fr6FgEx01D9wVl6trwcKBowh67UzONeNmUQPfLZpw/VWUFvfnR?=
 =?us-ascii?Q?7Q67buYS5HKIiA//0sr8bMyjgpWfh3EU09TgjVmIdBkHTCjTHFpnxWiDOTLs?=
 =?us-ascii?Q?+qcLi1l8Jo++vCf3iXE6VGV8yTEYEGYeQGMmKz2MQNd6IrENXLXPGTEMsEYa?=
 =?us-ascii?Q?z2I5FQbu41sw4XignGMxcKDlpUbCubf5oPbO/0PzTaqapeXeR637x7yzFvTb?=
 =?us-ascii?Q?FYA5ydKabBxMJMOi+BZ5rA6211taFFBFuHxLDAlg/Hwj6u4jzQ55QD00J3T/?=
 =?us-ascii?Q?MfvBQE1cEUw/KdPUPS7YtB+oQWTW3bTnRvWnK+q+XYQ/aBLFLNW8PhlBqPI+?=
 =?us-ascii?Q?ozJhPlpvPgLDQfH7eZJoZck8defwNcJAewk2sXxRMOdMb9Y0V0P2OXqDznSy?=
 =?us-ascii?Q?Mi9jleQ0YjAQD31kVTT71/+Wklckt/9EGtnAeM+sfoHnijpyOaSGw0qKhwSL?=
 =?us-ascii?Q?kYRBnZIWZznk82Ms6kwvpVOPSIahWTOsub+4oJKoHMm6BZV9x+WcJL/tcfGP?=
 =?us-ascii?Q?pP6rhFxH4PptpTZT7BTMA7BMfMGTiwFgb7GgNEfCuF0ky4U7mRtgtH9tbEdA?=
 =?us-ascii?Q?mu5ZE2/nqiC2TD4q6gzyJLr0CetYO1VSU+veVlfsCDSTrQ4HnTHRS5crDqf4?=
 =?us-ascii?Q?jwRg7qTYJbLQa1+2rmwlqNXUcMWugvbh8d7vaS7WFvYnD5xJHBgpVSBgxDMa?=
 =?us-ascii?Q?+cGwEQgq3FscQUrOaTtlER2av+zysx/FNAw+BX5mHam77tgWh2jFzpmIeLQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5OSNtHE83ng70Ovcfe23bVAaN9TjLFiodz+1v0RXhqu7CEOuvtF89W2unhoxU+J/hpUeV3f6X47KZI+6P1fKSWtfkj8umej0sxV3vGPO0w6niHxbPhkTvOEuu0EWJJajfzRFS01SvsxShRuQB1FKn+hpumr7spdNaNuDCyXyWjP5hYmFY+020gzXkML/8RzG
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:ELvZTfJ1+qN/uMHbbNWuiMbkNTX50Aopcic6RAcGrACEUWp1vwJsrf5aOKVGzvTDQILgb0gu3G7h8DRSLJVczDK3BlEB0pVBy2nielaYwtbd4yO0LcR/D6WvYsGMKMl6mvnSPZhMzzvrFB2i+BoF/edjKHzzXujznJ0bNfjjwntlOIUTFaRQ/a8reJ2BJJn+/bQz9C3aqnUpW+Pnf9t//Me84d/Ac2pZRQ268juUVnx2Z3zWjDAbD4IX6vU+j5bfbHfFKEtdzFcq4nDNdxMnpdW0G2/e9EDAGGbKLfdTujdO+iVG1F/b3jYtzwC/uPk4m8C6sCoNPmXfEWtGXZPIoCsaACGIybUEYtryrq8MzCf0FoVYowFkV58b57TeDbjhw00MiDUL6TddnlIeX9Zdq7F+k4ye78GAU9+2VlyrQo/VkdlPW8LHhcKqIx+YZTJEyY8vzc0BqPu5LY9sY6c5rw==;
 5:sILfZWkvuK3bc9SIxQ4SDXhO4ZJQUQC5pLMjekbCrdC1klQGFhZQK9XLThMpy6jnAdJld5T63kCSdAeSxVBA+tL6NN88+2Znsdg4uhNKwdT3QwMArbjnarxCVuJT0qSVL99U6bwYY3t2w384VQWUdTVGoiacYnFkGYEobQr21Mw=;
 24:i/TUy9brAIgNS8ZkuCYMnSrgYrcn3KbDvxdDL9zBCj5n00RuHsgYlAW4tuHoCUbfsdvIZrmailsC/aaAJiS6jszhjZ3ol4ky10OJdHWJ9RY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:I22yCPYVSSs3k6WkVk8dQpNtPfMgarqk/Me9XEq08HakTJvDwa42KRuqWr1URksmnkbNIp2nynx+TwzsWD/Il7ZsUSxe80X6Agha/Bb/PTjWQ7BJ/6vAfvjka/2lk6odSOHJ0xP1fEJGVxMhP5HKTjnpcCYZ/y9DkvH1olqCjfLYke0oJ9kUoyD/U25dTHcpwNMOtepksJtQRVFVUSdHyF+eOp8neOBOZTKclm1XscnRlcVAGfHFILPtUGj/Apsa
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:28.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaae382-c0cb-4165-d64c-08d590c4338f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2690
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Let the driver remove() function print an informative message
after it finishes removing the network interface, not at an
arbitrary point during cleanup.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index beb5959..9fb88f2 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2550,7 +2550,6 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	priv = netdev_priv(net_dev);
 
 	unregister_netdev(net_dev);
-	dev_info(net_dev->dev.parent, "Removed interface %s\n", net_dev->name);
 
 	if (priv->do_link_poll)
 		kthread_stop(priv->poll_thread);
@@ -2571,6 +2570,8 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	dev_set_drvdata(dev, NULL);
 	free_netdev(net_dev);
 
+	dev_info(net_dev->dev.parent, "Removed interface %s\n", net_dev->name);
+
 	return 0;
 }
 
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
