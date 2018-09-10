Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75077C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2061820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtiX8ezV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2061820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeIJOiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:38:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43073 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:38:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id m84-v6so17286992lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wa8dwKIZZXT39GhJu2oZlG5y/j2pwoOUpKuZN+ukFXQ=;
        b=CtiX8ezVk4BVK142DIScWfCQt18B5on3P6c3mrpgqH30spgQP4L4g28FnwJzd6newi
         f9PIbEsnGjpU5FNN2iW/bfvZ8Kub5h0bF+WcrrMrQU17/fxENg+y/e6/IwrNZ8YjbTcH
         gCS4fxl3WrMcSbePKqFIu+UVhgJyGlLlPqs9SoqlGpkltHUO8F3BIceXigjB3B5bMcUz
         LB3g6geFyPCNT/q7V77Xp/G1TwuD6jSr7xYo6Sv/UnOTz/6Lv65WWc4T70wEI2DGuiZh
         uTQ/rm4gyrMKj4ycC9Jx+Ux2Q1cCLHZ3sKnc6moa/Y1xmuJyTNxiZb8ihT/3TdRJpkgW
         avHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wa8dwKIZZXT39GhJu2oZlG5y/j2pwoOUpKuZN+ukFXQ=;
        b=gIW7jdwb8SMHy+OJz+PNtkb38KaxJXEinXApNR8k2HEUVUdnqf0p6qPJZ8OEFHDOuT
         S4fWYRbVGKwBvIfWmc6kWOOwNjzW2B7dOvPGsexbhKBsewlU7BVQBFoVpSgyj4AjwQYk
         08Tfs/fH/pRtDFGdoJFUYhlMwSXp6dwIwhjBEZBI+n65b2So8/4CB6ROfML1GPb1XJSk
         yBYunXdlihcl5V8NWNHgEOONBLISevohDlTK92vztTsB+DfFiv6tSzGHvY+HU8HnK8JM
         u0sKqbYDSyabTp0ne/e75s/yD9mKUy4h2h/2O4uZ1mXVAuUKqOe98419Ri0nZyhqhBj+
         +Pzg==
X-Gm-Message-State: APzg51DYtD+KA2+uZcrSMRE2r5RrJjjsLbnT3kheLkYxkn6n0r5eaKuk
        eX3KSHNpOTY+rS5hOM5SbxtuIEUinPE=
X-Google-Smtp-Source: ANB0VdbSfTMZrvphSUKxVMdjBxpeQ3Dq/+q/QuZzwTxMXcEg0DHsR1drUb9FgUx8SqKrrmAXTFl0oA==
X-Received: by 2002:a2e:4242:: with SMTP id p63-v6mr11696507lja.83.1536572705412;
        Mon, 10 Sep 2018 02:45:05 -0700 (PDT)
Received: from ?IPv6:2001:14bb:43:46b3:d135:7d7c:caf7:1c82? (dkqdnjzl1s10p1948tk-4.rev.dnainternet.fi. [2001:14bb:43:46b3:d135:7d7c:caf7:1c82])
        by smtp.gmail.com with ESMTPSA id q85-v6sm2635503lfg.20.2018.09.10.02.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 02:45:04 -0700 (PDT)
Subject: Re: [PATCH] mips: bug: add unlikely() to BUG_ON()
To:     Paul Burton <paul.burton@mips.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
References: <20180907180302.656-1-igor.stoppa@huawei.com>
 <20180907220208.nqucxycxsxmyxt4m@pburton-laptop>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <d702acea-0aac-abc3-c48e-21f0e44d5870@gmail.com>
Date:   Mon, 10 Sep 2018 12:45:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907220208.nqucxycxsxmyxt4m@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 08/09/18 01:02, Paul Burton wrote:

> I'm not sure this will actually do anything.
> 
> __BUG_ON() doesn't use the value of its condition argument for regular
> control flow unless it's compile-time constant anyway, in which case
> unlikely() should be redundant because the compiler knows the value
> already.
> 
> If the condition isn't compile-time constant then we just emit a tne
> (trap-if-not-equal) instruction using inline asm. That will generate an
> exception if the value is non-zero at runtime. I don't see how adding
> unlikely() is going to help the compiler do anything differently with
> that.

Thank you for the explanation. Please discard this patch.

--
igor
