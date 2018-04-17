Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeDQBzk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 21:55:40 -0400
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:45287
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751060AbeDQBzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 21:55:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=wxu@cnexlabs.com;
From: Wei Xu <wxu@cnexlabs.com>
To: linux-nvme@lists.infradead.org
Cc: mb@lightnvm.io, javier@cnexlabs.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Xu <wxu@cnexlabs.com>
Subject: [PATCH] nvme: lightnvm: add granby support
Date: Tue, 17 Apr 2018 09:55:12 +0800
Message-Id: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [115.238.84.139]
X-ClientProxiedBy: HK2PR04CA0077.apcprd04.prod.outlook.com
 (2603:1096:202:15::21) To MWHPR06MB3502.namprd06.prod.outlook.com
 (2603:10b6:300:11b::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR06MB3502;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3502;3:n/HW0dhANT94yYEJui2a5Zdxj6QMNGmgjYfuMtsQqSrpFBis25soAWRetXwlyKlmDPyk+IXJCggmIao9fclFhJGjL2p8ldMS8Fivl66LjjAozBcKz6nF6hHtUTcUW9LqWiAMwNpO+zhKCzZw7o5ZxuCCUCGJpHwvGk/Le3DjrSh89vPn5b+HxOji1Vi5lAlyH1wT30UAOfa+xdRn78t8q2N77dn8iounCt7I0iATH1Rs1ERlsfEQUSatgXTekvXH;25:34Sn+9BUHo7o5xBFhwnmSG5y7W1KXgxTbi425hs8/AYtOzJfMDqOqe3QCGfOiVYGNTEwoIpITsHpQhzlW2/ZVQa4DmfaU0Vbbg1FPonQy+o+hsaYOBuHzLvwO+/iIWhYEstOBIpgfDV+DsFZ0mU8b33BOtLG5N6/6Lz9I4Uf2nBDV0VVcX3EhYGJEGvmNo7XHVwTLdeckSHtMvnEOF9JQGzcFuk7v9CrdKry7aTmI2DCOKtZRIFJhLpWoGrl/IA8T3DdoT9eqz8lWUU14i6SyA2CPl9ASt5wucle5fHVdvmdMeV0FXdyRUjrL7YXBWyF8wH37VzxzoifAprJMBTD4A==;31:djoqhf78CR66UC/WnHAQWiCxWk0zecPc6clte47beiGxWVHJKzMHoBPP7KHvEySm2HsRxIG8u5tnjxjInUzct6ORnU58/rZiQT0y0X6aELnaUHYKCId6qf6GCR1nJMLqqjSs+SKhphD2P5ujVicDpL+kVW/rIH0eljHlT5vwK1JwAl155+kSd6a9Sq4S0SEj8A/TgfIay7KlbWqefAZqdxP4EcyIW2n2WlZwLk+bLZc=
X-MS-TrafficTypeDiagnostic: MWHPR06MB3502:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3502;20:VCd/0Nijc/tNsSUBm0OTsnLT+lcoHAGM7x8jCdMPM1igpot/Z3TKk9c2/+jq5G8I7T0xs4lOCddNUsHmoHKHb5GpPqh/1XZ+SFnAH8zzBm26o4omVVWRfWv0PQQ435C3UsqApdQRq5yl1G3Tyo3GwcK/wcmLHTNhY9aVrIlgqb0=;4:u06Go/FkdhwAbMxyZCHpe15FLmu6sZKXF2QN4hk9qacEnIfzx5egNjYVPpuomz/4Cz0EW+OwewxeH5r6Trcy07eNtWWlgsb6rXl14SHPSAIdcVaAMIV8fgkHvVbkPuqLkEMhYp2DiqyZrHwI5yBiWCLCJfVMXvgkmUgiesuPT9oUMlQlua3OjgMcp8Qetm4ZKlTKFInSRv4UBYlBY1//H4hnHw290T/5nx3caaAqYaLyvkFf+T7y3eK0ifWs3snidsHBMsnG7DGUh1nVzCe+jw==
X-Microsoft-Antispam-PRVS: <MWHPR06MB35024116828593E78EB75022C3B70@MWHPR06MB3502.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR06MB3502;BCL:0;PCL:0;RULEID:;SRVR:MWHPR06MB3502;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39830400003)(39380400002)(366004)(396003)(346002)(376002)(199004)(189003)(47776003)(66066001)(68736007)(5660300001)(4326008)(7696005)(8936002)(23676004)(36756003)(7736002)(6666003)(59450400001)(386003)(69596002)(316002)(26005)(86362001)(52116002)(53416004)(25786009)(478600001)(81166006)(956004)(2616005)(81156014)(186003)(16526019)(107886003)(1857600001)(486006)(476003)(53936002)(8676002)(50226002)(50466002)(2906002)(2351001)(3846002)(2870700001)(105586002)(305945005)(2361001)(6916009)(106356001)(6486002)(6116002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR06MB3502;H:dojo.cnexlabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA2TUIzNTAyOzIzOk9BckdaNnM3OEFMYkR4cTRxemN3eTBaQmlR?=
 =?utf-8?B?OTZaUHhmN1QxSDYxWGRJSHY3bTlmWUZjZWY1RlJteExZMTlPMWpRTndGTXZz?=
 =?utf-8?B?d2FxS3A5dmFINUcrQys1dWhydjh0N3Y0MzZFbXh0RHBqdHE2K1dlU2x1ZXV6?=
 =?utf-8?B?L1dCU2RJTkJqOXNCL3F6b3ZMQ1o5eDRjZkFMcVoxWEEyTkZKcVlzOGc1MFVE?=
 =?utf-8?B?NG8vRVcwSDVnK0t1VFlINHM4anFXczlWemlFdk9vMmF2VGlTSzdUcnQxRStX?=
 =?utf-8?B?VlIwVkxndWIrcEZ3NkxnNWlvYnFxNlNBRUxqaVNyS3BYS3JGSEtUQisrQkti?=
 =?utf-8?B?ZXQ1aUxaaWNvNVV5NXhEMlpmVVBwNGs5MUlCaVEwbmFLMUxOSTk4TVVHVmFo?=
 =?utf-8?B?eGt4TVlYZTVVZy9CQ0ZKeS9hQzU1anJhSG5iVFJIU2JuSHJPTi8zMVIvK2xv?=
 =?utf-8?B?eW1aVHlKZllpQzVaQVluRmdSMFRwcXY0bVRRY1kzOEZ5RE1GdEhjc0hzS0l1?=
 =?utf-8?B?ai9yZm1YTXBhZThzRFVCRzF6OC9jUlh6TllOWFFZZFFKcHp0bi9sbDh5QUx5?=
 =?utf-8?B?dXlLZEYxR0FUVDZzVXYrQ2pMNWtBMEkyeWJWNXlVNVh3VnhYTlRPdEFIcFZz?=
 =?utf-8?B?Mjlqc2pEWEpUNEl0ZElmMGZLZlR0NVBHTjBVVG1jQjNmZmdCUTRSTDdLeFNi?=
 =?utf-8?B?c2lSK1pGaVhPS2lEdDR2TFIwVkVpc2x3S2pISG5aekVvME5CR2JQNnc2RzJW?=
 =?utf-8?B?Y3JBSlo5dWRsZS9PNzd4bjk1VHZoOHpKZlZHc0tUNEtTNlpXR1lrNmxyVFhQ?=
 =?utf-8?B?Vi9CWUVFaHhra2o5L1RFb1JnUXBuY3FSYmIzZUNrVGhaWmlQSy8vRjZsMHgv?=
 =?utf-8?B?bU51bXlQSzVsdXVyWlgyd0N3KzVTM05Vd3E0czU2RlJhQkwvV1pwdC9NODQ1?=
 =?utf-8?B?L0JBdGNIa0RZeXRFTFJXdTRJT0dpSjBxVnpOTmZqeitMZ1dHb2lUbElCaEx4?=
 =?utf-8?B?a2tUa3l0UGxzdEFTdVBFVm9ZOUxBZ2FhWXBUY0VqNkM5dGJkZkdoMlFyTi91?=
 =?utf-8?B?Rk5Bby9YSWg2b2dxM3pGdGZtKzZxa1laSThyMzFkQitkd2ZZTDJkYTZSeFVZ?=
 =?utf-8?B?dHNpZmR3ZUpmUHJUeGIvdUt2aWdKUG5vSGNONy85UnRPVFJuYUZCOTJqbU1N?=
 =?utf-8?B?TEh0cEY0NkhKRzRvMGxkd1E2MVAwUUhuVWNlTjh1RzIwYjJnaGhPcWh2RURF?=
 =?utf-8?B?UEpidkZLZ0JDWUR2dWhReG1NOFdSY0JvSlRqTTZ0dVBsSW9rWjZERlNCMGJW?=
 =?utf-8?B?Z1FDQVFNUFVMVSsyUlRzN1F2ZnVSSUZiNnEycUlkM2FDSHFScDJhTWlFT1hC?=
 =?utf-8?B?YTRNb0lHNEtSMm5xaDltd2kwUkwzK1dMT0w0S1RUSTlZdE5OM3kxalkwSnI3?=
 =?utf-8?B?elhoSXF5aTZjQjZaOTF3QmdSeFU5VW9HVGI4U3FuSkEwZEVkNG9WYlZBb3hK?=
 =?utf-8?B?TmMzMlBiaDVjRU1BWkd5ZFVEblJ5cVJIN1I4VnlLNUg5dW51cHpGNGV4bGFD?=
 =?utf-8?B?Q3lLd2d4NzQzNzJBM1NzUExidkQvZngzZ1JJZmtuZlcwRjNzYUJ3bFBGdmV4?=
 =?utf-8?B?MlFuQVlsWnBndCs2K1I4ZjZUYThwWHBYb0lSWnp3Q1hadDVtdTdMR0pqQTJ0?=
 =?utf-8?Q?/Z8adFiqWyKuwVV8L8=3D?=
X-Microsoft-Antispam-Message-Info: c6/zSE71f0dWAlcWDYjc3lPBeWZzuXaDT1RNs/yii5J6IB99I4MOP4lyU2Y3b5LQqexURPKAIyIO3G4ucu7sfBKzZQsIvovEFhK4yFF+uL4as/1U3glaYvM61uthkNfgOmFqYBmHrlSEJRb18eJbIsfdF63VOh9U6x4yrIGZ+qASoYR3JHgGkWr2SCkpa+dN
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3502;6:ltz0ajiQ44rFX55RPSyYw6cUXuFW9uF8P7Y+u1OFo2G8fc+xHQb489fBe/bbNUljDJV/xSHI+zNizF//0LVf5b0Kcbl+/mPxBTGVjo1NHOmrU9twa2GLJK+dloZOOnRpeogW6iaCrJfWunOusAWUIfqwnulTnh5SUrnJyBcKdCTGPt/9HnPtJcSFx2aiXJqaYx1DwG3DgfJ+WF9Ese3zrX3IDmrvb9X9/tONJr1n7VJ/IMdMEmZs43z36gCL2EEgeRAAA3b0p4gpaKvBN3Vpza8bTUGf+cNInsOn97iYByjfHTc5V7udELf3Vd6o7L5Tb/eRiBWsx7/Vh96Ohz+hdY/59m2q7wZpNCplADft+S7hwh1AYL6sYo+TeMfH3l/xxCBK6tcQhuCDu7/7oZNNuiy9YA4UPnrdQiEzgIQxEN+9nMEX0Pe80eSgBeXWB2IMsizLbp2I8u6evXrpCtVYHA==;5:1EcVVOsmusVLoNvKy2eCKruN4CNBV76VmW+hU/hB+jBg+7xZ5y4UpDcnp4yRt0lcyCp1HzpjcFW6Ako1b5P3Y/uDNAftHmy9Z9bZXRGf0NBkooPoxEZRYAtSsKLGYxVYV6EDiqo/D8Rqn8n8JilcBQR33vIbz6SLIhkd5OmKc3w=;24:bF+sBDJrb6txuR3WGMp7rcXrq/yAnnOK/ADJoSR0Vl7sJQHjA1sQfPnMlqSqIC2JHUF3phbuAVJMoCsIuLDwjFYJXMOd3R0utpNroEjbA8U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3502;7:DRJ9bp13y4NpHW5nWK5lYdcrpdgoZjvGm+lqQ1BjQ9pghNl6DEgi2r7lZ6qKVfBndlmlMbYIXdpIkrc0f6uB3VHzn0RaMpVNK3azwpx6jPT8+phgZWvwQ6o6Aj4vF4+m1wOBmTPQrVknGjwU4u9TyhoH0tuLjnQQs3lDGKMMlZ54tBUSWO3y4M3UF4ljZUmAg8eJHcOehYpT58HlzWkRC0UuENKJR66SeSWGwqSUAW89TIIxH36dPThjOM1ugEE6
X-MS-Office365-Filtering-Correlation-Id: 476e850c-ff75-4394-3e69-08d5a4064f33
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 01:55:33.1591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476e850c-ff75-4394-3e69-08d5a4064f33
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3502
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new lightnvm quirk to identify CNEX’s Granby controller.

Signed-off-by: Wei Xu <wxu@cnexlabs.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cb73bc8..9419e88 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
 		.driver_data = NVME_QUIRK_LIGHTNVM, },
+	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
+		.driver_data = NVME_QUIRK_LIGHTNVM, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.7.4
