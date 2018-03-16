Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521215156-2-7906922101632721651
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215155; b=lmRq5MEF3p5Fe5FlkaicnnEUMHSn9edIrDHpxur2DJAwFbw
    BcjLV0mtoLFsel8xkDOjekNxLS9ZZ+LhfacNRFwZ0yyKUjLT3O3i46KawACmKSqA
    65j+Z5WhkSQqY4c58RBwURyrugjeaqDRdvSMDVPVeLXjHLk6Zzc7qRm7GKzTUIEw
    5N8eq3ULZKD9CTicbR2YE9zOuGvrBFLlaqbnmYFMrVFwoxCbNNRdeaPEdeb+Vtiw
    oUlPNahsYqhA774HhYLwDIDbzIHL8aVf3qE+rwPjKAISl0UZ5gKgwwjsuEGmNb2c
    HjYNRBGAiJQleirFB18z5/r266Gk4D/bpX9qg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215155; bh=zh/zIQpP2VdaB0Hgo/e8gKoky6
    /nZ0zB7zpNKwkzD6A=; b=GbBnLvCnYZMXTfTe0DCCgFZM+uzqQ3/FGe4xcgM6C0
    n7l+9bMttrXJY78+62v3EidBwSri8ZUZB0TsSyD1ANQMxi3JpB7jZzyUVFNgND5S
    NtAYwsuj2PMgSO9f1P6XgOEHZ6VYQR28rmjf5gHLOANHEuDraeDc5sMmAnSd5lVb
    xhw3R/r6kPvO1WSwwger7+hd0/ednidGu4uVm3wlH0FNwIDvDYLi0e8pETvcduyY
    082z3e+820JNCidcgUM+b0xnXMsX3tDJuSBMZ//3i6dqaVQ3oDst4k/LNNMNj5lO
    CjBAfnHFutaf3pNZf36srdutb/ZAtE75l339nZOkY1rQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934524AbeCPPpW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:45:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932967AbeCPPpV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:45:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 123/128] rcutorture/configinit: Fix build directory error message
Date: Fri, 16 Mar 2018 16:24:24 +0100
Message-Id: <20180316152342.555859601@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj38.park@gmail.com>


[ Upstream commit 2adfa4210f8f35cdfb4e08318cc06b99752964c2 ]

The 'configinit.sh' script checks the format of optional argument for the
build directory, printing an error message if the format is not valid.
However, the error message uses the wrong variable, indicating an empty
string even though the user entered a non-empty (but erroneous) string.
This commit fixes the script to use the correct variable.

Fixes: c87b9c601ac8 ("rcutorture: Add KVM-based test framework")

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/rcutorture/bin/configinit.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -51,7 +51,7 @@ then
 			mkdir $builddir
 		fi
 	else
-		echo Bad build directory: \"$builddir\"
+		echo Bad build directory: \"$buildloc\"
 		exit 2
 	fi
 fi
