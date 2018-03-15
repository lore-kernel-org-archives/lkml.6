Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeCOUEN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:04:13 -0400
Received: from mail-sn1nam01on0080.outbound.protection.outlook.com ([104.47.32.80]:37058
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeCOUEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:04:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v2] Documentation/CodingStyle: Add an example for braces
From: Gary R Hook <gary.hook@amd.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, corbet@lwn.net
Date: Thu, 15 Mar 2018 15:04:02 -0500
Message-ID: <152114372879.3142.8833111074324091904.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR03CA0078.namprd03.prod.outlook.com (10.171.242.147) To
 BY2PR12MB0695.namprd12.prod.outlook.com (10.163.113.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f3a8405-c1b7-4fc2-e43c-08d58aafe88b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0695;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;3:/Q52Z11plRAfpVHcTc4haUG9xi1OOiQ3HR4Wo9vQxPHQ4e4ek0Tj4rtOxS9K4qVp5dEEIHsKCTXBK3RTN1OkHBcrm3ESpBv7sAvjwG+4EGk3MUFp3QugqBHD4pM1HSfQ2hrMiLefg+rHb0NVLVgpHArYkNRmJGS346vNWQ/u2TkY3Lmkgccy8AB+ehU8WXrqVSrurKChx9soB3si6HcOHVOaWp6twUhGPN4QVl6e/oKAeixsNz7EmdoPbHRqNBWM;25:lGpkm3pEzyBP6rIv5hJSOfs7H+gOhvPworDGDrHa1XJrU19vksHwLUOrOG/LwzbizPfHPDzY7/eJwXa6nJZZcY6EDRQk3w1SjMqt0c5xok8lukXjl8Y/KHhthMyfjjIWt7q3j4VIbosEkKOgIMkSnJ6lIw4gznmTRz6glGvSNcFYr3NSi1vzpfHIYXa03hQME+pqG7mIK8WdwJsDxrDfcptxAuNGUx9iQSyZ7Hx78V3ZG1/ZN4DRuAl6KohDwrLuFm+tRAjdESe45J/2Q4tmcOAKXyqOt7/VOH5b6Nk4PyfSrFODIXflTQdAdwFyxIzAGV6AyJbRD4OldUkEMfY5Pg==;31:TlIVlexyasD8++cvp01zJEubkfZKzEdvCewxKChbcQ3gpGOqjP9FpSIipR+tKR7Ld703xht5CsjuSL1hEzTKHNfCtAb49eMXWy2DYk+wZ0poRDMpZaKyBGt0QfecRxloG+dqoj+8Z98EavEbqNFY2lUwswQmzvOnTV1MZMkFcXxRiXqXfWmqAQOMfeefDBqzIhYtatVSzgRhN3DmI9ZhVNtT55FGPg1GqLoS/XGcLhI=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0695:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;20:TJ4O2k3m6gza2HhFgmvsCfc5IjCI3CRlD8ruFqiJN+V92YbRoBNWYiTNITNGpDgZ/tiiT/4QuNaj/12sYkg1fOpPjuceiotB3Obl1X/Wk9Y/w+b+0B7mSY/HVdsoQCd8f1Rp/1Yrc9N9GZQs/bTvIueUqhbFN4Mqz4ryumYVOCnA9mQyEXxvt12/BebyLG/xqXJqkBGrEctit2w5e/cAgQrM0Qi0CBdMLD95eJLYp0a5APkZv+GUQbGgstU6tX0/NsJFg5gdvwxTjVvOuWsVzP45Gt8su+qtQXI6g5jMRnvFm7Mw6x2TxSQrmSJo74UgTgqhzMEtZ9BBrbdwBQjwwq4O/CCyKPGWLH3Tt71VN0teV5ciB76Nj213TQdeyqXfVjE/3yLSyIkMHqMLqJAergX8BU6haeV9aqZB6dXn3mnXtwvSSdFmuvHtsTbggOuLhxXKtudmjkIcIS0x2KTjS0n+nbhaB/i0gw95mUCE2gioEEKqGCL4TeR2i4rp7LV1;4:8HsgCar+HUpr93nygauF46RoJGu8u3/BL7mAUprCpmfPDq/0UKsp+xCbKIQbs8SlECDZDhKUEcsUMy2Pd4E7DKfWxG/rCkRo+fmQHOySur+PAkKEL6ep+O83G3t8qAZoyktwsyozcRYzDl7JB6sKWuHyp8JGZbbFOj3U1WvTMzwmfSAJs8FaDIOmTEsLg49XaazWUUM1VzuaF/AvPdOYfsRJuABwaDXq9rbX3/XrpI/sEyw7Rgp4TRLkIDIuz0tScC3JllXx9hre9fQABKho7uka1LfKhdKeUiVQxmERZXA5mgVq1jDD9WTdRNBoJo3P
X-Microsoft-Antispam-PRVS: <BY2PR12MB06952491C5B02E90F2D68DF8FDD00@BY2PR12MB0695.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR12MB0695;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0695;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(81156014)(81166006)(86362001)(8936002)(50466002)(575784001)(90366009)(6486002)(8676002)(7736002)(5660300001)(4326008)(25786009)(53936002)(33716001)(9686003)(106356001)(230700001)(2361001)(52116002)(72206003)(2351001)(103116003)(2906002)(33896004)(58126008)(105586002)(97736004)(47776003)(23676004)(2486003)(478600001)(68736007)(66066001)(3846002)(305945005)(316002)(6116002)(186003)(16526019)(6916009)(26005)(6666003)(386003)(16576012)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0695;H:[127.0.1.1];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwNjk1OzIzOjhESzN0MzZ5aDJPYlZsNS9VZW9mdW5nN2dj?=
 =?utf-8?B?TkRFM2xtUHhvSmRkTk85eVlySGFST1A4Z1lFL2ZVbTlYSlhtRlE5bndhTjFT?=
 =?utf-8?B?emxiS1RyOWVOOGlzRDhGeWw2ckQwTnpkMUduWnFNY0pZYmNNdDJzMEwySis4?=
 =?utf-8?B?aHFQeTdab2txV3NBekdxZHJQcWxNYXZ5S0t4N2NJWDlzVVFkZVdVcTNJK0pl?=
 =?utf-8?B?NHBEV0RpejU2TzZLdVNWb2Z5dUpJS2hoTVhINFR0alR2OGpzSkw1ZERKS1dt?=
 =?utf-8?B?V3hIU0ZGT3VSZ2Eydi9MVXd4MkxMbi95aEYwVTNZdk1QaGllYm95K3cxcGtN?=
 =?utf-8?B?TTZwVE9yWDdYUmc2UkZuWk14WFBjL09MVVdkSXo3aUl0WnZ1WDRQK2VRcjdt?=
 =?utf-8?B?U1ZieFZoMWMvcE5aUTFwYndmZzRHUTEwcU5yd1JMSHRTOUxiMDZ2QUpXcFEy?=
 =?utf-8?B?UUdkd2xMVGFFS3lTTUM5NktBTUY1Z2d6ZmlRSFo4K2phNHloamhrZ1l4K0hW?=
 =?utf-8?B?VE8zdnk3b05rSXZvd3BMb3k3Wmt0emdvM0dsMndPalFUMUlJOUNoa2JaTE9L?=
 =?utf-8?B?ODQyMzJ1SmxoaEtRZklpK1k3QVdFdi94czNPMS90NUxEWW9LODA5aXdHWlBh?=
 =?utf-8?B?ZFdiUDF0cDlER1lCOGxuVXVKRTRjWEhsYjhpOHNrVG1VYVlyOEhhK2R2dEVt?=
 =?utf-8?B?TnlZeEV2ZDVhRlpjOVVpcVErRFdkcnVuS3FaSGtvVGk5aXZDamtVbFRua21q?=
 =?utf-8?B?bC9sQS9vQ3U5R0l6RlJXam0zVnMrUnhjdm4vT2RzVjlXS3kwNnVLdC9iWUh2?=
 =?utf-8?B?ZGovR00ycUZMK1l5TzVOMXBreVR4NFA4Q2U2UUFreW01aEd2STdEUWlWdEhj?=
 =?utf-8?B?SEtvTVBUalUrbWNTdGVIdDJTa29VK1JzbyttZ1ZiMDVqRE9JN2c2S25SZm5R?=
 =?utf-8?B?UVliaDRMb1VHaThrUDZHckkyS1RIdnd4RmJmNE45S3hUd2NqZlJwMm5UanFp?=
 =?utf-8?B?Ylp3WG8va3c0a1NIMGVuQ0RZNThjd1BOYlpPMjhzSUZDUTV1cmtrOG5HeC9x?=
 =?utf-8?B?SEU3L0RRZ1ZYMUZVWFBaZlRpYW5UVE5sYkcvY2lXdnJhS3FFeEpPNXVteldU?=
 =?utf-8?B?MXhFM0pmVVlrZEw4Y1lFUStIWVV5YmVQaG1lZ1VZRFZCelVmRWx6ajN4M0kw?=
 =?utf-8?B?ZG5vR0pQeGg4QWRuTWJISzVlTUljTlZNSUFhaUZuL1k5N2NxaEVVeHF3WW1n?=
 =?utf-8?B?bXFyLzhtcUlJZDRkeXB0MjRGVnVkdng0TkNtb0N5elBFNlgwTjQyV2I2c0w3?=
 =?utf-8?B?Q2JoQ0RqaU0wQUJnL0FCR2RQQVg5Szdka0c5NmJ5TTBwY0x6S2pRKzFiY21F?=
 =?utf-8?B?MElDM2FSUm5hR2hzaWpXMmNjR1lXdlhFbVdCSlFlY0NLV2czRHJQVWQyL2Fp?=
 =?utf-8?B?cVdYbi84WmkxSFZ4K1AzWUwxdFUvNTN1OFhtbjNLSk9ueHlUb1NneXJkNEZS?=
 =?utf-8?B?UGZEdWR1ZmNDaFlnZFpVTmcveVgxa0xOZ2w3RVh1RHdsOFV3SXJVUm1ta0pM?=
 =?utf-8?B?TkVzTFowa1VjZEI1akZCdVhFUVJuWisvVHFzZTVLbkh6SDRmSFd2U1dndmIr?=
 =?utf-8?B?QlV3N2FWK3U0Kyt1SGlrQVpqam9tSDNXTVJaU1lPRFR3dHJpVDBPWkhyZitN?=
 =?utf-8?Q?4eEKJDdR6bCrsZEnWnmhPd3/scfpQzYGj0y3lVp?=
X-Microsoft-Antispam-Message-Info: uI78oXyQC+KXk4IRdirtRWSw4Qg004fa409f56aVSkJRAp6mPwOeV1VL5JRtDk5H/1vZyWZhoeXZ/ukH0jxJGfZ2t/QOvk3huljx1GI83+5yOSmEV2T2v4sFzSGgvxeHQ07Wz+JnOEl9LOMWXLDbk2oeuFQS0WJr0btRPKMeVkElzzIBCWMA5r2jZGYl8a77
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;6:W1Qf3ClDXt61gIDGt9VMVQw9nmNICtGn/CAlyBSQ5ot6qpaXab9L3gNpV3VW+Ok4AEcaL1BvCW5nutOr4XNq1LEF+dNoH0eOmBDF6/KVxLQbyMBKNw+D/FJsPa8xYopSRtPJQMm7w/Hgx8NgT6Rv99GlkIrZnI57Kis7NTMrYQ03STsqPwyxeXo+PpiBumSzMT4DUDfeTxvWTrQhZUU6prNI94pxgcKH6vDH6EPY1JSGBPJw3cLMKpMemqzwfPInKmm1n4mEhl4s3P+lJcj1VVCEgi6yFkpqYFEiJtkJFcI4FsxZBUJWNEq6+OnGpA6noDThd9/DCHG16rHcI5cZdb79OwKsFhenUAWZLtFTyZc=;5:OfKdLEpj86wIcThT6qEExMFklIOinHNBq3fMzRQv27+grrbtrd3tseTyAGvMSe1XQ25JJNRT+2w+k6YOCdZoUVCJbvjUWLPInn53rr3MClvCdhJC7zziSPp4OHP7T4zX8SgqiBM07SeGe0O/FgpkG0srCUH8cVneTEp/595dTD4=;24:6JX+pPAus9cnzUkqUyaiSl3aWr5XgtraHTr6Q/iC2DDGXjI34LqdYuC6Fk9iWmiL+AJPSiRWf0LMd7RUTiNCOgun6QTvZRhqFJh8VxEx4EQ=;7:Bq4I2U6lwFp0eJ9VpnPkaZTerwFBjJTUfHAb1/UxpQZctRcIGgaoI7ylmBdcYnPxNi5qHRcfMqaEZSktD2gXw5W/XuXDfqEvpQLBkFLDO/dUW694C1lwjL6QMrxAFkWVAizcvY9YB+33czI9pmcJ00VOoWQANOnsHuLCCQ258I/bdc/GUJPfLuo6qirFtoLj9bgKmyaFb1yIO8DjIUAHGyIFzlqgqx/C4EK83uqOCsNn3nrhPr3TRisQtX0jUAXb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0695;20:fhEIs17aW6ZxA/gbeON9XmGU1j9yZ+jXUmIozzzE23NOGW1p3P+gUWf4ObPB81dWXtnfuDCe1OOu1G6HUgeWOQtDWz3pxbgmB+AMrAoDLYTKflozjWBBsBlr/05Nr3s1o3fqnWKmVTGbn/Qf1kWajxXwnebkPujvHWV0YHRXkgW3m3g73sjIrT5nXnOHwiHRI9tmBt0P4dVzCxSHwy0VtI5a9P5AI83+9Lm2emC1wKPvyID2YrUoS7W+uz1Vq54S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 20:04:06.3496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3a8405-c1b7-4fc2-e43c-08d58aafe88b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0695
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another example of required braces when using a compound statements.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---

Changes since v1:
- Move the new example up, and make it more generic

 Documentation/process/coding-style.rst |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index a20b44a40ec4..fcef0b4b59d0 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -188,6 +188,15 @@ and
 	else
 		do_that();
 
+Do use braces when a body is more complex than a single simple statement:
+
+.. code-block:: c
+
+	if (condition) {
+		if (another_condition)
+			do_something();
+	}
+
 This does not apply if only one branch of a conditional statement is a single
 statement; in the latter case use braces in both branches:
 
