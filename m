Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA18ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0C520824
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 04:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IbOXduhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0C520824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJ1N17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 09:27:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41484 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeJ1N16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 09:27:58 -0400
Received: by mail-lf1-f67.google.com with SMTP id c16so3647895lfj.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 21:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mo8chMTb7P8kdTTT55rkPmbC4jMufu5lGpn7gEzmxgY=;
        b=IbOXduhkXH4VBod5k+MVxNNUN0rMfyXNT8dWGkLHP5ckDujhfUUyKhWviE9u/fEx7B
         Ucr0TXRTgi0i8ht8g7w7D+9Punv5QoLg87gu/nk4UKKcCIw+hZ0hgeFZFSPFxRMVhgrw
         8EllDdr7q0fGV+UIhAiOCY6h1hcWCSq00rMhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mo8chMTb7P8kdTTT55rkPmbC4jMufu5lGpn7gEzmxgY=;
        b=MBRQLU7kwfDh6QWE987V1FzRtxrG85vK3886HJ1UCYmV10LIx4SV8xyiBFL7a9LiQo
         bQqLxWQ+alWAZr8d2KDHU4nCLnpELZNVdnbBHY36kOorBVLaD4kjSjU87FGH2QxuZyo4
         ukCZLgbGEgY1QkkHQAesZ+aPFXcl5VxrFkN6lVxlLTdHa+VcbXfOBfPLtI2/stRhMvn5
         rBtpnssymBuiZLXOgsALd+kpWHct9QuXPByT3NMjAJ8WJN8ktPfpbQGB3G0Fg1Zw9RAE
         K2Zq2X5cY1ME7Suj4cc/7ssBuE+dLFnBIvLyn5uoFR5O40n/2bmaAPmZwPGO/YUhh1sZ
         P8IQ==
X-Gm-Message-State: AGRZ1gLo/FkTYHb/nC/5zTPB1l5X6uawTY40/zPZq3jbZzdW2BfZU2G2
        6s2viJTZK/LT9CTYYEXVNHKpkGfrUrH9b+vUZ/GTw9c2
X-Google-Smtp-Source: AJdET5ea7a/QffQBPsL5Qlk5+qrcyZAt0XLoHOmtfYFYhGgMuQepznBlrMYVVcVuEovAm4ODdwOoibWulgBV6VwDN9s=
X-Received: by 2002:a19:6803:: with SMTP id d3-v6mr5613661lfc.45.1540701872040;
 Sat, 27 Oct 2018 21:44:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9b04:0:0:0:0:0 with HTTP; Sat, 27 Oct 2018 21:44:31
 -0700 (PDT)
In-Reply-To: <20181028021653.155513-1-joel@joelfernandes.org>
References: <20181028021653.155513-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 27 Oct 2018 21:44:31 -0700
Message-ID: <CAEXW_YTCJS9Yxt4J=nbF+Omdon_4Li2BUiVzALGX246fMA9J2Q@mail.gmail.com>
Subject: Re: [RFC] rcu: doc: update example about stale data
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 7:16 PM, Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
> The RCU example for 'rejecting stale data' on system-call auditting
> stops iterating through the rules if a deleted one is found. It makes
> more sense to continue looking at other rules once a deleted one is
> rejected. Although the original example is fine, this makes it more
> meaningful.

Sorry, I messed up the patch title, it is supposed to be 'doc: rcu:
...'. I can resend it if you want.

thanks,

- Joel
