Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3293838-1520306259-2-12585420185941206228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520306258; b=MUxHcEQXDkPdthFRavDBK79rnnVGmmcsTlWA74Wl7OJKXH2
    oPiyoePgpImay7/UIiemWUES1zj5cCqwxlGK2melVXnp7M/tAq6ndqGb2cJFy6J8
    RGhQ6oBWiskAKfMI436nmhmRm/G7QEQFOX8VPjhIQZAt98tvYFXb9IcDWirx5SZx
    awO5bTZH6uiP5Bvr0dKSfl/MfkHdYSgP9bKcRnTRNSq3g2obQ32al9EnFDR9LJeh
    9tObgzKqnv5UwanK1q+cgTcXbA3g3Y2gMM7JASxwy3+Q6kx0UAWeejgdPkuwhUzS
    70m230Be8HC9S/YnBLFu1jYkchz2J7eh44dUDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520306258; bh=VQxW/JJGrRe19G+UhDlz0ETq6g6t85LIF+ui06EW0OE=; b=v
    UJHlB86XjUP7CQa30YsZB6hN7ltQZeOBjlf0mFmPig3O06pFAlb6rp1robv86tSw
    5aksSTKkW6b1fylAc4V/QMIFe3BEfBqHDYXHnQjVS4JU/aud/DGn3plrgZ89cwaj
    s/fTmkiHOn/bUkNSd0cmO6DMgRB4YIv57dR1jsv1jHiN6ZhlSoJAyvuC03k7ti++
    YOdwUDPn0Q2R4hLedI4kc8/9WLTBWe+2XjqkOXm55IfRdrLhxv4CcqxPjgV1hHM3
    Fzt2D2I2N8kaWA5tCRqo18ocBFzVHC6DiVChSkF9TU3TJXp0xsNghPBM0XfE2khV
    A8ZdaZk0mLZ1QtINb3b6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeCFDRh (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 22:17:37 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:42786 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeCFDRg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Mar 2018 22:17:36 -0500
Message-ID: <1520306253.2786.121.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 130/193] [media] tc358743: fix register i2c_rd/wr
 functions
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Date: Tue, 06 Mar 2018 03:17:33 +0000
In-Reply-To: <20180223170346.213655459@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
         <20180223170346.213655459@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-23 at 19:26 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> commit 3538aa6ecfb2dd727a40f9ebbbf25a0c2afe6226 upstream.
[...]

This introduces a regression in i2c_wr8_and_or(), fixed upstream by:

commit f2c61f98e0b5f8b53b8fb860e5dcdd661bde7d0b
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu May 4 12:20:17 2017 -0300

    [media] tc358743: fix register i2c_rd/wr function fix

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
