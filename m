Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeCZRDf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:03:35 -0400
Received: from mail-db5eur01on0079.outbound.protection.outlook.com ([104.47.2.79]:16253
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751994AbeCZRDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:03:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH 0/8] drm/arm/malidp: Enhance support for system and runtime power management on malidp.
Date: Mon, 26 Mar 2018 18:03:12 +0100
Message-Id: <1522083800-30100-1-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:803:1::31) To AM6PR08MB3032.eurprd08.prod.outlook.com
 (2603:10a6:209:45::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e27e5591-7555-438b-cb36-08d5933b80dd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3032;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;3:994CO3+98UshT2T/iyXcvGH2OagVv5eMmOyQCzHB+JxTn0KbXApIjVG66kLZRubK3F9pl90TP+KbXTPVXp6bfj+OW8rvXLVA6k2UykrWqchbm+R0pg6X0ngtpajgNLJhfwuuEGfWMgjHxlVCeeYmV+U3S3CNlnVarcYfqkYfl5+8cu9OOES37IrtfJicUrPwgudeviP08/d6wen9Qw/mSW6M7hGTy6ibFJkB2FkbEE6Ttf3Y9OleJt04mLAuGTRR;25:9/BAcqQ9QvyMQSFUDj9x6zhFTFB3y7tvEKK9W4s8yD89xzJknKB/gLKym01kPrIoDkDIzQNNOxDsxIw+oxOVS/hAjmVN/A6jhlEr9+MAC6azzI9gpDur25UpKJGv7Gfmqacj8u+qLPxv05pgCAkv4MvrDUL0nwQyh0ydRm+mfhHZaqZSXGAH8HSuTFQUlCeChGhvv9/EL6Bs0XRdMhOu7o8a63rRCqvb45xK5cOeyrCSDXZI/P+fg9YAvqL6+vlChzhH76hRsmRYeqgoduRumpFOVCdimyZEgN5ZrTabHS5tnKttCuUnN3F2/UVYbAmtAjllk7bsBSbsKjPxOb53+w==;31:CMq2MzFOWSDW/5/O+E1yoegYn0BtdM7pykNCfw1vBxaFODiBIvkrQJReWZ95CPVFeO40qaVUr5gj8qMLFdMri9G4qMRKDt77sc2+HcTEy+O1tE/dfFN4DWSbeLe9xuBZ+h+X4PHmAgsSO9fVKCBjnMILeJrPD1fXOhOPn8rScjaWP6r17TSGhhOCC0Xc04jmD7bLleNpbDQSK9cTquK9GNa7RcSVEyYx1e3S60YM+4E=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;20:ZQxYfBUyn4iODjWC07FhrTzUo8oIISOMEE9xicM8UQ7Ap2k7YJTWRSe4TtdAzZAilMHrUIPirA5afmNMF5+mZ8PHbHS7kDYsgIKYUvYLfGzu7eIxiJoTy01NaECYmGrtKtbU+RdEn8h+HHf+An79cCAumaggV/PZI6syWJqoi1E=;4:lr97UusaKopd0tUitiaeGEBhDqDqplg/1fGy2RXj6233lv07OS48iWNbFMURJCWb1lspnLQrJR+bpQ/+hXxmEuDHNJxYeBh/ZpVi+Jh/r6+lxxZgIqK0GF6SK6S8UhiWHYAIx4wqPALl8fFpttpyztyaVbyHpIkIO0t+ntkXsfV94nRPJV0NkocjdPmCg+s4KIxgmwkcI3BiJOgv5XWsvvKtWYBhksGgECco4gGkKZTc1LM1qsEwZUnt/9OVQid3MsAW8tSEXRt0BtgfeR09tQ==
X-Microsoft-Antispam-PRVS: <AM6PR08MB30322F04CD9C2A33F4762EF1E4AD0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:AM6PR08MB3032;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3032;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(305945005)(26005)(8936002)(86362001)(478600001)(6486002)(16526019)(51416003)(72206003)(7696005)(7736002)(53936002)(4326008)(486005)(486005)(25786009)(105586002)(47776003)(66066001)(68736007)(97736004)(316002)(6666003)(2906002)(106356001)(16586007)(2616005)(3846002)(52116002)(6116002)(5660300001)(8676002)(36756003)(50226002)(81166006)(50466002)(956004)(81156014)(48376002)(386003)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3032;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3032;23:sGx21n8v+ov7gNoDkFVYjPrAHFOpmXKaUCaOgM3Pe?=
 =?us-ascii?Q?6UJ//wsb1kpgXJWfmsgiZR8NcQg0hjOJZ6EKkbmedTfpns0v4B4DNdv9fcji?=
 =?us-ascii?Q?K0QAdjGYmflrR7/lmCMSuBnw1+/1DjV5epK6NnY4XB4XzqBRZunTYoibThgi?=
 =?us-ascii?Q?sFGvAn0nn/kB0XaoSq8+f53oWomBQOTre0ijyM61Bm/p6T8I/ELHWyQfpCBY?=
 =?us-ascii?Q?wCCrVXJAW36j2KXJZ78qNYyb6JEuR71S5deBC9oiJJ7XIlTiPqCufV8w08Kb?=
 =?us-ascii?Q?8LPcctxnycYTX5lwXxj5LsLC2H06LbVtQeXruVN1fpLNVufuECA0tf4x+vJl?=
 =?us-ascii?Q?ATLI36HoiRQzgZkqADaIJd6Ajh11f2c2Nzg1nIT5Fa8A+WiUuCWYYcKz/daK?=
 =?us-ascii?Q?D1OUd4Z2r7XefKgNEUNozBaYQUnr6qGy1viseuaAOv+565DVOnhS7WgO0ggg?=
 =?us-ascii?Q?TfGtWkSBOkFdopytfwr+JteKBnl6h6ac7XFNV04xsrEHhEhd8HVl1tvBpg3N?=
 =?us-ascii?Q?/hi1DMIk2TmuXuJuZE0dzgbyz8cos8vD63d1UgvH1TPVWAF0SedSGLt55zvY?=
 =?us-ascii?Q?q+KxBBLLLM0PXgvl2qlUghVa1ULQnoDkAmfN4nseDn7vyDCF2t8h1RbdXUds?=
 =?us-ascii?Q?oTtApiVS+GdlVnKnRnKgwd2KOS8hg3ojixY5sKlT7rtdD6Rgy+A1lSIR+pgi?=
 =?us-ascii?Q?ivwcWWy7RgXx6LliY8WJjO9APPLSjLcs1C549HKIb8XRE5NgZLZF7gaLpyyD?=
 =?us-ascii?Q?9S1kK0Och4kn6hA10AkdX971b9ZASHRRYfCa/RH+9BCxkk8o/du9+br7Nxav?=
 =?us-ascii?Q?hyrqPVUy9dd1LSjvlVRVMPlTIbQuARp52g92vWu40O7VCmqmbtNshgkUm9ag?=
 =?us-ascii?Q?8l1R5Li0/19gmSjYsH5VyicyLQDw8IK/y/2sh4zKITczo24ehxyaTF1juyuQ?=
 =?us-ascii?Q?NKIectGOBD3vI3gHwHfTcd61dPKDlhBALscK2gArvIf5Qpe5UrusQ1EEXgsx?=
 =?us-ascii?Q?ay0eeHj/EHw849XyesOIJdK9nIhZAGp8Yv5UmM1MYYbISjSU7LhAxtr2rU0y?=
 =?us-ascii?Q?jGSc7/T2UEhgvYIYRVM2kcBoNC7OA02g+aMeUPBoOZGMQO2sg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 82I52hYqvZ64znq5Zm+RnFj7D6fmvsCiNrbGbvYubfd+yhNC+d45p9sVJT9odv6P6KWACXlMYhGerMSC68qF0by1lj2CXiyTsVsNoAYrohx4SqJLLznByvBaKIhXkAGz8oE8XFibEKkiNgSirGUU5UnM7ru+l9SnBE/Zz6qDyWNd/9CR9uD5JMrR23h7QhAH
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;6:+QqchFgn9R01IgImtp6EwwM2uFnf+yNsFuHTlg8xIeLGHCxXFJZfA8ccSIC8w5IBfdcrU3abCOkkKC7YluXx9/yYBS4dxouI63Kjy5uUV94Ggb05lKWo5d5DfohENZcSjqp5b/7nBUaR/IOqhQ1j5RYBbMJs3bbPQdix8IRaihd1HKDir/Mz+9ykOVSlWHVmcP+bczuV40CIO+c6Zm++fBr5rOmQLuqS1rnEDRllM9m7S8obW7sah6FHwKzr/I8HpItjyAB3ivkNEbQQuf5fQoBLGjbuqCWf/9MEzmjHdCLLjMxUurnoIhjScg8Z4PXgJBFKa7ugq7CDkltlvQE3ymkIh1UJkS67zf7WPXHr7uQxX+vgVLrBZSe7Xyn7gvXcyZ/S+TX/m/MVPotdsA7RJdS1W5Ro/2U0cOHrSjtDQNdH4JtEWp1EpGlLBrxE5P1uQtpQa3NCttp6YfyOL7x5/g==;5:WpWLEFGFJvNudXJN9k4K2iKLMlEjVEHbkvi+oShNmrYe8XJdb5SqwtJyLoaq8B1TqOTJrMMQGQSFohQvNPCNu0j/PXJPR+x2ra84za8APg8oVOx424+0WjCfCco60wTJYWJ9W5sBn1tCeIIpmVhc7mzyLq4YimQhiYXS77BH0WI=;24:pd8T0htja2C3j3UE37QOgZJe9drjG2stjnVzwpkqrPMq+KlR4h32Rpgp1X1tfArNlouJptI/4l/+xVpzrpGyjl9N4vpSLYHzRgnGnT3Quwk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3032;7:4nOsqNI30zXomNgeuwVf77J7Nu27jolSwOY3rBVbngHFjQe+NbRZ60JlfxVnl49/AMtPCVZetFZAuGsBZK68T8I0frnCiJx/hnBo6VUiNoeelcDl90wAtvfJOw+BZLRK6U0lvypNAjU3Y/czlYkMUw/D9khWyIgwfPHxZ2WiF4QDFrR+K5OMM45094MYCzmb9h13LCrQcC1ciYyleL4VJWi7YPriifWmfa+RpIUr575Dv65k5gQ9icPP/gepBkdf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 17:03:31.0603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27e5591-7555-438b-cb36-08d5933b80dd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances and fixes certain issues relevant to system and
runtime power management on malidp.

Ayan Kumar Halder (8):
  drm/arm/malidp: Modified the prototype of malidp_de_irq_fini
  drm/arm/malidp: Modified the prototype of malidp_se_irq_fini
  drm/arm/malidp: Split malidp_de_irq_init
  drm/arm/malidp: Split malidp_se_irq_init
  drm/arm/malidp: Enable/disable interrupts in runtime pm
  drm/arm/malidp: Enable/disable the scaling engine interrupts with
    memory writeback
  drm/arm/malidp: Set the output_depth register in modeset
  drm/arm/malidp: Added the late system pm functions

 drivers/gpu/drm/arm/malidp_drv.c | 33 ++++++++++++++++++++----
 drivers/gpu/drm/arm/malidp_hw.c  | 55 +++++++++++++++++++++++++++-------------
 drivers/gpu/drm/arm/malidp_hw.h  |  6 +++--
 3 files changed, 70 insertions(+), 24 deletions(-)

-- 
2.7.4
