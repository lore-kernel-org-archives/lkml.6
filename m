Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9547DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9A12146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="hwrnC/0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfBTCm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:42:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40629 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfBTCmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:42:55 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so25707312qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 18:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=2N6hzQ59Ndqu8ZvIp+meiLzMTcx+eYDLzewIvKUgIVI=;
        b=hwrnC/0z/0Z8Z8BkAuyH2D39XQoTnYR+/GLjZvYefCHo1e360AohAfY7sXVwomUCM4
         1E0HyLMRM3PTDcXMa9wfZvI0tUxn/LHhEMafb97i+xxvK4etNGQPhXm/zjl3iDzBK5Lm
         PKRbScuiE8rwHAL7EKPlTvSvv3VZ5Q7Ilukackk8X/1ihxG6yiQGl8QwLa493t8CMMB7
         yqMUwrX9c7dkIFKdQPk/259eufIZMxreK9j/A7tQdYwRkZ7TwfhXON1tD7kmThjCZtsM
         uWwWw3iLYyMFbvblxK9hNyU6qP2lUfN64zQ9HeucAgE2oLqCwUPbIW0Btmmj//qIrhWF
         QwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=2N6hzQ59Ndqu8ZvIp+meiLzMTcx+eYDLzewIvKUgIVI=;
        b=CIGcDouMxwGSHp+sxWFGC1pt331/ahKvZvKJSX0wV/xJpDojn28KE8ZcBCPx2gMQqf
         GRerBHIZzplhjRWnTDfFpBeiAYaJEpFUc5ICiXAQtRfRJVzBeVS/dSyx0ohzrChL+iwf
         mdNLzDmOdZSRRRZe71TqAuh/Cv5bElyDPTVG8h3bRnLVJMqutHzQUhrv3Z+JlRpPo89t
         JvHhN4FcTUDBJF/yvy2TpHRoO+0bCeMOmiKn/o1PFOMiGOLKeOtImpfhITIE9468+Y0e
         0cLeDvY6lZdCFItbH5fCldMQD7DWk9xBVuInKgRf/3oD36nfRm+mDsqiZkd2AZcOnxwk
         HndQ==
X-Gm-Message-State: AHQUAuYsDcEC/41VlKefLs5p1LsH9ETE8hN4t6mU6+YkR8sIzT+oO063
        upSUvI8KrA5v3HDSmoiflSOn/g==
X-Google-Smtp-Source: AHgI3IbaJzwNh6tSXoTix6Jd7DlgE+2J1gFCYGH+uyQBjivn4zVPYyc6kC9WtK3PD+yJunCbrsSFgQ==
X-Received: by 2002:ac8:2585:: with SMTP id e5mr25312192qte.233.1550630574709;
        Tue, 19 Feb 2019 18:42:54 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 24sm7514148qtu.17.2019.02.19.18.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 18:42:54 -0800 (PST)
Date:   Tue, 19 Feb 2019 18:42:46 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 08/21] ethtool: generic handlers for GET
 requests
Message-ID: <20190219184246.276f94ce@cakuba.netronome.com>
In-Reply-To: <99e5e578d2a554bb2bfd9ee04984ff54f8320b43.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
        <99e5e578d2a554bb2bfd9ee04984ff54f8320b43.1550513384.git.mkubecek@suse.cz>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 19:22:04 +0100 (CET), Michal Kubecek wrote:
> +static struct common_req_info *alloc_get_data(const struct get_request_ops *ops)

nit: IMHO prefixing all structures and functions with a common phrase
     (ethnl) makes the code easier to navigate.

> +{
> +	struct common_req_info *req_info = kmalloc(ops->data_size, GFP_KERNEL);
> +
> +	if (!req_info)
> +		return NULL;

nit: please avoid calling complex functions inline, especially if the
     result has to be error checked
