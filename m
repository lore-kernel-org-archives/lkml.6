Return-Path: <kernel-hardening-return-11746-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225gzwQ8KycUqn0mnF+KLdsOZSghwE6ZPSzYv0BwQeEKFqRlpRAhLurxUbl/Lwz5rJPCvmDN
ARC-Seal: i=1; a=rsa-sha256; t=1518535350; cv=none;
        d=google.com; s=arc-20160816;
        b=ZeHysAiy3qHyEL0RncOYRl+abpZeymqwSC7/h63097p2Kw4K0sGuSKqo7cSfLJ8lRy
         8yL94r7ricg+QgCkNuB4VKeYsaOMeCzKmMpHzpCWJ96NN6pSIh0wGAE1gxBAW00O3Wuq
         bcDIsWUzCP1KACw+HdKolGWX022KJ1CEQqd0B303fpyc1mnQ6RgCZXrvD9mTrB18EI5m
         cDOmFXoVI37k2E0Mi3o5SDnZQOs9ZgPqt6ChakqIHigrChWe+K7azko4lz1Jvs/5QIHM
         T6sgxMo6wIRkZBjsdzpC+djkyf7GC5T1wEGnAJXfm0nCSdRNlF/vCfI2Auqaa4gda6XD
         rm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=zyNxdWKQYX2YIafBRZFAsWIelL250qcxoqbuL583R8Q=;
        b=iw7IOcpJbOtqNxzwTz3fDyTHKkZ5vgr74nVDJYl6AM7Po3ao83bfO/zM6Bm2RyMsZh
         +q6XT5rF4N1BqboOO+ME0OWOsZAvzfvfzkzpWBdF5+3kIM865kaihUGCwCm35o1n69d7
         qyz2n0bDURIrQnjt3Cepck7X+MwRdMlq1xIK/FO962DkP1SHBOHLelN9aCH/GUtf3Ey/
         O4LBW/F2bVXuoIzHPOVGkeQbluqjO2RwLk2Cghsm3R7EJPMoBDKWQsIwJ85EBPXIDciW
         1LXi+EjGhRwdOQkV6p7DpE5kASs9iNVt5CpkbYtmHexLySIhl0RwRI5XKDZ2cCcOt+/7
         ACTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=k5Qn0OBz;
       spf=pass (google.com: domain of kernel-hardening-return-11746-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11746-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=k5Qn0OBz;
       spf=pass (google.com: domain of kernel-hardening-return-11746-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11746-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Feb 2018 06:56:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: valdis.kletnieks@vt.edu
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] GCC release 8 support for gcc-plugins
Message-ID: <20180213145632.GA7937@infradead.org>
References: <123377.1517765678@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123377.1517765678@turing-police.cc.vt.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490625322246882?=
X-GMAIL-MSGID: =?utf-8?q?1592299724038148559?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 12:34:38PM -0500, valdis.kletnieks@vt.edu wrote:
> For reasons totally beyond my understanding, gcc 8 changed the
> order of two structure member, which leads to an error:

I'm a little late on this, but isn't the whole point of C99 initializers
that field order should not matter at all?
