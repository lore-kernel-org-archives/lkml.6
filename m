Return-Path: <kernel-hardening-return-11991-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsmmfKBNsn+uuf0DyXWr2VXLHYdDZAEkQoZ2oMo2ANDEpG5tKeVKdh8xICTCHKBwO1CxD8M
ARC-Seal: i=1; a=rsa-sha256; t=1519706768; cv=none;
        d=google.com; s=arc-20160816;
        b=CEcQeY3R8iQTS0o+RM3p07gREQM9pyKIKELbcg+Qf+y0bteF1SeqFk0t34N19mH9n5
         vb/M233FKpanxN9NMkUI2fgtNz0TBx8d184pdiilsNRPpNMYRFm5KrGRNicAEQ0QcGOO
         pS1ejZd2Lp+sxz/wgA7olDvE/fm8s9gZUPA1XBPovvra8codP78Qb6Fwc9RR/Alcvwoj
         dFzcoWSz9oz0R2jfDUYEYOcv9ZwXpV4xR9GUsvZhL2KgBoDA+VvH44hPSt2Jpigm3nz8
         gdcecTg+3//VO4SuA9BstfsNp+qvVWFPC9yVvT1WqQEatNCe6r6pMSpBpUHO3/qcKCJt
         7Shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Df/BYCppCYbwLZVUes3GDJ4qZ88TjcZ1PCorLfbCLm4=;
        b=ukDwY2p5VXe44/aKY7oobLXa7PNm0Jq+4sqJls30E44SskvyMr2jpt3jEKNjyjlyrd
         9Kwk64v/WM4UFLlrQ4/YjQEvYgOdOiAA/zHpt3qi+zz6GL62Bp8i4VGZrBrpMbNWWRS5
         dHlpU2DrE1qD981REiNw5zVE7uqrSpz86W8zbfdGRvXBRjVzV+/bF3QtzqytDuql2TLw
         +jy6Q1qH07WAcwqw7C/seGDlxVCJjy8EYDmA4b6UIFnfWLNo2/AWmU+MsLf3l5ujnvS+
         UGComsX2C1JkdSf6XNXgh8buNJnwyWnKcMXot+//El/lLmL6lJ3SNA/e8HIX0i8wUqum
         uVGg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=oT3jg9lB;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Azh9vWTT;
       spf=pass (google.com: domain of kernel-hardening-return-11991-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11991-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=oT3jg9lB;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Azh9vWTT;
       spf=pass (google.com: domain of kernel-hardening-return-11991-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11991-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:a-KUWggXaDFD4pCR6U7-und6nZ7_OZ3_pTlqeL_RohV6ckFshZqnRg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] leaking_addresses: remove version number
Date: Tue, 27 Feb 2018 15:45:11 +1100
Message-Id: <1519706711-18580-4-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519706711-18580-1-git-send-email-me@tobin.cc>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528045370176343?=
X-GMAIL-MSGID: =?utf-8?q?1593528045370176343?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We have git now, we don't need a version number.  This was originally
added because leaking_addresses.pl shamelessly (and mindlessly) copied
checkpatch.pl

Remove version number from script.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index ac84a164a528..d5d31f3df97e 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -31,7 +31,6 @@ use bigint qw/hex/;
 use feature 'state';
 
 my $P = $0;
-my $V = '0.01';
 
 # Directories to scan.
 my @DIRS = ('/proc', '/sys');
@@ -85,7 +84,6 @@ sub help
 	print << "EOM";
 
 Usage: $P [OPTIONS]
-Version: $V
 
 Options:
 
-- 
2.7.4
