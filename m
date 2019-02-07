Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713332086C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILYdGyWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBGSV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:21:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35510 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGSV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:21:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so918610wmt.0;
        Thu, 07 Feb 2019 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/4eJDqA94YOxwyYuAVdf957HOJ8fq4Zyj/OTXBZpY6I=;
        b=ILYdGyWPNg7Jmf1YFNeQGePEKg+FrwekjejZqKtS9yU7tOMdyQ8ufIkKMrFgybpdbM
         f3jRIxtavTtAFtYIWzX2ccgII23Um94o291GNE6tlxUwXT4H0B6CEspm+7IJMTT2zqo0
         YKl59MrarKO9vRmdFQ7y76D1xcIRpLVn48fZlkN1jDx2fzoZWjbogdhE/euz7uXi0ZpE
         MzMKaqJtOfEhDQZC8JfQ01u+5Hm9eDwQXvmnfTpZ3rPmnS2GpRhJ01PBgEd1Y8uZo2Pg
         n2Mxd2EOPQBQwiPTQ6os6G0YYwktIoJXGZe6ltZ7Zbx7kblJz4/Ca2F9KiqhdbcEeJBz
         6r4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/4eJDqA94YOxwyYuAVdf957HOJ8fq4Zyj/OTXBZpY6I=;
        b=hX62OQ0KNpw09p3GPku9qi+mKlES9CMUbhiYzE5a6XXgwRVmMDaZYyggJE87A9JDe1
         PsPbXwh8S6uqR3gJ5motKBLJNeznv8O/rbPzmOPR9X7s2Ct0xhPcd2KbktMrgCktKBfp
         m3Bw+zqeblnpKfX3Tf2dt7bMPvmU5aGW72a4nUo+cbFRprfY3hWKwaE0Y6KytpxHLAkL
         DTD+0ejb53AZ0P0myBltcqKFWF0Ep/1Hc2yrwaDFG3nGQAzKAf9zi6EZ2DfKQlUQONqH
         62yGRPmozRsoyWmUBf8w1BoMVZ9Vs/4BoUyDq5vc0s3RMWI9TuL5yRU66fYvG1axnpw4
         VSuQ==
X-Gm-Message-State: AHQUAuZ3vZlKyrCiY/L+Hn5cqQx+HRSi7+smcx/Ss46sDdkEaDeekNe5
        lw0UVL8fHmSExcF0y5vSSGU=
X-Google-Smtp-Source: AHgI3Ib61XOgR122rX9iEEeLLHS77YKwedYL6f5PQA0Rjajzw0x+7aByR5DGXYCSOOiI0ne6eMcbjw==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr8704335wmd.67.1549563685141;
        Thu, 07 Feb 2019 10:21:25 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:a906:e81:1a0f:97bd? (p200300EA8BF1E200A9060E811A0F97BD.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:a906:e81:1a0f:97bd])
        by smtp.googlemail.com with ESMTPSA id b14sm33043657wrx.36.2019.02.07.10.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 10:21:24 -0800 (PST)
Subject: Re: [PATCH net-next v2 01/10] net: phy: Update PHY linkmodes after
 config_init
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-2-maxime.chevallier@bootlin.com>
 <20190207134807.GD23970@lunn.ch> <20190207145517.08bb8975@bootlin.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <349385df-3de6-63e0-f1bb-6085c50b9840@gmail.com>
Date:   Thu, 7 Feb 2019 19:21:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207145517.08bb8975@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2019 14:55, Maxime Chevallier wrote:
> Hello Andrew,
> 
> On Thu, 7 Feb 2019 14:48:07 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
>> On Thu, Feb 07, 2019 at 10:49:30AM +0100, Maxime Chevallier wrote:
>>> We want to be able to update a PHY's supported list in the config_init
>>> callback, so move the Pause parameters settings from phydrv->features
>>> after calling config_init to make sure these  parameters aren't
>>> overwritten.  
>>
>> Hi Maxime
>>
>> I have a patch which makes some core changes to support PHY doing
>> runtime feature detection. I would prefer to use them, than this.
>>
>> Either I or Heiner will post them soon.
> 
> Sure, no problem, thanks for doing this. I'll be happy to review and
> test that on my side.
> 
The second version of the patch set comes in time because I was just
about to submit parts of it on Maxime's behalf. We may have some
dependencies between adding the get_features callback in phy_driver
and this patch set. Maybe the patch set needs to be splitted.
I think tomorrow or the day after I can have a closer look at this.

> As I said, I lack the big picture view on that part so my approach was
> pretty naive, I'm glad you can take care of this :)
> 
Don't be so self-effacing, it's good work :)

> Thanks,
> 
> Maxime
> 
Heiner
