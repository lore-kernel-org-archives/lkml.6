Return-Path: <kys@microsoft.com>
X-Google-Smtp-Source: AB8JxZrPzGGDR9sCF7rWMpvUkBBIWy/5oP4nfchEG1Z74CjQTCKzHKmc5x/U7MMEFmY47uK+vZmY
ARC-Seal: i=1; a=rsa-sha256; t=1526114271; cv=none;
        d=google.com; s=arc-20160816;
        b=UQO1i/YKu6HGMRN154LKXJX8LfRziYF4hlRxIrIQePOYdT0pPGHwV14Be/FmjLhoh4
         V3WRcYWQVwnypTa/Nj6FspJjqxu0AG/L0TOWsfib/qBBUBtZE+CKTUcyQnmNAQT2DWBf
         fpkB3U80l4S860fj82z15GSzMCVvCBu+bSCs7m5R91VLTmZADNwK+as7hKtvRyc3WyVx
         8RtbNgAWc0a6wDpr9Ki+dzEhnAhwuzAboSh5pKOHu09+9f/EVvp57ZPlls8J9V3YupIa
         ipCGJAN7rVu2C2GMEYcCYBIPaG14mcs+wFnTuFkaYJbT5AOGs3H01rQJM7vj1fEOWd+g
         bopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:to
         :from:dkim-signature:arc-authentication-results;
        bh=cttAiuGzglrNgCWFz2L4AxxPuq72MFYcnydVkPDY9cA=;
        b=m2fyIyimZeG/b16ljpxFKX47eeLJPnfD2FWIIwesqoCXrGaNRFFo0FZFU7LHaE+b09
         WeUOifYr2sr+H8pibBnaLzgCyanXpe+tHAC5ikQMkkGsihwBc0wGt6uQTFY0ss/9mCnb
         PDJ1+yl5KEgFZMpoCwp5f9b9iTDBi7a08lXHtSDLOlKwT2eWBIENC45WtSLJXtAMQuGv
         nLh9Nu/I7HvAId4IZouN34EkdJcTS9fJnm991y2OPIatuED0RpT0DW5HXLHhLe0BVNhj
         VxAIz2l/D2mUENOZTbzCGBDVGMbYT8waXhvI49PJgRJUgjZPA+iVC2oXLizKERlxcvFk
         GIow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=art+rjw9;
       spf=pass (google.com: domain of kys@microsoft.com designates 104.47.32.121 as permitted sender) smtp.mailfrom=kys@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=art+rjw9;
       spf=pass (google.com: domain of kys@microsoft.com designates 104.47.32.121 as permitted sender) smtp.mailfrom=kys@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: KY Srinivasan <kys@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	"olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "leann.ogasawara@canonical.com"
	<leann.ogasawara@canonical.com>, "marcelo.cerri@canonical.com"
	<marcelo.cerri@canonical.com>, Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH char-misc 1/2] Drivers: hv: vmbus: Remove x86 MSR refs in
 arch independent code
Thread-Topic: [PATCH char-misc 1/2] Drivers: hv: vmbus: Remove x86 MSR refs in
 arch independent code
Thread-Index: AQHT5mTeFHs0S8tFEE6HonExa6h3IqQry+KQ
Date: Sat, 12 May 2018 08:37:47 +0000
Message-ID: <MW2PR2101MB1113AED36F49875BA729D671A09E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <1525739851-54919-1-git-send-email-mikelley@microsoft.com>
 <1525739851-54919-2-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1525739851-54919-2-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [210.13.83.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0938;7:H+4ini9sRuyVqOu4cVDty7Lz4Kufl5/fDzTMu7Dx+VB4f72xHA4Xi/dOdqYVeYsQfVHkhl1JE1V3L1wWQn8JO0uvm6By9gkKYVXbxtryHW9xfSCZXoiOrziJUMOzrD8AhkZKbFB4c5COU3g2Dxkv2VDliHrrj6xJipfbG3HFQUwMe9j/OBgJL2vSUW59kf5iKcGR+ly70aPejafhckIBOPD+9guAKmflrQLqtKmshVbAAxQFGvuMN+wiJNrScLND;20:EOiUP1IEcU8Xz9FtJoIgODu3YKYNT22/eNZGKP3iRqqhni0KMBCurY3BS2Z200+QxDIG0tY3ezyWe5uY/q1jH6OT3IRRLs/488MjKOdT485VqTo+eUXkVcHBS1olpt7YiJVxL8v7YhYhwAq6AfLLyzI87iXKh/HXWGjwH3BzRgo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:MW2PR2101MB0938;
x-ms-traffictypediagnostic: MW2PR2101MB0938:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0938334F8C5257997BD04924A09E0@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0938;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0938;
x-forefront-prvs: 067071EFC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(39380400002)(396003)(366004)(189003)(199004)(13464003)(97736004)(8936002)(2906002)(476003)(110136005)(11346002)(446003)(6116002)(53936002)(3846002)(25786009)(14454004)(6636002)(486006)(105586002)(6246003)(10290500003)(478600001)(33656002)(106356001)(6436002)(68736007)(3280700002)(229853002)(2501003)(5250100002)(3660700001)(1511001)(55016002)(7736002)(74316002)(66066001)(6506007)(7696005)(99286004)(86612001)(53546011)(2900100001)(102836004)(22452003)(86362001)(10090500001)(316002)(9686003)(81166006)(81156014)(26005)(8676002)(2201001)(76176011)(8990500004)(5660300001)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xdYu0wMdE9x/4SOdNiw3czAwCn9cLScqtAeK7dl9I48NL0WqLz+f/rPwq6v8odyDSe6lVPW7+k2bVyo7oLnEAytKd67G9faaz717Yl+AsyprUEdbBqGj4jEpHNKmUKd12/XmFpNWEnKLkwl857JBLQcHr6TlByWuORGpoHnRtAm7OAyzlvvvuRhBZP9sdJbV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7ea9b57b-5e12-4369-876d-08d5b7e3a404
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea9b57b-5e12-4369-876d-08d5b7e3a404
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2018 08:37:47.8762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599854238222252131?=
X-GMAIL-MSGID: =?utf-8?q?1600246798225576759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: mhkelley58@gmail.com <mhkelley58@gmail.com>
> Sent: Tuesday, May 8, 2018 8:38 AM
> To: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen
> Hemminger <sthemmin@microsoft.com>; KY Srinivasan
> <kys@microsoft.com>
> Subject: [PATCH char-misc 1/2] Drivers: hv: vmbus: Remove x86 MSR refs in
> arch independent code
>=20
> From: Michael Kelley <mikelley@microsoft.com>
>=20
> In architecture independent code for manipulating Hyper-V synthetic timer=
s
> and synthetic interrupts, pass in an ordinal number identifying the timer
> or interrupt, rather than an actual MSR register address.  Then in
> x86/x64 specific code, map the ordinal number to the appropriate MSR.
> This change facilitates the introduction of an ARM64 version of Hyper-V,
> which uses the same synthetic timers and interrupts, but a different
> mechanism for accessing them.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 12 ++++++++----
>  drivers/hv/hv.c                 | 20 ++++++++------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h
> b/arch/x86/include/asm/mshyperv.h
> index b90e796..caf9035 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -75,8 +75,10 @@ static inline void vmbus_signal_eom(struct
> hv_message *msg, u32 old_msg_type)
>  	}
>  }
>=20
> -#define hv_init_timer(timer, tick) wrmsrl(timer, tick)
> -#define hv_init_timer_config(config, val) wrmsrl(config, val)
> +#define hv_init_timer(timer, tick) \
> +	wrmsrl(HV_X64_MSR_STIMER0_COUNT + (2*timer), tick)
> +#define hv_init_timer_config(timer, val) \
> +	wrmsrl(HV_X64_MSR_STIMER0_CONFIG + (2*timer), val)
Why are we stepping in units of 2?

K. Y
