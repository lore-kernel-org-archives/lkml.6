Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AEAECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC8821470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Lyx1XKrn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ctlf3pne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC8821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeJTGyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:54:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbeJTGyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:54:15 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JMhQW4029139;
        Fri, 19 Oct 2018 15:44:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TIiYhEFWk8jaEcsr1QSsmvy3P2fRygFBge1qKPlFFGo=;
 b=Lyx1XKrnIXNHVIqlygbG+hkxoKZJAYzTRnqZvaBVU4uUJYUMAbEjZcQeRWmiEcLskxpb
 C9HHoBehPmanZN6tOfdwtqok3BfoZKUa2LDe+ic0W8D13Hz+pt4l9I+JLVAcSZQjRQe9
 sSnZ/hpKBWZDzPVEG65nKrYXbuBj/3ZIFxE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n7n280k73-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Oct 2018 15:44:54 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 19 Oct 2018 15:44:46 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 19 Oct 2018 15:44:46 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.12) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 19 Oct 2018 15:44:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIiYhEFWk8jaEcsr1QSsmvy3P2fRygFBge1qKPlFFGo=;
 b=Ctlf3pneW7FUxugo9/7L6+3Ze86RssfqSdrVQpr6SkOvxIsjfWTNbDi3q0HAOJKeyUDSv+c8Elf1/Xg7oRuKFla8YpLvor3lFqNIxEBiLJDmZUKvET3nngyKmZsmQ9X7FydmvMPCWXZMbTFfBGtc3S4+6qJ43KbW+qAA7qMbZwI=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0261.namprd15.prod.outlook.com (10.163.64.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.25; Fri, 19 Oct 2018 22:44:39 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::19fd:7871:6103:1dba%5]) with mapi id 15.20.1228.027; Fri, 19 Oct 2018
 22:44:39 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Thomas Garnier" <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Thread-Topic: [RFC PATCH 0/2] improve vmalloc allocation
Thread-Index: AQHUZ9Iyiyhkunqa/karKPeBZ8/0v6UnKvgA
Date:   Fri, 19 Oct 2018 22:44:39 +0000
Message-ID: <20181019224432.GA616@tower.DHCP.thefacebook.com>
References: <20181019173538.590-1-urezki@gmail.com>
In-Reply-To: <20181019173538.590-1-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0018.namprd17.prod.outlook.com
 (2603:10b6:301:14::28) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:b47f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0261;20:gsqwLZzzqlMQrW6vZyGYILW8KJKvOyZqgp1qLwGtSmPvbOEh7YF8Fng9SJtj1HcTYLPF3f6QNjUBbstiPGaBgo/useO2eJ9a8XzMAjfRPRNfmr3TQRy1a2L2UWOihdLASTR7bQQelPhNlcasCI/zH7PkjZ8kYJZXQK0lv2B3LHI=
x-ms-office365-filtering-correlation-id: 3f18de96-0378-4c2a-bf23-08d636147368
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0261;
x-ms-traffictypediagnostic: BY2PR15MB0261:
x-microsoft-antispam-prvs: <BY2PR15MB026166BDBF81D9E9C0BDE8D2BEF90@BY2PR15MB0261.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0261;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0261;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(33896004)(4326008)(9686003)(1411001)(14454004)(68736007)(33656002)(6246003)(6916009)(99286004)(6512007)(76176011)(97736004)(52116002)(217873002)(5660300001)(5250100002)(8936002)(386003)(6506007)(81156014)(8676002)(6436002)(478600001)(256004)(25786009)(229853002)(53936002)(39060400002)(6486002)(46003)(2900100001)(71190400001)(11346002)(86362001)(446003)(102836004)(476003)(54906003)(81166006)(486006)(186003)(71200400001)(7416002)(305945005)(7736002)(6116002)(316002)(105586002)(1076002)(2906002)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0261;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aS/O7Fr6/YQ1rcFJHyJnTMNDcy7NgFpTmP3BEQXMV8L7K6BP0lHhRccieJaWLAB9xAuXPUO/F2MPxj9LqIrDdKSzWWjLVORNY7gnqokr5vQCo3vkay55/VyuuoMJMxwdlap16sWESm6YgU7stYoTdK7ikqi9Zt6hTO+491sigMV7C3XmtrSivs1d1DEhCPFtkBG2kJesw9RTkGh8Aw9YG8anJjAuUl6KSB/7A+vEAGpnCjRqxKRdJddoci9YR3NTiN1qt8H10OzlndAD12G5M2fhyyLJbDq83tE7ktaDkcb7wEPYQff/vdwiFa3XmNEdIuuDxhX5XxgKOP6pYdtmzaFBDi4vOqm/stspskFTXio=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C67FFCE1E1F254D917A38028823A9C3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f18de96-0378-4c2a-bf23-08d636147368
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 22:44:39.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0261
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 07:35:36PM +0200, Uladzislau Rezki (Sony) wrote:
> Objective
> ---------
> Initiative of improving vmalloc allocator comes from getting many issues
> related to allocation time, i.e. sometimes it is terribly slow. As a resu=
lt
> many workloads which are sensitive for long (more than 1 millisecond) pre=
emption
> off scenario are affected by that slowness(test cases like UI or audio, e=
tc.).
>=20
> The problem is that, currently an allocation of the new VA area is done o=
ver
> busy list iteration until a suitable hole is found between two busy areas=
.
> Therefore each new allocation causes the list being grown. Due to long li=
st
> and different permissive parameters an allocation can take a long time on
> embedded devices(milliseconds).
...
> 3) This one is related to PCPU allocator(see pcpu_alloc_test()). In that
> stress test case i see that SUnreclaim(/proc/meminfo) parameter gets incr=
eased,
> i.e. there is a memory leek somewhere in percpu allocator. It sounds like
> a memory that is allocated by pcpu_get_vm_areas() sometimes is not freed.
> Resulting in memory leaking or "Kernel panic":
>=20

Can you, please, try the following patch:
6685b357363b ("percpu: stop leaking bitmap metadata blocks") ?

BTW, with growing number of vmalloc users (per-cpu allocator and bpf stuff =
are
big drivers), I find the patchset very interesting.

Thanks!
