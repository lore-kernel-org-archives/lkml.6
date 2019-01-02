Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82920218D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PT7X9/jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfABURe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:17:34 -0500
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:3920
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfABURd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b5SSsJ/epIB7ChRzlXYuZR6hkpTtzGqfvFJsoRQDfI=;
 b=PT7X9/jcyAI1ju7xtPa1PRnbf4F5yv3dPszcO2mvi70n1fPycXkzl5yYhQN7VEsjsq8RpXA4uAuA1x/zS88qO7G1733oTEcely0nu/zDKPhrfd2+/CsVhmWboNT/qMN+rsDeUyiL+VBFbY8SL6pPqRTUfAL6QdVYnREU9QE/shE=
Received: from BL0PR12MB2468.namprd12.prod.outlook.com (52.132.11.143) by
 BL0PR12MB2498.namprd12.prod.outlook.com (52.132.11.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Wed, 2 Jan 2019 20:17:21 +0000
Received: from BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::a1ce:59b2:803b:9164]) by BL0PR12MB2468.namprd12.prod.outlook.com
 ([fe80::a1ce:59b2:803b:9164%7]) with mapi id 15.20.1471.019; Wed, 2 Jan 2019
 20:17:21 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 08/10] selftests/resctrl Add Cache QoS Monitoring (CQM)
 selftest
Thread-Topic: [PATCH v4 08/10] selftests/resctrl Add Cache QoS Monitoring
 (CQM) selftest
Thread-Index: AQHUmYz+cRKJlaxP+0OA4E2vEOmOVKWcfTaA
Date:   Wed, 2 Jan 2019 20:17:20 +0000
Message-ID: <ea7b91f7-aadc-c26a-f616-e400b5e4cf2d@amd.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
 <1545438038-75107-9-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1545438038-75107-9-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0021.namprd05.prod.outlook.com
 (2603:10b6:803:40::34) To BL0PR12MB2468.namprd12.prod.outlook.com
 (2603:10b6:207:4e::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR12MB2498;20:8M+gMRlssgFiFYpcdTnjoPwB8OTZFuGDkp1oI3iNTO74fiTbP2ciajtUx3aRvFjsfQFHOeyeTCH3Exe2usm/z/U1ukuBJW8Sy+Er6nnhEc69ePHd4H17Rzbh23x+432TaZVxcDv/+57Zl3VwV3l1o96OerD+D5Iw76rvZlhdqKt9JQc3+rwUEqiOXJcvIQ5Kr3Tpdp8RUv+V9RZBX3urJgl4tBhQbH4SQ8qQS2wxRgBIjII/ti7G2T7XxcvZR5mY
x-ms-office365-filtering-correlation-id: 48366f34-0789-4517-a347-08d670ef4cad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2498;
x-ms-traffictypediagnostic: BL0PR12MB2498:
x-microsoft-antispam-prvs: <BL0PR12MB24986D0D91DF7504D9039616958C0@BL0PR12MB2498.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BL0PR12MB2498;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2498;
x-forefront-prvs: 0905A6B2C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(346002)(376002)(39860400002)(199004)(13464003)(189003)(6506007)(25786009)(86362001)(26005)(76176011)(53546011)(5660300001)(386003)(6436002)(97736004)(6486002)(6512007)(4326008)(53946003)(71200400001)(186003)(53936002)(6246003)(4744004)(7416002)(71190400001)(52116002)(3846002)(6116002)(102836004)(31696002)(11346002)(575784001)(446003)(305945005)(486006)(7736002)(8936002)(81166006)(81156014)(8676002)(106356001)(256004)(229853002)(31686004)(105586002)(14454004)(99286004)(2616005)(66066001)(478600001)(72206003)(14444005)(110136005)(316002)(2906002)(476003)(36756003)(68736007)(921003)(1121003)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2498;H:BL0PR12MB2468.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OvCKNGkJNyVfudz/pK97S21PwFQB3mc7RlGM9glOfh4nGrdKo9mjMZC3CrZlCXGt+iMyPzo+/0a4UAmFeYkS0kuTnlDTZkKtgtoM8xGQdLvw4QatqJ+RlLDj227pZml55tDp/srCzy6bsA+rNDpL4oGq06nKKHK1+dj3Gka0RKGkYSrKS5nz3raFGgSDv0Yhi7rzhfHP/u2VI3FxKAb7JOUsii86XeOuV8UYKR6n5dtznyW1EtrzpUmuTR/3TeiSE3iZRavMpraxDcN1HcCbAdTlAczePjU0lPlG2CWJf22i13Y5fkHecnQbcB7QOA3t
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <F481FDCCEDB05A489209D2E82894E89F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48366f34-0789-4517-a347-08d670ef4cad
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 20:17:20.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2498
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua, Sai,

Couple of problems with these patches(see below).  Please check again.

> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Friday, December 21, 2018 6:21 PM
> To: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; H Peter Anvin <hpa@zytor.com>; Tony Luck
> <tony.luck@intel.com>; Peter Zijlstra <peterz@infradead.org>; Reinette
> Chatre <reinette.chatre@intel.com>; Moger, Babu
> <Babu.Moger@amd.com>; James Morse <james.morse@arm.com>;
> Xiaochen Shen <xiaochen.shen@intel.com>; Ravi V Shankar
> <ravi.v.shankar@intel.com>; Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com>; Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; Fenghua Yu
> <fenghua.yu@intel.com>
> Subject: [PATCH v4 08/10] selftests/resctrl Add Cache QoS Monitoring (CQM=
)
> selftest
>=20
> From: Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
>=20
> Cache QoS Monitoring (CQM) selftest starts stressful cache benchmark
> with specified size of memory to access the cache. Last Level cache
> occupancy reported by CQM should be close to the size of the memory.
>=20
> Signed-off-by: Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/Makefile      |   2 +-
>  tools/testing/selftests/resctrl/cache.c       | 102 ++++++++
>  tools/testing/selftests/resctrl/cqm_test.c    | 169 +++++++++++++
>  tools/testing/selftests/resctrl/fill_buf.c    | 107 ++++----
>  tools/testing/selftests/resctrl/mba_test.c    |   3 +-
>  tools/testing/selftests/resctrl/mbm_test.c    |   3 +-
>  tools/testing/selftests/resctrl/resctrl.h     |  30 ++-
>  .../testing/selftests/resctrl/resctrl_tests.c |  82 +++++--
>  tools/testing/selftests/resctrl/resctrl_val.c | 106 ++++----
>  tools/testing/selftests/resctrl/resctrlfs.c   | 231 ++++++++++++++++--
>  10 files changed, 691 insertions(+), 144 deletions(-)
>  create mode 100644 tools/testing/selftests/resctrl/cache.c
>  create mode 100644 tools/testing/selftests/resctrl/cqm_test.c
>=20
> diff --git a/tools/testing/selftests/resctrl/Makefile
> b/tools/testing/selftests/resctrl/Makefile
> index bf9f55e71d0c..664561cd76e6 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -8,7 +8,7 @@ all: resctrl_tests
>=20
>  resctrl_tests: *.o
>  	$(CC) $(CFLAGS) -o resctrl_tests resctrl_tests.o resctrlfs.o \
> -		 membw.o fill_buf.o mbm_test.o mba_test.o
> +		 resctrl_val.o fill_buf.o mbm_test.o mba_test.o cache.o
> cqm_test.o
>=20
>  .PHONY: clean
>=20
> diff --git a/tools/testing/selftests/resctrl/cache.c
> b/tools/testing/selftests/resctrl/cache.c
> new file mode 100644
> index 000000000000..1256590ef804
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/cache.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <stdint.h>
> +#include "resctrl.h"
> +
> +struct read_format {
> +	__u64 nr;			/* The number of events */
> +	struct {
> +		__u64 value;		/* The value of the event */
> +	} values[2];
> +};
> +
> +char cbm_mask[256];
> +unsigned long long_mask;
> +char llc_occup_path[1024];
> +
> +/*
> + * Get LLC Occupancy as reported by RESCTRL FS
> + * For CQM,
> + * 1. If con_mon grp and mon grp given, then read from mon grp in
> + * con_mon grp
> + * 2. If only con_mon grp given, then read from con_mon grp
> + * 3. If both not given, then read from root con_mon grp
> + * For CAT,
> + * 1. If con_mon grp given, then read from it
> + * 2. If con_mon grp not given, then read from root con_mon grp
> + *
> + * Return: =3D0 on success.  <0 on failure.
> + */
> +static int get_llc_occu_resctrl(unsigned long *llc_occupancy)
> +{
> +	FILE *fp;
> +
> +	fp =3D fopen(llc_occup_path, "r");
> +	if (!fp) {
> +		perror("Failed to open results file");
> +
> +		return errno;
> +	}
> +	if (fscanf(fp, "%lu", llc_occupancy) <=3D 0) {
> +		perror("Could not get llc occupancy");
> +		fclose(fp);
> +
> +		return -1;
> +	}
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +/*
> + * print_results_cache:	the cache results are stored in a file
> + * @filename:		file that stores the results
> + * @bm_pid:		child pid that runs benchmark
> + * @llc_value:		perf miss value /
> + *			llc occupancy value reported by resctrl FS
> + *
> + * Return:		0 on success. non-zero on failure.
> + */
> +static int print_results_cache(char *filename, int bm_pid,
> +			       unsigned long llc_value)
> +{
> +	FILE *fp;
> +
> +	if (strcmp(filename, "stdio") =3D=3D 0 || strcmp(filename, "stderr") =
=3D=3D 0)
> {
> +		printf("Pid: %d \t LLC_value: %lu\n", bm_pid,
> +		       llc_value);
> +	} else {
> +		fp =3D fopen(filename, "a");
> +		if (!fp) {
> +			perror("Cannot open results file");
> +
> +			return errno;
> +		}
> +		fprintf(fp, "Pid: %d \t llc_value: %lu\n", bm_pid,
> +			llc_value);
> +		fclose(fp);
> +	}
> +
> +	return 0;
> +}
> +
> +int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
> +{
> +	unsigned long llc_occu_resc =3D 0, llc_value =3D 0;
> +	int ret;
> +
> +	/*
> +	 * Measure llc occupancy from resctrl.
> +	 */
> +	if (!strcmp(param->resctrl_val, "cqm")) {
> +		ret =3D get_llc_occu_resctrl(&llc_occu_resc);
> +		if (ret < 0)
> +			return ret;
> +		llc_value =3D llc_occu_resc;
> +	}
> +	ret =3D print_results_cache(param->filename, bm_pid, llc_value);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/resctrl/cqm_test.c
> b/tools/testing/selftests/resctrl/cqm_test.c
> new file mode 100644
> index 000000000000..cddee364c88a
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/cqm_test.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cache Monitoring Technology (CQM) test
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Authors:
> + *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> + *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> + *    Fenghua Yu <fenghua.yu@intel.com>
> + */
> +#include "resctrl.h"
> +#include <unistd.h>
> +
> +#define RESULT_FILE_NAME	"result_cqm"
> +#define NUM_OF_RUNS		5
> +#define MAX_DIFF		2000000
> +#define MAX_DIFF_PERCENT	15
> +
> +int count_of_bits;
> +char cbm_mask[256];
> +unsigned long long_mask;
> +unsigned long cache_size;
> +
> +static int cqm_setup(int num, ...)
> +{
> +	struct resctrl_val_param *p;
> +	va_list param;
> +
> +	va_start(param, num);
> +	p =3D va_arg(param, struct resctrl_val_param *);
> +	va_end(param);
> +
> +	/* Run NUM_OF_RUNS times */
> +	if (p->num_of_runs >=3D NUM_OF_RUNS)
> +		return -1;
> +
> +	p->num_of_runs++;
> +
> +	return 0;
> +}
> +
> +static void show_cache_info(unsigned long sum_llc_occu_resc, int
> no_of_bits,
> +			    unsigned long span)
> +{
> +	unsigned long avg_llc_occu_resc =3D 0;
> +	long avg_diff =3D 0;
> +	float diff_percent;
> +
> +	avg_llc_occu_resc =3D sum_llc_occu_resc / (NUM_OF_RUNS - 1);
> +	avg_diff =3D (long long)abs(span - avg_llc_occu_resc);
> +
> +	printf("\nResults are displayed in (Bytes)\n");
> +	printf("\nNumber of bits: %d \t", no_of_bits);
> +	printf("Avg_llc_occu_resc: %lu \t", avg_llc_occu_resc);
> +	printf("llc_occu_exp (span): %lu \t", span);
> +
> +	diff_percent =3D (((float)span - avg_llc_occu_resc) / span) * 100;
> +
> +	printf("Diff: %ld \t", avg_diff);
> +	printf("Percent diff=3D%d\t", abs((int)diff_percent));
> +
> +	if ((abs((int)diff_percent) <=3D MAX_DIFF_PERCENT) ||
> +	    (abs(avg_diff) <=3D MAX_DIFF))
> +		printf("Passed\n");
> +	else
> +		printf("Failed\n");
> +}
> +
> +static int check_results(struct resctrl_val_param *param, int no_of_bits=
)
> +{
> +	char *token_array[8], temp[512];
> +	unsigned long sum_llc_occu_resc =3D 0;
> +	int runs =3D 0;
> +	FILE *fp;
> +
> +	printf("\nchecking for pass/fail\n");
> +	fp =3D fopen(param->filename, "r");
> +	if (!fp) {
> +		perror("Error in opening file\n");
> +
> +		return errno;
> +	}
> +
> +	while (fgets(temp, 1024, fp)) {
> +		char *token =3D strtok(temp, ":\t");
> +		int fields =3D 0;
> +
> +		while (token) {
> +			token_array[fields++] =3D token;
> +			token =3D strtok(NULL, ":\t");
> +		}
> +
> +		/* Field 3 is llc occ resc value */
> +		if (runs > 0)
> +			sum_llc_occu_resc +=3D atol(token_array[3]);
> +		runs++;
> +	}
> +	fclose(fp);
> +	show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
> +
> +	return 0;
> +}
> +
> +void cqm_test_cleanup(void)
> +{
> +	remove(RESULT_FILE_NAME);
> +}
> +
> +int cqm_resctrl_val(int core_id, int n, char **benchmark_cmd)
> +{
> +	int ret, mum_resctrlfs;
> +
> +	cache_size =3D 0;
> +	mum_resctrlfs =3D 1;
> +
> +	ret =3D remount_resctrlfs(mum_resctrlfs);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D get_cbm_mask("L3");
> +	if (ret)
> +		return ret;
> +
> +	long_mask =3D strtoul(cbm_mask, NULL, 16);
> +
> +	ret =3D get_cache_size(core_id, 3, &cache_size);
> +	if (ret)
> +		return ret;
> +	printf("cache size :%lu\n", cache_size);
> +
> +	count_of_bits =3D count_bits(long_mask);
> +
> +	if (n < 1 || n > count_of_bits) {
> +		printf("Invalid input value for numbr_of_bits n!\n");
> +		printf("Please Enter value in range 1 to %d\n",
> count_of_bits);
> +		return -1;
> +	}
> +
> +	struct resctrl_val_param param =3D {
> +		.resctrl_val	=3D "cqm",
> +		.ctrlgrp	=3D "c1",
> +		.mongrp		=3D "m1",
> +		.cpu_no		=3D core_id,
> +		.mum_resctrlfs	=3D 0,
> +		.filename	=3D RESULT_FILE_NAME,
> +		.mask		=3D ~(long_mask << n) & long_mask,
> +		.span		=3D cache_size * n / count_of_bits,
> +		.num_of_runs	=3D 0,
> +		.setup		=3D cqm_setup,
> +	};
> +
> +	if (strcmp(benchmark_cmd[0], "fill_buf") =3D=3D 0)
> +		sprintf(benchmark_cmd[1], "%llu", param.span);
> +
> +	remove(RESULT_FILE_NAME);
> +
> +	ret =3D resctrl_val(benchmark_cmd, &param);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D check_results(&param, n);
> +	if (ret)
> +		return ret;
> +
> +	cqm_test_cleanup();
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c
> b/tools/testing/selftests/resctrl/fill_buf.c
> index d9950b5d068d..7c3579a3ef06 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -78,54 +78,63 @@ static void *malloc_and_init_memory(size_t s)
>  	return p;
>  }
>=20
> -static void fill_cache_read(unsigned char *start_ptr, unsigned char
> *end_ptr)
> +static void fill_one_span_read(unsigned char *start_ptr, unsigned char
> *end_ptr)
>  {
> -	while (1) {
> -		unsigned char sum, *p;
> -
> -		p =3D start_ptr;
> -		/* Read two chars in each cache line to stress cache */
> -		while (p < (end_ptr - 1024)) {
> -			sum +=3D p[0] + p[32] + p[64] + p[96] + p[128] +
> -			       p[160] + p[192] + p[224] + p[256] + p[288] +
> -			       p[320] + p[352] + p[384] + p[416] + p[448] +
> -			       p[480] + p[512] + p[544] + p[576] + p[608] +
> -			       p[640] + p[672] + p[704] + p[736] + p[768] +
> -			       p[800] + p[832] + p[864] + p[896] + p[928] +
> -			       p[960] + p[992];
> -			p +=3D 1024;
> -		}
> +	unsigned char sum, *p;
> +
> +	sum =3D 0;
> +	p =3D start_ptr;
> +	while (p < end_ptr) {
> +		sum +=3D *p;
> +		p +=3D (CL_SIZE / 2);
>  	}
>  }
>=20
> -static void fill_cache_write(unsigned char *start_ptr, unsigned char
> *end_ptr)
> +static
> +void fill_one_span_write(unsigned char *start_ptr, unsigned char
> *end_ptr)
>  {
> -	while (1) {
> -		while (start_ptr < end_ptr) {
> -			*start_ptr =3D '1';
> -			start_ptr +=3D (CL_SIZE / 2);
> -		}
> -		start_ptr =3D startptr;
> +	unsigned char *p;
> +
> +	p =3D start_ptr;
> +	while (p < end_ptr) {
> +		*p =3D '1';
> +		p +=3D (CL_SIZE / 2);
>  	}
>  }
>=20
> -static void
> -fill_cache(unsigned long long buf_size, int malloc_and_init,
> -	   int memflush, int op)
> +static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_=
ptr,
> +			   char *resctrl_val)
> +{
> +	while (1)
> +		fill_one_span_read(start_ptr, end_ptr);
> +
> +	return 0;
> +}
> +
> +static int fill_cache_write(unsigned char *start_ptr, unsigned char
> *end_ptr,
> +			    char *resctrl_val)
> +{
> +	while (1)
> +		fill_one_span_write(start_ptr, end_ptr);
> +
> +	return 0;
> +}
> +
> +static int
> +fill_cache(unsigned long long buf_size, int malloc_and_init, int memflus=
h,
> +	   int op, char *resctrl_val)
>  {
>  	unsigned char *start_ptr, *end_ptr;
>  	unsigned long long i;
> +	int ret;
>=20
> -	if (malloc_and_init) {
> +	if (malloc_and_init)
>  		start_ptr =3D malloc_and_init_memory(buf_size);
> -		printf("Started benchmark with memalign\n");
> -	} else {
> +	else
>  		start_ptr =3D malloc(buf_size);
> -		printf("Started benchmark with malloc\n");
> -	}
>=20
>  	if (!start_ptr)
> -		return;
> +		return -1;
>=20
>  	startptr =3D start_ptr;
>  	end_ptr =3D start_ptr + buf_size;
> @@ -142,24 +151,29 @@ fill_cache(unsigned long long buf_size, int
> malloc_and_init,
>  	start_ptr =3D startptr;
>=20
>  	/* Flush the memory before using to avoid "cache hot pages" effect
> */
> -	if (memflush) {
> +	if (memflush)
>  		mem_flush(start_ptr, buf_size);
> -		printf("Started benchmark with memflush\n");
> -	} else {
> -		printf("Started benchmark *without* memflush\n");
> -	}
>=20
>  	if (op =3D=3D 0)
> -		fill_cache_read(start_ptr, end_ptr);
> +		ret =3D fill_cache_read(start_ptr, end_ptr, resctrl_val);
>  	else
> -		fill_cache_write(start_ptr, end_ptr);
> +		ret =3D fill_cache_write(start_ptr, end_ptr, resctrl_val);
> +
> +	if (ret) {
> +		printf("\n Errror in fill cache read/write...\n");
> +		return -1;
> +	}
>=20
>  	free(startptr);
> +
> +	return 0;
>  }
>=20
> -int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int=
 op)
> +int run_fill_buf(unsigned long long span, int malloc_and_init_memory,
> +		 int memflush, int op, char *resctrl_val)
>  {
> -	unsigned long long cache_size =3D span * MB;
> +	unsigned long long cache_size =3D span;
> +	int ret;
>=20
>  	/* set up ctrl-c handler */
>  	if (signal(SIGINT, ctrl_handler) =3D=3D SIG_ERR)
> @@ -167,9 +181,12 @@ int run_fill_buf(int span, int
> malloc_and_init_memory, int memflush, int op)
>  	if (signal(SIGHUP, ctrl_handler) =3D=3D SIG_ERR)
>  		printf("Failed to catch SIGHUP!\n");
>=20
> -	printf("Cache size in Bytes =3D %llu\n", cache_size);
> -
> -	fill_cache(cache_size, malloc_and_init_memory, memflush, op);
> +	ret =3D fill_cache(cache_size, malloc_and_init_memory, memflush, op,
> +			 resctrl_val);
> +	if (ret) {
> +		printf("\n Errror in fill cache\n");
> +		return -1;
> +	}
>=20
> -	return -1;
> +	return 0;
>  }
> diff --git a/tools/testing/selftests/resctrl/mba_test.c
> b/tools/testing/selftests/resctrl/mba_test.c
> index 7a5d869e5382..66be852d737f 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -57,6 +57,7 @@ static void show_mba_info(unsigned long *bw_imc,
> unsigned long *bw_resc)
>  {
>  	int allocation, failed =3D 0, runs;
>=20
> +	printf("\nResults are displayed in (MB)\n");
>  	/* Memory bandwidth from 100% down to 10% */
>  	for (allocation =3D 0; allocation < ALLOCATION_MAX /
> ALLOCATION_STEP;
>  	     allocation++) {
> @@ -159,7 +160,7 @@ int mba_schemata_change(int core_id, char
> *bw_report, char **benchmark_cmd)
>=20
>  	remove(RESULT_FILE_NAME);
>=20
> -	ret =3D membw_val(benchmark_cmd, &param);
> +	ret =3D resctrl_val(benchmark_cmd, &param);
>  	if (ret)
>  		return ret;
>=20
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c
> b/tools/testing/selftests/resctrl/mbm_test.c
> index fc1b8bab1c71..ce3eab15328e 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -36,6 +36,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long
> *bw_resc, int span)
>  	avg_bw_resc =3D sum_bw_resc / 4;
>  	avg_diff =3D avg_bw_resc - avg_bw_imc;
>=20
> +	printf("\nResults are displayed in (MB)\n");
>  	printf("\nSpan (MB): %d \t", span);
>  	printf("avg_bw_imc: %lu\t", avg_bw_imc);
>  	printf("avg_bw_resc: %lu\t", avg_bw_resc);
> @@ -131,7 +132,7 @@ int mbm_bw_change(int span, int core_id, char
> *bw_report, char **benchmark_cmd)
>=20
>  	remove(RESULT_FILE_NAME);
>=20
> -	ret =3D membw_val(benchmark_cmd, &param);
> +	ret =3D resctrl_val(benchmark_cmd, &param);
>  	if (ret)
>  		return ret;
>=20
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index fce01c827d81..b847ec972e77 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -16,11 +16,18 @@
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/types.h>
> +#include <sys/select.h>
>  #include <asm/unistd.h>
>  #include <linux/perf_event.h>
> +#include <sys/time.h>
> +#include <math.h>
> +#include <sys/wait.h>
> +#include <sys/eventfd.h>
>=20
> +#define MB			(1024 * 1024)
>  #define RESCTRL_PATH		"/sys/fs/resctrl"
>  #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
> +#define CBM_MASK_PATH		"/sys/fs/resctrl/info"
>=20
>  #define PARENT_EXIT(err_msg)			\
>  	do {					\
> @@ -46,18 +53,24 @@ struct resctrl_val_param {
>  	char	ctrlgrp[64];
>  	char	mongrp[64];
>  	int	cpu_no;
> -	int	span;
> +	unsigned long long span;
>  	int	mum_resctrlfs;
>  	char	filename[64];
>  	char	*bw_report;
> +	unsigned long mask;
> +	int	num_of_runs;
>  	int	(*setup)(int num, ...);
> +
>  };
>=20
>  pid_t bm_pid, ppid;
> +extern char cbm_mask[256];
> +extern unsigned long long_mask;
> +extern char llc_occup_path[1024];
>=20
>  int remount_resctrlfs(bool mum_resctrlfs);
>  int umount_resctrlfs(void);
> -char get_sock_num(int cpu_no);
> +int get_sock_num(int cpu_no, char *sock_num);
>  int validate_bw_report_request(char *bw_report);
>  int validate_resctrl_feature_request(char *resctrl_val);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no);
> @@ -68,12 +81,21 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char
> *ctrlgrp, char *mongrp,
>  			    char *resctrl_val);
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu=
,
>  		    int group_fd, unsigned long flags);
> -int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int
> op);
> -int membw_val(char **benchmark_cmd, struct resctrl_val_param *param);
> +int run_fill_buf(unsigned long long span, int malloc_and_init_memory,
> +		 int memflush, int op, char *resctrl_val);
> +int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
>  int mbm_bw_change(int span, int core_id, char *bw_report, char
> **benchmark_cmd);
>  void tests_cleanup(void);
>  void mbm_test_cleanup(void);
>  int mba_schemata_change(int core_id, char *bw_report, char
> **benchmark_cmd);
>  void mba_test_cleanup(void);
> +int get_cbm_mask(char *cache_type);
> +int get_cache_size(int cpu_no, int cache_num, unsigned long *cache_size)=
;
> +void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
> +int cqm_resctrl_val(int core_id, int n, char **benchmark_cmd);
> +unsigned int count_bits(unsigned long n);
> +void cqm_test_cleanup(void);
> +int get_core_sibling(int cpu_no);
> +int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
>=20
>  #endif /* RESCTRL_H */
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c
> b/tools/testing/selftests/resctrl/resctrl_tests.c
> index e4d00fb63769..035929f18696 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -14,15 +14,14 @@
>  #define BENCHMARK_ARGS		64
>  #define BENCHMARK_ARG_SIZE	64
>=20
> -int ben_count;
> -
>  static void cmd_help(void)
>  {
> -	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-
> t test list]\n");
> -	printf("\t-b benchmark_cmd [options]: run specified benchmark\n");
> +	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-
> t test list] [-n no_of_bits]\n");
> +	printf("\t-b benchmark_cmd [options]: run specified benchmark for
> MBM, MBA and CQM");
>  	printf("\t default benchmark is builtin fill_buf\n");
>  	printf("\t-t test list: run tests specified in the test list, ");
> -	printf("e.g. -t mbm,mba\n");
> +	printf("e.g. -t mbm, mba, cqm\n");
> +	printf("\t-n no_of_bits: run cache tests using specified no of bits in
> cache bit mask\n");
>  	printf("\t-h: help\n");
>  }
>=20
> @@ -30,17 +29,30 @@ void tests_cleanup(void)
>  {
>  	mbm_test_cleanup();
>  	mba_test_cleanup();
> +	cqm_test_cleanup();
>  }
>=20
>  int main(int argc, char **argv)
>  {
>  	char
> benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
> -	int res, c, core_id =3D 0, span =3D 250, argc_new =3D argc, i;
> +	int res, c, core_id =3D 1, span =3D 250, argc_new =3D argc, i, no_of_bi=
ts =3D 5;
> +	int ben_count, ben_ind;
>  	bool has_ben =3D false, mbm_test =3D true, mba_test =3D true;
> +	bool cqm_test =3D true;
>  	char *benchmark_cmd[BENCHMARK_ARGS];
>  	char bw_report[64], bm_type[64];
>=20
> -	while ((c =3D getopt(argc_new, argv, "ht:b:")) !=3D -1) {
> +	for (int i =3D 0; i < argc; i++) {

This declaration here is causing following errors.

resctrl_tests.c: In function =91main=92:
resctrl_tests.c:46:11: error: redeclaration of =91i=92 with no linkage
  for (int i =3D 0; i < argc; i++) {
           ^
resctrl_tests.c:39:56: note: previous declaration of =91i=92 was here
  int res, c, core_id =3D 1, span =3D 250, argc_new =3D argc, i, no_of_bits=
 =3D 5;
                                                        ^
resctrl_tests.c:46:2: error: =91for=92 loop initial declarations are only
allowed in C99 mode
  for (int i =3D 0; i < argc; i++) {
  ^
resctrl_tests.c:46:2: note: use option -std=3Dc99 or -std=3Dgnu99 to compil=
e
your code


> +		if (strcmp(argv[i], "-b") =3D=3D 0) {
> +			ben_ind =3D i + 1;
> +			ben_count =3D argc - ben_ind;
> +			argc_new =3D ben_ind - 1;
> +			has_ben =3D 1;
> +			break;
> +		}
> +	}
> +
> +	while ((c =3D getopt(argc_new, argv, "ht:n:p:")) !=3D -1) {
>  		char *token;
>=20
>  		switch (c) {
> @@ -49,11 +61,14 @@ int main(int argc, char **argv)
>=20
>  			mbm_test =3D false;
>  			mba_test =3D false;
> +			cqm_test =3D false;
>  			while (token) {
>  				if (!strcmp(token, "mbm")) {
>  					mbm_test =3D true;
>  				} else if (!strcmp(token, "mba")) {
>  					mba_test =3D true;
> +				} else if (!strcmp(token, "cqm")) {
> +					cqm_test =3D true;
>  				} else {
>  					printf("invalid argument\n");
>=20
> @@ -62,22 +77,11 @@ int main(int argc, char **argv)
>  				token =3D strtok(NULL, ":\t");
>  			}
>  			break;
> -		case 'b':
> -			/* Extract benchmark command from command line.
> */
> -			token =3D strtok(optarg, " ");
> -			i =3D 0;
> -			while (token) {
> -				benchmark_cmd[i] =3D
> benchmark_cmd_area[i];
> -				strcpy(benchmark_cmd[i++], token);
> -				if (i >=3D BENCHMARK_ARGS) {
> -					printf("Too many benchmark
> args\n");
> -
> -					return -1;
> -				}
> -				token =3D strtok(NULL, " ");
> -			}
> -			benchmark_cmd[i] =3D NULL;
> -			has_ben =3D true;
> +		case 'n':
> +			no_of_bits =3D atoi(optarg);
> +			break;
> +		case 'p':
> +			core_id =3D atoi(optarg);
>  			break;
>  		case 'h':
>  			cmd_help();
> @@ -101,16 +105,26 @@ int main(int argc, char **argv)
>  		return errno;
>  	}
>=20
> -	if (!has_ben) {
> +	if (has_ben) {
> +		/* Extract benchmark command from command line. */
> +		for (int i =3D ben_ind; i < argc; i++) {

resctrl_tests.c:114:3: error: =91for=92 loop initial declarations are only
allowed in C99 mode
   for (int i =3D ben_ind; i < argc; i++) {
   ^
make: *** [*.o] Error 1


> +			benchmark_cmd[i - ben_ind] =3D
> benchmark_cmd_area[i];
> +			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
> +		}
> +		benchmark_cmd[ben_count] =3D
> benchmark_cmd_area[ben_count];
> +		sprintf(benchmark_cmd[ben_count], "%s", "NULL");
> +	} else {
>  		/* If no benchmark is given by "-b" argument, use fill_buf. */
> -		for (i =3D 0; i < 5; i++)
> +		for (i =3D 0; i < 6; i++)
>  			benchmark_cmd[i] =3D benchmark_cmd_area[i];
> +
>  		strcpy(benchmark_cmd[0], "fill_buf");
>  		sprintf(benchmark_cmd[1], "%d", span);
>  		strcpy(benchmark_cmd[2], "1");
>  		strcpy(benchmark_cmd[3], "1");
>  		strcpy(benchmark_cmd[4], "0");
> -		benchmark_cmd[5] =3D NULL;
> +		strcpy(benchmark_cmd[5], "");
> +		benchmark_cmd[6] =3D NULL;
>  	}
>=20
>  	sprintf(bw_report, "reads");
> @@ -118,18 +132,32 @@ int main(int argc, char **argv)
>=20
>  	if (mbm_test) {
>  		printf("\nMBM BW Change Starting..\n");
> +		if (!has_ben)
> +			sprintf(benchmark_cmd[5], "%s", "mbm");
>  		res =3D mbm_bw_change(span, core_id, bw_report,
> benchmark_cmd);
>  		if (res)
>  			printf("Error in running tests for mbm bw
> change!\n");
> +		mbm_test_cleanup();
>  	}
>=20
>  	if (mba_test) {
>  		printf("\nMBA Schemata Change Starting..\n");
>  		if (!has_ben)
> -			sprintf(benchmark_cmd[1], "%d", span);
> +			sprintf(benchmark_cmd[5], "%s", "mba");
>  		res =3D mba_schemata_change(core_id, bw_report,
> benchmark_cmd);
>  		if (res)
>  			printf("Error in tests for mba-change-schemata!\n");
> +		mba_test_cleanup();
> +	}
> +
> +	if (cqm_test) {
> +		printf("\nCQM Test Starting..\n");
> +		if (!has_ben)
> +			sprintf(benchmark_cmd[5], "%s", "cqm");
> +		res =3D cqm_resctrl_val(core_id, no_of_bits, benchmark_cmd);
> +		if (res)
> +			printf("Error in CQM test!\n");
> +		cqm_test_cleanup();
>  	}
>=20
>  	return 0;
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c
> b/tools/testing/selftests/resctrl/resctrl_val.c
> index fa77af5a5b57..eb7d5f0620e2 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -11,7 +11,6 @@
>   */
>  #include "resctrl.h"
>=20
> -#define MB			(1024 * 1024)
>  #define UNCORE_IMC		"uncore_imc"
>  #define READ_FILE_NAME		"events/cas_count_read"
>  #define WRITE_FILE_NAME		"events/cas_count_write"
> @@ -33,6 +32,18 @@
>  #define MBM_LOCAL_BYTES_PATH			\
>  	"%s/mon_data/mon_L3_0%c/mbm_local_bytes"
>=20
> +#define CON_MON_LCC_OCCUP_PATH		\
> +	"%s/%s/mon_groups/%s/mon_data/mon_L3_0%c/llc_occupancy"
> +
> +#define CON_LCC_OCCUP_PATH		\
> +	"%s/%s/mon_data/mon_L3_0%c/llc_occupancy"
> +
> +#define MON_LCC_OCCUP_PATH		\
> +	"%s/mon_groups/%s/mon_data/mon_L3_0%c/llc_occupancy"
> +
> +#define LCC_OCCUP_PATH			\
> +	"%s/mon_data/mon_L3_0%c/llc_occupancy"
> +
>  struct membw_read_format {
>  	__u64 value;         /* The value of the event */
>  	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED
> */
> @@ -207,12 +218,12 @@ static int read_from_imc_dir(char *imc_dir, int
> count)
>   * A config again has two parts, event and umask.
>   * Enumerate all these details into an array of structures.
>   *
> - * Return: >=3D 0 on success. < 0 on failure.
> + * Return: > 0 on success. <=3D 0 on failure.
>   */
>  static int num_of_imcs(void)
>  {
>  	unsigned int count =3D 0;
> -	char imc_dir[1024];
> +	char imc_dir[512];
>  	struct dirent *ep;
>  	int ret;
>  	DIR *dp;
> @@ -381,9 +392,10 @@ static void initialize_mem_bw_resctrl(const char
> *ctrlgrp, const char *mongrp,
>  				      int cpu_no, char *resctrl_val)
>  {
>  	char sock_num;
> +	int ret;
>=20
> -	sock_num =3D get_sock_num(cpu_no);
> -	if (sock_num < 0)
> +	ret =3D get_sock_num(cpu_no, &sock_num);
> +	if (ret < 0)
>  		return;
>=20
>  	if (strcmp(resctrl_val, "mbm") =3D=3D 0)
> @@ -433,16 +445,6 @@ static unsigned long get_mem_bw_resctrl(void)
>=20
>  pid_t bm_pid, ppid;
>=20
> -static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
> -{
> -	kill(bm_pid, SIGKILL);
> -	umount_resctrlfs();
> -	tests_cleanup();
> -	printf("Ending\n\n");
> -
> -	exit(EXIT_SUCCESS);
> -}
> -
>  /*
>   * print_results_bw:	the memory bandwidth results are stored in a file
>   * @filename:		file that stores the results
> @@ -481,6 +483,42 @@ static int print_results_bw(char *filename,  int
> bm_pid, float bw_imc,
>  	return 0;
>  }
>=20
> +static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char
> sock_num)
> +{
> +	if (strlen(ctrlgrp) && strlen(mongrp))
> +		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,
> 	RESCTRL_PATH,
> +			ctrlgrp, mongrp, sock_num);
> +	else if (!strlen(ctrlgrp) && strlen(mongrp))
> +		sprintf(llc_occup_path,	MON_LCC_OCCUP_PATH,
> RESCTRL_PATH,
> +			mongrp, sock_num);
> +	else if (strlen(ctrlgrp) && !strlen(mongrp))
> +		sprintf(llc_occup_path,	CON_LCC_OCCUP_PATH,
> RESCTRL_PATH,
> +			ctrlgrp, sock_num);
> +	else if (!strlen(ctrlgrp) && !strlen(mongrp))
> +		sprintf(llc_occup_path, LCC_OCCUP_PATH,
> 	RESCTRL_PATH, sock_num);
> +}
> +
> +/*
> + * initialize_llc_occu_resctrl:	Appropriately populate "llc_occup_path"
> + * @ctrlgrp:			Name of the control monitor group
> (con_mon grp)
> + * @mongrp:			Name of the monitor group (mon grp)
> + * @cpu_no:			CPU number that the benchmark PID is
> binded to
> + * @resctrl_val:		Resctrl feature (Eg: cat, cqm.. etc)
> + */
> +static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char
> *mongrp,
> +					int cpu_no, char *resctrl_val)
> +{
> +	char sock_num;
> +	int ret;
> +
> +	ret =3D get_sock_num(cpu_no, &sock_num);
> +	if (ret < 0)
> +		return;
> +
> +	if (strcmp(resctrl_val, "cqm") =3D=3D 0)
> +		set_cqm_path(ctrlgrp, mongrp, sock_num);
> +}
> +
>  static int
>  measure_vals(struct resctrl_val_param *param, unsigned long
> *bw_resc_start)
>  {
> @@ -513,28 +551,24 @@ measure_vals(struct resctrl_val_param *param,
> unsigned long *bw_resc_start)
>  }
>=20
>  /*
> - * membw_val:		execute benchmark and measure memory
> bandwidth on
> + * resctrl_val:		execute benchmark and measure memory
> bandwidth on
>   *			the benchmark
>   * @benchmark_cmd:	benchmark command and its arguments
> - * @param:		parameters passed to membw_val()
> + * @param:		parameters passed to resctrl_val()
>   *
>   * Return:		0 on success. non-zero on failure.
>   */
> -int membw_val(char **benchmark_cmd, struct resctrl_val_param *param)
> +int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
>  {
>  	int ret =3D 0, pipefd[2], pipe_message =3D 0;
>  	char *resctrl_val =3D param->resctrl_val;
>  	unsigned long bw_resc_start =3D 0;
>  	struct sigaction sigact;
>  	union sigval value;
> -	FILE *fp;
>=20
>  	if (strcmp(param->filename, "") =3D=3D 0)
>  		sprintf(param->filename, "stdio");
>=20
> -	if (strcmp(param->bw_report, "") =3D=3D 0)
> -		param->bw_report =3D "total";
> -
>  	ret =3D validate_resctrl_feature_request(resctrl_val);
>  	if (ret)
>  		return ret;
> @@ -556,21 +590,6 @@ int membw_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>  	 */
>  	ppid =3D getpid();
>=20
> -	/* File based synchronization between parent and child */
> -	fp =3D fopen("sig", "w");
> -	if (!fp) {
> -		perror("Failed to open sig file");
> -
> -		return -1;
> -	}
> -	if (fprintf(fp, "%d\n", 0) <=3D 0) {
> -		perror("Unable to establish sync bw parent & child");
> -		fclose(fp);
> -
> -		return -1;
> -	}
> -	fclose(fp);
> -
>  	if (pipe(pipefd)) {
>  		perror("Unable to create pipe");
>=20
> @@ -652,7 +671,9 @@ int membw_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>=20
>  		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
>  					  param->cpu_no, resctrl_val);
> -	}
> +	} else if (strcmp(resctrl_val, "cqm") =3D=3D 0)
> +		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
> +					    param->cpu_no, resctrl_val);
>=20
>  	/* Parent waits for child to be ready. */
>  	close(pipefd[1]);
> @@ -672,7 +693,8 @@ int membw_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>=20
>  	/* Test runs until the callback setup() tells the test to stop. */
>  	while (1) {
> -		if (strcmp(resctrl_val, "mbm") =3D=3D 0) {
> +		if ((strcmp(resctrl_val, "mbm") =3D=3D 0) ||
> +		    (strcmp(resctrl_val, "mba") =3D=3D 0)) {
>  			ret =3D param->setup(1, param);
>  			if (ret) {
>  				ret =3D 0;
> @@ -682,14 +704,14 @@ int membw_val(char **benchmark_cmd, struct
> resctrl_val_param *param)
>  			ret =3D measure_vals(param, &bw_resc_start);
>  			if (ret)
>  				break;
> -		} else if ((strcmp(resctrl_val, "mba") =3D=3D 0)) {
> +		} else if (strcmp(resctrl_val, "cqm") =3D=3D 0) {
>  			ret =3D param->setup(1, param);
>  			if (ret) {
>  				ret =3D 0;
>  				break;
>  			}
> -
> -			ret =3D measure_vals(param, &bw_resc_start);
> +			sleep(1);
> +			ret =3D measure_cache_vals(param, bm_pid);
>  			if (ret)
>  				break;
>  		} else {
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> index 9d9962947c9c..9fc27ae68582 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -13,7 +13,11 @@
>=20
>  #define RESCTRL_MBM		"L3 monitoring detected"
>  #define RESCTRL_MBA		"MB allocation detected"
> -#define MAX_RESCTRL_FEATURES	2
> +#define RESCTRL_CQM		"L3 monitoring detected"
> +#define MAX_RESCTRL_FEATURES	4
> +#define CORE_SIBLINGS_PATH	"/sys/bus/cpu/devices/cpu"
> +
> +char cbm_mask[256];
>=20
>  /*
>   * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
> @@ -58,7 +62,7 @@ int remount_resctrlfs(bool mum_resctrlfs)
>=20
>  				return errno;
>  			}
> -			printf("Remount: done!\n");
> +			printf("umount: done!\n");
>  		} else {
>  			printf("Mounted already. Not remounting!\n");
>=20
> @@ -89,12 +93,13 @@ int umount_resctrlfs(void)
>  /*
>   * get_sock_num - Get socket number for a specified CPU
>   * @cpu_no:	CPU number
> + * @sock_num:	pointer to socket_number
>   *
>   * Return: >=3D 0 on success, < 0 on failure.
>   */
> -char get_sock_num(int cpu_no)
> +int get_sock_num(int cpu_no, char *sock_num)
>  {
> -	char sock_num, phys_pkg_path[1024];
> +	char phys_pkg_path[1024];
>  	FILE *fp;
>=20
>  	sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
> @@ -105,7 +110,7 @@ char get_sock_num(int cpu_no)
>=20
>  		return -1;
>  	}
> -	if (fscanf(fp, "%c", &sock_num) <=3D 0) {
> +	if (fscanf(fp, "%c", sock_num) <=3D 0) {
>  		perror("Could not get socket number");
>  		fclose(fp);
>=20
> @@ -113,7 +118,135 @@ char get_sock_num(int cpu_no)
>  	}
>  	fclose(fp);
>=20
> -	return sock_num;
> +	return 0;
> +}
> +
> +/*
> + * get_cache_size - Get cache size for a specified CPU
> + * @cpu_no:	CPU number
> + * @cache_num:	Cache level 2 for L2, 3 for L3
> + * @cache_size:	pointer to cache_size
> + *
> + * Return: =3D 0 on success, < 0 on failure.
> + */
> +int get_cache_size(int cpu_no, int cache_num, unsigned long *cache_size)
> +{
> +	char cache_path[1024], cache_str[64];
> +	FILE *fp;
> +	int length, i;
> +
> +	sprintf(cache_path,
> "/sys/bus/cpu/devices/cpu%d/cache/index%d/size",
> +		cpu_no, cache_num);
> +	fp =3D fopen(cache_path, "r");
> +	if (!fp) {
> +		perror("Failed to open cache size");
> +
> +		return -1;
> +	}
> +	if (fscanf(fp, "%s", cache_str) <=3D 0) {
> +		perror("Could not get cache_size");
> +		fclose(fp);
> +
> +		return -1;
> +	}
> +	fclose(fp);
> +
> +	length =3D (int)strlen(cache_str);
> +
> +	*cache_size =3D 0;
> +
> +	for (i =3D 0; i < length; i++) {
> +		if ((cache_str[i] >=3D '0') && (cache_str[i] <=3D '9'))
> +
> +			*cache_size =3D *cache_size * 10 + (cache_str[i] - '0');
> +
> +		else if (cache_str[i] =3D=3D 'K')
> +
> +			*cache_size =3D *cache_size * 1024;
> +
> +		else if (cache_str[i] =3D=3D 'M')
> +
> +			*cache_size =3D *cache_size * 1024 * 1024;
> +
> +		else
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * get_cbm_mask - Get cbm mask for given cache
> + * @cache_type:	Cache level L2/L3
> + *
> + * Mask is stored in cbm_mask which is global variable.
> + *
> + * Return: =3D 0 on success, < 0 on failure.
> + */
> +int get_cbm_mask(char *cache_type)
> +{
> +	char cbm_mask_path[1024];
> +	FILE *fp;
> +
> +	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH,
> cache_type);
> +
> +	fp =3D fopen(cbm_mask_path, "r");
> +	if (!fp) {
> +		perror("Failed to open cache level");
> +
> +		return -1;
> +	}
> +	if (fscanf(fp, "%s", cbm_mask) <=3D 0) {
> +		perror("Could not get max cbm_mask");
> +		fclose(fp);
> +
> +		return -1;
> +	}
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +/*
> + * get_core_sibling - Get sibling core id from the same socket for given=
 CPU
> + * @cpu_no:	CPU number
> + *
> + * Return:	> 0 on success, < 0 on failure.
> + */
> +int get_core_sibling(int cpu_no)
> +{
> +	char core_siblings_path[1024], cpu_list_str[64];
> +	int sibling_core_id =3D -1;
> +	FILE *fp;
> +
> +	sprintf(core_siblings_path, "%s%d/topology/core_siblings_list",
> +		CORE_SIBLINGS_PATH, cpu_no);
> +
> +	fp =3D fopen(core_siblings_path, "r");
> +	if (!fp) {
> +		perror("Failed to open core siblings path");
> +
> +		return -1;
> +	}
> +	if (fscanf(fp, "%s", cpu_list_str) <=3D 0) {
> +		perror("Could not get core_siblings list");
> +		fclose(fp);
> +
> +		return -1;
> +	}
> +	fclose(fp);
> +
> +	char *token =3D strtok(cpu_list_str, "-,");
> +
> +	while (token) {
> +		sibling_core_id =3D atoi(token);
> +		/* Skipping core 0 as we don't want to run test on core 0 */
> +		if (sibling_core_id !=3D 0)
> +			break;
> +		token =3D strtok(NULL, "-,");
> +	}
> +
> +	return sibling_core_id;
>  }
>=20
>  /*
> @@ -152,8 +285,10 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
>   */
>  void run_benchmark(int signum, siginfo_t *info, void *ucontext)
>  {
> -	int span, operation, ret;
> +	unsigned long long buffer_span;
> +	int span, operation, ret, malloc_and_init_memory, memflush;
>  	char **benchmark_cmd;
> +	char resctrl_val[64];
>  	FILE *fp;
>=20
>  	benchmark_cmd =3D info->si_ptr;
> @@ -169,8 +304,18 @@ void run_benchmark(int signum, siginfo_t *info,
> void *ucontext)
>  	if (strcmp(benchmark_cmd[0], "fill_buf") =3D=3D 0) {
>  		/* Execute default fill_buf benchmark */
>  		span =3D atoi(benchmark_cmd[1]);
> +		malloc_and_init_memory =3D atoi(benchmark_cmd[2]);
> +		memflush =3D  atoi(benchmark_cmd[3]);
>  		operation =3D atoi(benchmark_cmd[4]);
> -		if (run_fill_buf(span, 1, 1, operation))
> +		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
> +
> +		if (strcmp(resctrl_val, "cqm") !=3D 0)
> +			buffer_span =3D span * MB;
> +		else
> +			buffer_span =3D span;
> +
> +		if (run_fill_buf(buffer_span, malloc_and_init_memory,
> memflush,
> +				 operation, resctrl_val))
>  			fprintf(stderr, "Error in running fill buffer\n");
>  	} else {
>  		/* Execute specified benchmark */
> @@ -197,6 +342,14 @@ static int create_grp(const char *grp_name, char
> *grp, const char *parent_grp)
>  	struct dirent *ep;
>  	DIR *dp;
>=20
> +	/*
> +	 * At this point, we are guaranteed to have resctrl FS mounted and if
> +	 * length of grp_name =3D=3D 0, it means, user wants to use root
> con_mon
> +	 * grp, so do nothing
> +	 */
> +	if (strlen(grp_name) =3D=3D 0)
> +		return 0;
> +
>  	/* Check if requested grp exists or not */
>  	dp =3D opendir(parent_grp);
>  	if (dp) {
> @@ -238,7 +391,6 @@ static int write_pid_to_tasks(char *tasks, pid_t pid)
>  		fclose(fp);
>=20
>  		return -1;
> -
>  	}
>  	fclose(fp);
>=20
> @@ -263,11 +415,11 @@ static int write_pid_to_tasks(char *tasks, pid_t pi=
d)
>  int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>  			    char *resctrl_val)
>  {
> -	char controlgroup[256], monitorgroup[256], monitorgroup_p[256];
> -	char tasks[256];
> +	char controlgroup[128], monitorgroup[512], monitorgroup_p[256];
> +	char tasks[1024];
>  	int ret;
>=20
> -	if (ctrlgrp)
> +	if (strlen(ctrlgrp))
>  		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
>  	else
>  		sprintf(controlgroup, "%s", RESCTRL_PATH);
> @@ -281,9 +433,10 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char
> *ctrlgrp, char *mongrp,
>  	if (ret)
>  		return ret;
>=20
> -	/* Create mon grp and write pid into it for "mbm" test */
> -	if ((strcmp(resctrl_val, "mbm") =3D=3D 0)) {
> -		if (mongrp) {
> +	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
> +	if ((strcmp(resctrl_val, "cqm") =3D=3D 0) ||
> +	    (strcmp(resctrl_val, "mbm") =3D=3D 0)) {
> +		if (strlen(mongrp)) {
>  			sprintf(monitorgroup_p, "%s/mon_groups",
> controlgroup);
>  			sprintf(monitorgroup, "%s/%s", monitorgroup_p,
> mongrp);
>  			ret =3D create_grp(mongrp, monitorgroup,
> monitorgroup_p);
> @@ -319,23 +472,31 @@ int write_schemata(char *ctrlgrp, char *schemata,
> int cpu_no, char *resctrl_val)
>  {
>  	char sock_num, controlgroup[1024], schema[1024];
>  	FILE *fp;
> +	int ret;
>=20
> -	if (strcmp(resctrl_val, "mba") =3D=3D 0) {
> +	if ((strcmp(resctrl_val, "mba") =3D=3D 0) ||
> +	    (strcmp(resctrl_val, "cqm") =3D=3D 0)) {
>  		if (!schemata) {
>  			printf("Schemata empty, so not updating\n");
>=20
>  			return 0;
>  		}
> -		sock_num =3D get_sock_num(cpu_no);
> -		if (sock_num < 0)
> +		ret =3D get_sock_num(cpu_no, &sock_num);
> +		if (ret < 0)
>  			return -1;
>=20
> -		if (ctrlgrp)
> +		if (strlen(ctrlgrp) !=3D 0)
>  			sprintf(controlgroup, "%s/%s/schemata",
> RESCTRL_PATH,
>  				ctrlgrp);
>  		else
>  			sprintf(controlgroup, "%s/schemata",
> RESCTRL_PATH);
> -		sprintf(schema, "%s%c%c%s", "MB:", sock_num, '=3D',
> schemata);
> +
> +		if (!strcmp(resctrl_val, "cqm"))
> +			sprintf(schema, "%s%c%c%s", "L3:", sock_num, '=3D',
> +				schemata);
> +		if (strcmp(resctrl_val, "mba") =3D=3D 0)
> +			sprintf(schema, "%s%c%c%s", "MB:", sock_num, '=3D',
> +				schemata);
>=20
>  		fp =3D fopen(controlgroup, "w");
>  		if (!fp) {
> @@ -352,7 +513,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int
> cpu_no, char *resctrl_val)
>  		}
>  		fclose(fp);
>=20
> -		printf("Write schemata to resctrl FS: done!\n");
> +		printf("Write schemata with %s to resctrl FS: done!\n",
> schema);
>  	}
>=20
>  	return 0;
> @@ -366,9 +527,9 @@ int write_schemata(char *ctrlgrp, char *schemata, int
> cpu_no, char *resctrl_val)
>   */
>  int validate_resctrl_feature_request(char *resctrl_val)
>  {
> -	int resctrl_features_supported[MAX_RESCTRL_FEATURES] =3D {0, 0};
> +	int resctrl_features_supported[MAX_RESCTRL_FEATURES] =3D {0, 0, 0,
> 0};
>  	const char *resctrl_features_list[MAX_RESCTRL_FEATURES] =3D {
> -			"mbm", "mba"};
> +			"mbm", "mba", "cqm"};
>  	int i, valid_resctrl_feature =3D -1;
>  	char line[1024];
>  	FILE *fp;
> @@ -409,6 +570,8 @@ int validate_resctrl_feature_request(char
> *resctrl_val)
>  			resctrl_features_supported[0] =3D 1;
>  		if ((strstr(line, RESCTRL_MBA)) !=3D NULL)
>  			resctrl_features_supported[1] =3D 1;
> +		if ((strstr(line, RESCTRL_CQM)) !=3D NULL)
> +			resctrl_features_supported[3] =3D 1;
>  	}
>  	fclose(fp);
>=20
> @@ -452,3 +615,25 @@ int perf_event_open(struct perf_event_attr
> *hw_event, pid_t pid, int cpu,
>  		      group_fd, flags);
>  	return ret;
>  }
> +
> +void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
> +{
> +	kill(bm_pid, SIGKILL);
> +	umount_resctrlfs();
> +	tests_cleanup();
> +	printf("Ending\n\n");
> +
> +	exit(EXIT_SUCCESS);
> +}
> +
> +unsigned int count_bits(unsigned long n)
> +{
> +	unsigned int count =3D 0;
> +
> +	while (n) {
> +		count +=3D n & 1;
> +		n >>=3D 1;
> +	}
> +
> +	return count;
> +}
> --
> 2.19.1

