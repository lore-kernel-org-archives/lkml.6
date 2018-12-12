Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0438C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E7D20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UDvGCFel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E7D20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeLLIcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 03:32:18 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34846 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLLIcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 03:32:18 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBC8O6qN026774;
        Wed, 12 Dec 2018 08:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jXK4V4XHXfEhwO+EvcGsnsmgMdReutd+SbHs7eW8u64=;
 b=UDvGCFelMSJC8+mzu1FKXeoTrlz8WjTFlVybLSeFhgQaIkdSANnIFKbEKJVcWwiYc4fz
 ohEll3ImKbvukj4zLhMh46ETAVCOYTjF0G1G4xhLrM5giZSjXZOqxF5eYt0UHvJg1Mji
 oxCrrBFYpITkVatIszUYtqZwN1gmiVSGCIk8295j0u4hCCJGlSef6UNsK1vCiaukquw3
 ChkdFJcSRF7nj2T/V5lsXq2Xx7itdFpzV/zFi/sKiCPhZAkGs8wTNHCf2BwryjBdO7A6
 WFDNgT/wrqDyO1rSBxLh3B8vpXYNTsgnGJipDSfMEdQAFtoGDWq+Nq0mjo+gH3yLO2Cw Og== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2pawwp08h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:31:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBC8ViF4021085
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Dec 2018 08:31:44 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBC8ViaF015434;
        Wed, 12 Dec 2018 08:31:44 GMT
Received: from kadam (/197.157.0.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Dec 2018 00:31:43 -0800
Date:   Wed, 12 Dec 2018 11:31:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH 10/11] staging: iio: adt7316: change interpretation of
 write to dac update mode
Message-ID: <20181212083132.GJ3116@kadam>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-11-jeremyfertic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212005503.28054-11-jeremyfertic@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9104 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812120075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:55:02PM -0700, Jeremy Fertic wrote:
> Based on the output of adt7316_show_all_DAC_update_modes() and
> adt7316_show_DAC_update_mode(), adt7316_store_DAC_update_mode() should
> expect the user to enter an integer input from 0 to 3. The user input is
> currently expected to account for the actual bit positions in the register.
> For example, choosing option 3 would require a write of 0x30 (actually 48
> since it expects base 10). To address this inconsistency, create a shift
> macro to be used in the valid input check as well as the calculation for
> the register write.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> ---
> I'm not sure if this patch is appropriate since it's making a user visible
> change. I've included it since the driver is still in staging.

We don't want to break user space, but I agree with you that applying
this patch is probably the right thing.

regards,
dan carpenter


