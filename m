Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBEEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA88E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ht5F2i33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA88E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeK0Dzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:55:45 -0500
Received: from mail-eopbgr680115.outbound.protection.outlook.com ([40.107.68.115]:57216
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbeK0Dzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taNT+xLMASzmsQJAzuycJFKkkUIU21kVyiJS/t9FXkY=;
 b=ht5F2i33WBtObu2hqiSV3o9oEAV11toDUC2NXoSA51jreLendkjEbZeFuVSfc1ViROTyLrjABBBPJDrvVlWCrqDgQysLAlhcKXbg1RhjSib/ZfhKyxT/QFNQQjbArXM/02pg3W61BYpywvejkiNprvpPVQ8BzUOgWiLK6W7kP1s=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.5; Mon, 26 Nov 2018 17:01:00 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1404.002; Mon, 26 Nov 2018
 17:01:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Roman Kagan <rkagan@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Topic: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures
 definitions to hyperv-tlfs.h
Thread-Index: AQHUhZ9h2g9Agw1QXEObN9QIHGEpQ6ViR2+g
Date:   Mon, 26 Nov 2018 17:00:59 +0000
Message-ID: <CY4PR21MB0773087E1A8C83B1DCC972CAD7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181126154732.23025-1-vkuznets@redhat.com>
 <20181126154732.23025-2-vkuznets@redhat.com>
In-Reply-To: <20181126154732.23025-2-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-26T17:00:58.6846634Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:ed00:bad5:da35:76f9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:TD6JAPr+1JlQjnUyLV2hruba9Su7jtvXVJjYld3OrlNHzXhTO5dsL+yoo413XKPiTWPANlPhywc8oFDUw5xvVRI8wTnj07V/BbpOpFGV/IMQTGpUM4j3lbMkc+cnGob2GGe48sFil66Oecz/Lr9SMJDtxKzzYSAzcbzkb9yL4rDN4u2iWs2j0jHJylWFPL16cOxqz/FKeWn8yGBjkAzxguFvxmgH341IZheqc7A689/a/HK8dk6cSzCWUwtTuQtvMv7/HfkaQQG5PyFgoE4s37OVXrofu6THBlvijzmOnIwsV26/uumnGi1YWfVZf4CMz4/BFC7d1T3dy0kb7k57oiLG9Ne+4gBpOFC/tvWkwWxSpaRusZDxcO6A+Fq+rBYlPoNS7z/7mlZ8tnDOyNtRCSVt3ke7Lzho29CuYGIywC0pFA0cY8C7PB5ar2UpUCTIkDDRBkuudOidy0SiaWa22w==;5:hiyodUvzbCVgrlS7l3Z4N8ZhMNrlYsS5FqYU70BQ8WZgSq6o1HAXlk9DjhJCZq+X+V8hjHwHF753aFx6aEj+IKfdDQySWVq/CSgPsaVx2RK9T6Oti/n1+w5qkNLVvhkrw4OWGw1QgNkb+/2rK15kYvkLSQ5utSg4L3v0Mi4TnuY=;7:vyeAJUqqIeN3zLOFfiHLK2wS9m7Xuxgdp0JZNFT8o2Htr0cheGAcE+iZTUWwknE/1Ijy2LArozMjRbp4Cov/k+kBw5E9kSZD3AWnfsNqEsm4xhAcpdLKk0TpZnAaP+IHxqB1ZuPQtk51HtDCNJcDAg==
x-ms-office365-filtering-correlation-id: a2005b93-a4a9-48bc-d924-08d653c0bdbc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB012070247A56EC36C3441A2FD7D70@CY4PR21MB0120.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231443)(944501421)(2018427008)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(76176011)(5660300001)(4326008)(55016002)(86362001)(186003)(7696005)(86612001)(6506007)(102836004)(9686003)(14454004)(74316002)(10090500001)(106356001)(105586002)(81166006)(478600001)(81156014)(8676002)(7736002)(8936002)(33656002)(305945005)(6116002)(53936002)(2906002)(6246003)(25786009)(99286004)(2501003)(10290500003)(68736007)(22452003)(8990500004)(256004)(46003)(486006)(316002)(446003)(476003)(11346002)(54906003)(110136005)(6436002)(97736004)(71200400001)(71190400001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l/MBBzKjhV6iS9gmmBjTXmBdomsuFQ0wt1SoFvxskYz1iM53Ug+Og/pmP4VQ8H7qr4Fv56n1k76ngM5e0W1WQIUNcZbhMVKBjPCOxnG/dpN/yklRZJ1unnzqohyGQPtvM0ZhOGhd9WddusIwdc4OgEU2MpZMoihAGR6zWDSNECSaidjy4lmSH879MHUXpcM68NH3gEopPuoTGVsJylW8tEi4eJKTilcnrjhqsXZK0DtayT1aN5nwkj8H+MgcJllL1vb5Y1jIku1Xk6vFE/7KO65sHNLhlHLCTvaQgVXePH1FECyglrUrRJDtI/ocG8jlDrWE/vMsNFN0IGlKtV0kDEQawsad8SBi459WBE3d95E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2005b93-a4a9-48bc-d924-08d653c0bdbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 17:01:00.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Monday, November 26, 20=
18 7:47 AM
>=20
> We implement Hyper-V SynIC and synthetic timers in KVM too so there's som=
e
> room for code sharing.
>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 69 ++++++++++++++++++++++++++++++
>  drivers/hv/hv.c                    |  2 +-
>  drivers/hv/hyperv_vmbus.h          | 68 -----------------------------
>  3 files changed, 70 insertions(+), 69 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
