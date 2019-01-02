Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38944C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18A1218E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+bIF1Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfABQR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:17:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38857 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbfABQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:17:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so14771682pgc.5;
        Wed, 02 Jan 2019 08:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p94rmo3HfxFw3TnPvo7d+KwuHKwrbZB6ZPl5iqHrEew=;
        b=L+bIF1Nt7XQRd9lFDngIRU/N1TwV54I61ElYNFcRKnJjtmVUpzHUUkKoTN+wBCBtBu
         DArEakfpFT1nFoKRTdcShoMQw1a3cAfNdnbNG/CweVLzPUpldh50/GbBIpW05Eo14WMK
         5gO7bX9R6brTB5Skt8jxT7qXSoIetv94njUSJ0kmbhgTGP2jNWZoel0Bo/SEmhV1Ng5s
         AMl6+UC4ki1gzBhhWCJcAFewIvTkgE4hnY6TrkPCvbAYXHGJAbRZM0OaYAa0V1IKMyXZ
         PjBYFaICzVwgXwbZG0Dcb3K6cpZXuGD2HQy6PUav2v9WT44ynOo7PYFpWTH6gQhI0/pj
         xcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p94rmo3HfxFw3TnPvo7d+KwuHKwrbZB6ZPl5iqHrEew=;
        b=lsebNMLHkS41ZyTvNIaO4wvKI6WWGLug911BtIsdDpcodPLmyp8xhoow+B4d+R4qKI
         Eq2pAj0MKao23GNSf7/i6HaoUpWGXyXxjF5XLDJ7JH4gAT2tUFxX4kGHvKiHasBiXIzo
         lkV8/DE+XE1IMG1C0+L4y4K20AUn+Tj1U7D0bJ+upHwNbTLy/zUdg7e+Xf4hpfprfwk2
         NHeh15Wwr1nE55sqsIlQH4RejlQ4MZ5oQK1BsQ8ib5Qzy9ULz5hIOrfJ9SYEVvdLJ3Hi
         562A1FEgTwcxjzjWp2yz2HW4RdmMVxQ1GzxYkeZ50aTp4Qdfi2EZLgz8K0vV0NGBSNE+
         z1Lw==
X-Gm-Message-State: AJcUukcbnlE807hckYN4+JWJOX7vdTfckRYjMiXQmHboNkNSORR/T9F8
        UTCy83BGfXfo/1lfBGEe/5c=
X-Google-Smtp-Source: ALg8bN7z8xWuWEGe+d7aV1Hze7s+Ua/x9ydpb5Gu8kCzvAXc9/6T8Wl5OPkc+5m6R9jZlWgu0f7c5Q==
X-Received: by 2002:a63:1560:: with SMTP id 32mr13810151pgv.383.1546445847902;
        Wed, 02 Jan 2019 08:17:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b202sm107756312pfb.88.2019.01.02.08.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 08:17:26 -0800 (PST)
Date:   Wed, 2 Jan 2019 08:17:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, Kangjie Lu <kjlu@umn.edu>, kbuild-all@01.org,
        pakki001@umn.edu, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: lm80: fix a missing check of return value
Message-ID: <20190102161725.GA5301@roeck-us.net>
References: <20181221061304.59684-1-kjlu@umn.edu>
 <20190102152359.GC22256@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102152359.GC22256@kadam>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 06:23:59PM +0300, Dan Carpenter wrote:
> Hi Kangjie,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Kangjie-Lu/hwmon-lm80-fix-a-missing-check-of-return-value/20181222-023000
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
> 
Fix already queued, waiting for end of commit window.

Thanks,
Guenter
