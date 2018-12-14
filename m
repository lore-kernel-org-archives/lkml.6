Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9EBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1318E2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeNrUw9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbeLNQQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:16:14 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34993 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeLNQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:16:13 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so2918588pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hiS5Bs4kBHtEWzWrCY84bFZ30xfBri0aQjI7eZrflak=;
        b=GeNrUw9rXirmSyNXNSdLv44ShW2BnwtzHEODYAB4eoLbvEJh4V2GOS8Jw9/3MiyI9q
         vPFCgJU9ts2JQGMSnF+7gZrDLNPskQvMP7ODNNVELLNPo8IJsOLujLWpEYurEQTl+YGH
         f8zqqrvWT18+4Scw2r7opkufp6uQXo2QbzEua19QFkcGpnjHysPGeVDUtfYznWotasQc
         f1AjyvR5VmBimHYTXX2V0nlGAgN7lpgBqPoE6Hrz7A5Lmw6iDUctTs4SdGsABjvJ7lOR
         YIWuoTZ27nwk5rE8tHBLmbmspI98aFJA4MINUc7PbMON8MSuz41sao3AnjdlrNdev7Po
         X+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hiS5Bs4kBHtEWzWrCY84bFZ30xfBri0aQjI7eZrflak=;
        b=oUgzd5nCRz2DcOC0V5yEUcSVo/ud/1KmQo5NhEu2u8Zf27xMMCX/7iKC/rL7co838h
         GLDiGKwqUHEi+F1LuDd662zoE3Qe8sAZpRWFz3PTcgvCbO5ZmKgh0ygjFSNXy9VGjV+M
         4EfKmiS1RE5a+BlyvRg8c+E+cynbrBAAdXw+bjNnp4c4fw/kVg07Yqcy5rujYo4mwJSj
         mSGzHvs8SVkf+NuvKhu0n//LJdfv60EhL4w8g9pmhHwYx70sM/+K2YkiPqIp+3ld/hcy
         2X5bjplDk98oTLvaDiBkfMkgvYw42mi06m/BHPMKY7YfHRJHHVrJd5mdtvqB2XCGD8Dr
         Eb2w==
X-Gm-Message-State: AA+aEWaV1O/QdaPIZkNKvL6PgHI7GhblZZGzWagKzgwozhH5kg3S98h0
        nhctph9hAjQLXT1bJymFVLY=
X-Google-Smtp-Source: AFSGD/WsFvdDZgPVvYlhwaeiHpYobFpaTo8S3VyDOjMIVhNSRiTfFZuXKSLqzbL+0qnEI9SnmZ/jMg==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr3405110pfc.198.1544804172666;
        Fri, 14 Dec 2018 08:16:12 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id p67sm11455982pfg.44.2018.12.14.08.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 08:16:11 -0800 (PST)
Date:   Fri, 14 Dec 2018 21:46:04 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
Message-ID: <20181214161604.GA17456@himanshu-Vostro-3559>
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:52:15AM -0800, Joe Perches wrote:
> On Fri, 2018-12-14 at 14:01 +0100, Jorge Ramirez-Ortiz wrote:
> > As per Documentation/process/submitting-patches, Co-developed-by is a
> > valid signature.
> > 
> > This commit removes the warning.
> 
> Your commit message doesn't match your subject.
> 
> A couple variants have been documented and only
> one should actually be used.
> 
> $ git grep -i co-developed-by Documentation/process/
> Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
> Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
> Documentation/process/submitting-patches.rst:A Co-Developed-by: states that the patch was also created by another developer
> 
> $ git log --grep="co-developed-by:" -i | \
>   grep -ohiP "co-developed-by:" | sort | uniq -c | sort -rn
>      80 Co-developed-by:
>      40 Co-Developed-by:
> 
> So which should it be?
> 
> btw: I prefer neither as I think Signed-off-by: is sufficient.

OK, but does multiple Signed-off-by: in the commits imply that
the patch was created by all those developers ?

I don't think so, perhaps this was the reason to introduce
Co-developed-by: tag.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
