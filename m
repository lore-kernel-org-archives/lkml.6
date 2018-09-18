Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F3BECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE142146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YkZOYQyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE142146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbeIROmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:42:02 -0400
Received: from mail-eopbgr00042.outbound.protection.outlook.com ([40.107.0.42]:28968
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726838AbeIROmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjmPYrTu14nryW8cWbPAq2p33Mf1HEwyNzCtvMEfA/8=;
 b=YkZOYQyzIhTeUhDYgy+mmi5wNatOYxLbUpz6BPCq7zXPwHREIDLJ8/rFrbWxkAmgnHS8T0tqWNjIzpeIj4b0KQ7LwgqWUnYkRegVnxQhmrpUOjkpjPBt4EnhVwivw1zJSkmqShfoNtdsuL+07d8cD8K02jv0mL9orUUffgze0NI=
Received: from DB7PR04MB4252.eurprd04.prod.outlook.com (52.135.131.26) by
 DB7PR04MB5290.eurprd04.prod.outlook.com (20.176.236.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 09:10:18 +0000
Received: from DB7PR04MB4252.eurprd04.prod.outlook.com
 ([fe80::adcf:1ae7:53ea:3b83]) by DB7PR04MB4252.eurprd04.prod.outlook.com
 ([fe80::adcf:1ae7:53ea:3b83%2]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 09:10:18 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: manual merge of the net-next tree with the net tree
Thread-Topic: linux-next: manual merge of the net-next tree with the net tree
Thread-Index: AQHUTuQmuI+iWx13PESk1gjWaeZYs6T1ubsAgAAGcqA=
Date:   Tue, 18 Sep 2018 09:10:18 +0000
Message-ID: <DB7PR04MB42522B223D4E04F5DA519A8B8B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
References: <20180918101107.74d8689a@canb.auug.org.au>
 <93982e9d-dc78-6423-bb9b-c5773d98e244@iogearbox.net>
In-Reply-To: <93982e9d-dc78-6423-bb9b-c5773d98e244@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5290;6:ArZir6KDpyyn/p2K3XJ2UrDLZOzphurnpMkD7mMwy8OoE3hWRz1j+GagIln28hrDq7AHF1pAstPZjaukDF1SoFh/qcHdj2FuCDiq112cEZoI3CC5uTAOcJkJVbxPHW+0uPF2ORrBSF91U55FkRNcFN/kcbnC4xH/H/GfbqtudIsVp/TpyeDiqITOpfZPl7/DvS5dlIlvMSoDUVMuEcftCVXyilVQMeO3OpQKmVLga4r5vfLEGKP9ip68dyjmk+tddLnrYyauRXSRupJKXBFz9vJfKte04OKevkZqDYqBaDJfNhig6lr9yChr9CF0rotJ0KIUEO4A1rkytfx++6WOUK57b+i0xs0kjz57O0k/c9gnGb5JtFtGYJx9R5PHS4nWA3yLhNyS/i3g5hzAzXDE/HVkKDMhPszUIWQUORLtkO8CBHj4GwV184soWThuI7MZrdLBjUQ5dvWCve9ojMsx5A==;5:R4w8RlfV4Gr0DPIzkQ8VPPgGeSGFSxums5S1nBH06j45C7vKtmMEu/aGU8KbnyAbte5grCi6ZBsuGn/2bKEaH1PaDzSygm9Nl9ZclJw84A7SAS9VcEKWa6m50QhjpnOZ9t5m+NGmp+SS0DfSOErpDziumIRKxlDX3Y6Quyurst4=;7:2GKKXi51u4AxqAe5Hwh5dkiASSa3eV0T4KgNeOkEz7naBNQxfJIzb+lFVntbElGldP797eAIjDtUDPh4NuqRg7iUIW+fMs/GTcyZajGaGJZRd4/fh7UbdKq4lYgZ4hocOmNJqHFN1p7j43Dlc97tV55f91PbHuVB5lmhjy60zRBaYiMgi8dAIxutI5hmGko1Q1XdPzOi7fNXsL4NDwtXyH7f3FwziL5eH80c/ukITmdfqEmmaDCDXcxcQOdcCHGl
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a428d7d3-05b7-47a9-a87a-08d61d468dc9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5290;
x-ms-traffictypediagnostic: DB7PR04MB5290:
x-microsoft-antispam-prvs: <DB7PR04MB529053BB1A0AA2DFBAD563438B1D0@DB7PR04MB5290.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB5290;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5290;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(136003)(13464003)(199004)(189003)(53754006)(229853002)(53936002)(316002)(9686003)(99286004)(55016002)(7696005)(110136005)(4326008)(54906003)(6436002)(106356001)(97736004)(44832011)(478600001)(105586002)(33656002)(76176011)(5250100002)(2900100001)(6116002)(86362001)(476003)(486006)(25786009)(3846002)(2906002)(14454004)(11346002)(446003)(6506007)(102836004)(53546011)(186003)(26005)(81156014)(81166006)(8676002)(5660300001)(7736002)(74316002)(6246003)(256004)(8936002)(68736007)(305945005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5290;H:DB7PR04MB4252.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XeBCaPTa1F2MM+dolQv0JPfrswezwyh1ANmLbdqn1gw5V9PfLraZcPvQJQmTBav6tQpCHjEqEbAHAl4jHoo8dXmALHCLy3RNkhEcVcQSKYePIUBo383urTyN6zL1lf6CPXTRkfMw7I5x8SgdyBCxI9y/MeCPxA7FMu4OmeLXeBz9aPGq0qP02WptmCMBh4O4pXCkyJENOwKFaRZCsxPhqMqanyj6bOHLYN5YWe9uERSxvG8iXH81KJIVCVJiW5ZGq8d1qQuMjLgpqy/CHu+u6ZpWadS9lfJa0MyIWM+2AK5+76Y7nKZGgJwnTBBdpyiEck7pHkRr2iasNPdYXdhFJxAi04LR/UePoHrr5Hbvh8g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a428d7d3-05b7-47a9-a87a-08d61d468dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 09:10:18.2853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Daniel Borkmann <daniel@iogearbox.net>
> Sent: Tuesday, September 18, 2018 2:14 PM
> To: Stephen Rothwell <sfr@canb.auug.org.au>; David Miller
> <davem@davemloft.net>; Networking <netdev@vger.kernel.org>
> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; Vakul Garg
> <vakul.garg@nxp.com>
> Subject: Re: linux-next: manual merge of the net-next tree with the net t=
ree
>=20
> On 09/18/2018 02:11 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the net-next tree got a conflict in:
> >
> >   tools/testing/selftests/net/tls.c
> >
> > between commit:
> >
> >   50c6b58a814d ("tls: fix currently broken MSG_PEEK behavior")
> >
> > from the net tree and commit:
> >
> >   c2ad647c6442 ("selftests/tls: Add test for recv(PEEK) spanning
> > across multiple records")
> >
> > from the net-next tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This is
> > now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your
> > tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise
> > any particularly complex conflicts.
>=20
> The test from 50c6b58a814d supersedes the one from c2ad647c6442 so the
> recv_peek_large_buf_mult_recs could be removed; latter was also not
> working correctly due to this bug.

Why remove recv_peek_large_buf_mult_recs if its correct?
Why not the newly added one which achieves the same thing?

Regards, Vakul

>=20
> Thanks,
> Daniel
