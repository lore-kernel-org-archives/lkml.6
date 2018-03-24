Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-158926-1521910980-2-11742038309760120644
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521910978; b=Yfv7wqNO4WU55OeBfogFMkXREyEqJv/gjzlCS9OLrb+PORG
    YK5f6zhNQWsrbVoNdLM6mKdkNonmEaBokSl0Fv/mTzoB1R3IwrENuE1qbHK94n4H
    Pf8PsN9MuR6T0l5b8UiDo1Kj1IgPV8OVu92bl3sKLMxngdsJ+aIlPZABFbBNK+0K
    J8Ts751kbSe3IhZOnSH02c7cb7a10hz44wS4P5sGA6k2HBiYm+eYCFYiVKnN9X7o
    EXM8FtfEN19bpPseh5EQKczAp/HK9nfyvOi+V1U7nail9uEWnYG6FKXhgI/02MGN
    Auba1t3e7HcdcqJzZULOei0DrN4m5goopST3MdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521910978; bh=J
    gdn9dwviR8Gsc+1/+AtZLCx43vZp4NENCLmUHHYOwQ=; b=k1f1nZO8InuCobf8Z
    QC9DoRtnWXaW17/Wy2IZYX92U6H1p7uco0c+r5NdHYFPnKwdKb9oz5fGuP4dkehb
    nF8Ag5VgNjWfo5h7rT2rg8ZvPJ3/TF3+0K1NI0Qkvtv5zY8299WvM61ayeSpbGhd
    Qb52UkRWgfE0GSWnw8haM9dZEfr/rrWadY+xcvrqq4hEvo/L4yxF1S+42qYQ/zJl
    kVq+99+FJ9hLtPKCa62cZ4sWJ99ZEtxgD935hshF5oTY3WC59Kwiko+PtHD2K29C
    cUfi/ZaK2jfrAMcmLxeQLs3dPRMnTQLgNMHL6+JHm4w8SdhlQ9CTC7OSsvsnwNM5
    gqe8w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K4U3Il4a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=K4U3Il4a x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=microsoft.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net-next,1/2] hv_netvsc: Fix the return status in RX path
Thread-Topic: [PATCH net-next, 1/2] hv_netvsc: Fix the return status in RX path
Thread-Index: AQHTwhHxH07LHDYeH0ychb4hJXWI5qPfmCSg
Date: Sat, 24 Mar 2018 16:48:07 +0000
Message-ID: <DM5PR2101MB103003AA72955A6C6AD44D0CDCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180322190114.25596-1-haiyangz@linuxonhyperv.com>
 <20180322190114.25596-2-haiyangz@linuxonhyperv.com>
In-Reply-To: <20180322190114.25596-2-haiyangz@linuxonhyperv.com>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM5PR2101MB1030;
 7:wpwtes6u7VoLa+A1dTdW9HoNPD7UwpICwyeneoJSzaFRVexVGXNqRCd8vljWrBF+1aLGvn1sIEYct0xoHL4y4yprLV70Cv1tNXSyjq0IaJe3oObi7mB/hX1TTMKrCqG8Nxr2voe7oFdqL8TVMxXiylvil34hVkfOV7EXU94lXjr9TaAlrISQAVpr3dQbK9M4GStRAujQQ5VOTGLK0c+4Ati6k+t+zlmrYkTJGI/oy+nUuannnt/I6LiRI5+zcMUs;
 20:K100CYKd01mUBlf1omGwXOKBcnrG0nNAL8sm/eyIt2bmGfGq3kWtS68ntdkES2mWvBR/l/UIn5rrt+xpyeDE5wd7Yd5ii7X/dY8syBgj+bVA0by8KI+D1mEG+Z4QNYatRfybVwZGey0Nx/pNyewiOsXUmX94/dMj8D798mhk86A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fbbfc3a-c8dc-462d-494a-08d591a70580
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7193020);
 SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
x-microsoft-antispam-prvs: <DM5PR2101MB1030C0B192664324A9A05B75DCAF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(9452136761055); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:DM5PR2101MB1030; BCL:0; PCL:0; RULEID:; SRVR:DM5PR2101MB1030;
x-forefront-prvs: 0621E7E436
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(376002)(396003)(189003)(199004)(13464003)(22452003)(305945005)(74316002)(7736002)(478600001)(33656002)(5660300001)(14454004)(446003)(11346002)(316002)(8676002)(81156014)(110136005)(54906003)(8936002)(105586002)(229853002)(6116002)(3846002)(3280700002)(2906002)(72206003)(10290500003)(81166006)(86612001)(6346003)(76176011)(8990500004)(102836004)(26005)(59450400001)(25786009)(2900100001)(10090500001)(4326008)(5250100002)(7696005)(6506007)(53546011)(2501003)(66066001)(99286004)(6246003)(106356001)(1511001)(6436002)(55016002)(68736007)(53936002)(9686003)(97736004)(3660700001)(2201001)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR2101MB1030;
 H:DM5PR2101MB1030.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: sVZa18mJmbN25uGI6syqxqfn8rDBQkx7oghM/zyAiWuwFeASkDC6FpBDuUDUPSNB6pG4MD8nLr/E4DVdmu0e/1n7mQy+cnMX4JGGai2nGrbQzt1ca3qr0Q8PaMmVW0bYv3gGjVlx30IC+hwIvALRHFE5byA67+0by5dn8jrTyAk1WsrWqD9pIZFhFM4bi8qCt822nccKGtm/Cw7qwkVsy3J+tRKkQjmWxMfg3AhpmyB69PeFeSLAbT1VXIDexwo5vU2MSFNQradG1M8BThB1B4JcJFQo1cCIshI5cnFfrUSqMoFBS1dtzyI4BNJrV0X9m77LtaaJ0a5HlFRfi+f5OA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbbfc3a-c8dc-462d-494a-08d591a70580
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2018 16:48:07.9211 (UTC)
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
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf
> Of Haiyang Zhang
> Sent: Thursday, March 22, 2018 12:01 PM
> To: davem@davemloft.net; netdev@vger.kernel.org
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; vkuznets@redhat.com;
> devel@linuxdriverproject.org; linux-kernel@vger.kernel.org
> Subject: [PATCH net-next,1/2] hv_netvsc: Fix the return status in RX path
> 
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> As defined in hyperv_net.h, the NVSP_STAT_SUCCESS is one not zero.
> Some functions returns 0 when it actually means NVSP_STAT_SUCCESS.
> This patch fixes them.
> 
> In netvsc_receive(), it puts the last RNDIS packet's receive status
> for all packets in a vmxferpage which may contain multiple RNDIS
> packets.
> This patch puts NVSP_STAT_FAIL in the receive completion if one of
> the packets in a vmxferpage fails.

This patch changes the status field that is being reported back to
the Hyper-V host in the receive completion message in
enq_receive_complete().   The current code reports 0 on success,
and with the patch, it will report 1 on success.  So does this change
affect anything on the Hyper-V side?  Or is Hyper-V just ignoring
the value?   If this change doesn't have any impact on the
interactions with Hyper-V, perhaps it would be good to explain
why in the commit message.

Michael

> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc.c       | 8 ++++++--
>  drivers/net/hyperv/netvsc_drv.c   | 2 +-
>  drivers/net/hyperv/rndis_filter.c | 4 ++--
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index aa95e81af6e5..1ddb2c39b6e4 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -1098,12 +1098,16 @@ static int netvsc_receive(struct net_device *ndev,
>  		void *data = recv_buf
>  			+ vmxferpage_packet->ranges[i].byte_offset;
>  		u32 buflen = vmxferpage_packet->ranges[i].byte_count;
> +		int ret;
> 
>  		trace_rndis_recv(ndev, q_idx, data);
> 
>  		/* Pass it to the upper layer */
> -		status = rndis_filter_receive(ndev, net_device,
> -					      channel, data, buflen);
> +		ret = rndis_filter_receive(ndev, net_device,
> +					   channel, data, buflen);
> +
> +		if (unlikely(ret != NVSP_STAT_SUCCESS))
> +			status = NVSP_STAT_FAIL;
>  	}
> 
>  	enq_receive_complete(ndev, net_device, q_idx,
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index cdb78eefab67..33607995be62 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -818,7 +818,7 @@ int netvsc_recv_callback(struct net_device *net,
>  	u64_stats_update_end(&rx_stats->syncp);
> 
>  	napi_gro_receive(&nvchan->napi, skb);
> -	return 0;
> +	return NVSP_STAT_SUCCESS;
>  }
> 
>  static void netvsc_get_drvinfo(struct net_device *net,
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index 2dc00f714482..591fb8080f11 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -443,10 +443,10 @@ int rndis_filter_receive(struct net_device *ndev,
>  			"unhandled rndis message (type %u len %u)\n",
>  			   rndis_msg->ndis_msg_type,
>  			   rndis_msg->msg_len);
> -		break;
> +		return NVSP_STAT_FAIL;
>  	}
> 
> -	return 0;
> +	return NVSP_STAT_SUCCESS;
>  }
> 
>  static int rndis_filter_query_device(struct rndis_device *dev,
> --
> 2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
