Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838281-2-4250461480841686089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838281; b=g9hV+je+bQb1QpUB/uu8M4KxTgk0jqbb724I0KHuKC9rMxV
    ttnEQiJUiG2JtmuSxwjoejd/54BHnZQX5A4AZ8MlitzVGWwHns44xHJvuNTuUU2Z
    DCcde5gMnW7khmffdIyx/hP2LGDBV7GUB3TDPm5HnOfguWs388uGCx6CZQAAcAz1
    RJov+DhyjmGOT3ebodsZpnC7r77l1AvqY/DpWxToEA1TNpgKn1vEFxk5I5n4d/mG
    Po7wBjh6dNsYm9p+oEZlSEQ3oWCwB8rwtJL9lqxCHNHh/VDkCwOrlAArkiGU7BeP
    DG2TfcWxRwMU1GktQNLtpwtLNJuqet0+yH9m4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:reply-to:to:cc:message-id
    :subject:mime-version:content-type:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1519838281; bh=3o/K8rRL
    7COkQMAmS6Fp95ZHszuFoJFR15Cv+Bgd0Y4=; b=k29k15qruR4EBRzcKFyHdlkt
    Rqz+DUf8AziCV5oMHfFQ2+AXsFjjl6KDiDARMGt/whCwME8sEAT3odECvU2Ff0Jh
    iCIpHgPMpMW/2k0fJqsJV5pSeWyWAEpi+ohR5xPQPz+insZq/iMKlPNP0pLSIXUD
    kcaMQGJHBWnRgZG20zgjR/ZSjr62I8V4YhbGwpXDHTjXwx5jmzBrBowUyqoWePk6
    SIaI+ed8fDxIXnP5JhfO6exisFuFoOFoUQQ2/cZEXvEwK0GDK3mjAQQhhjiFE6jx
    v6tkjffnotrmBXilWhLfLijtKUs58OYBCf/KQwu5qia2CrrMdExVLyT6WAbNvg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=VGJu63Et x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=VGJu63Et x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933203AbeB1RR5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:17:57 -0500
Received: from sonic301-36.consmr.mail.ir2.yahoo.com ([77.238.176.113]:44967
        "EHLO sonic301-36.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932224AbeB1RRy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 12:17:54 -0500
X-YMail-OSG: FUxKzPIVM1kuhB2N_vrci9lqyQ4jS7MuLFuMQUFmBLop5PZuZUP6jxbN_N72nvb
 bg__lV7PM18voQczqv5bWQz1D5QkghyACoanBuaIzTwv84hKW5eclDrUNEOvM2.iNJRZYql.cmEw
 L1dQKhR3sjjIrFgBrcezaVXOoYXYFSQ7kZF5vpiUPBtz25ZEHUTWeBG82bUPw2BmyZPjYbXGeSmD
 h2tlhJR6rdgkCmMMTDsnb3GU6yiPFm12566Mdc6mQuoq9kOI9xLk_kDcdMJAYolx4.rZ3IXKnh_6
 9nFH_VkT.2XbmMtAWffDU_ThgjuqwaA8myqL6kdQ1RzEZbErMkLQRIQVU7zQ7HGtJ0Q6qLYb9oCD
 suGjVwN25MnaGPnKDMYgGf8ov.uN4npSVk4whSmk3vrsyoZu.UDU2W65gkGGr0FTHU4BChRVf.Wq
 5ngw6B_CULzo0cblxdzJUP0LcgSi2x9yscnU1tyvnr2wFSuslXWva2AEEsB9WMfeODlCqRiEqOi6
 CHujudVs-
Date: Wed, 28 Feb 2018 17:17:51 +0000 (UTC)
From: Hin-Tak Leung <htl10@users.sourceforge.net>
Reply-To: Hin-Tak Leung <htl10@users.sourceforge.net>
To: <herton@canonical.com>, <Larry.Finger@lwfinger.net>,
        Sudhir Sreedharan <ssreedharan@mvista.com>
Cc: <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sudhir Sreedharan <ssreedharan@mvista.com>,
        <stable@vger.kernel.org>
Message-ID: <1706696595.11449639.1519838271211@mail.yahoo.com>
Subject: Re: [PATCH] rtl8187: Fix NULL pointer dereference in
 priv->conf_mutex
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1706696595.11449639.1519838271211.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.11419 YahooMailBasic Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36 Edge/16.16299
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--------------------------------------------
On Thu, 15/2/18, Sudhir Sreedharan <ssreedharan@mvista.com> wrote:

...
 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sudhir Sreedharan <ssreedharan@mvista.com>

Acked-by: Hin-Tak Leung <htl10@users.sourceforge.net>
