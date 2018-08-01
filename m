Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F83AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4CB20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="k6C5aJIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4CB20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbeHAURm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:17:42 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:55897
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387676AbeHAURm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otEl8so8SoYhICIPotAkWmAfzzd58Fyqn7O2SZyKIkM=;
 b=k6C5aJIf3tA8m7zhkJzfz62uLfRq9I4o61Th7jRRl4N3A011PnX3lC2hQkDRl9qxaia6ppnean5vluzvfNauc3nw67YOAm9g1pdtdH+rspbSuZ4sUSLLt2WpzP62Vce0n2AABJAFqf/OSqImbiR4v6cGVcpz8KDYbY12i9Cn6RY=
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com (10.175.21.22) by
 VI1PR0502MB3710.eurprd05.prod.outlook.com (52.134.8.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Wed, 1 Aug 2018 18:30:36 +0000
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786]) by VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786%7]) with mapi id 15.20.1017.010; Wed, 1 Aug 2018
 18:30:36 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Rothwell <sfr@canb.auug.org.au>
CC:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Topic: linux-next: manual merge of the net-next tree with the rdma tree
Thread-Index: AQHUJVRUTB8GmjpwI0+ZUp6KP0x+UKSiaTKAgAAYRACAAAPAgIAHVegAgACMp4CAAMOVAIAAFJsA
Date:   Wed, 1 Aug 2018 18:30:36 +0000
Message-ID: <VI1PR0502MB3008C0158C43DC42A06C5255D12D0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180727123301.3ac97ddc@canb.auug.org.au>
 <20180727024832.GA30023@mellanox.com>
 <20180727132847.2be8563b@canb.auug.org.au>
 <VI1PR0502MB3008702AFA64F44DE57DC9F5D12A0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20180727150903.0f2816ba@canb.auug.org.au>
 <VI1PR0502MB3008076016496152D4898D8ED12E0@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <20180801153345.22692adb@canb.auug.org.au> <20180801171346.GC10824@ziepe.ca>
In-Reply-To: <20180801171346.GC10824@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB3710;6:DPki8lriLh8dcUAIFRP3jjm86VYXwYG7OcSQ+Z8NnpGqRDQiNk/i9HdjNGOBgPDqoycqNXjxhxwWfC1YUVLDjT9zUzs7vdkmprq+azMGvdfpJ4mrzNAefAS1SSmqmqVdAtjiyqr03pm7dPVERdPxtY0+VnaMGZKQB8FJZluUdFF17kHKUvIazzbjP0jR9wFBO7yH8QXo37vZ61UvxRsir1VOO/gVGYzkCqLu06i8AlX1UGmr++kNUS1Gm+iWq6vfyixfH+d4xYg/zf0hbq1ucT3IqiTxMulKEJXnYLaEcwFhv0RYS36gL1T/e/b3azf2gyQnbHpb+gG7j/KGKVZznlCZxDp8hSjKBp98rh94MdoEQzb71Z48Vv6u7Es8PrGAPH5j4woiXP3BpbyeyyjdtbyjysBmCvJXNwWetWaQZ4X7YS9tS2FAHSq4P9QFp7qfvsOd4Z3oeA3iB1fSt7pTqw==;5:Z66MNK+eBvWvekrmu8hvtVtmcupgQvJeVnOw773oS/jD8UApIGz4Z/ku9rqDgCdZdWRBBK6oH6GxgtHW2F/S+7hnpnz/NcTND+wY7qqRzy64TJU3y3zkOz4+DJWU2Z6p7hbuLdcTSDpck3ou8uRmpap8y6HEcooTbqlpdnPRIYg=;7:8FrxoE6H0rJPMfVdbdeiwXKjyHe+8sdLVpEouu84ysZ+N6AxsjllCPoEZ+QGKFbKib1Kge/MPFRn6+Wp638IijVqWb8ZejD2OU6BL10xlUKxYM8+lRP0xr1aLu2p6KTRtdJaYaMSpfxPCe34FHsj8P7n2rPGf6UhAAUpo5yuQYNcvTtNV5hvSPrd+l+n58eBKNs67l8cvCyDm47VA/nNALrF2UqFQNJRaNOA5hK5CWoeN/sZNUVcKWBQwzlSShby
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6cc4d69a-e998-45ef-4612-08d5f7dce019
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3710;
x-ms-traffictypediagnostic: VI1PR0502MB3710:
x-microsoft-antispam-prvs: <VI1PR0502MB37103DA2B77E6B73F93CD462D12D0@VI1PR0502MB3710.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(84791874153150)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0502MB3710;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3710;
x-forefront-prvs: 0751474A44
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(136003)(376002)(396003)(13464003)(199004)(189003)(76176011)(575784001)(966005)(81166006)(305945005)(476003)(478600001)(446003)(74316002)(97736004)(486006)(256004)(81156014)(229853002)(55016002)(6306002)(186003)(9686003)(5250100002)(8676002)(7736002)(86362001)(5660300001)(26005)(14454004)(6116002)(3846002)(8936002)(106356001)(53936002)(99286004)(105586002)(93886005)(68736007)(33656002)(66066001)(102836004)(316002)(53546011)(4326008)(7696005)(6506007)(2906002)(6436002)(11346002)(110136005)(54906003)(25786009)(6246003)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3710;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: cdg9vrfIangGnSwwmCXsjT8c+c14tXoCQ+F0cOVhxx2MiCmy2GV4gWdWxPpjWwdDlj9m6rMwkeIozIP1Rxib9TnlMAYNJ/nQd83DGUyUzPQL7VDP8A6vEeDKXDeFNlD9A/IPPRbJxST42c9Z0L8W4zAGPY8Qk3au4V6iBHX1LY8EBIXI/8YUpN/0+3SKwGD2bjvIbxfR/D+mcre8FHFHGlxrkdl+AvKBwzo4iGQMorUNnMwMb9REe60zGJIVjGz1rN5I7X1oNnldbhVT2gZ6FBCFMUsroSao3zoUYxwPI/85fJ7/KgnihkEA2zX5BTW3BymL4sMOAz/pXN71vedMlPTBqxnhTqW8bZ9NPEEewMU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc4d69a-e998-45ef-4612-08d5f7dce019
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 18:30:36.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3710
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, August 1, 2018 12:14 PM
> To: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Parav Pandit <parav@mellanox.com>; David Miller
> <davem@davemloft.net>; Networking <netdev@vger.kernel.org>; Doug
> Ledford <dledford@redhat.com>; Linux-Next Mailing List <linux-
> next@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; Ursula Braun <ubraun@linux.ibm.com>; Leon
> Romanovsky <leonro@mellanox.com>; linux-rdma@vger.kernel.org
> Subject: Re: linux-next: manual merge of the net-next tree with the rdma =
tree
>=20
> On Wed, Aug 01, 2018 at 03:33:45PM +1000, Stephen Rothwell wrote:
> > Hi Parav,
> >
> > On Tue, 31 Jul 2018 21:12:00 +0000 Parav Pandit <parav@mellanox.com>
> wrote:
> > >
> > > You might want to consider this compatibility patch in Linux-rdma
> > > tree to avoid a merge conflict of smc.
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit
> > > /?h=3Dfor-next&id=3D7aaa1807e698f73094b78f0ef25b1a37a4409a55
> >
> > Ok, since commit that is now in the rdma tree, my resolution of the
> > original conflicts comes down to dropping all the changes to
> > net/smc/smc_core.c net/smc/smc_ib.c that come from the rdma tree and
> > adding
> >
> > #include <rdma/ib_cache.h>
> >
> > to net/smc/smc_ib.c.
>=20
> Oh, that means I put the compat inline in the wrong header? Sigh.
>=20
It was in wrong place originally in ib_verbs.h because lately it returned a=
ll the entries from the cache.
So ib_cache.h was/is correct place.
But devel happened at pace where we eventually deprecated it.
So from pure compat perspective, yeah, it should be in wrong file i.e. ib_v=
erbs.h but otherwise its correct in ib_cache.h.
