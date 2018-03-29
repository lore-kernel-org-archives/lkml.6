Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeC2JaA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 05:30:00 -0400
Received: from mail-co1nam03on0050.outbound.protection.outlook.com ([104.47.40.50]:63650
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750884AbeC2J36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 05:29:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 29 Mar 2018 17:29:40 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] net: mvneta: remove duplicate *_coal assignment
Message-ID: <20180329172940.4a5f592c@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0002.jpnprd01.prod.outlook.com (2603:1096:404::14)
 To CY4PR03MB2631.namprd03.prod.outlook.com (2603:10b6:903:75::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 358cea8e-9745-4e9d-7e01-08d59557a20d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR03MB2631;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;3:LUBlm1Mjurt/zjb9L7b5oVNp7IADY7WEVIv1PZ4UXlW/k1MRLkZV3LVwtSxOG5Xfy5V5Uk8Lkemntq048qt+aWrR3nOojy6L8M0Cj3TlagCxr5kzUshiG1csqLHzT1ykSFRYHRfyRP+PPWgpy/zxrd7QvvlsBqKwbM47x/jGGqRZeUeju+gDDaOO3hGWzpfJbCextWUj+DZlJ8EMzuQwzP3MXlWeXBQkjrqbT7++omCKEM40FWz51v3Ribt8kGFF;25:KJiIDsBmD/b7BHDCRZaRHBzoSTUzmm6v/IIDKNFTfcvrVqPQ9q+jQRADLGVYpzxSKrXtNR9boLFS7TeUUxFmvG8hSaudxL/IsBgGvqG1OvklBWeuRU1I9E+BfZXW5QzfMqZUisuO2DKcRVPIiwNGQdc2t98ABC7AfgeA4lgBTNiCQQuCkAJ6ktm78nOoan8Lq9yt2uu/TxHsDp+byQmGJa3dqOzz1RWNurpA4WB8mjGrnMGEgt9klxBk44zvtHs1Q9pDehW4DgUrH8450YcZ8FcVDRHR18SMyWJEIjmdUS5lQSqpYB8CmSsVwzTEcVeil03/E3L/mbKNTuXKDCbO/w==;31:KmwZUUa3kyxS+jEUvpMivwxXf8uUAc6i3cVMH59nm/00kc+fo65cxQ29UoxD4Ve+MmTRGL4Ut4zG9S1V9hU9iG4IvQmSPckYQPHxMf62yNwrnDvCfOQotVWw2M6LLqfVgrTXO2pF5Bdlj/J3JAkI+RVD9fGhYrFHv3Y7JSX9ngrRSJJqNqZmV2DtqyepzFp6BmBrhp0H+knmu+FKrxlvgkO7sf7PgSaYP2gmjQ16aA8=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2631:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;20:rIXTKZTceB4PcXt1G8QsuoWOqayx8wuGacnlaCJKNp8qpvUVNPPRUJA+JLG+NU8PqoDwm6OpB2W7UVOkR2mpBJlhcdzjf+8aMH0nnUlpW97sUjuJwBDqRlzw1jAyGaQfM5vsgHY6D9SSDeKIkkpuYGpSWpFS4MHBPEBBuAAksi4FqsNbl8rZDrK33Ix15Dmxnmb+fhAqoG5kNaCNDTpviE3lpoJm+pVMIulBUVRyTXBq16JrBFpiOHg3aerUIppbtXuhkdJo/6h3w5ZFoRjCY6TbH17aMWB/BBowAVUMCEwoPG++z95aXlSUe5tr2jgkm341coaH8E1FpZfVpyULUDjQzWSCnMdZ2OyWvj1ohxNC0EFqeV/WEy9it+0t03mL50gf8pj+cVBSmBCe6AflKgG3i46R6MEbrgWPayTzSC+3Mi/5q2zWUm4RxlUVAxZJv10fHmLZoq7qFteuD2G3us+20/k5qetWuoh8kJoxnFg+5fy1Cu0fqE2TqmcyH9lo;4:H6okmPjRwBixsEaEkXxhkQbojel8WNljEWyS5EgQcrXUHEnU/YCGtc3Vr66smvIpryrRZ/nLtzvT3cnaiaAcnR1LmYK8Y5BxEpBrN/35PrCIwViTO7AesGo6GidNRi3kRNHj5k6rmiaS4PnCO7AaeeOxwCE1JZY4ruvsOjyY9HyfQ0IkvOEAynLWkvBZG9EX2qXh6s91m5p/fMJXrRwwhDl8SXhuuZrPApOFJhnwQ3/0CiiyTEj851gS6z0XbLlbYu9lyQzuQM29LZ8gy0jP6Q==
X-Microsoft-Antispam-PRVS: <CY4PR03MB263154FD83711913D78C5E7AEDA20@CY4PR03MB2631.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR03MB2631;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2631;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(396003)(346002)(39380400002)(199004)(189003)(9686003)(50466002)(8676002)(50226002)(68736007)(16526019)(55016002)(72206003)(8936002)(6116002)(81156014)(66066001)(53936002)(23726003)(26005)(47776003)(81166006)(486005)(486005)(2906002)(1857600001)(186003)(86362001)(478600001)(230700001)(6506007)(386003)(3846002)(956004)(33896004)(1076002)(97736004)(110136005)(316002)(52116002)(105586002)(59450400001)(305945005)(7696005)(106356001)(25786009)(476003)(7736002)(4326008)(6666003)(5660300001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2631;H:xhacker.debian;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2631;23:6pjC22sY8+ZXrMnIbal7ZQwn5hMEku5n6+tXeUxFi?=
 =?us-ascii?Q?V3S1Uc91iCQgFEwdelRO2+RfPtB9giFA0q7Rq+x4AYgAWcx7Zy/XPakxt10a?=
 =?us-ascii?Q?kdLi1jaUkvkgFKh9QC4XkaIXaLzmym1mrCb3UT+zQjAnNPMSpn6OsitbMWUn?=
 =?us-ascii?Q?arw9GBpuwUbs5VJ94QmGoOxnb2iEyP+C4g8P3wLaLIeR3N1OYi5GXPfIYeEY?=
 =?us-ascii?Q?gVH7hEsBEE8B+RI5TrUAuySlomy9vdL0EiZPpmM00GdO/ZauMJPPw2LjFwAk?=
 =?us-ascii?Q?nct+JpGPqnTRo+/SAGUk5dXzhqcLoR9kUafaGFIuQq88tS00o5R87avwUTQ2?=
 =?us-ascii?Q?e18wbZoCaKQyaPW62CTskYokPCRdDAoT7uhkEpzBx4eYGFEIlgYPwXCS9Jra?=
 =?us-ascii?Q?tb1fCTIQpIaMzmkK8l7pexH3D1vkIT+CtCYyx61HIOwQOrLerzP4aIrmLmA9?=
 =?us-ascii?Q?isZWbYi9nKupJ1D2QZc1Y1IepxWlDsEh7Th5eEIajCceGs/tnHEVE8TOpG+3?=
 =?us-ascii?Q?TYrMSkroyC8J73AnKf7pnRUcRB0AE2Dq7uY7cQur8cbcSbT7kkZ5WbYYGCq9?=
 =?us-ascii?Q?HOALCbFCNSPB9z0PIt0oOpZ/9IWly+21bnR+6jW8IeTREo/H06lFMydSQNJ/?=
 =?us-ascii?Q?KzfBD3cCIl9FHLCxzL6gGpm8VcoSGpK+4fHQJHKDfSbQDC+iFoW6gZzZZ1Od?=
 =?us-ascii?Q?SXEuw/PFbFUURbWFi2nEvcVBaz21M0rOdysQ8csKL2VsW/LCIrcPtvYs5SNX?=
 =?us-ascii?Q?8+Q5m+yJMCm6DnmhHmy8F85GkkC6+nlJyfO2bm5TPUXd1wylyBtZPsBQvpzr?=
 =?us-ascii?Q?5XE8jppE+qLOLx3G26tCiKNMmKcJ6G8iCNbnd7eC0EwZDu+Ky4RIqkE6uBTe?=
 =?us-ascii?Q?eXsBpxbiYLeKLPyXP4bReIB4iw9SV39ms3YivRlHHkFHexRXTxPP0DVC27o2?=
 =?us-ascii?Q?oLwy9FC2j2k+ApXDPwsCSK6/PCNBA7VOVEF7daW1dpJ+KC/iN8gYIs0FPMZv?=
 =?us-ascii?Q?oYNkPJU9qRl5awh5az8m04vjAWMEkcLkbvMRFXqpoOsP5qnJWGWndxM4sTym?=
 =?us-ascii?Q?5Lq6wkoSOy5bEFr+8MSNtfWjP5TjVLR9nOa6iFveKPko2gvy+uMItGOck/y8?=
 =?us-ascii?Q?gDYchNr9d/MdPA2BbJ7dCXIXDFQ715JBopjV+cw9bhq2t+nx4JF6ENfcOFzW?=
 =?us-ascii?Q?AFVcAyoUBTEuxcBSUoHJEOtklR4x3koikeFTL60xv2jSCnp3qjlRNO0iQ0mR?=
 =?us-ascii?Q?LuJyVJlNnJv8VdTaFA=3D?=
X-Microsoft-Antispam-Message-Info: 7iZfNmJuCTjfuO7XIeFYDgkc2fyMkx+hCfoURfIU54QNrdXDtlkR1dAck6b+A7hcFJYypj1nmmpzrBwUa7i+uzkvtVpwz8mI1dc6Y5rY8UmzwhsjnRvQ8mwbMXWp8jUL5dAASsKlg+OWhrvuh61h5UX4GlWUh67cqvbQDuA0IbbXpnPwKB+DlhPyATgH2eMY
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;6:AoefvaGwhMJoIIhr2Xj9FY+Xln8NkyHwNX0RG5ipACWaAsxKVdqffDVR2bsSH/2wiZNldHYUQ93v2SB6tGnuSwL3eF+wjQJ3ZzTNkny58yc78DYJTG4JvN/lJp5DyQBcTn4rHDUTHUxVonEx5O+uxCw6Qe42BlXYqF2ca4VcaCRI7St9I0s60UfrKCRJp8/Vj0oLbixYqnFjU99HbNg4dNQEnvNOnmY5S14qBe5WJZ6B9/S5rUtm5KUSWJlTPlyARMDBj5Fb3/ElliDJuWvm9UjmIpc7LJa0V3kv3MAxUaexyyUX+FKL6Nfu9AFijZAZGwVXj0yHfeUuKTX1v/Tt/U25Vhwm3/TorE+koYWqCRPnfFDyXVI1yBVZj/GfkJsVhnezl4eSi2tJph3mlzNc7AdsAskhPith20OWTZHSZZzJFJ9wJtC/e5+v6i97Jw9RIolx8uSQqaXJtHC8ItRfJw==;5:+rQ0cKp8ycTmQWJ6KvhwNMy6VmjO2hLuJz86nq/JpnT9Io/I1aZdPmdn21ICr2bR7X77gWt4Zqci6p7JilXbMpcEPIYzQ085qLkm7H9pXdSSrFOF/p4bIYiWIi3uZpxOsJe297ikeX642nFZ0NLXfQ6AqNQPWI24HTXN8TBgxxU=;24:p9xXqQ35zY4Sq/mEPLV92dbNOUcztvN4xW9iySNeLXIhtcUAHmsvA3p2crpQmgrEazvL+7bQjDpYlMc+6rBHRe1hBJrDV43aEXIHviom7Ho=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2631;7:MJKlApKiVG4h18oPFWrwM9bn4Xav2dkilG7Q9g0/cKW1aF3HX3DIXHr/+NLxAOYy7LiG08i5tCSAnGGFt8GuGSc2fYgYldreugay8ZILXmH6iPFjRv7HkA4FxTrSIhqRGLUhy9P2nLb5BR6FWfgKDmEmM6clwestViJaYgfyUZ2uJzttHVNX2XIQNqYcLTswhtpYHwsvNrHr+7iwKI/D4heNTqTfE14GU98N57QEZ5JaREohckvwXJHMWHhDPPUA
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 09:29:54.2060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358cea8e-9745-4e9d-7e01-08d59557a20d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2631
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The style of the rx/tx queue's *_coal member assignment is:

static void foo_coal_set(...)
{
	set the coal in hw;
	update queue's foo_coal member; [1]
}

In other place, we call foo_coal_set(pp, queue->foo_coal), so the above [1]
is duplicated and could be removed.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index eaa4bb80f1c9..30aab9bf77cc 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1555,7 +1555,6 @@ static void mvneta_rx_pkts_coal_set(struct mvneta_port *pp,
 {
 	mvreg_write(pp, MVNETA_RXQ_THRESHOLD_REG(rxq->id),
 		    value | MVNETA_RXQ_NON_OCCUPIED(0));
-	rxq->pkts_coal = value;
 }
 
 /* Set the time delay in usec before RX interrupt will be generated by
@@ -1571,7 +1570,6 @@ static void mvneta_rx_time_coal_set(struct mvneta_port *pp,
 	val = (clk_rate / 1000000) * value;
 
 	mvreg_write(pp, MVNETA_RXQ_TIME_COAL_REG(rxq->id), val);
-	rxq->time_coal = value;
 }
 
 /* Set threshold for TX_DONE pkts coalescing */
@@ -1586,8 +1584,6 @@ static void mvneta_tx_done_pkts_coal_set(struct mvneta_port *pp,
 	val |= MVNETA_TXQ_SENT_THRESH_MASK(value);
 
 	mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), val);
-
-	txq->done_pkts_coal = value;
 }
 
 /* Handle rx descriptor fill by setting buf_cookie and buf_phys_addr */
-- 
2.16.3
