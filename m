Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB113C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A9F2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hx0Nsqtr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Hbad+BPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A9F2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeKFLLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:11:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40982 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbeKFLLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:11:11 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA61dtFf032248;
        Mon, 5 Nov 2018 17:48:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QfAWQLeZG3Bok2qNqfkA7pz+Y3vLzqI22swDpXGgvTE=;
 b=hx0NsqtrY1tULo2D3Z1qOv2Aehnu00PGCasg9eZRDVHQ9LpZrKLxEh9QKItzQLxysKdU
 mfSpbdS8k0ytVmAT1qvm4e7bQq6bCGvJ8PPeHKAWhFObnT6BTi4BfjTo0H/5cHC3ONVx
 hudpw92VvX49l0y1iUV5D/BG6TWdv9JmYhQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2njxsq971f-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Nov 2018 17:48:20 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 5 Nov 2018 17:47:55 -0800
Received: from PRN-CHUB10.TheFacebook.com (2620:10d:c081:35::19) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 5 Nov 2018 17:47:55 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 5 Nov 2018 17:47:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfAWQLeZG3Bok2qNqfkA7pz+Y3vLzqI22swDpXGgvTE=;
 b=Hbad+BPK6wMiVkK+bsV0BmirJgw8rHYVBpQbhh0TCQsdx0CG2e/Ln3zYTWwbCp666TG/nUx8DFrYwl2pR2ZqQHoFjjts3NHC2sHO3xdYSAETAyv6po4JnOYIlVqtVvtbFZ9N1Uw+2riUDvpk4aPzyxDwnqj/1GK7OkTY1GnymUE=
Received: from BY1PR15MB0072.namprd15.prod.outlook.com (10.161.97.153) by
 BY1PR15MB0072.namprd15.prod.outlook.com (10.161.97.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 01:47:52 +0000
Received: from BY1PR15MB0072.namprd15.prod.outlook.com
 ([fe80::b526:fa51:eb41:38c1]) by BY1PR15MB0072.namprd15.prod.outlook.com
 ([fe80::b526:fa51:eb41:38c1%7]) with mapi id 15.20.1294.028; Tue, 6 Nov 2018
 01:47:52 +0000
From:   Yonghong Song <yhs@fb.com>
To:     kernel test robot <rong.a.chen@intel.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "lkp@01.org" <lkp@01.org>
Subject: Re: [LKP] [tools/bpf] f6f3bac08f: stderr.failed_to_prepare_for_bpf
Thread-Topic: [LKP] [tools/bpf] f6f3bac08f: stderr.failed_to_prepare_for_bpf
Thread-Index: AQHUdXK6kG2P7/thukucGCoE4QIYVg==
Date:   Tue, 6 Nov 2018 01:47:52 +0000
Message-ID: <ad890bee-0cce-c2fd-c1a4-900c928d82f0@fb.com>
References: <20181105053635.GS24195@shao2-debian>
In-Reply-To: <20181105053635.GS24195@shao2-debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0046.namprd20.prod.outlook.com
 (2603:10b6:300:ed::32) To BY1PR15MB0072.namprd15.prod.outlook.com
 (2a01:111:e400:507c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:d981]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY1PR15MB0072;20:0GoPL/YtWtjBLZ/cq9G/xua1/fsrxkSBotYsJsVYRH1LHu9a07ukb27iuAeWC7/EMgRKpC3+Z+spuM6YtXc1wXO753XlaRjyvL+X77nBSnng2KSklPK2snVzBHAK6TlHLfBahGw9gQ1IO71BFIKfC+jSwvpz2cLfuO26sJhFwvQ=
x-ms-office365-filtering-correlation-id: d007db4c-7b93-4b13-ae4c-08d64389dd17
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY1PR15MB0072;
x-ms-traffictypediagnostic: BY1PR15MB0072:
x-microsoft-antispam-prvs: <BY1PR15MB00729FFAB32A5B3E99B0DCB7D3CB0@BY1PR15MB0072.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150)(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231382)(11241501184)(944501410)(52105095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY1PR15MB0072;BCL:0;PCL:0;RULEID:;SRVR:BY1PR15MB0072;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(69234005)(31686004)(46003)(229853002)(25786009)(106356001)(11346002)(446003)(97736004)(14454004)(256004)(105586002)(14444005)(6306002)(6512007)(5024004)(53936002)(2900100001)(2906002)(68736007)(966005)(6116002)(52116002)(53546011)(6506007)(386003)(36756003)(7736002)(305945005)(54906003)(99286004)(316002)(6436002)(486006)(186003)(4326008)(476003)(71200400001)(102836004)(81166006)(81156014)(6246003)(8676002)(71190400001)(6916009)(6486002)(2616005)(31696002)(76176011)(5660300001)(478600001)(8936002)(86362001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR15MB0072;H:BY1PR15MB0072.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KKpTNVrs7gP/qoBSOXq+AIsrOAnzqBlCajafiG+u4uT2xxChUYZ5C6C3817UbfE7fSTTJMlbQre572G13PYcQs6tyQKqFgl/FqNExeNMwMeqFjtSnFGyOj+hmR1ZJlz3VEpjwzICavlE6UhyzsQglkBnzf9FRdqS5puP03t2XvaATMDMqvsXSVcHTz9V9MleXmVRKFYsjvM8mLvAcs9RP0VxmECTcCmLXO4/g2hABMtbDOFvHzA+c6uSzoxgTVxqpmEHDZtBI7VK5k+iDQurGBJb+KcjFwrCdu/aDREnN7qzTWPCmgJ0ZgiPrCgcgch3gCD61Nupy/ReMmNTvDGbGXAESE7aJJXIcyVPaTlfz7c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FCB4A6B0C73FDA4DA1E9489962A9D872@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d007db4c-7b93-4b13-ae4c-08d64389dd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 01:47:52.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB0072
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I cannot reproduce in my local fc28 system with the attached steps.

The netlink_dumper.c file, could you confirm whether the following=20
header files are missing form you rhel-7.2 host?

#include <linux/rtnetlink.h>
#include <linux/tc_act/tc_bpf.h>

I suspect you probably miss linux/tc_act/tc_bpf.h. But could you confirm=20
it? If this is the case, I can fix the problem by adding tc_bpf.h into
tools/include/uapi directory.

Thanks,

Yonghong


On 11/4/18 9:36 PM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: f6f3bac08ff9855d803081a353a1fafaa8845739 ("tools/bpf: bpftool: ad=
d net support")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> in testcase: bpf_offload
> with following parameters:
>=20
> 	ucode: 0xb00002e
>=20
>=20
>=20
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz wit=
h 64G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
>=20
>=20
> KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel=
-7.2-f6f3bac08ff9855d803081a353a1fafaa8845739
> 2018-11-03 10:11:02 cd /usr/src/linux-selftests-x86_64-rhel-7.2-f6f3bac08=
ff9855d803081a353a1fafaa8845739/tools/testing/selftests
> 2018-11-03 10:11:02 ln -sf /usr/bin/clang-7 /usr/bin/clang
> 2018-11-03 10:11:02 ln -sf /usr/bin/llc-7 /usr/bin/llc
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3bac=
08ff9855d803081a353a1fafaa8845739/tools/bpf'
>=20
> Auto-detecting system features:
> ...                        libbfd: [ =1B[31mOFF=1B[m ]
> ...        disassembler-four-args: [ =1B[31mOFF=1B[m ]
>=20
>    CC       bpf_jit_disasm.o
>    LINK     bpf_jit_disasm
>    CC       bpf_dbg.o
>    LINK     bpf_dbg
>    CC       bpf_asm.o
>    BISON    bpf_exp.yacc.c
>    CC       bpf_exp.yacc.o
>    FLEX     bpf_exp.lex.c
>    CC       bpf_exp.lex.o
>    LINK     bpf_asm
>    DESCEND  bpftool
> make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3=
bac08ff9855d803081a353a1fafaa8845739/tools/bpf/bpftool'
>=20
> Auto-detecting system features:
> ...                        libbfd: [ =1B[31mOFF=1B[m ]
> ...        disassembler-four-args: [ =1B[31mOFF=1B[m ]
>=20
>    CC       map_perf_ring.o
>    CC       xlated_dumper.o
>    CC       perf.o
>    CC       prog.o
>    CC       btf_dumper.o
>    CC       net.o
>    CC       netlink_dumper.o
> Makefile:96: recipe for target 'netlink_dumper.o' failed
> make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3b=
ac08ff9855d803081a353a1fafaa8845739/tools/bpf/bpftool'
> Makefile:99: recipe for target 'bpftool' failed
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.2-f6f3bac0=
8ff9855d803081a353a1fafaa8845739/tools/bpf'
>=20
>=20
>=20
> To reproduce:
>=20
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
>=20
>=20
>=20
> Thanks,
> Rong Chen
>=20
