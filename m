Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93AEC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A5020851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="chZTxdyr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hzrCmiIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A5020851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeLMVLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:11:51 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43458 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbeLMVLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:11:50 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBDL7TYI000948;
        Thu, 13 Dec 2018 13:11:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DMRNKv4beyTlFQMQHqIw5BrMJRZG353wpvalY8V9Rsg=;
 b=chZTxdyrZ5K5xr6Q7x3jp6ArELmWZQ+Vu55HqQCKR4PdK/21oB8lNa4PrR109nATrT6I
 0Ngf30+fKVtlMfNH5ym7YAhuDRCsbSvnrH5UjozL9ZjvOWNWaMvDUA94IPOIiiY7BDen
 iHAISs8yhPUupeeGL1ZA/dxQ7g6IIBC1Wu8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pbxmmg39v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Dec 2018 13:11:26 -0800
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 13:11:25 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 13 Dec 2018 13:11:25 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 13 Dec 2018 13:11:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMRNKv4beyTlFQMQHqIw5BrMJRZG353wpvalY8V9Rsg=;
 b=hzrCmiIWziEiDpMpFFE0OdEa8OTOo5OohJ8TFb983Fl9qKhcvLdKeOlQRQ60v6Cr5PnEB3ZIDZz6zoPD+/AKq8MUaEyKb9bce0jfwRy7PROU1eGJI0aHC+Kb6sjqZ/AVsMfonlpdLY3m34FeFcsJ5h9Y9dVGtvA1Wxa+kCbVZGg=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1725.namprd15.prod.outlook.com (10.174.254.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 21:11:23 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::14db:7315:30f7:10d7%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 21:11:23 +0000
From:   Martin Lau <kafai@fb.com>
To:     Matt Mullins <mmullins@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: support raw tracepoints in modules
Thread-Topic: [PATCH bpf-next v2] bpf: support raw tracepoints in modules
Thread-Index: AQHUknzQUAdyL61eYUK1z7n4N6HWmKV9DX0AgAAEfICAABnXAA==
Date:   Thu, 13 Dec 2018 21:11:22 +0000
Message-ID: <20181213211120.yyxzecuqrgzeoarb@kafai-mbp>
References: <20181213004237.3888568-1-mmullins@fb.com>
 <20181213192248.ljc6i5unafdlgryf@kafai-mbp>
 <7fcf04f0f46d4a1df98687312bfc607dd7fffb1c.camel@fb.com>
In-Reply-To: <7fcf04f0f46d4a1df98687312bfc607dd7fffb1c.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0033.prod.exchangelabs.com (2603:10b6:300:101::19)
 To MWHPR15MB1790.namprd15.prod.outlook.com (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:47d6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1725;20:a1nqdkHj6bRjiP2t9NvARKdfPGqmfs/ZamqArFo1KbbM7NJApi6g/HxmIoNxWk0pA04rc07VCBl1e0W3Io2XmQNzaELBYvxKSMhAyXBm6RjRgI91NDw0W9DKhpw7BAeQDAkyjqd9T0gCAPo53M3UcPgzxYVKuXUK6iOpX3mFeVY=
x-ms-office365-filtering-correlation-id: 1f8ebde5-d0f8-47a6-8e0e-08d6613f88c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1725;
x-ms-traffictypediagnostic: MWHPR15MB1725:
x-microsoft-antispam-prvs: <MWHPR15MB172595B73AC224FDF16DBD3CD5A00@MWHPR15MB1725.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1725;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(229853002)(53936002)(6512007)(6486002)(9686003)(6506007)(33896004)(6436002)(76176011)(386003)(52116002)(6862004)(14454004)(6246003)(5660300001)(4326008)(7736002)(305945005)(81156014)(71190400001)(186003)(71200400001)(14444005)(81166006)(8676002)(102836004)(68736007)(97736004)(99286004)(5024004)(4001150100001)(486006)(11346002)(446003)(476003)(46003)(6636002)(8936002)(54906003)(86362001)(256004)(3716004)(316002)(25786009)(33716001)(478600001)(106356001)(2906002)(1076002)(105586002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1725;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ONFslDsb87KVIJzCZTYkUhN9h1+tHyWp9jE8cpB5QL4kK33IJoDuWFN5a5ZFquQ4nveiehbjTQjr21Mk0bmof2vhpuLcIFAXP2nlrmIvyw9jnDQcOIJ/L84Mn8XNYAV8uAwDyi0phc0xfIeLcJOt7+yMo6xzj0QiNezTPV8x+tW2pEiiOjviALCno3fgK6pyVPtWiM+DJIReqrqhJAU3bQi+7II6vJecNVfau6Dm1d5STpppLtDwz+GX+b1ihsVaAaEcWRxI47wSXBbRbcfLMjBUnNpfwzH+MsOufrdF3Dn99h63LH1YVyacO9UzYZxw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <874C1F340C745349B4AC676C2B017F29@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8ebde5-d0f8-47a6-8e0e-08d6613f88c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 21:11:23.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1725
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-13_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:38:51AM -0800, Matt Mullins wrote:
> On Thu, 2018-12-13 at 19:22 +0000, Martin Lau wrote:
> > On Wed, Dec 12, 2018 at 04:42:37PM -0800, Matt Mullins wrote:
> > > Distributions build drivers as modules, including network and filesys=
tem
> > > drivers which export numerous tracepoints.  This enables
> > > bpf(BPF_RAW_TRACEPOINT_OPEN) to attach to those tracepoints.
> > >
Acked-by: Martin KaFai Lau <kafai@fb.com>

[ ... ]

> > > +#ifdef CONFIG_MODULES
> > > +int bpf_event_notify(struct notifier_block *nb, unsigned long op, vo=
id *module)
> > > +{
> > > +	struct bpf_trace_module *btm, *tmp;
> > > +	struct module *mod =3D module;
> > > +
> > > +	if (mod->num_bpf_raw_events =3D=3D 0 ||
> > > +	    (op !=3D MODULE_STATE_COMING && op !=3D MODULE_STATE_GOING))
> > > +		return 0;
> > > +
> > > +	mutex_lock(&bpf_module_mutex);
> > > +
> > > +	switch (op) {
> > > +	case MODULE_STATE_COMING:
> > > +		btm =3D kzalloc(sizeof(*btm), GFP_KERNEL);
> > > +		if (btm) {
> > > +			btm->module =3D module;
> > > +			list_add(&btm->list, &bpf_trace_modules);
> > > +		}
> >=20
> > Is it fine to return 0 on !btm case?
>=20
> That effectively just means we'll be ignoring tracepoints for a module
> that is loaded while we can't allocate a bpf_trace_module (24 bytes) to
> track it.  That feels like reasonable behavior to me.
ok.
