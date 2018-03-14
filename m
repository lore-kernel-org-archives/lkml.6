Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932312AbeCNNin (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:38:43 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:55200
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752257AbeCNNig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:38:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 5/5] dpaa_eth: remove duplicate increment of the tx_errors counter
Date: Wed, 14 Mar 2018 08:37:32 -0500
Message-Id: <20180314133732.24068-6-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To AM5PR04MB3267.eurprd04.prod.outlook.com
 (2603:10a6:206:d::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 682895c0-526c-4383-05ff-08d589b0e261
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3267;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;3:EbSG13DlmZmiRookfdkN5EvbQZXCaaXOoSMKU/t6OPAAnLLxDciM14hMhKPbaEyg+BTzKTqWu8K1i2WDQs5RLI0GSUDU++5wR9ffpH0nvz+aw9nX958/T/QhhFHP2cxWCpPCRUmlU2h7PqDUCiTQSwUx+ZH3YtoQZsvcPguoj+h/A7fLjx37EoHvrgeg8YSXqnZCDXgvM9RBnWe2AMlnvhvIXse0dcwyfS/Bj2jwvVQwB1d9gveJ8r0T/xiNMbi8;25:kQBUDzneaUoqil15IVuxjXsRcUItJd2JQZrts+hOgeH9IHQEtpW1mCjngqmT3Y30e1/1lbWYcYzPtC7E0kajqTXz9FFeHVrZHV63FSV3V2TJJShAD+V1pHfmXAb8rAkHs5Q/GNgdQQ3ByfGJAUDpVZO4opi+qY/2CU+x9lQ21wJiuQIkla/vycDT/1BNvCxiLNP6t7kyfGCSL7FTwyNjR5ievezhmWImK+RcHd0540gur9f5JxL7ddeQRrcmui5xT38lYAU3N8kBxldP/Iule6HYmUnrmDMKkkXKxVq0DbFmjLyI6dZ4I0aIndct16fZ6jgzeV/yBlL4gnknUR7dlg==;31:j+hiY1te/bsyXka7NaTGEza3Ye9NeQWN9hrOmO/HppFwIKkZYy3lEqBDdqO6paibCW3A8bQfreSu97GXMdGcbLTVjEftXQFeEduk5rW5NEQtoC1OWyXzAMRfMt8VLwCM1wMfNfQ3/L2WcEC3QiM1upRlQi1s7SHX4GXezNjMYJtppH7LomxLcXgSOytK7ZHJ4l2uD4XQU4lIpVFXX4bX0Vya7B9xpuKTMk0X3bjQku8=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;20:E+CmxcUOZ68K94PT5QEuqnRRE2ADxX6qIGFrzn5o5hdxql9IgXNNQlL4rWcr0Zia5lSpcoD51Uq+9NB9XYKGbVBqTU+oGl+Ssnps21Ru+yYfox7eHc34aLdNpSrY0qTqaFMzedQMzTiyp2HjLV8sMo++SkRRH4mupRSnYGf0JFNqWdILTu6Ch/sscBBxU15iZwVQL3nmuT6WaOsWBVgx+Fex085FXebakrex8xgpFlqJ30tqp6QEBq85U45Zb5r6G8mwR9TGwHDVc4uHCwJJX4qtTl4Dtul+cU7fc01AE6AlmjmQkvf1fuT/F33zz9Wfb3f8hPNEPs5thgPs+yl1ClyXoEZYi3doX0cj+EsjtRsprYLq3At+cENuMAISa6MTmaJtVjDYZqsMvgPvhzZjnqq8KRU32pLILykO7TjRT47DLML4MQvdBpHnwTShpRRe9iAuK2xVUJ7fb8loX0jhnIzH8oxSHrvz81WIAKaF6/LMP4LqdHiq6UP5G5CDMyT5;4:NiPLZRXMbunH6FGvpnEoMl/gA5GRstkCKQn1ObU62X2EfiBVQZT71DKHGDV5Zocp+QAI6CrND6fQo3JQjJxy2DidPuWad1sN2vqVX/cVHDS4tlKWea6/mEV8GYRea7/x7YVJ3CvH/4OujrPKFF9Mym4/pXUo/qWlcEdyhXr3UPcoetoFfkPt5yZpoEKujnOQ/i5oUpI4cv1vpCtJ3M5Rt8IJHNCcDknCPaoU70kCtWpeyPOlQtFxuaIimk6eMDChXFLuuBcwRKwolDAzZYgF5m1mW2CPecDO1DCQnMuN44X/SpS1aCf2xDmnuL1uWM4S
X-Microsoft-Antispam-PRVS: <AM5PR04MB3267F59CB912CAAD4F13182BECD10@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR04MB3267;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3267;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(1076002)(68736007)(7736002)(6916009)(47776003)(4326008)(8676002)(2950100002)(316002)(50466002)(81156014)(25786009)(81166006)(66066001)(50226002)(305945005)(3846002)(8936002)(53936002)(6116002)(36756003)(48376002)(2906002)(16526019)(26005)(3450700001)(2361001)(86362001)(186003)(59450400001)(478600001)(51416003)(76176011)(106356001)(52116002)(16586007)(43066004)(6512007)(2351001)(6486002)(97736004)(5660300001)(386003)(105586002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3267;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3267;23:IP8Pi1zYLX1NzeKci0d7TkmFqAi9hi1q5F+/QY+C7?=
 =?us-ascii?Q?AclmX/ZlPJjLnV6Lcb7+XmvHrtMJIsUeRhcEFjsi6+nL4Xs6o4HA8afflkvs?=
 =?us-ascii?Q?vnGv83KTKeXLt2KgbwlmH7i6DU848cr2ZW3IuDm2ZMDWT+0Suvvh6t6+5c/+?=
 =?us-ascii?Q?YU8EayQDHzU+k7EWZI09gRSKUGhtwEki3oA8hqtYUY38/f5fr1PyebVcAznn?=
 =?us-ascii?Q?n+ET6aNIqzKEYL+SVmtkkoqCJgBDk2Jj+SORZg0w/n0pV+l62Jy6742kVBfi?=
 =?us-ascii?Q?Q+x5WrOS7/D1PnoXD+kBIZfbYVC9j9TzfD/m1eNRHVIwCmLnhdK5Vx+XJwhh?=
 =?us-ascii?Q?TWanBBglxV658M9RiH7rtoUU+eLd1kxsVClcbWgVpvYjF0hWanIFyUu4NiMO?=
 =?us-ascii?Q?Gy3BHZ1OcceZH1+IzTkm/ULs6ASXjbGBITtaAZ/h85Z4Ymcbez9Ib/vxFgB0?=
 =?us-ascii?Q?xiSkhZbtAd/F053B07YxK53LhZzTPSmxJ+xrQgt5Or/BtjhrPO5Ks8+HQMgQ?=
 =?us-ascii?Q?DfxKZc25EHfcWEq/FEKOK9rIL9mIKwVEe8VC+gHq0AxgV3YIlmHQUPpup2RU?=
 =?us-ascii?Q?X5x/8OK4p4wHsbutdwzOHOEo+s6jOaIyGvg3QOS4UMv3O6A5zvIrLepoTSzw?=
 =?us-ascii?Q?a12BXKjBuhSHI6ZS4efy6vBUu06r8bUFtgn5GkEYsJhFf4KOa/M8kvLetyEn?=
 =?us-ascii?Q?yLHI1jsRIzzm0mc26ZGx63yvihi6vYU1Wz4hLsoKdbkSchJlX3ihhOi/jmVu?=
 =?us-ascii?Q?jtiyHjW6DZdXhCtOhIxhHhKyyA9tM7NOi4obnTuOAVidGkveepmc9AgMx1jo?=
 =?us-ascii?Q?5Y15TCGVw3wxNq2TWxYs2OBwbX3Z4d2ZBZZnX4J+IeBevsAi8EFAY79GSrga?=
 =?us-ascii?Q?nniWTMm/gmrA3M0id9vzN2wgob2neHCYXQ8nDGfnmTu/o9gwNCKF2OWt/uHx?=
 =?us-ascii?Q?qRl2Cs/gB7XvbVDcVI5ggrkHkqouyvQOXzj7hYhEfg/LN9g8hyK86EqCOZwu?=
 =?us-ascii?Q?6+qSanqeq9CPy13IPBBB8NyF62I1ZwfUCeHPlFiEsLPIdW/zp9kPQBOvcJ92?=
 =?us-ascii?Q?3iYRT61NispLV+2CACgshD4vEQrROwNiOWBVRa7andJ25eUoufeL3OsQ3OSU?=
 =?us-ascii?Q?YqZjVU99x72Vgdyh8eq6AbSYEX8spejSQfEYBw5DEqUlu3hVU3m5XWOLXg+Z?=
 =?us-ascii?Q?szKfDDOlmHtVhUI4IDHr+KVx6HPKtObuZLj?=
X-Microsoft-Antispam-Message-Info: jhwa7lcXSQyZxhb1n7POuT8ecn73FxlpSagVoZxfq1oSlqsM5K1YEUXSdZi3G7JGeD9ibq1fUBD/KwD42wXCuN/Jv8md4vJ84vKVm62vvzzSVvZz36/3VjeFIyvw1FQ2yIAXv1llUTG1FqVlY8t/U8NElnhBHROCkskztfTFcy642m3OzgUTIEK/VG4Ya+YF
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;6:VU4OpuDW2JZ9KJPsaYcA2vYnDIw+TLjHgkSimdEqKctF50PNDg/iOyv3XKQpH/Ivz5VOk8/oDsX20y0KjhnCxAiFHcGO0fRKp2StO4bhIC4tFXjKCwqGVrW4/ilqV/bWs+6zQqASX4R2v126iyqqcDr/+YWEnmu2nrSv7acx5OqJsbni2NZ3M+ZfMDbS/TpGODNoIiBPAFvcrDrCFMrpWInRo/00s8QbrH3AY/6eGrGWclEn6bShPHKFLEYxgaBe/qIGKI8e61YMUeT7ZUIdWOXV7MOi/feJ0FhPZW2ycQwlWDNs8pbJMZeFduPg02qpFOrUoXvs0g6zb3DwaM2u+5Li8BtxKwmwSkAjgKMt8SI=;5:A8f0BIoiaJ4GZ7BL2av4+pqnUmh8BNloFVI07UUTqpfnK19YQsXRKLXZtQNzsItjhQgRDlK/UhmvzXnp4H7UC2Y17AgBozKRK3zQmDitmXzNjTqOFuCOFkknfTgG7ym5cVm/zD+eM+djhzQUhyrWU/9OolH7dBVdD6Cgs8p9gjY=;24:5kwrjZ5FTL26nQRMqmD3o1z1ojlJ2j2ofGkmqFt1wLTeFqI62sKv59MyDVNiMJdjoqn8e8TDQbx4yL0V2zDHij+V6LqQgZ1YadhdoeuwjX0=;7:smskIj8nwUx1jJ952l6TNILQUI31m2kJfWfHv8nYKolBvfRKvw36U/YOY2YnPFT1sNzBOnmsxJi/Iz5T3baBtBQwZ4jWUYO65wdoxeyrEp4vZuE2cwAPKs5NI+XApBBGayJHou0Tn256ScGwu0m/asbrUja1ol2E6xvh4A+Kv2GirEdZVY19UtX0f8FCj5GRu37W+ETbaWzttAdeOnLT7cGQWjtIthbBR7Da0K/f5PcCiGsLgl8yqy4SnFfORCZ5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 13:38:33.1957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682895c0-526c-4383-05ff-08d589b0e261
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camelia Groza <camelia.groza@nxp.com>

The tx_errors counter is incremented by the dpaa_xmit caller.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 76b3c9e..fd43f98 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2021,7 +2021,6 @@ static inline int dpaa_xmit(struct dpaa_priv *priv,
 	}
 
 	if (unlikely(err < 0)) {
-		percpu_stats->tx_errors++;
 		percpu_stats->tx_fifo_errors++;
 		return err;
 	}
-- 
2.1.0
