Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805246-2-3123046922233864176
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
    t=1521805245; b=teHoL7CHFI8/BwCCicsKqSlGB5xmTqV95cH06uACiUjKjdb
    mejbGm51P0CO9KwS//kYRyTu3VTo2SSADYQAvbRKMtnVBW4VUFk+tYhb5IqnA3Gh
    bCq3GgFIC9VV4hI4PJy1o1pxQi7cu5RpPDx7ioEBGhVMH2XA6W8s3MxAxPF6JEm4
    NDLqXM0GsMcO/UZyE0y9LqP4vq+gkrJKiU00oFa7CbaDQGZF9h09I8qnoWL5uiR7
    n4WkmoNcumpGdYyA6Akmq4EwTbaaK4mY/EtOePcCFS4Tz1CbUUMJZlNBvHn1V/qd
    MdKKj7kmHJ/y9KLxpAV/xl/Q8Iv44eC7zBWtjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805245; bh=9+Qj83Rdbw8vsH6VZbZnqnLJkV
    fhrOGgPL4NPzFWAJo=; b=Ef46xvFSaugCGhoVnk5r9Egta3V17z3z+VBGnRpRuT
    KDjsE5s8l/NwWbs8n01t1r0L3wbl9cyrhiX5kGG9sBLVO81z/SHp6eQLs88dQqgt
    CBFJFwWPTSYfkvbjIDVB+reFqyAeTj8s/HTwnxHl9pYjg/BGwovcyW6d5DzoZM/p
    hnf7RIvxLWosDjGwTPFeNip7bovb4iuB3ISx/IWGNmYKUKvxWHsMN/7JgodVUZqJ
    mfQv2htFeOCuBLHpLh9Pzjl+WLI4G6RARnRI5vltZ0Ak6+Bzf6dTuVe7g3klneS2
    n3Jg41v4oSyboQdfX7iXtncGJRpOUfqiimF4PFKkLdsw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754647AbeCWKEM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbeCWKEK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 002/177] ASoC: rsnd: check src mod pointer for rsnd_mod_id()
Date: Fri, 23 Mar 2018 10:52:10 +0100
Message-Id: <20180323094205.251276543@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 374503c6109e60f48fa9b11341b14466f07bd3f4 upstream.

Without this patch, gcc 4.9.x says

    sound/soc/sh/rcar/cmd.c: In function 'rsnd_cmd_init':
    sound/soc/sh/rcar/cmd.c:85:14: warning: array subscript is below array\
	bounds [-Warray-bounds]
	data = path[rsnd_mod_id(src)] |

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/sh/rcar/cmd.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -82,6 +82,9 @@ static int rsnd_cmd_init(struct rsnd_mod
 			[9] = 0x2,
 		};
 
+		if (unlikely(!src))
+			return -EIO;
+
 		data = path[rsnd_mod_id(src)] |
 			cmd_case[rsnd_mod_id(src)] << 16;
 	}
