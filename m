Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B556C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152FE2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 14:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UlyCuQwl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hs1izvB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152FE2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbeIYUyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 16:54:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729333AbeIYUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 16:54:37 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8PEjZkq024917;
        Tue, 25 Sep 2018 07:46:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JSultzY78yoPK3FszrTsjB+HAgj1g/QCnC3IfnOJWaM=;
 b=UlyCuQwlXbK7PjrVLlGiB1+yA9vQMl5NHV23MNgPYbYVfpxfPDwqRDRi8rpqL4Qiq2eR
 ZrGee5yjcHrNtLVSxyQmacLCrfxqTTr+pdHodjl8ziizyCy8N/zdHrZdrl7+TiZE78Bd
 7v4a56tNr/0oF0oglbf0MbSemqLWHbp/g+k= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mqp9wr52m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 25 Sep 2018 07:46:39 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 25 Sep 2018 07:46:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSultzY78yoPK3FszrTsjB+HAgj1g/QCnC3IfnOJWaM=;
 b=hs1izvB9tJ8HNNfuoSRfueW97iqWS1VzmZbtZlQtOo0xmXJMMf4ztRnCHOkoCMvi04agjdJQKvxVO7Lz9rHI+XqilpdF0X6Yh/+02hW9F0q3aYpZPiCRCDmj4CiU0jBk3hJe+gcAutvnor2DQi4paDQ6FBALBQOBGL5hNnf5ZVY=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1183.namprd15.prod.outlook.com (10.175.2.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Tue, 25 Sep 2018 14:46:32 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::9082:c167:38a9:9705%7]) with mapi id 15.20.1143.019; Tue, 25 Sep 2018
 14:46:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Srikar Dronamraju" <srikar@linux.vnet.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Topic: [PATCH RESEND] trace_uprobe: support reference counter in
 fd-based uprobe
Thread-Index: AQHUVEtirE9ytyh59kqeAFSxKzDreqUAiLUAgACLzIA=
Date:   Tue, 25 Sep 2018 14:46:32 +0000
Message-ID: <2EAC58E5-A849-44AC-86E4-68C7D1AEB965@fb.com>
References: <20180924211236.4149482-1-songliubraving@fb.com>
 <201809251403.5GBHgN7F%fengguang.wu@intel.com>
In-Reply-To: <201809251403.5GBHgN7F%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.9.1)
x-originating-ip: [2620:10d:c090:180::1:f2c7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1183;20:SWILz9FVnHGkSnpgsfeR9xGsK3TrTfnhEz1T2tD7hfK2RR1zPUretf9DffhKNajuWNSvXzGXmZU/TatePSxKaPt9YgUcWUFWVUG17S9S0wlvafz7uhSj9IJ0YTZFyG9EGNAMM3D+02EC0JA7pCrE+waoBWMzRAtROWjcETbo7Ag=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dc087a24-e155-4a5c-8549-08d622f5af55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1183;
x-ms-traffictypediagnostic: MWHPR15MB1183:
x-microsoft-antispam-prvs: <MWHPR15MB1183CAB893DE84F7006E1A54B3160@MWHPR15MB1183.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(166708455590820)(10436049006162)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149066)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:MWHPR15MB1183;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1183;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(6246003)(5660300001)(6116002)(36756003)(76176011)(81156014)(71190400001)(99286004)(25786009)(82746002)(71200400001)(6486002)(316002)(53936002)(6306002)(7736002)(305945005)(54906003)(6512007)(53546011)(33656002)(6506007)(8676002)(186003)(83716004)(86362001)(2616005)(2900100001)(575784001)(478600001)(81166006)(102836004)(8936002)(105586002)(50226002)(4326008)(966005)(106356001)(486006)(11346002)(446003)(476003)(6916009)(2906002)(5024004)(256004)(46003)(5250100002)(57306001)(14454004)(97736004)(6436002)(345774005)(68736007)(229853002)(34290500001)(1758585002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1183;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5fkiYIluNSEI4NgXIE5vreryK+DuG84iaZ/IPXy/yrFFATvXTCQpiyBw+zDQdgE0SZWKIBARbDoHyl4PAmTpBL25OrlTa3TSoi8xXwc9YqHrwmGJ6mCSs6f+9DIOz+Yo8X6YtjODTl6gKmRVJQC6hPChguy87V1gH8QglXsmz0ovaHQsYCNqENIwUoq4amVN4L/ChUwiMLxwNlHzsR6/gVK+PkC25n/3rEpbkLrq8TtXlK0uso/M6sjyZbFDgATALiJtfzQuxg6w6tJavLn/KCXSE98yOMAQKJiqxKSJKQfi4EzafhKITNOHD34ljqJPgYAneDnd92m9LNEyWqp4Tg40BocyaV6EoqxA9kAG+Y0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C39415EF7D76D44887EFBDAB6C601141@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc087a24-e155-4a5c-8549-08d622f5af55
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 14:46:32.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1183
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-25_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=20

This patch is based on this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/log=
/?h=3Dftrace/core

Thanks,
Song



> On Sep 24, 2018, at 11:26 PM, kbuild test robot <lkp@intel.com> wrote:
>=20
> Hi Song,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on v4.19-rc5 next-20180925]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Song-Liu/trace_uprobe-su=
pport-reference-counter-in-fd-based-uprobe/20180925-135454
> config: i386-randconfig-x005-201838 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=3Di386=20
>=20
> All errors (new ones prefixed by >>):
>=20
>   kernel/trace/trace_uprobe.c: In function 'create_local_trace_uprobe':
>>> kernel/trace/trace_uprobe.c:1376:4: error: 'struct trace_uprobe' has no=
 member named 'ref_ctr_offset'
>     tu->ref_ctr_offset =3D ref_ctr_offset;
>       ^~
>=20
> vim +1376 kernel/trace/trace_uprobe.c
>=20
>  1340=09
>  1341	#ifdef CONFIG_PERF_EVENTS
>  1342	struct trace_event_call *
>  1343	create_local_trace_uprobe(char *name, unsigned long offs,
>  1344				  unsigned long ref_ctr_offset, bool is_return)
>  1345	{
>  1346		struct trace_uprobe *tu;
>  1347		struct path path;
>  1348		int ret;
>  1349=09
>  1350		ret =3D kern_path(name, LOOKUP_FOLLOW, &path);
>  1351		if (ret)
>  1352			return ERR_PTR(ret);
>  1353=09
>  1354		if (!d_is_reg(path.dentry)) {
>  1355			path_put(&path);
>  1356			return ERR_PTR(-EINVAL);
>  1357		}
>  1358=09
>  1359		/*
>  1360		 * local trace_kprobes are not added to probe_list, so they are ne=
ver
>  1361		 * searched in find_trace_kprobe(). Therefore, there is no concern=
 of
>  1362		 * duplicated name "DUMMY_EVENT" here.
>  1363		 */
>  1364		tu =3D alloc_trace_uprobe(UPROBE_EVENT_SYSTEM, "DUMMY_EVENT", 0,
>  1365					is_return);
>  1366=09
>  1367		if (IS_ERR(tu)) {
>  1368			pr_info("Failed to allocate trace_uprobe.(%d)\n",
>  1369				(int)PTR_ERR(tu));
>  1370			path_put(&path);
>  1371			return ERR_CAST(tu);
>  1372		}
>  1373=09
>  1374		tu->offset =3D offs;
>  1375		tu->path =3D path;
>> 1376		tu->ref_ctr_offset =3D ref_ctr_offset;
>  1377		tu->filename =3D kstrdup(name, GFP_KERNEL);
>  1378		init_trace_event_call(tu, &tu->tp.call);
>  1379=09
>  1380		if (set_print_fmt(&tu->tp, is_ret_probe(tu)) < 0) {
>  1381			ret =3D -ENOMEM;
>  1382			goto error;
>  1383		}
>  1384=09
>  1385		return &tu->tp.call;
>  1386	error:
>  1387		free_trace_uprobe(tu);
>  1388		return ERR_PTR(ret);
>  1389	}
>  1390=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.01.org_piper=
mail_kbuild-2Dall&d=3DDwIBAg&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3Di6WobKxbeG3slzH=
SIOxTVtYIJw7qjCE6S0spDTKL-J4&m=3D3vAXcNkXYHALEVsIZG7-ToPCNADLh0bCVwEpureyaa=
w&s=3DeKJR9UoqZ2KCoTN58CznxX7ipOGdcRwG0zWFLsbzHXc&e=3D                   In=
tel Corporation
> <.config.gz>

