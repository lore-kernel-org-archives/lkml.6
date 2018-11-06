Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5743C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787402083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="WHGbsBzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787402083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeKGGTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:19:03 -0500
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:20757
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726547AbeKGGTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlomCDKuD+JEvlOdfOJop55cG554qqznaPrnwm/VU/s=;
 b=WHGbsBzI0NWrzff17Jwpy3hnNF7kYVT5JRTGrQzGa1cod0XatkcptizvL2m6bowEZDY5vpOiInlB1vEx8jv3E1HOVXPkbeu2ahB15WmzBmDLQBUdORuwSxZGjA4UUA0VjHYW3YEaNGi1+AfKOBqY50oXJ0LoX599EHOjap/ztr0=
Received: from AM0PR05MB4450.eurprd05.prod.outlook.com (52.134.92.23) by
 AM0PR05MB4164.eurprd05.prod.outlook.com (52.134.90.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Tue, 6 Nov 2018 20:51:54 +0000
Received: from AM0PR05MB4450.eurprd05.prod.outlook.com
 ([fe80::51bb:4e6d:4dd:6483]) by AM0PR05MB4450.eurprd05.prod.outlook.com
 ([fe80::51bb:4e6d:4dd:6483%5]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 20:51:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jwadams@google.com" <jwadams@google.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "prasad.singamsetty@oracle.com" <prasad.singamsetty@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "tj@kernel.org" <tj@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Thread-Topic: [RFC PATCH v4 01/13] ktask: add documentation
Thread-Index: AQHUdSiFTIsR2pPUQUCXmyvUkohtzqVCcNuAgADE+YCAAATqAA==
Date:   Tue, 6 Nov 2018 20:51:54 +0000
Message-ID: <20181106205146.GB30490@mellanox.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
 <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:301:60::49) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB4164;6:AuUulElybXH44fz3/wM/iFmWSAHMe42Yi2BCaEapi9QHlisVTKsLJ4rAMZ93yqOGNoHVgP9EBnEp4E/hlgkVG1sEjomcfjESs2oxA6v29cAo8eTbksIpFg0y7u2xRU97uanbitpSQdXq27n5IRqNtFEFcFM8InbjZmK+i1ptCWhW8GX+jrGmXLRrCf0ibDVErnkSPSQwZdA+yV66j/rWn/H2ye2Pq9U4LElCyCgZX2Lgq+8xiMPKo7O5vRwBLmMkCRqQmXNFg8UpbSNQ13yofGLO4CgGHylMhm0egNToMre4HeD+3qRcHPCVO83UVYSOqJXUkPEMBkuBhwipMZZ4JzRUaEJpOeZ2jT8Og/rJQTrdCrVUo1ELCYo0guToaelrBGxcsLNmQWYfzXje2fOQZbrNBEQbsZFH2lOSve6eFGq3P3uXjdK+N90UoXSeUr3Z9M3CeAvTnHRMYtpjRERICw==;5:7e0uSh26/NvGevMQdptPg38S9/qh4eLouQIDKa8tB0nVDe/bUFhQVhiZvU2AII9OVSYYP6fcj3qGdQUgVRa4p8GPPq7EPE/dZ/FHlFxwo/m2F0fpjF26m/D+b0SnYFLcMcxkMPHzs5knr66Br+ZR/gj/CWTrspCjNu5q8Oxg1Qg=;7:09C1QLIAZNVt9JzljzpN1hnInCe3XelU++qMMYL1hGrPhll5xicD0zxU3uhFAtgqjoIK0akOZqb68nmF7d54ZzzoG16vshVQ2xiAMfncBQ80MGya/3RooVOYEGtebiR5WTAYcczX+VzUKGCtyW1WmQ==
x-ms-office365-filtering-correlation-id: 4950d401-cffd-4d26-0275-08d64429aeec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4164;
x-ms-traffictypediagnostic: AM0PR05MB4164:
x-microsoft-antispam-prvs: <AM0PR05MB41646A3FDB55580D9FE83293CFCB0@AM0PR05MB4164.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR05MB4164;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4164;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(256004)(52116002)(316002)(106356001)(105586002)(6436002)(76176011)(93886005)(2900100001)(478600001)(25786009)(99286004)(33656002)(229853002)(446003)(81166006)(71200400001)(8936002)(2616005)(217873002)(2906002)(8676002)(81156014)(14444005)(97736004)(476003)(4326008)(11346002)(71190400001)(7416002)(6506007)(54906003)(26005)(6512007)(186003)(486006)(14454004)(36756003)(39060400002)(86362001)(5660300001)(305945005)(7736002)(6246003)(66066001)(6916009)(386003)(102836004)(3846002)(68736007)(53936002)(6116002)(1076002)(6486002)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4164;H:AM0PR05MB4450.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ffoERr4+bt+3rmI1kfG0flgmAcQaeTpn8sW3WOeJpKIr4DRPvqbJ2tWWHpa4+DgYKGJqF6anH1mMdQ6nlokvODlcphTc8Hud2DWTlSibsW08So3QhCVQsgYakqJRrY6WE24O7QkcZEnQATNGL8m89VRatlqRd+KsJl2nsD+hQgcZSjwhIGSNmmvhaYUR37A0kBcPN2VJJfDW2tCXJoWF1aunaUK1lsOi1zvgtWtjVYJuCPwPB3697a92my3n8MUYCs62vQUoGfOXHYdHjHSTrrYi/zoHLJ9NQTBteqqfLlA7LCDiTU0D/qvSDxNNB/aX0wcmw0n3ND1xRJr1yky9oV2Gd//6QfWdyiJxGCpZFNo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D06AA0EB35F9848AAEE468B33AEEB0F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4950d401-cffd-4d26-0275-08d64429aeec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 20:51:54.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 12:34:11PM -0800, Daniel Jordan wrote:

> > What isn't clear is if this calling thread is waiting or not. Only do
> > this inheritance trick if it is actually waiting on the work. If it is
> > not, nobody cares.
>=20
> The calling thread waits.  Even if it didn't though, the inheritance tric=
k
> would still be desirable for timely completion of the job.

Can you make lockdep aware that this is synchronous?

ie if I do

  mutex_lock()
  ktask_run()
  mutex_lock()

Can lockdep know that all the workers are running under that lock?

I'm thinking particularly about rtnl_lock as a possible case, but
there could also make some sense to hold the read side of the mm_sem
or similar like the above.

Jason
