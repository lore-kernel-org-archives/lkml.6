Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504EA2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 05:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GibVtPJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504EA2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeJBMbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:31:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40311 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbeJBMbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:31:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so39910plv.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 22:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gH/XFyyNL+FpmmHVuK1MkOCMxjunZBYoRFZHXVXFwkg=;
        b=GibVtPJckzvgbCcU8Adkil4G+JixibCVKLYP3MfQGOoaniBGl9nKH/Fg0Nc49yeRej
         fPlH9IKYdOXOi29KykSDps+ZN/+F1UMWZyDibHmUatzb/OhGoa6Q26u1gpBqZncKW8d5
         4dFpuHA4D0qZFmNtvNuxOlUK96Ibic4Y8/D33wCwwHJk54WLInVByU61YhgUCbx0XAXQ
         oF1hv89iUvyeZlWZjg0fmIT2XK4vRL/1ArByFgVT21ADWJF413rYVbgjJoS4oQdsBivu
         EsM45H8uEXmC+vFBOUpIo3aO6Rz1tkpJXTzaj4u+I8Fe4ssYOlrrrvBHXof9ZL16gDF7
         n1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gH/XFyyNL+FpmmHVuK1MkOCMxjunZBYoRFZHXVXFwkg=;
        b=E/DGvMaSIpRVjANofnZTOkDjRI/X0C+f01DlwgfmCWNY0zHnPe2Nx1AMMrRHJBBXJB
         qrxAn5N/OPXjDNyVgF9C4Ay5ok+NTOw7wGvEuzmvpQza1xWtl4zCzK7cIvSIN2DdWC0c
         2SPC7u2vy7pKVelX20MYLeJDoN1eT7+5yW3X9RbO1QquKwEI1qenQF2bhykYqiOG9Mex
         XDl50B2KSNzyxBDy2bhLCILNoI3jmO07p8ujyfCS9IQgapeGo8+9JNg7Oabiw4wlq1lz
         Un+zQPgxPxExCKkHquAJ40wxnjKcKCLjohoZKdsHlOPq8v3BgRfaxswFLAqscAen7xvI
         a27w==
X-Gm-Message-State: ABuFfojjYk5KBmNfDRSeFpeg+SjPkwEg0LVnhqSgCzk8hhfmw70IeSgU
        iOUMNKZ87HEdRI9yC1i1ifQ=
X-Google-Smtp-Source: ACcGV60A8/4841UwSZVx12pSraMd0lXuxi6uEgLpnW4RFOko5Aq3O0x9g5ekVMg62mdR9O65aIG4Hg==
X-Received: by 2002:a17:902:d90e:: with SMTP id c14-v6mr9645880plz.61.1538459422934;
        Mon, 01 Oct 2018 22:50:22 -0700 (PDT)
Received: from localhost ([39.7.19.27])
        by smtp.gmail.com with ESMTPSA id o133-v6sm14942768pfg.86.2018.10.01.22.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 22:50:21 -0700 (PDT)
Date:   Tue, 2 Oct 2018 14:50:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] printk: Correct wrong casting
Message-ID: <20181002055018.GB598@jagdpanzerIV>
References: <1538239553-81805-1-git-send-email-zhe.he@windriver.com>
 <1538239553-81805-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538239553-81805-2-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/30/18 00:45), zhe.he@windriver.com wrote:
> Correct wrong casting that might cut off the normal output.

A commit message probably could have been a bit more descriptive,
mentioning that log_first_seq and console_seq are 64-bit unsigned
integers, this is a Cc material potentially.

> Signed-off-by: He Zhe <zhe.he@windriver.com>
> Cc: stable@vger.kernel.org
> Cc: pmladek@suse.com
> Cc: sergey.senozhatsky@gmail.com
> Cc: rostedt@goodmis.org

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
