Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6EEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B80206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="s8ZrYbWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbeLNQau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:30:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36052 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeLNQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:30:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so5421578ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohpVLLxzMLR6t3TyeZ9Uer7Ih+QC8diFc7ZJxZbDNVk=;
        b=s8ZrYbWq9CUWiRO7rAZ6CvpbDWEYXqR7nJ2ZoJBvmRl4b1pXWYTviMebAJyzN1Lw+E
         ZF6YXt5joT7NQmgGYzUY1I65B/6QXW0hAJUII2WhQ6bGcRgFWv7bM/eNhF7+8HFVnXQ5
         7K222mQ/OtE1BA+MEPKWVWO5KXqaHLOmtz3YCRa9KfgJQVnurmn7wNAjNB9EZsRgyrFI
         UoCGvPOnuzekBa+rJzZacNFM+B/AB61Ny/Ceh0ObNIxYBn/w4l0cTtNfiYQlmH5LLaJT
         AWKlZs/XoHEIsu8ZY5F4yocDwjDvJRNm68HvPADIE3O/Er6BzN5iJIiNJoBzYF3p5QdS
         9OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ohpVLLxzMLR6t3TyeZ9Uer7Ih+QC8diFc7ZJxZbDNVk=;
        b=qwmGHBz+Ka0Z8ytFZRQF3lLbrYphQO+U4J6GDTKMNoLU9Wdj/aio1dPwjKz/fYWOV7
         70qoYplZcN6EOp5OqjQMVbwOWCf34ghvxkdHMkV4LM2thF3s/Y7DIvoEQ33A5HjZ0Yl6
         4G+N2XD6OBr+q0DTXKUFcO9egCXBDtRPgpZ31E5mje0wFGmgh7Pip+MeTnsGJ7UcYnAM
         VYC+rgw1d7Uvp67mNVMx+e7zRTSXlsg3vRR4RvQIW6wZCvaZKnfXFdzQqQOPu0yaPZqo
         iDRLPgMGzn1SkDFZtK23pptYUroAlR/qdFmFjPrCIO9rcNH2dsEvj58rEpyfGS9X3+ZA
         vmcA==
X-Gm-Message-State: AA+aEWZgOvsUDWSdQYfVgKrUWZ/ua8Lg4BeBlKORJKw99YgQswC1XWTO
        084j3Gkp4497S52v/VjV7cvqa6VcOfo=
X-Google-Smtp-Source: AFSGD/VRBp2bLPzcYexkVhnnKLJ380RRGYhQjYNk4aDd7NLbDQvVB7gw45g4lYE3hCDtcz1VhtK6GA==
X-Received: by 2002:a2e:750a:: with SMTP id q10-v6mr2473793ljc.39.1544805047275;
        Fri, 14 Dec 2018 08:30:47 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.123])
        by smtp.gmail.com with ESMTPSA id m63-v6sm1043624lje.81.2018.12.14.08.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 08:30:46 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774c0 SoC
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>
References: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <0783aaaa-b185-03bc-b027-d0ef159acda1@cogentembedded.com>
Date:   Fri, 14 Dec 2018 19:30:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544732314-6041-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/2018 11:18 PM, Fabrizio Castro wrote:

> Document RZ/G2E (R8A774C0) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
