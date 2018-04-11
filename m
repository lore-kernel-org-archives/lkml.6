Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479378-2-11078215046964411464
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479377; b=K1pm6too4FekoCeBd14I9Lx7ZSyo9rtT0rulfsGJhz5i2hNMLa
    q0xtX63veEvY3sVqio8Kx/xBJHzQf+EGD83oq/5yg0YupHa2LGeH59A4Q7wOqwrG
    pnd/cvmlgrCmqzUx+y3uyQjfNiNHKFNLsuMmnBuVGNR632Syi90WTgp185n9rHdy
    acilhDzVj2ao1mlrHO9bb1OpQpkKNSSu9jK6Ct8AwlqYZRXLHfCXs1gvPlK3z49p
    d2JKgrXVpZmimkWg9mRAB95K0zzi5AOhOEZRKiaQzv7gu1NfeOcOUzBR8zyCC7xl
    AJd9s1MIgAxeumV+1CmwP7DfCHbE6FueaEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479377; bh=s4raexbBpMlmkAdg1RotRzr9+1+G5i
    rT2VakC9KoGLw=; b=cO0zK0D46sBgRKoJRVMxrjPxZ8K+8EAv1rMfMSDJ5ujKAD
    uRmk/YXvzZR6wbHE7bLQc9hW0B3Z/Tu/Ca16yhD1QwBCTgEMwi6QlXaM8QiTeNIE
    36LWWV9d4/qCoaRrjy/1n7YtpodYhdeSTbldW2IHeO5QAlUP0CgHw2rbkGOZO2ut
    Oq419MALyg26sZxgjJq2zhC/TVm8Zk9rcQbVYevbRvAfQpls2iwKxuHGD0Ewv/LV
    NUwYqz8KxE6Cqi7N9g/qUxHTaYqBk7jY+FJ1jh3aJBbpxc3CbHsvqUfj9YT8C31Q
    UCIcdCThdYzMNlvsHt8GqmtLfVHwUq3BuSei+xrA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPEYVILYzZRrlgd4t4Wu6+f8/6LYqybnMzwON0NiHIgnlXatqpq74albPoKPlNQfX95dq142XbbzczQmmT3I8dbwUj8TOGe5+mDGU3l7F3Dcoa85sn0u
    zxk/RyLsxvTGxOS3zC8uN+A9yh1ypSOhUm9/yPNZFXzoVdNqed2eh0oS5JYi2UdPwzXcrlKybIBNu0CtHizYF4UoixUoOEZ2vlBgAOxSQy8tc66FXqbZoV3o
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=EUOQwXsjon1gZHHlxT4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbeDKUmo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:42:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755941AbeDKSrh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 093/190] ASoC: Intel: sst: Fix the return value of sst_send_byte_stream_mrfld()
Date: Wed, 11 Apr 2018 20:35:39 +0200
Message-Id: <20180411183556.036843921@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit eaadb1caa966a91128297b754e90b7c92b350a00 ]

In some error handling paths, an error code is assiegned to 'ret'.
However, the function always return 0.

Fix it and return the error code if such an error paths is taken.

Fixes: 3d9ff34622ba ("ASoC: Intel: sst: add stream operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/atom/sst/sst_stream.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -221,7 +221,7 @@ int sst_send_byte_stream_mrfld(struct in
 		sst_free_block(sst_drv_ctx, block);
 out:
 	test_and_clear_bit(pvt_id, &sst_drv_ctx->pvt_id);
-	return 0;
+	return ret;
 }
 
 /*
