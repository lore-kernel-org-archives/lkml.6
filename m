Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD70C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AD72064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cViGrbZ1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="TqsluMfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AD72064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeJWAAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:00:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbeJWAAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:00:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MFcSkW020885;
        Mon, 22 Oct 2018 08:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SJnrOplNVsxfwNjKUQJi4fuALyuxjUgD2Op4hOpWM5o=;
 b=cViGrbZ1CQ/pZ/Oa+7FX8L5EFbsPGeEvuCgezvlXRrBNrr1HlS1bnlONQceJGdJDjoH3
 415hUHS0Swxrx4Zq8ldcIBP3HERr6cwwnxuQbj+hJUMORLsemFrtI9CIosiM4PvGr7ML
 hIxSDktvd2PSBqQNWHS7fRaQG9V5uFW9FYI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n9h70r1af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Oct 2018 08:40:39 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 22 Oct 2018 08:40:38 -0700
Received: from PRN-CHUB03.TheFacebook.com (2620:10d:c081:35::12) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 22 Oct 2018 08:40:38 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.13) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 22 Oct 2018 08:40:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJnrOplNVsxfwNjKUQJi4fuALyuxjUgD2Op4hOpWM5o=;
 b=TqsluMfWK+I8ABtnXTPgqNcH/i9i09prbGtphcPz7N+ul07RxXyfKtDgSzp7KnzTrN8pLVFwLc5nxA0gkIGCbs0OCF+a2YZThFBfFlZsUOfmq/sY8mkLotb2k+d0vXfq2jxNkXGiTpJBpfZ3TMkqK+wRVIkTP2ECCxOvBCfXmRw=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1744.namprd15.prod.outlook.com (10.174.255.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 15:40:36 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::c56f:45c:1647:a419%3]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 15:40:36 +0000
From:   Martin Lau <kafai@fb.com>
To:     Wenwen Wang <wang6495@umn.edu>
CC:     Kangjie Lu <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: btf: Fix a missing-check bug
Thread-Topic: [PATCH] bpf: btf: Fix a missing-check bug
Thread-Index: AQHUZ/tT5hcL8cX3YUmTKQXXW/AX8KUrayyA
Date:   Mon, 22 Oct 2018 15:40:35 +0000
Message-ID: <20181022154033.yrooopuhoct3vn4x@kafai-mbp.dhcp.thefacebook.com>
References: <1539988191-13973-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1539988191-13973-1-git-send-email-wang6495@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:300:13d::29) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:ac3f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1744;20:129hPTT/u6QORrej5bTA9RqDeDb1VbR/TDTjGs4z17CkRo2ZVCsqqfTOC8bkQuTq7evDC8mzdHug1t5NCfRJKKflaTmMeF94AwdthAWU0fJk6zuBtkJF4K6fr26CHO0QWs0Vh16x9JsARsdLedw21D+5RnWO5v6KAD808gQTJ3s=
x-ms-office365-filtering-correlation-id: ec095717-94c7-4db7-5f03-08d63834b541
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1744;
x-ms-traffictypediagnostic: MWHPR15MB1744:
x-microsoft-antispam-prvs: <MWHPR15MB174421415761DD8FFEBB9F0CD5F40@MWHPR15MB1744.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1744;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1744;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(136003)(396003)(189003)(199004)(102836004)(6436002)(486006)(86362001)(386003)(6506007)(9686003)(46003)(476003)(68736007)(229853002)(11346002)(52116002)(446003)(6512007)(71200400001)(2900100001)(6246003)(99286004)(81166006)(81156014)(71190400001)(6486002)(6916009)(2171002)(76176011)(33896004)(8676002)(106356001)(14444005)(256004)(105586002)(316002)(54906003)(186003)(5250100002)(8936002)(53936002)(2906002)(5660300001)(1076002)(6116002)(97736004)(305945005)(14454004)(7736002)(25786009)(478600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1744;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ILIRv1xtzgjDoyGbIuQdFSDeVPkj/Vux5N365a3Zx9fc9SBMFfbxVjmIj4uR1i3tPOVMmbyB7e/EZEFuq/6REQ/Z6pzyTjMazx5NxXYmqEvafEZ87Ovu+FQs+7D3tMlXRVEjvYCm7ZaMDkT3jv8xauig+sg8sV8nyqbjSasajuPN6bfyBzg7HqDgkhuFo0ucWPyn9+DlTBJaAZncIZ5J5yxNb3nS67ELl5hqOTqlK9T2ftvS8qR70JDqKQIUXH4Bn+BFaTbilv7eW2be5FKeT2tQtWf+5CItyB+NbZY72UIACsLQwvPkHv4WXKYL41Z4VT916aSMezyn3ddx5pyAb0znMKqSbjbTjdCHAj4ZIvM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0A34A0248310C449D89013B5BF276D4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec095717-94c7-4db7-5f03-08d63834b541
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 15:40:35.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1744
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 05:29:51PM -0500, Wenwen Wang wrote:
> In btf_parse(), the header of the user-space btf data 'btf_data' is first=
ly
> parsed and verified through btf_parse_hdr(). In btf_parse_hdr(), the head=
er
> is copied from user-space 'btf_data' to kernel-space 'btf->hdr' and then
> verified. If no error happens during the verification process, the whole
> data of 'btf_data', including the header, is then copied to 'data' in
> btf_parse(). It is obvious that the header is copied twice here. More
> importantly, no check is enforced after the second copy to make sure the
> headers obtained in these two copies are same. Given that 'btf_data'
> resides in the user space, a malicious user can race to modify the header
> between these two copies. By doing so, the user can inject inconsistent
> data, which can cause undefined behavior of the kernel and introduce
> potential security risk.
>=20
> To avoid the above issue, this patch rewrites the header after the second
> copy, using 'btf->hdr', which is obtained in the first copy.
Acked-by: Martin KaFai Lau <kafai@fb.com>
