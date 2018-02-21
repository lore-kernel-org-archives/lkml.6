Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1682629-1519223972-2-10924529432221871271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519223971; b=ct6wX9UxjfbbsJg4atxTR5kJdcROLA9rFq7TUkHJOLDXoRl
    nQbu0u716bDzvmnRCEsfsi8klnrh6ENdaS+Nqi/3vJ3PhTjvnVcVf48Kyt80se4u
    cv9VAi/MAFjanFoOfq8h7ASiDrdjZRCBhJVjm/aHGw9+R7/WuEdAz6ATtmYmezJJ
    lf8goOAgbbWECXIqQlFfEbCA7jKiG7PwcSMzLvCrwJJN6KCYtbpB/0UbVwy8Eik7
    a4p1vnaTHh93AE6I9UPWGZ5PwHqVO8NWYEYXZ1J5HE7PV7I9Z6D28zqYmJEvPaoH
    kVhF/hkCHfFTx3iiHUaCyJlnCHH9sKWuRgg0FFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519223971; bh=HM3pBbIpX8pdNZDK9sUwU+VhMs
    qMCxm/YfY1Y4AZjRI=; b=agRu13xI9L8U+6ubkcM1JHAWcQUQTuBvfFWGnRk7vT
    wYwGSjZJue+DslclPaxhkRt9VJo4+whhjMKd/2Aa/tVaMMiKCHUC+3SPjuTA+iJ4
    QzehO4LGEw3hLd9o6OQirwTwY9AzOKy/vRXyl8w15/rgLIxLRZ7cdDxgqUIeW4AO
    Ly+euvqRfNEmzHgQslSShdiCIvOoChL02s1XpAG/y1X03RRGlswJ0so0GnsynXPN
    li2EeL0yXcuOdxD23TsnIeWtPjfdlBW5Sq+jLHEeQ3WR93oRCnqptPru8Ye+wOUA
    7UTjHCQ+86KqhyBlFnVAwXYPVLEu+IXfPGMAtQP7T0Bg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=K44vHiiF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=K44vHiiF x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937825AbeBUOjN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 09:39:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33511 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934187AbeBUOjM (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 09:39:12 -0500
X-ME-Sender: <xms:j4SNWi_wdB0GBw0gDCKsvQz8JNH8GudAiwP17O17E7nJTNeazAQNLQ>
Date: Wed, 21 Feb 2018 15:39:09 +0100
From: Greg KH <greg@kroah.com>
To: ShuFanLee <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com, linux@roeck-us.net,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] Handle vendor defined behavior in tcpci_init,
 tcpci_set_vconn and export tcpci_irq. More operations can be extended in
 tcpci_data if needed. According to TCPCI specification, 4.4.5.2
 ROLE_CONTROL, TCPC shall not start DRP toggling until subsequently the TCPM
 writes to the COMMAND register to start DRP toggling. DRP toggling flow is
 chagned as following:   - Write DRP = 0 & Rd/Rd   - Write DRP = 1   - Set
 LOOK4CONNECTION command
Message-ID: <20180221143909.GA29620@kroah.com>
References: <1519223434-7396-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519223434-7396-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 10:30:34PM +0800, ShuFanLee wrote:
> From: ShuFanLee <shufan_lee@richtek.com>
> 
> Signed-off-by: ShuFanLee <shufan_lee@richtek.com>

Something went really wrong with your subject line :(

Please fix and try again.

thanks,

greg k-h
