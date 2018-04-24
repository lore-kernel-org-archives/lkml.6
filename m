Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2386324-1524550968-5-1109292531982580229
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524550968; b=U9KvnRTOdZoy/crW0FbcVSEK2V5kf4x2pkuipgfLXSRt60GpMt
    A+nlwE+YR3Al3QYl7edhaEJDtQkmUgIyHDjJsJ0saE49SH0kKt0Lp6IK6hOFF7vc
    hfQUJzjfYVzIPU25GE8PKSk8rFQISKkzK7W6TCLjatmhoOfeG4AdKwOEPguirICE
    vLx7qqCU4KV/ZeMuPRzQU82RClg+4spUsEmo+K2Jilii493H1LTYWdhUE1OjuISM
    2qQsxzlpDbspWmrIXnaxuQ0w0kSkK1Cp3vakwA/zjVJdVYB2e0cPSRMQWgGbHC55
    6vU1ylYFtK4kTFck5X6z2MuEziU2tC3jPLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524550968; bh=mqC2gLGsNB0Gg5HhCWXjv5ruws06XZ
    hOJm//BiM8DCI=; b=q5C+QN5z5zA6vKnPcrMoDLfVszoXb7CKyO0PqMic8kv7nx
    aiqJdTrT+1e2lmOUOu+W8gBvL1LuMcWwNLRewZS3sn7S7lofDOGXxsaJ0s+UUFCy
    Q9Q1jgqcAusk1qfVy2eUH0pbI7lr4+3qylFnTgN2lrJYY762V7ddOjgyrSEgY0tI
    cepnql3nJu7HyOpOymHDtKSSykbeG+v9EjMtrc3dAe7DuGPyO5sEzxx4bEqvkCcZ
    RsGzXy9D/Ii9ab0JM+MFqW3vYMkzazhsFbN/m3L3mXYUmz4wOn3HISgGZAwKaDee
    0NEKXtv+iBFpHYS4XlzAYeavGNCLJFUqDjuYKy6w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBM683CHD51DT+pnn5Ki4//sTrf88VvxANH1QT1m6dxwczNRXoIpnfxmWZd9uTue1BspazdaPWZND5zXN0RnJ2GWpLrEz0WeaVtvm0Z123k6wQ+3It3z
    9OC/jl578QuYRdJfkLRAvBR003U9q3swchNasj6Sz/C/YX4sUvwF5dACyb0gxCYZC2WCDP7L9//k8UlwVDEWdGSW6LF2+yCVMyWAaFfihvLeFb5OzvTgLWma
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=QUsSQQSK_aF0ayfbGqIA:9
    a=V4kT2iFRPP0ZhHbm:21 a=ZpyNOLgypH183hjL:21 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
    a=AjGcO6oz07-iQ99wixmX:22 a=d3PnA9EDa4IxuAV0gXij:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756367AbeDXGWp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 02:22:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756360AbeDXGWo (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 02:22:44 -0400
Date: Tue, 24 Apr 2018 08:22:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xswang@marvell.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        oferh@marvell.com, dingwei@marvell.com, xigu@marvell.com,
        nadavh@marvell.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] libahci: Allow drivers to override stop_engine
Message-ID: <20180424062236.GA14537@kroah.com>
References: <1524542805-11349-1-git-send-email-xswang@marvell.com>
 <1524542805-11349-2-git-send-email-xswang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524542805-11349-2-git-send-email-xswang@marvell.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 12:06:44PM +0800, xswang@marvell.com wrote:
> From: Evan Wang <xswang@marvell.com>
> 
> Marvell armada37xx, armada7k and armada8k share the same
> AHCI sata controller IP, and currently there is an issue
> (Errata Ref#226)that the SATA can not be detected via SATA
> Port-MultiPlayer(PMP). After debugging, the reason is
> found that the value of Port-x FIS-based Switching Control
> (PxFBS@0x40) became wrong.
> According to design, the bits[11:8, 0] of register PxFBS
> are cleared when Port Command and Status (0x18) bit[0]
> changes its value from 1 to 0, i.e. falling edge of Port
> Command and Status bit[0] sends PULSE that resets PxFBS
> bits[11:8; 0].
> So it needs save the port PxFBS register before PxCMD
> ST write and restore the port PxFBS register afterwards
> in ahci_stop_engine().
> 
> This commit allows drivers to override ahci_stop_engine
> behavior for use by the Marvell AHCI driver(and potentially
> other drivers in the future).
> 
> Signed-off-by: Evan Wang <xswang@marvell.com>
> Suggested-by: Ofer Heifetz <oferh@marvell.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/ata/ahci.c          |  6 +++---
>  drivers/ata/ahci.h          |  7 +++++++
>  drivers/ata/ahci_qoriq.c    |  2 +-
>  drivers/ata/ahci_xgene.c    |  4 ++--
>  drivers/ata/libahci.c       | 20 ++++++++++++--------
>  drivers/ata/sata_highbank.c |  2 +-
>  6 files changed, 26 insertions(+), 15 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
