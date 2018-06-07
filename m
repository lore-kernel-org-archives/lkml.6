Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RN0wMRb2GFvUQAAAmS7hNA
	; Thu, 07 Jun 2018 09:10:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 44BD3607F7; Thu,  7 Jun 2018 09:10:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EohAtlUN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CEA11607DC;
	Thu,  7 Jun 2018 09:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEA11607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932795AbeFGJKd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:10:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45593 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbeFGJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:10:28 -0400
Received: by mail-pf0-f196.google.com with SMTP id a22-v6so4596345pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 02:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=80t2qFEMJWN1kjVU3JfVGtwzmPfZZXuweGSdWWXLnG0=;
        b=EohAtlUNgeEzWFj/PUe5o+BmDxXGoIX0WZQ5gIEwWFQUBbKeZUDHm3Kzj9YSmjh8Y7
         yhoFnCBwVWxjbAdeVLIgFNyUZZzC8Y9Cq1rYKeCH38X1FvKXHulsyHqnk2Yk/OAya6sh
         MPF1XQsgp9jtLWawABRu8UOT22zeo7GRQoj0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=80t2qFEMJWN1kjVU3JfVGtwzmPfZZXuweGSdWWXLnG0=;
        b=gaCIx5Q2mOSV3hGeaMtEYxtPFl4jtPe5Z0/K3/p1kH3wTTAIqG+c82s5HRAoz75xnC
         Eqh8osiUjABQ5MMU8yJdXlQjwrC4eKgdimlXQq9//rSukBBvzUFgMOxZhkmmawZzap4g
         Paze8bt3Gz9RaPcOtiM3jkdAO2QVmFiJcSzL8pPRVM5UczWB5/zCTxbjrDLJL2zWAnB+
         5OeEhOtkyMKd0dUMpshotCHa0TNm/E/0AcuXEbgzvtAOR5hYnUwLL6x+WlsGUFSLs7b7
         AYjB8NPd3LZoEV6UU4DWFAtxXtOPuO/l2ltQMch+UKa776U7Etom5q/PQBLfK5tMxMRz
         fxaQ==
X-Gm-Message-State: APt69E3h5rIZmFxIG3yGHcDJgYZ1wf8VrS7uex7bg0Wia4w5+htN1mX0
        +XqT8R8UFbxLI2NxAGvWwydq7kVO5sk=
X-Google-Smtp-Source: ADUXVKIZA5CiSzmb9F0Ghe/JCGR6KbKMG+Zx+UmeybJEKCYJGV8JcosaiugB++gYXQuks96gDazejA==
X-Received: by 2002:a63:7f4e:: with SMTP id p14-v6mr885570pgn.27.1528362627987;
        Thu, 07 Jun 2018 02:10:27 -0700 (PDT)
Received: from localhost ([122.172.167.207])
        by smtp.gmail.com with ESMTPSA id t23-v6sm35207873pfa.86.2018.06.07.02.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 02:10:27 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:40:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: "Du, Changbin" <changbin.du@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh@linuxfoundation.org, alex.elder@linaro.org,
        Johan Hovold <johan@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, linux-sparse@vger.kernel.org,
        mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org,
        changbin.du@gmail.com, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
 <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
 <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 11:03, Bernd Petrovitsch wrote:
> On Thu, 2018-06-07 at 14:08 +0530, Viresh Kumar wrote:
> > On 07-06-18, 15:46, Du, Changbin wrote:
> > > I think if the destination is not a null terminated string (If I understand your
> > > description below), memcpy can be used to get rid of such warning. The warning
> > > makes sense in general as explained in mannual. Thanks!
> > 
> > The destination should be a null terminated string eventually, but we first need
> > to make sure src is a null terminated string.
> 
> Is there strnlen() or memchr() in the kernel?
> Then check the source before copying it.

It would be extra work, but memchr can be used to work around this I believe.

@Johan ??

-- 
viresh
