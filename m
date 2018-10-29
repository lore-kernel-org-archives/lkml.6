Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36C420989
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kApHG9MP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36C420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeJ3Gyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:54:32 -0400
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:23668
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727749AbeJ3Gyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXKQa2Q00iODqssMwENnzBJP/71h/TCvL2xv/odSY+I=;
 b=kApHG9MPInLt+e/cu5/+7FQuu4Qy+PzN6wyHsKKM8+ARG3oQZKfn7RACck+o5NIt1uoryXHLa52Kt2TbpTYuzeZWH8MupTvIxoiUZncnOP/RCqHGbqI/E9rW+TON9ocx97E4MLNG+ejxJiiptVRMV4fXY4cPeMYohiRRGfLi5jg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1418.namprd12.prod.outlook.com (10.168.238.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Mon, 29 Oct 2018 22:03:46 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 22:03:46 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/8] selftests/resctrl: Add callback to start a
 benchmark
Thread-Topic: [PATCH v2 4/8] selftests/resctrl: Add callback to start a
 benchmark
Thread-Index: AQHUbLgFI3mHL7WI2k2MkT4/GQIbvaU2zGMA
Date:   Mon, 29 Oct 2018 22:03:46 +0000
Message-ID: <DM5PR12MB2471D2246730DF1A4923475B95F30@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1540508826-144502-1-git-send-email-fenghua.yu@intel.com>
 <1540508826-144502-5-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1540508826-144502-5-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2600:1700:270:e9d0:1c3a:d3a:dc00:d869]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1418;20:mM79nbAGpr0fvCdRB5alUuP4EnuDZT8Mn7LDCwD4ASliTY/0yqEvH4rJoA6qydLxty3oMDkg9YVw0swC1BqvKEB+BXjaSUuPEz6wh/7ROnkXqLCA8x/LcrsEGh5PVwHxM8wwMtczWX78KZjboG/F8FpG9aQkDprcY0nhxCcKlfqB2k0UrlKtzm+ZNDVEekD2jm9cjhbssid6lf79ypz5TgrVpN9H2XnjSx26FWD/epcPgNUX0zRfkhz9jyodoUBp
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a72f800e-cbf5-43c0-c585-08d63dea6657
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1418;
x-ms-traffictypediagnostic: DM5PR12MB1418:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB141883BF26E55ECB6465148E95F30@DM5PR12MB1418.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(767451399110)(180628864354917)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1418;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1418;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(346002)(136003)(366004)(13464003)(189003)(199004)(46003)(72206003)(6116002)(53936002)(71190400001)(229853002)(74316002)(478600001)(6506007)(33656002)(106356001)(53546011)(102836004)(305945005)(4744004)(55016002)(105586002)(14454004)(7416002)(7736002)(71200400001)(446003)(4326008)(8676002)(97736004)(6436002)(11346002)(186003)(316002)(5660300001)(81166006)(81156014)(2900100001)(476003)(14444005)(7696005)(486006)(256004)(76176011)(8936002)(6246003)(86362001)(9686003)(110136005)(68736007)(2906002)(25786009)(5250100002)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1418;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xvPOFnDLiQErBofkmsKoBi07KbiAWPI5WElklA5MZhF0KTsNAXOcyTowuTluh2662HJJsN6tXYZnDi2bjj2tESVeIJIOKbCaTNtgyUqZbgq47vdWfTIk1alJMOHZgdT0mLYhLSdPvKg+TePmf4+IehgeKfrmXLFWGDVIyp21W/TFAuXYChMFydHC5i0/5yHTS23BolE/eJrE9+gtzcT1sgnKLTN2Q+RvKUSEAeDb+q8cZTtatCyVddbFRJEmeLmflJIrFejEDXnImn1UEl2Jcg4bypvAeEkpCbhvT+tYNG1fwMgDXezZdeKUAZjpR6JNH9O1OtbFDzdfpQIzZl4oXywPIuxUhFrzJGTiZTueIwI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72f800e-cbf5-43c0-c585-08d63dea6657
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 22:03:46.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua/Sai,


> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Thursday, October 25, 2018 6:07 PM
> To: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; H Peter Anvin <hpa@zytor.com>; Tony Luck
> <tony.luck@intel.com>; Peter Zijlstra <peterz@infradead.org>; Reinette
> Chatre <reinette.chatre@intel.com>; Moger, Babu
> <Babu.Moger@amd.com>; James Morse <james.morse@arm.com>; Ravi V
> Shankar <ravi.v.shankar@intel.com>; Sai Praneeth Prakhya
> <sai.praneeth.prakhya@intel.com>; Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Cc: linux-kernel <linux-kernel@vger.kernel.org>; Fenghua Yu
> <fenghua.yu@intel.com>
> Subject: [PATCH v2 4/8] selftests/resctrl: Add callback to start a benchm=
ark
>=20
> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>=20
> The callback starts a child process and puts the child pid in created
> resctrl group with specified memory bandwidth in schemata. The child
> starts running benchmark.
>=20
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/membw.c   | 273
> ++++++++++++++++++++++++++++++
>  tools/testing/selftests/resctrl/resctrl.h |  27 +++
>  2 files changed, 300 insertions(+)
>=20
> diff --git a/tools/testing/selftests/resctrl/membw.c
> b/tools/testing/selftests/resctrl/membw.c
> index 1bced7e7f148..dfcd9c1244d8 100644
> --- a/tools/testing/selftests/resctrl/membw.c
> +++ b/tools/testing/selftests/resctrl/membw.c
> @@ -401,3 +401,276 @@ static unsigned long get_mem_bw_resctrl(void)
>=20
>  	return mbm_total;
>  }
> +
> +pid_t bm_pid, ppid;
> +
> +static void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
> +{
> +	kill(bm_pid, SIGKILL);
> +	printf("Ending\n\n");
> +
> +	exit(EXIT_SUCCESS);
> +}
> +
> +/*
> + * print_results_bw:	the memory bandwidth results are stored in a file
> + * @filename:		file that stores the results
> + * @bm_pid:		child pid that runs benchmark
> + * @bw_imc:		perf imc counter value
> + * @bw_resc:		memory bandwidth value
> + *
> + * Return:		0 on success. non-zero on failure.
> + */
> +static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
> +			    unsigned long bw_resc)
> +{
> +	int diff =3D abs(bw_imc - bw_resc);
> +	FILE *fp;
> +
> +	if (strcmp(filename, "stdio") =3D=3D 0 || strcmp(filename, "stderr") =
=3D=3D 0)
> {
> +		printf("Pid: %d \t Mem_BW_iMC: %f \t ", bm_pid, bw_imc);
> +		printf("Mem_BW_resc: %lu \t Difference: %d\n", bw_resc,
> diff);
> +	} else {
> +		fp =3D fopen(filename, "a");
> +		if (!fp) {
> +			perror("Cannot open results file");
> +
> +			return errno;
> +		}
> +		if (fprintf(fp, "Pid: %d \t Mem_BW_iMC: %f \t ",
> +			    bm_pid, bw_imc) <=3D 0 ||
> +		    fprintf(fp, "Mem_BW_resc: %lu \t Difference: %d\n",
> +			    bw_resc, diff) <=3D 0) {
> +			fclose(fp);
> +			perror("Could not log results.");
> +
> +			return errno;
> +		}
> +		fclose(fp);
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +measure_vals(struct resctrl_val_param *param, unsigned long
> *bw_resc_start)
> +{
> +	unsigned long bw_imc, bw_resc, bw_resc_end;
> +	int ret;
> +
> +	/*
> +	 * Measure memory bandwidth from resctrl and from
> +	 * another source which is perf imc value or could
> +	 * be something else if perf imc event is not available.
> +	 * Compare the two values to validate resctrl value.
> +	 * It takes 1sec to measure the data.
> +	 */
> +	bw_imc =3D get_mem_bw_imc(param->cpu_no, param->bw_report);
> +	if (bw_imc < 0)
> +		return bw_imc;
> +
> +	bw_resc_end =3D get_mem_bw_resctrl();
> +	if (bw_resc_end < 0)
> +		return bw_resc_end;
> +
> +	bw_resc =3D (bw_resc_end - *bw_resc_start) / MB;
> +	ret =3D print_results_bw(param->filename, bm_pid, bw_imc,
> bw_resc);
> +	if (ret)
> +		return ret;
> +
> +	*bw_resc_start =3D bw_resc_end;
> +
> +	return 0;
> +}
> +
> +/*
> + * membw_val:		execute benchmark and measure memory
> bandwidth on
> + *			the benchmark
> + * @benchmark_cmd:	benchmark command and its arguments
> + * @param:		parameters passed to membw_val()
> + *
> + * Return:		0 on success. non-zero on failure.
> + */
> +int membw_val(char **benchmark_cmd, struct resctrl_val_param *param)
> +{
> +	char *resctrl_val =3D param->resctrl_val;
> +	unsigned long bw_resc_start =3D 0;
> +	struct sigaction sigact;
> +	union sigval value;
> +	int sig =3D 0, ret =3D 0;
> +	FILE *fp;
> +
> +	if (strcmp(param->filename, "") =3D=3D 0)
> +		sprintf(param->filename, "stdio");
> +
> +	if (strcmp(param->bw_report, "") =3D=3D 0)
> +		param->bw_report =3D "total";
> +
> +	ret =3D validate_resctrl_feature_request(resctrl_val);
> +	if (ret)
> +		return ret;
> +
> +	if ((strcmp(resctrl_val, "mba")) =3D=3D 0 ||
> +	    (strcmp(resctrl_val, "mbm")) =3D=3D 0) {
> +		ret =3D validate_bw_report_request(param->bw_report);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D remount_resctrlfs(param->mum_resctrlfs);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If benchmark wasn't successfully started by child, then child should
> +	 * kill parent, so save parent's pid
> +	 */
> +	ppid =3D getpid();
> +
> +	/* File based synchronization between parent and child */
> +	fp =3D fopen("sig", "w");
> +	if (!fp || (fprintf(fp, "%d\n", 0) <=3D 0) || (fclose(fp) =3D=3D EOF)) =
{

Same comment as patch 2. If fprintf fails,  will it fclose the file? I sugg=
est to separate these checks.

> +		perror("Unable to establish sync bw parent & child");
> +
> +		return errno;
> +	}
> +
> +	/*
> +	 * Fork to start benchmark, save child's pid so that it can be killed
> +	 * when needed
> +	 */
> +	bm_pid =3D fork();
> +	if (bm_pid =3D=3D -1) {
> +		perror("Unable to fork");
> +
> +		return errno;
> +	}
> +
> +	if (bm_pid =3D=3D 0) {
> +		/*
> +		 * Mask all signals except SIGUSR1, parent uses SIGUSR1 to
> +		 * start benchmark
> +		 */
> +		sigfillset(&sigact.sa_mask);
> +		sigdelset(&sigact.sa_mask, SIGUSR1);
> +
> +		sigact.sa_sigaction =3D run_benchmark;
> +		sigact.sa_flags =3D SA_SIGINFO;
> +
> +		/* Register for "SIGUSR1" signal from parent */
> +		if (sigaction(SIGUSR1, &sigact, NULL))
> +			PARENT_EXIT("Can't register child for signal");
> +
> +		/* Signal parent that child is ready */
> +		fp =3D fopen("sig", "w");
> +		if (!fp || (fprintf(fp, "%d\n", 1) <=3D 0) ||
> +		    (fclose(fp) =3D=3D EOF))

Same comment as above. If fprintf fails,  will it fclose the file? I sugges=
t to separate these checks.

> +			PARENT_EXIT("can't signal that child is ready");
> +
> +		/* Suspend child until delivery of "SIGUSR1" from parent */
> +		sigsuspend(&sigact.sa_mask);
> +	}
> +
> +	printf("Benchmark PID: %d\n", bm_pid);
> +
> +	/*
> +	 * Register CTRL-C handler for parent, as it has to kill benchmark
> +	 * before exiting
> +	 */
> +	sigact.sa_sigaction =3D ctrlc_handler;
> +	sigemptyset(&sigact.sa_mask);
> +	sigact.sa_flags =3D SA_SIGINFO;
> +	if (sigaction(SIGINT, &sigact, NULL) ||
> +	    sigaction(SIGHUP, &sigact, NULL)) {
> +		perror("Can't register parent for CTRL-C handler");
> +		ret =3D errno;
> +		goto out;
> +	}
> +
> +	value.sival_ptr =3D benchmark_cmd;
> +
> +	/* Taskset benchmark to specified cpu */
> +	ret =3D taskset_benchmark(bm_pid, param->cpu_no);
> +	if (ret)
> +		goto out;
> +
> +	/* Write benchmark to specified con_mon grp, mon_grp in resctrl
> FS*/
> +	ret =3D write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param-
> >mongrp,
> +				      resctrl_val);
> +	if (ret)
> +		goto out;
> +
> +	if ((strcmp(resctrl_val, "mbm") =3D=3D 0) ||
> +	    (strcmp(resctrl_val, "mba") =3D=3D 0)) {
> +		ret =3D initialize_mem_bw_imc();
> +		if (ret)
> +			goto out;
> +
> +		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
> +					  param->cpu_no, resctrl_val);
> +	}
> +
> +	/*
> +	 * Parent should signal child to start executing benchmark only upon
> +	 * receiving a signal from child saying that it's ready
> +	 */
> +	while (sig =3D=3D 0) {
> +		fp =3D fopen("sig", "r");
> +		if (!fp) {
> +			perror("Unable to open 'sig' file");
> +			ret =3D errno;
> +			goto out;
> +		}
> +		fscanf(fp, "%d\n", &sig);
> +		if (fclose(fp) =3D=3D EOF) {
> +			perror("Unable to close 'sig' file");
> +			ret =3D errno;
> +			goto out;
> +		}
> +	}
> +	if (system(RM_SIG_FILE) !=3D 0)
> +		perror("Unable to remove 'sig' file");
> +
> +	/* Signal child to start benchmark */
> +	if (sigqueue(bm_pid, SIGUSR1, value) =3D=3D -1) {
> +		perror("Unable to signal child to start execution");
> +		ret =3D errno;
> +		goto out;
> +	}
> +
> +	/* Give benchmark enough time to fully run */
> +	sleep(1);
> +
> +	/* Test runs until the callback setup() tells the test to stop. */
> +	while (1) {
> +		if (strcmp(resctrl_val, "mbm") =3D=3D 0) {
> +			ret =3D param->setup(1, param);
> +			if (ret) {
> +				ret =3D 0;
> +				break;
> +			}
> +
> +			ret =3D measure_vals(param, &bw_resc_start);
> +			if (ret)
> +				break;
> +		} else if ((strcmp(resctrl_val, "mba") =3D=3D 0)) {
> +			ret =3D param->setup(1, param->cpu_no);
> +			if (ret) {
> +				ret =3D 0;
> +				break;
> +			}
> +
> +			ret =3D measure_vals(param, &bw_resc_start);
> +			if (ret)
> +				break;
> +		} else {
> +			break;
> +		}
> +	}
> +
> +out:
> +	kill(bm_pid, SIGKILL);
> +	umount_resctrlfs();
> +
> +	return ret;
> +}
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> index fe3c3434df97..f1de2dee8f50 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -3,6 +3,7 @@
>  #ifndef RESCTRL_H
>  #define RESCTRL_H
>  #include <stdio.h>
> +#include <stdarg.h>
>  #include <errno.h>
>  #include <sched.h>
>  #include <stdlib.h>
> @@ -33,10 +34,35 @@
>  		exit(EXIT_FAILURE);		\
>  	} while (0)
>=20
> +/*
> + * resctrl_val_param:	resctrl test parameters
> + * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
> + * @ctrlgrp:		Name of the control monitor group (con_mon grp)
> + * @mongrp:		Name of the monitor group (mon grp)
> + * @cpu_no:		CPU number to which the benchmark would be
> binded
> + * @mum_resctrlfs:	Should the resctrl FS be remounted?
> + * @filename:		Name of file to which the o/p should be written
> + * @bw_report:		Bandwidth report type (reads vs writes)
> + * @setup:		Call back function to setup test environment
> + */
> +struct resctrl_val_param {
> +	char	*resctrl_val;
> +	char	ctrlgrp[64];
> +	char	mongrp[64];
> +	int	cpu_no;
> +	int	span;
> +	int	mum_resctrlfs;
> +	char	filename[64];
> +	char	*bw_report;
> +	char	*bm_type;
> +	int	(*setup)(int num, ...);
> +};
> +
>  pid_t bm_pid, ppid;
>  int ben_count;
>=20
>  int remount_resctrlfs(bool mum_resctrlfs);
> +int umount_resctrlfs(void);
>  char get_sock_num(int cpu_no);
>  int validate_bw_report_request(char *bw_report);
>  int validate_resctrl_feature_request(char *resctrl_val);
> @@ -49,5 +75,6 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char
> *ctrlgrp, char *mongrp,
>  int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu=
,
>  		    int group_fd, unsigned long flags);
>  int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int=
 op);
> +int membw_val(char **benchmark_cmd, struct resctrl_val_param *param);
>=20
>  #endif /* RESCTRL_H */
> --
> 2.5.0

