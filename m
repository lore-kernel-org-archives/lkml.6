Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1185227-1520620893-2-9212089455441395775
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520620892; b=m/t9ySac5qdq0dR8Dy3N5KCWnJLDh0FXHkvGr4cGu0cGFJn
    2XK+dr+Wlepmf0lLz6JtKdhAyUGtY0xl/kOAbGrEywtiMgsRmfZdrgFn9j9+Xp5R
    EHhMiXjrsX3teDqYTxfzRzlvkx/A6AeYrwPu2fvHRyJvEkuACJYq8OP4SXMZveWR
    eg/LV5OBdLOqtldVBXTXLKxZR6Iv5lnqtl29BqchWyQ0wormPytTeAR3f3Yv/GSr
    sZmzKjZ1kdFj9lGA7+u6Asul0dgMTLgBZNOWJmZgxQe7QAE2Nbil8iPIXdOgNcTq
    9vaXmu3q0ejDPdSkEy2ckaId2p18mvpBIXh2k1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520620892; bh=g
    Tr+kHiBwrJplMan7pNmW2kOQllkQwkpYT81vnWA71I=; b=YhX1ojEFrxlwovYDD
    Hc8s/c4gGgGP92Y+nqxUD+EMw9LY4tGCyHB09IJBPwVc6zDtDFa+NzSJlulZk7n7
    6aUseic9CDU98yzC3zUE2dhXpUPKa5jNWtYKDPRZFLTn9QsZM1ygtWEa5r6Y96E9
    WaKkFTh6Of4HLM/Sb8mAOHpO2Kft5zxGP0d0CFnA2hPKInupS/heDxFEfx1PVRsP
    S621LhsqwEFq8ZV1UQaIZOi1F6PmNVg6n4+I0YMMvZAtN3EkbusbSVPt0va8Ji+2
    ITSjAzWj1ZvshHUScFq39JIsFrsIG7XptCzCNm/zPwBp+d7nl+MIFqQnGGvl9D/z
    6Wo6w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=OqEup0k3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=OqEup0k3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2 1/2] staging: fsl-dpaa2/eth: Use __leXX types where needed
Date: Fri,  9 Mar 2018 12:40:55 -0600
Message-Id: <20180309184056.25370-2-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180309184056.25370-1-ruxandra.radulescu@nxp.com>
References: <20180309184056.25370-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: MWHPR15CA0040.namprd15.prod.outlook.com
 (2603:10b6:300:ad::26) To HE1PR0402MB2699.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79c5caae-e7b2-4725-6a83-08d585ed5a92
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2699;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 3:vq3BUqXssT5m0bgOs6SSJobB3s8wFqoVsqxF/yOYYwXYqlFHSV26T+CqrJaeTQPSkZdGlKr1kEEt5UWW65FLg5my+Rj1zYTUsBuCbPuNxUiwyh2QcK0P8T2KPO6cjydGAIKP8LmnnOYFpwb+qVoW81w/OLLeGuutwVg17GiBrxGFAPnOrsRxlXi/VKwCzGsnpy6jXHtcdNkSJ7pYrEaZ3Hpu0bYHwmR6Uep3CjsgWhc//VIPbEfBaYwiMnWVTzJw;
 25:0ruSQX7RynfZ/SDsEL0WZABD1xxVQzH/cOXTGYU+Llp0eYXydqNyuD45CxIETv864hY9QbgOejpib6vnQjdHDF8/tf4eyoxyhViyGzppjtRA3qJAZS0o+cMTkOM7O2RnPUsaiKhKuH9VcgHgqJ1mRYjLGN6oEtf9xZXUoEcTx/Zy1uC9zAbanomfBcd5fpHi5/Uuz1ba+DsSYQkuqzxbAQE/8UNFZEKxB1H3xz8O3LPQQFMgxObIQo+YvmFX9jEwaGF4TlweYPuWSDt7N5sPEuS9bIgAqLJCgkOfxPCiMPjRH20Mqz2hruvoASw6X7lY1PPQGXqRLLZR9IfXMx3DGw==;
 31:/arnfy/iCtaIgb/Hi1xMdTDNFy8IQAeBlmIyHQnwdVPG1M/sbb75Phl9rTvBzmu8m4GMR3HVUtKj7DP0jO0tk2KN3t0VxHRwiPSXcOCilVKrbxCyrASwiQy2U4kdTXtU7Fhs00g0k2tzyxU4X/rk5POPkrImJGd9/7ZKoBspDIqts3z5rqHTI6Qlrccbpmch2RO3nCTqSj7EaYO9J9HjiNx63CtihjBrbVJYDwM1mk0=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2699:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 20:gtBpnFGOmRowN0gD2JcCXXMcj1XN36JJt3jpOICh2ohujTXPUkypTQXhnyiFf3UHzPPyXX1XLFGEE85hd+nwCEr/aVPAHF28TVdtc5JiB1LikYjguEeIz8HHnT6dzYVBB/tpgqosJsGgmHS4fZH6wrHfSHq8jWUrX/T7jLFrE0u5ldQ4n4oAXXHdmU0dMN9j9nzzpJazQcJoErp1O0LGYi9gqvxvqNbZ/kCeey2es5PejMq3l25v15UmOWAzUrCBe+lC96JVHU6r2roSpJ2zJmiLE84oLTKZC6EYsjs2iqf1M2/1qTQFekQhhYd/obJrnDI7ONS4K3PzFVKJ9a2zh4YYl7NlHPGigArAQxwZz2zov9uuJKSFaFfyxBBqGJXwNpWz+/vuXV2Ek9qIG5KbaDCPmfWAgq6Nq2pNJxzfhaJvy3pMHGbxylplCDExzRMvELKuuJr15CQHWhBSuAa8M0LkskuorwzkRL79XHZ1Sbhdt/ky/VWox1yUG+coN0LH;
 4:V069mYt19nQ8shGV0LxQsBBl9LQcyAjcMwoBg+p8ufcS4O0oSsgwZiFtWabL+W3tyXqVb1LCHVVHx4QenT26BpOj1pDWFhxMvvkY8majavsuO+9VnLfuc/dTdsmZwSeFqWG5qIPQHAMYfL8LTkrKN9MUCciHVmsWZjqnEbW7kGUOFXaVSkjM8KPAXPAdSu/THnA0QKBqH+KB5N44rL2UkORNL3wflwJ7+woK5MU2lo/Jn9NEqCbegKNHD4VsTjMbBbTFF5aSqIGQNCvqHRckJ+NR8zdjqL9HfwRt9Y91PY754+99ThFboA9y+Ppj1I2E
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2699F2E29DEA7E7C22BBA3E994DE0@HE1PR0402MB2699.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:HE1PR0402MB2699; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2699;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(48376002)(105586002)(305945005)(2351001)(106356001)(97736004)(2361001)(6486002)(52116002)(5660300001)(81156014)(81166006)(47776003)(51416003)(8676002)(6506007)(7736002)(76176011)(478600001)(66066001)(25786009)(386003)(68736007)(8936002)(50226002)(86362001)(16586007)(316002)(1076002)(2950100002)(6512007)(53936002)(16526019)(6916009)(50466002)(186003)(6666003)(26005)(3846002)(6116002)(2906002)(36756003)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2699; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR0402MB2699;
 23:SOZP4JGwFFHyOsHvugZ0DQp+x1wGymwC9UTQN++?=
 =?us-ascii?Q?38hNovGcjItyXbwEE3tZXrG2FNAyVILDaS58J9coJdnspRK32z7Fo8T0MAci?=
 =?us-ascii?Q?qD7t+etIvv6aEI2NVMlUUGRW0Lv95el0uWDqK+4pguzmafUWdnCJcBd4XQMU?=
 =?us-ascii?Q?IrG95xeNkhkiv5ln2yHFh69NqRD19a+/JCh2ZVuY6o+zAsVLQ1tvWDqdE2a0?=
 =?us-ascii?Q?Tdg8pVuzpq6Z3qI5ZSzlHXJG0j493nnn/RT2bpVsDAegI0duCy5XqqNTiWMn?=
 =?us-ascii?Q?PeSs+YghLAFCScg1q88W8mpShvs9DdAjEh4MrD62gZWMXY10TJmvKj0GYDNB?=
 =?us-ascii?Q?XsY6jgDRwwD2y2Cqp+21tggKex8qL4fNtV0Yjplje9DEVqie3/aO5eQpI8np?=
 =?us-ascii?Q?4SzFXAI6nWTFdmY/6r+SAhlJB8xz+UAvgR+roNxOY3OqiDHo9cRAbvI1IcBO?=
 =?us-ascii?Q?9QTeyqEwaz2Yk80+ZAHE5ygxWJ4EarMJmH9Ze95jFG4fMXIFyH00rEfuzFCb?=
 =?us-ascii?Q?qtn3OYlgGwyVLRF9kGfVZE1aifaYP+CsRbsCGATn1n17pnpY55C3Ez1DH78j?=
 =?us-ascii?Q?POgHFK6PMapSpKIarSXd0LK73Ex0ooQWqa92SF3FqrXlGiLRA9uxk2U0C3ZZ?=
 =?us-ascii?Q?NbnWLGCjGwVkpFvdwVbeSopVl6ra/o1qIJtu+yA/E1E5+lexlgwlcRw5kRVY?=
 =?us-ascii?Q?qjkNTeIhJjnp/Hd4LJjMHKnSDfHGl/XVpl8p4XsBgXevHTogYqVMNxklokAj?=
 =?us-ascii?Q?pLmFnEmFlvqvtRVoTg414RMPRv77NyTf8bdaQVPJPZHNgRn4a7vHexbzKAv/?=
 =?us-ascii?Q?YLXd6254ZbUcSZzgPZUev8qq1+WZPW0uweZ4wHWdD/gGT+eOHkuCzEqVPk7w?=
 =?us-ascii?Q?Us/bhqsM+h6SLjgb/L88SS7q/h0fkb0FtSRPtnVW1sdPF7ERxLsFS9WQfb/n?=
 =?us-ascii?Q?+oDQ6qmiE0XB7vZEz+VkTua71puYwtf9/hBm0DvJARI5OJLzgcM6tuHlnHfu?=
 =?us-ascii?Q?7zExQqq7N6OmSjpv3d/xX0y7ik9zJp7fZ4i2HiHkmlxWtTwtSREYjgYIYTjP?=
 =?us-ascii?Q?wTdjic3QzCckm4KLvEdXl4S+Ozgo3CR2qVArOICobkKsPZt/HAtN3HWjBxuY?=
 =?us-ascii?Q?S6/qzYWZGYEwdR1GO9BuHbKDGSIcRSvnH0bBxz6/ykW7FiOJ1jNS51Q=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ZxWTyYJfMBA3ffVIxY3TS6EJZpaz7RdXCVeMos3GmnTeWAyMEHq3J8bsngiEPstLeDQDh0kEre87q6pVhoVwzORJPKMwfd5fQN59tJltS2BgVj70yKg3HnkXyGNWpFoVEQrcqrve3UM2Aq9a7NkwBUQmtdDnkgTUBXa6AN7S+h/E1I55NOF+4HXAgDr2CV/h
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2699;
 6:CHipMS1KYqYJgBDq2Zwuo3qJKlmY7CpcwQsA773qcon6/spw3KDhwxYocwNDSmMGfk2Bd2UZe2J7ZBy8DgzoijjbsQAeeQO5FMNFjSPw7WbILfRjo+LVmFMa2Y8vQijr9j9Mmbohh1NH+r56j6eyZppS2Pl31jzmvr1GqUnHQmnXKzpziXVsRvs590FdruADBliXewNxPciGKaTqxq2aK14IgXSzHaMxS7FIGcd9xQc4EaaTVCuD1gZKXLz0oVZ1WcxB89a1CRyyEZgLXI3KqzYIUSrPplxJ6MKlu17BEj6XV6NE+dkqpQNjbA6UjCLkv/lWmV8LWiboqw1wl2nwagAwmKUuO+hWy5VI1Hcto2U=;
 5:EBnD4GO9cETUSQ7YDnvVoQyI9nOcm68/OOlwuTesTnDb21urzdOaY8auPcz2mamVZe8BTAZQcUzeVvpy+BdAd8LmJu1TKKu6uJ/bT/axrVNX0sOlPGnGXMND3/Ltyz966bcoD0n5f1Jc+OcxIBDMrInPzB8PIic5OtHEOEUdUMY=;
 24:C6etRVFgCOgqxmwUPmdPTVC9RgR2I4VpYwmn+AchMnSfRY3/p3aR2fKg22Xvh5Lcpi++8azPMEav0eZG+39gxP9G/nSE83M4bDLkSMgWbbw=;
 7:zckRHfvrlYmWiqvHnD54/qv/tWGP6SLxaTYLot4Q9x/zeUFL4zvZX7dAV7fNjrXJTOsJa+q1s0TeDGKqsnxKhEnntTUI5yeQ2i065qifTN49K0+MkLfCsVHWs4IB44O6Zz181/Ef4U+MI33YTAlPcyJnxAnQnbggL6yirhwnJGvbOg1XhtYEDpZHpt0SN8ohf7zEm+BpRVGcmjHmcsLOJuNjkkKhnHayZm6CmsMxH53zqtfOUyknUyAaXyacKUDo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 18:41:19.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c5caae-e7b2-4725-6a83-08d585ed5a92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2699
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
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com,
 linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

One MC command structure got away with using uXX fields instead
of __leXX. Fix it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
v2: new patch

 drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h b/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
index 3120e22..d6f96f302 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni-cmd.h
@@ -539,8 +539,8 @@ struct dpni_rsp_get_taildrop {
 };
 
 struct dpni_rsp_get_api_version {
-	u16 major;
-	u16 minor;
+	__le16 major;
+	__le16 minor;
 };
 
 #endif /* _FSL_DPNI_CMD_H */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
