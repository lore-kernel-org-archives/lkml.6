Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEAFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FE920833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hSfr33vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FE920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeINWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:08:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42452 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeINWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:08:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EGhwDb012453;
        Fri, 14 Sep 2018 16:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=tnDeuYETqg3wNvwpJcRHoWfcQ0yPjXk6fGZ9WSx+cVY=;
 b=hSfr33vcCCHyKEU7T3O/IQS2umpsrVxsrD6aYArnQc5bXdU+hUpTlu3gSoiOH4bRhoK6
 JBGs4CG83/dhmyp+0eb7WC3l3bHHHfmP/eSZrTRSXKhWFS83ekqVp42xhxmXv2rBtY2V
 mm6vKhfcOG0b7IRRIGJ7M2lzsSVgCv72ZQD1VFbIARpZja7JHoiB+BMjYm9cZYA+PCM+
 xpT5RbU4kiJoD29H/hP+qrDSY6IabnGBNZUhB7Pyw+7zbG82R8mbH/qjYNdNcutbZkre
 6IVGhykB03ZDxb/fre2SKhLZGG/v4TyJfOtcFaTVsv6Rr5CPLOF1arVajIvBsE0tH/UW DA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mc72r85bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 16:52:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EGqfqL018216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 16:52:41 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8EGqeSc026751;
        Fri, 14 Sep 2018 16:52:41 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 09:52:40 -0700
Date:   Fri, 14 Sep 2018 19:52:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Robert =?utf-8?B?V8SZY8WCYXdza2k=?= <r.weclawski@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentine Sinitsyn <valentine.sinitsyn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Kacper =?utf-8?Q?Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        Manish Shrestha <manishshrestha2006@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: remove code that is valid only for 5
 GHz
Message-ID: <20180914165231.s3j2phc6jewe2ehm@mwanda>
References: <20180914061232.323jxklcp75ugtvr@mwanda>
 <20180914155905.4891-1-r.weclawski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180914155905.4891-1-r.weclawski@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 05:58:58PM +0200, Robert Węcławski wrote:
> > On Thu, Sep 13, 2018 at 10:32:39PM +0200, Robert Węcławski wrote:
> > > diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > > index eca06f05c0c4..b610443f2ac6 100644
> > > --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > > +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> > > @@ -1819,16 +1819,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
> > >  	case WIRELESS_11BG_24N:
> > >  		pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
> > >  		break;
> > > -	case WIRELESS_11A:
> > > -	case WIRELESS_11A_5N:
> > > -		pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
> > > -		break;
> > > -	case WIRELESS_11ABGN:
> > > -		if (pregistrypriv->channel > 14)
> > > -			pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
> > > -		else
> > > -			pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
> > > -		break;
> > >  	default:
> > > 		/*  TODO */
> > > 		break;
> >
> > Are you sure about this chunk?  I would have thought that <= 14 was not
> > 5G.  (I try to avoid rhetorical questions and I don't know the answer
> > here).
> > 
> > regards,
> > dan carpenter
> 
> I'm 99% sure this part is not needed because this chipset only supports B, G and N WiFi networks.
> 
> I think we should add pdev_network->NetworkTypeInUse = Ndis802_110FDM5 to default case to be 100% sure it won't break anything.
> If we do this we can be sure pdev_network->NetworkTypeInUse will be set.
> Should I make a new version of this patch?

Yes, please.

regards,
dan carpenter

