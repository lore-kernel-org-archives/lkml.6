Return-Path: <kernel-hardening-return-11817-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225HXjrbihHxlzH3znwJjXxuXhVs7FKOPai7AVLBM4ej2eJPfiht3m4GQtNch0RZ2vUgDJYw
ARC-Seal: i=1; a=rsa-sha256; t=1519008683; cv=none;
        d=google.com; s=arc-20160816;
        b=A8Sj5SWN3JOETWsxpyNLf0Qy8qMiWOLTQ35tQ7OPAGrVRdlxLck0rvATrR9bXp1T1M
         KAyETx3u7ZstRAMwk8myCFP8PQyve2GrQJat8V5jUntbN1T/2oMwVoOG+vShfPxUbpG1
         FZhh9Rdkq+uaU8x7Luvw3Ugu6SoLI8cyZx8nyFPGXFFTrd46xfdUbUwT6dfwxvgOI8Uo
         nlfv58ytwjjk0hwiqELdj8b1XQBKsnaCZ3jbCWlP3lYkJ+bS+iud+JxntEZPokjUuE44
         E6dowluRHdac3TihY9WSUcaIc9qxJnihs+lv6rbxQGuRzXh0nDdfmRgZ5sc0vxQW/DfG
         rECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Tgsjs/MRvMpeG62+kvzW3Wh62GKpLIKvKV+q6mD6tT8=;
        b=YMh4rcQV3FQShcXiLVTFWZ8wFuXubEhwCgNoX2RNvSqbCeXwqQwumHiXPjstIo0jHq
         GFmDAxXJUgyN+KIYJiQnxSmJy7GRWdRSOydxc1vvB2uwUYT9TJ8Pu3jN0Wkk/8tkx+Mu
         G1x8jgQTfJthVCYdTK9bp/6/3cjgyib4NdG3VHUqgHPKtfooCKNc+zPHVfWL9hx/nx8w
         U2iG9T/3hJx0Xu0TGAACnajQ7X0dnVJhKrb/ainC/IWha/wUCAYs0FHpoPeX1G8Q1v9R
         FXMCGHEDN/IOL79JcUuOqTb0HkImkO1vlfUrfbMbDbB3+nYUo9e9aLm8O+F9IIA0bdrq
         sfnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=oIDWXTbf;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=IHF4GSGu;
       spf=pass (google.com: domain of kernel-hardening-return-11817-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11817-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=oIDWXTbf;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=IHF4GSGu;
       spf=pass (google.com: domain of kernel-hardening-return-11817-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11817-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:kTuKWm7A2hmECScGcjwttJ1HVUm8UsHAUMNFUQLPSBk6C5gFVyW7VQ>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] leaking_addresses: simplify and optimize
Date: Mon, 19 Feb 2018 13:50:45 +1100
Message-Id: <1519008649-15782-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796049263140350?=
X-GMAIL-MSGID: =?utf-8?q?1592796049263140350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

leaking_addresses.pl is currently woefully slow.  This series fixes
that.  Also, currently configuring which files/directories to skip is
overly complicated.  We can simplify the code configuration quite easily
by combining the configuration arrays.

This series does not apply on top of the mainline but is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git leaks-testing


thanks,
Tobin.

Tobin C. Harding (4):
  leaking_addresses: do not parse binary files
  leaking_addresses: simplify path skipping
  leaking_addresses: cache architecture name
  leaking_addresses: add scan_once array

 scripts/leaking_addresses.pl | 125 ++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 61 deletions(-)

-- 
2.7.4
