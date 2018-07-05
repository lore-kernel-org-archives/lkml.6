Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65810C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1867324137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaxJ8c7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1867324137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754783AbeGENKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:10:43 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37628 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754615AbeGENKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:10:39 -0400
Received: by mail-lf0-f66.google.com with SMTP id j8-v6so6920393lfb.4;
        Thu, 05 Jul 2018 06:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t3n3zLJ0qcivaAG2MFqO3iTfyqr/lHuG1KQ61j6Eg1g=;
        b=RaxJ8c7YZ42C6FVhv1BPdJqOzw1OdULKr2yNaeD4FD+h+sT3+EvPZDIzHRGWEY4BUu
         5tNy7inbS8rwzp+a//O5WHBw4gdwXA8iQjgaoHEcKOQ8nEXzOWvdzP52rXdXuLV3UUkU
         bOOBbrxceBChYEQL4Q7/zIUPz2LyS8otUTnqMELahKUyNK/JQDxMKtzGdbk3PIeGibQn
         AydgMuY2elNXgSfJxaLjJtwXT1M1+qx7zxiGL6UbCAUxVRVYWGzRZqwtYd6kpeGg1j9K
         4U9oTTcg48Cqpbei4VMWjzO6pCrD1VYII8AemLuzKoQXZxAZu1QBFWl7bZsWd+4QSxBG
         gYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=t3n3zLJ0qcivaAG2MFqO3iTfyqr/lHuG1KQ61j6Eg1g=;
        b=LS3zpqEkws/7bA/HvpXw4YNAkBlSpVo4T5m1qZwn5ulukgOXX95JFgIe4BIJB2NWT7
         9D6BAKs2+vy92tlk59ImqbrsjQZLrO7jJ7ZLjJRBn0kBjW2HA2fuHHdfCTjaY5BPvmKq
         jpVX+J24RmcUtCagOtOH5saVb7vf2yrXegbxJFy1o/lEfzv85aUtPwzYMgnQq8PYHvUD
         39N5uxCLUBXPtm1+SqCtfFekwGoG8EHgzUbCDlvtmkJnOKSDQOrz7a/tR7hauTztxl8m
         r7WzgppdCDdCFWA5R5u8pxGCp+JDbzsZASYewhQ4+/+GQJwgQUcZ6iJXTUrqC0L0A9IC
         0UrA==
X-Gm-Message-State: APt69E3Db40jQLxtLt6fjtuG3BUdKphQ59rPbDbKgx1lJx2KP93Ruf74
        Au7i05U63rVOy6okQvtRITU=
X-Google-Smtp-Source: AAOMgpcI3joLhbmPjZAWUr/pMM/4i+bxVAAV2pKdwawZG/lYBtrNJfR7ApzdKDhFnjLtZGxejlDqHA==
X-Received: by 2002:a19:d046:: with SMTP id h67-v6mr4511554lfg.52.1530796237689;
        Thu, 05 Jul 2018 06:10:37 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id m72-v6sm1426739lfm.49.2018.07.05.06.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:10:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fb41j-0001OC-DB; Thu, 05 Jul 2018 15:10:27 +0200
Date:   Thu, 5 Jul 2018 15:10:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     Johan Hovold <johan@kernel.org>, Karoly Pados <pados@pados.hu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for CP2102N
Message-ID: <20180705131027.GB9802@localhost>
References: <20180620082507.GO32411@localhost>
 <20180617182503.23080-1-pados@pados.hu>
 <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
 <20180620105231.GQ32411@localhost>
 <87d0w5wm33.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0w5wm33.fsf@miraculix.mork.no>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 08:04:32PM +0200, Bjørn Mork wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> >> Not quite. It is not from a forum post, but from a SiLabs Knowledge
> >> Base article
> >> (https://www.silabs.com/community/interface/knowledge-base.entry.html/2017/06/12/fletcher_checksumfo-TeDF)
> >
> > Yeah, that's the one I was referring to.
> >
> >> That article states explicitly that the code was taken from Wikipedia,
> >> so it is CC-SA, which is to the best of my knowledge 1) compatible
> >> with GPL, and 2) does not require attribution if the original material
> >> is missing it, and it does. So AFAICT we are clear on the licensing
> >> front.
> >
> > First of all I can't seem to find that code snippet on the wiki page it
> > does refer to, so I'm still not convinced.
> 
> It was there in older versions of the article.  See for example:
> https://en.wikipedia.org/w/index.php?title=Fletcher%27s_checksum&oldid=730327006

Ah, thanks for digging that out.

> > Second, this should have been high-lighted in your submission somehow.
> 
> Definitely. All code has an original author who deserves credit.  And if
> you cannot find the original author, then there is always a risk than
> someone along the line stole the code...  Maybe long before it ended up
> in Wikipedia.  But that doesn't matter.
> 
> Doesn't seem worth the risk for a simple checksum algorithm which
> probably has lots of GPL implementations.

Right.

Johan
