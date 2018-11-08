Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FEEC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19FB20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 08:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO3jmVYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19FB20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeKHRwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 12:52:40 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53859 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeKHRwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 12:52:39 -0500
Received: by mail-wm1-f49.google.com with SMTP id f10-v6so302228wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 00:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zI6RaRH5sHDGDEy6cj3UWUjITtxf7WuNyeDYvV5PfQg=;
        b=CO3jmVYWlpC21DBnYq0wsa5Vj1XX5UTNb2vle456fqfacBeEoJs60S017KI6h0o0KK
         +CvRh6KdNbLMBVzmYmgiFK8OnhbmtV1BVcqAgCdvrzTBKqs2nkpJ9YX0HYVh8QQnXZks
         0Ro4ShrhSw6VNX3oVFOYS/wOhgW+A9e+ue7vvBZdbkbSXKAlZqwkpK4VDpNeZmEqHLgQ
         NXjejgsIch/XCwthhGGBWPD8UuONNEJJ047Pb7xNZ1BaD4LnPEGklzufjsJsUy7cDPa9
         4gg5DUItZQRsFepGQGVUzsAVwkoxcQSxRg5GPZXGE6BZ0AZkSpz2zSoFrZt0+PVliu7J
         bA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zI6RaRH5sHDGDEy6cj3UWUjITtxf7WuNyeDYvV5PfQg=;
        b=QHjvO/C0vTn58LPrhRYAWi7J6oHKMPXSu0N463hLZ1Yk+/JOXouWeJZcAqIeLRpcZm
         euhFGMMgdPhckZgUtnDLJMrVNeqm0///QVQzN10b5QRFNy7rfvM/lAyACbxYWIztDDKT
         H/vGzQkt+c/pXg2Rw7DHzxFVBTUvkOpFzQIN89ovO4wvd+GLZpMtObsnGFZIskkz3Wl+
         oRjg/+pJDE9dm3GsZ8oEte/mF53tBuC7elijVPU2LGRbahXdZMxB3UXphMr6GsVxyi8z
         vybrmpkyVYR+sPLw6hFN9/7303pOIxPbVK6W5VcIZxwLcNMQCTF/CCd4W/lpFjm/f4bn
         W2qg==
X-Gm-Message-State: AGRZ1gJ7c1aEJF469XFiBAMbSJ8MIqjsOyz+n2rFlNfpu9MQ+zwM22tE
        kPnt8uFUh20XuW0boI9tig4=
X-Google-Smtp-Source: AJdET5fHDvtDJe/7wQ4FLtmDmPbhFJx2Pvx9BWgOBpa7KOiAFXXHtkdwzrQf34YH36QQ102TTbYn9A==
X-Received: by 2002:a7b:c1d1:: with SMTP id a17-v6mr318360wmj.10.1541665098002;
        Thu, 08 Nov 2018 00:18:18 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x12-v6sm1864871wrt.87.2018.11.08.00.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 00:18:17 -0800 (PST)
Date:   Thu, 8 Nov 2018 09:18:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch 2/2] Documentation/process: Add tip tree handbook
Message-ID: <20181108081814.GH20032@gmail.com>
References: <20181107171010.421878737@linutronix.de>
 <20181107171149.165693799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107171149.165693799@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> +Commit notifications
> +--------------------
> +
> +The tip tree is monitored by a bot for new commits. The bot sends an email
> +for each new commit to a dedicated mailing list
> +(``linux-tip-commits@vger.kernel.org``) and Cc's all people who are
> +mentioned in one of the commit tags. It uses the email message id from the
> +Link tag at the end of the tag list to set the In-Reply-To email header so
> +the message is properly threaded with the patch submission email.

s/id
 /ID

> +
> +The maintainers try to reply to the submitter when merging a patch, but
> +they sometimes forget or it does not fit the workflow of the moment. While
> +the bot message is purely mechanical assume it implies a 'Thank you!
> +Applied.'.

s/The maintainers
 /The -tip maintainers and submaintainers

s/is purely mechanical assume it implies a 'Thank you! Applied.'
 /is purely mechanical, it also implies a 'Thank you! Applied.' message.

... added a missing comma, plus there's nothing to assume, that the 
thank-you note is implied is a given! :-)

Thanks,

	Ingo
