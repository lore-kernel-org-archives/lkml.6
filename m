Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479323-2-14673566334737541839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479323; b=EYACy2lic+f2xEIQNPcOfjsQhVV2N1qIVgXaxFGyZ7i7kPfAUw
    WDNaTRtFAz2oLwEFsSjOaqD6Um3smHmr0JO2XVJEBu8ejeLmpHPhUNra77H7xCN7
    63xGe5IFnrJ4bsIVlrbPRFVIC8V6h3pRCIXef6GHDSPSyEH7kdYDWCPnQx14i+gr
    PKK643kxMPMo2L3PfK9DzZNYaT8B9RJLLs9H24igwOPQFBk0ovqUpqbLIy50fGpV
    VCf6Q1uel3Mr6m6Cyu+yFqxNvDwsxb29j1KgBJSpxZNNNSE6QSp0M0fDmz4Sda7V
    NGoDiJj5C9Qy5X6mit+4KMCrsfcwYAVYPHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479323; bh=quTJdchcjr31B1KBa/54bwm/h/zgRP
    iW5FSVmnvLrPA=; b=rbBLiPfKYl/wyqu2qBoFpsy9Hb8wWvStTP8MGSCoFr4RRB
    Hz3J1RF+ZsNBAz+IjX5ba2AmZee2ChOIQecq2dqV7KGuu/BPYGlIW2nsR6xJ5CkB
    0beKZ2UbGTw3kIHaWh8qFBAF9q1xFCylxi70E9dcHfd7pRQNQOMrNPe8RuJsBH/w
    MuhJaBmw+mEnD1jwburFna7HVoUxzJZZfKY5bF2ra8Ilvj24lnBTdsjFoGr3eq6j
    bKQSOi7S2o+XbI6dgRn62fDPNEafm4Z9Z8596D7QSZCU80Fo2Bd0cEMYW0XmcHQe
    meCgpFxzyfU7wnneTBe2Yn7eM2JenE9kcOLXtnvw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfNWuFR2fzqeIXRfOP7SdqHOYeZHmbHJCBYdi+p/Vnto9ZvzN9tgTtLcSp5uNEeFJ7DbWAjpIM9F5eNcyHMrNWo04BympN02Ka6K51sSbKZpDUq7aX9tn
    Ag2iK732HPQqgduzivIRBhctCu4yyaN2B/p3oQJsR5Az78VMPf4la8wc/6N1+WC6MAwF8b1ABGSYfL2mgeehIYF/Bwxn76jIKkKvdRPqnQMO3XcqnB4kEuzb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=iCkbH6iyzJDqi2tHSMQA:9 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbeDKSro (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755970AbeDKSrm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Firo Yang <firogm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 095/190] hdlcdrv: Fix divide by zero in hdlcdrv_ioctl
Date: Wed, 11 Apr 2018 20:35:41 +0200
Message-Id: <20180411183556.135523359@linuxfoundation.org>
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

From: Firo Yang <firogm@gmail.com>


[ Upstream commit fb3ce90b7d7761b6f7f28f0ff5c456ef6b5229a1 ]

syszkaller fuzzer triggered a divide by zero, when set calibration
through ioctl().

To fix it, test 'bitrate' if it is negative or 0, just return -EINVAL.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Firo Yang <firogm@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hamradio/hdlcdrv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/hamradio/hdlcdrv.c
+++ b/drivers/net/hamradio/hdlcdrv.c
@@ -574,6 +574,8 @@ static int hdlcdrv_ioctl(struct net_devi
 	case HDLCDRVCTL_CALIBRATE:
 		if(!capable(CAP_SYS_RAWIO))
 			return -EPERM;
+		if (s->par.bitrate <= 0)
+			return -EINVAL;
 		if (bi.data.calibrate > INT_MAX / s->par.bitrate)
 			return -EINVAL;
 		s->hdlctx.calibrate = bi.data.calibrate * s->par.bitrate / 16;
