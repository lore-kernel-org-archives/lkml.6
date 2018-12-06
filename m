Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F0FC67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A379E20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="p1lNo44i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A379E20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeLFJnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:43:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32794 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeLFJnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:43:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so232580eds.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7cGrXL3/HboMoDAghURaQXrc5M31gPRjVll6TID/Nlk=;
        b=p1lNo44ib+tgfWEYWLdDXyhjR6IBy2FSkkAPlH66z8igVkPuwF39U3ODMiyF3JI+hF
         DBPAdh/C77gpA6qHsPB0RwGUdp3UQJeL3qWatIU99tzVppUsYdOMC/NZsQTcICc2QPX8
         X7x/1uD9F2dLdwuth/QXoiVAurfetFcXz5MMTlaQMo5QqnkQDSYQQjbIY9RQOdbDCsjy
         Ds34+mRupiYdxO8+HZe2z7DQkbjMAr3mhLXV3BOb0UxmevUHim9tyj1EOqiMn2AEur6P
         XR5f1W/zZBLVwDEruot9KsTDt9hTLns0kSEoerfXY44UQGBcXPHxZr8R6UXeokI7uwCV
         fPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cGrXL3/HboMoDAghURaQXrc5M31gPRjVll6TID/Nlk=;
        b=CU1H4vNiOmyDsbAjZjb57lkr8VEFrds8zEdYJQ/v9dS4LNPCRXAZS96gWJ1q6Lb8w9
         SgwzaJ4f86QTOb5gqE4ccPfqvgBqnbbld8/FjFGCjjmKlxEi5lQ3RvTDMe8drRh0zPBw
         PC1uv8/1gmRBetdx4DOWWEhyJ0Boix72w5h6AlBhbudxAZF//H9fH7IxD2E+RsfBcB7q
         y5gKeKu1Qz/n+ibMHYJ9xTDG3qKSiILhZC3wXTl8xwqfWTuk7woZPpGKpxIJYC88qcyL
         MoXJHvsxLmro8GER0tYUhQ6zN4m/9XbQCaGi5cjK1bTQ5D0LGANPxL0MyCs6kipGfS/j
         AB8g==
X-Gm-Message-State: AA+aEWa/07lXhlJkPAQKfH33UcVgd7Jw6zpfiiMFe+LegEx6od3rvh1N
        3W0znLdQtjfCWFPJguLJjkjlUrZjryo=
X-Google-Smtp-Source: AFSGD/WAczMABk/T+f1Fc3v0qr4oUldeiinZZZ8MxiHJNBuQX4jrmG232gVLwl+6Wf4uH2KjvMD08g==
X-Received: by 2002:a50:b205:: with SMTP id o5mr23507303edd.245.1544089427800;
        Thu, 06 Dec 2018 01:43:47 -0800 (PST)
Received: from [192.168.192.38] ([80.111.179.123])
        by smtp.gmail.com with ESMTPSA id u33sm45773edm.88.2018.12.06.01.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 01:43:47 -0800 (PST)
Subject: Re: [PATCH 2/2] staging: greybus: Added space between string
 concatenated
To:     Sicilia Cristian <sicilia.cristian@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <cover.1543956271.git.sicilia.cristian@gmail.com>
 <5b215b50d4da9a7730450a83fb5e3a167b65e03a.1543956271.git.sicilia.cristian@gmail.com>
 <42632636-9b08-bd75-b789-88ef82f52c2c@nexus-software.ie>
 <20181205210034.GA24054@peano>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <e7902148-4f80-2d9c-7f51-d6bd21bf9eff@nexus-software.ie>
Date:   Thu, 6 Dec 2018 09:43:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181205210034.GA24054@peano>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2018 21:00, Sicilia Cristian wrote:
> It doesn't change the result string

So why do it then ?
