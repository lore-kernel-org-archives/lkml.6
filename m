Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-956397-1521939457-2-14809766593415196894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521939457; b=b+zLizYPhY8VE1LOUCjX59W+gCoqJdQ3beWoj5G7XGHm/ZX
    PMRuOdADKs9m0CUJIVXOsd4H6euMF4Gpsv0sSGNPMulcWBmxIAdVexRfXycTEtTT
    MX8BvD/caE+g1/5ghhZBJEstNNfsmGQzRQ/cYT/rB5eQdtU2C/xl4jRvuWmraCTA
    34qDnF+H3EGXSlTnNtIO12MLak91VGR7PwtL+dXEzpd2vwe9DhasRO6vXnME/myf
    vGpL/jAN+BJYZblgYPtz6YGdGIfi1bdr+fuiC500iHW0WXpcD71kshaqAgaLVCQS
    ZdyHooNGJkcr0LrDAZT3peqkh/p/JKi2opurKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521939457; bh=S
    3KCMMIrGR3yCCvEOZvwcVpJPqAEoKvxsxDd8aTllBU=; b=bYlNDflP1bW2o4Bmd
    NfeUKBeK0K4EXrMpZH02kFzZM+grBj3p/O4AYB2p/Xf99Nsbpi9glh/xYPOIfTIa
    kkzVVoogTVk6mTOtkizCCIEcmRHx8Q1rusYguNNPfQG48K2VrnclOErzfZF4crfc
    psNnvoQOu+Gk6GXeFH57ZCJtYY42qLurBjhYPAg26ALCJe2oKBnDky1eSp0GGdT7
    nogOauDTJapFvMr15Lv1+n6+QNEO16woFaiOiElK2KTdFAVQfPxIHHw1cGw2n7YN
    YtVmB/hQ9xb+PDxslQkWbxcXsfPqhQledkrRWMHuVi3sSKkGiEMKK98sk5FWxFv/
    6z1xA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z9Wtdc7y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Z9Wtdc7y x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Haiyang Zhang <haiyangz@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
 "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next,1/2] hv_netvsc: Fix the return status in RX path
Thread-Topic: [PATCH net-next, 1/2] hv_netvsc: Fix the return status in RX path
Thread-Index: AQHTwhBZzy0DeWsSN022dpFRpCYf5KPfm6SAgACCAMA=
Date: Sun, 25 Mar 2018 00:41:37 +0000
Message-ID: <BL0PR2101MB110877CEB926DEB399ABA564CAAE0@BL0PR2101MB1108.namprd21.prod.outlook.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
 <20180322190114.25596-2-haiyangz@linuxonhyperv.com>
 <DM5PR2101MB103003AA72955A6C6AD44D0CDCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB103003AA72955A6C6AD44D0CDCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-24T16:48:04.3236663Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BL0PR2101MB0977;
 7:KyKSBKOYQRUF7S2dBeIv6qLtz8jMDdRA9s6BF/gPCIbOr3/OA0X5atbdTMSfgLb2UEQd+3MKLTRGVl0M8zYyF6fY4zkXl8Yzth3pyYIyD+uOqEr1gdWk6cT6wgeVeBV0IpWj6pzcVHJ9IcA1BN5FLFXcEr3LYyMDSmsMlAK1IZM9II5PtOM7A7brYpu5ap0omRwN0dc+l7lSV6cSf670ly2HFQALtvX59I3EhHOpmnFun40cIWDG35QxiCWIEUfJ;
 20:WGKDRGSBXjaiBWf23zWrky4IWJP3D2cPttfO98QR1HaTBui6up69hhzCdizsXTisD+ZnuDKkyod+JaxyMzJlyUWXuCiTnoKm29RmPiKEp7FTeYHSkxLvColS+n7XiPoh9FzPqUXJdOaw/R40idctt2FU/8Qv/V8kb24ifCdRj2Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc97eaae-af28-438f-8205-08d591e92ad5
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:BL0PR2101MB0977;
x-ms-traffictypediagnostic: BL0PR2101MB0977:
x-microsoft-antispam-prvs: <BL0PR2101MB097744A9E925CEB1E49CE8DCCAAE0@BL0PR2101MB0977.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:BL0PR2101MB0977; BCL:0; PCL:0; RULEID:; SRVR:BL0PR2101MB0977;
x-forefront-prvs: 0622A98CD5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(396003)(366004)(39860400002)(39380400002)(189003)(199004)(13464003)(229853002)(8676002)(66066001)(76176011)(4326008)(74316002)(86362001)(14454004)(53936002)(54906003)(102836004)(26005)(8936002)(6116002)(6246003)(81166006)(6506007)(81156014)(110136005)(8990500004)(53546011)(2900100001)(99286004)(3846002)(86612001)(6346003)(9686003)(55016002)(10090500001)(316002)(106356001)(5250100002)(6436002)(2501003)(478600001)(22452003)(10290500003)(7696005)(446003)(5660300001)(7736002)(97736004)(1511001)(25786009)(68736007)(3280700002)(105586002)(33656002)(2906002)(305945005)(3660700001)(11346002)(2201001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BL0PR2101MB0977;
 H:BL0PR2101MB1108.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-message-info: ZDHp8cyavxvcD5r/78rjb1ggbL8pIyNeBG8pQ2fiG3VIR96E+M3MDQaqQTyZWovWSBkGsN4/2BjczOgGSvsdEuUZCpR8TRqL3zl03ACVAgVuyfWUlSZBBxhNJo3VTYi0STmq0+CQzW91AgmImoWPaiQPvWOZ11f+gu3usXdYxszey7JmZMmG3hM+c3cSJA5ub+miO7cbfILVofXyHVIH15bQ2ntg2PWFi5rA2iMkbdGkUkT+YjCD4ySv4mGhCrskiXA7oZyxRxUzQycG25FHxTrtVqUBIJuL3m0sBLMKOerPXXRT24kvtlSC7znFdCxx3A+RlKPFmrtPGymWvuja6g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc97eaae-af28-438f-8205-08d591e92ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2018 00:41:37.2994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0977
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Michael Kelley (EOSG)
> Sent: Saturday, March 24, 2018 12:48 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>; davem@davemloft.net;
> netdev@vger.kernel.org
> Cc: KY Srinivasan <kys@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets@redhat.com;
> devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH net-next,1/2] hv_netvsc: Fix the return status in RX path
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > <linux-kernel-owner@vger.kernel.org> On Behalf Of Haiyang Zhang
> > Sent: Thursday, March 22, 2018 12:01 PM
> > To: davem@davemloft.net; netdev@vger.kernel.org
> > Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan
> > <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> > olaf@aepfle.de; vkuznets@redhat.com; devel@linuxdriverproject.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH net-next,1/2] hv_netvsc: Fix the return status in RX
> > path
> >
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > As defined in hyperv_net.h, the NVSP_STAT_SUCCESS is one not zero.
> > Some functions returns 0 when it actually means NVSP_STAT_SUCCESS.
> > This patch fixes them.
> >
> > In netvsc_receive(), it puts the last RNDIS packet's receive status
> > for all packets in a vmxferpage which may contain multiple RNDIS
> > packets.
> > This patch puts NVSP_STAT_FAIL in the receive completion if one of the
> > packets in a vmxferpage fails.
> 
> This patch changes the status field that is being reported back to the Hyper-V
> host in the receive completion message in
> enq_receive_complete().   The current code reports 0 on success,
> and with the patch, it will report 1 on success.  So does this change affect
> anything on the Hyper-V side?  Or is Hyper-V just ignoring
> the value?   If this change doesn't have any impact on the
> interactions with Hyper-V, perhaps it would be good to explain why in the
> commit message.

Here is the definition of each status code for NetVSP. 
enum {
        NVSP_STAT_NONE = 0,
        NVSP_STAT_SUCCESS,
        NVSP_STAT_FAIL,
        NVSP_STAT_PROTOCOL_TOO_NEW,
        NVSP_STAT_PROTOCOL_TOO_OLD,
        NVSP_STAT_INVALID_RNDIS_PKT,
        NVSP_STAT_BUSY,
        NVSP_STAT_PROTOCOL_UNSUPPORTED,
        NVSP_STAT_MAX,
};

Existing code returns NVSP_STAT_NONE = 0, and with this patch
we return NVSP_STAT_SUCCESS = 1. 
Based on testing, either way works for now. But for correctness
and future stability (e.g. host side becomes more stringent), we
should follow the protocol.

Thanks,
- Haiyang

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
