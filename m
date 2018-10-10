Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CE7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764A420645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="djNc5dHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764A420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeJKE26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:28:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36564 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeJKE26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:28:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9AKxOhR014810;
        Wed, 10 Oct 2018 21:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=p2yHKbq37yUVtAGtdNMbgDyO1U7OQ5n3rj3nh1L2rjc=;
 b=djNc5dHP5IQQjn3+BhslHAar12aRzAii9oaO/RG3l9KRShrfJ3aU6lwPFySylGSJJDfX
 3D44qV1/jiv5B9LbqYD5PxJ5/qQ/YzcmqozJWQMcM0cI8I8ydvd8Tq4H7Fcz2bz32N5B
 lYBCiq1TLZhpNlrlWSyxKcIXl3IpL1dutXtQGdcPsd+Djz99z75lVeIySqY8X1cvBeqQ
 KQW6YNvGlabumSSXcgrDVUXltxhLn+F3oRxwiyx4XjlHhyUzukcGGAB83JP1x1jVs8FL
 eEfF5HkejBcn9C7KQMYJzVnVJFjBq48/m91SWQu4zI/Ga2ycIT/FnQjwCugu4EhnerGg YA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mxn0q6puy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Oct 2018 21:04:58 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9AL4wWP004068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Oct 2018 21:04:58 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9AL4v7w005673;
        Wed, 10 Oct 2018 21:04:57 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Oct 2018 21:04:57 +0000
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id A561C6A0134; Wed, 10 Oct 2018 17:04:56 -0400 (EDT)
Date:   Wed, 10 Oct 2018 17:04:56 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] code-of-conduct: Add back the TAB as the central
 reporting point
Message-ID: <20181010210456.GB30366@char.us.oracle.com>
References: <1539202053.12644.8.camel@HansenPartnership.com>
 <1539202230.12644.12.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539202230.12644.12.camel@HansenPartnership.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810100195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:10:30PM -0700, James Bottomley wrote:
> Add a Reporting section where the Enforcement section used to be.  The
> intention is still to debate what should go here, but in the meantime, this
> gives us back the central reporting point we had in the old code of conflict.
> 
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> 
> v2: Added this patch to allay concerns we were stripping the reporting
>     mechanism entirely.
> ---
>  Documentation/process/code-of-conduct.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
> index 4dd90987305b..2000bdc2a6ad 100644
> --- a/Documentation/process/code-of-conduct.rst
> +++ b/Documentation/process/code-of-conduct.rst
> @@ -59,6 +59,16 @@ address, posting via an official social media account, or acting as an appointed
>  representative at an online or offline event. Representation of a project may be
>  further defined and clarified by project maintainers.
>  
> +Reporting
> +=========
> +
> +Instances of abusive, harassing, or otherwise unacceptable behavior may be
> +reported by contacting the Technical Advisory Board (TAB) at
> +<tab@lists.linux-foundation.org>. All complaints will be reviewed and
> +investigated and will result in a response that is deemed necessary and
> +appropriate to the circumstances. The TAB is obligated to maintain
> +confidentiality with regard to the reporter of an incident.
> +
>  Attribution
>  ===========
>  
> -- 
> 2.13.7
> 
