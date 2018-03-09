Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751957AbeCIAvT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 19:51:19 -0500
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:3475
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751005AbeCIAvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 19:51:16 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2 3/5] iommu/amd - Add a README variable for the IOMMU
 debugfs
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 18:51:09 -0600
Message-ID: <152055666941.63229.15022736780979941514.stgit@sosxen2.amd.com>
In-Reply-To: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0008.namprd21.prod.outlook.com (10.173.197.18) To
 BY2PR12MB0693.namprd12.prod.outlook.com (10.163.113.158)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e24fc12-6ad6-4beb-e1de-08d58557dc0a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0693;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;3:kYmdu8GrUF4lkt/2LvOXc5nfNpwEhYHsUiT0F5fn/alxS6pzTwqAtZhnj0XD9WMIWjGzsrVVo1ThZ7gBMefih0pynM0ZOwNYYEixp7yVRsnawvXbfW7DRb8c+e+V0ueBTx7xgJdyyaQT9XcJMAy5bDRlYoCqn+1HuPDDXrvM3IqFcwKGi7Uh/KPEbFDOaHGTtFOCJutfLYLz1huc7XPt76T39T12V2NEiKWweaXbocVA6Ht0aahm2JveEBydNQof;25:yHlA9IXirIPybIINrHMi7hvSBogPsaKBusayXZZBmjXCXotXQ11/2LV+TcQ9AA8dOHrYnOHbehYC72GETsk8XOTimQ5gxvR4w1Q/8IOSdDS3fWqSXjYnC4h4DWzsoDNUqjcsTmM6g53nSKOKBpoB0IMi3no+mGCMGFeGqZmUHpdzcnk+ZsfP5PbdX590mQ7jUMrAVhn2cLl15+3IFponJYaJ+kRX8LKhvt0VA43lJR3qw4YL8HeukGfUE92OTnpXYF+Od4JUCyw3eG9rfP7JYbJ8iP/Y0Wayf2VAxW3DbIdI1Mqq1CLBKTyqQRtCBJjZ/xaLWbdNTr+3ekvIpVGCVg==;31:X5+5SKepR7l9dS6ZgjabcEyZben5HndSh+km7iz6cGwP3+6f7CoN2i1Ap7hpmH79u3u56v3Tq/+xefIUo+2cSHBIfDFYQHJW3xILEzHQOokgqXP3OGyTUyuGUcaj2x2YX0s10uZvUpCQ4EvGbYCPK0L/+7fdT64Nqn3QIzOCjmUairsnK5jyjqo4hLo2oLWxIs905sVwSoldwgs87wyKbLlSgOM8y0TqbYYsvCT/qO8=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0693:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:4heNpbvcfHPwhIJvOP0eQDZQViRKrQ1ZgCT0PPNDV/GUYoL0s8AV+xEs5N8hi4C1ZvFid+lXFxoxaiTClQeED/gP1g7tQBMWxPGfRpcX/sgXuZd1u5eKHtYgxlDMZetrE3U7b1AB0ycaQuy0CsKg98iwLUge+kjpS47WBQtD73ily3HYbpvjDdnU9XfiJY8V0u1WXqMw+oJ+ZjIq4Qtpf+g3nUvIKDrCPAFHb1qvLT6yn5Ry+WZhf0hdHH9jAejWXcYjlP7LxxmqAm3sfZmm4VQpV1jMUaOTBHm7xTP5j9N+9dMB6R+4ZqonPRNz9dJXPs0jtkeBO0a2sT1+CxwA4eUMxgNPK3/AEeYIwy2n0/htYo567VfBlfTkfP56t88A7pwRKJdw6M5t0kAdCcgvn+cwdrQzQQSW9FJx27xgDDuVPfUXyHO9kh6gwKYUDbR9XO3NV3dXo8+avuiYuVE+ekOOu2wYu4nWr1HcKb0bI2/23PlU3C0NA/5vOFSng+oa;4:6ne3bC4beOOvaF46OrkWOIwg8mWiu/LnnEFv22zFbdpl6f0+rZSyrS3Xc0xpjf/XKFVParELDwv9TXw2D+r+vPgBLnv09t2HHb26FX8orbRR0FFu7P+iINJOfnh+Sou5yr83B4qnLo1uR+lViNkW8DtxwFd1msgoFIrEJTQlsQ3swoY/4EE+DjeEZATBiXyRUg4SOh27b0fyfqnyR9SBNDhDM/n3pGs2HTMs7n6WY/tEkemxuS7SX/ulkb8heN4PAqf5lDTRGruVAnmGCGJr0R0UpoJ1ZIyTQqai9yxDKhQJy1S/tI0d+N8+GLZ/C+5B
X-Microsoft-Antispam-PRVS: <BY2PR12MB069367CDC58A7EB3D3A5C6DCFDDE0@BY2PR12MB0693.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0693;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0693;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(39380400002)(396003)(189003)(199004)(8936002)(230700001)(5660300001)(6916009)(97736004)(47776003)(478600001)(103116003)(66066001)(305945005)(7736002)(6666003)(105586002)(81166006)(50466002)(86362001)(81156014)(8676002)(53416004)(72206003)(58126008)(2950100002)(106356001)(2361001)(2351001)(7696005)(186003)(16526019)(68736007)(25786009)(26005)(6116002)(3846002)(76176011)(2486003)(23676004)(52116002)(55016002)(386003)(2906002)(316002)(4326008)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0693;H:sosxen2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjkzOzIzOmFnNlFsa0NvTFRDdXMzM2JqTUNLbEZyWkRl?=
 =?utf-8?B?RHNSQTZoazdJMGl4Vlp4clNmaisyRjM5TDlaRERwOG1WNEdGTVQxNE1yZlpT?=
 =?utf-8?B?RWhZY1FUa0FkaW5RL2t3cElzOTN5eitFT045RUdFRDBrVlVkR2IwYVRydkdB?=
 =?utf-8?B?bkRWYlR2dk1hakZ0T1FEQmVjRW16aEg3czZlYkx3US91dlY5SHRuUnZHMHlK?=
 =?utf-8?B?cW42dlpHclZ0S3o0ZUkwY1lKSmMzYjM3SllaMjNuYUVkNVg1aFZERVZsYjNl?=
 =?utf-8?B?QjE0Z0s3K0lISldEVEVQUGF0eEF1blNEN3l1VVI5Ly94emJSaFJqQytaMWRD?=
 =?utf-8?B?Wk1SNlVCd3Z3VWdOV3pzeE1rMWhPNGJMSVY2dElhMS9oOW5FUWZzWHpIb2Rw?=
 =?utf-8?B?enkyREN5SmJIQzdFcUNZSXhBV1A5NFpUMHZYM3dEOWUxbEVtTFpuSENCNjZB?=
 =?utf-8?B?azdpSGhVZjQzV2pOdTJwSXlCT1RJdkQ0cDh4aytkaFlFK0lEbktNSFA3Q2c3?=
 =?utf-8?B?VWNMWVk4Yzc3K3Mra0pYQUZhZjQrRjJpeG1UQzJoVmMzdzhaeCtRUzg0c1Yx?=
 =?utf-8?B?NHZHUlRSZUZrUTJTTUhmYk9sRjhwYTVGbnJuNVkvL3R1K2ZmRUpYQlErTEhW?=
 =?utf-8?B?cCt3UEdWSHFldWNGcUVMQkNSaFRhd1hKaVl5dGNwOUphZVJkeGNIeW96L3hj?=
 =?utf-8?B?YjJDbzBiM210V2V2clZOczZZUnlxMFFrNE1mMmNUTStTbk9HWDNQT3VySFVo?=
 =?utf-8?B?UUxPWHYzV3BKUHJ0Z1BER2RyTU9WeXM4MHBMWWEvTVQxQmk4YVNkTzY4ckV2?=
 =?utf-8?B?NDZkSjdUb2s0WVN1dHU3MWJmZlphN1B3RlNvVlZPQUFXcUg0VnRGZ0JvWnZU?=
 =?utf-8?B?UHRMa25zcWhsdTd2eFI2WlJ5cjJRUUdTdVQwalRySmtpa0w3TC9mNmV5Z1BD?=
 =?utf-8?B?QzVvcHhWTldtTWlUdVI0U1J1cWVwMXU2UW1LYTlZcU9kOVhLQVdxYThVd2ZN?=
 =?utf-8?B?L2swNE1iTmhmRGZ5MTJ6em5IUUtRb05pSHFRTC9lTmVBZ2JmZis4ZGw0c2Ez?=
 =?utf-8?B?YkpRNm5Nc1hFK2k1ck9KSXEwVG5HcGFxMWIvbHN2V3kyd2NrVHNlWTBGc3JS?=
 =?utf-8?B?RHV0c1FlaXJ0Z0c5UnMxejIyeTFSRVVJUEdERC9aRCtFME5SU09GcE9NQ09n?=
 =?utf-8?B?bVVVYXNEUmRBSkZONmZHRU5KaTYyNEIvVVZ6Q2NubmVVc3dwVmpwUFNFZXh5?=
 =?utf-8?B?RjAxWGhIdyszelkrcjZ5TFRjV3ltNTUwUjd0R0M2UHJHdUNOZFN1R0l6cXVF?=
 =?utf-8?B?WUFlSWdiV2lueWRadTV1b1FJdGF4dW5zaGZ6RUl0QmU3L1kxTzgwbjZuSk1w?=
 =?utf-8?B?NnNUTXNadUtnRXEyNTVtVHZydGJSMGlPcWdWOFk0SHFodlpjZnB2MWR6QTln?=
 =?utf-8?B?dVZGZy81aFd3V1RDMXVqNVorcmdWSTd3WHgrb0cwb2k4SEpIc2pXMzQ5WHpy?=
 =?utf-8?B?N3pLRGRhc2dyU205Qi9qZTNzNkc3WnBpQnNnbElVMGZOYVlpQjdNbnNqTE9L?=
 =?utf-8?B?N2tscHZXbjFEWnNxd21GcHYyUlFzd2c9PQ==?=
X-Microsoft-Antispam-Message-Info: pGrzynig3XzLbd2qTXf182tU7ZFsukZ3Vo9lfTPNlv+sBxxqpgaOTcPy6V80dGFtvNOc9b+5vDxLXg+jXbeaVYn2sauUL1FJWrGQ56UM4m7lCiwuNMpc4qysdDmSszba0Nw+zfI//Gzd0WHNhcbpCWt4TlV9Sc3djjp1sKL2677vqj7NS+Y+eRAAi6uc/x0a
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;6:mrk6QCyxrNBbREwXcDwAOapGWWsZ08YurUgKQnsDctMkDybmU/Ct9xv6syHEfJbt7bcPhcfRt4NLAfX+VjXRhJK24NcLVFaDBR3a+V7kWg4zhmgq0FrVQE8ykgfksA6fhsZRfdIgk89vI+0DOi46bW/Lvw+FsA2eDNd76lrl8Wy8eVBN573wjTyhPiM9uxaPUFom73f7domRZLtOKfn9dMzqpYUgLU+6lrpgi1am8VeyYlfy9QGAJEndMOihKJrPFAvy6gGEvs7sKE9AtXAAvZhIu2A8W/t/zLxP5qNYj/17xJF9omaOO8jfkMmo1XGsc9fhqzmqxE941/blSBsrXqCEuTgXaEri1nYsszuD7Kc=;5:q3XhK7fME9Tjabr7yYyo8UGO4xH8QJZ1zRaEWORcCTYOiTlmJXkZDR9jVNT9Q5D6yDHixihYb4K66liGjAegN7fwN7TVw0Hf3C/NxicFZDtSoa7SivGUltIPvCZ7tuvqpdGDsSajyvpRQ0FNyZR8+Y6E8SV14qV+BdCgOuXaK5E=;24:8igc/5ePnmnzV//mK88p1LjRHwzoSBIjX4iYu1St0XUpnEc0qH6Nq7XuNXBUoyxF/+WAUrIeAii2Qj7c/LB40kkXgT0TGKFytIRoGsO9qdk=;7:gXhIgONyyyDQym42u+Po71M15+3kLx/fw2JGwfjeoRiGCXHf9haNgFJ4yMnb6CnorZMQI30Ym84KGmlqOKc9wVls1qA5KpX6gXxf31UL54ttEjD+zod2g7UMhxJ1ic/BNbOGT178PeoSHBrU8LxCCvQ+5vYRp5u3+JbNq99pYe3xOd7Ix2o1SUtpw4Puw9+Pf1nkBtt0HzcQaE+TNAF3qxTmQEA9ovkB+Mk0NYjiganNMBHtN7keF+K9sBNM506I
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0693;20:zxwX91H7Xe95MgcgxhZ/XpoFHcEAoXAL3fhaYZeO7G+xZCjT36mVTZErmHdX4WaPk+p/EqwW7XPkiCL5EUeW2cOl2uU5TRbX/v2dGKjkxJOl1wYTrS/Y2SD08tMJ5tFTUEHPz6OS0CkbS4p32NwIXlvB0m2zJpq/V/RXWRSxcUAzkUqLuItXqAPbraiC0kMUU2kGg6UwX/Jp2OA3XS57N4RU1aW0eoADIg2RIqQ6Dr4AJyTROg8I+DJfQ17qe0ob
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:51:13.5330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e24fc12-6ad6-4beb-e1de-08d58557dc0a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0693
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide help text via a filesystem entry

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/amd_iommu_debugfs.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd_iommu_debugfs.c
index 481f4d86f8f8..79945ce1199d 100644
--- a/drivers/iommu/amd_iommu_debugfs.c
+++ b/drivers/iommu/amd_iommu_debugfs.c
@@ -81,6 +81,31 @@ static const struct file_operations amd_iommu_debugfs_dtecount_ops = {
 	.write = NULL,
 };
 
+static char readmetext[] =
+"count                   Count of active devices\n"
+"verbose                 Provide additional descriptive text\n"
+"\n";
+
+static ssize_t amd_iommu_debugfs_readme_read(struct file *filp,
+				      char __user *ubuf,
+				      size_t count, loff_t *offp)
+{
+	ssize_t ret;
+
+	ret = simple_read_from_buffer(ubuf, count, offp,
+				      readmetext, strlen(readmetext));
+
+	return ret;
+}
+
+
+static const struct file_operations amd_iommu_debugfs_readme_ops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = amd_iommu_debugfs_readme_read,
+	.write = NULL,
+};
+
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 {
 	char name[MAX_NAME_LEN + 1];
@@ -115,6 +140,12 @@ void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
 	if (!d_dte)
 		goto err;
 
+	d_dte = debugfs_create_file("README", 0400,
+				    iommu->debugfs_instance, iommu,
+				    &amd_iommu_debugfs_readme_ops);
+	if (!d_dte)
+		goto err;
+
 	return;
 
 err:
