Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89596C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437DA2082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="C/4ECPKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437DA2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLDJnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:43:46 -0500
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:63808
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbeLDJnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJcPcDqwDUkGyRcV3wwFNmTmbr3/9hRSSujg0R+PCjY=;
 b=C/4ECPKFed9JLUiMzRGba3/B2XzP76ywFPHzsebIjwF4EMZQwkuPWnrLpWoPP6BPCI3ql55fOmOP3xGuwjYf1bwzXkviRhv1JAqm/5Bh6NIR7KB3GXPhY5BhnlhT6t1DGEYnBzfnHfUkurOaa9+Wq0a0lnWRTQIr0cqpYwsDuNw=
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com (10.172.225.139) by
 DB6PR0501MB2599.eurprd05.prod.outlook.com (10.168.74.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:42:59 +0000
Received: from DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::495c:1921:a6d4:ec83]) by DB6PR0501MB2694.eurprd05.prod.outlook.com
 ([fe80::495c:1921:a6d4:ec83%3]) with mapi id 15.20.1382.023; Tue, 4 Dec 2018
 09:42:59 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@mellanox.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Guy Levi(SW)" <guyle@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHUi2r62QmJLYPrKUempC6bhoGF3qVt0U4AgACDVAA=
Date:   Tue, 4 Dec 2018 09:42:59 +0000
Message-ID: <20181204094256.GX6462@mtr-leonro.mtl.com>
References: <20181204114731.48b18bfc@canb.auug.org.au>
 <20181204015247.GR12288@mellanox.com>
In-Reply-To: <20181204015247.GR12288@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0057.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::34) To DB6PR0501MB2694.eurprd05.prod.outlook.com
 (2603:10a6:4:81::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.138.135.184]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0501MB2599;6:dUUiL6udAsFDhMG6DX37DKTB3vxlP6JC46FicRL6FAMEXx0tYg3/pS7dUq5kGgq8Ylrt/4Qeb7Xv9W3v+antsd0PmLbszdYXgcehrfAVDFN4nofovAQ3ivfLyDctwA3PT23Cav2iYgE/N2pBoQ6QAbkudkJ7kVEz8cYAuFazEl4Qjj/6bgcoQUd9cfi6O3FclwF3jBP47YY7KFw0DY1+YDtfUaakHaTIoX6Gnup0xCP7uvhMi9rqo54XSuEfiXvtWV4+preufqVKeDk8ouW2JfkrEE/kH+rt8nZzEjDoP6mDboKBpzLBXFCnsKGkdafum5Lhr9czl6g09Jfz8UKW3/ExkZy5A2GZdl2c1d31PQqcI6iyAOddrN+l6XJAy9xmkjxbi+JSvVfo55ytRwQDFcY6oAGw52LJtBesDCYEy+smIYt3j+qViFJKTOnSG4tSq9lAvNw84kRjI7Y9m5hZuQ==;5:uHCnI5lkaoTwwL+o9336j66a6imUMnEYm7hZGCXgedI2LJpShzkz0dBaxAef1i480SQjSyIETDLSNzDR+gWEJf978AyNvbsCpv878AQfvF7+wr+BfPt+wqqrPUx3fw+701oDMDSDt54u5q5WoCnik/nAhEdHv+W1L/jWYz1yR7s=;7:7PzRH5xpGFGtvpyxzhGL6u/wozbGHkj2AuxK5Qeoj/LSHZxre8zccnrEwcQbcJHBDN2Ar4bVgoYvSC9ZE9TLyH+SOq9+7RK1dSEZsGoZfVK4As5h+zdpXDEjpsBbu/rWlCpNO1bByzBeuUi4UBbFpA==
x-ms-office365-filtering-correlation-id: 05165952-9d39-48e3-19a5-08d659cce050
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB6PR0501MB2599;
x-ms-traffictypediagnostic: DB6PR0501MB2599:
x-microsoft-antispam-prvs: <DB6PR0501MB259938647AD5F2E841CAB68AB0AF0@DB6PR0501MB2599.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231455)(999002)(944501493)(4983020)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0501MB2599;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2599;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(53754006)(189003)(199004)(305945005)(33656002)(81166006)(6246003)(81156014)(6636002)(97736004)(386003)(26005)(107886003)(68736007)(6506007)(102836004)(8676002)(4326008)(478600001)(229853002)(25786009)(14454004)(71190400001)(8936002)(7736002)(86362001)(316002)(54906003)(106356001)(71200400001)(186003)(105586002)(5660300001)(2906002)(476003)(6436002)(6486002)(99286004)(99936001)(9686003)(6512007)(14444005)(53936002)(446003)(256004)(486006)(66066001)(1076002)(6116002)(33896004)(3846002)(6862004)(11346002)(52116002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2599;H:DB6PR0501MB2694.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IfV4o62KC1UZHMfmkboN4RftygqfYkgK1x/ZqTQTeSD9LEVNFsS0hEub5gJSJhpPhfurHT6yBD5SG2bSm/kj2WDk5pSHuA+E5UN++vjNcSNw06ylT+zBSnsTYdQ3GsoY3lIpi9ThumpNt1eI8Us8YnHCsadks1R0wd2bhmxrou1DTsO6WYUmpOYKMnXi3HVdHRmVD7K3N0ucCndmshYFtaUIwm9Xs8/jYMud76OpmpSOAPV4TlVmIKwZFKA4OOjn8mP5oXLK1z4sklgOrALDcDe3lZScDo1982qILpYxgcEhtfeCCjtiVBkpQQiK1Tq7LRtM5GoGKKHq8b4zBaX8eluWicu1sb4RrrdE4co614M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05165952-9d39-48e3-19a5-08d659cce050
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:42:59.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2599
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 01:52:54AM +0000, Jason Gunthorpe wrote:
> On Tue, Dec 04, 2018 at 11:47:31AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the rdma tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > ERROR: "mlx5_get_send_wqe" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> >
> > Caused by commit
> >
> >   34f4c9554d8b ("IB/mlx5: Use fragmented QP's buffer for in-kernel users")
> >
> > mlx5_get_send_wqe() is still used in drivers/infiniband/hw/mlx5/cq.c
> > and declared in drivers/infiniband/hw/mlx5/mlx5_ib.h ...
> >
> > I have used the version of the rdma tree from next-20181203 for today.
>
> Huh. So apparently every compiler that tested this patch (0-day, mine,
> the submitters) optimized this call away because is_atomic_response()
> always returns 0: meaning mlx5_get_atomic_laddr is never callable and
> can be deleted entirely, including the call to mlx5_get_send_wqe.
>
> Not sure what compiler setup will hit this, but it is clearly wrong
> code..
>
> Guy/Leon, please send a fixup.. Maybe just delete all this
> handle_atomics stuff?

I deleted it and will wait for the results of regression prior to send the patch.

Thanks

>
> Thanks,
> Jason

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcBkwgAAoJEORje4g2clinI8MP/1z+R6a1gfOMZEFjZHPp+P04
nM2hz+nbi4aZTdwaOayd7pjoRD+NeKC9zEy7dYG93EuUZmi7JShCr5xpl5iDcIgk
g+yiRjL8RvzXmc1qRhwi4Bs+hezoQOZJhrBVRYwiSBpE2RzawrbpRABSDOgMagzS
RZk2osl2t+duBXjN7ESxm1sRwpymPh174btocId5yIk7zJH5lFlxCy7jnQYLJwfE
Rgzu7Sb97PXOtrSGQHOmtnw9TSA3GsFveluHD5qPg/atbnUzR7in7q4/WMDK0ycS
u3qCSstWLRylBeL4rdaUo8Zn0Wm24PV3zZX8NqyP9GBPa+6LJq5Q+bLVIWkM/1J5
L/k1pgMLoRlvplw5/GHopE2Q3tg/CaWuVRgs4US1IslKu4lZTgtqzGt33xVsolmW
xCAaYEhV29Ck/45Fa/TAepIZnUsq+lQ/k14cUXneabuT+zytG1gEoHOxgkqHMj2D
q6fDGMys0o9MH0tGgwVLwQD4U7It8HVRAb1KllqRMb3ivNvJ7AVB5dcQlabdEoJc
O1rxwxo4VfEgpjZ77yf4WMiLNA53qKfUF7UI/0q64iOTwgzSjCalKThJwKqzQzgi
Scx/TfbjzVPsOStApQAZ6dXEpAF3W9psuNwFcBs0YVOB0X9zNCd2HhuoSYDnjIZX
RyfjrhBR5x9r/kboebJ4
=14GD
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--
