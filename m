Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1630703-1521030235-2-9358192499170264543
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521030235; b=vFufzumBecOkYDSuj0K9m12PT+vl1xyfPzbnvzYeanoikiQ
    bn7Ly1OReq3oVsJOQ9Hlvjnx/TFOkK+OlvpUtve+K6r3IjYr8E6KBfUex61gNj/5
    NI+CAahwpB/6kcgGcQ/zFWuTbsvm1/7Htqo+YS3L5v6vzq1+Jmc5OPLogjOq8HJR
    HptKR/w3Xi8PedvgVxfxaGsTJCLoIxwVIaP6+OBvjdS+N9iOEEECwDMRO6uyi+Q0
    Dk0XHHwuS/qm8m7wjWFfx+1DfBdGoSomfW2ceUidnzGJT2tBse2FKKELQXCzZse9
    N6thCkg4iVwra8j7DJX33r9DdwiUr3WS3n8xWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521030235; bh=mm1XQb/HPjdv5JIO0rZKyXj95VOoC9B37JWni9lj6hQ=; b=u
    YX9Kfz7e3vbaAX3NxVv1JPiwOJ1LB5VqxRK1+V9niJVODuiieFUvuWna/TlwyL1d
    gCiwON1CecDTcrsVCP410zSqb00RDdEyk3qZqGhAj9+IdJReS0/Z07sgpvAWt+RO
    PxqbnMqTSPFlvbb9VzgAN9REgSx0P22IXlc/UxUdPRuMxx0RDEoLamPjSFl3wecC
    8v9chwQ+dFiWLJW1C6yFF+F/ZjlwM3QBwD+4Cz3am5i6pakG7PF/98NYf+NtTaam
    wook9suKpyiCOPo5AZ6y9JkgOiiqZNv2f8jxIOViuDkl3esKvlMBv8sb5HLD+zYJ
    le9kQ/I0J0siktO04FyuA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeCNMX1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 08:23:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:50978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeCNMX0 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 08:23:26 -0400
Message-ID: <1521029854.4511.12.camel@suse.com>
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
From: Oliver Neukum <oneukum@suse.com>
To: Richard Leitner <dev@g0hl1n.net>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Cc: bhelgaas@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, richard.leitner@skidata.com
Date: Wed, 14 Mar 2018 13:17:34 +0100
In-Reply-To: <20180314102933.21367-3-dev@g0hl1n.net>
References: <20180314102933.21367-1-dev@g0hl1n.net>
         <20180314102933.21367-3-dev@g0hl1n.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Mittwoch, den 14.03.2018, 11:29 +0100 schrieb Richard Leitner:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> pci_ids.h

Hi,

in general, why?
Does this patch generate any benefit for any developer
reading the source? I don't see it. Does it cause an
issue for anybody who has a log file with the nummerical
ID and needs to grep for it? Yes it does.

Where is the point of this patch?

	Regards
		Oliver

