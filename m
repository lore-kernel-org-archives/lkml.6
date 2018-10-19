Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA60ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C90820843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 21:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Vi8hlYD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C90820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJTF5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 01:57:48 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:57784 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726678AbeJTF5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 01:57:48 -0400
X-Greylist: delayed 666 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2018 01:57:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1539985790; x=1571521790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e3G2PKsG2imjg7T1pMydF10IrOP0C1sL0Wb8z37I8Nw=;
  b=Vi8hlYD1wr+zxtttywzOsUAF/OaUtWQt/qa99xeeomNdRrsn8vxr1sIU
   6e74Wjrxh9XFlt20ARvLZH4cm5XoTHDRZHYGSh4vYt7JaJ1eXK5rV9dxr
   VwPIH4vvuBZaus8hWkp8451FIS6zBxX88k3u6Xnr3hjWXh8xlrxShemOD
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EQAABNTspbhiWd50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgVWCAhIoCowDX41HgXeVGIF6CwEBhGwChSo0DQ0BAwEBAgE?=
 =?us-ascii?q?BAgEBAhABAQEKCQsIKS+CNiKCYwEBAQMBEhUTLRIFCwIBCBQBIRBXAgQBDQU?=
 =?us-ascii?q?IGoJ/gXoInQiJVwEBAYFoM4oXjWaBEYMSilgCgSoBjRyPegYBApBkH4FPhHO?=
 =?us-ascii?q?JZ5YrAgQCBAUCFIFDgg5wgW6BToImDgmOGm+LBoEfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EQAABNTspbhiWd50NkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VWCAhIoCowDX41HgXeVGIF6CwEBhGwChSo0DQ0BAwEBAgEBAgEBAhABAQEKC?=
 =?us-ascii?q?QsIKS+CNiKCYwEBAQMBEhUTLRIFCwIBCBQBIRBXAgQBDQUIGoJ/gXoInQiJV?=
 =?us-ascii?q?wEBAYFoM4oXjWaBEYMSilgCgSoBjRyPegYBApBkH4FPhHOJZ5YrAgQCBAUCF?=
 =?us-ascii?q?IFDgg5wgW6BToImDgmOGm+LBoEfAQE?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2018 16:38:15 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JLcQd5048451;
        Fri, 19 Oct 2018 17:38:50 -0400
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2n7ajvbupc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 17:38:50 -0400
From:   <Justin.Lee1@Dell.com>
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Oct 2018 03:38:47 +0600
X-LoopCount0: from 10.166.135.98
X-IronPort-AV: E=Sophos;i="5.54,401,1534827600"; 
   d="scan'208";a="1150324336"
To:     <davem@davemloft.net>, <sam@mendozajonas.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH net-next 0/6] net/ncsi: Allow enabling multiple packages &
 channels
Thread-Topic: [PATCH net-next 0/6] net/ncsi: Allow enabling multiple packages
 & channels
Thread-Index: AQHUZpcNEQCD9YIJq0mCdRbo1sv1t6Ul8lWAgAEg4PA=
Date:   Fri, 19 Oct 2018 21:38:47 +0000
Message-ID: <79ee8c9befaa40e781bfeba4ba25d396@AUSX13MPS302.AMER.DELL.COM>
References: <20181018035917.19413-1-sam@mendozajonas.com>
 <20181018.155647.1045018243241594303.davem@davemloft.net>
In-Reply-To: <20181018.155647.1045018243241594303.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=853 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

When I run the testing (enable multi-package (package 0 and 1) and=20
multi-channel (channel 0 and 1 on both packages)), I see there are two chan=
nels
with TX enable.

When I unplug/plug network cable, it seems the behavior is to keep one TX p=
er
package, is it the behavior you expect? All channels are behind the same et=
h2,
I would expect there is only one active TX.

I create the below file to expose driver's status. RX and TX are printing=20
from the follow variables.
nc->modes[NCSI_MODE_ENABLE].enable,
nc->modes[NCSI_MODE_TX_ENABLE].enable,

cat /sys/kernel/debug/ncsi_protocol/ncsi_device_status;
IFIDX IFNAME NAME   PID CID RX TX MP MC WP WC PS RU CR NQ
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
  2   eth2   ncsi0  000 000 1  1  1  1  1  1  1  1  1  0=20
  2   eth2   ncsi1  000 001 1  0  1  1  1  1  1  1  1  0=20
  2   eth2   ncsi2  001 000 1  1  1  1  1  1  1  1  1  0=20
  2   eth2   ncsi3  001 001 1  0  1  1  1  1  1  1  1  0=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
M:  Multi-mode      P:  Package ID
W:  Whitelist       C:  Channel ID
PS: Poll Status
RU: Running
CR: Carrier OK
NQ: Queue Stopped

Thanks,
Justin


From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Thu, 18 Oct 2018 14:59:11 +1100

> This series extends the NCSI driver to configure multiple packages
> and/or channels simultaneously. Since the RFC series this includes a few
> extra changes to fix areas in the driver that either made this harder or
> were roadblocks due to deviations from the NCSI specification.
>=20
> Patches 1 & 2 fix two issues where the driver made assumptions about the
> capabilities of the NCSI topology.
> Patches 3 & 4 change some internal semantics slightly to make multi-mode
> easier.
> Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration
> and keeping track of channel states.
> Patch 6 implements the main multi-package/multi-channel configuration,
> configured via the Netlink interface.
>=20
> Readers who have an interesting NCSI setup - especially multi-package
> with HWA - please test! I think I've covered all permutations but I
> don't have infinite hardware to test on.


