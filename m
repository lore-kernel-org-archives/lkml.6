Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7117C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D4F20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G979/ecc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D4F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJKPIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:08:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeJKPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:08:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B7dbDm178861;
        Thu, 11 Oct 2018 07:42:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=jba4rtlbNwZ2X0ckvA9XSHvdwV2ld4/spV4E/7tA5ts=;
 b=G979/eccyV58BBQbGOW5JgcBMXiDjDmyJ0laCk1MYa04KwPJu5Ik8U+v+R9trbr1Y6Ld
 ZU9rpt+505q57eyxotoLhNhLOcJ+hwZXwaXNqR6cUxLchbiQ97SZofcaZtWl7mUO8xPs
 R7JDwtRFUKLw2WZ+wV0TJydyxXgkPtQ/t6p68Nt7aBK/+z0n2sXLFz5lBpLW7XBYL7zl
 Pmp2pyOX3z2uYMnz2Ttyk/JdeF8HgoizjyrTdfagZNGPzIMwdCzqwaFACVZLxcCt51Zc
 aWkLIX/tN3ohWASYK7Kdd9pXK2YTLLXsns0aft6PpOyPW3xsfeYGgKljEmFUTdsme1sI Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mxnpra7tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 07:42:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9B7gWXT017715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 07:42:32 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9B7gUTU029122;
        Thu, 11 Oct 2018 07:42:31 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 07:42:30 +0000
Date:   Thu, 11 Oct 2018 10:42:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tim.Bird@sony.com, linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Message-ID: <20181011074224.zzhh3btcj3kxw4k7@mwanda>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861851.4088.7.camel@HansenPartnership.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
 <1538883209.4088.14.camel@HansenPartnership.com>
 <20181008163748.0e68cba5@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008163748.0e68cba5@alans-desktop>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=647
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:37:48PM +0100, Alan Cox wrote:
>  
> > I happen to think that the fact that the TAB cannot compel where it
> > cannot persuade is a huge strength of the system because it means
> > there's no power structure to subvert if someone were interested in
> > using it to try to impose their own viewpoint on the community.  But
> > that's just my opinion and I did write the TAB charter, so I'm probably
> > biased in this viewpoint.
> 
> The TAB can't handle it anyway because the privacy promise about
> reporting is incompatible with reality for three reasons (and I bet there
> are more)

Really you want to keep any reporting private from people on the TAB
because they're going to be interviewing you for a job in a couple
years.

regards,
dan carpenter
