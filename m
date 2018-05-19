Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-807590-1526705466-2-5644321309108357914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526705465; b=PfcLMZ1re86hBPWKvL+synzwF/Sh5AX9XC180YD0sLOWU9BQJW
    QPufuK/kBVG+d1SyXoc46q+fbX6FondeL3sRTA1UvBeCZAts1H5c9O0Io5a5dgF6
    7vEAoV02/sHRDYrIlSuOZjJMv7A+CyyRZENKikRzjWB6QwLIplCpvQlMyMvopS/Z
    hXk5zHS39CMu23ixfoj8xv+jgM8BOFVLbbmRplA691dtbhIhJ9eBCAoG/qRNsRHd
    JUyZ6vwK0MjTquMBcnmXqO+rmMjSiuLwrBp2ROZzHO1deWk0LxL2a+LvgnWI+4eG
    6ucEZ5FS9GYZpoMl9ikSFjpvZOzfQWL32bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526705465; bh=
    SEbpJGxSwy8BzZPFK1dV99oKMFu1VedmT4RWMLMarRI=; b=e28iwx3B3OUX5a4g
    rwnY80yuPeU3LXxzCeZcu6gkilL6DvJwyCDPQlsjRDBshfd706pocuMeWQdOZGWs
    k0do3rA5sZUjDi3aOSq6lvmsdjJZ6HKhinrIAss2kU/psF5IVPyAFEgJ0YCKtMTb
    Qn/sD8wbyvfIqlMqKCVQOWe1VKquQTAwMVs0XL8YLamcdutXOInDsSHnmVrtc3rF
    nyvuHw+7F73IPPT8/5pRPivh+SbKnOJ0J/cjigOzRJw4VLin/T6QyMUT50RBEfPx
    8HBi+aNJdY8Y8ALSk3O5IZhGetGMCF7FcFvRmuuAeN0OXks1PPrWZ5tk47W9Cxog
    93PZFA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=godking.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=godking.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=godking.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=godking.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEL9AjBFpizhgQxBm2kWuhvUNkmPr70XIgvAR+Gcgt3hPPVyfHX6W75PnhRhFsQE7iGXRhBpb0eK4kMryo/JA3VgIXCg+017eiiixJdtjoJALJQDEXao
    NgdglRJtZKuhkazED32eJLn43WbxM6YekyQ+fRKBmZC/HKKhzZI5NvUNI+dgzqzVQ3qNLeUP+311h2yI+Th5Gs9YGrkDzmP2m6QQtws3o+dYaZ/Irnq9d1Ix
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=5LIarkNwficbJEomSz0A:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750766AbeESEuZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 19 May 2018 00:50:25 -0400
Received: from s18231873.onlinehome-server.info ([217.160.179.168]:42430 "EHLO
        godking.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeESEuY (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 19 May 2018 00:50:24 -0400
From: Alexander Kappner <agk@godking.net>
To: stern@rowland.harvard.edu, oneukum@suse.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, gregkh@linuxfoundation.org,
        Alexander Kappner <agk@godking.net>
Subject: [PATCH v2 0/2] Re: usb-storage: Add quirks to make G-Technology "G-Drive" work
Date: Fri, 18 May 2018 21:50:14 -0700
Message-Id: <1526705416-12573-1-git-send-email-agk@godking.net>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <Pine.LNX.4.44L0.1805181634000.1645-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1805181634000.1645-100000@iolanthe.rowland.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

v2 of this patch implements the FL_ALWAYS_SYNC flag in the UAS driver, and then
adds the flag as quirks for the device at issue. This allows the G-Drive to work
under both UAS and usb-storage.

Alexander Kappner (2):
  [usb-storage] Add support for FL_ALWAYS_SYNC flag in the UAS driver
  [usb-storage] Add compatibility quirk flags for G-Technologies G-Drive

 drivers/usb/storage/uas.c          | 6 ++++++
 drivers/usb/storage/unusual_devs.h | 9 +++++++++
 drivers/usb/storage/unusual_uas.h  | 9 +++++++++
 3 files changed, 24 insertions(+)

-- 
2.1.4

