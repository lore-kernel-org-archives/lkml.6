Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43074C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7180B2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJWHLX2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeLNU6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:58:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33024 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbeLNU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:58:08 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so3263982plo.0;
        Fri, 14 Dec 2018 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nKn9yheUmyYNGOHtNqDCelwebCWGHkX+/pUrK3UVzM8=;
        b=dJWHLX2FpXTq8S4acSufbNHvMbzNb4p0GG6Ed48izfhGWPWK1oHzmm8ZsDxs92mGMr
         Jj+KmxM6oHj65FRaPcjYCEXWmPEZwVItcSv5BrVbNez6Zh8gKYim3rjY/axju+3hpiSH
         Yg6dvx5VFq6l2JoQ+/7iuXK5snmBD/d0LeaxpLW8oG9haHl3SFjjCA1y/AqiHj1KAXYT
         yDGnPdJvTTsi3kTlTpmBfvmwpa7ffYfvz8qXU+tiDsgDGRM2lGRktS2mutv93noIxov6
         Kzbv66EznoQNG1OuQbehQN2RNUhNCyJvNksg0WiTQYc+ddxLNBBQRav29G1IVJ0uPxpu
         NCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nKn9yheUmyYNGOHtNqDCelwebCWGHkX+/pUrK3UVzM8=;
        b=LRk2kd4dTt9yNvn4cH52enPztxNRpeI8fap2dovdheAhTTcuvxq+GHS6/0/EQcg+zL
         XQE1I5O8eUhAUR4IhDJ+PAk26yMLA7kfP1omlJG576IvkamVMhGsEgLe+lh1HFCDfWL+
         eQxzYOt6+z6XbHRpzazApkhG9cauw2qraka5BcBuryGLfFfUpKmEU0aAv6tmmOlUZM5A
         cwDCfddFmmTIjI1vwTHqCNVwYolJHc2ujDlrR3FquLk+aodPb/MW7aDCY6AI5ZUaBl/O
         J8/2S3dzngWrvu+Je8s6pGxr7aGFyv9dNDSMV8ak99uYvJbXAEahEqVI9x97GQ1qi8vE
         lvvg==
X-Gm-Message-State: AA+aEWYb6Qydz4jxoqna6ZlKfUtIYLHekJR/Nw1qqIgWPCgl1U8GEh+8
        gEigVfZBFljPOljFjbiRQNc=
X-Google-Smtp-Source: AFSGD/VLOh89EnSalpSeo0xal3qwzpwuPo4L7brqqgRwlMOJJEBw6LlplkSXuEYB80SMB6owLwlrWw==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr4239467plb.238.1544821087915;
        Fri, 14 Dec 2018 12:58:07 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id a10sm7108659pfi.138.2018.12.14.12.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 12:58:07 -0800 (PST)
Date:   Sat, 15 Dec 2018 02:28:00 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        joe@perches.com, gregkh@linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] checkpatch: add Co-developed-by to signature tags
Message-ID: <20181214205800.GA22639@himanshu-Vostro-3559>
References: <1544808928-20002-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1544808928-20002-3-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20181214121634.1157f2302c8ba1825fc03ad2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214121634.1157f2302c8ba1825fc03ad2@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 12:16:34PM -0800, Andrew Morton wrote:
> On Fri, 14 Dec 2018 18:35:28 +0100 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org> wrote:
> 
> > As per Documentation/process/submitting-patches, Co-developed-by is a
> > valid signature.
> > 
> 
> I'm with Joe - I find this tag kinda useless and duplicative.  But whatever.

I'm fine either way, just the problem is:

	Co-developed-by Vs Co-Developed-by

with checkpatch spitting out that it is not a valid signature.

In the end, I can completely remove the tag from docs if it is useless
and duplicative.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
