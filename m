Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F8EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D5B2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1bM7/WSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D5B2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeJ3Gmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:42:31 -0400
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:64847
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbeJ3Gma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OGu0xY6CNbFoZxlMjYIkQJwcTX+nwqDA0rDn1xkYwE=;
 b=1bM7/WSp5IwGIuYkEW2e2buf9lQtpYpWeYdWIB4UM54GeuCDLNGzUh/ajp0BGJ9qrIssMMQHOjzEmud83GIVLlo4FwyBoFACoKzls3TZiIKxEJ2cOkryMGXVoqqQCmSbtaKtxo888+abUjEAMAHzq4yKgZrO3xtJSvRimzVhHm4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1692.namprd12.prod.outlook.com (10.172.40.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Mon, 29 Oct 2018 21:51:46 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 21:51:46 +0000
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
Subject: RE: [PATCH v2 2/8] selftests/resctrl: Add basic resctrl file system
 operations and data
Thread-Topic: [PATCH v2 2/8] selftests/resctrl: Add basic resctrl file system
 operations and data
Thread-Index: AQHUbLgDlrQML4ljtECAffIL8h1TDaU2w6aw
Date:   Mon, 29 Oct 2018 21:51:46 +0000
Message-ID: <DM5PR12MB2471679DD21D00A33D092A1795F30@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1540508826-144502-1-git-send-email-fenghua.yu@intel.com>
 <1540508826-144502-3-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1540508826-144502-3-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:1c3a:d3a:dc00:d869]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1692;20:N3h77aQ+zTX0oMKDg1gQ2mg8B3H8Lk74B75wG799ckfnFEfNVNPGEA8QkJ08FNswf+Bbo0ZP3nfk9r4vUwSE2/XnrHc/cL/Poj4tp5LK86UYAwiIOBRE6Eyn7me/xuLdrO9zcy3qrvJgMiyqDnrPDfxlIEyoppjh4PK9Br6nMJqwXuTSQt1/8qEwCxFwHsc4Khfs05zwR1DHkFKvjVv0Pn7LIidCoZBEFth5mQ4XiyQkMMxZ5QxG89Wgg2NWIJYO
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8660acbe-b88b-4c22-702b-08d63de8b8d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1692;
x-ms-traffictypediagnostic: DM5PR12MB1692:
x-microsoft-antispam-prvs: <DM5PR12MB1692A69B6EE0094897DD30BB95F30@DM5PR12MB1692.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(228905959029699)(767451399110)(180628864354917)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1692;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1692;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(136003)(39860400002)(376002)(189003)(199004)(13464003)(4744004)(486006)(46003)(110136005)(6436002)(305945005)(186003)(8936002)(6116002)(33656002)(2900100001)(4326008)(8676002)(74316002)(7736002)(81166006)(81156014)(25786009)(316002)(9686003)(102836004)(229853002)(14444005)(6246003)(6506007)(256004)(53546011)(478600001)(76176011)(68736007)(11346002)(55016002)(446003)(105586002)(53946003)(5660300001)(53936002)(14454004)(86362001)(71200400001)(97736004)(71190400001)(7416002)(476003)(106356001)(99286004)(72206003)(2906002)(7696005)(5250100002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1692;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: UqnsGhA1iGmh2hKj5x7vvHrGex4+eEdA7mh0EDqcDx3reRFKXcOHLIn773IY9CLilk5m72aPSkMr09ZKZifH8mbFlJlLHNYmg1SGwdt4tg9vEYB6pt4XUDDKisnEc0xMqg1R1h4JSb1shzHk2rh1nFoC+CjUnUNdkOvkwAZdrhmsJ2oI0ncgw+g0tv8fmr36JBL2U3C4Lud3RJUEDQi9iCHBNZIUhzt4yVrWX1ivRmoG2/w1huG5attY6imUJp/ktfUuvpXiUVNmdpbH5HAXFGCLoDO0DOEI0GHi4rtg5PkuvfYuUXNgCUknXhXLw26Ys9Kvh7sB71ewj1wc804vf+GYFTtKd2/5YUWg8lrnptY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8660acbe-b88b-4c22-702b-08d63de8b8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 21:51:46.0996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua, Sai,

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
> Subject: [PATCH v2 2/8] selftests/resctrl: Add basic resctrl file system
> operations and data
>=20
> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>=20
> The basic resctrl file system operations and data are added for future
> usage by resctrl selftest tool.
>=20
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/Makefile    |  10 +
>  tools/testing/selftests/resctrl/resctrl.h   |  53 ++++
>  tools/testing/selftests/resctrl/resctrlfs.c | 465
> ++++++++++++++++++++++++++++
>  3 files changed, 528 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/Makefile
>  create mode 100644 tools/testing/selftests/resctrl/resctrl.h
>  create mode 100644 tools/testing/selftests/resctrl/resctrlfs.c
>=20
> diff --git a/tools/testing/selftests/resctrl/Makefile
> b/tools/testing/selftests/resctrl/Makefile
> new file mode 100644
> index 000000000000..bd5c5418961e
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -0,0 +1,10 @@
> +CC =3D gcc
> +CFLAGS =3D -g -Wall
> +
> +*.o: *.c
> +	$(CC) $(CFLAGS) -c *.c
> +
> +.PHONY: clean
> +
> +clean:
> +	$(RM) *.o *~
> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> b/tools/testing/selftests/resctrl/resctrl.h
> new file mode 100644
> index 000000000000..fe3c3434df97
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#define _GNU_SOURCE
> +#ifndef RESCTRL_H
> +#define RESCTRL_H
> +#include <stdio.h>
> +#include <errno.h>
> +#include <sched.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <dirent.h>
> +#include <stdbool.h>
> +#include <sys/stat.h>
> +#include <sys/ioctl.h>
> +#include <sys/mount.h>
> +#include <sys/types.h>
> +#include <asm/unistd.h>
> +#include <linux/perf_event.h>
> +
> +#define MB			(1024 * 1024)
> +#define RESCTRL_PATH		"/sys/fs/resctrl"
> +#define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
> +#define RESCTRL_MBM		"L3 monitoring detected"
> +#define RESCTRL_MBA		"MB allocation detected"
> +#define MAX_RESCTRL_FEATURES	2
> +#define RM_SIG_FILE		"rm -rf sig"
> +
> +#define PARENT_EXIT(err_msg)			\
> +	do {					\
> +		perror(err_msg);		\
> +		kill(ppid, SIGKILL);		\
> +		exit(EXIT_FAILURE);		\
> +	} while (0)
> +
> +pid_t bm_pid, ppid;
> +int ben_count;
> +
> +int remount_resctrlfs(bool mum_resctrlfs);
> +char get_sock_num(int cpu_no);
> +int validate_bw_report_request(char *bw_report);
> +int validate_resctrl_feature_request(char *resctrl_val);
> +int taskset_benchmark(pid_t bm_pid, int cpu_no);
> +void run_benchmark(int signum, siginfo_t *info, void *ucontext);
> +int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
> +		   char *resctrl_val);
> +int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
> +			    char *resctrl_val);
> +int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu=
,
> +		    int group_fd, unsigned long flags);
> +int run_fill_buf(int span, int malloc_and_init_memory, int memflush, int
> op);
> +
> +#endif /* RESCTRL_H */
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c
> b/tools/testing/selftests/resctrl/resctrlfs.c
> new file mode 100644
> index 000000000000..d73726ef2002
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -0,0 +1,465 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Basic resctrl file system operations
> + *
> + * Copyright (C) 2018 Intel Corporation
> + *
> + * Authors:
> + *    Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>
> + *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> + *    Fenghua Yu <fenghua.yu@intel.com>
> + */
> +#include "resctrl.h"
> +
> +/*
> + * remount_resctrlfs:	Remount resctrl FS at /sys/fs/resctrl
> + * @mum_resctrlfs:	Should the resctrl FS be remounted?
> + *
> + * If not mounted, mount it.
> + * If mounted and mum_resctrlfs then remount resctrl FS.
> + * If mounted and !mum_resctrlfs then noop
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +int remount_resctrlfs(bool mum_resctrlfs)
> +{
> +	DIR *dp;
> +	struct dirent *ep;
> +	unsigned int count =3D 0;
> +
> +	/*
> +	 * If kernel is built with CONFIG_RESCTRL, then /sys/fs/resctrl should
> +	 * be present by default
> +	 */
> +	dp =3D opendir(RESCTRL_PATH);
> +	if (dp) {
> +		while ((ep =3D readdir(dp)) !=3D NULL)
> +			count++;
> +		closedir(dp);
> +	} else {
> +		perror("Unable to read /sys/fs/resctrl");
> +
> +		return errno;
> +	}
> +
> +	/*
> +	 * If resctrl FS has more than two entries, it means that resctrl FS ha=
s
> +	 * already been mounted. The two default entries are "." and "..",
> these
> +	 * are present even when resctrl FS is not mounted
> +	 */
> +	if (count > 2) {
> +		if (mum_resctrlfs) {
> +			if (umount(RESCTRL_PATH) !=3D 0) {
> +				perror("Unable to umount resctrl");
> +
> +				return errno;
> +			}
> +			printf("Remount: done!\n");
> +		} else {
> +			printf("Mounted already. Not remounting!\n");
> +
> +			return 0;
> +		}
> +	}
> +
> +	if (mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL) !=3D 0) {
> +		perror("Unable to mount resctrl FS at /sys/fs/resctrl");
> +
> +		return errno;
> +	}
> +
> +	return 0;
> +}
> +
> +int umount_resctrlfs(void)
> +{
> +	if (umount(RESCTRL_PATH)) {
> +		perror("Unable to umount resctrl");
> +
> +		return errno;
> +	}
> +
> +	return 0;
> +}
> +
> +char get_sock_num(int cpu_no)
> +{
> +	char sock_num, phys_pkg_path[1024];
> +	FILE *fp;
> +
> +	sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
> +		PHYS_ID_PATH, cpu_no);
> +	fp =3D fopen(phys_pkg_path, "r");

There should corresponding fclose for this. In general, I would check all t=
he fopens in this series. I found few of the files not closed while returni=
ng.
More comments below.

> +	if (!fp || fscanf(fp, "%c", &sock_num) <=3D 0 || fclose(fp) =3D=3D EOF)=
 {
> +		perror("Could not get socket number");
> +
> +		return -1;
> +	}
> +
> +	return sock_num;
> +}
> +
> +/*
> + * taskset_benchmark:	Taskset PID (i.e. benchmark) to a specified
> cpu
> + * @bm_pid:		PID that should be binded
> + * @cpu_no:		CPU number at which the PID would be binded
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +int taskset_benchmark(pid_t bm_pid, int cpu_no)
> +{
> +	cpu_set_t my_set;
> +
> +	CPU_ZERO(&my_set);
> +	CPU_SET(cpu_no, &my_set);
> +
> +	if (sched_setaffinity(bm_pid, sizeof(cpu_set_t), &my_set)) {
> +		perror("Unable to taskset benchmark");
> +
> +		return -1;
> +	}
> +
> +	printf("Taskset benchmark: done!\n");
> +
> +	return 0;
> +}
> +
> +/*
> + * Run a specified benchmark or fill_buf (default benchmark). Direct
> + * benchmark stdio to /dev/null
> + */
> +void run_benchmark(int signum, siginfo_t *info, void *ucontext)
> +{
> +	char **benchmark_cmd;
> +	int span, operation, ret;
> +
> +	benchmark_cmd =3D info->si_ptr;
> +
> +	/*
> +	 * Direct stdio of child to /dev/null, so that only parent writes to
> +	 * stdio (console)
> +	 */
> +	if (!freopen("/dev/null", "w", stdout))
> +		PARENT_EXIT("Unable to direct BM op to /dev/null");

Do you need fclose for this before returning from this function?

> +
> +	if (strcmp(benchmark_cmd[0], "fill_buf") =3D=3D 0) {
> +		/* Execute default fill_buf benchmark */
> +		span =3D atoi(benchmark_cmd[1]);
> +		operation =3D atoi(benchmark_cmd[4]);
> +		if (run_fill_buf(span, 1, 1, operation))
> +			fprintf(stderr, "Error in running fill buffer\n");
> +	} else {
> +		/* Execute specified benchmark */
> +		ret =3D execvp(benchmark_cmd[0], benchmark_cmd);
> +		if (ret)
> +			perror("wrong\n");
> +	}
> +
> +	PARENT_EXIT("Unable to run specified benchmark");
> +}
> +
> +/*
> + * create_con_mon_grp:	Create a con_mon group *only* if one
> doesn't exist
> + * @ctrlgrp:		Name of the con_mon group
> + * @controlgroup:	Path at which it should be created
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +static int create_con_mon_grp(const char *ctrlgrp, const char
> *controlgroup)
> +{
> +	int found_ctrl_grp =3D 0;
> +	struct dirent *ep;
> +	DIR *dp;
> +
> +	/*
> +	 * At this point, we are guaranteed to have resctrl FS mounted and if
> +	 * ctrlgrp =3D=3D NULL, it means, user wants to use root con_mon grp, s=
o
> do
> +	 * nothing
> +	 */
> +	if (!ctrlgrp)
> +		return 0;
> +
> +	/* Check if requested con_mon grp exists or not */
> +	dp =3D opendir(RESCTRL_PATH);
> +	if (dp) {
> +		while ((ep =3D readdir(dp)) !=3D NULL) {
> +			if (strcmp(ep->d_name, ctrlgrp) =3D=3D 0)
> +				found_ctrl_grp =3D 1;
> +		}
> +		closedir(dp);
> +	} else {
> +		perror("Unable to open resctrlfs for con_mon grp");
> +
> +		return errno;
> +	}
> +
> +	/* Requested con_mon grp doesn't exist, hence create it */
> +	if (found_ctrl_grp =3D=3D 0) {
> +		if (mkdir(controlgroup, 0) =3D=3D -1) {
> +			perror("Unable to create con_mon group");
> +
> +			return errno;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * create_mon_grp:	Create a monitor group *only* if one doesn't exist
> + * @mongrp:		Name of the monitor group
> + * @controlgroup:	Path of con_mon grp at which the mon grp will be
> created
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +static int create_mon_grp(const char *mongrp, const char *controlgroup)
> +{
> +	char monitorgroup[1024];
> +	int found_mon_grp =3D 0;
> +	struct dirent *ep;
> +	DIR *dp;
> +
> +	/* Check if requested mon grp exists or not */
> +	sprintf(monitorgroup, "%s/mon_groups", controlgroup);
> +	dp =3D opendir(monitorgroup);
> +	if (dp) {
> +		while ((ep =3D readdir(dp)) !=3D NULL) {
> +			if (strcmp(ep->d_name, mongrp) =3D=3D 0)
> +				found_mon_grp =3D 1;
> +		}
> +		closedir(dp);
> +	} else {
> +		perror("Unable to open resctrl FS for mon group");
> +
> +		return -1;
> +	}
> +
> +	/* Requested mon grp doesn't exist, hence create it */
> +	sprintf(monitorgroup, "%s/mon_groups/%s", controlgroup,
> mongrp);
> +	if (found_mon_grp =3D=3D 0) {
> +		if (mkdir(monitorgroup, 0) =3D=3D -1) {
> +			perror("Unable to create mon group");
> +
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * write_bm_pid_to_resctrl:	Write a PID (i.e. benchmark) to resctrl FS
> + * @bm_pid:			PID that should be written
> + * @ctrlgrp:			Name of the control monitor group
> (con_mon grp)
> + * @mongrp:			Name of the monitor group (mon grp)
> + * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
> + *
> + * If a con_mon grp is requested, create it and write pid to it, otherwi=
se
> + * write pid to root con_mon grp.
> + * If a mon grp is requested, create it and write pid to it, otherwise
> + * pid is not written, this means that pid is in con_mon grp and hence
> + * should consult con_mon grp's mon_data directory for results.
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
> +			    char *resctrl_val)
> +{
> +	char controlgroup[1024], monitorgroup[1024];
> +	FILE *fp;
> +	int ret;
> +
> +	if (ctrlgrp)
> +		sprintf(controlgroup, "%s/%s", RESCTRL_PATH, ctrlgrp);
> +	else
> +		sprintf(controlgroup, "%s", RESCTRL_PATH);
> +
> +	ret =3D create_con_mon_grp(ctrlgrp, controlgroup);
> +	if (ret)
> +		return ret;
> +
> +	/* Create mon grp, only for monitoring features like "mbm" */
> +	if ((strcmp(resctrl_val, "mbm") =3D=3D 0)) {
> +		if (mongrp) {
> +			ret =3D create_mon_grp(mongrp, controlgroup);
> +			if (ret)
> +				return ret;
> +
> +			sprintf(monitorgroup, "%s/mon_groups/%s/tasks",
> +				controlgroup, mongrp);
> +		}
> +	}
> +
> +	strcat(controlgroup, "/tasks");
> +
> +	/* Write child pid to con_mon grp */
> +	fp =3D fopen(controlgroup, "w");

I don't see corresponding fclose.

> +	if (!fp || fprintf(fp, "%d\n", bm_pid) <=3D 0 || fclose(fp) =3D=3D EOF)=
 {
> +		perror("Failed to write child to con_mon grp");
> +
> +		return errno;
> +	}
> +
> +	/* Write child pid to mon grp, only for "mbm" */
> +	if ((strcmp(resctrl_val, "mbm") =3D=3D 0)) {
> +		if (mongrp) {
> +			fp =3D fopen(monitorgroup, "w");
> +			if (!fp || fprintf(fp, "%d\n", bm_pid) <=3D 0 ||
> +			    fclose(fp) =3D=3D EOF) {


I feel too many checks at one place.  If fprintf fails,  will it fclose the=
 file? I suggest to separate these checks.

> +				perror("Failed to write child to mon grp");
> +
> +				return errno;
> +			}
> +		}
> +	}
> +
> +	printf("Write benchmark to resctrl FS: done!\n");
> +
> +	return 0;
> +}
> +
> +/*
> + * write_schemata:	Update schemata of a con_mon grp
> + * @ctrlgrp:		Name of the con_mon grp
> + * @schemata:		Schemata that should be updated to
> + * @cpu_no:		CPU number that the benchmark PID is binded to
> + * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
> + *
> + * Update schemata of a con_mon grp *only* if requested resctrl feature =
is
> + * allocation type
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char
> *resctrl_val)
> +{
> +	char sock_num, controlgroup[1024], schema[1024];
> +	FILE *fp;
> +
> +	if (strcmp(resctrl_val, "mba") =3D=3D 0) {
> +		if (!schemata) {
> +			printf("Schemata empty, so not updating\n");
> +
> +			return 0;
> +		}
> +		sock_num =3D get_sock_num(cpu_no);
> +		if (sock_num < 0)
> +			return -1;
> +
> +		if (ctrlgrp)
> +			sprintf(controlgroup, "%s/%s/schemata",
> RESCTRL_PATH,
> +				ctrlgrp);
> +		else
> +			sprintf(controlgroup, "%s/schemata",
> RESCTRL_PATH);
> +		sprintf(schema, "%s%c%c%s", "MB:", sock_num, '=3D',
> schemata);
> +
> +		fp =3D fopen(controlgroup, "w");
> +		if (!fp || fprintf(fp, "%s\n", schema) <=3D 0 ||
> +		    fclose(fp) =3D=3D EOF) {

Same comment as above.. If fprintf fails,  will it fclose the file? I sugge=
st to separate these checks.

> +			perror("Unable to write schemata to con_mon grp");
> +
> +			return errno;
> +		}
> +		printf("Write schemata to resctrl FS: done!\n");
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Check if the requested feature is a valid resctrl feature or not.
> + * If yes, check if it's supported by this platform or not.
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +int validate_resctrl_feature_request(char *resctrl_val)
> +{
> +	const char *resctrl_features_list[MAX_RESCTRL_FEATURES] =3D {
> +			"mbm", "mba"};
> +	int resctrl_features_supported[MAX_RESCTRL_FEATURES] =3D {0, 0};
> +	int i, valid_resctrl_feature =3D -1;
> +	char line[1024];
> +	FILE *fp;
> +
> +	if (!resctrl_val) {
> +		fprintf(stderr, "resctrl feature cannot be NULL\n");
> +
> +		return -1;
> +	}
> +
> +	/* Is the resctrl feature request valid? */
> +	for (i =3D 0; i < MAX_RESCTRL_FEATURES; i++) {
> +		if (strcmp(resctrl_features_list[i], resctrl_val) =3D=3D 0)
> +			valid_resctrl_feature =3D i;
> +	}
> +	if (valid_resctrl_feature =3D=3D -1) {
> +		fprintf(stderr, "Not a valid resctrl feature request\n");
> +
> +		return -1;
> +	}
> +
> +	/* Enumerate resctrl features supported by this platform */
> +	if (system("dmesg > dmesg") !=3D 0) {
> +		perror("Could not create custom dmesg file");
> +
> +		return errno;
> +	}
> +
> +	fp =3D fopen("dmesg", "r");
> +	if (!fp) {
> +		perror("Could not read custom created dmesg");
> +
> +		return errno;
> +	}
> +
> +	while (fgets(line, 1024, fp)) {
> +		if ((strstr(line, RESCTRL_MBM)) !=3D NULL)
> +			resctrl_features_supported[0] =3D 1;
> +		if ((strstr(line, RESCTRL_MBA)) !=3D NULL)
> +			resctrl_features_supported[1] =3D 1;
> +	}
> +	if (fclose(fp) =3D=3D EOF) {
> +		perror("Error in closing file");
> +
> +		return errno;
> +	}
> +
> +	if (system("rm -rf dmesg") !=3D 0)
> +		perror("Unable to remove 'dmesg' file");
> +
> +	/* Is the resctrl feature request supported? */
> +	if (!resctrl_features_supported[valid_resctrl_feature]) {
> +		fprintf(stderr, "resctrl feature not supported!");
> +
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +int validate_bw_report_request(char *bw_report)
> +{
> +	if (strcmp(bw_report, "reads") =3D=3D 0)
> +		return 0;
> +	if (strcmp(bw_report, "writes") =3D=3D 0)
> +		return 0;
> +	if (strcmp(bw_report, "nt-writes") =3D=3D 0) {
> +		strcpy(bw_report, "writes");
> +		return 0;
> +	}
> +	if (strcmp(bw_report, "total") =3D=3D 0)
> +		return 0;
> +
> +	fprintf(stderr, "Requested iMC B/W report type unavailable\n");
> +
> +	return -1;
> +}
> +
> +int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu=
,
> +		    int group_fd, unsigned long flags)
> +{
> +	int ret;
> +
> +	ret =3D syscall(__NR_perf_event_open, hw_event, pid, cpu,
> +		      group_fd, flags);
> +	return ret;
> +}
> --
> 2.5.0

