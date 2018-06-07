Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id snSwODtsGVsbSQAAmS7hNA
	; Thu, 07 Jun 2018 17:35:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 66EC5608BA; Thu,  7 Jun 2018 17:35:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C3593606FA;
	Thu,  7 Jun 2018 17:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3593606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=rockwellcollins.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934438AbeFGRfG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:35:06 -0400
Received: from ch3vs03.rockwellcollins.com ([205.175.226.47]:48978 "EHLO
        ch3vs03.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934131AbeFGRe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:34:56 -0400
X-RC-All-From: , 205.175.226.20, No hostname, brandon.maier@rockwellcollins.com,
 Brandon Maier <brandon.maier@rockwellcollins.com>, ,
X-RC-Attachments: , ,
X-RC-RemoteIP: 205.175.226.20
X-RC-RemoteHost: No hostname
X-RC-IP-Hostname: ch3ip03.rockwellcollins.com
X-RC-IP-MID: 6434595
X-RC-IP-Group: GOOGLE_RELAYED
X-RC-IP-Policy: $GOOGLE_RELAYED
X-RC-IP-SBRS: None
Received: from unknown (HELO mail-ot0-f198.google.com) ([205.175.226.20])
  by ch3vs03.rockwellcollins.com with ESMTP/TLS/AES128-GCM-SHA256; 07 Jun 2018 12:34:55 -0500
Received: by mail-ot0-f198.google.com with SMTP id l95-v6so6639271otl.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mo60SZDGatryRdChTYiM4u8iWqGHKK0GiQxeZtr0q8c=;
        b=TCo0GFuVgAD0py9vH8lkakoeso6wBL21/LHWkn8i/gbQKxUu4JQTYX2kz614y+hS+d
         oXCJQqN0E2glOoke5TIyBeaXNwa8DZPYBgbsoRyTaVI9tE9uIYxGJwJUz1QYwjsQ8m+Z
         NqEGf4MyjreOvk8cZRijp+h9ecdznMGfQUcLSDk6toIuokiRzOVziM/kbeAb6ZDVOBJt
         jnfaiAMr5twUQp993sEtFoUw1zsG8rcc6Kv3MmvvMfmG7scLsboG6EWup/Yok28H5jD3
         Sb47wlPFxFqDnOTpBQC9voCf0HcsDA37uWdTJkWkLjDHUe6FW4KLyddpyDQDpT+1iz3d
         aoIQ==
X-Gm-Message-State: APt69E0eHFTcfmFSfaxg/UiLhWRLpYIYLL5RFCNO9IXobXYAeTu4HvX/
        B6Dps4yv+F+sgxAxUvLlL7/flEs+l31Hqy71QvWRp54fs4jkF9yRNa0WkGd6fO17pEZg9PeCogq
        8nz79YHvliKIW5agCmfjyluBp8k83Jr8BAvdLsyBTJOW+O5RDy18l4cOBa0Y=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12-v6mr1434105otf.203.1528392895235;
        Thu, 07 Jun 2018 10:34:55 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKLAOrXN/cxG2Z5gfL/HxyTQmT7+x4vicz0sKulsXgXjO0R+YzOkIAxW9HUdyxYWf8QiI5/ePFVhhoHND2dyhoo=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12-v6mr1434089otf.203.1528392894908;
 Thu, 07 Jun 2018 10:34:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:5fc9:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 10:34:54 -0700 (PDT)
In-Reply-To: <20180607165227.GD25513@lunn.ch>
References: <20180607155348.149665-1-brandon.maier@rockwellcollins.com> <20180607165227.GD25513@lunn.ch>
From: Brandon Maier <brandon.maier@rockwellcollins.com>
Date: Thu, 7 Jun 2018 12:34:54 -0500
Message-ID: <CA+fik51YC14k8yMLRkybMXQNn6uWB0u6aQUd1GMZrQtOF=cd3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: phy: Check phy_driver ready before accessing
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

On Thu, Jun 7, 2018 at 11:52 AM, Andrew Lunn <andrew@lunn.ch> wrote:
> FYI: net-next is closed at the moment. Please resubmit these in two
> weeks time.

Ah, I didn't see networking/netdev-FAQ.txt. I'll resubmit these then.

> I'm sure there are more issues like this in the code.  e.g. there is
> no attempt made to hold a reference to the child phy. So it could be
> unbound. priv->phy_drv->read_status(phydev) is then going to do bad
> things.
>

Agreed. Another thing that looks suspicious to me is the driver
overrides the private data of the device it's attaching too, in the
`priv->phy_dev->priv = priv` bit. Seems like that could cause all
sorts of driver corruption problems.

But fixing that is going to require more drastic changes to how this
driver works. So it'd be worth applying this patch in the mean time.
