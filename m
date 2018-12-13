Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6354EC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4B620879
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjh9xy4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4B620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbeLMTiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:38:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33221 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:38:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id o89so1869265qko.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3zsDjWOOQsEH72+pWVg3HpeMHdHXbURs8eaRASQsbuk=;
        b=Xjh9xy4/lW2H3VqIuWPc7SS6sgyCDN9j8pDi3pG/ZSfoaGgDo6eEMCNh+fOKtg+o8t
         BXaktPsaozAsFIC0bcjoJEQsI+scWkG8DHEZF9jLQXeyYXWbKtCOaKhwH0iYuEEqC9cL
         /QbFd0nQjpKz99QTGxGjsWViUMB964x1sfAno/2FUS7G5w7dqP1Tt6MVa4qhqtU38iFj
         mi/G0PNc3YNIViR88UwjMGRc0y2GK9wVhoEcELRkApbQ6lxqJlHquXAirMR763kWhVV3
         8r+QPUGK6vTCWUZAL9a8udoTMA+Ol3UntF/zr5IVxt1up3GK3y3Cop+dxNY/x8EfLAdc
         VgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3zsDjWOOQsEH72+pWVg3HpeMHdHXbURs8eaRASQsbuk=;
        b=U8vBhdtcsHUstdQd39PZDC4AFv7xVc12pYG5P/zes3p6h0bDrTk/9e6YS+oTjw5SRf
         ekqX66nYPujVvhmqA2lsklVZttPvckpFc9Q+jAQyisT7Of+54P/Tcp8aoHkq9j2ln3EX
         pUjVuqcqmatb4nJqdauY9UW4U4O8/0eMUrzeszyuaRV84jNuxh7uKdIv90NZpLYFkIKX
         MWukwivdCgesOJjiQsYoUeKk/8DpHI5ZYEbq97T/wi4OhSQWoFE8cae+RKGut0pWJAm3
         m6sybANbMgEaEbCLUlQ4eGyEMM9F3Ue/HtMr7/yz6i/HX7LHGisDI+vjdpZoUAiE/FDM
         f+Dw==
X-Gm-Message-State: AA+aEWZY0Ed1WfNVFlzsPe3vVpWRtykuHjlzaorrhgqMCjt3wDmN2why
        K0EG48QvKhd4miovaj+fAA==
X-Google-Smtp-Source: AFSGD/WADOA/j2GVMXfQoUBN306yZ11o18BC/Ik6Bi2P7NsFH+BfeNtCsXFmVymyAOr5SYNPGuTmOQ==
X-Received: by 2002:a37:7d85:: with SMTP id y127mr86953qkc.302.1544729900701;
        Thu, 13 Dec 2018 11:38:20 -0800 (PST)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h35sm1899206qth.59.2018.12.13.11.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 11:38:20 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:38:18 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, keescook@chromium.org, bhe@redhat.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v13 2/6] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
Message-ID: <20181213193817.4ltrgctjfs5wvv4c@gabell>
References: <20181212031053.1815-1-fanc.fnst@cn.fujitsu.com>
 <20181212031053.1815-3-fanc.fnst@cn.fujitsu.com>
 <20181213192529.yjklliaxy4tk4kck@gabell>
 <20181213192950.GE25287@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213192950.GE25287@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 08:29:50PM +0100, Borislav Petkov wrote:
> On Thu, Dec 13, 2018 at 02:25:30PM -0500, Masayoshi Mizuma wrote:
> > > +	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
> > 
> > sizeof() is better here.
> > 
> > 	len = cmdline_find_option("acpi_rsdp", val, sizeof(var));
> 
> Why is it better?
> 
> That makes you go look for the "val" variable and see what it's size is.
> MAX_ADDRESS_LENGTH+1 is OTOH explicit.

Ah, thanks, make sense.

- Masa
