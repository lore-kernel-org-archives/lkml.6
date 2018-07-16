Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1070EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D4A208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCRC4NdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D4A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeGPMCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:02:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44356 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeGPMCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:02:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id d17-v6so17621888eds.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=takG7VDP9U4CybCgXxwJGmPp9y/m8eyAfXAMVfHWfaI=;
        b=pCRC4NdXRHZGhki/bQMyFl4601LBpiU/mg2ewkCng8gZcMW9xBiegF71+QDu8FZV4R
         mExJKr/YUTHU9ErCiLhHb10MejfxzP8+BkBBDDcW5pYi2Q5PjKhzfR7NdnqKkNXCPwOt
         JdO+Mke2B44zEqQkKTcl64a0R/WgmVmOW1nXnHLBNZR2mtfKRs1S6r4JacZHF62ExxbL
         JtERrVuD5lXqzsnKwhvZHyENLw9ih9T5f82txq+GUFcYgmKIOSs9FK2Kr7DU73n8GeUE
         NQLi8mEGTx2bbychvP+zHCWT/7+SeZvWEbwad6Ku0CY8uGwMTxhv0floffZtAtBebVxx
         86VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=takG7VDP9U4CybCgXxwJGmPp9y/m8eyAfXAMVfHWfaI=;
        b=nu96Y9gNNey0K53UDjI2hfYUyDnHqwndDnkmmEn3XPnDB80v0BmKQyHxzIUSotyHct
         3H6Wq4xt4ajlgEFrE0CuTjXc2ObznR+iejspUr51f5WYU1wfuKzqYgSVLHd4fzGXRVkO
         HKAykTsZMIhq8UiRb450tdttLzGV1dDOW7mzYBAuWbAV8O2DqL1qmH3VK4tT1AV6I0AF
         726WNLgVsfbTgrd87g+9OJEh060w1kWqzhgTjicez8C4EGMgPWsIwSHlgZgd5xcEQhjN
         PjeePzR37+VGiveVLuP8p9lB32qP8htObCuy4dyIS21ShTr0MaigPGmz9sbii3kUquqa
         XQgg==
X-Gm-Message-State: AOUpUlEoYOZQ7L3NheA/XYYQMhb5JggAz2sXn2bSwXid4c8rcxtj3GX2
        wiT+VnZWUztewlcwVPHyp7U=
X-Google-Smtp-Source: AAOMgpfJl9uLNuVm0MIgrN7wTiMFuD4+jfZFA+Gv1LWTCUEOsYdJD4zPRf6bdcF9H8ixVSNZ+Nw8WQ==
X-Received: by 2002:a50:ab13:: with SMTP id s19-v6mr17362556edc.133.1531740901226;
        Mon, 16 Jul 2018 04:35:01 -0700 (PDT)
Received: from xux707-tw ([109.77.251.220])
        by smtp.gmail.com with ESMTPSA id y6-v6sm6145763edo.46.2018.07.16.04.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:35:00 -0700 (PDT)
Date:   Mon, 16 Jul 2018 12:34:58 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        pombredanne@nexb.com
Subject: Re: staging:rtl8192u: [0/10] Coding style changes.
Message-ID: <20180716113457.GB22731@xux707-tw>
References: <20180713201247.21428-1-johnfwhitmore@gmail.com>
 <20180716084020.GA8260@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716084020.GA8260@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:40:20AM +0200, Greg KH wrote:
> On Fri, Jul 13, 2018 at 09:12:37PM +0100, John Whitmore wrote:
> > All coding style changes, but the second [2/10] is a bit more hairy then
> > most. The original code combined two typedef declarations into one with both
> > the structure and a pointer to the structure defined. I've totally removed the
> > pointer to the structure type since it uses Hungarian notation, which the
> > coding standard isn't keen on.
> > 
> > As a result of this there are changes in code from the type:
> > PStructType  *ppname;
> > to:
> > struct StructType **ppname;
> > 
> > To keep the diff simple I've kept the current nameing of "ppname", which again
> > is Hungarian notation. I'll leave that for a future patch.
> 
> Nit, your subject should look like:
> 
> Subject: [PATCH 00/10] staging:rtl8192u: Coding style changes.
> 
> What are you using to generate this email?  git format-patch
> --cover-letter should generate it with a correct subject line prefix,
> right?
> 

Oops! I was using "git send-email --compose" didn't realise that option was
included in format-patch. I'll use that format-patch option in future.

John
