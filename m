Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE582C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFBD2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Egi0j43J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFBD2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeJ3Gvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:51:50 -0400
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:39184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727597AbeJ3Gvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUhSTV8lWmxjJH4DIiZYT6Qw/dcxbHyoFhMbjnwec94=;
 b=Egi0j43JEU9SFc4e+/wvDipPZUT4fIkwE56GuJBvjGfZHYnN//bTHU3H9ygEftt5ZqXmCCiG4/eRKU7x39MAU3UybfLPr2gx1Rab2W3oOHbPMOTuwoUvYsMvmCiLNS5tP/D8JMT3qP2kJ5sGdeb3rZtdcairv9exiU06o0KVHRE=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1308.namprd12.prod.outlook.com (10.168.238.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.25; Mon, 29 Oct 2018 22:00:18 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 22:00:18 +0000
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
Subject: RE: [PATCH v2 3/8] selftests/resctrl: Read memory bandwidth from perf
 IMC counter and from resctrl file system
Thread-Topic: [PATCH v2 3/8] selftests/resctrl: Read memory bandwidth from
 perf IMC counter and from resctrl file system
Thread-Index: AQHUbLgF3NNoTfc+6keXN+c7OSo6PaU2ykJw
Date:   Mon, 29 Oct 2018 22:00:18 +0000
Message-ID: <DM5PR12MB247166BCA7D83A8AECE2BFFD95F30@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1540508826-144502-1-git-send-email-fenghua.yu@intel.com>
 <1540508826-144502-4-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1540508826-144502-4-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:1c3a:d3a:dc00:d869]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1308;20:axYHliF07HfMxymMoNme9NlKVha0UcWKyZlrXxh1Mrm2o53Xz+xHkUT0rtfX4vVnUN8c3nZzY/phlyTQWlMer0SsixWGc6RG4PwvXEz4GzdKAu5t51V06JdfScNFs5hdXYDlNfmQf3JSB9qQRibBu6GPXQKnflxdq4DDKqMP1v5hvev6jQ3GjbDQf3OJTWCTg03SlkR/Cyd0lt3I324B6/+BKpdt3sJrpRBVC3FA6AJNjWpTmsVkIIzCqdh+5S2G
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c521d7cf-5413-44c1-9c5c-08d63de9ea21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1308;
x-ms-traffictypediagnostic: DM5PR12MB1308:
x-microsoft-antispam-prvs: <DM5PR12MB13084ED7844FDA639FE5A33A95F30@DM5PR12MB1308.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72170088055959)(228905959029699)(767451399110)(180628864354917)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1308;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1308;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(189003)(199004)(13464003)(8676002)(6116002)(99286004)(4744004)(229853002)(8936002)(46003)(53546011)(74316002)(5660300001)(14444005)(53936002)(86362001)(256004)(478600001)(72206003)(186003)(2900100001)(71190400001)(71200400001)(2906002)(6246003)(110136005)(106356001)(76176011)(4326008)(7696005)(105586002)(9686003)(97736004)(102836004)(68736007)(81156014)(55016002)(33656002)(6506007)(14454004)(486006)(446003)(5250100002)(305945005)(6436002)(81166006)(316002)(7416002)(11346002)(25786009)(7736002)(476003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1308;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xyNNwSxD9hH/Tij5ynpSMB3ZSdWBwv1E8AEilnsLpWryGukFPh+zptWy4oaADFVleVble2pekYSo8O9alsqgbDTEWsxNFoZN8mGBjtXYnunV010HhSHNhi41Yp4X/C+ZooB4OfyyxC4JxPiJ1llvj+Gnn6HTxIIhX8tg06ebpIsHFXpLDcdOrolvVMMTIy/jYBdqUWbuvxZYM/MQpx07cU2J9kiTxgG0ceWCu199B2qt5CUpSsgf4dyku//9gsdJRLcQjeaDNQnTHYUv5eH/i0YsUBLh8g3OO3KqQpp9mbrslP15HkKui0Xap2rcfDLA5YuLWJgPKbmAGRqsTzWFC5j1zbmT6iqZpSY3rdYXJOo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c521d7cf-5413-44c1-9c5c-08d63de9ea21
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 22:00:18.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua, Sai

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
> Subject: [PATCH v2 3/8] selftests/resctrl: Read memory bandwidth from per=
f
> IMC counter and from resctrl file system
>=20
> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>=20
> Total memory bandwidth can be monitored from perf IMC counter and from
> resctrl file system. Later the two will be compared to verify the total
> memory bandwidth read from resctrl is correct.
>=20
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Signed-off-by: Arshiya Hayatkhan Pathan
> <arshiya.hayatkhan.pathan@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/membw.c | 403
> ++++++++++++++++++++++++++++++++
>  1 file changed, 403 insertions(+)
>  create mode 100644 tools/testing/selftests/resctrl/membw.c
>=20
> diff --git a/tools/testing/selftests/resctrl/membw.c
> b/tools/testing/selftests/resctrl/membw.c
> new file mode 100644
> index 000000000000..1bced7e7f148
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/membw.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Memory bandwidth monitoring and allocation library
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
> +#define UNCORE_IMC		"uncore_imc"
> +#define READ_FILE_NAME		"events/cas_count_read"
> +#define WRITE_FILE_NAME		"events/cas_count_write"
> +#define DYN_PMU_PATH		"/sys/bus/event_source/devices"
> +#define SCALE			0.00006103515625
> +#define MAX_IMCS		20
> +#define MAX_TOKENS		5
> +#define READ			0
> +#define WRITE			1
> +#define CON_MON_MBM_LOCAL_BYTES_PATH
> 	\
> +
> 	"%s/%s/mon_groups/%s/mon_data/mon_L3_0%c/mbm_local_byte
> s"
> +
> +#define CON_MBM_LOCAL_BYTES_PATH		\
> +	"%s/%s/mon_data/mon_L3_0%c/mbm_local_bytes"
> +
> +#define MON_MBM_LOCAL_BYTES_PATH		\
> +	"%s/mon_groups/%s/mon_data/mon_L3_0%c/mbm_local_bytes"
> +
> +#define MBM_LOCAL_BYTES_PATH			\
> +	"%s/mon_data/mon_L3_0%c/mbm_local_bytes"
> +
> +struct membw_read_format {
> +	__u64 value;         /* The value of the event */
> +	__u64 time_enabled;  /* if PERF_FORMAT_TOTAL_TIME_ENABLED
> */
> +	__u64 time_running;  /* if PERF_FORMAT_TOTAL_TIME_RUNNING
> */
> +	__u64 id;            /* if PERF_FORMAT_ID */
> +};
> +
> +struct imc_counter_config {
> +	__u32 type;
> +	__u64 event;
> +	__u64 umask;
> +	struct perf_event_attr pe;
> +	struct membw_read_format return_value;
> +	int fd;
> +};
> +
> +static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
> +static char mbm_total_path[1024];
> +static int imcs;
> +
> +void membw_initialize_perf_event_attr(int i, int j)
> +{
> +	memset(&imc_counters_config[i][j].pe, 0,
> +	       sizeof(struct perf_event_attr));
> +	imc_counters_config[i][j].pe.type =3D imc_counters_config[i][j].type;
> +	imc_counters_config[i][j].pe.size =3D sizeof(struct perf_event_attr);
> +	imc_counters_config[i][j].pe.disabled =3D 1;
> +	imc_counters_config[i][j].pe.inherit =3D 1;
> +	imc_counters_config[i][j].pe.exclude_guest =3D 1;
> +	imc_counters_config[i][j].pe.config =3D
> +		imc_counters_config[i][j].umask << 8 |
> +		imc_counters_config[i][j].event;
> +	imc_counters_config[i][j].pe.sample_type =3D
> PERF_SAMPLE_IDENTIFIER;
> +	imc_counters_config[i][j].pe.read_format =3D
> +		PERF_FORMAT_TOTAL_TIME_ENABLED |
> PERF_FORMAT_TOTAL_TIME_RUNNING;
> +}
> +
> +static int open_perf_event(int i, int cpu_no, int j)
> +{
> +	imc_counters_config[i][j].fd =3D
> +		perf_event_open(&imc_counters_config[i][j].pe, -1,
> cpu_no, -1,
> +				PERF_FLAG_FD_CLOEXEC);
> +
> +	if (imc_counters_config[i][j].fd =3D=3D -1) {
> +		fprintf(stderr, "Error opening leader %llx\n",
> +			imc_counters_config[i][j].pe.config);
> +
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +void membw_ioctl_perf_event_ioc_reset_enable(int i, int j)
> +{
> +	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_RESET, 0);
> +	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_ENABLE, 0);
> +}
> +
> +void membw_ioctl_perf_event_ioc_disable(int i, int j)
> +{
> +	ioctl(imc_counters_config[i][j].fd, PERF_EVENT_IOC_DISABLE, 0);
> +}
> +
> +/*
> + * get_event_and_umask:	Parse config into event and umask
> + * @cas_count_cfg:	Config
> + * @count:		iMC number
> + * @op:			Operation (read/write)
> + */
> +void get_event_and_umask(char *cas_count_cfg, int count, bool op)
> +{
> +	char *token[MAX_TOKENS];
> +	int i =3D 0;
> +
> +	strcat(cas_count_cfg, ",");
> +	token[0] =3D strtok(cas_count_cfg, "=3D,");
> +
> +	for (i =3D 1; i < MAX_TOKENS; i++)
> +		token[i] =3D strtok(NULL, "=3D,");
> +
> +	for (i =3D 0; i < MAX_TOKENS; i++) {
> +		if (!token[i])
> +			break;
> +		if (strcmp(token[i], "event") =3D=3D 0) {
> +			if (op =3D=3D READ)
> +				imc_counters_config[count][READ].event =3D
> +				strtol(token[i + 1], NULL, 16);
> +			else
> +				imc_counters_config[count][WRITE].event =3D
> +				strtol(token[i + 1], NULL, 16);
> +		}
> +		if (strcmp(token[i], "umask") =3D=3D 0) {
> +			if (op =3D=3D READ)
> +				imc_counters_config[count][READ].umask =3D
> +				strtol(token[i + 1], NULL, 16);
> +			else
> +				imc_counters_config[count][WRITE].umask =3D
> +				strtol(token[i + 1], NULL, 16);
> +		}
> +	}
> +}
> +
> +/* Get type and config (read and write) of an iMC counter */
> +static int read_from_imc_dir(char *imc_dir, int count)
> +{
> +	char cas_count_cfg[1024], imc_counter_cfg[1024],
> imc_counter_type[1024];
> +	FILE *fp;
> +
> +	/* Get type of iMC counter */
> +	sprintf(imc_counter_type, "%s%s", imc_dir, "type");
> +	fp =3D fopen(imc_counter_type, "r");
> +	if (!fp ||
> +	    fscanf(fp, "%u", &imc_counters_config[count][READ].type) <=3D 0 ||
> +	    fclose(fp) =3D=3D EOF) {

Same comment as patch 2. If fscanf fails,  will it fclose the file? I sugge=
st to separate these checks.

> +		perror("Could not get imc type");
> +
> +		return errno;
> +	}
> +
> +	imc_counters_config[count][WRITE].type =3D
> +				imc_counters_config[count][READ].type;
> +
> +	/* Get read config */
> +	sprintf(imc_counter_cfg, "%s%s", imc_dir, READ_FILE_NAME);
> +	fp =3D fopen(imc_counter_cfg, "r");
> +	if (!fp || fscanf(fp, "%s", cas_count_cfg) <=3D 0 || fclose(fp) =3D=3D =
EOF) {

Same comment as above. If fscanf fails,  will it fclose the file? I suggest=
 to separate these checks.

> +		perror("Could not get imc cas count read");
> +
> +		return errno;
> +	}
> +
> +	get_event_and_umask(cas_count_cfg, count, READ);
> +
> +	/* Get write config */
> +	sprintf(imc_counter_cfg, "%s%s", imc_dir, WRITE_FILE_NAME);
> +	fp =3D fopen(imc_counter_cfg, "r");
> +	if (!fp || fscanf(fp, "%s", cas_count_cfg) <=3D 0 || fclose(fp) =3D=3D =
EOF) {

Same comment as above.

> +		perror("Could not get imc cas count write");
> +
> +		return errno;
> +	}
> +
> +	get_event_and_umask(cas_count_cfg, count, WRITE);
> +
> +	return 0;
> +}
> +
> +/*
> + * A system can have 'n' number of iMC (Integrated Memory Controller)
> + * counters, get that 'n'. For each iMC counter get it's type and config=
.
> + * Also, each counter has two configs, one for read and the other for wr=
ite.
> + * A config again has two parts, event and umask.
> + * Enumerate all these details into an array of structures.
> + *
> + * Return: >=3D 0 on success. < 0 on failure.
> + */
> +static int num_of_imcs(void)
> +{
> +	unsigned int count =3D 0;
> +	char imc_dir[1024];
> +	struct dirent *ep;
> +	int ret;
> +	DIR *dp;
> +
> +	dp =3D opendir(DYN_PMU_PATH);
> +	if (dp) {
> +		while ((ep =3D readdir(dp))) {
> +			if (strstr(ep->d_name, UNCORE_IMC)) {
> +				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
> +					ep->d_name);
> +				ret =3D read_from_imc_dir(imc_dir, count);
> +				if (ret)
> +					return ret;
> +
> +				count++;
> +			}
> +		}
> +		closedir(dp);
> +		if (count =3D=3D 0) {
> +			perror("Unable find iMC counters!\n");
> +
> +			return -1;
> +		}
> +	} else {
> +		perror("Unable to open PMU directory!\n");
> +
> +		return -1;
> +	}
> +
> +	return count;
> +}
> +
> +static int initialize_mem_bw_imc(void)
> +{
> +	int imc, j;
> +
> +	imcs =3D num_of_imcs();
> +	if (imcs < 0)
> +		return imcs;
> +
> +	/* Initialize perf_event_attr structures for all iMC's */
> +	for (imc =3D 0; imc < imcs; imc++) {
> +		for (j =3D 0; j < 2; j++)
> +			membw_initialize_perf_event_attr(imc, j);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * get_mem_bw_imc:	Memory band width as reported by iMC counters
> + * @cpu_no:		CPU number that the benchmark PID is binded to
> + * @bw_report:		Bandwidth report type (reads, writes)
> + *
> + * Memory B/W utilized by a process on a socket can be calculated using
> + * iMC counters. Perf events are used to read these counters.
> + *
> + * Return: >=3D 0 on success. < 0 on failure.
> + */
> +static float get_mem_bw_imc(int cpu_no, char *bw_report)
> +{
> +	float reads, writes, of_mul_read, of_mul_write;
> +	int imc, j, ret;
> +
> +	/* Start all iMC counters to log values (both read and write) */
> +	reads =3D 0, writes =3D 0, of_mul_read =3D 1, of_mul_write =3D 1;
> +	for (imc =3D 0; imc < imcs; imc++) {
> +		for (j =3D 0; j < 2; j++) {
> +			ret =3D open_perf_event(imc, cpu_no, j);
> +			if (ret)
> +				return -1;
> +		}
> +		for (j =3D 0; j < 2; j++)
> +			membw_ioctl_perf_event_ioc_reset_enable(imc, j);
> +	}
> +
> +	sleep(1);
> +
> +	/* Stop counters after a second to get results (both read and write)
> */
> +	for (imc =3D 0; imc < imcs; imc++) {
> +		for (j =3D 0; j < 2; j++)
> +			membw_ioctl_perf_event_ioc_disable(imc, j);
> +	}
> +
> +	/*
> +	 * Get results which are stored in struct type imc_counter_config
> +	 * Take over flow into consideration before calculating total b/w
> +	 */
> +	for (imc =3D 0; imc < imcs; imc++) {
> +		struct imc_counter_config *r =3D
> +			&imc_counters_config[imc][READ];
> +		struct imc_counter_config *w =3D
> +			&imc_counters_config[imc][WRITE];
> +
> +		if (read(r->fd, &r->return_value,
> +			 sizeof(struct membw_read_format)) =3D=3D -1) {
> +			perror("Couldn't get read b/w through iMC");
> +
> +			return -1;
> +		}
> +
> +		if (read(w->fd, &w->return_value,
> +			 sizeof(struct membw_read_format)) =3D=3D -1) {
> +			perror("Couldn't get write bw through iMC");
> +
> +			return -1;
> +		}
> +
> +		__u64 r_time_enabled =3D r->return_value.time_enabled;
> +		__u64 r_time_running =3D r->return_value.time_running;
> +
> +		if (r_time_enabled !=3D r_time_running)
> +			of_mul_read =3D (float)r_time_enabled /
> +					(float)r_time_running;
> +
> +		__u64 w_time_enabled =3D w->return_value.time_enabled;
> +		__u64 w_time_running =3D w->return_value.time_running;
> +
> +		if (w_time_enabled !=3D w_time_running)
> +			of_mul_write =3D (float)w_time_enabled /
> +					(float)w_time_running;
> +		reads +=3D r->return_value.value * of_mul_read * SCALE;
> +		writes +=3D w->return_value.value * of_mul_write * SCALE;
> +	}
> +
> +	for (imc =3D 0; imc < imcs; imc++) {
> +		close(imc_counters_config[imc][READ].fd);
> +		close(imc_counters_config[imc][WRITE].fd);
> +	}
> +
> +	if (strcmp(bw_report, "reads") =3D=3D 0)
> +		return reads;
> +
> +	if (strcmp(bw_report, "writes") =3D=3D 0)
> +		return writes;
> +
> +	return (reads + writes);
> +}
> +
> +void set_mbm_path(const char *ctrlgrp, const char *mongrp, char
> sock_num)
> +{
> +	if (ctrlgrp && mongrp)
> +		sprintf(mbm_total_path,
> CON_MON_MBM_LOCAL_BYTES_PATH,
> +			RESCTRL_PATH, ctrlgrp, mongrp, sock_num);
> +	else if (!ctrlgrp && mongrp)
> +		sprintf(mbm_total_path, MON_MBM_LOCAL_BYTES_PATH,
> RESCTRL_PATH,
> +			mongrp, sock_num);
> +	else if (ctrlgrp && !mongrp)
> +		sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
> RESCTRL_PATH,
> +			ctrlgrp, sock_num);
> +	else if (!ctrlgrp && !mongrp)
> +		sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
> RESCTRL_PATH,
> +			sock_num);
> +}
> +
> +/*
> + * initialize_mem_bw_resctrl:	Appropriately populate "mbm_total_path"
> + * @ctrlgrp:			Name of the control monitor group
> (con_mon grp)
> + * @mongrp:			Name of the monitor group (mon grp)
> + * @cpu_no:			CPU number that the benchmark PID is
> binded to
> + * @resctrl_val:		Resctrl feature (Eg: mbm, mba.. etc)
> + */
> +static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char
> *mongrp,
> +				      int cpu_no, char *resctrl_val)
> +{
> +	char sock_num;
> +
> +	sock_num =3D get_sock_num(cpu_no);
> +	if (sock_num < 0)
> +		return;
> +
> +	if (strcmp(resctrl_val, "mbm") =3D=3D 0)
> +		set_mbm_path(ctrlgrp, mongrp, sock_num);
> +
> +	if ((strcmp(resctrl_val, "mba") =3D=3D 0)) {
> +		if (ctrlgrp)
> +			sprintf(mbm_total_path,
> CON_MBM_LOCAL_BYTES_PATH,
> +				RESCTRL_PATH, ctrlgrp, sock_num);
> +		else
> +			sprintf(mbm_total_path, MBM_LOCAL_BYTES_PATH,
> +				RESCTRL_PATH, sock_num);
> +	}
> +}
> +
> +/*
> + * Get MBM Local bytes as reported by resctrl FS
> + * For MBM,
> + * 1. If con_mon grp and mon grp are given, then read from con_mon grp's
> mon grp
> + * 2. If only con_mon grp is given, then read from con_mon grp
> + * 3. If both are not given, then read from root con_mon grp
> + * For MBA,
> + * 1. If con_mon grp is given, then read from it
> + * 2. If con_mon grp is not given, then read from root con_mon grp
> + */
> +static unsigned long get_mem_bw_resctrl(void)
> +{
> +	unsigned long mbm_total =3D 0;
> +	FILE *fp;
> +
> +	fp =3D fopen(mbm_total_path, "r");
> +	if (!fp || fscanf(fp, "%lu", &mbm_total) <=3D 0 || fclose(fp) =3D=3D EO=
F) {

Same comment as above. If fscanf fails,  will it fclose the file? I suggest=
 to separate these checks.

> +		perror("Could not get mbm local bytes");
> +
> +		return -1;
> +	}
> +
> +	return mbm_total;
> +}
> --
> 2.5.0

