Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342E12075C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="hKR3inAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfBTUHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:07:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41650 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfBTUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:07:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so15314971wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 12:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rea6NEOgqzng4Th0V+mrQZod7uWvikO4AkjPqlidHIQ=;
        b=hKR3inAUx/RaQl5XiHJBCQDytc9OL28Dykyn16Q8T3Rrv64sY2hzCiXrSPttw86kSU
         /nOW/b5aOXzPJaODKcEGOD532MY0ptV1odcRkz5YAqvlikFDucnaHaNnk/6SbqCfOJGQ
         PWq54rGT3B4LwsgN3UbBHRMD4nQJDaQNm1NpAzlM1awg45wTbaNK5z1uswXh4ZVNjlRN
         GP4hOhdPFslBf3Q5UDx6a4M87ID9ZD7d+W6xP81jyXJVu/gA3MUuRn1VFjt2YA1oEku4
         1VBICUchF6uMP/S64zsby7nfwh0yDMubnGj0xRDPr111DlO7CyuZmwwlrIs8U0zrFrV8
         fMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rea6NEOgqzng4Th0V+mrQZod7uWvikO4AkjPqlidHIQ=;
        b=GUFsoJQgrGFuRZg1ovbbDRT9VYlDHvIj7bOY+SYAgAfC23WfS4HHkOy8ldcKFajb82
         S4cC4+SMTAD6hb8/+m30YJrHz6Ix0qQWQITlIIpbM+9zIuA9Aq52eZfzYJu6+K3mL6Aw
         /WU8rIYrryt+tJq1CnRYgtffL0KZMYdD9Z8TT54n9ZfSkVGdJN3eN2Q6jfG/LfxqKiK/
         5E3wKjv2E50XCXZSDY9km+f0bo+Ut17FFLKHEqq3X7z38c5XD5JJR30aQ++BVMGTF2xC
         zuM97Y5SJIFICZVL7L+dPAaVVUd6fB5ytwwOrKu3EhfpRrdjMsMJlaRo8Nnkb016tSy/
         qX0w==
X-Gm-Message-State: AHQUAuYGT/CVX4l2F0dQ5SXjGnemhEtbS3XB5O3uOupoGXyu3zn4RghH
        7U/c8LJ9CrI3dVkrNpXbJKZH9g==
X-Google-Smtp-Source: AHgI3IYPxS8ZcUwAoFbjhBFq4MZO8A313N9Rrq7KfgKy11SFmarOvPJECIqYq8oOTCUs2p7VDiKP8A==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr22634490wrv.280.1550693264834;
        Wed, 20 Feb 2019 12:07:44 -0800 (PST)
Received: from localhost (ip-213-220-234-21.net.upcbroadband.cz. [213.220.234.21])
        by smtp.gmail.com with ESMTPSA id t9sm15751706wrx.73.2019.02.20.12.07.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 12:07:44 -0800 (PST)
Date:   Wed, 20 Feb 2019 20:58:11 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     David Miller <davem@davemloft.net>
Cc:     vkoul@kernel.org, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
Message-ID: <20190220195811.GO3080@nanopsycho>
References: <20190220044055.GD21884@vkoul-mobl>
 <20190219.224813.723564128666927693.davem@davemloft.net>
 <20190220083611.GJ3080@nanopsycho>
 <20190220.110201.2245447687492293995.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220.110201.2245447687492293995.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 20, 2019 at 08:02:01PM CET, davem@davemloft.net wrote:
>From: Jiri Pirko <jiri@resnulli.us>
>Date: Wed, 20 Feb 2019 09:36:11 +0100
>
>> Would be good to have some robot checking "Fixes" sanity...
>
>I want to add a script to my trees that locally do it for me but the

When it is in tree, it's already late. The robot has to check
emails/patchwork.


>backlog for patch review for me is so huge that I never get to "fun"
>tasks like that....
>
>This has been discussed before too.
