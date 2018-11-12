Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC8EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712E92243E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAddWkxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712E92243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbeKMGSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:18:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35964 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeKMGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:18:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id z13-v6so10811543wrs.3;
        Mon, 12 Nov 2018 12:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MKtXgv/bonyhe8Hbvp9Po10KRxOktfZdz/ar1nsxXTk=;
        b=WAddWkxESwHVc+BcET/zlgm8CZD0agNN29PWb4TjmP8VyuVAzzKGlRXmboyAMoVmTl
         LKFwxZjbTb2LoNmslWjSa3TncZYutZzTjA+zK/KM+R0WQnNZufmeysOuysJg9k66vZat
         Mw20IEQOJic5ZnnZ1kq9aww0BZnEBAY9KAk06avn0oSuWUzNAktjE2EJ7O7pYi9D8LMR
         4BKXUHrKHTUIbkcIZDnhjwup5IDC3gJsjvGQiO7iy1e+5msn3+ZxU0jfrtbjKU0TItLK
         bGU5qisV0vMfIaaOjOPz3dkWWOXx8GJib5HRrNRSu7wj1lFK7LORN5UaflJLmX4oCY5M
         SoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MKtXgv/bonyhe8Hbvp9Po10KRxOktfZdz/ar1nsxXTk=;
        b=s4RBxUlHmA4sxvOXLgRdRl3MkbvhmZ34GOrUy56JrW8KtzB5mhOE9hNSuOARGXq/MU
         ptW4ApSL9M4lCN1GaZR8UZ8L+lkIfwsVLL8kaNpKztF2mBi4mJaiILO68zHGp+Z15Vik
         4eBO1tjK9ELsyuGCtJlTVvWHwA2Cy/rxWWxu2ZxqYKFRdi0CbuOEQoeB+/vCdsEBFXiy
         AhG51Cj9rGsPiEqwsvHi6iegg1FwKVgvdLRa7EsrDTORLe8mtJqiaF96Jd6InCevxBRE
         +MPGPpHh5grtLHNVbe71VubgiO4ysaFZCJxo0szHK1uWldMv7xpTS7x1HDfoZkPE1Aa6
         jbnQ==
X-Gm-Message-State: AGRZ1gI5fYlkbbpd3cOtOTUs7sA9DIZb1PKChURddtSwrm2Nt6pOrWsY
        abu0EIPJmJg4UguVkewZYQ==
X-Google-Smtp-Source: AJdET5ff6Osc7r9ccee6aD96YeS5wfCSJYZHEFy6+sN8NXLwZRs/v6NaaWeVp6hQykT6GRy7L7lnXQ==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr2506219wre.157.1542054226476;
        Mon, 12 Nov 2018 12:23:46 -0800 (PST)
Received: from arch.home (host86-147-12-72.range86-147.btcentralplus.com. [86.147.12.72])
        by smtp.gmail.com with ESMTPSA id o18-v6sm17265064wrp.31.2018.11.12.12.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 12:23:45 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:23:43 +0000
From:   Craig Tatlor <ctatlor97@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: sdm630 SoC and Sony Pioneer (Xperia XA2)
 support
Message-ID: <20181112202343.GA31294@arch.home>
References: <20180812142317.19991-1-ctatlor97@gmail.com>
 <61693687.BtxviolxTZ@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61693687.BtxviolxTZ@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:34:50PM +0100, Heiko Stuebner wrote:
> Hi Craig,
> 
> Am Sonntag, 12. August 2018, 16:23:12 CET schrieb Craig Tatlor:
> > Initial device tree support for Qualcomm SDM630 SoC and
> > Sony Pioneer (Xperia XA2).
> > 
> > SDM630 is based off of the SDM660 soc and all SDM660 specific drivers are
> > compatible with it. SDM660 is also based off of MSM8998 so it uses some
> > of its drivers aswell.
> > 
> > The device tree is based on the CAF 4.4 kernel tree.
> > 
> > The device can be booted into the initrd with a shell over UART.
> > 
> > Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> 
> With I think core drivers like clk, pinctrl merged in 4.20, do you
> plan on respinning the devicetree support or in general continue
> working on sdm630/sdm660?
>
Yeah, i am just a little busy at the moment, i should probably be
sending of v3 in a few weeks.
> Or do you have some git tree available somewhere, were I can follow
> along? I do have interest in supporting a sdm630 phone of my own
> but still don't want to duplicate work :-)
My git tree is  https://gitlab.com/opendata26/linux the
mainline-submit-2 branch, i have sdhci, usb(via downstream backport just
so i can debug without opening phone) and also working on modem but that
isnt in that tree and isnt working quite yet.
> 
> 
> Thanks
> Heiko
> 
> 
> 
