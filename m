Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BFBC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 03:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9386206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 03:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="b0BxNxv0";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fCFgzUYq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbeLPDQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 22:16:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37394 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727638AbeLPDQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 22:16:41 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBG37bbS030847;
        Sat, 15 Dec 2018 19:16:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=v7mHmrJoyruv4t/wJY9/YpkO6ETHHLK5dkOUmwtna0I=;
 b=b0BxNxv0kAwsbWH+kP3YNrJj/LL+dxMGBRCgTjC+y3vDDqIZR65GRO/wtTiSGI9jobGX
 8SSvcEF5ZvN6UjBUUodrHUFGYLvF/JFvpnr1LWPQtHMOdBCK/nHYCeTkBk+puLBdkkPA
 oK6sMEw0dA4cPYY6HcjhRWLMBbfLvGtBtoA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pddmd830d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 15 Dec 2018 19:16:28 -0800
Received: from frc-hub06.TheFacebook.com (2620:10d:c021:18::176) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sat, 15 Dec 2018 19:16:27 -0800
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Sat, 15 Dec 2018 19:16:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7mHmrJoyruv4t/wJY9/YpkO6ETHHLK5dkOUmwtna0I=;
 b=fCFgzUYqj6yFGniz1DUYaeQiVGh8i1zxyC88lCHrPB0Yo2LaVYo/0jm1qfC8+wYrxJKlBeg5y7DLnRXHx2SbNRnvSIExLkIAP42tdD2R9pyWgBl4tTO0xNGXIah1pzboLSH6F44iPGXu799dOLAVdD5aWuLZA/iQGmEixwlusK0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2824.namprd15.prod.outlook.com (20.179.158.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Sun, 16 Dec 2018 03:16:06 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 03:16:06 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Rik van Riel <riel@surriel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH] fork,memcg: fix crash in free_thread_stack on memcg
 charge fail
Thread-Topic: [PATCH] fork,memcg: fix crash in free_thread_stack on memcg
 charge fail
Thread-Index: AQHUlC0jCUzvwC1gV06n7eKH1QlfeaWAsv2A
Date:   Sun, 16 Dec 2018 03:16:06 +0000
Message-ID: <20181216031558.GA8627@castle.DHCP.thefacebook.com>
References: <20181214231726.7ee4843c@imladris.surriel.com>
In-Reply-To: <20181214231726.7ee4843c@imladris.surriel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:100::23)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:b77d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2824;20:84bbrgxGQTHtW0x8M85Y8qLhZKEgHJx4h12pKIqsNqfkr4h6/wr5dqT4qjBjMTZdMJubis67LVx8PwHw3qoT/47DpogcDqpf4xlh8+jGB732Unanlr25j3ggCurA3fxDqfQkSGKRQZVAr0i8th7y7XuJnJ6jGn5vXNENEqN+e7g=
x-ms-office365-filtering-correlation-id: 287bfd69-a4d2-4d76-2c35-08d66304d130
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2824;
x-ms-traffictypediagnostic: BYAPR15MB2824:
x-microsoft-antispam-prvs: <BYAPR15MB2824B946196C6D052A1F15F0BEA30@BYAPR15MB2824.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2824;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2824;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(8936002)(446003)(478600001)(11346002)(71200400001)(71190400001)(476003)(5660300001)(97736004)(46003)(6916009)(305945005)(33656002)(575784001)(256004)(25786009)(6116002)(86362001)(6436002)(1076002)(2906002)(229853002)(6486002)(486006)(7736002)(6506007)(386003)(316002)(81166006)(81156014)(99286004)(105586002)(53936002)(14454004)(76176011)(33896004)(52116002)(106356001)(8676002)(68736007)(9686003)(102836004)(4326008)(186003)(6512007)(6246003)(54906003)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2824;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XvDftf+RbF2Zib5D9BlAe/+lhuckdUBwVIMCWqnqoS3BpVFm5KYUoLKTS3mewaIhXwEagi2WXITXEPcrK6gDQs5vcMitiDzlDql9vODc4zwsrBukwmFFBstEKk7OI8CBg8dLuaZN479P+kMAJ3ZJ0ayd+BueepSWfF+RMylwg9vt4TbUJOJCuLz0MJeM4HGXWekQMKb1XtD8VNHNODQZ7KcX+AJ+sivERvhBLveaUpuUGPX3F5q9SlFlXfPxhW/QTfv5pgWHKNV/vIuh12Bk+Lmdr65BYf7z45asXFOz/dJMt6tNYOC6vienUQCCFhj9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30CF8041DF09AB4988F50E631CABA187@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 287bfd69-a4d2-4d76-2c35-08d66304d130
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 03:16:06.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2824
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-16_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:17:26PM -0500, Rik van Riel wrote:
> Changeset 9b6f7e163cd0 ("mm: rework memcg kernel stack accounting")
> will result in fork failing if allocating a kernel stack for a task
> in dup_task_struct exceeds the kernel memory allowance for that cgroup.
>=20
> Unfortunately, it also results in a crash.
>=20
> This is due to the code jumping to free_stack and calling free_thread_sta=
ck
> when the memcg kernel stack charge fails, but without tsk->stack pointing
> at the freshly allocated stack.
>=20
> This in turn results in the vfree_atomic in free_thread_stack oopsing
> with a backtrace like this:
>=20
> #5 [ffffc900244efc88] die at ffffffff8101f0ab
>  #6 [ffffc900244efcb8] do_general_protection at ffffffff8101cb86
>  #7 [ffffc900244efce0] general_protection at ffffffff818ff082
>     [exception RIP: llist_add_batch+7]
>     RIP: ffffffff8150d487  RSP: ffffc900244efd98  RFLAGS: 00010282
>     RAX: 0000000000000000  RBX: ffff88085ef55980  RCX: 0000000000000000
>     RDX: ffff88085ef55980  RSI: 343834343531203a  RDI: 343834343531203a
>     RBP: ffffc900244efd98   R8: 0000000000000001   R9: ffff8808578c3600
>     R10: 0000000000000000  R11: 0000000000000001  R12: ffff88029f6c21c0
>     R13: 0000000000000286  R14: ffff880147759b00  R15: 0000000000000000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #8 [ffffc900244efda0] vfree_atomic at ffffffff811df2c7
>  #9 [ffffc900244efdb8] copy_process at ffffffff81086e37
> #10 [ffffc900244efe98] _do_fork at ffffffff810884e0
> #11 [ffffc900244eff10] sys_vfork at ffffffff810887ff
> #12 [ffffc900244eff20] do_syscall_64 at ffffffff81002a43
>     RIP: 000000000049b948  RSP: 00007ffcdb307830  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 0000000000896030  RCX: 000000000049b948
>     RDX: 0000000000000000  RSI: 00007ffcdb307790  RDI: 00000000005d7421
>     RBP: 000000000067370f   R8: 00007ffcdb3077b0   R9: 000000000001ed00
>     R10: 0000000000000008  R11: 0000000000000246  R12: 0000000000000040
>     R13: 000000000000000f  R14: 0000000000000000  R15: 000000000088d018
>     ORIG_RAX: 000000000000003a  CS: 0033  SS: 002b
>=20
> The simplest fix is to assign tsk->stack right where it is allocated.

Good catch!

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
