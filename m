Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AIpwx49VQ/wpwO9DDRWGYjwXZ3iJ88pKXZEHkJ7yglmONu3iSklOvlLfb5SviPJWywYQG/dS7HKA
ARC-Seal: i=1; a=rsa-sha256; t=1522874802; cv=none;
        d=google.com; s=arc-20160816;
        b=UXmPZqhcQ+VSBU8ckbXiFeSUn2EtnJCITzVZo8EW7UIKsXc6u/JJiEeL8fH60MIGd2
         MlH9a4IQe044l6Q2nuXzmwp3Zu/FpxR68ZnVsmxlLQRMTgkKqDWD95c3BxzJZfQ0q2N8
         9z4II49hfSDoZ1BvEUmwuwjSF2EaOe4DQ3J31Xf4g8QGvdsBAVWwEbau6G8XwCKoS99x
         M3VJy/4N9O9BjqMsXAMdez0OOUJ+c7t2v+iF3hmtGecZgZLWxrPTmFQSacWyt00+xVA8
         acncUQrxarJkKYAIS15HKK4NNX+3I0boIsO3/+jXMPDfVUYJ63CXZt2aC8a5l4vVWvWq
         cWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=cdeUxvlZn1TSG41XOhk381Q39G/rDiW4aQnRjZyun2U=;
        b=cDydBSYkAdZH11fH3+VNUF42KfkazThpTcNdlolVHujc3+ED+vvmLGy2UprerGSTip
         MldJ1iV7Z/tKLLbDEVyMTpFoUSxGFeT6l7pxokdQUYaKiWcAJl6RyCRQS2W7VrV6ixxz
         +aSngqiiXIRFGl6ZQWDoVurFNSBbx5J0gpHpAWYe8PQqZhJj+0pApGM8ZK0Cl2sZh5TR
         gW9bt8TQsytjGYcoH/eBx4VkdJ4d/UzUegmYXZGIzRenSuF788UViSjmfcbVfoIAeV31
         hzwRa8dicieq+A6m2EZdEOD1qzvpuFQ5taw5UmzDdm/cY1GGz+8DoMcwZ333ITH/Rfo2
         dgvw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Sro2tG9a;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.124.103 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=Sro2tG9a;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.124.103 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Dexuan Cui <decui@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>, 'Greg KH'
	<gregkh@linuxfoundation.org>
CC: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>
Subject: Any standard kernel API to dynamically allocate/free per-cpu vectors
 on x86?
Thread-Topic: Any standard kernel API to dynamically allocate/free per-cpu
 vectors on x86?
Thread-Index: AdPMU2bePo5Nuk30RL6D7Rk31Sbv+Q==
Date: Wed, 4 Apr 2018 20:46:16 +0000
Message-ID: <KL1P15301MB000638051CC8DC7FD2A2E74BBFA40@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-04-04T20:46:13.0776287Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:3::45a]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0038;7:EVidygWofgTm09ThDNoFhHABxRGnVA2qXF1EtRMYaMCXvfgis+ufXisZL6oi26qHmyN8u/2WvGOxy20DH8ur5iMIwy21akyMenxVq9FVB16TDTalJP5zGj1zJs9IjDxTLNx7YWvaZ81NQr4stxiCjCyahtQKSSy+h37POAc1+nKMhQbW7YKW8TZF4vLxpT6X/dHtKHVi1SKLTFlA990KYnjuFMhiF5oaK2jk6XXwftHtFt3XsyD4QwUJG6J3VWOh;20:4abD/vc9O/bcqnWNzs+xkL6jZ27Xmb9cjZ4ejnf6YSZTvg37RB9R0l+zcUhoeB77VSVOxsfuQ/I2VzrUBGzqEZ6FfM+Xrw1dgAQWS1zgwivFFkb0E0POXtGnQDV69+u/qq3R7rAhsXvCY3QoUDRUC0XFzbqjPBODSSFKRM95rV0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6711d04c-e2f5-44cf-63dd-08d59a6d1cb5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0038;
x-ms-traffictypediagnostic: KL1P15301MB0038:
x-microsoft-antispam-prvs: <KL1P15301MB00386235815CE77721B7B1F5BFA40@KL1P15301MB0038.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:KL1P15301MB0038;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0038;
x-forefront-prvs: 0632519F33
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(39380400002)(366004)(396003)(189003)(199004)(53936002)(77096007)(102836004)(6506007)(86612001)(86362001)(46003)(7736002)(97736004)(305945005)(74316002)(25786009)(14454004)(10290500003)(10090500001)(106356001)(186003)(476003)(99286004)(7696005)(105586002)(8990500004)(478600001)(3280700002)(486006)(3660700001)(110136005)(54906003)(68736007)(33656002)(55016002)(8676002)(81166006)(81156014)(8936002)(316002)(9686003)(6116002)(2906002)(4326008)(22452003)(6436002)(5660300001)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0038;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: GbGppkvKz6cxEuCEZpuVnNiiMzLDuUMnVpn3m04yJrTrHVbT3ovSAQmMjpf4vid4H8p+TyrAhoEks9NDL0Kk/k17P6XX6LtMmRaISkwOdlDfq8pyGS06vtwm8jgKBg//1vgA5WsZMwcua10oCkRpmLLutSjwJ9ySA36r21ZjoHJ0HBB0s9TkbL3bHiqnRmWiTkbeh6KqIz5MyeEBszGsDNXlIMOVsBaXlak9hz0fjqt6A0CMMmpcULZal5e0/cnwx9RxX8wT7jLMopTeyJUoctYEU5JaNOZUXoUP2hAeFBivpDJFKQnDdE9DWIgXyYmzREgtHH7dAvZ+RQo7dTpH3UiLrY/WSzknD48mhrvQuoXc8QyKe4xaEAS3/ttVmgwMjV4CmrXysHFqeHMgEgfMr4LdH3WC8dHa8MjPa1PeOmI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6711d04c-e2f5-44cf-63dd-08d59a6d1cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2018 20:46:16.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0038
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849968280484666?=
X-GMAIL-MSGID: =?utf-8?q?1596849968280484666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
Recently, two Hyper-V specific vectors were introduced in
arch/x86/include/asm/irq_vectors.h:

#if IS_ENABLED(CONFIG_HYPERV)
#define HYPERV_REENLIGHTENMENT_VECTOR   0xee
#define HYPERV_STIMER0_VECTOR           0xed
#endif

What if we need more such vectors on Hyper-V? This static global reservatio=
n
mechanism doesn't scale, IMO.

Actually I believe we don't really need to reserve the same vector on all C=
PUs,
because the model-specific registers (MSRs) defined for Hyper-V synthetic=20
interrupt controller (SynIC) are per-cpu, meaning each virtual processor ha=
s
its own copy of these registers, so they can be programmed independently.

That is to say, we can use different vectors for the same Synthetic Interru=
pt,
as long as we're able to dynamically get a per-cpu vector for each CPU.

I'm wondering if there is such a standard kernel API on x86.=20
As I skimmed through the code, I haven't found it yet, if any.

PS, the background of my question is that: in the future Hyper-V will
support multiple VMBus drivers running simultaneously in one virtual
machine, and I think it would be better for the future secondary VMBus
driver to use a different synthetic interrupt, which I hope can be
configured with dynamic vectors rather than a new static globally-reserved
vector.

Thanks!
-- Dexuan
