Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDQJFD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:05:03 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:61600
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeDQJDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:03:21 -0400
From: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
To: andrew@lunn.ch, robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org
Cc: alexandru.marginean@nxp.com, madalin.bucur@nxp.com,
        vicentiu.galanopulo@nxp.com
Subject: [PATCH net-next 2/3] net: phy: Change the array size to 32 for device_ids
Date: Tue, 17 Apr 2018 04:02:32 -0500
Message-Id: <20180417090233.21548-3-vicentiu.galanopulo@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
References: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
Reply-to: vicentiu.galanopulo@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To AM0PR04MB4116.eurprd04.prod.outlook.com
 (2603:10a6:208:65::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4116;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;3:UJjNWAgGITgA1nzJCX9C4//sU3dD2iG155s7PH6jpRFOXSVgeWptAniM1NeSD4rE82u9+BuyyTfuzNpGn8YUTfUyh0jOGpZG2ITBCd/eLiCdDhOAF5gEBsKm8tBSLAlt0Z8VP8sOeTds7p9mEpreGbFw5cc9A/waAwc570+URqnJrV91tYzD6OSGs5atGYv1dnLYGVK13TYhCcTqRK+29C9z4xrjc+NcJHMq5sgxgXRNh/HFxAO6CD4YSC2ZK3tD;25:FCzNbT2kn13I5PHejJtPCRDf+7GJu9C9ErpYh12jZHqc4MsHvFYoKUd/esQD64jXcfEihLgHpURszR+mHh7t/K5jNPbTNTRAWX7BNeEeG70qrJVz6lQr3hqAWxbMXxvbsumhnplSWPWE2hXFEbROiZABbku5KIm1xH5bd+hr0D3Ds8pI4erqK6dGadnR5wZx6eHijT1lNlQLwFibmox/RASyRJPGXsbh3wMRrh3j46fIIRRwg5rsVmx9x9/+Soem8+gxQVBUR2Q4ZbH6c8zQ0KBZzejys4IjqIM5ItPpvT22SuIktTlaTBJ1WtJawRb9J+TPvz6E0qbYDzPHgbSpWw==;31:Dp4JM6fsd9inKhGQAgVGIl3hARsUuYxKEbVSD3zyfGwugikHukpZ67Vu9hEpL2b+p1KmCwICPJDfQQA+5yagx8L9X4CtWOJOaiwno9/SUJ2RcwcyLhsGVmDticNtuwl9V5Fylb0Qy99eDMHf7He1/5tk4n9d8wg8jn5cS5Hh6Py4odaWmQRJFqxfAokNCP9QvwFw0aYZNnHCeUnwovPsXofSkEgzIDNcBqESacAmCmU=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4116:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;20:D8a6o4CoqV6IbM3nEdSUjhANDxZ0eVkr/PFTQwTK5TNNQ8bto0kZzLCyzm5fdOl+uWdN7nt5nPGatJah4eMmnRhNgfcOwZC9QTHFrPICKlnymjH0dyqbWD5Z3lUEq0LXYFYBzn181NzngFYAzC2yTq8kFRysD5WH6mzhe/QyBKIckqaL+9N3Aq2vnMGY2Up6acyzj695/eW4rwfZXMxJ6BUefsEheNsaOhasxfbcHn6jsSESsWxL96ejXPfzoJpsZy5qC++Kj4Pz1QWrz7roMpay9SGz5ugmM4QlT9PURPCMTvV1jX4mdKWHGa1b2EQr4DLI6QSX8OEH++QWdm/CsbtCZRb6HaBrX4j6uO5biag2o0yI4dmupCW89odj7EPO3bI6MsDZIU5Fb4/dufHWvjPM4b5PWBZfeAcFKJrGPSFXC3lMr97wXEECK0OpY3AAK1QIoKtkp4mPXLHLWT3K05R3PZFXfAMszXWN2kmRviUzmjks0PO1vRRCYG+I6p66;4:MJPnj3WRBiqXwsZ5afqRk2SzZET4JHze9xkBf3UQmd36oW+SISdvyLVAqGiX8SeCDNtM5W9aPiVOryaWBcTeYT/O4OjliftRBwnZ6uuaBNEWYfyKlJ0ZKRESd3q/bHbYtocDKy70wXr5qRGhz3rRrYHVXEtaD/mcEnqy7Ff24EK4D2xfXwZflDGpoo1Nqqdi8Ep0BNP1HOMMl53dsGQkTaEXUbI9Pq5J0QL3K+1Akz466AavIA5IUIizdpPP5eSMEOCclRBY6DEAC5q4Z+nwPZe2gZR+O/M21WHTGfDUQxotntZaf7KTCPXUl5H1kIwf
X-Microsoft-Antispam-PRVS: <AM0PR04MB41160DD89E0265CC0EF752E8EEB70@AM0PR04MB4116.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR04MB4116;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4116;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(956004)(6506007)(11346002)(47776003)(105586002)(50226002)(305945005)(16526019)(8676002)(81166006)(81156014)(8936002)(2906002)(48376002)(68736007)(25786009)(50466002)(478600001)(386003)(97736004)(66066001)(6116002)(106356001)(316002)(16586007)(52116002)(3846002)(53936002)(36756003)(51416003)(1076002)(186003)(76176011)(6512007)(4326008)(59450400001)(44832011)(446003)(2616005)(486006)(476003)(7736002)(5660300001)(43066004)(3450700001)(86362001)(575784001)(6666003)(6486002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4116;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4116;23:gtNCWd+1uJzf2CuzMZWkTblEukvlX5C6RPNe4N4ej?=
 =?us-ascii?Q?ZK5ktUDwPTGo9BQ+lr9LO3fUXmVOjpeGGjhhbKePeytqhSMtO0X+LPaw0gVz?=
 =?us-ascii?Q?JM62l0ldAuCceUCl4LESCRzN4HGrZTRhIBd/ZMuCM6tnwdYJLGwLT4XVTIxU?=
 =?us-ascii?Q?Icr8ZSvIsxIAvOHkA5m8bfamSo/ZkHivOwY2fqVR5GX8tpcRSXWRhIFieL0q?=
 =?us-ascii?Q?XInIM0nHBzg6AJg7Gb7LTXxe0M5hemfMh5UHkLajSKvfQo0436+6pOIyjSWW?=
 =?us-ascii?Q?AafUwR6zBYyxr3Ok9DukJgmpcVP3o6JJzbsN6yYnuqhk+tLvNPzN5eZU5o2P?=
 =?us-ascii?Q?Yu7yMORF1uKYDCsMrlLmocffYM0P47+AIOSL5pLSsF+puqmHKlfTjfRwGS2S?=
 =?us-ascii?Q?O13pPjXySWlU1Z0f3PWOu0MkEoGx/6fkACnBfwYyjYGRfJCQeLj+ibvl43PI?=
 =?us-ascii?Q?qtSxPB/29Dgr7GIzqP7DB/9XoiVm9xVaM3RBmYO/OQ46TYV5agq55+ktEuD1?=
 =?us-ascii?Q?HVi7Vh6MiNo+caeRBqgs862zwHkadG0vrl6YzjGPVLGxm1taFmqDdJJqUyKH?=
 =?us-ascii?Q?HUZQXftjlOwclANN6hkJWR06nZT3a9hjMgtRS2f4emrXiL28CwfSPmOB3Pu4?=
 =?us-ascii?Q?sVHVRisEJAHN3VtVbBrz9BtZkzlqDyg8qb+1vo2Va8Iq2vPe5Rqyaujmp1I9?=
 =?us-ascii?Q?kNiR3qJR8lVLewUNc+/eqkPv68G8vwwXggnntEX3y5ns2yIdNvNHlG0wKs6H?=
 =?us-ascii?Q?YCfsmq0GWlOmLuMGsq19+BLrWR0HAXAZ9jexn23h5B8fsxIlUmjTHhyCTk9A?=
 =?us-ascii?Q?hTAxoD8GFEXPVdeXP7h4SHv1dbbXXGHRVx7pQnIbrxyZTzaZuYDz2Pfz6KL+?=
 =?us-ascii?Q?8xXtD2vhRilgL10G0UEJXS1HLWSvVBNZOGWpqKxs9OR6xVqtj9moRMTE3tnq?=
 =?us-ascii?Q?WPSCOHrezTrwq1e0M/hdTgrZ5IW+3hSZo/Coq5TyLwms6LKqZIWGQL96o6O7?=
 =?us-ascii?Q?JhKqz5qt8Fs8VdjHNrfXP8Xbm+XgHkzPRNsM2YaLPjarfXXqaaiGoFt0TYjh?=
 =?us-ascii?Q?UsOTFE82coE+K5Rw7zr/mnCEkyaw5Y+FmsqtiCHUG6QVM6XzrtTCCgKs6JdG?=
 =?us-ascii?Q?Mb/kkNBdVNrDjpuc1V8XblrvCvaZAtIxesKz6+miikO7yqI9Y77TLuCjn3DT?=
 =?us-ascii?Q?J2DpgNjt4vdjTmlnNazS0HMWwGz/Ru2JeBX23k/jKj+c6A5WiXT/il5ejKdD?=
 =?us-ascii?Q?eu9V8bwHTHBct0dOHa8gFioBlqP2KGtMaHHFPz/poaMjBdSdCQL7Qacccr61?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: dPrdh5QbZbJrLwk8QhCZEA4XJLWMv3Z3aIQkpI9A1+EeRwlJEIkaV1tWSVPdmq8y4pyQLYVO1CSBlDZrZBgxwOabuoDgSAT27BI4ebIzwpVOJNsUArYsMHpcsMqaT1HrnO0m8kdzUF4x0mwHiydnlAZUo/LI/XA0UvdTSdHUfl1NhpE0XYPrgN1hLySXJYFs
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;6:/lcQPOe776rX4XF3w4sSU1RhwKdDvIMIDddEww+88vCNwqV1E8Vhh+5dwvNSrZay4gKpib8Kdly1ZFt1Rhr7HTevv0O33X0Z+vg6GyuIq3TkjDN4GCPtXNusXLwfKNxlaLzbe4KrWV3cvGuF4UpkMJofqoO1qeoPZA5pF6hbZ4QJ8SGWbOGflGGR/wQmoHnxp7t0s+6iBXpQgiE+SI90ql/7TI1FbbIfMbGm/i6U7ggCevFOXVTlF7msqBuEevOlu1jbj1zN0htQPScr6tNE1jiMdCg33lD920i0fUzoT/HG85Uxa7AOh8p4cOpXAiKWio6jSyCPavtjD1SCU5tSnNF847AZsnZljFaVky6KFpydYbAMNpuf+AUJWCmMuM3wQQnjSBKzNHiGnX0dc+3fyiLfHHRznbcTQAZdWMjGDxqtUfAONS7FubdeAhUQ/TdGd+gyCzXwQRv4H45qAOWRbA==;5:vlvXz8J7cegVBoCrlOe5n+G3nhxCoFlygDzsXN0IB4w2MsUoJDh+r/KeKQSDWxN2rQ5hkjcUgVmgAFPJIRCXLwlkxVg7Jg1HuwNYY6rX0ZspJooy9zD0PLl4Xxf3dXYD2DwxECXQrc76dYj3SRuN44VsyyoRt25L+ObYw+Rc+JA=;24:ljGU/D0lblfD8d1fhH+svwcantCOF++gjD+sTzNGYLRlxBeZ5Qjhc4wydZq5gjxSP5yldvxM710RRUhx6x3MvMG2cX7PGjHWLjygVdnk+b8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;7:yaOb4hb8Wz8OZhGDeL8ndb4rqMwXEBPDtgTTJYW4yjzpg676cI0wamUpTd5POwqKrYpDCsfCYBG6Bbs/EPaH/hMT3kNnrbgEMte16rll2RXhGIrGFtzBzZ5SR+fxd7Tz4TnuejBWL7hwNTlVqWH2klwtmE5EK82iCNqW7exMBejQ5AxhANKUxPnftlBVdWqzp+KZLIWz746vhB3rr0gCDTGX+jQ7NEt1V/9HSKRNYLDalmFvPqC/JiAErGrlRhzO
X-MS-Office365-Filtering-Correlation-Id: ee621461-1b3c-4f39-cf61-08d5a442107b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 09:03:16.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee621461-1b3c-4f39-cf61-08d5a442107b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the context of enabling the discovery of the PHYs
which have the C45 MDIO address space in a non-standard
address:  num_ids in get_phy_c45_ids, has the
value 8 (ARRAY_SIZE(c45_ids->device_ids)), but the
u32 *devs can store 32 devices in the bitfield.

If a device is stored in *devs, in bits 32 to 9
(bit counting in lookup loop starts from 1), it will
not be found.

Signed-off-by: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
---
 include/linux/phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index f0b5870..26aa320 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -360,7 +360,7 @@ enum phy_state {
  */
 struct phy_c45_device_ids {
 	u32 devices_in_package;
-	u32 device_ids[8];
+	u32 device_ids[32];
 };
 
 /* phy_device: An instance of a PHY
-- 
2.7.4
