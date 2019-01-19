Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A237FC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656762084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b3SLSprA";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Fy7PM1Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfASB7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:59:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42250 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728494AbfASB7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:59:01 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0J1sVax030226;
        Fri, 18 Jan 2019 17:58:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nIlLWaIJcxglDKsLgsb3mcs561bW5zey6OKgO9g+/ps=;
 b=b3SLSprAQ5MA8iS/phbxxbtBcifOx1wiuQ/zQv44XjnsPdaofzQ4fsmJ65EIzWURJK+0
 Z0pXXZSvoSWJ1L58dnDOYeLaFuyAOuUS3skM2T4NHT3k13ZSCI3NbFsXZ6g3svNNgzvC
 CBwMym39RwXlB03Anzaxa352plXN7t//Tcs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q3tjyg0rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Jan 2019 17:58:52 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 18 Jan 2019 17:58:50 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 18 Jan 2019 17:58:50 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 18 Jan 2019 17:58:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIlLWaIJcxglDKsLgsb3mcs561bW5zey6OKgO9g+/ps=;
 b=Fy7PM1Y8JrSA0EWFW5eKmxAWshqrTzT1ihrrR8yk7pSocv8UdE5LCa3Xw0R3p/FnGfzPU3PwpjthyejdWz1HxOewPMpe02c2R9lPkBmnVyrrRKvjBKkAS7qoH3S1iD2i++eHxyJrHiCoThrF3eBwZIHk3OxVxtpkRQ70Y9ZxkHw=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2984.namprd15.prod.outlook.com (20.178.237.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Sat, 19 Jan 2019 01:58:48 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a%5]) with mapi id 15.20.1537.018; Sat, 19 Jan 2019
 01:58:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, oom: fix use-after-free in oom_kill_process
Thread-Topic: [RFC PATCH] mm, oom: fix use-after-free in oom_kill_process
Thread-Index: AQHUr5EBIvKrzcFIzky9cw758RvqYqW11eEA
Date:   Sat, 19 Jan 2019 01:58:48 +0000
Message-ID: <20190119015843.GB15935@castle.DHCP.thefacebook.com>
References: <20190119005022.61321-1-shakeelb@google.com>
In-Reply-To: <20190119005022.61321-1-shakeelb@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:300:103::17) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:fac2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2984;20:m5h8ihvkWKBSwfzUGVEeNeBLEo+By6fy+X1UWZNMfVgt5JqQ1ngtARWl5N25NKR+IbF3ReOGZ0RVSchHkC2l2txl+vM3nDEvo9bcy5DmAxf4QqFSdr4GxiAfPwF0tdtyTwIFmtrnptraeCD1+oWyNJNwbHJLp0V4Z/+EBFiZppo=
x-ms-office365-filtering-correlation-id: 2dfa1b5b-2635-469c-31ed-08d67db1a6e7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2984;
x-ms-traffictypediagnostic: BYAPR15MB2984:
x-microsoft-antispam-prvs: <BYAPR15MB2984E17FB0A424B898BDDB4DBE9D0@BYAPR15MB2984.namprd15.prod.outlook.com>
x-forefront-prvs: 09222B39F5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(6436002)(229853002)(105586002)(14444005)(6916009)(256004)(476003)(4326008)(7736002)(316002)(54906003)(6246003)(9686003)(46003)(305945005)(186003)(5660300001)(6512007)(86362001)(8936002)(76176011)(53936002)(1076003)(71200400001)(2906002)(446003)(81156014)(81166006)(486006)(14454004)(102836004)(71190400001)(25786009)(52116002)(6486002)(386003)(6506007)(106356001)(99286004)(33656002)(8676002)(33896004)(97736004)(68736007)(478600001)(6116002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2984;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MUrwAtVF6YE8WKmfwxMuX3y4ZsAAtebmaram87RD1YVLzHm/cbXy37QOnAM4Fm6NKvIfyNv5kYYPiOwrnvIDoNRY7v6H3wEHCpplK2Itc3SNePmp9yprc3TJEG8RXqrI+44QH5Kd9U8eJXqrBYDyM8FJS+DqQTEQs6ylKJYJbg1nu0E/ox0JA8I54LtPJvdK5SCVx6AcndQUpXPQ5/lAB9F6y+cvjoRB+kTusD7D8gK0Ejk8r1HSok/BQtmGhwgLAx2TYQ1z3N9IB/ANkQqXXc8bpBO6IqWZYtOCRGDAJUEnWA1Rk2Hyup0DiQf/7aAUpddd4fydjY/+G5jkYiLEz7zgg9JCk8mBFPsG2ALt0sI1jgRvxj0bRbEw/y7CZNnbbUEmrNzP1WxrxOMUSMYx6s6KKEMghYfsFm6erV90gqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC4AE722C37E5B4FB770603647BAD67D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfa1b5b-2635-469c-31ed-08d67db1a6e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2019 01:58:47.5011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2984
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-18_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel!

>=20
> On looking further it seems like the process selected to be oom-killed
> has exited even before reaching read_lock(&tasklist_lock) in
> oom_kill_process(). More specifically the tsk->usage is 1 which is due
> to get_task_struct() in oom_evaluate_task() and the put_task_struct
> within for_each_thread() frees the tsk and for_each_thread() tries to
> access the tsk. The easiest fix is to do get/put across the
> for_each_thread() on the selected task.

Please, feel free to add
Reviewed-by: Roman Gushchin <guro@fb.com>
for this part.

>=20
> Now the next question is should we continue with the oom-kill as the
> previously selected task has exited? However before adding more
> complexity and heuristics, let's answer why we even look at the
> children of oom-kill selected task? The select_bad_process() has already
> selected the worst process in the system/memcg. Due to race, the
> selected process might not be the worst at the kill time but does that
> matter matter? The userspace can play with oom_score_adj to prefer
> children to be killed before the parent. I looked at the history but it
> seems like this is there before git history.

I'd totally support you in an attempt to remove this logic,
unless someone has a good example of its usefulness.

I believe it's a very old hack to select children over parents
in case they have the same oom badness (e.g. share most of the memory).

Maybe we can prefer older processes in case of equal oom badness,
and it will be enough.

Thanks!
