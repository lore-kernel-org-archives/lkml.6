Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBDCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F81218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YztifqOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAWRuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:50:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44222 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:50:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NHiOua103823;
        Wed, 23 Jan 2019 17:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=0xfOsHv/8cfiH5wzoIyStx5mdpM3wYHUpLbBPkuYiWI=;
 b=YztifqOvpx687Th1UeTaVULm6eZyqGe1LKqV7YgTkSX2y6A98VRyFqRe83yREoUE11xI
 3HEWa1jcv/F/GTV7yypeAIng/2dcVLMLHIw4NWccbAf/K/Z34D5ge0o5uNNnMX5BEn1c
 u2wZbnfHWMMV1n+bSnTdoPT4GKLreLbHx/jADj8jJIvNHifwhbwBsfxAhxb+zel/A4Zz
 3uYKOtA5uKJygFXtw0Ou4PIMwuV2dbVOgXSnTPsfbPlfiWYou8iYcgpMgHpBxtKlXs1I
 KZFO6bDODlX79JGrkriHA37S/vvOShiW5NDpyKEA52VTPZDHmjK8PrEAAqvk/GR5kp4/ Kg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2q3uauuf4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:50:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHofAp020808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 17:50:41 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NHof1Q004855;
        Wed, 23 Jan 2019 17:50:41 GMT
Received: from Konrads-MacBook-Pro.local (/75.104.64.133)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 09:50:41 -0800
Date:   Wed, 23 Jan 2019 12:50:18 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 04/13] KVM: Introduce a new guest mapping API
Message-ID: <20190123175014.GK19289@Konrads-MacBook-Pro.local>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
 <1547026933-31226-5-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547026933-31226-5-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9145 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=665
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (dirty)
> +		kvm_release_pfn_dirty(map->pfn);
> +	else
> +		kvm_release_pfn_clean(map->pfn);
> +	map->hva = NULL;

I keep on having this gnawing feeling that we MUST set map->page to
NULL.

That is I can see how it is not needed if you are using 'map' and
'unmap' together - for that we are good. But what I am worried is that
some one unmaps it .. and instead of checking map->hva they end up
checking map->page and think the page is mapped.

Would you be OK adding that extra statement just as a fail-safe
mechanism in case someones misues the APIs?
