Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3288027-1519662523-2-2921444505810351098
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enfrca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519662522; b=ronklGoGlWOYlbwOmfOrZgduznET3B6RFbRSvy/dA+NTthI
    v8qy3OodDQG2WJD5pQuf5Unq2iW8TBoYidGUEJpkE3sD4pkKRcIGa59clDA4KhFG
    1ilkxjcdtprRL9Fum7VbUjmL0zommwggR38xF+gn9u9aAZBZ7mcuOeXRPEnLRS/S
    67gR986EtpdrKayGbOcUr5KdFWlLT7e2wXxxxqyUZTUrdrL0QhVzqMmskcYMakw5
    ls+1tDt2vATKmW4NTcVPa2kq3+ExHFejZHgmkpeS2AXTAR4XeJ8ucAHQPdT2MHqs
    mdj461SEiHz0QIcvvhh/aIxwQ+s+5bGvKS9e5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519662522; bh=M
    h2X0kwQpZD+VUd+clxTM5+W97FeZrJYySrADVMnshE=; b=joUQvOky8zSAPzcIV
    U85cn/9411GjFi+klpKdv8OYuxePI43GLoUKlY6G0KosMTk1ZVr+2xdfwaXNzTnq
    d8RYf50MT85skrbP/KYAz3IK8lDvHTOnKk2G7ZMuERberV+aLdivQEFL5u6SCBZU
    X6CPATUkeBqthafDt0sNoKD+A4LVVmYghlmZAETM9GzDdWGPFxk5Qcw1aJ0/IKSF
    zt6DBqGZWCMyFfDZ1qCoXiaCCDzzeEDyo09pCenC1t0niEfHui/7w0xPhXHVPEri
    I5mdZn6tLEwB+HG7Sz4/8AVGHpa85b/fQ5KtkfZ17L8voysQqOVI7Cw2UIqLd+Lo
    9IsOA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=OlHDWzH0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=OlHDWzH0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 3/4] staging: fsl-dpaa2/eth: Fix incorrect casts
Date: Mon, 26 Feb 2018 10:28:06 -0600
Message-Id: <20180226162807.20649-4-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
References: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28)
 To DB6PR0402MB2696.eurprd04.prod.outlook.com
 (2603:10a6:4:94::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa9cb96a-c5d8-44c4-5044-08d57d35f838
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:DB6PR0402MB2696;
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 3:MOjmhkzzgenIbKFtRR5AaAgj+og5lfIWZC3rHGm9EYOC2FoSOhttWRceZ+qeRSGAkp9Evwn7wPJ5Yy/QeSNhR0mN/yONzz3skYTfx/si6VONNRElV5Pdxaau0XP0s1rZpp8JrFBvvtqs/zIm/3DMuZG8HrawxpoT2oypcDXA6VJhc/JIvKtZ2ahBDxkFMviiltqy3H50PQLpMhJTOsRV2J5MtsGoLdr6mhIuAxkiU6faz/IqWWM+3BQy/4rQB75b;
 25:y4M6Sm9kXL8fEGFlHhe9v63D+1NG+f8HGqYwNaSs9OMgkbtYTas3mfpjyeC9p/WskkdNJq+CfNeoh0IAYOlfvGDB5DyyWgEdjYLwh4NIdF8OBMzYKzN30jUaskF/7860ObxDAIjLHPHv70NhBZlvWtSUYG0l3wLpMgpcYEFgMAkFD7LzVDYyj5Go1gGNNm8gXQxS4v+JMnbQ3BVOZPU3FU8jYTaXQnGPx9TWVvyRrswQIbYly45n8AR2dtx+DbuXp48xWhl1sP+c0nz6Ztwj+0LqGR1YOvXgNgubUAelLT0eLXZJnWd05Xvqkjdnjvk2PBxQ1mk5ChYOakZ4d4q/vQ==;
 31:MFH1VTdhh+1TSaUbTtlCLNoPfBGl/TmyBSQVvo3X4IzYfVhiRdcxt7n80rIqACDbeDnwmqp4aL3O4Op25bH7TPaRqNyVJVrm023+zfM3f9RzFI0JbdXkEeyFDkCKdS5+pA+/2pXl/DjpoUp/nmlOLWpK4VVi/gskIr5xJICrHhJFaBSiQSW18iIYa0RdH/KxuFm0dQvTfQPBeM+S7znodvq6dHn993N8xvVle74bvBU=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 20:KGqSERZu2YKdF7lFNxfkX+9Z5essJoZVyKcBp5MGCUBgrMOGpv1J4wXyyvx5j+/RgAIyzoVFK9eDgyxpW7xLVA1ZjMN29VFWdvvXH6OJvhFM7QFDZIwsvlHRrvNqpkY7+KB4nEvNDIPeVX8xlhs0XJLC1ep0cqJJl1c6m8Er+2IEdaQGht7rFmxLtq4T14Ve2tTQB1vT3lE1S01WjjbN0xKSAaYFr9DxdSs3SaKefVzADxn69y69HBcyEazNNmZ41M50Ejx82f+oBesWdVKg+dgu5gri3qd1uJgZq3qAoreUJuSIPY/059Iem/w8O93or0GWbDjXzKiihn2zAFrsSN0syJch8gE4ztnc0hoz8VvaCFlyE0714sksjFOXtyv2lQEsTBPaoVaB3zJFPRMd0xLMdaOY+oYsKf/EzJkXYlu2OJSqOj4JKyJmLNOXW5jmraMIwDUGLdLNwl/N5CYYJ2mUswDM4PNI6hHbFd6Bc7YwYi85AFEToVRq+iIT0Csq;
 4:x9PTZ6r0vhUBe9RBNl9wvMyUTzJHYPpGBnFGnJ2jle1vh3F2qVzMsgwtMIvrfv7GHVKidjkN6znggunVW8cE+H4iOoAnkRQ0leNlqyG2povVB6/m8dayP3JAtefoS/01E87rxsnWyhDuTK6y+1Bg28A9EhrgEnmD1QfiCa7d9D0MK9mMCpLAGrvIMR4FOsgiPixwlUwqrGDAEkdzda2gP8qx+cMlOf8GAXX26FOOAe6+jQklWeS0imyoPqvulezTOBOIHKGE8JHQ89ZQUsNESGvbBrOdAfMdrOP6RRDFjK4NuJY0dHUgpafTDeaM0++w
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2696471E4BD0CD2AB37A9E1E94C10@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:DB6PR0402MB2696; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0402MB2696;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(39380400002)(376002)(199004)(189003)(2361001)(51416003)(106356001)(50466002)(26005)(16526019)(478600001)(316002)(186003)(105586002)(52116002)(305945005)(7736002)(16586007)(81166006)(25786009)(97736004)(5660300001)(2351001)(86362001)(2906002)(8676002)(2950100002)(6666003)(66066001)(36756003)(4326008)(6486002)(47776003)(6916009)(53936002)(48376002)(81156014)(59450400001)(76176011)(68736007)(6512007)(8936002)(386003)(6506007)(50226002)(1076002)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2696; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB6PR0402MB2696;
 23:LPdUdX+z5EboaO6zhs0bx/9MQefE1y8R703hXi9?=
 =?us-ascii?Q?t+p2UXkU79E7UfHZahnz8GLcyAZPXXpS96lyEDHsfr9qFlBvPTD24KU8/YHy?=
 =?us-ascii?Q?ECrSDH3GU/nfEGyRpeb0+9EVV0BYMiPeh/n4xqvcf7lD6kHMaOmne2ikKy0x?=
 =?us-ascii?Q?ku+F/NMBRePbQMFP+u0WaCKUCTC/48UIWolBPHd73BZmDzMqM9YC8f97/oRo?=
 =?us-ascii?Q?QpuPiA5RkQIRESOtCSC/nJSbzlJtqfBQKkWR25ijXe5k+T72objPWqBntte0?=
 =?us-ascii?Q?konJngB9Qp0M/o+w6k7j8ZzNgFyXIWZr6nExUH/rh2FcKj4PQWHVe4DSN40g?=
 =?us-ascii?Q?9Ox+dB1aAKKoAIyqkEWCdwR+1T/604hE0JSABYQ2rGkXfFuPTIJkJOVW5Far?=
 =?us-ascii?Q?AlgFWOP9dpnoMWyGL4aEDuFxQ120FT3SGgUokO7bGgFPJQT4+4O/ZrKro6k4?=
 =?us-ascii?Q?mEu+lzJGMQgVorpIp+kJR+L2FsKE6z4mXFOMm0R/XNCCb8eWjsMdru2OL+VF?=
 =?us-ascii?Q?o5E8FrxVCWa44Nh8hDViaWGk6Di+obVVyv8D1/l2bCTobYrfEVCs90Qexoea?=
 =?us-ascii?Q?vZDeNU7p/g/G13EhK79oGV+bs8080j098hiWkvxIRYLwuOM3ALLKdq+lDC8L?=
 =?us-ascii?Q?RrLcVORFU0m1Osh+G3qt1HZtb9XkdvdxXY4p+SXu/5VT/snraxZuLYSkpQvj?=
 =?us-ascii?Q?0IKMkSkIXmDTO+79uJsSZmKL0a0s+SlD1I6qPrBbxp6IgELq8WPUqNWBLVAF?=
 =?us-ascii?Q?7UAAZLqsjUgzM5JPx/KdWjkVOK8xLE1P+Zy/ZC9hVIHawqNv6l1IEKi9hEf7?=
 =?us-ascii?Q?eycqizzs1TK7x5Mmb+brpykGRSP3lJWd+slUNXieMzQbEhwZ66zY9h8NyASS?=
 =?us-ascii?Q?p8HfflTgDatb9b4XU5R7xHNxCSIh3EuOV6XQXTDbI3U0UOFIYqu2nR+RMAZ6?=
 =?us-ascii?Q?tMHLWLAPkoNZ1kiJedfKci1lFwMs0OVJTEtwG9zG5LAimPnmoeZZlKnNaXQ+?=
 =?us-ascii?Q?Ha8RIr9k2XWu7uJz5JLtBwtKRiQ+wBNAFcIkrBYSo6Y3nFbHYnaS4OmUclg4?=
 =?us-ascii?Q?zK1do92yy8s8LAtHk6OkfrS8IZRvnxOUiOTchVNau/XI2HlaNELZ7ql3U8Sx?=
 =?us-ascii?Q?CdFQpars+MGXbEYpwdaG1E1DlDhLBO0SF7zj+Dfo0RM9kEdEL3kaUEIKPRGV?=
 =?us-ascii?Q?buGcaDShsq2+UCMQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 6:+zUk1g9G4FRMFv50SghyhX6f28O/IVWlAXkHeDfqmTtNzBO7BoNRw5rJv5ZQUT4G19GHusiyyWKKZLI31ymQe6EdVl5KJcoYwvwj3sWVZm25rwAnHfTgbMAQCo8nEIKQ6NSjveuXZDn5vQcdxfYWaqTy1pMUaypNOSNiIV0uxcw00lMKmHg3VbRHOTD2W5U14bXqPl4z6Sew8vfmGuW2ArcGHAdDn4GI2VhK3Lgj98UWsg52FMKy9x1QUXpOJL1yCTeHFy0kmVxMqcrXiqdyGG27gfQCkkIubugAxSLe6/bBKyGL+mVbtYRGFIYTztc6XEkFMZ2RZgEX5T2DWVrznnBY433ldcqM+RMcQNpr69I=;
 5:u2ehjgjb5Dkv+qEvFQHp7abRFhsvhgwl6cx+Js/auMB6LcJLcofdkDG8+sCF2qb0s20n+29FFP1EtNHwbh/zrLSIIN8nlI8gdHhqF4aUZ95/nKY14FKzgGGD5G+pmPuPj45NxomQfuzAyEiwgHdN0gLLNWicZohGNJrPa9DCJFA=;
 24:pm89hQ/EXwsca+xN6sX/s27dPhMqLfTuR/8QXfRUVrS2vNOsM3gl2hUzUNUdmltvS1hMbeQsUmHapEU19evaAoLxh3iIZXN+8+TLXpZjbOM=;
 7:miM2ByQgUJbImi76evJkp5bhyPhVqFoxDXatIk6I2obX+1kVPct+1w4cxvnnkSKSOTmxC75ZAqmh0Qmkp9jcspDGMJYMtb8JLvFyFU6h/MERpsroAgEFJ9nLc68jqusSiP0Vzt6WOZHKGUNUQ//9PzjFkADHB18iljCqLeg7o3HIesexK8XbUxFLToZRLXgtEJkPRAaMdaS9Pd2deI9R/WR+7BBoPJGC6kOHApd31mbGu0Laes5+F85HubAft+db
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:28:28.1471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9cb96a-c5d8-44c4-5044-08d57d35f838
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
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
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com, bogdan.purcareata@nxp.com,
 linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The DPAA2 Ethernet driver incorrectly assumes virtual addresses
are always 64b long, which causes compiler errors when building
for a 32b platform.

Fix this by using explicit casts to uintptr_t where necessary.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index dc7be538..c81a01f 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -324,7 +324,7 @@ static int consume_frames(struct dpaa2_eth_channel *ch)
 		}
 
 		fd = dpaa2_dq_fd(dq);
-		fq = (struct dpaa2_eth_fq *)dpaa2_dq_fqd_ctx(dq);
+		fq = (struct dpaa2_eth_fq *)(uintptr_t)dpaa2_dq_fqd_ctx(dq);
 		fq->stats.frames++;
 
 		fq->consume(priv, ch, fd, &ch->napi, fq->flowid);
@@ -1905,7 +1905,7 @@ static int setup_rx_flow(struct dpaa2_eth_priv *priv,
 	queue.destination.id = fq->channel->dpcon_id;
 	queue.destination.type = DPNI_DEST_DPCON;
 	queue.destination.priority = 1;
-	queue.user_context = (u64)fq;
+	queue.user_context = (u64)(uintptr_t)fq;
 	err = dpni_set_queue(priv->mc_io, 0, priv->mc_token,
 			     DPNI_QUEUE_RX, 0, fq->flowid,
 			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST,
@@ -1957,7 +1957,7 @@ static int setup_tx_flow(struct dpaa2_eth_priv *priv,
 	queue.destination.id = fq->channel->dpcon_id;
 	queue.destination.type = DPNI_DEST_DPCON;
 	queue.destination.priority = 0;
-	queue.user_context = (u64)fq;
+	queue.user_context = (u64)(uintptr_t)fq;
 	err = dpni_set_queue(priv->mc_io, 0, priv->mc_token,
 			     DPNI_QUEUE_TX_CONFIRM, 0, fq->flowid,
 			     DPNI_QUEUE_OPT_USER_CTX | DPNI_QUEUE_OPT_DEST,
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
