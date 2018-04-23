Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-773530-1524467295-3-1035975671917119667
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524467294; b=wdb+jkvN7osX39UnBRpfrpzNaKp28RUPFmlyLszpF6PdHLCJb+
    I1iWNsn0bWMjhAET/vu8CZUfx4VeQnqdZbtiM9DgwodJos0yGLwhGBBK7i1aLquT
    JnIf+ELwrZVF4HEE9uxeUYnPNKCEQ3Jg5d31Xl5cCUvVfUTq9vkFyndkwLNimPOY
    Kaw7EpbCfT+Ctlw11Jd3Aw40Yelud6BbLRDPsoQVDvP7IUYf4161lXS6Puw+1YBs
    q0or9gyp2GKvPFkQqEM2dfGXlKjpuqjgObbKDdjg3ttjdhRWK64aMFMj3CnjZrA8
    Hb+ij1GvfUlSsypalOh7QdrjdDbtAAVjsI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524467294; bh=IEzlFQDn5k
    3fb5flqBPwjdIzzlhwGGckYiTFjBhPWhI=; b=Ui/zcF0dL8esl1aBE8Tz2IN7CD
    h50OHkc8u7wo9xlV0M+hrjg3R7pa58gPUpZm0pSxKLWmvr4LdEKhjXLJU2Y0vXIJ
    IWYtAV336685+QpSpt2eGrbQttogHFxsdbx8u49EyxXau/t/w8Xbftl/JewD0xp9
    sBA1dvlQNVuDb56qHBqeDcKndlVaUBqCuXD90l6re9ZzbB2iZxiupceroBbs17s7
    i5Ny78EyijICKbgCWRr5exo1lihLzDxUD1WCcsIK84WxDBpTZA4iEwndJVA9duns
    bGf0B0Eh/NrcsLv+wpQ8Y1q+uyPswTkD4lOQj75FlnTBNUnUPrO4Twn2/B1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lichtvoll.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lichtvoll.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD62Sc9A0j4f4ofmnLNA2Z79s3B/37USicehueA3Q0EpCYokB/+5H+OkfG5btVPDI98wreQj3DKCWxEusGwsPZui8HRx9fynSMzSJla13TJ4BiioZgth
    ZcpYAo7qw/RMQ0IKk7PmXiKFGGVjnqFjZC2uIw89tJ25nNc7N3P3LFAOlMYyNwO8n9OTFlj4EoOYAuTUtJITTxY7P6VRYwAs3lOkecLVFuZkboJ4hd26dsTs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=NwAOTJUJpH8TLHnCH9IA:9 a=CjuIK1q_8ugA:10 a=VxAk22fqlfwA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeDWHH7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 03:07:59 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:36349 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeDWHH6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 03:07:58 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org,
        ming.lei@redhat.com, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
Date: Mon, 23 Apr 2018 09:07:53 +0200
Message-ID: <5447611.bGQfOfz2WP@merkaba>
In-Reply-To: <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com> <2612135.Ur0PZolWSD@merkaba> <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jianchao.

jianchao.wang - 17.04.18, 16:34:
> On 04/17/2018 08:10 PM, Martin Steigerwald wrote:
> > For testing it I add it to 4.16.2 with the patches I have already?
> 
> You could try to only apply this patch to have a test. 

Compiling now to have a test.

Thanks,
-- 
Martin
