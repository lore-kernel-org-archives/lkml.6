Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519411647-2-7545935228874446771
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411647; b=IhRQVM2SJhApGEQtGhVoEIwkQ9bufTUMA/2fulYJ7lnyUh4
    /DkaV2P6053inAz4N9p4JprSBWxZx4owHecHFu+z0xo7slQnFAJTZbXF4MYO63f5
    YZCQi8JaHOU+ChT7cy/s/D5MF7Qc+DKft4aCFyUvlixbeWLsu+op5qP7HElVgULw
    Ot8iZGo3V2NyZF743lynof4pZwZzXvIzS/LSowGHkLh4EwuuNgj6VUNXN541GT4D
    se/lXf09PlmIB3FM80n/g9S2b0+zdEoeARXthczX9RIrAyGISLnPTEjSDVgx4zwQ
    wnFqwLSp2ANgv6a0R56BdVlsz26Afd1aLPq5Xiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411647; bh=9LdlQv02sRROYFdlEI90fdDPPU
    uZkmZaG69srCniS/w=; b=VERd8A2QMs1s6M95k2ktxOju7+3K8bHvfvTlmBnJqm
    kZGY9zQtbsmeKUWfQhn6ZMfWKGGAAUYd8mYcCjFbpCAzNpRD/dnfn9UrmA+N1xIA
    xkj6ENhp/21BMlLjT570cZCB6Z9iI/DKkB+fvM9bTkt5nwJS/bxOMBYqIAOBAtmB
    Hgx5HFZgKqfBR+5N9i2uOWq6whqfT2N4IBeqx5heYgyxiZ6nZ0DlVtw8633LxtIe
    w7F8vg18jxqXWM4A1E6oa5a97/O4CoLkfSSVRtA/L0FdLALXKDDWe208R//ncZBW
    WPmRFTVgw9snPBIehlEYOkOXmothLHxf0jh6WvGxDolw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934143AbeBWSrV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:47:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933842AbeBWSrU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:47:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 085/145] xen: XEN_ACPI_PROCESSOR is Dom0-only
Date: Fri, 23 Feb 2018 19:26:31 +0100
Message-Id: <20180223170735.717835216@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Jan Beulich <JBeulich@suse.com>


[ Upstream commit c4f9d9cb2c29ff04c6b4bb09b72802d8aedfc7cb ]

Add a respective dependency.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -246,7 +246,7 @@ config XEN_ACPI_HOTPLUG_CPU
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
-	depends on XEN && X86 && ACPI_PROCESSOR && CPU_FREQ
+	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
 	default m
 	help
           This ACPI processor uploads Power Management information to the Xen
