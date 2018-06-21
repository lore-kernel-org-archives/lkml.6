Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2ACE20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IFIeUsLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2ACE20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932993AbeFUIW4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:22:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37992 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932617AbeFUIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:22:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L8EOgj136155;
        Thu, 21 Jun 2018 08:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=xsJbARbok3jBB5+b3NaYkTz3DUORz2fwles4PxSDzHY=;
 b=IFIeUsLKTzDQqKYJ+f0J+zceKs6L/zPTa3PDFRBP6ac9iP2oQT63Mg38gNP2/JSBieRQ
 IxLKDqNmKDZngFA2h5aAoxBySgcPq9O1G4+woBRu9F6xr2BjPuI29VonXOI6X9dZYF6r
 Z5zQwBdsmniL+5qXqCzUfs62wVpjb9sAJrG6nD4kTJTwJEx0pPXSsdr8zUAmzSGG3oaV
 JF2dWyHMIzRjuRLXLvBGl5pf/Jyab4LtoLy8B0eOr2ZJkhwjG71sn/RamG5YVD9OLzMv
 676OKhLcuK59CE/SFEUB/CF1ciL+jBleP5lXSs5ARPQmED52yz074RXl2iKw3SQnGQgk PA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2mqu7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 08:22:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L8MZ7P027043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 08:22:35 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5L8MYOr024377;
        Thu, 21 Jun 2018 08:22:35 GMT
Received: from mwanda (/41.202.241.28)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 01:22:34 -0700
Date:   Thu, 21 Jun 2018 11:22:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Opperman <eklikeroomys@gmail.com>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] staging: wlan-ng: improved readability of function
 prism2_add_key
Message-ID: <20180621082225.xuhqvm7bevbiuaso@mwanda>
References: <1529514635-17948-1-git-send-email-eklikeroomys@gmail.com>
 <20180620200829.qm2zxeyyl5kqh6gu@mwanda>
 <20180621044252.GA19583@kerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621044252.GA19583@kerdev>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 06:42:52AM +0200, Chris Opperman wrote:
> Hi Dan,
> 
> I agree completely. I was concerned whether the preprocessor definitions in
> p80211metadef.h were named according to some convention as there are
> many definitions named similarly there.
> 

Yeah, sure but in that case leave this code alone until we get the time
to update all the definitions.

> I am considering renaming this specific definition to "p80211_dot11_keyid",
> would that be more acceptable?

There is probably a normal define that wireless drivers already use, but
I don't know networking enough to say what it is...  You should try
asking on linux-wireless.

It says in the header that the name is generated automatically?  Is that
true?  How does that work?

Probably it's better to make it upper case?  Are both the P80211 and the
DOT11 required or is DOT11 a subset?  Anyway, I don't think it's
possible to create a worse naming scheme than the driver already has so
I'm likely to approve anything you send.

regards,
dan carpenter

