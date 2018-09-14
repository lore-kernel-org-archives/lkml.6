Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A005FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66AD20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jeke6J8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E66AD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeINLZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:25:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeINLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:25:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8E6AY0r042607;
        Fri, 14 Sep 2018 06:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=TK0qNECg94FvUnbVKuDZW72yLp8i2e5Y+EWzEKYUMCk=;
 b=jeke6J8C/NW18vyOuhsjKcYeAYisBt01zts+jlfPFKrpgWK9UG+pWpfOi9fWgEA7bn53
 xDb3DqFz93LOVYvPTKlEe5OyWZJeDFD9j/l4D/2oTzvuy9v1S5+b/4Ppo68KOVpytSBt
 3o0GcWLvoaeZJ1jAet9J+JGjathPfmr4Xlq86fycP7PL2Os1jxfKOE01qe9eiK1j5gH5
 XQczRacYkvwdXVnxAQI9sUlLB2eml8O1efOdlEoW5We4TB3bWBEmOD7J6W9390yKtwkt
 lizckDops5sDa0JGzP3xMZiFqNfdmFbkdCFkIwrz3t58UyewcI37KJ3bts1yePh5epll 9g== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mc5utw4qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 06:12:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8E6CgOl022134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 06:12:42 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8E6CfZK028306;
        Fri, 14 Sep 2018 06:12:41 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Sep 2018 23:12:40 -0700
Date:   Fri, 14 Sep 2018 09:12:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Robert =?utf-8?B?V8SZY8WCYXdza2k=?= <r.weclawski@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Kees Cook <keescook@chromium.org>,
        Kacper =?utf-8?Q?Ko=C5=82odziej?= <kacper@kolodziej.it>,
        Mihaela Muraru <mihaela.muraru21@gmail.com>,
        Valentine Sinitsyn <valentine.sinitsyn@gmail.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>
Subject: Re: [PATCH] staging: rtl8188eu: remove code that is valid only for 5
 GHz
Message-ID: <20180914061232.323jxklcp75ugtvr@mwanda>
References: <20180913203246.4376-1-r.weclawski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913203246.4376-1-r.weclawski@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 10:32:39PM +0200, Robert Węcławski wrote:
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index eca06f05c0c4..b610443f2ac6 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -1819,16 +1819,6 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
>  	case WIRELESS_11BG_24N:
>  		pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
>  		break;
> -	case WIRELESS_11A:
> -	case WIRELESS_11A_5N:
> -		pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
> -		break;
> -	case WIRELESS_11ABGN:
> -		if (pregistrypriv->channel > 14)
> -			pdev_network->NetworkTypeInUse = Ndis802_11OFDM5;
> -		else
> -			pdev_network->NetworkTypeInUse = Ndis802_11OFDM24;
> -		break;
>  	default:
>  		/*  TODO */
>  		break;

Are you sure about this chunk?  I would have thought that <= 14 was not
5G.  (I try to avoid rhetorical questions and I don't know the answer
here).

regards,
dan carpenter

