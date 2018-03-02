Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1415877-1519991426-2-13698036455449739403
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519991426; b=hp5GgGPSzYoEviOc209XFtaklyGJN7IWFsAELkebUIKD92i
    LpNnL4AQWj1Z9iVmX3nLNFyd981BrkolyJbXc+7Kj7o9kJiPAV5GPrpXfadKdzRf
    dudU9EGi4fpfOM46jpfophCV2FJKLDFgq9X/icbeASpUC+kz3kNSBdN1t5JSj2aY
    N28nj89cFOYMzVu+2ZI4QWRUPOeDMp6FRXjzAv1eBb71rmARx8K/DnZ5Rt58LkBZ
    Ee03sAsz5/UmsTFyM3GZQY1EmKVoyeaiHM31gAVerZDtOWEiniO3L3jUjI8skGeF
    eVrkvm+vk3ptKpawg3ysKGhKQgsR6A0XLF6300g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519991426; bh=fvoAM/FVDFXt8xOqLPUZixFvQd
    bIhsOBn6FXCPqt+YY=; b=DRgeUb9rYwoXtuZk3LrjYSPvuIfYVGNWPMg5aivySe
    GnH5yKI5iIO6OlJBAyguZrdv5ySObdsk/g82Sf+VmVrrTJSr3dyAIvCdvfCPi+cX
    LL2usUYZiNZKNqSzKeDjmtugbzHjJNPkuSml9JZ8NMYuyPZCJMc20ohdOjZ0F0Ci
    qeHGr9I1GAcu4VcPS5QTeRbc5+uuiu32tGB3cp499x78RUG2oAy1de1j2X8U3lRP
    iL8m8jU5C8AZZuezeONrIr7eyB4fzcBI9nlSoXdPgYFVfZ7u0QSpuIAf3I+hY8Kw
    uxppywjwwY2I6gz8NeiiQPcD0JtbcSl2qWRHWs7+vFeQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=NcReZ1Bh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=NcReZ1Bh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031701AbeCBLuD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:50:03 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58452 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030298AbeCBLt6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 06:49:58 -0500
Date: Fri, 2 Mar 2018 14:49:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302114909.u6kqdszt3aew2io2@mwanda>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302111931.GX9418@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=490
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020138
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 11:19:31AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> > Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> > so do not treat it as an error.  If interrupt 0 was configured, the driver
> > would exit the probe early, before finishing initialization, but with
> > 0-exit status.
> 
> The official position (as stated by Linus) is that interrupt zero is
> not a valid interrupt for peripheral drivers (it may be valid within
> architecture code for things like the x86 PIT, but nothing else.)
> 
> You need to number your platform interrupts from one rather than zero.
> 
> Note that there have been patches proposed to make platform_get_irq()
> return an error rather than returning a value of zero, so changing
> the driver in this way is not a good idea.
> 

Those patches to make platform_get_irq() return error codes were merged
12 years ago in commit 305b3228f9ff ("[PATCH] driver core:
platform_get_irq*(): return -ENXIO on error").

This patch just drops the check for zero which is should be fine.

regards,
dan carpenter
