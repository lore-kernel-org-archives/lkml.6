Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981077-2-6152995222582989508
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523981077; b=LzCCr9jc07LhOoGvwPfKX1Gv41eCJIDKxQVf/iNLwgdzMORLmL
    4NGEsERaS2KDNqGBrEqtE/S5ecHlg0guOZhUoYG6A3kzUSvjt/A1qYQA91BUkYF6
    nZwmroMQKL2+4TbLoTEpD9TQmbaAPEvESKiaHSdZ8Zw83K2kpVxePE/KdTlwmbYj
    ccrDY5VI+pHfTH6ob5HGP7bnyA01TE/JuLmkmWxo4NVuJ+4C+uQX5cnfvV3S7zOq
    LAQb6zWe0YUAqxZOMhAL6AdGgzVv6EZknFyTmtIq9YsjtY2di7eSbdVGSHNrqQL7
    /Zl2phX++pRrVkwOsn8LMpFvlj4tD236mW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981077; bh=lz0HrZPNY2Q0yXjI1lGneforxefSuv
    YDEloGI8p/mio=; b=f0p5JC0KbbFJ80BGpWrk27NF45NUBoPmTLHyfMGKWUI1Ao
    SUaNDxY0JioMmsfcdjoqtHOUug4PlNgrPIXgPtaXv/4ps8nvlJSwq84kqIs6FBAx
    sKip6RCsGEi66cmU6FmUcuHuFDQSsJCVMHH07ma/hyyb1ORVQ+UoKglLF4fZoSTY
    v+CGSDULQ8NbXXXsFqlTIqezttvmterER2Cyhz5j+uPbv56bW6qId+5+je9LaGQ4
    Tvidanqb2IFzjascLmJ0A3CzrVV5Jw+xI55hmqCkLi5eUDHNa4r4S+uW3F5ws/sf
    H/isyNFrsSSMA64nWDct8UD4MCoFpPVZhR+oIQZw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfNGDtxl37turIoLaWMrUog2ClLXXY/u2Ka9cs3o3z5rVDEPDh6RBnk5drMl5xYQz5euIfzSPege1FAAmrmonyp/6yxjvBwgpddVwxNAcgGMl59MAwryS
    8DoOjPj3bKyuaIh831zWpTrgunT8bEUS7EjR1zpEJiAEiD1DmdSuzrx+OCwm4oCZh/+fJ9wWEl+lRnM51gFsl1K6PX9jshe1mOAKIEAKWazKL4Wjw3PsDRJ6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=YuMdhhXDAAAA:8 a=VwQbUJbxAAAA:8 a=CbDCq_QkAAAA:8
    a=ag1SF4gXAAAA:8 a=qpNe5W0X0CwpowSjBJIA:9 a=QEXdDO2ut3YA:10
    a=krT1t2N6f9LSFQZJgkPp:22 a=AjGcO6oz07-iQ99wixmX:22 a=1qrBK16LubpBFNPVNq2M:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeDQQEM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:04:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeDQQEK (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:04:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Gagniuc <Alex_Gagniuc@Dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 29/53] nvme: Skip checking heads without namespaces
Date: Tue, 17 Apr 2018 17:58:54 +0200
Message-Id: <20180417155724.573672858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 2079699c10c8c60a9572540c2f77d045abf036eb upstream.

If a task is holding a reference to a namespace on a removed controller,
the head will not be released. If the same controller is added again
later, its namespaces may not be successfully added. Instead, the user
will see kernel message "Duplicate IDs for nsid <X>".

This patch fixes that by skipping heads that don't have namespaces when
considering if a new namespace is safe to add.

Reported-by: Alex Gagniuc <Alex_Gagniuc@Dellteam.com>
Cc: stable@vger.kernel.org
Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2720,6 +2720,7 @@ static int __nvme_check_ids(struct nvme_
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
 		if (nvme_ns_ids_valid(&new->ids) &&
+		    !list_empty(&h->list) &&
 		    nvme_ns_ids_equal(&new->ids, &h->ids))
 			return -EINVAL;
 	}
