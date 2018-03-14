Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1645187-1521030349-2-14016736728650336621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521030349; b=os/SGgbmCLXWx8TmWvGa4/JSZAHH/GZF7LPwNfVIHuwH2lM
    6qM+EaToPztCDA7EgyQODtHMLv0kb+MYmxGCQ6PPRdHVuZVdk38Uqedh845CQTNe
    MbX0ev4OTXLJ/ptzh9q8xrI1biF1ppScdLU3IQmH6uIFsDRo0+vg2EArB/c3Ymfr
    T3mtNWuzWm0ApaILchQGss7pJBOqyPkmLwGArVXtRvG8PHTVzDj7+UeCsw0qkLn5
    V6AWJqrNMqS0HJBaOMV2irGAtlvXKh+RDT0Lrq1jPkZx5QJJEy4FWUpZKENFunEh
    1vocVb6q1EdOPv9MZAmC4Hr7sLmuwKF8DpQOD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521030349; bh=imEgIGOL7WyyMR/jZlOmSpwYa3
    s+15ZxtQTTbwKrVTY=; b=b9wKNcAGa4lDyt0iX9uqt1RGwvQWollbRq4RDHzeYF
    2+yW4HWMknbaeXkEUpJw6TANVxJG34PnPiyL/h3BEj5DAf3u35P+QgpxlPsCxBS+
    Jpi8Fpl1vTw81mblLmgdgz6M7JoSVbxZQuxH29MTvLzB2wtGB3Geh78z2LOnN0pV
    Je8njSNFzulcMCnKue99p8GDC47c0JSWSLp1OXQtn8P/c52NyYJ/JutTzxwDjxV0
    wu8WMlkGgIKMNZJOFkzVw++5aAY5e7u5Ze1F4oIBxPqnNnR84o6919QckP3A6ma0
    et7GO3wVUhZrVbaPep1bcxsPzWZcZefwtso0VN6Tpyzg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeCNMZL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 08:25:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38140 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNMZK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 08:25:10 -0400
Date: Wed, 14 Mar 2018 13:25:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v7 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180314122508.GA7672@kroah.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
 <20180312143431.82396-2-heikki.krogerus@linux.intel.com>
 <20180314111605.GA21241@kroah.com>
 <20180314121323.GA10347@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314121323.GA10347@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:13:23PM +0200, Heikki Krogerus wrote:
> > Sorry I missed this the last review cycles.
> 
> Np. I'll prepare v8. This will not affect the other patches, so is it
> enough if I just update this patch? Or do you prefer that I re-send
> the whole series?

Resending the whole series makes it easiest for me, thanks.

greg k-h
