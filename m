Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524810865-2-15987109959053985345
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524810864; b=afQxDZgjkQtLCby41VPPyxaIF0lfFRuCdm1+WUr1YsGr6OjhG9
    YFoWz1CsytY9NHJ4wB/ZN3/DJjs0daCDb3IcjhyFnTxrNFVZ6eQ5NKAd7SdlQCAh
    SZDC1AV0pqoCxKzuVU9K6e8vVVFnWupvX2EUv+A9DQcCfxHFzJr5jc95ajTjJEvM
    Nqjg25J1R9CGcqauvxl+oai/FaYs1KFSjGD3e3NdGfqggQqTcaaBJzuSqPPQQP53
    reeNcJZzoqKkzEjzf5GWZykvlk6Na0hgiW+8twU807zPXOzfkEMcFkj8QtSZ+BGX
    7Gc0eJZQ+QhOxJFSzrb2/0xbc14rr9Fqlf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524810864; bh=GI0Iw
    ADU5SpgAkB7XrWsm3P+6+2+AbdLJ+cKasSbnU0=; b=GfuLuBdPxf7qwkfdkTIpJ
    5XzAO1XC2vpsXCflhYwJQk29HdF5b891jfNyAKioTU9H7BEpMQjtUS4JxEAO0vec
    VE2CQ5zotABsDTDsmN3wuoHLGBlnrIibJkXS28oZdnB+r4ilXDVdekpyed+Ind2W
    sxDekATrPC2aZDVa0wbuB+PQtg6e7avgo6Lt949Wzi2ggdBzR/OOmcljWxeVplYk
    TUAH9+JbQoxeZHW7VcygBBDAp9I7auuTwpF4sXodEVZgdwudBLpHrzTauj7WVbKD
    GtvI+mLaa35ORfgW1LYJ8sQWRpfM/0ViTjmVKFsMVwPU3yivgjgGi4pbiXT5giSn
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fbfxgaIc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=fbfxgaIc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNrtvNv3iD4FvthUPZ5c2EmRi/FnEeFaG4tgD1GvRAhrokOdEBE+xIEcBsFkKfQFyYtD/Ho0RG6OOEXAm+yJBKHzlehKi2o52IpA1YwMCua+yFKc1zDV
    6OzkPjwEm4X0zzqHD/rDzWlzH4dQBja+2giYInbupA/QPdP08HyPbnNgmtcRXB9ruzlZ87rmbDDd3U1+3tkSqyP1r+d0o1vAF279BWKuy99K+cGu+g4DcuuK
    C1YWgsB9PdUbWgEIi/hGyg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=2_GqYZIPIjsA:10 a=P6MAjPsMllQA:10
    a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=Lf-vpJhqX20A:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8 a=DfNHnWVPAAAA:8
    a=20KFwNOVAAAA:8 a=oGMlB6cnAAAA:8 a=Odnh0R2cAAAA:8 a=vKUCQJIjSeRXIHOg_PsA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 a=rjTVMONInIDnV1a_A2c_:22 a=NdAtdrkLVvyUPsUoGJp4:22
    a=lNAA6UHySJB7qmBR1x20:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: KY Srinivasan <kys@microsoft.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Topic: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
Thread-Index: AQHT3MEu4uYWJdgpmkipM8S1SvacPaQTknWAgACXPsA=
Date: Fri, 27 Apr 2018 06:34:11 +0000
Message-ID: <MW2PR2101MB11132C0482BCE3524713C435A08D0@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180425181110.8683-1-kys@linuxonhyperv.com>
 <20180425181250.8740-1-kys@linuxonhyperv.com>
 <20180425181250.8740-2-kys@linuxonhyperv.com>
 <20180426213148.d5udlgzgbvtym25p@mwanda>
In-Reply-To: <20180426213148.d5udlgzgbvtym25p@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:3d34:9b63:3fe:d485]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MW2PR2101MB0985;
 7:nv591sdp2/pHnBC2174QTaM2BskN/tRIT7hY2TbX8esO3QwpnhP/XCbJd5kDc7gfK+KtRWN70ybG6zegy+A907kk3lm++oaLCPIN2Tcgre29AEJCQ97l5n7v0wJqy8AlEIyjNcCta2/xXH68dqRzyvmZmR+/5KM47/00nauLPVW6NuJw21PhzDxb6iUkZetFbTMYR0yR2ZpwK8IjeNGugfjsq58E8llb4TpjiiwzJhRjMnyF6HX2RERfgcFKd9pa;
 20:tgyZLqJvtaQ3zu7+dqJyRh7CxrGb1aNkhycVkzAE+KG417J32m1XcEc/17h5r4YrObCyGQlkv30O0goJ2zLsXiqAfzhjxVDEC3NgLLWuaD+iSzns7ej6ogG88Dm29KvVVjyH0Q7SuS15S++vfG9ynktVCFM7I99vPopsNAwU7Y8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);
 SRVR:MW2PR2101MB0985;
x-ms-traffictypediagnostic: MW2PR2101MB0985:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0985385286804544267DBFE0A08D0@MW2PR2101MB0985.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);
 SRVR:MW2PR2101MB0985; BCL:0; PCL:0; RULEID:; SRVR:MW2PR2101MB0985;
x-forefront-prvs: 0655F9F006
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(346002)(366004)(396003)(376002)(39860400002)(13464003)(199004)(189003)(11346002)(106356001)(229853002)(186003)(5250100002)(486006)(7416002)(97736004)(2900100001)(446003)(316002)(22452003)(99286004)(476003)(105586002)(46003)(6916009)(93886005)(86362001)(6116002)(6436002)(3660700001)(33656002)(2906002)(86612001)(9686003)(10090500001)(55016002)(14454004)(8990500004)(68736007)(305945005)(53546011)(7736002)(102836004)(74316002)(10290500003)(6506007)(7696005)(5660300001)(76176011)(81166006)(478600001)(8936002)(6246003)(81156014)(8676002)(4326008)(25786009)(3280700002)(53936002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW2PR2101MB0985;
 H:MW2PR2101MB1113.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
x-microsoft-antispam-message-info: q7N1nYlM0R+lXxMeE6OQuxEWT3rJDj6lAhImh1RDkwtA2ue7gLEyMBiF/4Ni4tt8TGiTu0OCut8SAP1IphXicRoxCyNk7ugTekssXxkwC3G0+K0WZWRuFH576qMq8gErj8WhrPOQYtgp40bJN65vjbHMNh8cbmp0XfYM4p8/Wlm/AxHWiknQ8Fzxsk/Gf32Q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d649e532-af56-4ed5-deb3-08d5ac08e37a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d649e532-af56-4ed5-deb3-08d5ac08e37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2018 06:34:11.6908 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0985
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Thursday, April 26, 2018 2:32 PM
> To: KY Srinivasan <kys@microsoft.com>
> Cc: x86@kernel.org; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; tglx@linutronix.de;
> hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Subject: Re: [PATCH 2/5] X86: Hyper-V: Enable IPI enlightenments
> 
> On Wed, Apr 25, 2018 at 11:12:47AM -0700, kys@linuxonhyperv.com wrote:
> > +/*
> > + * IPI implementation on Hyper-V.
> > + */
> > +
> > +static int __send_ipi_mask(const struct cpumask *mask, int vector)
> > +{
> > +	int cur_cpu, vcpu;
> > +	struct ipi_arg_non_ex **arg;
> > +	struct ipi_arg_non_ex *ipi_arg;
> > +	int ret = 1;
> 
> Not specifically related to this patch, but hv code sometimes returns 1
> on error or U64_MAX.  It's slightly magical.  Maybe
> HV_STATUS_INVALID_HYPERCALL_INPUT (3) would be more appropriate?
> Or we
> could make a new more generic error code:
> 
> #define HV_STATUS_INVALID        1

Good point. We will look at cleaning this up.

Regards,

K. Y
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
