Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54ACC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDFB21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="U99ae/y+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfAVTXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:23:03 -0500
Received: from mail-eopbgr790134.outbound.protection.outlook.com ([40.107.79.134]:45263
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfAVTXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lZ8+PHK9HebAT0SQwVpL6u8fVEJDJsgpPW0ctY3YFQ=;
 b=U99ae/y+wcJm0aThopqZ8yO3kdRkD4v2G+3Q0keGLVoCYGXcxoQNYJ9WXIfTmd/BhJoB2pqxx2o3mc8WRKCCmgsOK9xXYkdxdAfZjmyQKhP7f2HaMMCyuE8l5R1xmbnQarw7YgfAqMO9D+6x0j/UfFAXR2o0nlTELpeTefUFFRI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1199.namprd22.prod.outlook.com (10.174.169.162) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 19:22:57 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 19:22:57 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/5] mips: cavium: no need to check return value of
 debugfs_create functions
Thread-Topic: [PATCH 1/5] mips: cavium: no need to check return value of
 debugfs_create functions
Thread-Index: AQHUsmLuEra2RuUO8ECdbuG3dcjl1aW7oXsAgAAJf4A=
Date:   Tue, 22 Jan 2019 19:22:57 +0000
Message-ID: <20190122192255.tjkmwgx25wvcp6y6@pburton-laptop>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
 <20190122145742.11292-2-gregkh@linuxfoundation.org>
 <20190122184855.GB2792@darkstar.musicnaut.iki.fi>
In-Reply-To: <20190122184855.GB2792@darkstar.musicnaut.iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0076.namprd15.prod.outlook.com
 (2603:10b6:101:20::20) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1199;6:ZZHhcQVG8EeI+G5D7vXFvu6nhKbFQsN5oqziZxqjxIlHOMAmvJsxLA3h1ViSmIPfNULJUeYFBxUqOu/1kaobsmWDC/9Edwda/ofXbfSgwtifgg4wGT5/AKGC6Qf/E4TPHeIwBOHe/QeCV09GYHmZkRn65McD2LSzJTuh+PbhGfOhoi9mw1kki8r4ZT9S3wfEQiO252AepzHvxW8tc66UgPX8dtUZ2+7Lj3L51wBNNgtdGq1E3fiXa+6PMBWE0r24y+EPuEw6OptWOFpJaRf+abarD8qqoQAfsSXpmo2fD9ehA4LKGmcZEYF2Ak7cr8TGpQnJJtDGkx9xWxwc5J0ZYsR73CvcYnZgonSty3NrvBqbcaop4JBZSQiEt1gVGqMdKWXIIQpO3x1oI8Rd/E+c7susSWFfJX0F+hIesEHFQS+xxTc9hUSCTPHMaQYHZtqy8BtpoaVizvqz/hGHwoYfcg==;5:is+r5+kt7E78vOZVcIrcGaXuOG9yTJx5MaAKrhUu1BT0INkE7IJOA65pUEGhnVB/Sc5vW6yLzhlSiJhn+nvySirUqIkBv/Fy//MR+TmX2LjGJGLGd7QuotBamgdKbvHBSUEFfvgdx9vao/EMkVOAvdt6Px0lcb3g+tMqTPd2vEkLy7S5vp4nfZB3PwAPEUThJyonDN65ly8Pz/tqjg2SQQ==;7:SZFZKZymPZJeCOuM9aeh8mJAokuKihaRgBTWSpDsQCS0p4OMLlP8VB+5VIGLwui6PwYBQfP2l5L+jOCtjKwwWxPgnuuX4RUBTKCAFyOjHdNW7j+UNUTUPsW1Zuz6rFrvlWHajBNXZNZQtnsuT6BsUA==
x-ms-office365-filtering-correlation-id: 194725f7-f735-4ba9-e4be-08d6809f03a8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1199;
x-ms-traffictypediagnostic: MWHPR2201MB1199:
x-microsoft-antispam-prvs: <MWHPR2201MB1199858D1433E7D3F1BF0FBAC1980@MWHPR2201MB1199.namprd22.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(396003)(346002)(366004)(136003)(376002)(199004)(189003)(99286004)(54906003)(58126008)(316002)(1076003)(68736007)(4326008)(25786009)(42882007)(2906002)(11346002)(446003)(9686003)(6512007)(102836004)(186003)(105586002)(6506007)(26005)(110136005)(66066001)(478600001)(53936002)(33896004)(6246003)(76176011)(386003)(52116002)(14454004)(106356001)(476003)(6486002)(229853002)(6436002)(97736004)(8936002)(256004)(81156014)(8676002)(81166006)(486006)(305945005)(44832011)(33716001)(3846002)(6116002)(71190400001)(71200400001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1199;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FL49Z4ES6toBN+3A9a7FIUS0cFS9dIN4BcEnBW6jy5uI62rEoa3lg/K9nPJMJjdiODxkplzHCmJc7X+TKi+z+A5VHMkNVXvGpCjwVuaKXZjyB4MR+4CvAOQz0jipcJU+bAY2DAqFu6+fvMDK43lniMNAJguXuWO+00iAy33f2OwqOdzRmLTZCiVq/myU9rH5QMmRaPBziI5MbQxEGBnt/uiJyjM17kkNN7lKdVor5uvI9Yw4H9MMkK+FamNvLE9Xf0LqV1QbaveAtqWllUfcVi26Yfsv7LTKl+hPgGSBzdVh217Xwq/omdJ6KpPqJsXK38fM6R2tTyDd/58gufFnAXmUfUlgvZRJ5+6P2ZjPJQLVxkfmnDg8tBNfttTcwJBZmwSgBjTkxO4759/Z0l15wYBmlAsJ4F6T2HU2gO85J6Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <73D792F136891C4AB125461A7C663B24@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194725f7-f735-4ba9-e4be-08d6809f03a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 19:22:56.8318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 22, 2019 at 08:48:56PM +0200, Aaro Koskinen wrote:
> On Tue, Jan 22, 2019 at 03:57:38PM +0100, Greg Kroah-Hartman wrote:
> > -static int init_debufs(void)
> > +static void init_debugfs(void)
> >  {
> > -	struct dentry *show_dentry;
> >  	dir =3D debugfs_create_dir("oct_ilm", 0);
> > -	if (!dir) {
> > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
> > -		return -1;
> > -	}
> > -
> > -	show_dentry =3D debugfs_create_file("statistics", 0222, dir, NULL,
> > -					  &oct_ilm_ops);
> > -	if (!show_dentry) {
> > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/statistics\n=
");
> > -		return -1;
> > -	}
> > -
> > -	show_dentry =3D debugfs_create_file("reset", 0222, dir, NULL,
> > -					  &reset_statistics_ops);
> > -	if (!show_dentry) {
> > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/reset\n");
> > -		return -1;
> > -	}
> > -
> > +	debugfs_create_file("statistics", 0222, dir, NULL, &oct_ilm_ops);
> > +	debugfs_create_file("reset", 0222, dir, NULL, &reset_statistics_ops);
> >  	return 0;
>=20
> The return needs to be deleted now that the function is void.

Well spotted - I'm happy to fix this up whilst applying the patch.

Thanks,
    Paul
