Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544B02080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBMWPQWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544B02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbeKAC74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:59:56 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46017 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbeKAC74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:59:56 -0400
Received: by mail-vs1-f67.google.com with SMTP id 124so10579731vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U+dJ4AgdH9DGxnYoDCHDxdcMNM6k3fIWA9x9UjVEZao=;
        b=PBMWPQWwN/FHJTe31U3F+tS7A6ohGBiy60XOA7EW9fMXLKENuy6jkPkt8JSReTG80r
         /EYtizEVXGpfw1KUjS+ZTZY2catCsieF5B1ACElB7YXHNXyhKkA+TtUvMqOMAEU530sB
         VzYgLuHqfSnK4OpzpeF2GiLpLjQBjQhlTXGpBVsDiy5YuzB39jRqPQ0Y7+fOksRM/tWk
         hhp8hVkf5a8kgdGQylgN9m+TGlPO1VZz5eRCknQxS+t+u2tGjZScPv3S+1w5lC0UYGXK
         fIS1BNVh3fVe2kYBaCt+Cq7kwiXNXplZX2ggRWUg4Mnw+Gg8HfroKwIR+9Y+evfYzEfR
         M6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U+dJ4AgdH9DGxnYoDCHDxdcMNM6k3fIWA9x9UjVEZao=;
        b=GddlhEoQ6ir3oq5ajvFerEG4+Infa+Ok7wz/uoaM7zcpdmId74o9Aty9WpMkztXNr2
         NHfcbPn1ewrveOnNF/6VrNzs9G+Sk4cahaK4/AuQURird17Eg2qYXAS1azMvg/feegFQ
         t1thKcuCUmleLRZn3f4vjWbRRiR0QfWhlNwDFOIJJa30J18ivbl99gJpjzGA/YjnsoVn
         Cs/hFFDMRuLgQfHpnjtA6Sae4YMN0ECT3qhyawJjWuurSO7kD3frKoa4Xp/fmQjj+ZUJ
         je8OPWfGojrFP07fOOrVlYThsgTQejZBD1ZkDTl8496HUHbpe5xh+p9dAOFn8kvOcKoC
         O3iQ==
X-Gm-Message-State: AGRZ1gKhvhcWuv2uOh3Htf8mixAioKCHtoidE6YtjZ+siwp8qmnhFuiO
        4eQ5jIa8bFdb8DoDrDVfzz8gwQlnnSPX7yF4E1krTw==
X-Google-Smtp-Source: AJdET5c/2HOiSY3vvcq0d4pdZSyM2RgX1oV56twC2SM9KWiLPe5iX4wXNEcK8pEvxELw+KKuWjlMw6BfoUSocP6gazI=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr1777807vsc.171.1541008850780;
 Wed, 31 Oct 2018 11:00:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Wed, 31 Oct 2018 11:00:49
 -0700 (PDT)
In-Reply-To: <20181031175448.GC2180@cisco>
References: <20181029221037.87724-1-dancol@google.com> <20181031155912.45088-1-dancol@google.com>
 <20181031175448.GC2180@cisco>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 18:00:49 +0000
Message-ID: <CAKOZuevrFxWLY1J1DVPNGaEy8UbkD1r_M9T9FQTOtSrqp-G0qw@mail.gmail.com>
Subject: Re: [PATCH v3] Implement /proc/pid/kill
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 5:54 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> Why not just use an ioctl() like Jann suggested instead of this big
> security check? Then we avoid the whole setuid writer thing entirely,

Don't you think a system call would be better than a new ioctl? With
either an ioctl or a new system call, though, the shell would need a
helper program to use the facility, whereas with the existing
approach, the shell can use the new facility without any additional
binaries.

> and we can pass the fd around if we want to.

You can pass the FD around today --- specifically, you just pass the
/proc/pid directory FD, not the /proc/pid/kill FD. The /proc/pid
directory FD acts as a process handle. (It's literally a reference to
a struct pid.) Anyone who receives one of these process handle FDs and
who wants to use the corresponding kill file can open the kill fd with
openat(2). What you can't do is pass the /proc/pid/kill FD to another
security context and use it, but when would you ever want to do that?
