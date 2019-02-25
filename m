Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A56C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35B12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="b8lmfIrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfBYTIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:08:43 -0500
Received: from mail-eopbgr820103.outbound.protection.outlook.com ([40.107.82.103]:36832
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfBYTIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glSro5UQqwFFWqP01tYpSuBfVJZGN1HMXCH7EEeE9NI=;
 b=b8lmfIrAiWraY+O8AQ8YqiN0vmF7Ih5ylY8Hpu0Upd8lCH3HYFAgq13K5+9DfP1JnNbJPQDmyX7iPz9Asq3VWocSRogFnPu5xRvhsUJ5MFKhbBPFdhjTBPMlnOCNcfw8NZwdFOzG75x02Q/LD+7A19wDH0JGttbs5V9SCYgUGOY=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 19:08:37 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:08:37 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] MIPS: SGI-IP27: do xtalk scanning later
Thread-Topic: [PATCH v2 04/10] MIPS: SGI-IP27: do xtalk scanning later
Thread-Index: AQHUyiuqZaLcbMzEaU66cJqyzq4me6Xw5quA
Date:   Mon, 25 Feb 2019 19:08:36 +0000
Message-ID: <MWHPR2201MB1277D56D7785D4E1C931AF09C17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190219155728.19163-5-tbogendoerfer@suse.de>
In-Reply-To: <20190219155728.19163-5-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0004.prod.exchangelabs.com (2603:10b6:a02:80::17)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a014c68-36da-42d8-4ac6-08d69b54a4eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1343;23:7Y0ysW+eR+k84bQPwmG3ZVqoRpVCJhwkKag2X?=
 =?iso-8859-1?Q?DpBYz6mR/27NtmH4re52HNP1A9GWpOtYrYz8de4OVTCTarqVRNN2L1pMoF?=
 =?iso-8859-1?Q?tDTZS3KN6eMK91ilJQuO01I5rNy1nsgrgXqLTGa/7xEUQs/y/F/eCTTOnd?=
 =?iso-8859-1?Q?ztnOCozCuSiuigmp/mEzTpKMhQDsdw6Ova4yO2CdM2ZTGgJmhDkG/6Gmyb?=
 =?iso-8859-1?Q?ID2d/uKezScM2HWw5rSg2SQoCDZnhGVMmnuLc43EwNJOS/Y9pa0oU0lfbp?=
 =?iso-8859-1?Q?Ww1F2KaSr+4zsyrmMMfu0xwT5t2r5sDi1iVLoEvoVNikLFmswlONDEf/ag?=
 =?iso-8859-1?Q?AEv9+q+Z8D07hUpma4Gvf07xXNhj3QuZPPXlc2q+H5ng8Gp1/f+Z3Gwi9y?=
 =?iso-8859-1?Q?FnxI7Z5XQfyVTIA1/2RyQc2TNUja0rstPL9ItThyTy3uDELIu6XG8Ttcsk?=
 =?iso-8859-1?Q?/47Oese49alqCwMC2FL7On454wYS4tG51QSl8V0mbyz5UBR3Lxpfjt7DX7?=
 =?iso-8859-1?Q?9Yj+yBlD6WKPTv7MEo/RPkcNZ+xWGJNa4AgQfoI2dGFv/XoE/zgPq4zVdZ?=
 =?iso-8859-1?Q?FfPyQaWUeEgk7YG5odKemLBVnF0jM9RAKkdnGza99+t3fcKk+W788rdTdf?=
 =?iso-8859-1?Q?T1RgUrrGFB9zVh/521vDcquqgIl+jlTarAwIvVOpLhjiJ1MqJnH7XMHhQj?=
 =?iso-8859-1?Q?LiOoCOwZyA7vOjSR7V9rL+fgLOZjRSmhT8QfpZvIaT5f/lIyr0jATRqpq7?=
 =?iso-8859-1?Q?vcP9TABlG7KxWFBO2kod73liJ1BiApsXJhRa+pWE7WfhfF2mzKD6LW/LMg?=
 =?iso-8859-1?Q?niGQY5GxPB5qO2WbjifcS6oJq+b9Xl6iFnJjtrYaFW2XIDZs9lHa0Re9/d?=
 =?iso-8859-1?Q?VTrC2MZzQnqzTqdF33rnZxFLT8IWEADFL5ELTi4ZWYGtYdHLVytLA8SgBu?=
 =?iso-8859-1?Q?VjV2aWO6PzWi7dZ15i9WEmTIef7PjpYZd+wAiSjJZY6BXr6VPqBsFsrlOy?=
 =?iso-8859-1?Q?L+DvkNUM8eXXVvTL20JaAdbjeYDGeKrQoattOI0IXy7G/YVNBfGY/u1U+L?=
 =?iso-8859-1?Q?ekdqd+3Q4NUX/OqJXvpZPW8PWZSSZxCZkz70gOwXJMgLOc+PK8+u6MS+E9?=
 =?iso-8859-1?Q?j3+DIx++Cxt4ejTvyjeFGuDXhQd7VK1o1ImFwOElir4qrwpCG9NADVKphn?=
 =?iso-8859-1?Q?BXYiTLll1Utx76teVQNT4PutNlgwnX8S0Xb8UZIPCY+8zbBDvu7Wbh13X/?=
 =?iso-8859-1?Q?TxNzWtM1UbprkU+pjiMQ0M+b3tw3ykY7q2bBFdimYcEhSBqP/AZhj3EobF?=
 =?iso-8859-1?Q?EuFhPiBarGzcZy/5iRwD07aKR4vu5z8vaESPkqllue2QrtA=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB13436AAB5B3F0011E62AE4B3C17A0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(316002)(33656002)(26005)(6916009)(71190400001)(71200400001)(52116002)(256004)(42882007)(54906003)(55016002)(2906002)(76176011)(99286004)(7696005)(9686003)(6116002)(3846002)(186003)(7736002)(305945005)(102836004)(44832011)(386003)(6506007)(74316002)(486006)(11346002)(476003)(53936002)(446003)(8676002)(106356001)(8936002)(81156014)(81166006)(6246003)(105586002)(66066001)(4744005)(68736007)(25786009)(4326008)(97736004)(229853002)(14454004)(5660300002)(478600001)(52536013)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IzvMUVISG/wHI5PD0ucUD0FBr5AsMvcYpRNWOtSMElXd4PZjS/nhYbYNzQLLBwfwUbsLdyC6MU2b0XYhOrybtzBPVm5VfXST5RTFYKyMUTHmm6rB58GuCdeOjOm90p7h1m298adt+5Gr0iTW7kcxhQz5O31cUjgvEWJ6/cWgdmZnD2iSoghDrdjUJcuw0BUJdq/uw93R6ctZ1Zir4wfROIJb6qcVqsT745S6K3cRKwSHOQG6sipB3RNDhn0n3cVnEH4h08VpKHSuRVIrBy3xifhzY4LPECfgpYrWGdGtZGQPuKAEcTUTzr3M1JFZ3trx5IPiGoKM9L264up38/UjeGMy6L2RytODLntKhoADJ/DbnEqoASDBI9o/SfPwpn+28I0mpKSm2jgijeaOcDV2N7WafhDbrwmy1qxAq2kx5FE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a014c68-36da-42d8-4ac6-08d69b54a4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:08:36.4784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> Move xtalk scanning to a later boot stage to be able using things like
> kmalloc and friends.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
