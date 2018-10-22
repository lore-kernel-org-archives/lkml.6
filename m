Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5AEC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D7320852
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="XdIhCOd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D7320852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeJVQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:37:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeJVQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:37:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so9217155wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q7rUS9sLQMBhe+2xCBSF1Y95eUAX1ZdOCq/DSNQKqMs=;
        b=XdIhCOd6JUvZev2I0ok9+0ka3gxU5HU+S+rGLwph2KTCSF+n+fp6oN6VRbsefrEI/r
         0ISejwBmNbbGO9lABbNgpKbWG1N1z/uJBb8o84RnOgRa7yypWEJrYzark4k0Dhi/b5uq
         aLldUb251zYuo3NQdKYUqMYZCw4xnZ278pNY0TsbEfIM2D5VaQaXIjo3/wSJ7yS8mSwI
         BZschAjnaqPf3m2JYv62gUETk3lh88TN0DE+N8Xg5SuYgkqqnCuCLuJ1YVCk/k9p2zHf
         ndMYzbYKMLvRrFCxfWFgvdmkDH/2FXFJY8u6w6UfDFNn8wdh/YRyKLKMd25AavZ97JW3
         b2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q7rUS9sLQMBhe+2xCBSF1Y95eUAX1ZdOCq/DSNQKqMs=;
        b=YPSSoV4EDqvknyDbJhGTYFEX7l7dTzl6H8rJRE4FHy4AfcKamheAGPYoK0I463eJAk
         rK18Qq08Az9CO22Ap/91xsI4D1RZ9aCj8PVrgn67MSTSZykoOu42d88Y8NACAYg29ss2
         tBiyfZmhAH/c11foiCzqq6tF4pmj7xExcZPl5YP51gUo+vE8I2sRVxEQTe/9lhf+aF/R
         aEWJ8y8W13DypcuhTxW3rW2HumhPsmu3CdIHpPj1nqI/6QEzjjLC4Ia6iEdo2/52p5Bh
         2AtDK0wQNXf50w8YB+3Lj6QBXADUYK6YzMTzRJOES/Ms62XwbOZGjjar7FttznWvsXVk
         DbHQ==
X-Gm-Message-State: AGRZ1gI2qDfcWLBsxX/Q0ATX2bj6Ceh9g41aab/eXZSKbtLtfXbNCAgw
        e/RpI4595QqmpKuvMSQ/n5z8mg==
X-Google-Smtp-Source: AJdET5f6J/3++LUjGt7KyCJasU4ySWz2oOzBJpXJHcKpgHw9b64WzV+xNwCyD4G+/C4RQXovhfSutA==
X-Received: by 2002:a1c:d986:: with SMTP id q128-v6mr15755010wmg.110.1540196406225;
        Mon, 22 Oct 2018 01:20:06 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id s7-v6sm17143866wmd.0.2018.10.22.01.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 01:20:05 -0700 (PDT)
Date:   Mon, 22 Oct 2018 09:20:03 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     willy@infradead.org, dushistov@mail.ru, viro@zeniv.linux.org.uk,
        David.Laight@aculab.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181022082003.GA3318@pathfinder>
References: <20181020220957.GA7267@pathfinder>
 <20181020222637.GA3477@bombadil.infradead.org>
 <CAOQ4uxhO_-B12280jT5RHX3oMjoSTHG73=PyDDVfURs-ey-EkA@mail.gmail.com>
 <20181021095710.GA3482@pathfinder>
 <CAOQ4uxg2Vb4fKUcN1nHUtYuapBmUNFNiMZYJaPsjKf5z4EAEuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg2Vb4fKUcN1nHUtYuapBmUNFNiMZYJaPsjKf5z4EAEuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 02:02:57PM +0300, Amir Goldstein wrote:
> Yes. If you are looking for a cleanup task, you can
> apply relevant patches from my series, starting with:
> https://patchwork.kernel.org/patch/9481237/
> (Leave the xfs patch [11/11] out)
> 
> But besides verifying that patches still apply and build,
> you will need to address the concerns of fs maintainers.
> Take for example the btrfs patch:
> https://patchwork.kernel.org/patch/9480725/
> 
> It says:
> + *
> + * Values 0..7 should match common file type values in file_type.h.
>   */
>  #define BTRFS_FT_UNKNOWN 0
>  #define BTRFS_FT_REG_FILE 1
> 
> But that is not enough.
> When converting code to use the generic defines FT_*, instead of
> filesystem defined we need to leave in the code build time assertions
> that will catch an attempt to change fs contancts in the future, e.g.:
> 
> static inline u8 btrfs_inode_type(struct inode *inode)
>  {
> - return btrfs_type_by_mode[(inode->i_mode & S_IFMT) >> S_SHIFT];
> + BUILD_BUG_ON(BTRFS_FT_UNKNOWN != FT_UNKNOWN);
> + BUILD_BUG_ON(BTRFS_FT_REG_FILE != FT_REG_FILE);
> ...
> + return fs_umode_to_ftype(inode->i_mode);
>  }
> 
> Same should be done for all relevant filesystems.
> Then you need to hope that fs maintainers will like this cleanup and
> want to take the patches ;-)
> 
> Cheers,
> Amir.

Dear Amir,

I will give it a go and see how far I get :-)

Regards,
Phil
