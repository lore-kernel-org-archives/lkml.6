Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-169531-1518787265-2-3349240467456383913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518787264; b=vIPGpmmGQraLIspCBRQe6hfw4PaNYYqCFUZiccMyY0kRz2S
    icCQ3aWCgsQQi1pRRoha0QiZh+Jysj1PpVkLS9M1aB/4rDrc5f5X66ng6JQXXpG5
    9hMLsjN9z4ClovfQNkW5aBTTTtpz9VJTH77I+7rl27DkK2quUTSEnZLi8ec5ht5x
    oU065BR0AlF4o8Twyrmz72Rf8US67qNc1/F4xdICcMgBRJFi8BkEZiXvo3yVt4Pt
    9uTNcc3D0G1SIOyfogk+0yniYzUlGc737VnYyHl9eZZSr/ze+SNj23oOigG9r6F1
    OnxQ7i6jvMmgJz8M1siF53M7jV8iB5Bzyu22RnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518787264; bh=fg7y9getNYeX9K3M0ctoJPQOXG
    5VDrFtWTQHBnyvkWw=; b=rau/uvpxzr3nQsRjAniRWoWEbUQkPUT+SXO53Cie1n
    Ccjz73EzhyjPujq5LGeuZFY7KuLxGuj1DNZ0iZbREaWde8dh7VUAFGgNj65f9OQ5
    6fj+gzQ/qZaC7UcEwfzDslajzzf09ksoZYZ3AQvCEHdLTGI16YG2Njq+FXUCemit
    dMChDxCpFuyMW636fxUSxCWTCory4OZUcKlfXqur7M5JXl2JVfzYn53S/jOXweXO
    Yki0Zz/EWoSlOXLWRIURr4ZU8L/qtNZuDddjTZlaLEhHpjTGGMwQemxj8lV8lMSU
    3ReCrPMgBaDP7O+DpMGA0MOanqftJnr7IbNL7xzpTaBg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030722AbeBPNUt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:20:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:27663 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030435AbeBPNUs (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Feb 2018 08:20:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31363985"
Date: Fri, 16 Feb 2018 15:20:43 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 06/12] usb: typec: tcpm: Use new Type-C switch/mux and
 usb-role-switch functions
Message-ID: <20180216132043.GL1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-7-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:45AM +0100, Hans de Goede wrote:
> Remove the unused (not implemented anywhere) tcpc_mux_dev abstraction
> and replace it with calling the new typec_set_orientation,
> usb_role_switch_set and typec_set_mode functions.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
