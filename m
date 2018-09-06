Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2971C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5145F20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="yrbhkDa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5145F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeIFT54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:57:56 -0400
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:50190
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727501AbeIFT54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZxx9CRnaJ31AE07rAZoMrgwCwt/Q9Mg+7aLaD2mnGk=;
 b=yrbhkDa+WS9PHNIPBsp5CbhGAEsilIpfktAjH14WcDnCuJqqlwVdXRnDK+ej5qSsacCkmavovX9TjqKJq8tUgXKxthQI6EC148Qex286vBeBjv2OrHZ6q2hDVOrGr0tnhZE6n6ES1YiSvDu2J2nTfvZcAORDkVbHOEd0HPh//Yc=
Received: from DM6PR02MB5227.namprd02.prod.outlook.com (20.176.116.140) by
 DM6PR02MB4107.namprd02.prod.outlook.com (20.176.75.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 6 Sep 2018 15:21:49 +0000
Received: from DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644]) by DM6PR02MB5227.namprd02.prod.outlook.com
 ([fe80::4c6f:aaa3:2a0:9644%3]) with mapi id 15.20.1080.020; Thu, 6 Sep 2018
 15:21:49 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        Srinivas Goud <sgoud@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
Thread-Topic: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
Thread-Index: AQHUQS5/FJ8KGxmdPEaOLIfxKqYf6KTgMVQAgAM2gIA=
Date:   Thu, 6 Sep 2018 15:21:49 +0000
Message-ID: <DM6PR02MB52276BECB56DCAB7576CDB53C1010@DM6PR02MB5227.namprd02.prod.outlook.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-3-git-send-email-manish.narani@xilinx.com>
 <20180904141618.GA5516@bogus>
In-Reply-To: <20180904141618.GA5516@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4107;6:P0cDFRoxiB17yxsqvUl/dyBzd6+Fc+JGLKQl5n1yh89+qW4sOLwUeZX7Ucd+u/ouMlMtv/1OFaqkLQjzNpZbznMf3pteQXnYL4pcG2KKGzRKDk8jrSaMsBSNrerXz6g3TLRBkQ1bteRPkzyLvrkxIJdD0tz/7mQeciQUohAqVYdcye3926evIj9p2HNIbHlUmH9/rKNmdFuR7SNbrwt/Gop7Kcsof5TtnuZMWZAogjw6eU2BgBBTnjTPpLRLUGpa9sLEaN2CpHQxUtdDRIZWkCmbtzz+yw+vrD/403AuwMrbQslW3Cpf2H52W58MVWNh4HTrP+A+tZz5UDIIar6++zmqAtG83qNk+Pwxp8/ptQJaFL7mJNr+2VjuhbjxJUu5nOy3JMueA+plh3ve+1Vv0S7y6ZKryPifb+tj8pA+eZVuiwZ8eacegoL8QHjJ0wZbGcSijh0Sgf2nLKus9IicOw==;5:uEkKq+W3vlcJjwEIlRuIAOLurMI250MExbIoo7AT+TsJLdKOiL5JZxe1rXmoopieNYCvEfCw8gKP1JXbku+RPF/FQV3PuA5Odf864/YDHtpAl3YSs1l/ul+K431Uju2Z8iNTdtu+jDh9p7pz2rEifk83xTea5kgOZsp7e+f0u94=;7:ay+UQALvozodkFP/sUzzmxzribQ8hp4UyWXanymsDdZfJKaDXywzSRIKX4ckkjAUGGyeKQFU9UNMlUbY0jMRxTnoo4IPCTAMaSAJTEoJEQS+SXborV45Yci0tc4ZJZBiFsdqLWLcTOmVi6XTT4BGvNvZRPhpGmSdq/CETPz1Y6Mjh6n4030LtalocjSkIJmz7a5qhNt6fA8TG96H+PgIcHz2/jw0+7jRkQtGncs0tQjPE3NoDNS35sdbBIHCl/CW
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 0aa5bbfd-c962-440d-c194-08d6140c77a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4107;
x-ms-traffictypediagnostic: DM6PR02MB4107:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB410788EC3D8BDC18CE5D68B7C1010@DM6PR02MB4107.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(20558992708506)(9452136761055)(185117386973197)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR02MB4107;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4107;
x-forefront-prvs: 0787459938
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(13464003)(53936002)(14454004)(66066001)(316002)(7696005)(6436002)(81166006)(8936002)(81156014)(72206003)(256004)(54906003)(2900100001)(2906002)(229853002)(68736007)(7416002)(99286004)(76176011)(478600001)(4326008)(97736004)(74316002)(106356001)(7736002)(305945005)(5660300001)(102836004)(25786009)(33656002)(6506007)(6246003)(446003)(3846002)(186003)(486006)(9686003)(53546011)(55016002)(86362001)(476003)(8676002)(11346002)(105586002)(26005)(6916009)(5250100002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4107;H:DM6PR02MB5227.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OMGYO4qKWKCvYr519qiQc/ecb0mIOZR3a3MWYrcjCeKBjnzFxXpI56viybcP34Bt/fxVdeBH+Mc5vev/5tCywJpdkKzeI3PixkEiPjIDZLgUAFFVjM3PNdXsgAOJtDS/qceqab208azAfrnGGKGvws/odKl4RySdH0aQT3c3BkMgPqdk5wNGkSpzdlKmLYx9k895i4wklYKEse5kjwHf3kKMAd2YLV8X5n2WlVsGVrntJzCz4OtaMnjVGRH17R+v3dV9MmnMGYO6E+6sXgrbi+TA97ht91jReOmmdSgJoDqa3Ov3t/dEWZdUqvVwb1M2R57KbPOUNiB01zqfI/gN2R30k7SGpZ8GxUvuRg1oFDc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa5bbfd-c962-440d-c194-08d6140c77a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2018 15:21:49.7180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh@kernel.org]
> Sent: Tuesday, September 4, 2018 7:46 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: mark.rutland@arm.com; Michal Simek <michals@xilinx.com>;
> bp@alien8.de; mchehab@kernel.org; leoyang.li@nxp.com;
> amit.kucheria@linaro.org; olof@lixom.net; Srinivas Goud <sgoud@xilinx.com=
>;
> Anirudha Sarangi <anirudh@xilinx.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> edac@vger.kernel.org
> Subject: Re: [PATCH v5 2/4] dt: bindings: Document ZynqMP DDRC in Synopsy=
s
> documentation
>=20
> On Fri, Aug 31, 2018 at 06:57:48PM +0530, Manish Narani wrote:
> > Add information of ZynqMP DDRC which reports the single bit errors
> > that are corrected and the double bit errors that are detected.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> > ---
> >  .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++=
++++-
> ---
> >  1 file changed, 22 insertions(+), 5 deletions(-)
>=20
> Please add acks/reviewed-bys when posting new versions.
Sure. I will include it in v6.

Thanks,
Manish Narani
