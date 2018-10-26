Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B5ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803072075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Zy4vnHZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803072075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeJ0G1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:27:45 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:28695 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728399AbeJ0G1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1540590543; x=1572126543;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tWmp4oGp7E3WUoGSPInLpkCq5Qd46Axw4XY16yBpV7g=;
  b=Zy4vnHZly1CaTkkV3UYzb1H8miYVWUWcLEfbv8ASOom8+yzaJ8QX0EXW
   ZjkfF4KU+fK3W24BmoQ+Z3O+2d36eQFQkTxIVXJUj670WO07jOJWx5eDW
   sBc9Qdi4PaMu/CqiMuniHNXA8hIu0xDtueEh/mgPdO/2Acp0rmZsu6awE
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FVAAA3i9NbhyWd50NjHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUgYBAQsBgVWBFX8yhzWFLYs5O4N9lHKBegsBARuBFYM8AoMZITUMDQE?=
 =?us-ascii?q?DAQECAQECAQECEAEBAQoLCQgpIwyCNiKBR18+AgEDEhUTLRIQAgEINhBXAgQ?=
 =?us-ascii?q?BDQ0agn8BggGbPQKBEIlXAQEBgWgzg3GGL4tngheBEYMSilkCgSoBjTGQIwY?=
 =?us-ascii?q?BAoZpgyAFhmkggVKEd4l8iTKKJAGDFAIEAgQFAhSBRAGCDHCBboFPCIIdDgk?=
 =?us-ascii?q?SgxCKeI0OgR8BAQ?=
X-IPAS-Result: =?us-ascii?q?A2FVAAA3i9NbhyWd50NjHAEBAQQBAQcEAQGBUgYBAQsBg?=
 =?us-ascii?q?VWBFX8yhzWFLYs5O4N9lHKBegsBARuBFYM8AoMZITUMDQEDAQECAQECAQECE?=
 =?us-ascii?q?AEBAQoLCQgpIwyCNiKBR18+AgEDEhUTLRIQAgEINhBXAgQBDQ0agn8BggGbP?=
 =?us-ascii?q?QKBEIlXAQEBgWgzg3GGL4tngheBEYMSilkCgSoBjTGQIwYBAoZpgyAFhmkgg?=
 =?us-ascii?q?VKEd4l8iTKKJAGDFAIEAgQFAhSBRAGCDHCBboFPCIIdDgkSgxCKeI0OgR8BA?=
 =?us-ascii?q?Q?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2018 16:49:02 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QLmU9L128248;
        Fri, 26 Oct 2018 17:49:02 -0400
Received: from esa1.dell-outbound2.iphmx.com (esa1.dell-outbound2.iphmx.com [68.232.153.201])
        by mx0b-00154901.pphosted.com with ESMTP id 2nc7cns377-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 17:49:02 -0400
From:   <Justin.Lee1@Dell.com>
Received: from ausc60ps301.us.dell.com ([143.166.148.206])
  by esa1.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Oct 2018 03:48:36 +0600
X-LoopCount0: from 10.166.135.97
X-IronPort-AV: E=Sophos;i="5.54,429,1534827600"; 
   d="scan'208";a="1216992310"
To:     <sam@mendozajonas.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH net-next v2 6/6] net/ncsi: Configure multi-package,
 multi-channel modes with failover
Thread-Topic: [PATCH net-next v2 6/6] net/ncsi: Configure multi-package,
 multi-channel modes with failover
Thread-Index: AQHUaxq7PwNtXYFfrkq+WonZnNQ9MKUyEawg
Date:   Fri, 26 Oct 2018 21:48:58 +0000
Message-ID: <93324b3c0a9b4929aa64801b4ed9c25c@AUSX13MPS306.AMER.DELL.COM>
References: <20181023215201.27315-1-sam@mendozajonas.com>
 <20181023215201.27315-7-sam@mendozajonas.com>
In-Reply-To: <20181023215201.27315-7-sam@mendozajonas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810260185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

There is one place that we assume the next available TX channel is under th=
e same package.
Please see the comment below.

Thanks,
Justin


+/* Change the active Tx channel in a multi-channel setup */
+int ncsi_update_tx_channel(struct ncsi_dev_priv *ndp,
> +			   struct ncsi_package *np,
> +			   struct ncsi_channel *disable,
> +			   struct ncsi_channel *enable)
> +{
> +	struct ncsi_cmd_arg nca;
> +	struct ncsi_channel *nc;
> +	int ret =3D 0;
> +
> +	if (!np->multi_channel)
> +		netdev_warn(ndp->ndev.dev,
> +			    "NCSI: Trying to update Tx channel in single-channel mode\n");
> +	nca.ndp =3D ndp;
> +	nca.package =3D np->id;

If the channel may be on different package, the package ID here may not be =
correct
in some cases.

> +	nca.req_flags =3D 0;
> +
> +	/* Find current channel with Tx enabled */
> +	if (!disable) {
> +		NCSI_FOR_EACH_CHANNEL(np, nc)
> +			if (nc->modes[NCSI_MODE_TX_ENABLE].enable)
> +				disable =3D nc;
> +	}
> +
> +	/* Find a suitable channel for Tx */
> +	if (!enable) {
> +		if (np->preferred_channel &&
> +		    ncsi_channel_has_link(np->preferred_channel)) {
> +			enable =3D np->preferred_channel;
> +		} else {
> +			NCSI_FOR_EACH_CHANNEL(np, nc) {
> +				if (!(np->channel_whitelist & 0x1 << nc->id))
> +					continue;
> +				if (nc->state !=3D NCSI_CHANNEL_ACTIVE)
> +					continue;
> +				if (ncsi_channel_has_link(nc)) {
> +					enable =3D nc;
> +					break;
> +				}
> +			}

When we search, we need to consider the other available channel might be on=
 the
package.

> +		}
> +	}
> +
> +	if (disable =3D=3D enable)
> +		return -1;
> +
> +	if (!enable)
> +		return -1;
> +
> +	if (disable) {
> +		nca.channel =3D disable->id;
> +		nca.type =3D NCSI_PKT_CMD_DCNT;
> +		ret =3D ncsi_xmit_cmd(&nca);
> +		if (ret)
> +			netdev_err(ndp->ndev.dev,
> +				   "Error %d sending DCNT\n",
> +				   ret);
> +	}

I remove the cable from ncsi0 and it doesn't failover to ncsi3 as ncsi0 and=
 ncsi3 are not under
the same package.

cat /sys/kernel/debug/ncsi_protocol/ncsi_device_
IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PC CS PS LS RU CR NQ HA
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  2   eth2   ncsi0  000 000 1  1  1  1  1  1  1  3  0  0  1  1  0  1
  2   eth2   ncsi1  000 001 0  0  1  1  1  0  0  1  0  1  1  1  0  1
  2   eth2   ncsi2  001 000 0  0  1  1  1  0  0  1  0  1  1  1  0  1
  2   eth2   ncsi3  001 001 1  0  1  1  1  1  0  2  1  1  1  1  0  1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
MP: Multi-mode Package     WP: Whitelist Package
MC: Multi-mode Channel     WC: Whitelist Channel
PC: Primary Channel        CS: Channel State
PS: Poll Status            LS: Link Status
RU: Running                CR: Carrier OK
NQ: Queue Stopped          HA: Hardware Arbitration
