Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472866-2-10199933171433815290
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
    1523472865; b=iB7iksVNTZIcbU++k4liGJu5EUVVKGatggkUXWonCVCU+8g5aR
    rWkSHh1+wfEvoFemxebAPC0Gcqdn8kmOxobBFAaHblFIUb1s+Ie91zYDMzmjYyzU
    UdQef0rpagIl3zLWAbptwM1Ux1r0u1/f93xjNcZvffZzZXQhpArexriEZJwfmGH+
    B8SR3H3U408VmS7fUhaY4egYA9o7/VeGjVW012GbykQtlZqSNOSGRQEuauZX/PFl
    E0BulN8qtHQuJeXZhCtvUHkhsri4En1Fp8+4kysOkxsgvml2b2+EnsEROgF+2w03
    8Eq0Jx3Q2wmp9xCQsvt1u3qqQqoE3b61jZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472865; bh=T7bd3DJDc0dJgciJH5WD8NT07t59la
    ZqLr57Towtzds=; b=TF7X6OtqAXwsgBbhYn2xGDJPH++Kx2mR/1BznbOR43G5GM
    CaA6cYrHjroTGN0JDRea51xnLXtac1gyJTbcmV/0hlEsBeJNe8Pp02LUSg/BbKqT
    LmYjB6lJs4vOYRnXs6DSEY9egJdPf9hLI0uP5WIcn7Qz6vDn0HUYi9PaJCVJVXHk
    YJqeZ1klTW/GoQ0mlppOv0YyGTnhsWoHKCj8mKWAvUJuoC8zvjS5Xx0TRztXEjOg
    PXc3RmNMHeqlZq4bZU5RJ79eWxjEn6Hhe669ZKFBW4R/K0W6OmzHDuhcixRIiSx2
    444za1/zyNr0HlMHiKevgEJZEzvdALKOaNXBDHEg==
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
X-CM-Envelope: MS4wfPLcsjx+LoARP/lGhQAmOxZBQUmsHk/bKIMQHYIO9JJpGtkY2HPvsnbds36jJRACIpBTyDZG8H0dhgoIbyqPicYDawWK9MkuDctXA4eixub0qCb1JurH
    wRl3CuB6EdoR6H5cz2eQ2pjh3OPLIntrkx6EPa0L39NrgTSOdOhwyvmXtulTah5107/CZsOv8UNlbZmhz/sjI6h/wY0wR0ap0HkeX5h4l+0yR6DMvWAsQRaM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=e4JcQNwn_gKbhmeX78YA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbeDKSyW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34420 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933457AbeDKSyR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 042/310] PowerCap: Fix an error code in powercap_register_zone()
Date: Wed, 11 Apr 2018 20:33:01 +0200
Message-Id: <20180411183624.080219352@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 216c4e9db4c9d1d2a382b42880442dc632cd47d9 ]

In the current code we accidentally return the successful result from
idr_alloc() instead of a negative error pointer.  The caller is looking
for an error pointer and so it treats the returned value as a valid
pointer.

This one might be a bit serious because if it lets people get around the
kernel's protection for remapping NULL.  I'm not sure.

Fixes: 75d2364ea0ca (PowerCap: Add class driver)
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/powercap/powercap_sys.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -538,6 +538,7 @@ struct powercap_zone *powercap_register_
 
 	power_zone->id = result;
 	idr_init(&power_zone->idr);
+	result = -ENOMEM;
 	power_zone->name = kstrdup(name, GFP_KERNEL);
 	if (!power_zone->name)
 		goto err_name_alloc;
