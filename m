Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06581C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEBC20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0nu54gUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfBUTTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:19:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42968 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfBUTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:19:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LJIhe1051026;
        Thu, 21 Feb 2019 19:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=U79ozE82iuUXnKSAhwQDiizEL3ZIqNkJdvnHqw1OKow=;
 b=0nu54gUaCvM8H6cI2ItOqZUPs3zljpOCp0R4KwtFFCnBHawC0vmcTa3pP8iztCS/iXoj
 dgoRdoLbP3Hdlt/JKYPDpdeK5mMuyNDDOYl4z61mjJVwPemohqh7YWB5Ww/mGjja29c4
 bp8o3cqEZPNd9fmhNV09hCyv2aG4Gzkfcew6h/ksaqE+SH8VNyL1sl4Riyl99FQHPZsS
 uLNP99NtaUphpWfZya1UL19hGo7t0wALHyZocJCVBLYPyB4x7TSzHl4WTcVA/EbGyzgC
 m8XYGe4Ovlx/gXR06EDiVRWp1X06r69t7dICdsayHYJnOhFwS0WB0pOy/C7N5md9bDqn yw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xua7qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 19:19:06 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1LJJ5ub002661
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 19:19:05 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LJJ5ZU023806;
        Thu, 21 Feb 2019 19:19:05 GMT
Received: from kadam (/197.157.0.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 11:19:04 -0800
Date:   Thu, 21 Feb 2019 22:18:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] test_firmware: silence underflow warning in
 test_dev_config_update_u8()
Message-ID: <20190221191855.GB1737@kadam>
References: <20190221183700.GA1737@kadam>
 <20190221183826.GA30993@kadam>
 <20190221105458.409d1968961962079c54b815@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221105458.409d1968961962079c54b815@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:54:58AM -0800, Andrew Morton wrote:
> On Thu, 21 Feb 2019 21:38:26 +0300 Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> > We put an upper bound on "new" but we don't check for negatives.
> 
> U8_MAX has unsigned type, so `if (new > U8_MAX)' does check for negative.
> 

No, doesn't work in this case.

#define U8_MAX          ((u8)~0U)

It would need to unsigned long for the type promotion to prevent
negatives, but it starts as unsigned int, then unsigned char, which is
type promoted to int.

It would be more clear to just write it as:

#define U8_MAX 0xff

> > In
> > this case the underflow doesn't matter very much, but we may as well
> > make the static checker happy.
> > 
> > ...
> >
> > --- a/lib/test_firmware.c
> > +++ b/lib/test_firmware.c
> > @@ -326,15 +326,12 @@ static ssize_t test_dev_config_show_int(char *buf, int cfg)
> >  static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
> >  {
> >  	int ret;
> > -	long new;
> > +	u8 new;
> >  
> > -	ret = kstrtol(buf, 10, &new);
> > +	ret = kstrtou8(buf, 10, &new);
> >  	if (ret)
> >  		return ret;
> >  
> > -	if (new > U8_MAX)
> > -		return -EINVAL;
> > -
> >  	mutex_lock(&test_fw_mutex);
> >  	*(u8 *)cfg = new;
> >  	mutex_unlock(&test_fw_mutex);
> 
> if *buf=="257",
> 
> previous behavior: -EINVAL
> new behavior: *cfg = 1
> 
> yes?

No.  The kstrtou8() check the limit so it will return -ERANGE.  I should
have probably spelled that out better in the commit message.  I'll
resend tomorrow.

regard,
dan carpenter

