Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AA2C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B19D24137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlQNjUbD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B19D24137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeGENLS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:11:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38124 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbeGENLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:11:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so6633356ljc.5;
        Thu, 05 Jul 2018 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ACYZL5igcpmwDCXvYs1TRg+lhzrcRXaVbsnuEXffSE4=;
        b=UlQNjUbDDktAEuT7wGmOGh6VqD0nUvQZdf1mqxjm8vA+dO655x+KUZdeilzBaMl2gc
         qww4lCuSoKVjxZ/dHixvfWKKdOBY573GKWqXTDytQk89IU7y50peuKO2DpaAJm+HN36U
         RMc5x0p9ViY55cHLXl8MDcXQMymIve236wRwum4HjPo4zspZkHjcD6+IBK8GnS6Y6poK
         zVEjtJoeHMLpyjVYIh7GYxUnlTcZVzJntKBsNwU/bnCWej/X6y40NMfVAlQKw5FU96wI
         xm3w0aLRYONQ0bGJO0DbYB5zppI92WDaRtiW/Ok4Jfd/l/MW3GJlOHJHpU4278rLYpOS
         rYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ACYZL5igcpmwDCXvYs1TRg+lhzrcRXaVbsnuEXffSE4=;
        b=qed375ND7OHXzBqmlxjOZar6lIsFUQnUwmfFwTpJ2mBPcJIuVQgnlIylg8iK0M9Cx9
         eFZ/qlGxN5rSfW+9PXVzu8AkDYgtxvXOVCQeTKbK8fbt8Sn902sQh+NS8c3upoiC1SXm
         aL43y3/vWeCVlQ4bDs/xvBrREjCT3ameXZGkBid8nf4zmGrwe4wzvey0ulfveDZ4VqMS
         w0cSRzZIJqSxmbdbkx5ZyHAOay1DItHPN1kETIdGr00kkCzBdAbgTmuv9EPJ+Sk/y82B
         MWc/rAKAOl+mJnNWS01YaK7fZ9n2YMo+CsYNZYv4Jdbj/oTAZBLyguKoAs+T/Tm3OHYM
         o5MQ==
X-Gm-Message-State: APt69E1yJbf7i7Nto6QgCPxqeEb5appYyC8cJQSeabPkzR0iXqdBKckw
        hzZpJM7LuSsuUPnVP8mgWOU=
X-Google-Smtp-Source: AAOMgpfCJe3ohg7/QoBp3nzEIheQ5iExhcj3jqClelxmac7fPwsAHdtvkE2MscagqFDLEhIaeDQkYA==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr4072648ljj.103.1530796273265;
        Thu, 05 Jul 2018 06:11:13 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id h65-v6sm1433088lfb.22.2018.07.05.06.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:11:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fb42I-0001OX-P7; Thu, 05 Jul 2018 15:11:02 +0200
Date:   Thu, 5 Jul 2018 15:11:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martyn Welch <martyn.welch@collabora.co.uk>
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for CP2102N
Message-ID: <20180705131102.GC9802@localhost>
References: <87d0w5wm33.fsf@miraculix.mork.no>
 <20180620082507.GO32411@localhost>
 <20180617182503.23080-1-pados@pados.hu>
 <b2526c441d5d99b5f491b78cf9e84475@pados.hu>
 <20180620105231.GQ32411@localhost>
 <f16a7de43b151c6f98ff5ff379427f16@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f16a7de43b151c6f98ff5ff379427f16@pados.hu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 07:17:33PM +0000, Karoly Pados wrote:

> On a different note, v2 patches are coming soon with the feedback from Johan
> incorporated. Did not forget and I still intend to polish everything up
> as requested to get these features into mainline.

Sounds good!

Johan
