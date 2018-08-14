Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278B7C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE16A21745
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 01:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="H6PZ6ug6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE16A21745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbeHNEjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 00:39:21 -0400
Received: from mail-eopbgr730057.outbound.protection.outlook.com ([40.107.73.57]:11072
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbeHNEjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 00:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJLs8d2DEAEcUa+cNhtB0HbDFo3gSaY5z7afwSLErRU=;
 b=H6PZ6ug6kn5ZbMQ/GAhmfXuYG7QPaXxoWF7CsY30OndCpGYtKBU96TRLgdCSpsOywSVCF+rF82Jtpb8GMGxuUVqwMD76/VciwiKc7d0WREc/ZWUUHTn335QqrUEih1YyRPIZpyHro+0z+z29KlyDr6BW0KgoeHRhVYsDEAUSL54=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jayachandran.Nair@cavium.com; 
Received: from jc-sabre (50.233.148.155) by
 DM6PR07MB5019.namprd07.prod.outlook.com (2603:10b6:5:25::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.22; Tue, 14 Aug 2018 01:54:25 +0000
Date:   Mon, 13 Aug 2018 18:54:17 -0700
From:   Jayachandran C <jnair@caviumnetworks.com>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [1/2] dt-bindings: phy: Add stingray usb phy documentation
Message-ID: <20180814015416.GA29046@jc-sabre>
References: <1499432825-15820-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499432825-15820-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [50.233.148.155]
X-ClientProxiedBy: MWHPR2201CA0075.namprd22.prod.outlook.com
 (2603:10b6:301:5e::28) To DM6PR07MB5019.namprd07.prod.outlook.com
 (2603:10b6:5:25::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a80c04d-b0cf-4438-d0f1-08d60188dd90
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB5019;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5019;3:5eP4VsXhvCHYBKQ1XTX/7g/cuBhcfEd679T2CduvNvsb4chB+uzAoAjvNGWAbaFg9czlF4hb9nhJRr5mep56Y9x/YYzPTv2ACoEec5dCgK31dQTR9Ry9bELx+lNIlikeHiP4jT2Dzd/qK8UmtnstrHkxaLhytgVcApYSrXW/N6S8IgdJhhXb+y96hu1bxtD0JYGDvNuhy7m6mw9WYikgj8wjDLaUmB3zPwn26SA6cq+2X9k8a2697d3+lqk8YBWX;25:4YsxAygw0ivSGfjP3dbSLZjEMV5Dz2hoHymzvpq+blDgxm3FrwoM+1pyOeEs6U/bZ8r+VGM+uTz0a1/85SavsQumihusQRmYLIfeGcsK7MSdLJEiKLsaRkUG7ADIg/Gxcvo6nToA0PgIYhoJoSVb/SNkOfDiAfmnED4lDoIXxiVxar9makSapOcFlT+O160Kk3BVBtPPg1EjFLA/WMzcifJ5UULJhOPS3ArRvK7N7VH4AvXPDH/ADAJBjHREyT1QH/rb4O5b6qqmxLJwb/49pVP+qIJMLvhnT9nS8uRQoK9JCDuhxmupuH/pJ3ut/DrfVLZI9FAitGgfF+1DoUSd0Q==;31:pwlHY20fNolXUUj4LUIAC2OvRgmI+3gWE39AZzSUPecuBjaPXoO/BrOKvwHzgVu+sH3OMu5KC929vYtPgdYtZ/VkJA2TQSz0HBfMBXizTu7pj1zvUSv4+X1v5Z4gvCrTP+MrTnxbWdTZ8fxSDwCkyOiRukvNkhxCtmnPAjtqfnq82DZzj07sHFxpddYGoht03bZy8Z/Z3+DDDxcnqMRJ4NrOOWoQHXvDNkPSjyW1mEE=
X-MS-TrafficTypeDiagnostic: DM6PR07MB5019:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5019;20:V1Wq7U9lntPl9ex+5bQAH8TCmVYaK/FSrEBLEuESSVTqjbFhM3ikdPG3wCJA6wz/PkNqBeOnG338kj6/ZY2EDFlvJQG/ZtKHdFHheU9b/M8CSQwUp4UdeRqEcGsQmlGhsETJfivoOpfdiahkdKRjyECYGIzgpz4O/IUNCPI5cEVHK6/D99lTV20WuLgO3AB6NKJfJ6zU4mh4NGlYwgtzpQ/EUtOC8sWOI2yWJcWZBQBLJ6iiXVCcoAjmGPM9UXmfGFuII4Pz6szGE3W+WekCnROs72QGiuslZGmy6scFpqY6irTjo3bySBraSNexcWJPjuT5MiejVna0mpJufqbf5oNpIOFGyXKBgBHU7WA7LcXNOlZbXXnncbrFc2bpp2vz5CKG3PcKy8AD2lF8vECoEi+Y4CNCyF51aTZTFRSmV+L4gvb7NV5Wy10LyxBOl+oM6uVKUA/Bb8Ls150hpE5WIFpqwinYenkf7xVWc4KUZTlQ1Yljpbi5/nwStKH/cKLyjhwWv/IJt37RAx3WuMMWb1PjC5tpGcJmLwTxFQjHVo1YDb/IzKl2ytr22a/Vp5RofeB+bqGhhRSL3GKuNPyEVqoidV+BaAEm1S0KsgzYl44=;4:hkMqg4nR8hmK6YTI5uOojOTILXo1rZIKJICzJ+OntRqNgOGqiT+ZWhz4ppLeIicVg37vb0cDp0W3bViNCNw1hCxQP5FYF8i5ak3d+n5kmmy8hYxaBKsMSBQNvw/hh+7sf4z5TRUBzK3ScE28L7Vx4rz/o/SyCBHuVZ7oFviPiaU4WDd4Bquf3KrGLGccvsNDqtsSNdLgwWKPeWQqtIcjoIrnRKL941/e9VLR5/QPEviK5r6SwG1HWJ2v0BaE+GBLlFaA08BNDzo0e4g4YnpfKoS6VZCcMPZ//VO6sfC/+7+8aeEVnm/fsX1lINbg5rEC
X-Microsoft-Antispam-PRVS: <DM6PR07MB50197211E02A05F1ABD1A65984380@DM6PR07MB5019.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(208715162771679);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB5019;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5019;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(366004)(396003)(199004)(189003)(72206003)(42882007)(229853002)(4326008)(2906002)(9686003)(50466002)(8936002)(6246003)(53936002)(446003)(5660300001)(55016002)(3846002)(23726003)(6116002)(106356001)(316002)(33656002)(105586002)(54906003)(58126008)(16586007)(6496006)(478600001)(33716001)(25786009)(1076002)(7736002)(6916009)(97736004)(76176011)(11346002)(956004)(66066001)(476003)(6666003)(52116002)(47776003)(305945005)(186003)(16526019)(8676002)(81156014)(26005)(81166006)(386003)(33896004)(486006)(68736007)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5019;H:jc-sabre;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB5019;23:w1ldQFp8L1wddbxRFuz0QMgVMaFVuCs/QPw+laGFL?=
 =?us-ascii?Q?I8cQCD2f1GBjXWCGxHtyfqOzl48vB/A+7E4q7AWlD2K/XWuex2NWYBcDOK/m?=
 =?us-ascii?Q?ulCvrT3zROt5sqXL7bFfajYSk2eOseVZHlBrXyAAl9vCgP2T24KrNsq2jCgd?=
 =?us-ascii?Q?Qhv2Twq1kIe3273ICbejIPUCduqPAz2bEhaRjxfGE+j53mFldLEvtJQANY/H?=
 =?us-ascii?Q?l40oQsrBIeVQomBNJCj86YDBM75T7NysjGpvDnPmYKRl6BRqqVwJm+uUCe1V?=
 =?us-ascii?Q?7bMuw6q72MBXNerDxOjak+aU94LpaEJyfeU0A/CV635YbbDb+qf2X5Gsfjd1?=
 =?us-ascii?Q?gEny3z1GEHiTyV/3kFkLX5m3FPt16CCAxiboLV8jKWtiU91Y5BV2BpJxPn3k?=
 =?us-ascii?Q?Fu32LFEy9pK8q/UTl/VVGkl3RkBU3cqP1F8W+kvc9xoAENijwCKEIlLeWsWK?=
 =?us-ascii?Q?LGt+Ukua4ZMQrESrrAOw5WL0ocFrZfFxd7Xzo2Vtq5WpHUv6qPlns60eh36U?=
 =?us-ascii?Q?XGQ2gYr6espHsQtbduNemkpuP91uIE+Tbfvi/b3FlEuUx+XonINQhXgJ7Wbi?=
 =?us-ascii?Q?Uh1iziOihbDBGpclDTEsIqPOh5r9A7LjEjIieSNyPiX/jIdBWfBlpDI8a6+r?=
 =?us-ascii?Q?9aMivI/CnhkxC+2eHhxoxXIeAX1hD7S8jTRvONj7Ezt7Jgv0CJK4ILRD6nsX?=
 =?us-ascii?Q?8Pxt/fAs8xiYBwDEzD2nwu1pg0IEGGb4UqWDaNHnriwRuRIZh+rg4e/1JyUy?=
 =?us-ascii?Q?SAEnO5VPHuUeV4Enq8t/YmYD85MaXvBdj3xt78+jwvHK4edYt+FQZ65k7Awj?=
 =?us-ascii?Q?IKy4mTSvsmYO89WTG7ccKJTUB+EPa+YOGxUa1ThyfVSRmMZVKU2X6S9uXMc4?=
 =?us-ascii?Q?+7eYeAu3EO4Wtj3Ut2vXEO1KaCmZgWe3kvj0mj0HausSIwbpRPM1zzGL+Y+D?=
 =?us-ascii?Q?TwbAORV3tmVWB/iLWvnarKT6DbSC5UxyNMpXmhsl/F8bjtE15P4evDYtH6TO?=
 =?us-ascii?Q?M6QlXPMkgcFrHDHs32nKm+BdriC+/ISHfrzpykiWNqwrBKuN9AOr5NwuVvBD?=
 =?us-ascii?Q?0lIuoqxOIty2Byeo4wGnCzd24h271jFagQSteS6PZP1wdyZ9AuqFMRcAaFhm?=
 =?us-ascii?Q?tE0VUyTB/IFQGoDNuGYpzeBq3cI76Hb557b33nT0OOT17ZmvyWqmp/4JN/si?=
 =?us-ascii?Q?7LuikERNV4gsZJy6fmYfIBrqTH9HSFp8n1davqpRpFI6htYg7Dr59DCZ9bed?=
 =?us-ascii?Q?mN/HuOY4vKlfxnp1euOim1t6pApscPySsdwTZH0l8/lgGRRG0iKcDDZqpUoI?=
 =?us-ascii?Q?oLAhSEmuSbo7irRZZVFjIcBBEHRVPBt+8cIrHcAgYIW?=
X-Microsoft-Antispam-Message-Info: FE2o7R3A+pJlnBxvF/INwt/2kCqCdNtETWlvddIeTIQvzz56vfZkYWi9EQR58iB26L5nOUQ+Li63ss6vPN+LGEaleFWUPlNrIZN/O+ZeS7DO+rJBYzPhRRM0OJYEZisw+TnpxF+it+9fYdYospfi39WQT6t7FMNQGBH8Un7WG5fJN7C+PZm9qPUvmarzpz5miGF6rNN+SxQk8UD7ufZnCt3PlCdi6EU7TPxHYYheyXNtVRgDNEXwUkZC5DgD5AFpjUExbUjm/O0DaD8Ch4oJoJMVgkKiVqU4Xq9Q3xUiDDiH5H5lgE9pyaYj4GPV8mwChK8C4wir76rUjcFf9dKbKh3fe/j8CUj+09W0vld7mPE=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5019;6:6+aNipqEuhJIZoUY/hmshMjsIYsb553jdGsEngQlfBZQvHeI+Z/HWv5mtNMF5qE5f3/0wLeuAFLwSapGRns1BW1JEYdHwrS7EfNRBF+fysiWjTAUgDyLpC7vjD9oYmu3N9j1FqFnV7TTH5pH1Fg49aDPHssPFZ/s8ItiM4eW9Jl0DJkvJ08HOakAwNf9UaelOk2sYKexpZ1poR+lh2MsJkQcupYfAo8c8rbifo98CZ899g8bnXA8vXmof/sEmlhfuSG0pS14CZc/6np7+9B5Um3rYjjB/Dw9e4bz7aZH3WOiJL1DfSbIH8bvYg5oT3/DVcFhSMJclZwX3MQpJwZ69awdW9jXnHyBR02hS1cjah7MdEeYwc29n1h+11Jt/VrsOtM8HA6bEEBJbeF6GE/yJ0xnOUo7HrQGrhBEVXdbQIti4IuXbKrb4Db6UQbTR3TpGVEspdipWEppQYpIXJsf2g==;5:Bu567EVgDezAQor8fXBgRgTv4/N3BaZqCjdui4zxomWgtefPRSVqrXuzpe4R0ptYSNKhOSZ36kXNR7pz8D4iadlbGdvPROYg+FJEXLTCybmIiwdTcAFEa8dFjYKERQmHzBpplEOCE5Einh80d5OTKg/D+ClQ9ecXWGbVB7Wz/N8=;7:TB0M/avZW2JiGsLepvOc/ujPCOleYFIi2QA/9GwbMjMkvakhB/G7XF2JhVlLwOw2jMC368VZCMjyJvlfpoIbS5k49bNSxjZaZbOyx6K7xEMv9KUdEi8K81KsFGUdKjFte0wrQ1Wst9oU2X7R/BgmxYdPwMa+t+veL4GkQvCBSqxZPXstMgZl9Ev5Z+EHaAsoiaQLplLSnRinMncxaWDWT8M46qfqMi2CnuAkFt+ZdDesWKMks+On6PR/UKn43vox
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 01:54:25.8175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a80c04d-b0cf-4438-d0f1-08d60188dd90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinath, Ray,

On Fri, Jul 07, 2017 at 06:37:04PM +0530, Srinath Mannam wrote:
> Add DT binding document for stingray usb phy driver.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Acked-by: Rob Herring <robh@kernel.org>

The Broadcom Vulcan chip (now Cavium ThunderX2) uses the same USB PHY
from what I understand. Our hardware team reports that there are some
failures seen without the a custom PHY driver.

Do you require this PHY driver on regular operation on Stingray? Or is
this for some specific functionality? I am asking since the issue
reported here is on switching between a USB 3.0 and USB 2.0 devices.

Any plans on submitting this driver again?

Thanks,
JC
