Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E449C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99B5206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqkYCLdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99B5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeIFNqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:46:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46174 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeIFNql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:46:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id t19-v6so4673928ply.13;
        Thu, 06 Sep 2018 02:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SYtLqUIpxOfJTVn75e2jp0vGWmT6KVdygBF69ZeHTYc=;
        b=tqkYCLdWyOB7Xl2uwk9TKpQXh4doNLmAO80zQXa8RzKl6MsoRM3b8spRSwS4bLV5/Z
         /0iWVw0EzsT+bgrjRBUId9xV4Y+FhSlKPhamO/f6Tutjx9TRm2K3RSiUM8vTGjLQVUQy
         tD38SV3/v2ZE8sDAMPIJJ+oFy04DzCayIvFOSim9QcnIjkZMaaf/Hj5LnL3BxYyOPMR3
         27mUxhCpUUv4zD35WKTX5cEIwk/LX8kH6igRALFO0SYCUzJ9A4/j7Ts3hlmyHpBnGdJe
         /bwTD5z8FziFgeLmYkBml6gk0M+GiQMQDg+baSHHpCCL+7W2Zx2v0GSmbcb0WbRDloxw
         qTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYtLqUIpxOfJTVn75e2jp0vGWmT6KVdygBF69ZeHTYc=;
        b=EK3XORk1TMTujyYZfwWDhRCak+jGwgRN72JZpFsjaGDlMGH92+Li6lmv/YVBXisWDA
         TmZrpsNGE4oywOwFYNYrB+7xXcYddfyNEy9DNKSrEUKaOX7WJO+iBJbowujmts/zLiBP
         JjgIUisI5TI8PnWkqc7Iz0lQ17Dl5dlXi8S81csMZfwk2u+9CBe6tsVwP8hyHB5Ebr7g
         VzpO2dTUfWI6otAl+Q5QUZPJnXpMH7c2g5IdmME3rA8zkYTYxkzIzwryQKTzEFUNMFBh
         96HoEiIWL54fDiXR8SgiZGCdV+PszQyVAjRE15MMtDHE3XK3NIVT/GasLDLfm9pVIlO1
         2Sow==
X-Gm-Message-State: APzg51BzBcq/3VwtcA/pJaxZ7sp9fa3St7OhWkJXtm7fbcTk8cG2xyRD
        e+kMZ3IobCSpviixsuJV0PE=
X-Google-Smtp-Source: ANB0Vda7YxmpwmvxOCRcyAheQEAD3pj0KaszgF6QT7gWP2FZmyZUpt1cyCf8xgnHUSgBWeb2ppxYGg==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8-v6mr1736682plo.308.1536225131914;
        Thu, 06 Sep 2018 02:12:11 -0700 (PDT)
Received: from localhost (g221.58-98-169.ppp.wakwak.ne.jp. [58.98.169.221])
        by smtp.gmail.com with ESMTPSA id g66-v6sm7079501pfk.39.2018.09.06.02.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 02:12:11 -0700 (PDT)
Date:   Thu, 6 Sep 2018 18:12:09 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 10/21] openrisc: use for_each_of_cpu_node iterator
Message-ID: <20180906091209.GJ4594@lianli.shorne-pla.net>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905193738.19325-11-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 02:37:27PM -0500, Rob Herring wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
> 
> This also fixes a leaked reference for cpus node.
> 
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take via the DT tree. This is dependent on the
> first 2 patches.
> 
>  arch/openrisc/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 9d28ab14d139..e17fcd83120f 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -158,9 +158,8 @@ static struct device_node *setup_find_cpu_node(int cpu)
>  {
>  	u32 hwid;
>  	struct device_node *cpun;
> -	struct device_node *cpus = of_find_node_by_path("/cpus");
> 
> -	for_each_available_child_of_node(cpus, cpun) {
> +	for_each_of_cpu_node(cpun) {
>  		if (of_property_read_u32(cpun, "reg", &hwid))
>  			continue;
>  		if (hwid == cpu)

This looks fine to me.  Thanks Rob

Acked-by: Stafford Horne <shorne@gmail.com>

