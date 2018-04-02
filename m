Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbeDBNVZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 09:21:25 -0400
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:3898
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750710AbeDBNVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 09:21:23 -0400
From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC: Borislav Petkov <bp@alien8.de>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: RE: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Topic: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
 Structure
Thread-Index: AQHTw6ETertR7T3IzEK1oLavaKPLa6PnEXSAgAAwJRCAAWq6gIAE1wfw
Date: Mon, 2 Apr 2018 13:21:20 +0000
Message-ID: <DM5PR12MB1916AC5CC36AEF4364C7D317F8A60@DM5PR12MB1916.namprd12.prod.outlook.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
 <20180324184940.19762-4-Yazen.Ghannam@amd.com>
 <20180329105448.GB29198@pd.tnic>
 <DM5PR12MB19162707D0F98D1A061F0A7AF8A20@DM5PR12MB1916.namprd12.prod.outlook.com>
 <CAKv+Gu_6D03iGvxsmiQS_ODET2cv4f7kVsK5S5EKhiVN1YxRaw@mail.gmail.com>
In-Reply-To: <CAKv+Gu_6D03iGvxsmiQS_ODET2cv4f7kVsK5S5EKhiVN1YxRaw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
x-originating-ip: [2601:345:301:c593:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1514;7:M9Tz2FW5Uc/XsRB8OagpZ/Z/atjzP05B6S3IMYpujG7yDjfrE20A23Ho2pcgpFX7ulS2hA4L7foTRVUlhrmWeT8+SmmLwbFysuY3CT3yhZcJz6V+dW5brmhkKrT8cb3E5z58ENZwZm4PP+15t6aSqGKqHDpjizoPrIbyCOKDDg35JkhiETIUVhpa0wiC5rocl6xoVOpovQH0vk2Fk4sPQt8aR8g+o8U6v+tZdEXZVJK2MzLTD3CGs+I/O+BO6Ywy;20:VjFIqcwX/DPbSZQ98k368xg5U0iNt3FMT4CCPLXY/zZdYih2EVB5xpBp3zXAIjLQUTZ6DWo4i//JIX4KPIsnTLKgMvq9mSF9bLKtvIweke1zzrbxnDzVyEbYZ49EEwnHUuH8vR9whlJ734kVPhvwaB5bMflt2M/Qn/PqwIvKhzha8x3oekAmtMUQzLgWZiny+ebxpUQS37DgPVPw/Ri5WGobGrdocMMj04QDeUrwf/ej0jD4Ys3CJzYis1TQCjff
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bdf3091f-7b05-49fd-49ae-08d5989ca00e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1514;
x-ms-traffictypediagnostic: DM5PR12MB1514:
x-microsoft-antispam-prvs: <DM5PR12MB151432F5C27D9D9CE315EFD3F8A60@DM5PR12MB1514.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(42068640409301)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1514;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1514;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(376002)(366004)(39860400002)(189003)(199004)(13464003)(6116002)(11346002)(3660700001)(6306002)(9686003)(6916009)(53936002)(2900100001)(3280700002)(446003)(229853002)(2906002)(55016002)(81156014)(4326008)(97736004)(8936002)(486005)(86362001)(575784001)(93886005)(476003)(486005)(81166006)(8676002)(186003)(106356001)(14454004)(6246003)(7696005)(105586002)(102836004)(74316002)(7736002)(72206003)(5250100002)(99286004)(316002)(6436002)(6506007)(46003)(305945005)(966005)(76176011)(33656002)(478600001)(5660300001)(25786009)(53546011)(54906003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1514;H:DM5PR12MB1916.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: L0s32PDYm+WMshmCQ4a1Sr3neV0QiqxfLxNFFSi7pCK7MMUkJmbK+XYHBjnXqeq1PFAWGKQuJNyMOlFJKLGwcGwcVnYlWgwDXI9KFQdOJeZHK7k/PTBnWl/uQBvgiBrbP65buKq8fznv3u52rSTXBf9f9wkvHNHjjs/eOjvWO/WilrkzCLblVxP4ZmiLBR5hUDohEowKXgriYNRr2tKg+8uUoW6oZ+EfsVsPBP7vX/P6iuJxogtMl1zo2W8IsncBleWTMqTeNRx9paFGiJt20ZcyaQVT+Vvjbh7Bp2CP+5K1KUosSLXzLViOolcCMH8ncBx9VaK60gZ+EMZ8Y/YNBu8HJP4cnK8mbfJQPjG8r85jrGGps3G2QiSrMMd6t9qTMH6oAgIBF85CvttURdrbpKNDHXySkR56DLJcGpdzLis=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf3091f-7b05-49fd-49ae-08d5989ca00e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 13:21:20.9310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32DLU6q003859

> -----Original Message-----
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Sent: Friday, March 30, 2018 7:25 AM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>; linux-efi@vger.kernel.org; linux-
> kernel@vger.kernel.org; x86@kernel.org; tony.luck@intel.com
> Subject: Re: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info Structure
> 
> On 29 March 2018 at 14:53, Ghannam, Yazen <Yazen.Ghannam@amd.com>
> wrote:
> >> -----Original Message-----
> >> From: Borislav Petkov <bp@alien8.de>
> >> Sent: Thursday, March 29, 2018 6:55 AM
> >> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> >> Cc: linux-efi@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> ard.biesheuvel@linaro.org; x86@kernel.org; tony.luck@intel.com
> >> Subject: Re: [PATCH v3 3/8] efi: Decode IA32/X64 Processor Error Info
> >> Structure
> >>
> >> On Sat, Mar 24, 2018 at 01:49:35PM -0500, Yazen Ghannam wrote:
> >> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> >> >
> >> > Print the fields in the IA32/X64 Processor Error Info Structure.
> >> >
> >> > Based on UEFI 2.7 Table 253. IA32/X64 Processor Error Information
> >> > Structure.
> >> >
> >> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> >> > ---
> >> > Link:
> >> > https://lkml.kernel.org/r/20180226193904.20532-4-
> >> Yazen.Ghannam@amd.com
> >> >
> >> > v2->v3:
> >> > * Fix table number in commit message.
> >> > * Don't print raw validation bits.
> >> >
> >> > v1->v2:
> >> > * Add parantheses around "bits" expression in macro.
> >> > * Fix indentation on multi-line statements.
> >> >
> >> >  drivers/firmware/efi/cper-x86.c | 50
> >> +++++++++++++++++++++++++++++++++++++++++
> >> >  1 file changed, 50 insertions(+)
> >> >
> >> > diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-
> >> x86.c
> >> > index 863f0cd2a0ff..a9ab3bbf7986 100644
> >> > --- a/drivers/firmware/efi/cper-x86.c
> >> > +++ b/drivers/firmware/efi/cper-x86.c
> >> > @@ -3,15 +3,28 @@
> >> >
> >> >  #include <linux/cper.h>
> >> >
> >> > +#define INDENT_SP  " "
> >>
> >> There's that thing again. So it was a total waste of time discussing
> >> this last time. So let me save my time this time:
> >>
> >> NAKed-by: Borislav Petkov <bp@suse.de>
> >>
> >
> > IIRC, the arguments for keeping this are
> > 1) convention for CPER
> > 2) code readability
> >
> > The argument against was
> > 1) it's dumb
> >
> > So I decided to keep it. I don't really mind either way so I'll change it
> > if there's a second opinion.
> >
> 
> Yes, please change it.

Okay, will do. Should I include a patch that changes it for the other CPER
code also?

Thanks,
Yazen
