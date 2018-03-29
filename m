Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeC2Nxu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:53:50 -0400
Received: from mail-co1nam03on0054.outbound.protection.outlook.com ([104.47.40.54]:62368
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752791AbeC2Nxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:53:46 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: RE: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Topic: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Index: AQHTw6ETertR7T3IzEK1oLavaKPLa6PnEXSAgAAwJRA=
Date: Thu, 29 Mar 2018 13:53:44 +0000
Message-ID: <DM5PR12MB19162707D0F98D1A061F0A7AF8A20@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
 <20180324184940.19762-4-Yazen.Ghannam@amd.com>
 <20180329105448.GB29198@pd.tnic>
In-Reply-To: <20180329105448.GB29198@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1497;7:nMYFEyZyv8HrZJHsQaUC4HluX+oUuFfGwlO2e/aSOURS2D9MBUUtgVaL5lcn4MixkrT2JoT1mu45GZ7u3PirYWHSTNX3XR05u1YSrgdBokBl1VC2rmp1v68N5NmyvSy36Y4TPFrQvGx3uU8zDfY5CfQT1eSudu5aglCDmApneNvW8ugfjnDTDxefTXkrkJxvhGKsVLWSkVN3rl59DsBR7naeSY9BP0zx0xZF1vw1bAWoOiJpJDSbaaxwcbaN0y8q;20:fv6giv7Cx1Q0JZ1/RIgipnndQIKCqh41GLNn6T8ixrp8yu/MGGOZy1xRV1o/6D4xexpx//cqGhQ5xqCDoJfTKL8sfU0+pnPEWmvREauMUWHNExQ9VAltTnaurKrWsue+/eqMtQ9zjjfzejryCsFieeyeKHYJ1yLQW2+YViiX0HJ8qTeTdvV8j0kWXHyDotl7AAN2bXok1ztq34oMxGlNuQ263QvAqu1n+BChCJ0fGy5PeYHxgnxnBNpTnqucmJlX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7579f98-76f1-40b6-b3a8-08d5957c7c9e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1497;
x-ms-traffictypediagnostic: DM5PR12MB1497:
x-microsoft-antispam-prvs: <DM5PR12MB1497AFF30BF48F5C046E138EF8A20@DM5PR12MB1497.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1497;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1497;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(39380400002)(13464003)(199004)(189003)(102836004)(9686003)(55016002)(25786009)(476003)(186003)(97736004)(11346002)(33656002)(966005)(316002)(106356001)(486005)(72206003)(4326008)(486005)(99286004)(446003)(478600001)(105586002)(74316002)(54906003)(53546011)(6506007)(5660300001)(2906002)(6436002)(6306002)(81156014)(81166006)(8676002)(53936002)(6116002)(5250100002)(14454004)(6246003)(229853002)(7696005)(7736002)(46003)(68736007)(305945005)(76176011)(3660700001)(575784001)(3280700002)(6916009)(2900100001)(8936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1497;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 5k+RxKyfckcVPtk6KN9INQ5FFIkbGN5b/yt38Vxi8FRTKPCgRUuL+c6g5KUrsWssxpOlw5A+oUwDJmyT1uk10OyhDYAb4T/xm0MNzJfvemq6k6mN+4qWzv2GF95nh1dm9RMGGp+lDpR85ISwbHOM/CGKDs3c5RM2inmTyenFyJRonOzcZy56HzW1wGTaQ3OKLi3qra0MfkdMnUGfx0bIbLZBmaEc+Xw9asarQ6waITptFEZjgieb+RFHwJd0rjKl8zyLeCPlmVsHdvVOBpACV149IZnYxItqOLn3Lvr4159aGqTTeYdriIhJ+xyKKBPbJEqeKXFf7h463b0EWDt5Cg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7579f98-76f1-40b6-b3a8-08d5957c7c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 13:53:44.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1497
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2TDruE0016881

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Thursday, March 29, 2018 6:55 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> ard.biesheuvel@linaro.org; x86@kernel.org; tony.luck@intel.com
> Subject: Re: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
> Structure
> 
> On Sat, Mar 24, 2018 at 01:49:35PM -0500, Yazen Ghannam wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >
> > Print the fields in the IA32/X64 Processor Error Info Structure.
> >
> > Based on UEFI 2.7 Table 253. IA32/X64 Processor Error Information
> > Structure.
> >
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > Link:
> > https://lkml.kernel.org/r/20180226193904.20532-4-
> Yazen.Ghannam@amd.com
> >
> > v2->v3:
> > * Fix table number in commit message.
> > * Don't print raw validation bits.
> >
> > v1->v2:
> > * Add parantheses around "bits" expression in macro.
> > * Fix indentation on multi-line statements.
> >
> >  drivers/firmware/efi/cper-x86.c | 50
> +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> x86.c
> > index 863f0cd2a0ff..a9ab3bbf7986 100644
> > --- a/drivers/firmware/efi/cper-x86.c
> > +++ b/drivers/firmware/efi/cper-x86.c
> > @@ -3,15 +3,28 @@
> >
> >  #include <linux/cper.h>
> >
> > +#define INDENT_SP	" "
> 
> There's that thing again. So it was a total waste of time discussing
> this last time. So let me save my time this time:
> 
> NAKed-by: Borislav Petkov <bp@suse.de>
> 

IIRC, the arguments for keeping this are
1) convention for CPER
2) code readability

The argument against was
1) it's dumb

So I decided to keep it. I don't really mind either way so I'll change it
if there's a second opinion.

Thanks,
Yazen
