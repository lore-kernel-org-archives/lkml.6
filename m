Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82056C5AE5E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4D32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="aKVbl8s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4D32075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757196AbeFSUja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:39:30 -0400
Received: from mail-by2nam03on0080.outbound.protection.outlook.com ([104.47.42.80]:18848
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754833AbeFSUj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmBCeOkKwgyr/MBuWcAnsYq6Al+aVHy2cJTMGaBAeWA=;
 b=aKVbl8s61zA8r+XLxtBhE+56xO3GRZcqdtc2HUaIoqqHheuUkXbxe280R1Iz+Y4hr3gqmDsUBQQOgobnWEFDRb4+6Oq3QUoof6QXeGnUrGajqwL84hMwlOL8hF6yCDXSR6XfggETIWhsGlqvQ1EMn+eyzhc/QnwxFwoD+RwZTr4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jayachandran.Nair@cavium.com; 
Received: from jc-sabre (50.233.148.156) by
 CO2PR07MB697.namprd07.prod.outlook.com (2a01:111:e400:141f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Tue, 19 Jun
 2018 20:39:23 +0000
Date:   Tue, 19 Jun 2018 13:39:11 -0700
From:   Jayachandran C <jnair@caviumnetworks.com>
To:     George Cherian <george.cherian@cavium.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, pprakash@codeaurora.org
Subject: Re: [v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Message-ID: <20180619203846.GA6083@jc-sabre>
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:104:6::31) To CO2PR07MB697.namprd07.prod.outlook.com
 (2a01:111:e400:141f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8683d7be-6a69-4c26-d97b-08d5d624be34
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR07MB697;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;3:aIQH23wNr+nWhydmxzIP5LONYOPF8hnSES8XiRaEZz2/f93Mu/PqtrYKwMm4kW7M5OtZxlW86yOgI/84ysrfjnBXYydVO4FeMogHGdm6YXajVuesXk0wSUC36Yx/nUrAlUXMymdlIWjg8TOClOad84GqMTGLsVlhg/gm2prFvol1sPu255tw4xs8IhHsVDsBNWFmMAai/b1dlG6dzZzVHK567ZmpFZ6b3GtsRi1daSzh8+eWt92a38Njj+BhYO07;25:hKFZgG1ipe9n8Hq736ddAjlOEpkpvNozoGXsvwNOL/YdMXfauqlDmajk7E4hxc43g59fXOVu0n317Ih2s0IdGRClrStbL4Iitl+hyLwDqn9UPYZwhnjkSy0AAwIMMWxj49yuhzRQwOwPbYUbYmBdj7EH+QDf5soqxyDqBcMlMboB6d/etvdE9kf446vo8h9VymmtM08ZECznyqllEfXqXzJg25JRV7A41J9iy2ETqGthw2IZsvnns+4B7O1imyc27XtbfvxKFDdKnh0nOVDg/P18p3NAo4vZ90bkaSfs4CWGx4yyZuaRl/9C4c17u9ADuPSvlcgxqOV2uFB+GWcubQ==;31:pT577dcOgioL6cDIf4OYPjT7OcYHKZYd/1H96nzzO+jprUljDfbMaqNhKfG7gyD2ib9xPjhd5uxEK2Q2nWbcx1JB0w0TFrynFlatHvOQTALIOvrVMoDht5c+leV9VjWysVNgfFSY39s5OUp+lX4YDk16glNkTNmAbnhv4f+/UIvdqnIbc+kYMw0Mg8vsuITHF0Hm+ntYgVQyuEMfdiDH1Gcvt19ebpsNhTJ5MzuspkY=
X-MS-TrafficTypeDiagnostic: CO2PR07MB697:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;20:lCDV0cbQU5inMnZaTwmECJXEbReTjaxZJ9SBRTaYghdzTCs3YZ7JgtX7ZlvITSyTV4mvVNgtVpY2A2/XMEMonNTzV9RzwF1VH3b3Vn/O8eOQ8JNW5kPMUM0YpCifmCpAofZoFZkp6lwmlnPV0V6YUHlVSX5ROZJbhTkthdbzOxwuUpwOiNbh5YyOpjOPLXlDgNLOMhB2KowNykkNwFjtJjfeINTaaSJTWT312FqgvaVCVmYyNFcdU9ywDUUjC2XtoyWdjQzRiMSB8KxP7OdQKuZoBVHOSQy/RU9rqskhRtsJvKSxEgfXfLJufwIZFmBH9xPdVNbIgNlEpJe3ZCoOD+9d6CLc7rAk/nEqbcU3bRhkwj0EytvKkfTIU2RfeXv991VB/vDWIsShFxd+DR8Y1KfCEkO/wLlVXFqAYdHICaUJNq40KcFJiBmXuzCq8CkomvIxovv50zTh1niYQB3xA4LNXM/uW685NQI2FjsjLiXDlVebGWMiBVw3fovUAmqOvBHHZdJkow4NEVTI2HXSfcu1VCz9alHovh12p6ML+LQIp3HUCufo8pZA6ywjIV8lkZL6ucHi3BTcYOU30Dwz10o7RzDObmjBqDV79pRY6mA=;4:VRq53wmobiUACacssd1NqPdeBxrmxRwmSOsnohLyWMjjBdRf7nfz9JpYuaONiFvxA2Tb9WX13XcJFghdPUBKgDz+YQJ2SbPul3SeKKOYAiaktMk2rnY/3sf25ciGnkQfKpinNt+avRsp2kKKF7xGOnNwNVG181LBOI04W7/zLvm4w8hsnb4zvq2rL7Prlu+wq041TF5z5/wtEl8fxOk0D9tYJ7NEVPbqzp15vp2p8oKm8kKmcC/n2cmSjSQmHx18RtyKov0QLQ52KRz4opG56w==
X-Microsoft-Antispam-PRVS: <CO2PR07MB69761B1D5EF336E89DBC90584700@CO2PR07MB697.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CO2PR07MB697;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB697;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(39380400002)(396003)(376002)(189003)(199004)(25786009)(50466002)(11346002)(33716001)(3846002)(81156014)(305945005)(446003)(23726003)(7736002)(5660300001)(66066001)(476003)(47776003)(4326008)(6666003)(956004)(486006)(1076002)(9686003)(6246003)(97736004)(81166006)(105586002)(2906002)(6116002)(8676002)(8936002)(106356001)(42882007)(26005)(53936002)(72206003)(68736007)(76176011)(6862004)(55016002)(229853002)(16586007)(16526019)(58126008)(478600001)(316002)(52116002)(33896004)(6496006)(33656002)(386003)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB697;H:jc-sabre;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR07MB697;23:dw+HolZoiPr7jb6cSMM8rJNBVwMzBQjpUdFQwny2o2?=
 =?us-ascii?Q?TDNLCFGwR7EQ2j5qUnka/LoEovGwbMUZ61yEvlD1caX9DGS2Ody4j3p6VvAA?=
 =?us-ascii?Q?I46thHjuDQxlAE0uHwRdSD4wKcxyV2O4DFvTtdQVJVLtPdHqTldSPqpArAkK?=
 =?us-ascii?Q?1KHVuxOXOW0fM1wKJIfEyFM4mJrCI5LGelBRKtZUn4P5W6T8qOLb/LRFxJyJ?=
 =?us-ascii?Q?6H/uxQ9V9iQn1D3Rq5293FOlsXbi1RWM4ym7AFHkb04z0xUerhK4mlNfFa6n?=
 =?us-ascii?Q?QBu6yda20zjnMszUDSliF98NkEebRyZTcUX2HGzAuSIz39x28/qm37JMqKcD?=
 =?us-ascii?Q?SuG7LJOHzFZJWYOmn1d6LAkFBIlzgCV0z8tJ9r+4z7k7Ax/TGgKqQnzTVFLu?=
 =?us-ascii?Q?ApDUF5b12nMdte3EJVRc0Wt2/qTKo3NOTKKyGCZA8fhPl8dkwUnh92scP4g7?=
 =?us-ascii?Q?ywzowFXi0ekhycEl6UlMZ4aYMABx2X7lY7dLq6sFMBie7FyknzQ9ekH7Tx8j?=
 =?us-ascii?Q?3mE/OtK1ckqg5m9xYcZqxhuB2tXqUKVGdD46TnOFiFYbgA56aQwKVeekkP7g?=
 =?us-ascii?Q?XV9VMfpRD8mCj1BavVRDVKymspgf9sqjN6LUjXhhYnp65tkUMtDdqUoLgUgS?=
 =?us-ascii?Q?PNnSLU8i3zvLPFP0lv2ooeUqsKZOtGWOIBeXyaYXUfoE0OctLacs/WR4kFNC?=
 =?us-ascii?Q?eKASfjmCZ5WswugVkXN12A7CfyKkeR6X7FZKmxsTyLb1n04Bp/1DUUj54Gyt?=
 =?us-ascii?Q?PPLYPKrSPC8CgTOg6E5xLY3WPu6pXw5mj+MVBfanjPo/t2D/YfBAsPXoHQge?=
 =?us-ascii?Q?YRQsoaoV7thwMwd7+MJVNrCrW9JupWOkgl0jVHt/Tt+Zxht7Ky8Dl0qNmno+?=
 =?us-ascii?Q?CqzWe9Amtb88XB0zbXLodItz5TmWkW+unGcdaz5cusWo4hYXa5ONiShtnYH2?=
 =?us-ascii?Q?gmAe7UBOFf8Uujb+mG9n4LiFx9NBv85aCVyNTOfJyZyawFu11QUICGDzYfN5?=
 =?us-ascii?Q?G5syPMouFFLuoet8+JaQ4xvmPwhQwWNKV/Gmu7UE89eP85j6HZGrS0mYpLAb?=
 =?us-ascii?Q?A6npkwV1fbw41VX8rQcV41lBXcBVbtxrZbWszwhPNDD5Es4u71Q107Hi19NY?=
 =?us-ascii?Q?/eYweDSQiy3SoGTyj58Jvk1bVb/1BzUw2q7CKS1kUPCCHldtLzhCPk7L0f21?=
 =?us-ascii?Q?9ihZAHxtSTF58lfjMgyRnnV1iH0onSbXBbZ2QMbJRi0oug9gvFbJKE277bgP?=
 =?us-ascii?Q?Epim8uOJs2EeSFsDxhLl0JU+TgNIh/YH4hk0ancxjB9ha9jozA9jvdPZSA9g?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: jtk90uIoLnyrlWJuPh3ls7mGxicljQGvjU0N2eN5YUNMDlz6dPWY9chkpsO7Hk4Wh34dft0d5VgkjjX+H/VAxhKS+iHUQoeOLRCsnDa2NgQkBcWfuQcirG55cYFDLdeQkCNOs+zdr7pfuKY/w3rg8Wmi/04GVvDE5ifiO7WrWxV7nme2FQXujFjpk1q8sc8XS3FpdVrrbOXyUPzQrJ4dCf8Z/OGk4ahRZ1uxZg3LXzt+cVVNtejh+VbvR5TUqdvyJwyO+yRhTPpdBJK3HOhhzxMfgN/b+ip0ME5/R9GmyYvSI0U+1sU8GAz5hGqv8hS868Iyd0lFZw32qoehFLHxLA==
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;6:s8kE32lZ4HRlIX1eOyRKPu17AnmY74+/eWyRx7g2iQwO+OqWoXKV02RXEhwiVqtus9iaPDfHj+FsaKZ/BZ+zKWceUwkig8u7ceufvEp3Dq5czDt1/EoH60hkhjvxdrvQXYqtAWbSEhslVw1YVv80GmN3GOENHt0K+VFJMn9LQNur1uIhD7Ejs5TJ5+yxACfu7UOAJgzpjoO6OczQ6CXCMJbtMBvJofB2l3uI1m8hKayEfZN7dq3I28f5FeZM+1UTLiRQqq3pLTEqPsN7zQMJ6Nfhj0hviRkpeNNzJZcTM+hFRWkvvv7jrhEfIBlK2K18cGH+o2l1z6rP2nADAHznJaNSgAHbEKSjZiiyoSgy/y1vL65YHgfHKE9FIF9RGhaI1N8S8bHpMFw8nsDNU2VBG0isQHng9+MlA0gnEYWO0N3lQ7BFaotaBfXldIgoQ4SLfxwXwkgXoxk51ftio6Xsvw==;5:eUPA5Edcvob+uW+T4MfBulRFDCSAa+G7uNmXkX53giRLwsqvc/gH3WofWxvZ4YmcJphcEixG2A73Hl305IMcG7Dvjj1hZa/qh3GKEXsPy9W93/4PmKzb1rjIzFbvKUl4gg7rTNWTnaeYmAVhQ6J4OTHfxhu9eu90yVLeBBjSEFo=;24:0+e9g+e4FaM+0dqPo2TwJwPvhqHUhw5k/1ajOx0HK7rfc5GedIshzMv0JLA8OEFPTZLi80fz4Q1V2esKe4M00JPwrbH3sfhrIrs5gKZXFDw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;7:HRQGzOV3olmyFfBohu1NQKmOmYCo32aLc6m52CxSsTBc96ayUp1qLrSuwCEfdqkx5y4qqwwwkeiEjZ40YXH8hI2vtudHdJZcaRIGU2fkmotqZvpAesdYRb9YOCiVZFPncyE3Ze63/0guf4SOQneUrhhZ4j8ii3fgvyDVYASgb2z1qT65r2BuWEAfp25g7ACBI43xm/LaKu0mVQEtxsyny1RY30hl8ysTVYp6YlCuLpTntkDPupri2Cny0yD3shvr
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 20:39:23.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8683d7be-6a69-4c26-d97b-08d5d624be34
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB697
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

Few comments on your patch:

On Fri, Jun 15, 2018 at 03:03:15AM -0700, George Cherian wrote:
> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> feedback via set of performance counters. To determine the actual
> performance level delivered over time, OSPM may read a set of
> performance counters from the Reference Performance Counter Register
> and the Delivered Performance Counter Register.
> 
> OSPM calculates the delivered performance over a given time period by
> taking a beginning and ending snapshot of both the reference and
> delivered performance counters, and calculating:
> 
> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
> 
> Implement the above and hook this to the cpufreq->get method.
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 3464580..3fe7625 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{
> +	u64 delta_reference, delta_delivered;
> +	u64 reference_perf, delivered_perf;
> +
> +	reference_perf = fb_ctrs_t0.reference_perf;
> +	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
> +		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
> +	} else {
> +		/*
> +		 * Counters would have wrapped-around
> +		 * We also need to find whether the low level fw
> +		 * maintains 32 bit or 64 bit counters, to calculate
> +		 * the correct delta.
> +		 */
> +		if (fb_ctrs_t0.reference > (~(u32)0))
> +			delta_reference  = (~((u64)0) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +		else
> +			delta_reference  = (~((u32)0) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +	}
> +
> +	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered) {
> +		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
> +	} else {
> +		/*
> +		 * Counters would have wrapped-around
> +		 * We also need to find whether the low level fw
> +		 * maintains 32 bit or 64 bit counters, to calculate
> +		 * the correct delta.
> +		 */
> +		if (fb_ctrs_t0.delivered > (~(u32)0))
> +			delta_delivered  = (~((u64)0) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
> +		else
> +			delta_delivered  = (~((u32)0) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
> +	}

Having this code repeated twice does not look great. Also the math here
is not correct, since (~0 - val2 + val1) is off by one. Because of
binary representation, unsigned subtraction will work even if
val2 < val1. So cleaner way would be to do:

static inline u64 ts_sub(u64 t1, u64 t0)
{
	if (t1 > t0 || t0 > ~(u32)0)
		return t1 - t0;

	return (u32)t1 - (u32)t0;
}

And then use ts_sub in both places above.

JC.
