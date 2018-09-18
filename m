Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85B3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C94C214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9oFj6Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C94C214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbeIRWik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:38:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41548 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbeIRWik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:38:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id s15-v6so1335732pgv.8;
        Tue, 18 Sep 2018 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rpj7C/DP+RR+9zS8m+GJFa5Je3ygCxDJXdm5C3MKGso=;
        b=h9oFj6EgGGq0xzXjNRu4CMfR7k3oHqkulYrBp/LAnWmjQG0MLuu18L8x/oIEJA/pgd
         Uz7mNoJAYO+hL+GixSlYNhGs/KhQERLzYbQ8CKY6Y2/iC3hTIUQsYSIgyYULnu54mABr
         MgnFXG9rlGW13OwOk/xBntHPbigJxD2/y81MEOtg97rZnZX/5RlhhroPTW1Evrt/mSFB
         yiX0l/G+569B6aCDsSx4zUvulXcL5VzUEMyaGcl/tDFZwFa9ZgzQFkWmhw0q597H6oMa
         CmsUl+E01tZhn5Pbia9+dEQR6ULLamoLghdq46t94Xnc1I8LvxwQZoDF5jn8EmVImfRh
         zQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rpj7C/DP+RR+9zS8m+GJFa5Je3ygCxDJXdm5C3MKGso=;
        b=H1EBEL53mFxkzAZzeQmBvp6gJQbYwQhYvyDyCn+TDmhDjAQac67Aus9SNEHEtI83td
         sLtWL7cjbz7akSKZ8Iy2/8r8dmlfuCDL3rv3qOlluuOCXqorFIJOthumVc+pbdQw/PVM
         grbURdInbtWAuCszj8qhuhUYSLVxYYPyVPL5Q+Il88+0OXJekAHazztNqP137SqsRqFA
         iJaftrmpOW5xZunobFpmJc3pjrx3NVjGJNqApXG24HzaUwhgNrmpJShaRGaWUKzxhNqv
         CB1SmX38IdpY3x7Ksh8+ra4x8QF6XQMcUKShLUuo+ypllfTq5ZP4NIrlz6LSfTzL5fpN
         ZGRg==
X-Gm-Message-State: APzg51Cs+eoG5yIq0rTnCtdWs6BtdVZAR+CJVBZFs7aMBC+Fkqlsge8V
        xEPlDlj1sMdK0rsxnwhgkeNR2hdo
X-Google-Smtp-Source: ANB0VdaW171Gywo9Nc47ehGIbuLHlZpX2rJH2RPTIrxdOqHYY4AtQZENv8h4RQVi3vfZQHxJnHpCgQ==
X-Received: by 2002:a62:9683:: with SMTP id s3-v6mr31882288pfk.191.1537290309923;
        Tue, 18 Sep 2018 10:05:09 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x82-v6sm34575634pfe.129.2018.09.18.10.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 10:05:08 -0700 (PDT)
Date:   Tue, 18 Sep 2018 10:05:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Input: uinput - allow for max == min during
 input_absinfo validation
Message-ID: <20180918170507.GD177805@dtor-ws>
References: <20180918052256.GA23446@jelly>
 <19cbcf47-4ab4-7dd0-392a-9a47b7264999@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19cbcf47-4ab4-7dd0-392a-9a47b7264999@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 01:13:47PM +0200, Martin Kepplinger wrote:
> On 9/18/18 7:22 AM, Peter Hutterer wrote:
> > These values are inclusive, so a range of 1 requires min == max.
> > 
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> 
> true, nice catch.
> 
> Reviewed-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

Applied, thank you.

-- 
Dmitry
