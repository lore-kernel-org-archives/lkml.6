Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99615C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510C020BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eaPSFWC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510C020BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeGLM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:26:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37176 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeGLM0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:26:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CC8hRE189524;
        Thu, 12 Jul 2018 12:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=+bDiW32H2pkBWyBA8IkZ1LMSuI1wj5rxBdjQQjrTHaE=;
 b=eaPSFWC49LsyEkloaDX8pylO9z0vPqLtckqAr9Gc/6b2XItU8FSOz7z8qsOhCszMrQc6
 oO9/6jbftXkbzhIB5/KL2+7uZMJYnNzDW2K+9jCpSm8xIInWgXoHgFFQCF2WMGNsbLmF
 1bMjIHdHdKWPEzx00v37ojapYrOcOXCIGOY6XLAPFJb9bXssG+Cr68BMgPl1GimLb60I
 3SsxXUzJJncGn7iYU+d3x5LqNH/2+JNivOfeiC8eZ0YcAK/rhPs3nIs8E0w5ygvlQYV4
 cQI+h0pkCzzSouscVcZNSSwhw0aBsjiWWc3aFE+PGA7+U+jckew2vDhjB773MEHMiOE+ Lw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k2p763ct7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 12:17:07 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CCH5eA017812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 12:17:06 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6CCH2lS006344;
        Thu, 12 Jul 2018 12:17:02 GMT
Received: from mwanda (/41.202.241.62)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 05:17:01 -0700
Date:   Thu, 12 Jul 2018 15:16:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
Message-ID: <20180712121528.gxe2oygqcz4zopyn@mwanda>
References: <20180618060709.14290-1-andr2000@gmail.com>
 <20180618122951.v55dxtjg4azezjvg@mwanda>
 <a0b8ffa2-cf75-5a8c-7341-29855780fc00@epam.com>
 <a9167704-e687-2688-18b8-f5e6320b1089@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9167704-e687-2688-18b8-f5e6320b1089@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=649
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 02:58:00PM +0300, Oleksandr Andrushchenko wrote:
> On 06/18/2018 03:32 PM, Oleksandr Andrushchenko wrote:
> > On 06/18/2018 03:29 PM, Dan Carpenter wrote:
> > > On Mon, Jun 18, 2018 at 09:07:09AM +0300, Oleksandr Andrushchenko wrote:
> > > > drivers/gpu/drm/drm_gem_cma_helper.c    | 2 +-
> > > >   drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
> > > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c
> > > > b/drivers/gpu/drm/drm_gem_cma_helper.c
> > > > index 80a5115c3846..ce868ce288fb 100644
> > > > --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> > > > +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> > > > @@ -436,7 +436,7 @@ struct sg_table
> > > > *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
> > > >         sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
> > > >       if (!sgt)
> > > > -        return NULL;
> > > > +        return ERR_PTR(-ENOMEM);
> > > >         ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
> > > >                     cma_obj->paddr, obj->size);
> > > 
> > > If dma_get_sgtable() fails then we return NULL.
> > > 
> > > Fix that and it should be good.
> > You mean I can put your r-b with that fixed?
> ping

Yeah.  Send the v2 patch and I'll review it.

regards,
dan carpenter

