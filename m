Return-Path: <keescook@chromium.org>
X-Cyrus-Session-Id: sloti22d1t05-3714631-1518638814-2-2293520577833816097
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.67', Host='mail-pg0-f67.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: keescook@chromium.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518638813; b=OOUsZzILNe5bkItCMV5KgZZXcy5I0qh7afUKcVkiKIVjR3G
    TDLyY8drKqcOcCUUGMvjupyGvSwNgVxy77/2W7bNbnmPViAnDKsSYEJ+skos3wDV
    HDZHfyxuiWB97oZaOwqFAmzr7s85LrNy2Bh9xLqn/d1qjpA+5TfPtgEOV62YHgNE
    ZwYTw5P7bH71UpvQf/JoT0aTk7bCHZYvL5Vj/9tVFe4OAAj9vdAtm1ETYcrVWXRi
    lU6oc96VjAy/T6NGShbRH3uTW4iIHvALBMlJW2T624AYJjCeOY28h0D89BzU6dpj
    FxM9QqqQuGV6Ar7hOGCnR1goVoK7zZNbopav/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id; s=
    arctest; t=1518638813; bh=pR0D0laQGpT3d53jI/Ktw6fld7NeIOTauuLW3U
    YC4q0=; b=wzSJ598YVtauhTnV33cEnfJ1UqP8rfvsh+poAVXpNEiGTRb9VXuySC
    CNelAgOcwd4BEakLDjJDgZup0ojVQg5Wh27lTe21+n6gBXCyzRgvstwElxRitOiV
    U5GU4CX5GPZaCEUEtEcMjeNJprXr/s8RKt8AyhFiGSptsxzUiCvYToZCuTk2UvUi
    xp9m126U1Dq7uKJwRkTtfV3O5o+AaFZSfe7nTjTElv66k8BgdeKq0jnu2Pi/CqWk
    HQ5IVXTcc32sIlmIj1om0jjzHIG8E94eDgjm+jMssny685qxWzcceajeHAYau6Iy
    GaXVn7D7KwuxrjkT5Xw2wvHEuzIpuJiQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=METhqomj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=keescook@chromium.org smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H0Ov6yjo;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=chromium.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=METhqomj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=keescook@chromium.org smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H0Ov6yjo;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=chromium.org smtp.result=pass smtp_is_org_domain=yes header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224gE3mPAmbyUYCiblNb0OwLH2y2ywtwlMcQVKbv4w2722l0p8P9qOFD4d1JblBx4auTjnUBug==
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Willy Tarreau <w@1wt.eu>,
	Hugh Dickins <hughd@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Rik van Riel <riel@redhat.com>,
	Laura Abbott <labbott@redhat.com>,
	Greg KH <greg@kroah.com>,
	Andy Lutomirski <luto@kernel.org>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [RESEND][PATCH 0/3] exec: Pin stack limit during exec
Date: Wed, 14 Feb 2018 12:06:33 -0800
Message-Id: <1518638796-20819-1-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Attempts to solve problems with the stack limit changing during exec
continue to be frustrated[1][2]. In addition to the specific issues around
the Stack Clash family of flaws, Andy Lutomirski pointed out[3] other
places during exec where the stack limit is used and is assumed to be
unchanging. Given the many places it gets used and the fact that it can be
manipulated/raced via setrlimit() and prlimit(), I think the only way to
handle this is to move away from the "current" view of the stack limit and
instead attach it to the bprm, and plumb this down into the functions that
need to know the stack limits. This series implements the approach.

Neither I nor 0-day have found issues with this series, so I'd like to
get it into -mm for further testing.

Thanks!

-Kees

[1] 04e35f4495dd ("exec: avoid RLIMIT_STACK races with prlimit()")
[2] 779f4e1c6c7c ("Revert "exec: avoid RLIMIT_STACK races with prlimit()"")
[3] to security@kernel.org, "Subject: existing rlimit races?"
