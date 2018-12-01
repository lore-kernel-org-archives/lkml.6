Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44F6C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624942081C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/BZUEum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624942081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLAR44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:56:56 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:33204 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLAR44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:56:56 -0500
Received: by mail-io1-f48.google.com with SMTP id t24so6417643ioi.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 22:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/6vk7e5HJ9ypg2DG45bTAXIgcOKg29qVfyC9jdzers=;
        b=j/BZUEumZs3rTz0D6DREIUzPdn1a9+HqXrkeosLrWC+KoPQmPQ6Up1SwEdia4xz7WQ
         EWR/hpqlXqqxh0lKaO9DbhlEz23m4rdtQj6lCzBAYPp51Gk42PdmhBJGEYh+D08cKXuo
         +B2D6KX1aAdZ1TAZBTGibWa8x55JsOccqamgphQa4pXZ4jExVQDM7DBcHqX4ZGUdLUOh
         0fjRmWiBQrvHgDlR2alh6tA8ynu0SeAJJeDokmSiMGBzWYmdCxX6IjZF5CI7an8nc7HO
         ZLJ9qK0gwsJ/qBtx0TWN+q1zUx5vjdxYNfHRhgRM3D+ALne8J3q8sB/eIv0ZizP5KwjW
         EmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/6vk7e5HJ9ypg2DG45bTAXIgcOKg29qVfyC9jdzers=;
        b=Is7ZOAuUM7ftb+crwCZDUTdz+ypju/5XXQjWL6LWMcI7p+vxmFes3HcW09x4AMB/sX
         tMpgPzw02VCiwaXhxtkh8jRP1+IibpwdDXQ0XLP88iDh6JWER5US0BUfhAIwK8pnJALD
         H0rj4HfI8JvGYXeQis8qMWNvBfgpcN3+zl/0RRJNEyecWBmwiggTKhECk2gG5ei0r38i
         e8Zw1Xhwyv4PiUUuxRDEXfXPNu3/dFaaovblppWQfHcQRFAjZkJbSpCP07xtsrEUQhkK
         Oearr7GUZqxubqPD4MIBijVHQYTMpauFBcrOzR0RRbUJ66Zc1o81EwPf6fDEzjScJiaT
         mzfA==
X-Gm-Message-State: AA+aEWbeT4c5nlIzGXehGNxHZHPzFucEPvXazxGQLH4hOC8sdQsmmH+U
        ixlkd+aH2ojAbfRexCqtMk99+vAwSeNlyIUGaWY=
X-Google-Smtp-Source: AFSGD/USRcZkOeIkFQRLBHl85qHyC1fyiyo4gpCGX71To+mwJfe3GuJI3LdQdxhz2CfLGImPuV51gDSkenb8TeOde2Y=
X-Received: by 2002:a5d:9818:: with SMTP id a24mr6711583iol.225.1543646706940;
 Fri, 30 Nov 2018 22:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20181101154640.23162-1-tiny.windzz@gmail.com> <20181101154403.03c918d2@gandalf.local.home>
In-Reply-To: <20181101154403.03c918d2@gandalf.local.home>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 1 Dec 2018 14:45:35 +0800
Message-ID: <CAEExFWvdt=BQSxw4km-b-r+3oYRuTmrnkmgobzzndiH-6GN45w@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: fix small typo
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, trivial@kernel.org,
        jkosina@suse.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 3:44 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
>
> Jiri,
>
> Is trivial still maintained?
>
> -- Steve
It seems that this tree has not been maintained for some time.
Are there aother tree to choose?

--Yangtao
