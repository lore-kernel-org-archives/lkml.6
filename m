Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FC3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38DB20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z/r2IL9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38DB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754609AbeGIM47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:56:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeGIM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:56:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69CrlQe065200;
        Mon, 9 Jul 2018 12:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6LKm2H7SVuB8AWy3JaRJCMnip+XUM2zqxMfDINs+IF4=;
 b=Z/r2IL9/jy/+aJ6Nlfcbqdb+VJL4bcSbmVymAnd7tOAnawB6CfBWuaJAilip4F/U4W0d
 op30kNOgBrsyHUk1pPt+v913wI7dac7FDQYLGiDStpnEAP39BIq5Ex+0RN8/A4mvJlbL
 o8qV9UIjg3XhhbmYNxSX2vBTZV+DX3abp1snTJNv7FfqPtaBoB1VGmXk3dH/bCUxPVhi
 FD2g6RKb0y8Z4RA9NHXqInNyXHBEl9FwKh7xnxNjNWpBEmz7KyNuDxxJHjlnnnCOszUV
 szoHI7XASMOY2fcByPli4a5iuSQf2SmsBLNZHKhE2khUWv4sbSeAHggCHvwdtBFt/Cg7 vw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7dm2cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jul 2018 12:56:47 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w69CukP7002150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jul 2018 12:56:46 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69CujPv013930;
        Mon, 9 Jul 2018 12:56:45 GMT
Received: from mwanda (/197.157.34.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 05:56:45 -0700
Date:   Mon, 9 Jul 2018 15:56:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jaya Durga <rjdurga@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        deanahn@gctsemi.com, quytelda@tamalin.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: gdm724x: gdm_tty.c:Fixed Macro argument reuse
Message-ID: <20180709125636.x4t5t7bgo632vowj@mwanda>
References: <20180709123632.5682-1-rjdurga@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709123632.5682-1-rjdurga@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8948 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=469
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand why you have sent this patch four times.

Are you a script which has a bug?  Please answer us so that we know you
are a human being.

regards,
dan carpenter

