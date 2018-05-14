Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AB8JxZpRMWNGIDX+PLRu7+61q1ovN4+SxPeL8QTxDDEtPsVCb73ODNmGs/qNDwSlqRb72zur4GIE
ARC-Seal: i=1; a=rsa-sha256; t=1526321669; cv=none;
        d=google.com; s=arc-20160816;
        b=WgBbLe35oW4ECBL6+lPDj2v7tz0iemEP5igV6SDtv5HKgu9DxqQOAui7TUhmwEcnwO
         eAzLVCmZuBW0JU/IRAy0kqv1fgFX18DrZxRJ/o93o2BkVFFVRoLDJ3Rh2tS8sGsFBhfr
         7QsezEw7v+oAefSTEX5R/X/59fH2k2IdN/AqIXAEDWHYLuzU3WlHTzLDOPjQwFPD2rLa
         VdwrCJYip6q87OXMtL1uPuXSKzgR+yAOFvEsv4XlM9Zfqf1NB7U4S1U3iQhcsnCD5Aji
         c++fxQ1R1igHNvZnswnj1v+rReRp9FuNT0ay87htHAETt0fGB87u5Q2kTZcgFst5LcuD
         xsuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=LThfQz0kgyPDSmneMnVkFc+/bpb+xkKKpnNnitGaCrY=;
        b=x44F+xD0MVLqd/0cCC7SaK0ukQvIiAPw62wE5w4cu4PLEJp6aLttqj6MJ6mmXGDecN
         iOxyb7Z7tkDFYL8cK+xJB3fEOjADhel7KrImm/4qAQTbWkSOIvXkVo4rrkwvrMIUzhFf
         dR6h786HCM5LbANnnq2inhM+bsCYlLM8AI9isBBAd3g26vgVRedb27x1Vpj4z0XAl5VY
         SI61WaJAy5IoqFuMOkCISsxWA4r6Dagh0/PLP9IL6NoB3ENO0CYL1ApK1uQi2sqJiLhl
         QMhA0yAAe4d/8KXfioxAELyU5YI01e2NY4DciXTRnhdHs5UgfXBNUYVbNx6gseXLEZcm
         9uaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=R7vB81vN;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.125.138 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=R7vB81vN;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.125.138 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Dexuan Cui <decui@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "kys@linuxonhyperv.com"
	<kys@linuxonhyperv.com>
CC: "olaf@aepfle.de" <olaf@aepfle.de>, Stephen Hemminger
	<sthemmin@microsoft.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Michael
 Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>, "apw@canonical.com"
	<apw@canonical.com>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version 5.0
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: enable VMBus protocol version
 5.0
Thread-Index: AQHT6dQOF2Jt1OtZ802pCkKtamiImKQt6r+AgAGeN0A=
Date: Mon, 14 May 2018 18:14:15 +0000
Message-ID: <KL1P15301MB00063E97D759B64F1CEC046CBF9C0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180512093033.12325-1-kys@linuxonhyperv.com>
 <20180513102409.4adc5200@xeon-e3>
In-Reply-To: <20180513102409.4adc5200@xeon-e3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-14T18:14:12.8851748Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:c::70b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0053;7:SW/zeP9UdqhT29Y2m/VEzWvLzzsAXI4+BrnnJfzS2qvdfmPY4DKrA2c/IQeYRmknUiAHbIeCnq3rHrF14PQtTOWj6EXnp0VmDDWj7ZK0k1rCf288D2BJgLjZC9Y9TP2BmMy0CXo4uSbvivUE8pHBai5enjmqVcG9yQMnEzqRKYXsr093xYTU0XHC38+lHXjDI88rYhw3I6GIUCOR+Go8t7B5Np5W0NA5hR4pB0J7y2ms50CIFt274e4ofuxdoH7v;20:bQunO1Hq1wdhXqDmwZNfoxxjz5o90AC++l5txh+uz0EW3C3JoomqO12BI7wNleqBQj8R22xw9UcMJWL46wUN6/vtlidM15HxFMzgbQXxsh1AVDUzQvE6BYcX/nK2Oq/0uI7yV0TEHS7mngzcYsXL3GtkUsy5Whl8SDRl8LTmwFo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7193020);SRVR:KL1P15301MB0053;
x-ms-traffictypediagnostic: KL1P15301MB0053:
x-microsoft-antispam-prvs: <KL1P15301MB005343DA121151008DA98613BF9C0@KL1P15301MB0053.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:KL1P15301MB0053;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0053;
x-forefront-prvs: 067270ECAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(24433001)(74316002)(97736004)(77096007)(186003)(4326008)(68736007)(6246003)(7736002)(102836004)(6506007)(76176011)(14454004)(86362001)(7696005)(22452003)(10290500003)(478600001)(9686003)(8990500004)(86612001)(2900100001)(305945005)(10090500001)(99286004)(25786009)(54906003)(110136005)(316002)(53936002)(3280700002)(476003)(486006)(8676002)(3660700001)(55016002)(229853002)(8936002)(81156014)(11346002)(446003)(6116002)(81166006)(46003)(5660300001)(33656002)(2906002)(2501003)(105586002)(106356001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0053;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9tbOhMFZd5b0vfTpClLyqyoObZCisXrLOdWK4f5ohnLE1YGdxgmLi+XWn/I3wqyNqF4pPGs0JPIl27SBHyMSII4neZJXQZCWg9jZFT3uzTSSsJthRmyug47yc7gEq9sk/Xxeq4VZfWTBWSmM7Tnt32M/wpxCOsjLaeg18bW4fp/kr0sT6aBr9byOHtJFzDLoDy99Mc+epOZNN7gXccYgZw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0280e6c7-c938-4b8d-6fe0-08d5b9c680c0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0280e6c7-c938-4b8d-6fe0-08d5b9c680c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2018 18:14:15.2006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0053
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600250180438237407?=
X-GMAIL-MSGID: =?utf-8?q?1600464271184133759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
> Stephen Hemminger
> Sent: Sunday, May 13, 2018 10:24
> > ...
> > @@ -372,6 +400,18 @@ int vmbus_post_msg(void *buffer, size_t buflen,
> bool can_sleep)
> > ...
> > +			hdr =3D (struct vmbus_channel_message_header *)buffer;
>=20
> Hate to pick o the details, but buffer is void * so cast is not necessary=
 here.

Yes, it's unnecessary in C, though it's necessary in C++.

I found the patch went into char-misc 4 hours ago, so it looks we may
as well leave it as is. IMHO an explicit cast is not a bad thing. :-)

Thanks,
-- Dexuan
