Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58216C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4C1217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5KVPfao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfBLPJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:09:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46255 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:09:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so1368581pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dOrCNbJyqJnEAtlTGTYJGJAKvxLGRrio4+VZj9rvkJQ=;
        b=e5KVPfao98Qcr1Rggwntx1XqtSEjVF6BnuVRI018KF+5izRbzMIbZMGzN8sdvu+6PW
         kWCtecdrYlieYzaaJ01RAugCVsc5yqfdXaBWyIJKqRUwWcAnJwKtl257V1ctrSeLIh7U
         835e/PY83qRhXBozZNKEY6X2AcGvfy6E3CHfvpVROLAP2c+EujfuW0oHW4qVe+hTFfXq
         TzZZ/Pi4CyHSXEO3SS7kzRBnLB803vd9Msm73Ki2yMdbJMQMph/nx2WTrK312Hqd+Yvd
         /oAHVtZg8cDRmLiZ72mSSoOhnqW6l9zVwYOedsEl8PsBNgEjmBUzY4Mcnqcpe9eX7up9
         uw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dOrCNbJyqJnEAtlTGTYJGJAKvxLGRrio4+VZj9rvkJQ=;
        b=CKLShTyqmwSMQDoi+EBmFBL15f69sxlu8izmbHfZJav2SNvaIibYs2CX3EsZpaJSqw
         XdzdnMMPSJzcV86IOp+syheYaTrnECG4ffDoADgTLhg1Refd8210YBmmVSmlo4STd1+U
         I+lypVejoH3x3j991HoscwshdKDmCoWWn0lL0++sz09zNKAjubYkdM0WU9cJMP779qwp
         0ONloXomvotdQJ3kzg0pmWm2W+F+kITL4U7kiDZzqHK6eF75SUDafAVgjtNcncGa3DwU
         +DzTgLUyMqsW5P3zNScbuG1oCEmBro5e+oyCVzZs2yylO6iDZ8qDGnm0RilBZBAV6iIl
         hYtw==
X-Gm-Message-State: AHQUAubutPZ+6fFIXw9ZoG4r3XvGFTERGWqLVlWIgS+nvqpAcftWBvAr
        Rx61cJjJcYVnGQ+wS8Wah0yMOJkC
X-Google-Smtp-Source: AHgI3IZ/RRcD9WLJjpnCHIDB6aPQ5OdMoJlHAw/nFit/YXOzynDTmG/ixqZQz1ud05hdntKikpmOxA==
X-Received: by 2002:a63:e10:: with SMTP id d16mr4108253pgl.148.1549984172150;
        Tue, 12 Feb 2019 07:09:32 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id q21sm29525921pfq.138.2019.02.12.07.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 07:09:31 -0800 (PST)
Date:   Tue, 12 Feb 2019 20:39:25 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: Use the correct style for SPDX license
 Identifier
Message-ID: <20190212150923.GA3366@nishad>
References: <20190205150620.GA17522@nishad>
 <20190205184431.GD22198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205184431.GD22198@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:44:31PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 05, 2019 at 08:36:24PM +0530, Nishad Kamdar wrote:
> > This patch corrects the style for SPDX license Identifier in mac.h
> > by using "/* */" in place of "//" as per Linux kernel licensing rules.
> > Issue found by checkpatch.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/vt6656/mac.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
> > index 94e700fcd0b6..75166020f7c6 100644
> > --- a/drivers/staging/vt6656/mac.h
> > +++ b/drivers/staging/vt6656/mac.h
> > @@ -1,5 +1,5 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > -/*
> > +/* SPDX-License-Identifier: GPL-2.0+
> 
> Should really be:
> 
> /* SPDX-License-Identifier: GPL-2.0+ */
> 
> thanks,
> 
> greg k-h

Ok, i'll modify it.

Thanks for the review.

Regards,
Nishad
