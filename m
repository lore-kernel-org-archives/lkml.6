Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4009665-1520844647-2-1210290460061532114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520844646; b=BFyNKBnG9mPdYDgUJa/pFk1cx0qEc3PAiBNZPRgNgw4mxYW
    vlUxKxYybSO/6CBvwAC/jv2HzgIWffx62eU/DX7Ig2DZNGqNFYUoav46G6AbQkjW
    5R1cBuWQL9SO1bWL/DwKr74nJ7Yfd9CRqlFa2+4VyipXKtLCfQZYY6iV3qypEsEy
    dFM8n7a1pjS7h3a2kqjwNa6+f+/m8eXzU5dRuZEwIfK2+EEksRNLXyZXIBRXsAsa
    H/p6fCga0VkjNpi29DCksqEkADCAfjFbsCcevBvXh2MNN8noxFyySIFrY4lrvIHa
    gMmlQs7ejOUG5gsNQJWT6XEPQ8wHESieF0ayDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520844646; bh=5
    ooRUh2W7XL6RbdOd/Yb2g94TOsuNEJdGFMEJ3b9/FY=; b=Hvu9zVIn7dJNPYphN
    eqaDY33EP374wcZIhuwJraDvx6Riqc7ntUxRaNoPDJpdSQtj3Qw5vA3lOhjl+0ig
    +SDgxuc7R+Actqoq1o9ghh+9lsc14HvCQyOol15RsdWUBHNQeVgybbdlrMPq5AYZ
    gHPhdNDwR3T9iPMZ/LqpzdZdqM5QGzITg8PLIarf4+oEiF4F42w3ZaLicdVIVF2S
    uMmOrNfuZYrTHkWtbDvxITZFmrR8afVBjuep8Imq7j1fmJcGz4Ae2pWtt8DlYKPF
    /BhJximoaBdXvmRiaYcupEYTTKGZavtGgQQ7jDeEOECHnvLM8fzC/yz9hw4fqnT6
    zezDQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qzfsvEQ9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qzfsvEQ9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v4 6/6] staging: fsl-dpaa2/ethsw: Add TODO
Date: Mon, 12 Mar 2018 03:49:55 -0500
Message-Id: <20180312084955.12686-7-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
References: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: DM5PR19CA0022.namprd19.prod.outlook.com
 (2603:10b6:3:151::32) To AM3PR04MB0743.eurprd04.prod.outlook.com
 (2a01:111:e400:8839::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 127f35b4-4648-450d-59c6-08d587f64aed
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB0743;
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 3:2GSihh1NXHQg/CrGZto8J+VwJBRmLy9dBe3pKubf1MjbC2BNut0RmsP7xncvhLgIcQn0V69QAqR1cTkkjukUwQZbrBOpEYiMLuKOjrGCqua5RJEdUhdBqRmrIZFLxGLSrpEX4ERJUW3Z7EmEUOYjW95XPaP5NKoC+O/bygxtky7RjtAmD4Az01aDBi9wo6eU2kT/OjQXd3hWXAAancecamATqYm1KlhSDhjcQNmZb6vZRGRDLsOx0E9hWTAMDPpw;
 25:9DzTK+wZ+8ku8Z/rvA9hGPaEMmbPATD/jXAnXAPBM8HD4/O0Hr4NlX4BqsraBg79DMkNFkciG/iPkY3KNKdWfnmSP5H2ivEfkeQdkNZg8hjx950Y400dsgCkKNIAidH3BdKQXv2Lm+nqc8p42Ig1hTbnDTXSl8CsnEolCTJOBKQ9r4IqInu+n2P2c8aOqaLHBhQJawMuMtVBJkdzaLjqzvGoE+iMVviyPaBNCDBSOpGID6S7Pcha90DvM8EpsyAzTE10Knnf05DujuQrjhX42Y5evMGnHoin7uL7fmFMlMTQu2ZeaApCPdrpVOk3VehdGEQjwYZIpPF3FG4zyqSraw==;
 31:JnaROQ6e2ejJAhZwHYhatJLkR4dd23ylx6IfxGD6y1EN1utBdH+uXC6HiqMC34R3KuWwoxi5peI312K51FkEvGbRdPoFzk0hjZHs520+/fkVM6bZEIo2I6K6veZ06aIH3M286czXwYSTSetZ2+Jhp4WzzU29lOu8Ox3rFSPUiMV1eGlbs0WVWv/lODsgA6QkLGNMi7+a0By0rIRDCkzAlcU9DGWDnX9Ph1qRbZPA9EI=
X-MS-TrafficTypeDiagnostic: AM3PR04MB0743:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 20:IbzfrxSbtUv3IJUUx7PgeJXpzYrGr0/sG0GQk1qGrhynnfMUvDLbdLwyN4+DqtVcHzuFuhE4b2FRGIo1VvT2V7hYUTJvOn9seqKv9MvePARCuHNB3K4EE7U6Z0NtIKTgUFB0xs/4HfwmJfLxMGxHI0r+MigNmsifHUgAWlg5T+tbqHiZKOw5BrWu3ODDQWcqn/KVIlPD1ycSbnaBlVYgxM5zS8CK3xS6AKb9Ym26oP/PLsoWNh4f9js3Oq1yHmfG2bkevPq/v3DdIR8AmP4aQlGi4W9PeyozBEaL8xUry4TP+B0oUtJHteXea+m8iQ0G1fus1afRHPKWqsYJ3NNs78PDljPyJGn6/BN9ar+rqrVv9dPpoBBhmPfJ6h9hKTGdvEIF6Fkksj8jZMMLKHy3OwsHHZ/Mq+yIHrdQcOaClqx4GzL5X0uoJ6Oug1IgO13YY+yGkxqhejtFUrIPViTsEnYccUSdFT52WaePSwi4JSpe/qn61t/h/3VNJXDsjF/6;
 4:cXcclj6FkMeGhRoeHd2ZbNgIKmYFSgdb/L/6V9SNkpuFH941BoMxMD7CgEr5FKEnvNMqNy+u1fpB8lmovVUMWRgw04uaXcuZBaDl96va+9//EgNynL3esTFoYSo4cROsW1XVvVcs5pVc+RE4IzauMlHQivvayVjU4IoIFtTfZV559sdVC6J3Wh1cWQ4kSTIjwUSv+ed3d3jtoAfQMUReZxhLwxoDMGZXvD8KiY0Py9HrLnzl7K4sqY3YdLt6nemNWfdIVcbqJM6Lf2adh+y4FkMDY8eDfn9nJDxM4dP9zVfu0nuR8qkPwCIfKldE77wo
X-Microsoft-Antispam-PRVS: <AM3PR04MB0743F467CF528A7944AAE202E6D30@AM3PR04MB0743.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM3PR04MB0743; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0743;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(199004)(189003)(54534003)(1076002)(47776003)(76176011)(52116002)(6512007)(36756003)(6486002)(39060400002)(66066001)(51416003)(386003)(6506007)(5660300001)(478600001)(26005)(4326008)(53936002)(48376002)(6116002)(3846002)(16586007)(2950100002)(6916009)(6666003)(105586002)(2361001)(2351001)(25786009)(8936002)(97736004)(106356001)(2906002)(81156014)(316002)(50226002)(81166006)(16526019)(50466002)(86362001)(68736007)(186003)(305945005)(7736002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0743; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM3PR04MB0743;
 23:NoQKFcAwZupioopSYT+4tp5FVZCcen733hVaqYuA9?=
 =?us-ascii?Q?ev25ZxKFeKk7wM5i/oKnsqJMwwha6t+8SM4UzV/LIVxzmZFKXABxzVH0L7qW?=
 =?us-ascii?Q?suoy+6/wkocA4UgrqFV20obsPxVN2FprQAUnHcToJcXEfY3W+0AIPF7eawll?=
 =?us-ascii?Q?Q4FBZcXJOksGsj/YotXZWPDw4f1yGFuNy8sW0liKJrIKjdjRtf4bF4dHvt0O?=
 =?us-ascii?Q?mdG9QAcpOloPabMXc+1Sy1s1RZ6+6S/seZnb4Ege4vP1E9i90GqUiJxEmx5T?=
 =?us-ascii?Q?bKVp/0lLCT9OR4evBo4qwfkb71Ju9iDGRHHJ+JZeCXMR54cryap/PhEVE1lk?=
 =?us-ascii?Q?Aypltqit8S7EVx2R97FJW6k38Va6sYWcmNlCaYpQK2jhHBvy1Gh/pn4LhBda?=
 =?us-ascii?Q?Q/98eZmZzieDXlc8tTlX157Qc+RGevbUfR9JOJbi6pxPh92uyX0Dt9c89ApN?=
 =?us-ascii?Q?EJH84NykxYb93hwh5lWzvqeGYzMMFWv+OkoCO+Sn1zpj3zU3VQNDRuQajxu0?=
 =?us-ascii?Q?7BR87tbRRkSvFVwAnJxIEO2Psss88oYqsnhNaXTff1ODQp5B7FRfMYzUzILH?=
 =?us-ascii?Q?Nj2XQofOfr48NdOetZ8QkwgJprtXwOGca01XOtWOBevScY9RiDyUj+5l6Ji3?=
 =?us-ascii?Q?U54raIJvW84QbFgxpjIDMZ8SuUxbfXDGEUbH/yOF2BjFMluzrlb7zujrJ9uf?=
 =?us-ascii?Q?7eyg0vyWXZijnkgteAt7hOfoMn9PXAsSSkOnuOqY1Ow6PniXCzHxHb61/esE?=
 =?us-ascii?Q?KNgtZSFpBJSuLxb3XJs2pWSoFspQxCm16ofW42gQCbm7+BMz7MvDf8L4V9fo?=
 =?us-ascii?Q?0L/6pSUhVzGKIefv3I4Lp5NUOIFUrk+bHLLGnJ/Np4ePiJLEpaJjgRDFxuXC?=
 =?us-ascii?Q?5iRqlltHzgNy/QeeKcwlRxd5n3PUcxQC8kk/aoKjUh0PDaLFq9G5ixNvAK3c?=
 =?us-ascii?Q?DHMEC8gFgnATyzBy/BBNMobuFCphtmylXdQe8iuL6As/caS/eTP2nVndpVQ5?=
 =?us-ascii?Q?30Mky42tC7QnlYdWz5NsWLqWRAtNHuBOMJHogIyZ9ltbhVwDAKCPP65sYT0q?=
 =?us-ascii?Q?pj6cYnEMlHqJVKdCpfvjwAHdfjts80F5ulVz3xDHIJ+Yjh4RxSv64xASWNhZ?=
 =?us-ascii?Q?VlwCAq2Yhf+MMP+M8XAxRC4iddBBBZsOcnBbMWLyjdW9eIkoud+tLc+TslLU?=
 =?us-ascii?Q?657b6ANRaSlCKET3Y3RRt6MSRtK49IGY1mm?=
X-Microsoft-Antispam-Message-Info: v4P5/or0L2mbs1Qsa2j3azJ3LxIkPeVB5EbOFLe1L/9C7+dCkV/5yJ/41SgjXRmLyZzTnBN8AOqxEQTf4MXrXZjBAVzXqNBDrZMPveiplAHeQEJo7aLut5JtAIesQ2DnGL9tx/CiL6qKy2DYaFzzv4qXzCwIMhZAAjiBFpJLf7RK4cDwwh63bewzskequtcV
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 6:XoHBzlkLT40vM7JNyvdq0WIdRPEaBn4wQIE7FEv5xHSAQXp52eRiXmhxpX0XPXe2l9+l08quyWd0owxoX+X0xK6Ea+a9HSQlZdTux2yaxNT09mM6Dj9T6pzoA6Up6or5Gn0IWlHpV/kyQFvtkvdFf9PEAlkvn55hRxNkIsst+p+J8X+w5rwg4+Io5/7jprYeTwXdWJKnPyf+HFxklH5KPbTqY6Oi+pxOGB3pnonWeBCCVtE/iHAqrlimgIT+E9or+/PXLnr4Tm+/vkjxMWx4b/wOv7JruIIeXoCjHr8fgWh1EM8qGf6M5Vp3ShZrRlyA3ZljuX5zg1r8/xDuBHb6muzVm5jCoLdCdQaNRxZJRMc=;
 5:RKikqu5otvq5bsmgsDyUiMeVtVDYYPVsDlzfwH/LQNrXlYPDU95EwkIW/3E17Q8/IB+r5G9KbjofS1bJKojjVVwIkuolRKiLMViDdHxonMKH9TNwTqM59ZKLRKVPPP6JdYTW3pfPWimKVAIHdceRK+PBypAVKsKe0Ce+BVhBuXQ=;
 24:tkcG/OoEKt5ssO0ba8luAbXc6aAGGu5ppbbD2gI1NDVhRJShJ0hzeHYJOdzsa4Ru7BCes904ufl7Jlyv7xUxf+iy7WWxN3+jolInttd6G9s=;
 7:jVbBbBri+75qOiaPtXKXUYomuU8JEABSw9RA/u6Ow9FndsahOr4+N3oh6aYA6Oe+HjKVLMWBOCFbXqvdUIIqj7AFYEWszQJyEnGI+k0I7F95+Sj1AZ/XUxT7Sio4XxHzJkjS8rgu7g6Z2auB7XPkhb07nm7RKK1DQJPy1uui9Z4LscDqDyq2IuTe96yuL6JV/fYgjvygWpK5TvAj3tTqdueAu4LCBqGLFsEMEWcWRrtXWrqGwKNo7YB8D3a8eoO0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 08:50:20.9379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127f35b4-4648-450d-59c6-08d587f64aed
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0743
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
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org, agraf@suse.de,
 stuyoder@gmail.com, ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a TODO file describing what needs to be added/changed before the driver
can be moved out of staging.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - no changes
 v4:
    - remove fsl-mc bus driver dependency as it is out of staging

 drivers/staging/fsl-dpaa2/ethsw/TODO | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/TODO

diff --git a/drivers/staging/fsl-dpaa2/ethsw/TODO b/drivers/staging/fsl-dpaa2/ethsw/TODO
new file mode 100644
index 0000000..d186875
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/TODO
@@ -0,0 +1,13 @@
+* Add I/O capabilities on switch port netdevices. This will allow control
+traffic to reach the CPU.
+* Add ACL to redirect control traffic to CPU.
+* Add support for displaying learned FDB entries
+* MC firmware uprev; the DPAA2 objects used by the Ethernet Switch driver
+need to   be kept in sync with binary interface changes in MC
+* refine README file
+* cleanup
+
+NOTE: At least first three of the above are required before getting the
+DPAA2 Ethernet Switch driver out of staging. Another requirement is that
+dpio driver is moved to drivers/soc (this is required for I/O).
+
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
