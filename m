Return-Path: <kernel-hardening-return-12063-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtcyzshLpjbnZUvtBtgAgOvN8FDjTkg5Ro2fvRwnlwlqab58E0b5ytXUXMOTefmYmf2L+nx
ARC-Seal: i=1; a=rsa-sha256; t=1519941847; cv=none;
        d=google.com; s=arc-20160816;
        b=DQV2L2mXgRPcvIMNvYOJOPgL5GJhcx7HjeJ2UVay3shuQx2Bo5pIZdG7oKMa4NXP4U
         TDMkYRTrfOVETzPd/Ff7BvaY8iUYYlwcIpES62N7WO6d90oyyCIZp9vOwrQQM/Wx4XA7
         R/cZPRLipV7f/RqnTspKU0BRAg4PbnwGhiKrPJaEqcFcP2jlGnrsUjQX+BUM5sYPfPlD
         ifvRGC+8rqhJ1RwVYHUHY4WCqf9w7T0ye5g/8wSXZji9/x5UF75Lzq1JBShwXaZT/VKo
         lI2wE439cldIMC/twMdjkFutaopwIfH2NYHyKU/8ri4jM4jPiEGgLfh7IdA0Wmx2p5+f
         /vSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=w0aPaeGURAY4ujVQ8WL6mDHVX1Hobfo2BRXaKMHnkQM=;
        b=f05hhRXJRML04lP8OB1iT6TVKQsH3G1e0bClGi5AkZBg3RRfs2ZV3CBwAUgBI/25U0
         s2flTtql05DsNmz2NE12LXda3Q8W4NLo5CTvJJbuBOBywgy5x/JqzTwFVK1oP8KsWEzg
         XpLCh5CeA6g6AC6ntqCebRKUsWQfgStQmCoTVFBq+9os05VG6BM4/qmzjI7REKTS+IsL
         FjzJll54F6HSW+UOHML1ZUMjso6z83XIOSkVcEXyUkS+Lpkl1956hamhCb138rFq1M/G
         jlzpdsonJIi8IGR1VKNatyrstFj5Ce2ebeIo45KKafdTLr4LRMJsJ/0A0hiOLsLnnQit
         L5rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=FF5Q6DqU;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=GH10m88y;
       spf=pass (google.com: domain of kernel-hardening-return-12063-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12063-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=FF5Q6DqU;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=GH10m88y;
       spf=pass (google.com: domain of kernel-hardening-return-12063-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12063-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:uniYWoO7jWHGXLo_CTAhpE-nRakFQrtiE0Zx3RbuP9IgBD_eeoRNpA>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] leaking_addresses: check path name for leaks
Date: Fri,  2 Mar 2018 09:03:18 +1100
Message-Id: <1519941800-27710-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593774542845220825?=
X-GMAIL-MSGID: =?utf-8?q?1593774542845220825?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A couple more patches to the leaking_addresses.pl script.  First one is
refactor, does not change program logic.

Patch 2 adds a check on each path name as the scan traverses the
directory tree.  Suggested by Tycho.

thanks,
Tobin.

Tobin C. Harding (2):
  leaking_addresses: explicitly name variable used in regex
  leaking_addresses: check if file name contains address

 scripts/leaking_addresses.pl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.7.4
