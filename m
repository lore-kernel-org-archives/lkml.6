Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3145149-1518622692-2-12050043336298709049
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518622691; b=B5WZBtd06b8x9/FK16LNyIyAT/szpwX6833adhk5ZViHT96
    vc4AKiwHCYKeqjKaNHiSNrtyYetaF2fiEHV/mtZ5qwNckO4Q5/ZIjMIVgdeo+np3
    QXR1VtUwbJKU8EJ5G0I1m2OsW6Xvcc8+MqwkApsuFMMHYuYPyVUVdS9NKeQ012sc
    3X6J4OWLF2bM5DklQVzjw1ml8T7RDq8zLQPh+B1+xBKWl+eCpLPS78Vj0YNh8008
    QhKnBAuwghmPoIBwombHafIZi2q4+5mf8HAXWfvHa0LUsz055F6dNxvScIds5/no
    DVrWyu9b4yJzLH/fdztDwvxjtmPffNeZBUg69vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518622691; bh=wRE4APt
    nNnNEvGvM2BlT+KHQ888nSySQIjopcxMPjQA=; b=NjDS0SX+QnSCiC0wYABKgc7
    vyloJigDnrCI+RMZeJRgudnkBJ38JxBXCN0qfIRcTYUVt9cbQoz/F//45aDo2Roy
    puX9nao7xnT7TEvdt5KCSKn8bmWUFfIYna6mjIRB7YFxMihgrMCLpk3dDKO68b/H
    RfwjILNBwRt6yjXQl1vsdTw0YLXOa2JccIly9M699qZQsPtRLCRr2O1B8TGilt84
    xNREkvBC+m4gCZsb6D0Cm6Ydy//p6p84B830LUfKf7I/+uUuqhyZR8fBfAZ3xkKr
    NM+fy8EX1ugmoJJqQcUJ5HnuvxVOsiPDBIqRwsu7ADBMgdHmCtIL44MSdZRuU/Q=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vd8zGiaQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vd8zGiaQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kroah.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031577AbeBNPh7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 10:37:59 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34557 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031380AbeBNPh4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Feb 2018 10:37:56 -0500
X-ME-Sender: <xms:01eEWmb34hEWMIBH-kshZ1A6dMPWXmSluYpFSpHktWQTwSd5i0CR0w>
Date: Wed, 14 Feb 2018 16:37:56 +0100
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?5p2O5pu45biG?= <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        cy_huang@richtek.com, shufan_lee@richtek.com
Subject: Re: [PATCH v2] staging: typec: handle vendor defined part and modify
 drp toggling flow
Message-ID: <20180214153756.GA2393@kroah.com>
References: <1518612334-24140-1-git-send-email-leechu729@gmail.com>
 <20180214125720.GB30479@kroah.com>
 <CAFaeLdQkCY5zTZrCLAszqZ5AaJxegGCRhsT9NXNJpEPH+rkeoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFaeLdQkCY5zTZrCLAszqZ5AaJxegGCRhsT9NXNJpEPH+rkeoQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 10:43:45PM +0800, 李書帆 wrote:
> Hi Gerg,
> 
> 
> What changed from v1?
> 
> The diff between v1 and v2 is as following:

<snip>

You need to explain what changed below the --- line, as is described in
Documentation/SubmittingPatches.

Please fix that up, and the text for your name, when you resend
version 3 of this patch.

thanks,

greg k-h
