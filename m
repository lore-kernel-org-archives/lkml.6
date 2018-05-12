Return-Path: <Michael.H.Kelley@microsoft.com>
X-Google-Smtp-Source: AB8JxZpr4dpmEjgirtch6c2YomhBAVNNGagIcF/6sUVreEQq0wW/TCPLUOmz3sDc66rnVDUKQZs+
ARC-Seal: i=1; a=rsa-sha256; t=1526129743; cv=none;
        d=google.com; s=arc-20160816;
        b=Jx4bx2+56aIJwByn9R0daFzD624yd6xedJAZ7y7x4M2MfUvniL8SXVoCZSXkVfu/EN
         QmjQaL9Nhl/qNl2QBKfxIRtMJxpiozpEHzRJnzSylWN2/7kkkP0woqUaGbgmhkG5sZ8M
         C6MFK1Gv4/uxiRInjCPzx48Uy8BdlBNfZVXBt36qA1F+Ow9PV79jL7U+PX7AoFGnPI1B
         uFHpM7Yzc4f2n9CoPAlaVy/+DzIEbjgSGXDeMQsn91j8XnDL/uGqRqgyOwnAV4rnBELn
         ccPDKgT0sR8m1cPSfuJweHmgi4R/1vBrNhDkdoxzGc7UuOkl3DwDqugOS/gqT5e2dd/G
         gx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:to:from:dkim-signature:arc-authentication-results;
        bh=X+GXw02274dgUKFxLwanmm6q/UzcuTwYov/sio+wdB8=;
        b=sh2UO8GGFFM331stEL1/jyI8O7e21u5CRWc9TU3ha7jaV0PGzwwQnXM6z6MhFEjXe4
         c3GYWPqbs6qEe8/souFDwvG96+2hlFOFwzWTSHgCzMwP83Pithu4mrqnIYXKboZRkfT7
         2OG+6BIldCHcy3+5lW9igsV1r56acrw70pBiGgvoQdY1FS7mNsioTVCLXhT6AJg+Azi1
         aIYk7PlJpCpQYMPklJR4992Gt2z7+tDu028yfkT3rnzQVkU3IiZ+mtZw3DRVjYajlaxa
         HwwGAN04O3FPnzwU72MogkXt1dW4cFgN+xKO/tJNaG0fCxjsPL9Y9bTS2ttcIkUfMsT+
         9A7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=AOFUH2Ma;
       spf=pass (google.com: domain of michael.h.kelley@microsoft.com designates 104.47.41.132 as permitted sender) smtp.mailfrom=Michael.H.Kelley@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=AOFUH2Ma;
       spf=pass (google.com: domain of michael.h.kelley@microsoft.com designates 104.47.41.132 as permitted sender) smtp.mailfrom=Michael.H.Kelley@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>,
	"apw@canonical.com" <apw@canonical.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>,
	"marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, Stephen
 Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH char-misc 1/2] Drivers: hv: vmbus: Remove x86 MSR refs in
 arch independent code
Thread-Topic: [PATCH char-misc 1/2] Drivers: hv: vmbus: Remove x86 MSR refs in
 arch independent code
Thread-Index: AQHT5mTh/2/f9124gEKaSv5+XL+NsKQrzDiAgABFcUA=
Date: Sat, 12 May 2018 12:55:41 +0000
Message-ID: <SN6PR2101MB1120399369011D3C4E5E2017DC9E0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <1525739851-54919-1-git-send-email-mikelley@microsoft.com>
 <1525739851-54919-2-git-send-email-mikelley@microsoft.com>
 <MW2PR2101MB1113AED36F49875BA729D671A09E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1113AED36F49875BA729D671A09E0@MW2PR2101MB1113.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-12T12:55:40.0718670Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB1101;7:trLhjXtJbvGJVpChQm3Mk3EFWoKLhxCUPhmYgNKKwU/eIB9JxleRWaH4A9Z7d2LgF0gVeEcksWgFpsVq6q9MpP0splC64H4rFjYvmJbm3z9Grp2CnXbVmG75k0zNtSHc/YqUZ37mrisQXygoKSmB2/CT4B8tvslxgRvGJRAP3mmXd5a4b01Sk7Kt0vj9r5D2agTObDwHrTLlSF4A08mmrHUewgMxl6PvpfWWN2mQCN0TH6Xxc9Zh+AWKHfpEdHbv;20:DK0pjL2c2zOrO6ca0zhJtDYoBJ714dvzXyEsK5TOHMJqHAaLfoDWlrzn8FE0HLbeiShHlHQm7Om9xV/wVz43xXCtIKd8/mMo7QPfpP4tT1nO0RSn3qYJjThjeJeFLYrazpB+vN72FSz5b1Carp5w3TzWS17Hfs0t2I0rXJezP0k=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB1101;
x-ms-traffictypediagnostic: SN6PR2101MB1101:
x-microsoft-antispam-prvs: <SN6PR2101MB110135FD0D539E778B4AB239DC9E0@SN6PR2101MB1101.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN6PR2101MB1101;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB1101;
x-forefront-prvs: 067071EFC8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(86362001)(22452003)(486006)(66066001)(8990500004)(8936002)(76176011)(2906002)(72206003)(7696005)(5660300001)(99286004)(229853002)(478600001)(33656002)(110136005)(2501003)(2201001)(6636002)(316002)(97736004)(68736007)(6346003)(3660700001)(3846002)(3280700002)(102836004)(6436002)(6116002)(11346002)(74316002)(446003)(2900100001)(55016002)(1511001)(106356001)(26005)(81156014)(86612001)(5250100002)(305945005)(14454004)(53936002)(6246003)(10290500003)(7736002)(8676002)(105586002)(81166006)(10090500001)(9686003)(6506007)(476003)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1101;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: be2A2VUh/NbEeWg6PX0XNTzwJXFjcXN37HRqDJ4NkPwdhCVHZ+jV08QAeiLLvSlRaqDwY1jTTagFA7cBCzezsDFb82ecFFqb7cDqxrjhbVx9OlV7CRF+58LaLrjKGKpKoZ+NvDJ4kM4DrOKFz6Hzph0d7WFylnu9RgbUygs6R13PBh2dPzTpYxKZLp+cbZx1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dddbc88b-3e03-4a76-6ea1-08d5b807ab05
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddbc88b-3e03-4a76-6ea1-08d5b807ab05
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2018 12:55:41.4773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1101
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599854238222252131?=
X-GMAIL-MSGID: =?utf-8?q?1600263022731720718?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> > -#define hv_init_timer(timer, tick) wrmsrl(timer, tick)
> > -#define hv_init_timer_config(config, val) wrmsrl(config, val)
> > +#define hv_init_timer(timer, tick) \
> > +	wrmsrl(HV_X64_MSR_STIMER0_COUNT + (2*timer), tick)
> > +#define hv_init_timer_config(timer, val) \
> > +	wrmsrl(HV_X64_MSR_STIMER0_CONFIG + (2*timer), val)
>
> Why are we stepping in units of 2?
>=20
> K. Y

The register addresses for  the *_CONFIG and *_COUNT registers
are interleaved.  From hyperv-tlfs.h:

#define HV_X64_MSR_STIMER0_CONFIG               0x400000B0
#define HV_X64_MSR_STIMER0_COUNT                0x400000B1
#define HV_X64_MSR_STIMER1_CONFIG               0x400000B2
#define HV_X64_MSR_STIMER1_COUNT                0x400000B3
#define HV_X64_MSR_STIMER2_CONFIG               0x400000B4
#define HV_X64_MSR_STIMER2_COUNT                0x400000B5
#define HV_X64_MSR_STIMER3_CONFIG               0x400000B6
#define HV_X64_MSR_STIMER3_COUNT                0x400000B7

Michael
