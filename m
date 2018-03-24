Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-158926-1521911146-2-12092110528423769709
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521911145; b=b+BcnH1XHNM510LdzCm6cKBcChSX0zgC1QHQNqJpAIgM7I4
    xneaD62gLhtRvg7svampX/U8UDLljn7G1UxZIUJyOgvom2cmr+hFNs2/tHxadD4a
    R9nL9l/7LvFlXXAtm3HBSqSakRCpRNR/vQqhc0DTVxDsi+83gkbcy/Q+sVwH0EHT
    woYz4D0dvgrk4jBWkwpMdTyRmwxiKOsh9KoMBS3wo6A/FD/pVUGkoekoFp1SjhJT
    SlCvBTWxh2ILIq0PWlzonVZ85qOnQgQ3x/uzNnRoDiPAm7p4YLIp778avFJOhUa+
    6JA8d+APS5aHdzlazLSJaZe7vrQVAhiY1EKfgEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521911145; bh=G
    yLof0+2umIF12+DRY7U7FxCOT1POQaV4acuL5NeV+A=; b=F5zE7X4stAYY2Rsie
    P3uw373KdIZQCDJII+N0e1dH4/5lx3doj/witGjOPFnI8oLAr/W1WSaxi1RUJSqy
    +bgKa4Gu4qHeAyUCiLoJWY5R0NtzXPYxO+WbKP6T293yxOSYNRmqeXPDQoaIn6sj
    03U7JdsBP8wbqvdwMMgK82nN0oZ3ZLd75RZuiGEspVD8l4oNGyLJA8OtVndERBr6
    ce04UzoCDfgduEtYcB/KLQ6igFCWetEjFij41+TgSVCHaj1FMJsxYah2X+X1rIU+
    /ODnKw6dTgTaYvDf3ThatvALi5i+TzipzoEcH1FmsH4NMAQ1dsraAmOm4HUKRxk8
    F0Jfg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mM3c+Vnf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=mM3c+Vnf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Long Li <longli@linuxonhyperv.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "James E . J . Bottomley" <JBottomley@odin.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Topic: [PATCH v2] storvsc: Set up correct queue depth values for IDE
 devices
Thread-Index: AQHTwieILwEfC+5/M0aVB+MvmiP+XaPfm4FQ
Date: Sat, 24 Mar 2018 16:50:59 +0000
Message-ID: <DM5PR2101MB1030FD5B6261CC7BCF0092D1DCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180322214718.29547-1-longli@linuxonhyperv.com>
In-Reply-To: <20180322214718.29547-1-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-24T16:50:58.3560288Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1030;
 7:63skjmPx/J+4JFqUsRwbeO2tgSzfavqNJzaJ3vQ0dBhWxyp640NFIwQtg7ndTcnsNDhhhCnwTVGRm730wqWHeav8cVxjI+ZZPd4mLc7elCrQtbsap3RjasmoNbM+rl2koTQnv+unzpaWx1T0jlPNjjYJt9QDawsu2bZct9hd6amCi+ToSwfK3atzQn8eyhnuRz7t2Fw53gsd6ysVxCBAyfBWczX0fpOZ6eBCiRaFxoq1qN9ybMrWoWWMvilrILBL;
 20:AuPPsx+F6FMwDRWRnRdU8OZvOGeHaS8DR2fkEAPD4WEME7dDRgPf56T4UdJNSYzHXgMzdmMqemfWXRV/T5723azcWGQRnLAqXcFZ43g6JN4zslwebMdIM3Rk7YrpYAo5+5/n2UsaepsAZ7ADOuBgB+SdLwkjTUeF9wct9TXCe5s=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 902d6924-9385-40da-503f-08d591a76c05
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
x-microsoft-antispam-prvs: <DM5PR2101MB1030590BA2F5F7D45B71091EDCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1030; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0621E7E436
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(346002)(39860400002)(39380400002)(366004)(54534003)(13464003)(199004)(189003)(4326008)(186003)(5250100002)(2900100001)(10090500001)(7696005)(2501003)(53546011)(6506007)(59450400001)(26005)(86612001)(6346003)(8990500004)(102836004)(76176011)(25786009)(53936002)(68736007)(55016002)(9686003)(97736004)(86362001)(575784001)(3660700001)(2201001)(107886003)(6246003)(66066001)(99286004)(1511001)(6436002)(106356001)(33656002)(11346002)(14454004)(446003)(5660300001)(22452003)(74316002)(305945005)(478600001)(7736002)(3280700002)(2906002)(72206003)(3846002)(6116002)(81166006)(10290500003)(110136005)(81156014)(8676002)(316002)(8936002)(105586002)(229853002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1030;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: WmFIH+cGFkFbTcoL3KXl7A5VkcaPhi5nFcmwwdLnsakK1VueDe63YAAfXYknz4KUiAjLSwXCMxKpWNSz94BNOuOejHg54JxqeglhYhhnBQSHhj3yUUz50goACrycLJ4n7i86Aob4gaHpw+aUAfOUgwtTyZsdtXK6zuF/v27eHLPs355TgIxjIQGh15TWIUuYliK64Mo/0r4/RvONkHlFqFf6nleaw9cQQSg+4RvOJI4NREyMtY7Aq4mgKmPL9VZlmj9DmTX4Kl5Sg+EVE6Z3zGzgsjRvEm0TYvEX0d1jShtCwaLfr2EKJv6+6an2E6eezzStB+dvSEi3otZndQVoXQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902d6924-9385-40da-503f-08d591a76c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2018 16:50:59.9125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of Long Li
> Sent: Thursday, March 22, 2018 2:47 PM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; James E . J . Bottomley <JBottomley@odin.com>;
> Martin K . Petersen <martin.petersen@oracle.com>; devel@linuxdriverproject.org; linux-
> scsi@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Long Li <longli@microsoft.com>
> Subject: [PATCH v2] storvsc: Set up correct queue depth values for IDE devices
> 
> From: Long Li <longli@microsoft.com>
> 
> Unlike SCSI and FC, we don't use multiple channels for IDE.
> Also fix the calculation for sub-channels.
> 
> Change log:
> v2: Addressed comment on incorrect number of sub-channels.
> (Michael Kelley <Michael.H.Kelley@microsoft.com>)
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/scsi/storvsc_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 8c51d628b52e..a2ec0bc9e9fa 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1722,11 +1722,14 @@ static int storvsc_probe(struct hv_device *device,
>  		max_targets = STORVSC_MAX_TARGETS;
>  		max_channels = STORVSC_MAX_CHANNELS;
>  		/*
> -		 * On Windows8 and above, we support sub-channels for storage.
> +		 * On Windows8 and above, we support sub-channels for storage
> +		 * on SCSI and FC controllers.
>  		 * The number of sub-channels offerred is based on the number of
>  		 * VCPUs in the guest.
>  		 */
> -		max_sub_channels = (num_cpus / storvsc_vcpus_per_sub_channel);
> +		if (!dev_is_ide)
> +			max_sub_channels =
> +				(num_cpus - 1) / storvsc_vcpus_per_sub_channel;
>  	}
> 
>  	scsi_driver.can_queue = (max_outstanding_req_per_channel *
> --
> 2.14.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
