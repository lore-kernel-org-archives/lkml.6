Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524812298-2-11775127504593778180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524812297; b=jxAKyUzhaYEAzPi/UGYWksoJZfEKbO0ViARRwUDl7w17JOU1jy
    kmTl9fslBseJfpeuirpP6tnvu0flUBv0Sf2rt45ZvVcfNMX8n8HrmkS9F039cbpo
    Wfh8GD3V9xR9jdX10eXp6WqI42WBGFrHqkPVlaD3IIZDmBfafIVJ7XbfWv+jkIQn
    EFnDm+N0KCuG4XdyQrddacb/o9LD4QTvRLtB1z79c44bBi1+GO6o8TsAX5zHBjkJ
    G8vnzyE0YyIGH8GvhYbVo9fRLQ5l0XnBeJDMbMI0wqX+aeE+FIDwgRQJsxxBRKnt
    jL3iT0bQgEVlydeCK2MvaOA7jqHUuMWNlaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524812297; bh=aVhYx
    r7TgPfnAUvr58anDLlZMs/SlJzzJBJQ3XXGE+s=; b=VMhXlSEhZom9UIxOSBEnh
    iHhzkh570RsvYbabgqZK2aFypEbLbEhj3YKfjq2oEWHmeEG6GuYdpxA4R3CTzcaG
    L17/SU/IIadzTgzAqTM2PewX5BOrV6Xnyvuxa8V8Uh1qA7fMGyYV0ce49qctQXyE
    iJkqasasXx2aFreOv+zLcpAu4vkX+xoK5sq0/AgvD+LbrYrColcW5QhtbrzMiqfM
    mQiLPO6uZSPbbFNW6kjznRjbdOyzETbxTaVkxxSfz81vHLZF4U/FFSmnfSUV6Zjr
    CMtYdiCSNCPLvHs+sh13RmVHPM0NyKaoSMwTQZZvCir/GXVZHZfuQQG4Pk2gflSR
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLWvErGAB3aT83nkQQXLFx1Ev0faFRz9Ug+Ln+CgnSncGd/XvdG0yIDXYzF0EfuDuz89KV+xtY5huv6u4cwu+Rc9jkwGxifm3FArey3+gxB1PAsQG9Bv
    GC3cnnWhlA9ba+/dlLYifloxY1c/S1SFgKdpV/Q/VfAeHh+aELUbBnlXGVckCHHnSgRTzD3AKijqAsv+6QAyb2uoOAJ1OYMPNv9qUOIsSEUN2iA+bRMVj3ss
    zSQNyh8fdNfXjI+bVM3jog==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=aAxM56ASt3ejvk7wYzIA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216C5214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org;
 spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 08:58:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Efstratios Gavas <xtrat@elg.io>
Subject: Re: [PATCH] Staging: wlan-ng: prism2sta: fixed indent coding style
 issues.
Message-ID: <20180427065801.GC4361@kroah.com>
References: <958b53ef.AMIAAAYVaKUAAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa4rkQ@mailjet.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <958b53ef.AMIAAAYVaKUAAAAAAAAAAADFWYgAAAASzIYAAAAAAArW7ABa4rkQ@mailjet.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org,
 Thibaut SAUTEREAU <thibaut.sautereau@telecom-sudparis.eu>,
 Aviv Palivoda <palaviv@gmail.com>,
 AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 05:45:07AM +0000, Efstratios Gavas wrote:
> Fixed coding style issues.
> Signed-off-by: Efstratios Gavas <xtrat@elg.io>

We need a blank line before the signed-off-by: line in order to properly
work.

Also, please be much more specific in your changelog text as to what you
are doing here.

And finally, you sent 2 copies of this patch, but no way to tell which
one is the "correct" one.

Please fix this up and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
