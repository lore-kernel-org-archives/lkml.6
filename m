Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460B9C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E2620840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="wKjl2OHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E2620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeKIIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:25:58 -0500
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:9015 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbeKIIZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:25:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1541717265; x=1573253265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AOJmLMFBXuxlygFAH8ErW7rAwtqR7VQCkCJ0VwvnvcQ=;
  b=wKjl2OHFPfUn7BjUFMqh0deCVSHkDRM1W4Q0mgHLW0d8hpw/J/OzSRml
   99pIguvVrUl3Dz3P1tPyEwVj9ZSSdtc7BQvJhdkXsTAs1l/+sAc06lus0
   91JZtd4VTjJga9wKS+/sLp6H4KnF6lVcSgabf/wNZOqabwqMgAJUxO0MO
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FHAADmvORbhiWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBVAQBAQsBgVWCBBIxjGWmVgsBAYRsAoM7NwoNAQMBAQIBAQIBAQIQAQE?=
 =?us-ascii?q?BCgkLCCkvgjYigmQCAQMSFRMtEhACAQg2EFcCBAENDRqCfwGCAZxqAoEQiVg?=
 =?us-ascii?q?BAQGBaTOKLI4QgRABgxKKWQKBKgGNV5BGBgECihcFgxaDXCCBVyKEX4oUl0k?=
 =?us-ascii?q?CBAIEBQIUgVmBeHCBboFPgiYOCRKOCkABizkpgQWBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2FHAADmvORbhiWd50NkHAEBAQQBAQcEAQGBVAQBAQsBg?=
 =?us-ascii?q?VWCBBIxjGWmVgsBAYRsAoM7NwoNAQMBAQIBAQIBAQIQAQEBCgkLCCkvgjYig?=
 =?us-ascii?q?mQCAQMSFRMtEhACAQg2EFcCBAENDRqCfwGCAZxqAoEQiVgBAQGBaTOKLI4Qg?=
 =?us-ascii?q?RABgxKKWQKBKgGNV5BGBgECihcFgxaDXCCBVyKEX4oUl0kCBAIEBQIUgVmBe?=
 =?us-ascii?q?HCBboFPgiYOCRKOCkABizkpgQWBHwEB?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Nov 2018 16:47:44 -0600
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8MmC3J000825;
        Thu, 8 Nov 2018 17:48:12 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2nmmntubj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Nov 2018 17:48:12 -0500
From:   <Justin.Lee1@Dell.com>
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 09 Nov 2018 04:48:09 +0600
X-LoopCount0: from 10.166.135.98
X-IronPort-AV: E=Sophos;i="5.54,481,1534827600"; 
   d="scan'208";a="727009260"
To:     <sam@mendozajonas.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH net-next v3 6/6] net/ncsi: Configure multi-package,
 multi-channel modes with failover
Thread-Topic: [PATCH net-next v3 6/6] net/ncsi: Configure multi-package,
 multi-channel modes with failover
Thread-Index: AQHUdw3T7sTeKH7RI0a85rjfghKYaaVGRmNg
Date:   Thu, 8 Nov 2018 22:48:09 +0000
Message-ID: <f9d0309dafe248a6aac8198f96f9bc4b@AUSX13MPS306.AMER.DELL.COM>
References: <20181108024909.9897-1-sam@mendozajonas.com>
 <20181108024909.9897-7-sam@mendozajonas.com>
In-Reply-To: <20181108024909.9897-7-sam@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

For multi-package and multi-channel case, channel seems to be select correc=
tly. Expect that,
I still see the timing issue for back-to-back netlink command. Due to that,=
 channel might be
set to invisible state. Please refer to ncsi0 and ncsi2 below. The channel =
state is set to 3.

cat /sys/kernel/debug/ncsi_protocol/ncsi_device_status
IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  2   eth2   ncsi0  000 000 1  1  1  1  1  0  0  3  0  1  1  1  0  1
  2   eth2   ncsi1  000 001 0  0  1  1  1  0  0  1  0  1  1  1  0  1
  2   eth2   ncsi2  001 000 1  0  1  1  1  1  0  3  0  1  1  1  0  1
  2   eth2   ncsi3  001 001 1  0  1  1  1  1  0  2  1  1  1  1  0  1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
MP: Multi-mode Package  WP: Whitelist Package
MC: Multi-mode Channel  WC: Whitelist Channel
PC: Primary Channel     CS: Channel State IA/A/IV 1/2/3
PS: Poll Status         LS: Link Status
RU: Running             CR: Carrier OK
NQ: Queue Stopped       HA: Hardware Arbitration

The timing issue is not only happening in application. If I use using the f=
ollowing way
to send the request, I can see the issue as well.=20

ncsi_netlink -l 2 -a 0x01 -m; ncsi_netlink -l 2 -p 0 -b 0x03 -m; ncsi_netli=
nk -l 2 -p 1 -b 0x00 -m;
ncsi_netlink -l 2 -a 0x03 -m; ncsi_netlink -l 2 -p 0 -b 0x00 -m; ncsi_netli=
nk -l 2 -p 1 -b 0x03 -m;


Also, there is one issue below for non-multi-package/non-multi-channel case=
.

Thanks,
Justin


> @@ -1008,32 +1164,49 @@ static int ncsi_choose_active_channel(struct ncsi=
_dev_priv *ndp)
> =20
>  			ncm =3D &nc->modes[NCSI_MODE_LINK];
>  			if (ncm->data[2] & 0x1) {
> -				spin_unlock_irqrestore(&nc->lock, flags);
>  				found =3D nc;
> -				goto out;
> +				with_link =3D true;
>  			}
> =20
> -			spin_unlock_irqrestore(&nc->lock, flags);
> +			/* If multi_channel is enabled configure all valid
> +			 * channels whether or not they currently have link
> +			 * so they will have AENs enabled.
> +			 */
> +			if (with_link || np->multi_channel) {
> +				spin_lock_irqsave(&ndp->lock, flags);
> +				list_add_tail_rcu(&nc->link,
> +						  &ndp->channel_queue);
> +				spin_unlock_irqrestore(&ndp->lock, flags);
> +
> +				netdev_dbg(ndp->ndev.dev,
> +					   "NCSI: Channel %u added to queue (link %s)\n",
> +					   nc->id,
> +					   ncm->data[2] & 0x1 ? "up" : "down");
> +			}
> +
> +			spin_unlock_irqrestore(&nc->lock, cflags);
> +
> +			if (with_link && !np->multi_channel)
> +				break;

The line needs to change to "goto found". If not, all channels with link wi=
ll be added
even if the multi-channel is not enabled for that package. The ncsi1 below =
is enabled.
There is no netlink command sent to enable multi-package or multi-channel.

IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  2   eth2   ncsi0  000 000 1  1  0  0  1  1  0  2  1  1  1  1  0  1
  2   eth2   ncsi1  000 001 1  0  0  0  1  1  0  2  1  1  1  1  0  1
  2   eth2   ncsi2  001 000 0  0  0  0  1  1  0  1  0  1  1  1  0  1
  2   eth2   ncsi3  001 001 0  0  0  0  1  1  0  1  0  1  1  1  0  1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
MP: Multi-mode Package  WP: Whitelist Package
MC: Multi-mode Channel  WC: Whitelist Channel
PC: Primary Channel     CS: Channel State IA/A/IV 1/2/3
PS: Poll Status         LS: Link Status
RU: Running             CR: Carrier OK
NQ: Queue Stopped       HA: Hardware Arbitration

>  		}
> +		if (with_link && !ndp->multi_package)
> +			break;
>  	}

found:

After applying this change, I notice that if there is no link available to =
BMC when BMC
starts, NC-SI can't properly configure channel once I plug in the Ethernet =
cable.=20

npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_aen_handler_lsc() - pkg 0 ch 0 st=
ate up
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_aen_handler_lsc() - had_link 0, h=
as_link 1, chained 0
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_stop_channel_monitor() - pkg 0 ch=
 0
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel()
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel() - pkg 0 ch=
 0 INVISIBLE
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel() - suspendi=
ng pkg 0 ch 0
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 st=
ate 0400 select
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 st=
ate 0403 dc
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 st=
ate 0404 deselect
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 st=
ate 0405 done
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_rsp_handler_dp() - pkg 0 ch 0 INA=
CTIVE
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_rsp_handler_dp() - pkg 0 ch 1 INA=
CTIVE
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_dev_work()
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 st=
ate 0406 deselect
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_suspend_channel() - pkg 0 ch 0 IN=
ACTIVE
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel()
npcm7xx-emc f0825000.eth eth2: NCSI: ncsi_process_next_channel() - No more =
channels to process
npcm7xx-emc f0825000.eth eth2: NCSI interface down

> =20
> -	if (!found) {
> +	if (list_empty(&ndp->channel_queue) && found) {
> +		netdev_info(ndp->ndev.dev,
> +			    "NCSI: No channel with link found, configuring channel %u\n",
> +			    found->id);
> +		spin_lock_irqsave(&ndp->lock, flags);
> +		list_add_tail_rcu(&found->link, &ndp->channel_queue);
> +		spin_unlock_irqrestore(&ndp->lock, flags);
> +	} else if (!found) {
>  		netdev_warn(ndp->ndev.dev,
> -			    "NCSI: No channel found with link\n");
> +			    "NCSI: No channel found to configure!\n");
>  		ncsi_report_link(ndp, true);
>  		return -ENODEV;
>  	}
> =20
> -	ncm =3D &found->modes[NCSI_MODE_LINK];
> -	netdev_dbg(ndp->ndev.dev,
> -		   "NCSI: Channel %u added to queue (link %s)\n",
> -		   found->id, ncm->data[2] & 0x1 ? "up" : "down");
> -
> -out:
> -	spin_lock_irqsave(&ndp->lock, flags);
> -	list_add_tail_rcu(&found->link, &ndp->channel_queue);
> -	spin_unlock_irqrestore(&ndp->lock, flags);
> -
>  	return ncsi_process_next_channel(ndp);
>  }

