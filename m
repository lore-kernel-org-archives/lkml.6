Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18A6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2B42085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4OqGaWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2B42085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeJKHA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:00:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45889 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKHA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:00:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id u12-v6so3381178pfn.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8WXacQOo9G3uk+9/R1PfEhsax8xzhZOR9SEqoRKPi80=;
        b=a4OqGaWw6SWo0F9e7Lvc4tH9i3e+emFy9rGousFPX94SHkirrC38sUcdbS0SN4Bq/e
         gK19ZdtdKveD3BUMESrzPQUDwQkwVRLSumscHx/NIO2oNSvpNg6ytSC8e7gGo75Vy2nq
         wpzBWPFFSPNomzFEy7nh6lksMMky3EI6odE+/kTQ+QvHzIDlw3w3uYR4LBNlKiwSQ1Ec
         p2GOCM0f6KjVIUEHzrTX60Z+HOoaPflMXYGoiObNBbwmORXIH50M0gY9WGDiM4dXXRhq
         pVQuivaK8GRsec0hK/lH3/RYDEksxCNVS4aaoxhjPPPL1nlfgA/FqCwZU7ChoNFEbxrA
         jquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8WXacQOo9G3uk+9/R1PfEhsax8xzhZOR9SEqoRKPi80=;
        b=kUsvOC8ghHO7bt+mV038a8zaJrUYCzZkceMKnsuhycrvrfYnRYtkCgeQuz/Fx7d/yQ
         cWjeIVcqm51FeRKbzRDs3LeJMAUfNsB5Db7WeRQcgw5oqLY08JIAnm4odm2URLq6gQXw
         jjAVTG05VX2BrF6j1zMRlCmsTs+p6Vy+3hGqM6SkajfQ7uJjauPz8ULp98bljVl6Gpqm
         JWo9IqhCDTLRBaQxhGCyh0fC0Jyn1+yjNsCwrVXmkvUOgLLmIm+i+AYqtyKsC6kLfrL1
         6hs8A8uuayclwnouCmafPYA2BP59CKB/6lX+1p86hbM8Wy26zZC/TLdbl+O+RY6QhHUw
         CWHg==
X-Gm-Message-State: ABuFfohgTZ+dXI2R3D0CB36q8HDTmk2JvVFaSu6wOkeD0StcE8xDVuGL
        nXEBy4xe/l8ZR+N+nY//yH0=
X-Google-Smtp-Source: ACcGV63P27g6f9qYwMrM7v3yWXyJ4qFJgMR9ZhiWHZf43J7N4lAoUdlh/ey+QBJpuZ7NmH3hO/U0RQ==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr37068018pfb.209.1539214561702;
        Wed, 10 Oct 2018 16:36:01 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d7-v6sm63474617pfm.23.2018.10.10.16.36.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 16:36:01 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
To:     esr@thyrsus.com, Josh Triplett <josh@joshtriplett.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org
References: <20181007085102.17795-1-geert@linux-m68k.org>
 <f4f7bf39-af34-4375-d6a2-b1f23cad519e@gmail.com>
 <20181010221611.GA5711@localhost> <20181010223319.GA31256@thyrsus.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <22aae042-5ef3-20df-6960-fc8ae3cd5506@gmail.com>
Date:   Wed, 10 Oct 2018 16:35:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010223319.GA31256@thyrsus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 15:33, Eric S. Raymond wrote:
> Josh Triplett <josh@joshtriplett.org>:
>>> The words removed by this patch are a political statement.
>>
>> Choosing not to say those words is a political statement.
> 
> The situation is not symmetrical.  Choosing the protected classes
> in the CoC is a *change* in its implied politics. 
> 
> It's a change that is, obviously from LKML traffic, very contentious.
> If this were a tpurely technical matter, it would be described as
> not backwards-compatible.
> 
> It's a change that, I submit, should not have been made without a clear
> consensus *in favor* of the change.
> 
> Our culture has a process for this. It's called RFCs. If we want to
> designate protected classes to be called out in conductt guidelines,
> an RFC should be floated first and the change should be made only
> if rough consensus has been achieved.
> 

Thank you for stating that clearly and concisely Eric.

I will bow out of further discussion on this specific point as I
have already seen this concept discussed on many threads already
in recent weeks.

-Frank
