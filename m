Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C652EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F88E208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eZHddzRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F88E208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933546AbeFLNOb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:14:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42014 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932555AbeFLNOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:14:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CDBJOe126994;
        Tue, 12 Jun 2018 13:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=sdw3gPmMCjV7olaD5glz+IXrY66gXnSzIGgEBJAiR7k=;
 b=eZHddzRHe+W7wbHZf3rywbG7OL5UohPybQfs4jmeLA3Dte1xwKRCRzcA+YG+I92Dt3nY
 aV1lvk7us2d6vScIDOAGshp/FoC1NvSEnRzKRuSxfJtUsNHdEAkiQP6vTHz/lGEKTiwt
 ehTCGnKjEPh/17a2J3lzQ+1D6LqMIK9Yt+3Q2V9K5Tv4eVgglo31F7ErRRqoWaw/h+aa
 t/Spka82Y+JHWLutcA6tVmK+Y8PvHnAQkHxQlmn/YEuL3WXL9DW8kfkJFvVEyYQdMhB1
 VsfsUTam8MnYf67p4gtn/ckcT3SGbE8YU+wdZZTAEkPbk/dzqGw8KOZNG2FGkCRnPzYT 7A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2jgecxh5w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 13:14:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CDEPfR002206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 13:14:25 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CDEPsM003922;
        Tue, 12 Jun 2018 13:14:25 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 06:14:24 -0700
Date:   Tue, 12 Jun 2018 16:14:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wilc1000: Fix type of argument in
 ieee80211_is_action()
Message-ID: <20180612131413.qlv3wes43obfbmhe@mwanda>
References: <20180610071013.GA8771@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610071013.GA8771@nishad>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=457
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 12:40:17PM +0530, Nishad Kamdar wrote:
> Type used is unsigned char but expected is restricted __le16.
> Warning reported by sparse. Part of eudyptula challenge.
> 

The code is buggy, but this fix just papers over it.  We discussed this
code earlier.

https://lkml.org/lkml/2018/6/5/304

regards,
dan carpenter

