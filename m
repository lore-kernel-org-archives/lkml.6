Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678B9C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206F523DC0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZpmmazc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206F523DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbeFVGcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:32:54 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41656 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbeFVGcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:32:53 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so5463369wrq.8;
        Thu, 21 Jun 2018 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EIw7qZ618/8JuYyFumNilFKD8g98zf6znzRrqT5r9hM=;
        b=QZpmmazcHo3KFAxflT9L5HSiKNI18w6/U1MJvnGoS1iEKN4QVfNGqlLoV04KmzCLO/
         gRV88/c2o01f0G8GG12kIC1dAsqMf35YOtAGP0Zafuw/AB28U5IpgXsrXBHFdSojzVSe
         BcyjDR2LedNLPVJ2SckWwMUv2q3pL4IyPtIkTG6fVlZ1b+5NasDNBroMvOeI0IhVh2iw
         SkNbaUSaGUZ70oI2KzPqFJZwuVT/+uYzW+4Lp3JOUfYXCG7hZN91BXDrHc8Mhu+FvnAe
         IgYqXg7+QnjwIs5DUVrtG2dWypfgGZq6YqJj/5GI9yoWjYYiE4A12t4zBlgSYxoO6Mbp
         d5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EIw7qZ618/8JuYyFumNilFKD8g98zf6znzRrqT5r9hM=;
        b=LimgCBcclakDlOHz7/0hZ6JD8D2qiV9Kya61L6+CCHxnrPG/zz2Eec4Sio6572sWGY
         DGy9Y3XQPVyZUqG6PXB2WOyAqiPEaG9O+L6oiRIb6d6bDWme8AzEb2FQ9K2D/4AYLUP2
         tVY7PznCGQ0LHH7DbslK8BWs5778jCOOqYubIegihDnyMCbXK3FR8GenoRmyENz9FY2L
         XnENtK0eO7LfdkBGUr8fH+qnsYoWlzl7keNmxfn/zhSUA55Piqo90QqhtvSMfVZudmyr
         XirWO8t6OhU3U0+MK6ajiq3YuK4SgFIg1TuTHNvOTJqqgO+DWNzvmchJ2I/uTxHzGEwG
         PLGg==
X-Gm-Message-State: APt69E0ubSuD9vCIhWhWSwZAaURL/xI+LwkKrD/mE2b6QrAQpmpgXo1a
        ihFqz6wokqxr409phhGdpVHF3OUG
X-Google-Smtp-Source: AAOMgpd8j214Bg5xyrP9tMaiablm4WnY94UkzgDj4fqKIgLugnx9ZyxeRgH2f0qLdBVniHZyqoOU8g==
X-Received: by 2002:adf:9487:: with SMTP id 7-v6mr386775wrr.82.1529649171622;
        Thu, 21 Jun 2018 23:32:51 -0700 (PDT)
Received: from dell.be.48ers.dk (d51A5BC31.access.telenet.be. [81.165.188.49])
        by smtp.gmail.com with ESMTPSA id y186-v6sm859447wmd.38.2018.06.21.23.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 23:32:50 -0700 (PDT)
Received: from peko by dell.be.48ers.dk with local (Exim 4.89)
        (envelope-from <peter@korsgaard.com>)
        id 1fWFcn-0005xD-9f; Fri, 22 Jun 2018 08:32:49 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] i2c: ocores: update HDL sources URL
References: <20180528085914.30657-1-federico.vaga@vaga.pv.it>
        <20180528085914.30657-2-federico.vaga@vaga.pv.it>
        <20180529181826.h6hzqefjgqd2xpap@ninjato>
Date:   Fri, 22 Jun 2018 08:32:49 +0200
In-Reply-To: <20180529181826.h6hzqefjgqd2xpap@ninjato> (Wolfram Sang's message
        of "Tue, 29 May 2018 20:18:26 +0200")
Message-ID: <87sh5fl4a6.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <wsa@the-dreams.de> writes:

 > On Mon, May 28, 2018 at 10:59:14AM +0200, Federico Vaga wrote:
 >> The URL is broken. This patch fix it
 >> 
 >> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

 > Shortened the URL a bit and applied to for-current, thanks!

 > @Peter: since the patch is trivial and nice to have in 4.17 already, I
 > took the liberty to apply it right away. Hope this is fine with you.

Sorry for the slow response - Yes it is indeed.

-- 
Bye, Peter Korsgaard
