Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88E9216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi5BXaEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88E9216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbeI1Ebo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:31:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34397 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeI1Ebo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:31:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so2940833pgv.1;
        Thu, 27 Sep 2018 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1ebwwlBwC8c0y9YoV45xfwpWffO0CA8NPiQrULOapbo=;
        b=Hi5BXaENpQacH9ayyAyVS3iYrzIr4AaQ0w7CTfvyDzWmHZXE9imPVNZQ9M6HdNk9mc
         6XjUAyOkAixp+gVEyc5nnl4IesrPqmUgV/VwOYNDhNK30YOLmNhRbggxCvKbxaouo2Ej
         ddntV8LY2U3YYZXhTEEi2rZoHYldSI73kiez5BWGl3CNhcToWZNaIZ0zPj5AYQWIKtCf
         NpuLpvMadtHfWchdSY/buQa4VJUUdW+IyBDzByhA+sCx4SEiSmZq474xnIywhSCziSHd
         xAHI3AsZ2ABszqHV21peULrzqe+sekVT2wst0LJomzpTWHqKmsfg6EnBkG1R0TYIdHLq
         g2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1ebwwlBwC8c0y9YoV45xfwpWffO0CA8NPiQrULOapbo=;
        b=sYRjVswbc9zp3y0QYAstlkAFSZFDRPLIKKi7ebi8ozarN8Cp5lvklxsXqjghRJy3hT
         QJxFr5wULqk2O8jMKb5bbKHPEKPRiS3RnREY5TRugAOye2DfSYlhJ4gj48eBoukMNxFH
         9lvwp4j5yewtTUmzkJI59VO8wrrvLLzwyyLD9je8joskM8v7CyeFD4AUSJCmqG6Dt7NN
         q1fuGDXqz2SZ4wUGDqOi9UfZ18vXQ7b6sWVUKDgxsncCPeO/mtw3LTXhYTw8cRB9AFQU
         S0sSFqQ+h2Vc3gSb0HBml3L4UhZp455xGbthUokoZraoKeKXBdYtQcy4UouTcmB22xwO
         6drw==
X-Gm-Message-State: ABuFfohvP6skzy7MFpdvqOdG1kRGDassR7uNpqVZiiotbYuNTcwcuchq
        aHVD2i9ASXolCkhSAsFCnLc=
X-Google-Smtp-Source: ACcGV61dzsqwKRnrbOl8Sq5Ua7mAKs/99XEHKbc0k4Gsq9fA48FcYZB1VDLHCyUwq2DjF+X84O7Kww==
X-Received: by 2002:a63:730c:: with SMTP id o12-v6mr12111138pgc.397.1538086276996;
        Thu, 27 Sep 2018 15:11:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j16-v6sm6691627pfk.125.2018.09.27.15.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:11:16 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:11:12 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 2/2] hwmon: ina3221: Read channel input source info
 from DT
Message-ID: <20180927221111.GA29012@Asurada-Nvidia.nvidia.com>
References: <20180927205406.21932-1-nicoleotsuka@gmail.com>
 <20180927205406.21932-3-nicoleotsuka@gmail.com>
 <20180927220620.GD9198@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927220620.GD9198@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:06:20PM -0700, Guenter Roeck wrote:
 
> I am quite sure I asked to use kstrtobool(). Did that get lost or do you have
> some reason to not use it ?
> 
> I can understand if you don't want to change ina3221_is_enable() to
> ina3221_is_enabled(), since that is POV, but I don't really understand
> why you did not make the other changes. Am I missing something ?

Sorry, my fault. It's not really "I don't want to" but I missed the
part in that review. Will fix them all.

Thanks
Nicolin
