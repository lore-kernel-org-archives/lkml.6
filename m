Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3D5C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A5E204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsqdUVSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A5E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeLNGqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:46:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39137 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNGqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:46:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so2275069pld.6;
        Thu, 13 Dec 2018 22:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5k5Xm7gA+YAbibREjZJes4UWSlK5iNrBIVPrVuEWcSM=;
        b=nsqdUVSIG5cVdCSXsJj0Fobi82G7Bzur0LaZw1IQV6jhdeL23zatVV43vuEMw5FQF0
         v6IJuxIiUL7+yD2NtOt+5OcFXJ6tOPC3XD26hHfml88wvOd/XM465Y63SVu2cDjbkbsG
         KXC/Qz0SvADPt+yJXCycaW7/8LSVmnNztnuF3vPUVO8VI+6zJUEB8Kf+QV9C6UDv/z8E
         InTBRmbEvwPcevta+eiI8UdgPypY+lR6Dl9qsfUH7w2EGRAGfDgrd8uTJuSX+Fn+j+W5
         MXG9tUAubfJA1vBREx2R8ORRuPknsWL8rShP3GupK0v50kX0DTn+DBpXbb4fqDAB3JpB
         hwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5k5Xm7gA+YAbibREjZJes4UWSlK5iNrBIVPrVuEWcSM=;
        b=chYs1+eQNcfoYmRiHrWPxcJVTr9Jvs+KyVWfexOZtmTrfJOBST75QUuwnFrda5u7Fj
         ILza1OXVMGb8q09GI54HAG143nvLodrVePrGVT1TDAiJ9AnoHzyb0q62dUo+Lf3ycupy
         p/r/TeNovMB4kF30uN+IPme9mnFKBkFEvAUMzLotIDT5AwXQAQwHHTGBM5O1pLxPoGOY
         V1WBVgbBWxFsrlK7aWIkakryL+8oFNEM98q1+9HKGu4juKdVUWFPTSzfFfDZ1KSlEBbh
         o2RjT3Hs3jN3lmcHh1gKptQvkthb27R1gdqCNBtj+8RghYXFrHo4Ytd4i7U2jSBox+SG
         CdPw==
X-Gm-Message-State: AA+aEWbcoF1ztNBOOUKoxFC3Xt9eNeNFwoBUHXSHwjZ8zJJNKuXUqT/q
        S8ztiI5ftLl5r+FtraWjWiM=
X-Google-Smtp-Source: AFSGD/WG3tA/gpk1hm1D2RF0FwrUOLQ9yv3B1TFtJkjjIbo1n6GznsMDtgghTu8jGiNPpKGlO/YABg==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr1851018plb.125.1544769994631;
        Thu, 13 Dec 2018 22:46:34 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c20sm4965074pfc.92.2018.12.13.22.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 22:46:34 -0800 (PST)
Subject: Re: [PATCH 0/2] of: phandle_cache, fix refcounts, remove stale entry
From:   Frank Rowand <frowand.list@gmail.com>
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
Message-ID: <84933c5e-04b1-df82-daec-cbae1017a830@gmail.com>
Date:   Thu, 13 Dec 2018 22:46:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael Bringmann,

On 12/13/18 10:42 PM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Non-overlay dynamic devicetree node removal may leave the node in
> the phandle cache.  Subsequent calls to of_find_node_by_phandle()
> will incorrectly find the stale entry.  This bug exposed the foloowing
> phandle cache refcount bug.
> 
> The refcount of phandle_cache entries is not incremented while in
> the cache, allowing use after free error after kfree() of the
> cached entry.
> 
> Frank Rowand (2):
>   of: of_node_get()/of_node_put() nodes held in phandle cache
>   of: __of_detach_node() - remove node from phandle cache
> 
>  drivers/of/base.c       | 99 ++++++++++++++++++++++++++++++++++++-------------
>  drivers/of/dynamic.c    |  3 ++
>  drivers/of/of_private.h |  4 ++
>  3 files changed, 81 insertions(+), 25 deletions(-)
> 

Can you please test that these patches fix the problem that you
reported in:

    [PATCH v03] powerpc/mobility: Fix node detach/rename problem

Thanks,

Frank
