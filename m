Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26789C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB9B2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 23:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xMCeslYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB9B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeIHEPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 00:15:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40062 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeIHEP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 00:15:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w87NOBUb170130;
        Fri, 7 Sep 2018 23:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=w3MCDawBW3umXcn6zKC3iTqwAoFxlqJtgkUb2ARUqo0=;
 b=xMCeslYyKPC8jLOlCuYdpzFcgFEN4Dd4UO0a83mi1M7dBGxEPURj3EY/6rKknB8OqP0M
 62EBOnde/gO/uTJQT8kMGW5wibl6I6lRAgHrjrW3dJ6aBTUfniAc0f9YLj0JDTO3KqpR
 G3qWOPXS9BSwOQ6AGZkyMFVXYmRFMdZFgNyF6DGFoeYSvKvX0M7AqKFJJ6EhfTrV04KH
 ynulJVtRAsEyeCQivqmjPf+3b+82chM4BG/ciOwKxrpiiAlUEtprodr5M38pdtH3g751
 6dCNoJlpD1NKTs4JrqsA1Yv+Mn3lxd8fu6Phlkw+VqLe4KdtWpT8eUd/2rGzzPFGDemM nA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2m7jqq5503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Sep 2018 23:32:08 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w87NW2ow012154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Sep 2018 23:32:02 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w87NW2Sw013897;
        Fri, 7 Sep 2018 23:32:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Sep 2018 16:32:01 -0700
Date:   Fri, 7 Sep 2018 16:32:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Max Asbock <masbock@lenovo.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris McDermott <lcm@lenovo.com>
Subject: Re: [Patch] acpi_power_meter: remove 'ignoring unsafe software power
 cap' message
Message-ID: <20180907233201.GA4635@magnolia>
References: <TY2PR03MB3519C32A5BC640BA41356CBEDE000@TY2PR03MB3519.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2PR03MB3519C32A5BC640BA41356CBEDE000@TY2PR03MB3519.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9009 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809070229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:07:39PM +0000, Max Asbock wrote:
> At boot time the acpi_power_meter driver greets users of non-IBM systems with the message: 
> 	
> "Ignoring unsafe software power cap". 
> 
> This message is generally interpreted as meaning: The system is
> operating under an unsafe power  cap and Linux is ignoring this fact,
> thus living dangerously. It, or its presumed origin, has been blamed
> for system crashes. People spent time writing knowledge base articles
> which explain that the message doesn't mean what users think. I now
> have to write another such article telling people to ignore this
> message. To avoid future confusion and unnecessary work, I think the
> best solution is to remove the message. 
> 
> Here is my translation of the 'ignoring unsafe power cap' message:
>
> 'The acpi_power_meter driver discovered an ACPI object that would in
> theory allow software to set power caps. The driver could now create
> files in sysfs to expose this interface to user space, but it chooses
> not to do so'.

TBH that driver safelists the (single) system that is known to have a
working power capping mechanism.  At the time (ten years ago) the AEM
group worried that other vendors would produce ACPI power meters which
advertised the capping ability but did not enforce the limit, hence the
safelist.  I asked "Well can't we just trust vendor firmware?" and peals
of laughter erupted on the phone. ;)

If the user confusion is that Lenovo systems have ACPI power meters with
working power capping, you could consider adding Lenovo to the safelist.

That said, the message is misleading.  It probably should have read:

"Power capping has not been verified to work on this platform.
Please ask the platform vendor email X to have it added to the list."

Alternately, you could remove the safelisting entirely and assume that
if the firmware is malicious there are far more evil things it will try.
Seeing as IBM AEM is a decade old I doubt it's protecting much now.

But /me shrugs and says, "eh, good enough".  Also, nice to hear from you
& lcm again. :)

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> Patch: Remove error message because it is generally misinterpreted. A replacement
> for the message is not necessary.
> 
> Signed-off-by: Max Asbock <masbock@lenovo.com>
> 
> diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
> index 34e45b9..578e886 100644
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -693,11 +693,8 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
>  	}
>  
>  	if (resource->caps.flags & POWER_METER_CAN_CAP) {
> -		if (!can_cap_in_hardware()) {
> -			dev_err(&resource->acpi_dev->dev,
> -				"Ignoring unsafe software power cap!\n");
> +		if (!can_cap_in_hardware())
>  			goto skip_unsafe_cap;
> -		}
>  
>  		if (resource->caps.configurable_cap)
>  			res = register_attrs(resource, rw_cap_attrs);
> 
> 
> 
