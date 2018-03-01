Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2083987-1519889327-2-10615857502559159538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519889327; b=ATk9P8XX24nkQlAQv1JU+1ED8v66hCI0ihMQTj7g6TIpci2
    Nkye7XTEUiwZKVYKKMF2wxV1zLqsB4HDcI7h5R/KdeNKIPkcrts1B4JOfyeYoKB7
    +FXNVAf+5lKhf4SdbxR6oMOwvCVLcnRjhJuYeufUfNuUsNqVSlV5v04V2QG3F8z3
    iWlmwh8KwfJ4HvYUcOII0H9gSrxz0u3+gBKXlfvtpbbqRbYxCsVj1MzjwRLAgWOR
    EWELSzKKACDgF7cQKTmAhVymth5EG4NvvuIEjYzHlBJ57+cSFEISDz8w8+02r0X9
    MN63zEwDFJsl5VK5jPfI+EXhrfMLabQGokWr/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519889327; bh=6iFaru2RyWHhsbbPNw1FRSRVov
    ckJGLZqFkp2ZF2mr4=; b=F2leV6W99fQKKWgFxCNpwoYHa17vWn0Odn/VvGAUBj
    infH19ci5PgNJRRLlrntdMZ+acr1lyDmaqO21/fcjtzstxUUFD/HYjnEYkjRWXjr
    4xxl0cQA4GRr43UrQDOXh/CQW3YcKpjUJdxMg5u1A6ISgwzOwnPyfFI4nJ4qkmgC
    wHV0plnBERHhnWkQF+hTBUnNpVx9t1X2PnJ5bYgyXJdg/oIht71zu0oB+EJVc6p5
    uIyotIU90xGFp/lc5I3b+EWpXeq78AQ6witaIfnyPlkynvUBo0MgtEa2JjtEyA7m
    SaAtn/B9RtsLFtXEAvE8OWGQMbxNHVbYSSwxf4RR9NAw==
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
        id S966458AbeCAH2c (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 02:28:32 -0500
Received: from mga03.intel.com ([134.134.136.65]:14559 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966373AbeCAH2b (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 1 Mar 2018 02:28:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="34585880"
Date: Thu, 1 Mar 2018 09:28:25 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jun Li <jun.li@nxp.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v5 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180301072825.GC5335@kuha.fi.intel.com>
References: <20180228150749.26831-1-hdegoede@redhat.com>
 <20180228150749.26831-2-hdegoede@redhat.com>
 <VI1PR0402MB3917DD93F114873CC736117389C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3917DD93F114873CC736117389C60@VI1PR0402MB3917.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, Mar 01, 2018 at 12:56:57AM +0000, Jun Li wrote:
> > +struct device *device_find_connection(struct device *dev, const char
> > +*con_id) {
> > +	return __device_find_connection(dev, con_id, generic_match, NULL); }
> 
> -       return __device_find_connection(dev, con_id, generic_match, NULL);
> +       return __device_find_connection(dev, con_id, NULL, generic_match);

Good catch!

Thanks,

-- 
heikki
