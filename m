Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QfM9MyvvGFvAawAAmS7hNA
	; Thu, 07 Jun 2018 08:39:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B3846607DC; Thu,  7 Jun 2018 08:39:07 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSVcksJT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2EF87602FC;
	Thu,  7 Jun 2018 08:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2EF87602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932550AbeFGIjD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:39:03 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37129 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeFGIjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:39:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so5674883plc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y45ivCNTlsWYRG9+Y/fXcDkBiv3l1h16vbzMNWhMS5M=;
        b=iSVcksJTIz4SYDKSwyDAIflUAYo+MHw3SzKMAFrVLetxfWxORF8cNv5emExKx+Ab9D
         z24CgKQY/oXtE6568ryhtdjQVJtQFeBk986akjkxdnFK0KgXsbzBL9BLUDkXVex2sC4D
         WzYUmpIoKURn4nS5M/YiYyvghMf8WNGYVKZSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y45ivCNTlsWYRG9+Y/fXcDkBiv3l1h16vbzMNWhMS5M=;
        b=aCLUYSi/MmGnRvLG2ZskgGfT9QRY3Km0z1dB0ntSsWHNQOofGjnSax4EsfJmoxdPa+
         mzZn/5aawoDmsAsMufmaThM79JXUu8uP3JAFETRR3or3IeksnII9R335r9QyGT3i1wqN
         HrsKmwLEmI4hXtJT028QUuaH1vt/NFT3EAMORyAlE12mzFimRyTQ24M7bCHD0GSygZpM
         jsDDcunzUZqYLw5OCKNOXURwTqK9wpy0qSCrV1KMFWqQPbF4ABQ8/F7KfrVbNexJVR4q
         C1ayu0WbHLUflIxrJqRWImxpMlZc98RmVXbPG1ViqVTJ2yEbndO2WdNJak2Y26U5EkFT
         0JEQ==
X-Gm-Message-State: APt69E04wlmRCDChFfrHyLSNIe8dZnEXUwqnyL8/xAUa1kwE+CesTkph
        2ykpJeIOftFM7D/9RXohqXq/4A==
X-Google-Smtp-Source: ADUXVKJfEglbF7hlOknzG27utvA1k97PrKKGxDUtkv8Bx9+XN3zH8vS0dh6QlhfKodXYy8EuIdFMzw==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7-v6mr1074857plb.292.1528360740128;
        Thu, 07 Jun 2018 01:39:00 -0700 (PDT)
Received: from localhost ([122.172.167.207])
        by smtp.gmail.com with ESMTPSA id a9-v6sm39005232pgt.57.2018.06.07.01.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:38:59 -0700 (PDT)
Date: Thu, 7 Jun 2018 14:08:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, gregkh@linuxfoundation.org,
        alex.elder@linaro.org, Johan Hovold <johan@kernel.org>,
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
Message-ID: <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
 <201806060501.btF3aJMZ%fengguang.wu@intel.com>
 <20180606095714.1d3c2def@vmware.local.home>
 <20180606142600.GN13775@localhost>
 <20180606142622.2338abf6@vmware.local.home>
 <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
 <20180607074628.kd3iyxevwj3ypzbr@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607074628.kd3iyxevwj3ypzbr@intel.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-06-18, 15:46, Du, Changbin wrote:
> I think if the destination is not a null terminated string (If I understand your
> description below), memcpy can be used to get rid of such warning. The warning
> makes sense in general as explained in mannual. Thanks!

The destination should be a null terminated string eventually, but we first need
to make sure src is a null terminated string.

-- 
viresh
