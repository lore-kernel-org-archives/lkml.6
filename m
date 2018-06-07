Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id q4/rCwltGVunTwAAmS7hNA
	; Thu, 07 Jun 2018 17:37:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 66CF36074D; Thu,  7 Jun 2018 17:37:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DDEFA6063F;
	Thu,  7 Jun 2018 17:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDEFA6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934629AbeFGRhL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:37:11 -0400
Received: from ch3vs02.rockwellcollins.com ([205.175.226.29]:25646 "EHLO
        ch3vs02.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933021AbeFGRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:37:09 -0400
X-RC-All-From: , 205.175.226.20, No hostname, brandon.maier@rockwellcollins.com,
 Brandon Maier <brandon.maier@rockwellcollins.com>, ,
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.226.20
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: ch3ip02.rockwellcollins.com
X-RC-IP-MID: 94972797
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
Received: from unknown (HELO mail-ot0-f197.google.com) ([205.175.226.20])
  by ch3vs02.rockwellcollins.com with ESMTP/TLS/AES128-GCM-SHA256; 07 Jun 2018 12:37:08 -0500
Received: by mail-ot0-f197.google.com with SMTP id h38-v6so6813845otb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ByzXH2jOStEnNw4uqvW6p2i4t/oFLSIqjI1/QG0PLY4=;
        b=aR23xplSDkVzt75GX1I3hTmtsyG/wpH5SR7qAf+uQdtpCvJ57XZ5aRPWqu8NMq0l3r
         w5EOVJY8NsqPyG6NblYi9iMh8J//2sGuFn0fVHqyeuanfYOMUVtzQYydRC7i71O9hf0S
         60Ya0Apnf1G6mOU8TCq6FR0YKNFAzvx4NbQE4pdaBwcyfODlG0jWMwqgL795SB0BhjvQ
         J8gWHMY3G9UeEQpelS9DSYUG4nYrJn+h0rC7Z9cuC56y3t2pMWyC4gVhIblX8pxFS36E
         iWnNl+zIgdnSpDFWHfJgYWD/Q6gUxIzDVL3DFMWv4f7VSZceP56L/8kHWIzbW6ZWql94
         Nimw==
X-Gm-Message-State: APt69E04yd7siaLn/elf4NfzaJDnLDN96lQYme0MW6ydqzyQ0/gLWG0D
        D2a8X0GVhgstosy/ynFcT7yGQQV3QwfA2Bl7Ct6sqlz2fIBaEZIdwZpsYGZ3b2m2m0AHgzRndgm
        pYOlTSQkRjJjSA3HWfz5pi0CqzRoCIxPE43KlyhXXECWIlBxCtIgl0NtyAzI=
X-Received: by 2002:a9d:331b:: with SMTP id f27-v6mr1718797otc.373.1528393028554;
        Thu, 07 Jun 2018 10:37:08 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKI2LyrutrEMRzfX6Pppn3OpNkIKapzN2fqRDor8OOHIP46xG1RdNwXMkj0V5wKC5dUpgmocorrG1rBnmU3gpZU=
X-Received: by 2002:a9d:331b:: with SMTP id f27-v6mr1718782otc.373.1528393028310;
 Thu, 07 Jun 2018 10:37:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:5fc9:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:37:07 -0700 (PDT)
In-Reply-To: <20180607164920.GC25513@lunn.ch>
References: <20180607155348.149665-1-brandon.maier@rockwellcollins.com>
 <20180607155348.149665-2-brandon.maier@rockwellcollins.com> <20180607164920.GC25513@lunn.ch>
From: Brandon Maier <brandon.maier@rockwellcollins.com>
Date: Thu, 7 Jun 2018 12:37:07 -0500
Message-ID: <CA+fik50j2JFJdNcN0AsnEea1R7Xg4Qpxu9zrihii2NBX_u9Zng@mail.gmail.com>
Subject: Re: [PATCH 2/3] net: phy: xgmiitorgmii: Use correct mdio bus
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, f.fainelli@gmail.com, davem@davemloft.net,
        michal.simek@xilinx.com,
        Clayton Shotwell <clayton.shotwell@rockwellcollins.com>,
        Kristopher Cory <kristopher.cory@rockwellcollins.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 11:49 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> I think the assumption was they are both on the same bus.
> However, they don't need to be.

That was my assumption as well. We ran into a scenario where they were
on separate buses.

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Thanks
