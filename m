Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519981274-2-5107582821945884093
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981274; b=Bar/rjZTp1awBQ2YfSECt80DMm6QcJWPB8/oHplSVVgq+Ni
    JMTWf1U2U9LtbSsRL3gz+u3vsMLQa7d5OfEc/Nc8L5+8rkO5vsMH5jSGUMMzcmjJ
    l3KKR4sI40C5cXkYTp76iPc4vnkOuu8+2vU7dylY923fbX/w3b+w46jpEcZJvAZO
    3pDLlIj/t+9eoN2yN9Ry+Ypiv4ht8O9wAjVJeosf+y3fzeNfk+h2kPsiqyBk45CM
    QVJVneDvDmsGPD/tHQ5ZXN9kaJZto9Ai2grEdxtaPBvj2vfj+B1LOJYla6G3Clb6
    Ec15oVluCK4CEqoF/VKQ+sYzWY50XG4HAU93EIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981274; bh=NwsISIpHc1GpNQ3Q4Y060/ktGE
    r4MQRMOF+kw/D+OUw=; b=eykGsCX6lAl13RqwDYqs/4yHOvtrzFR2frTHsys3+W
    VBIwZi+f8mxY4AwhTSp2fCPP/fq1Hk2k1ofldShLelu6Fh4vu8S/2m1ESjgiuZwW
    Q8rMrEHHBC8dqjDpkL+nwYeFf/mJL+GbGoXRX5rWJDJhuLatwdLLJVEcQh+Y9Cqy
    90bYapY4yZgCHQ5C0wiSUpyw9fnYd8DmG074q1pAcoZUdHBsMwtmqvmrqjH0vwQ4
    xzfAgW/uYp20q8c/fgFtotZhQ39AZ8foZjL8g/IHm6v0afCn4wNLflmCurzjfYBl
    op+z6Jax+RS3+y/e80ddOqVTehHp66DWdrd89eIaXLTg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424678AbeCBJBK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:01:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:53744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424659AbeCBJBH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:01:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 041/115] ASoC: rsnd: fixup ADG register mask
Date: Fri,  2 Mar 2018 09:50:44 +0100
Message-Id: <20180302084505.546515387@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


[ Upstream commit d5aa24825da5711f8cb829f873160ddf1a29b19c ]

BRGCKR should use 0x80770000, instead of 0x80FF0000.

R-Car Gen2 xxx_TIMSEL should use 0x0F1F,
R-Car Gen3 xxx_TIMSEL should use 0x1F1F.
Here, Gen3 doesn't support AVD, thus, both case can use 0x0F1F.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/adg.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -216,7 +216,7 @@ int rsnd_adg_set_cmd_timsel_gen2(struct
 				   NULL, &val, NULL);
 
 	val  = val	<< shift;
-	mask = 0xffff	<< shift;
+	mask = 0x0f1f	<< shift;
 
 	rsnd_mod_bset(adg_mod, CMDOUT_TIMSEL, mask, val);
 
@@ -244,7 +244,7 @@ int rsnd_adg_set_src_timesel_gen2(struct
 
 	in   = in	<< shift;
 	out  = out	<< shift;
-	mask = 0xffff	<< shift;
+	mask = 0x0f1f	<< shift;
 
 	switch (id / 2) {
 	case 0:
@@ -374,7 +374,7 @@ int rsnd_adg_ssi_clk_try_start(struct rs
 			ckr = 0x80000000;
 	}
 
-	rsnd_mod_bset(adg_mod, BRGCKR, 0x80FF0000, adg->ckr | ckr);
+	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
 	rsnd_mod_write(adg_mod, BRRA,  adg->rbga);
 	rsnd_mod_write(adg_mod, BRRB,  adg->rbgb);
 
