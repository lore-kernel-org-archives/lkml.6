Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885F9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 05:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4A72084F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 05:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2PebUuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfBWFxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 00:53:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38446 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBWFxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 00:53:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so2048886plb.5;
        Fri, 22 Feb 2019 21:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cas0vZVlcekzm7SWK5wnbnRhwsXZ8d82jNLOmCatWTc=;
        b=H2PebUuSOfF1uX1f15kR32c0ijTr4lysJRXu8egPwZFn7N82UzfZkyeZ7U/BpLISmw
         shTV7g1pMMMzCiugvbGxOoGXjT8jfxTpSDRGUQQ0cSyzAl3OAYU31Mwe4Mnn4WPEDLUS
         YOnx+Ftm2+nEt6GVEShIx/40jUfAmRlvFWjgb7wiFqNIXq03uFbO/A9c+BxKAkAtOT0a
         Xtn5Ew5IHD5Z8uUd/jxIuz2ZNkWiv+81HQlATAHoqWCyp2Olf7h+VHqkVRuu08vrR3AE
         fpH3P6ZQSVOV2hHXGBbgdoXGwEZhm+Hxi0IHGVdeip+iF2BwViZXdpKq/tA2xIxCiyc3
         5emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cas0vZVlcekzm7SWK5wnbnRhwsXZ8d82jNLOmCatWTc=;
        b=dyXUErkJvpfO1LNxqi7PyKvzCJclFQ0fktMFJkYHz5/83PABdcw1ucYMta6O087pfv
         7kS9kCXyDHryjdLxAOoVoypsZt054kzYNuZw3DmgL+4+k28HQ3iM5es0qBHJuuyItPP7
         tCx95DFf0zeB6A8/AlFTxupBmg/Koy7VfD6LaPEPfRgH0Rwb8OUps1lPH9rVeTn2pJRS
         IaQRaWHK0bBPZrMIQ6itkn0A85QyisSCwmwnJOmzrTDTsDVGIzfPZ6cKJFqU3avx3ZHB
         Aagntp0+O1+33rl+fdyULd6FSzuefPG01xVX9DiqS6RG8p+V8U2SlFKJb5HYK2Peyg2E
         0gAQ==
X-Gm-Message-State: AHQUAuatI7b4UlMzvz0sGEKbCZ4vqYtaoo8tgEhqfZI2Oh5Qs/9LdG89
        5+iMWwvbZPO+/PenlUeR9BctTYWuAyk=
X-Google-Smtp-Source: AHgI3Ia9IliQXVUEEEMQ02m13EVXFvutu95cnqU//LmyqWRa8akuHkW+VDCbYNITNZlYMpHF1A8YEQ==
X-Received: by 2002:a17:902:e60e:: with SMTP id cm14mr7934359plb.192.1550901217473;
        Fri, 22 Feb 2019 21:53:37 -0800 (PST)
Received: from ?IPv6:2405:204:8187:3683:3c36:27d7:3aac:e0e7? ([2405:204:8187:3683:3c36:27d7:3aac:e0e7])
        by smtp.gmail.com with ESMTPSA id g67sm8876023pfg.13.2019.02.22.21.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 21:53:36 -0800 (PST)
Subject: Re: [PATCH net-next] net: dsa: add missing of_node_put
To:     Andrew Lunn <andrew@lunn.ch>, wen.yang99@zte.com.cn
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190222111818.3888-1-himadri18.07@gmail.com>
 <20190222143649.GN5653@lunn.ch>
From:   Himadri Pandya <himadri18.07@gmail.com>
Message-ID: <425cc5b0-6237-8cc3-7e13-97a3dd97cdb2@gmail.com>
Date:   Sat, 23 Feb 2019 11:23:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222143649.GN5653@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/02/19 8:06 PM, Andrew Lunn wrote:
> On Fri, Feb 22, 2019 at 04:48:18PM +0530, Himadri Pandya wrote:
>> Decrement the reference count on port while returning out of the
>> loop. Issue identified by Coccinelle.
> You and Wen Yang are both fixing the same issue. Maybe you can
> coordinate?

Sure.

- Himadri


>
> 	Andrew


