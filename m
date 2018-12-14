Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C10C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BE7206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="T89eYwSS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Wo3/baEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbeLNSpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:45:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730551AbeLNSpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:45:05 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id wBEId1jg024328;
        Fri, 14 Dec 2018 10:44:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rVnsgm8dNnV62+/Hi195se0WYqwvl6MXewvAPclDQ2A=;
 b=T89eYwSSH4qmfd2VZsAA3vqmkhNjIHEaLjX9aqtbNVcQtgeCFeQUC66C/7qpuVD46/yg
 uxj9XOvMeQZmPWKOQyY1C86yhJsWwoMsyZJvEhKcoXY7qcdS5Ez4f/LoKkGdq99Ar0/f
 MNvC9LcJegCR+/PnbWkIis/3tBKj0Nng8do= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2pcf3urn2n-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 14 Dec 2018 10:44:25 -0800
Received: from frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 10:42:53 -0800
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-mbx04.TheFacebook.com (2620:10d:c0a1:f82::28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 14 Dec 2018 10:42:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Fri, 14 Dec 2018 10:42:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVnsgm8dNnV62+/Hi195se0WYqwvl6MXewvAPclDQ2A=;
 b=Wo3/baEfTwZl8yHA8Cmvp2/aGEmDEb2hfp96ZCytFM/NslnOMLlytCs6PFz+YNj2uhygLt+WsL4vLexPaHTQJqIFNvc29h6z/4kyKd/yai8p7Fkr9LwA8+ERQLyRODFXLorQLaeBwYuytaK5nzVTuNbXQwMGcbYOTpgm+xLP07I=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2486.namprd15.prod.outlook.com (52.135.198.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 18:42:51 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::990:c2e0:2a8a:25c5%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 18:42:50 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [RFC 4/4] mm: show number of vmalloc pages in /proc/meminfo
Thread-Topic: [RFC 4/4] mm: show number of vmalloc pages in /proc/meminfo
Thread-Index: AQHUk9fwHbb0L9+OPECvwJSLy1gAbKV+jhgAgAAD1AA=
Date:   Fri, 14 Dec 2018 18:42:50 +0000
Message-ID: <20181214184244.GA5196@castle.DHCP.thefacebook.com>
References: <20181214180720.32040-1-guro@fb.com>
 <20181214180720.32040-5-guro@fb.com>
 <20181214182904.GE10600@bombadil.infradead.org>
In-Reply-To: <20181214182904.GE10600@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:104:4::19) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:bff6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2486;20:FxCsvYH0lYKgYp/pdwPHbZMuTRArvcHnFKi3fdI7HYH2KE9uSuBff6OoqGOpX0H4vOklV8DCgEq7XtaqxpO9h68yONV60Qb81kMpqvUHAp3ZF8KJcnEF72tqlvdF9vKSVr2evekxvrFhhadki8I93nNPNS0r7x5qhxpgqKpy018=
x-ms-office365-filtering-correlation-id: e4e3c4a9-93a1-47c4-f1fd-08d661f3f331
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2486;
x-ms-traffictypediagnostic: BYAPR15MB2486:
x-microsoft-antispam-prvs: <BYAPR15MB24866637A3936D7E2C0BC158BEA10@BYAPR15MB2486.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(11241501185)(6040522)(2401047)(8121501046)(5005006)(823302103)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR15MB2486;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2486;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(6306002)(53936002)(305945005)(33656002)(9686003)(6512007)(52116002)(229853002)(7736002)(6246003)(6916009)(2906002)(102836004)(476003)(33896004)(11346002)(446003)(966005)(8936002)(8676002)(106356001)(105586002)(486006)(81166006)(81156014)(14454004)(186003)(76176011)(99286004)(5660300001)(39060400002)(386003)(6506007)(4326008)(25786009)(1076002)(14444005)(256004)(6116002)(86362001)(46003)(97736004)(316002)(71200400001)(54906003)(71190400001)(6486002)(478600001)(68736007)(6436002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2486;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3UTtQ8h5c+QF+HpNsCYyBO3tAVqQ7L+dKWVh0zel4eecqsLdWfVNADguth6AgFgo0wfn17EJt0BIKiPMUGVhf3z/hw5OXBtnyh8h1W2BqKxNiSGa+1V2/B2yGy9NzU+ToSzSCqEZ1ieO9XdYjlGuPRlFlmImGa4JdZmg86Dau8d7nZPpvNhtwoXm0U2P4C8+SYxQ0VwoZ6A58ZgTI4yAKQAqmDdTpqFvM9mb0bMGiGeAR0g3ScxBPPZW49HZrSFLPnD4nG4iw1bYW3T/lHCBwXcXhPel9LI6dD5CNSaxkPc3hG23m/DjN8x1os82LrrZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8AD0CC77F4BD34387B5096E9F03B38D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e3c4a9-93a1-47c4-f1fd-08d661f3f331
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 18:42:50.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2486
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:29:04AM -0800, Matthew Wilcox wrote:
> On Fri, Dec 14, 2018 at 10:07:20AM -0800, Roman Gushchin wrote:
> > Vmalloc() is getting more and more used these days (kernel stacks,
> > bpf and percpu allocator are new top users), and the total %
> > of memory consumed by vmalloc() can be pretty significant
> > and changes dynamically.
> >=20
> > /proc/meminfo is the best place to display this information:
> > its top goal is to show top consumers of the memory.
> >=20
> > Since the VmallocUsed field in /proc/meminfo is not in use
> > for quite a long time (it has been defined to 0 by the
> > commit a5ad88ce8c7f ("mm: get rid of 'vmalloc_info' from
> > /proc/meminfo")), let's reuse it for showing the actual
> > physical memory consumption of vmalloc().
>=20
> Do you see significant contention on nr_vmalloc_pages?  Also, if it's
> just an atomic_long_t, is it worth having an accessor for it?  And if
> it is worth having an accessor for it, then it can be static.

Not really, so I decided that per-cpu counter is an overkill
right now; but we can easily switch over once we'll notice any contention.
Will add static.

>=20
> Also, I seem to be missing 3/4.
>=20

Hm, https://lkml.org/lkml/2018/12/14/1048 ?

Thanks!
