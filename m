Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2135D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AeN7Fnht";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kv4Z2mH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfBUWYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:24:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42492 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbfBUWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:24:31 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1LMJdZC008855;
        Thu, 21 Feb 2019 14:24:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Epl5XOyFfHbV0p4MSOpDhXw96DWq4yeVkjdAajAGX/w=;
 b=AeN7FnhtcQYtpm7T3jSPVH9nFKZxjJEhXkzQYaRjYmwaA/QP3mhL7h03WINAuLlAs4+r
 aq1lOl8k0UFzKjALaF/I2wPQMc4+eUW7Xht6NCobAjUZ3fRSOPmluwIDTnmWjo81XYHn
 Ew0MOjotePlWVVpBavPvWHteuKyyuGyRGGs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2qt1nsrnkh-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Feb 2019 14:24:03 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 21 Feb 2019 14:24:00 -0800
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 21 Feb 2019 14:24:00 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 21 Feb 2019 14:23:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Epl5XOyFfHbV0p4MSOpDhXw96DWq4yeVkjdAajAGX/w=;
 b=kv4Z2mH2td2k9Wk+bYlxTmOfbpDkupvPxOJaxAlycCMHHYJPX6SclNcCRtB8caoocPElbO6tutcFnIiD+fanhrBcBorL0G9EOwROB1XVwZTmttMK/06A+ptAK/A7gVpYYP3QjQ59wCjdqCbtksG1jLgmx5tywwoWpEwZsOS0Aj0=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1295.namprd15.prod.outlook.com (10.175.3.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 22:23:58 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::ac2f:bf87:54e:48a2%12]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 22:23:58 +0000
From:   Martin Lau <kafai@fb.com>
To:     Alban Crequy <alban.crequy@gmail.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alban@kinvolk.io" <alban@kinvolk.io>,
        "iago@kinvolk.io" <iago@kinvolk.io>,
        Craig Gallek <kraig@google.com>
Subject: Re: [PATCH bpf-next v1] bpf, lpm: fix lookup bug in map_delete_elem
Thread-Topic: [PATCH bpf-next v1] bpf, lpm: fix lookup bug in map_delete_elem
Thread-Index: AQHUygQlhnaFWKZBg0GeAn9mNGwt5KXq1DQA
Date:   Thu, 21 Feb 2019 22:23:57 +0000
Message-ID: <20190221222350.6u2jbtias2c3mgyy@kafai-mbp.dhcp.thefacebook.com>
References: <20190221163926.15221-1-alban@kinvolk.io>
In-Reply-To: <20190221163926.15221-1-alban@kinvolk.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To MWHPR15MB1790.namprd15.prod.outlook.com (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:9033]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd598e11-1f2f-4c9f-9e08-08d6984b4565
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1295;
x-ms-traffictypediagnostic: MWHPR15MB1295:
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1295;20:kaT9BHIJWpSG8vSWwkzEVbTagtnT4XujAIWcCX0vjQC3Hg8mT8Od4qipxttxuzumzouyJOo9025ggpHApikx7nZs4A/YtVXrzrzItVOrovOQfrgtAC34IGZlccHvjz0+karBmIcDvDGEVu3PdWs6Rve/D2/WEzflFmQx8MjoEWs=
x-microsoft-antispam-prvs: <MWHPR15MB12958409FE7E477293F927D6D57E0@MWHPR15MB1295.namprd15.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(1076003)(46003)(76176011)(14454004)(6116002)(52116002)(478600001)(8936002)(68736007)(99286004)(97736004)(6506007)(386003)(54906003)(11346002)(25786009)(6246003)(446003)(476003)(33896004)(6436002)(486006)(2906002)(102836004)(316002)(86362001)(6486002)(6512007)(9686003)(81166006)(8676002)(6916009)(7736002)(4326008)(71200400001)(105586002)(71190400001)(106356001)(305945005)(229853002)(81156014)(256004)(14444005)(186003)(53936002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1295;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V/WC2wXtnCemQ1L2gZza4dXUvF6Zoepsy8JtqwhO2zdpzENWB5uP+LjugQMGhEVCkqbVnKpn0gGYbMklgstgcaKzxoYnjift5ijMdFGYjaenFaYRYhsHdx23eS9a/EXjdrZfVyOILU0+drSb1Hc2hjvAB0Sc2umjsmm4bDQ95egZzMuLOkYmK/wfyqQBZpp2UsvcrVpEDjmBNv1xfkxHBO8JB3QToE85U60yZOlbTyPk/0dbhYSsy4uz6Orrp5/gbG3N/8ma7+gm3HIDXaAingOLWcv6BbIHKEJEnaoiIwQgzql2jotmwTJbRtuvjywAj5srMUsgyuvCoXKbTdcWAbK2uq+Q7inM+DPEcDjb51gtAQjLNdx6qv42g1tAd5x0yosLJn4aQh6F8Wz/WlLHeBfgcma7sGi00cqwp2Ab2V0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7BA84E2E76C7C44B88842771E88A026@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd598e11-1f2f-4c9f-9e08-08d6984b4565
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 22:23:56.7445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1295
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 05:39:26PM +0100, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
>=20
> trie_delete_elem() was deleting an entry even though it was not matching
> if the prefixlen was correct. This patch adds a check on matchlen.
>=20
> Reproducer:
>=20
> $ sudo bpftool map create /sys/fs/bpf/mylpm type lpm_trie key 8 value 1 e=
ntries 128 name mylpm flags 1
> $ sudo bpftool map update pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 aa=
 bb cc dd value hex 01
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> key: 10 00 00 00 aa bb cc dd  value: 01
> Found 1 element
> $ sudo bpftool map delete pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 ff=
 ff ff ff
> $ echo $?
> 0
> $ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
> Found 0 elements
The change makes sense to me.  Can you add this reproducer to
tools/testing/selftests/bpf/test_lpm_map.c?

Bug fix should be for the "bpf" tree instead of "bpf-next"
Fixes tag is also required, like

Fixes: e454cf595853 ("bpf: Implement map_delete_elem for BPF_MAP_TYPE_LPM_T=
RIE")
Cc: Craig Gallek <kraig@google.com>

>=20
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  kernel/bpf/lpm_trie.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> index abf1002080df..93a5cbbde421 100644
> --- a/kernel/bpf/lpm_trie.c
> +++ b/kernel/bpf/lpm_trie.c
> @@ -471,6 +471,7 @@ static int trie_delete_elem(struct bpf_map *map, void=
 *_key)
>  	}
> =20
>  	if (!node || node->prefixlen !=3D key->prefixlen ||
> +	    node->prefixlen !=3D matchlen ||
>  	    (node->flags & LPM_TREE_NODE_FLAG_IM)) {
>  		ret =3D -ENOENT;
>  		goto out;
> --=20
> 2.20.1
>=20
