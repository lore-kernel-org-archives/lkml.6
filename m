Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E2CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F32E208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 10:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F32E208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeH0OZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:25:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726825AbeH0OZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:25:37 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RAXmO5076752
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:39:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m4dg3d5v5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 06:39:29 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Mon, 27 Aug 2018 11:39:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Aug 2018 11:39:20 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7RAdJeH38666252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Aug 2018 10:39:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F9F942042;
        Mon, 27 Aug 2018 13:39:18 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D0B442045;
        Mon, 27 Aug 2018 13:39:17 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.97])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Aug 2018 13:39:16 +0100 (BST)
Date:   Mon, 27 Aug 2018 13:39:16 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] clk: pmc-atom: use devm_kstrdup_const()
References: <20180827082101.5036-1-brgl@bgdev.pl>
 <20180827082101.5036-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827082101.5036-2-brgl@bgdev.pl>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18082710-0012-0000-0000-0000029F4211
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082710-0013-0000-0000-000020D344B7
Message-Id: <20180827103915.GC13848@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=891 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808270115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:21:01AM +0200, Bartosz Golaszewski wrote:
> Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
> an example of how to use this new routine to shrink driver code.
> 
> While we're at it: replace a call to kcalloc() with devm_kcalloc().
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/clk/x86/clk-pmc-atom.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
> index 08ef69945ffb..daa2192e6568 100644
> --- a/drivers/clk/x86/clk-pmc-atom.c
> +++ b/drivers/clk/x86/clk-pmc-atom.c
> @@ -253,14 +253,6 @@ static void plt_clk_unregister_fixed_rate_loop(struct clk_plt_data *data,
>  		plt_clk_unregister_fixed_rate(data->parents[i]);
>  }
> 
> -static void plt_clk_free_parent_names_loop(const char **parent_names,
> -					   unsigned int i)
> -{
> -	while (i--)
> -		kfree_const(parent_names[i]);
> -	kfree(parent_names);
> -}
> -
>  static void plt_clk_unregister_loop(struct clk_plt_data *data,
>  				    unsigned int i)
>  {
> @@ -286,8 +278,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>  	if (!data->parents)
>  		return ERR_PTR(-ENOMEM);
> 
> -	parent_names = kcalloc(nparents, sizeof(*parent_names),
> -			       GFP_KERNEL);
> +	parent_names = devm_kcalloc(&pdev->dev, nparents,
> +				    sizeof(*parent_names), GFP_KERNEL);
>  	if (!parent_names)
>  		return ERR_PTR(-ENOMEM);
> 
> @@ -300,7 +292,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
>  			err = PTR_ERR(data->parents[i]);
>  			goto err_unreg;
>  		}
> -		parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
> +		parent_names[i] = devm_kstrdup_const(&pdev->dev,
> +						     clks[i].name, GFP_KERNEL);
>  	}
> 
>  	data->nparents = nparents;
> @@ -308,7 +301,6 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
> 
>  err_unreg:
>  	plt_clk_unregister_fixed_rate_loop(data, i);
> -	plt_clk_free_parent_names_loop(parent_names, i);

What happens if clks[i].name is not a part of RO data? The devm_kstrdup_const
will allocate memory and nothing will ever free it...

And, please don't drop kfree(parent_names) here.

>  	return ERR_PTR(err);
>  }
> 
> @@ -351,15 +343,12 @@ static int plt_clk_probe(struct platform_device *pdev)
>  		goto err_unreg_clk_plt;
>  	}
> 
> -	plt_clk_free_parent_names_loop(parent_names, data->nparents);
> -
>  	platform_set_drvdata(pdev, data);
>  	return 0;
> 
>  err_unreg_clk_plt:
>  	plt_clk_unregister_loop(data, i);
>  	plt_clk_unregister_parents(data);
> -	plt_clk_free_parent_names_loop(parent_names, data->nparents);

Ditto.

>  	return err;
>  }
> 
> -- 
> 2.18.0
> 

-- 
Sincerely yours,
Mike.

