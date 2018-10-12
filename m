Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0772C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610382098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="FXMPX+XW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610382098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeJMEgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:36:11 -0400
Received: from mail-cys01nam02on0127.outbound.protection.outlook.com ([104.47.37.127]:64081
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeJMEgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGRwn8YE4jZ84dvnO7Kq0GeuWtvukM3AjHK4dk9dSlA=;
 b=FXMPX+XWVkcC5O4xfgHRYUd+PmxvYpm/g41u1HZkjzEpnipJbaLO5hzLTXiNr0rPnKBvmJgRnM8Ph8pDa43hKW4RlcAYW0C+vsWX+viQDBReKZC6QSYWQFmWVBVsdKMOVCH+M8AU9VFJHA4szt047FgcFGprzLoaXpJKZrEOw9M=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1422.namprd22.prod.outlook.com (10.172.63.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Fri, 12 Oct 2018 21:01:49 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 21:01:49 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Maksym Kokhan <maksym.kokhan@globallogic.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] mips: convert to generic builtin command line
Thread-Topic: [PATCH 7/8] mips: convert to generic builtin command line
Thread-Index: AQHUVoMf+XdDhAaEwESEN/TIkkcHlKUEeo4AgBE44YCABn0egA==
Date:   Fri, 12 Oct 2018 21:01:49 +0000
Message-ID: <20181012210147.32x4gy6o5ilfdy7l@pburton-laptop>
References: <1538067417-6007-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180927185626.gcvx5qjemxbff3zt@pburton-laptop>
 <CAMT6-xi+E1-ATYRXpkmcAprrwykLVHnUc2D+QBQLgPBv4hhwUg@mail.gmail.com>
In-Reply-To: <CAMT6-xi+E1-ATYRXpkmcAprrwykLVHnUc2D+QBQLgPBv4hhwUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0035.namprd21.prod.outlook.com
 (2603:10b6:300:129::21) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1422;6:qB2XmPo/JNPai1VGfOGl78X3XDYuxZ4ZS3cEMIv23mkzMZoyoxNhGMPVfWqPKnlHS/mZXG1vaDiPSZ8K+HAWXVhjRBBnCo0gWz19sKRdm6+n6ZENv4pTFunaAH6LnbMNCWCLbPiYYd9f0qFM95sP3yqvG0NSf2RuROQACjxyIz5Gjd3doDGdcJyC4TQijywa6YgzOm7lBZvIJ2DRCiw5SIgUcWxftVvUYhM4KONZM0WEwOwZAbMzOhAlVsRe+9HLygGqCV5KO1v9crMrBzTrIf8q7MTmgfoaegsM4RSREeysecFWaIO3zZl8YzEjahpU4pjPd2FFuyIc+YjBO0Vcg2XGGR6xeOF0s9nXWctYSjcmiUUdcRwJjGKLBinru2God3hpbx3ovq4GMlGnl7pDXIdp07VwgcXo20a4ZxTXwsCRkWpsL0V5xRznQwDddQSl9FL+pQJMmRH5nlqgjjg/YQ==;5:6EW0XTz0OmIg5XoQ6c89kJTjaJ7mml4NkojEe0E5xiYiI8Z84w+/RsaHwl2IkdRwn+NLWYo6WtvF9xtD7ECZTlIovQqkihIpbW0nXdxlSHDU+dchDR2y9fB8F5SAtrJUfbCIQzf8F2aEruWmhbMttKfG3jCsPqVSF9wGW8EA5hw=;7:M/FJTWxRW0Gb4pHZtZqNnGjFVKB3dFCoGXS+SDv6L0uwhEeCgwIkzV3A6uo5ax0SuiXXkaI7rEIRsrkYCSVv2eWA0H8rHmI58Hp7V6HhzfhcHxBqYuKA8S0wVep1nmdooXNbCSfeM6FpCOjL8b1b05QBnmQjrB5wDysK0cwO2d3N/5UOLPJd/9/l0+bk23b9S89oSqFwQxIQS2QACLtM85rYFl0J8pRU40vklKX62L0pJOeZTIdZOYCIA4jPNLCk
x-ms-office365-filtering-correlation-id: 95091703-dfe1-468e-580d-08d63085ed11
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1422;
x-ms-traffictypediagnostic: MWHPR2201MB1422:
x-microsoft-antispam-prvs: <MWHPR2201MB1422365C9101C2BCEAC28278C1E20@MWHPR2201MB1422.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(2016111802025)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1422;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1422;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(346002)(39850400004)(376002)(396003)(199004)(189003)(52314003)(8936002)(7736002)(54906003)(2906002)(81166006)(6246003)(4326008)(25786009)(305945005)(8676002)(14454004)(68736007)(81156014)(229853002)(106356001)(5250100002)(1076002)(6916009)(9686003)(105586002)(5660300001)(6116002)(6512007)(3846002)(42882007)(53936002)(486006)(14444005)(186003)(2900100001)(71200400001)(71190400001)(256004)(386003)(6506007)(26005)(53546011)(102836004)(6436002)(44832011)(11346002)(476003)(33716001)(446003)(97736004)(6486002)(52116002)(316002)(58126008)(99286004)(66066001)(76176011)(33896004)(508600001)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1422;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OnQaXaJLfYd+vCN/dEml1+plDTqvA/rKteuKPTYCCWXQYUDEJwHJQlEn88lMitjNMFUACzvMAW7A9CC8NCyfMuq21vqQJUohOWK2M4rVjJKHGvz/6TDKU8GNKkd+Ty6AkQI5sMFsC0LWvzjYqY0OdEB/f8CvlHNQwFLIEDoocNrH6h71V1133M7Pe3FobctuYq2q6L4xGwUJciKCRTBstNm8OospVpaYlEE8rSIydY6GjS1bht28y2JJHbZ9DzF1d/uLrQBL/p+1K5a7XaCibHS0xjnVtXxtB+JCuhGHWbeRqgHCLPz7ViNNLllPZvMQMfSjbOud6BmhGxCLXnzP3WJJWhC9qFUTHGbpixtxOqg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D8C593175FBA95469D59F1E1F08DBA22@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95091703-dfe1-468e-580d-08d63085ed11
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 21:01:49.2811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1422
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maksym,

On Mon, Oct 08, 2018 at 08:56:25PM +0300, Maksym Kokhan wrote:
> On Thu, Sep 27, 2018 at 9:56 PM Paul Burton <paul.burton@mips.com> wrote:
> > It also doesn't allow for the various Kconfig options which allow us to
> > ignore some of the sources of command line arguments, nor does it honor
> > the ordering that those existing options allow. In practice perhaps we
> > can cut down on some of this configurability anyway, but if we do that
> > it needs to be thought through & the commit message should describe the
> > changes in behaviour.
>=20
> Yes, this generic command line implementation lacks some of the
> features, existing in the current mips command line code, and we
> are going to expand functionality of generic command line code to
> correspond it, but it would be easier to initially merge this simple
> implementation and then develop it step by step.

The problem occurs if merging the simple implementation breaks currently
working systems. That is a no-go, and that is what I believe will happen
with the current patchset.

"Knowingly break it now & say we'll fix it later" is not an acceptable
approach.

Thanks,
    Paul
