Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273E0C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F5720838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vmjLiRmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F5720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLGOlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:41:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGOlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:41:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB7Edovf141555;
        Fri, 7 Dec 2018 14:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kiVB/qz1hdxrz4PMmwkuRvggHH7jVFFIbuwRBoxtrNs=;
 b=vmjLiRmTUi4QuK+HFPrfCDuv1MmXUsQZ4ynKmSoK3oYq7NvcuV9xSVL1hVDuPhbsqruk
 JP2tkd/WMMBn9dJdfeLNspxQxO4dXGdtW9ZPu4476Gk8stEGwIe7Sdicjcxj71qIAfd8
 Udjq2kVDvfd+7/gFaU8wrEImaskcxINqDq9pC6WgpmFHCg2DFFNgjuGZDfHnB8B8oL3y
 JhJ7wu0CEQ2EUbFhENAdPXfjFsKMW4s2jFESMxCAaOIjaD2vsBIBPaeqLrlUmCGVbh7i
 GnWMrEJuRmsue6C5xk63hOyCrqSB5oyAGVHE2BG4tJ4hQzRhwK/j3LgWbxWDyHkwgKR5 lg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hque7st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 14:40:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB7EewDv004661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 14:40:58 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB7Eetf3022668;
        Fri, 7 Dec 2018 14:40:56 GMT
Received: from unbuntlaptop (/197.157.0.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 06:40:55 -0800
Date:   Fri, 7 Dec 2018 17:40:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Minas Harutyunyan <minas.harutyunyan@synopsys.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Maynard CABIENTE <maynard.cabiente@raritan.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] usb: dwc2: Revert "usb: dwc2: Disable all EP's on
 disconnect"
Message-ID: <20181207144045.GT3073@unbuntlaptop>
References: <CGME20181121154518eucas1p2cc7ffd4d071ff420c747e1d0c387ee5d@eucas1p2.samsung.com>
 <20181121154504.13052-1-m.szyprowski@samsung.com>
 <410670D7E743164D87FA6160E7907A56013A7AA1EE@am04wembxa.internal.synopsys.com>
 <20181123144307.GC2970@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B19C2@am04wembxa.internal.synopsys.com>
 <20181204132913.GH3073@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B2847@am04wembxa.internal.synopsys.com>
 <20181207101532.GR3073@unbuntlaptop>
 <410670D7E743164D87FA6160E7907A56013A7B4AAF@am04wembxa.internal.synopsys.com>
 <410670D7E743164D87FA6160E7907A56013A7B4E2E@am04wembxa.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410670D7E743164D87FA6160E7907A56013A7B4E2E@am04wembxa.internal.synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=638
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 02:13:18PM +0000, Minas Harutyunyan wrote:
> 
> My patch doesn't pass sparse checking: "warning: context imbalance in 
> 'dwc2_hsotg_core_init_disconnected' - unexpected unlock". Sparse persist!
> So, I need to re-work patch. Can I use your idea with 
> dwc2_hsotg_ep_disable_lock() function to prepare new one?
> 

Sparse lock checking is pretty crap, and I wouldn't go out of my way
normally to make it happy...  But of course you can use my idea.

regards,
dan carpenter

