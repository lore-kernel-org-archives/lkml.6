Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519416046-2-7254861029435486706
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
    t=1519416046; b=qzmCym6aKr0wHDVnsHB3EdxyguMv4PhFgxVLFAJeoIKd4/e
    R3VoZdYyHVgwcyoEot81ZKhA7FwETAdk//0OQ2YNrbyMkiw4uhtwNtOm1Hvvl8Xj
    50bDSws5pIsn9RnnIpXUpNdeEPHdFAXml8l+R00Hfovf5difCkzolX9fxQfhbCun
    CfTTlaIKNRWPEhAuSE+ksoOS5CPtbEwLDamxd4gwQfeQENrpCvXeYp/WWLiBgDdx
    CxiPlxAHmkJDobJ5phIVDasqPuWlhOX82fhiyUHZv1Pp9uA3NtCTUZkcGBKJ0KR2
    4PW17hj2qRUxKu5t6xo/pKIo/lJMmGO04HHu1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416046; bh=x3rHAr3G8gm/KTaUJzajWx9Ln8
    VDDpeGZr9egKpSVyo=; b=K1ngAltj+9gSYZChKJISeHMkkfJt3ZyYPdNZtBivGe
    KP+DTaE3/4AP04Zzgda5UpuDQVv/YUCHz5jDJfCwVwNZXpxEdA6nupXeGFDBpPtF
    wb4xO9ALTOReA4ps1x/pdDA2RMpDyLLK5iGm7yTXgs+WZNHxsBuPdggrrJry2ho5
    /eJAP3u28cWnpG1QZEfjHRHM0VzyEgNH4ZaOYIrMfPXpp9Us0URaBJmjp5vO45ip
    JI88gGDIXaG2kPxhrxVvgLR3gPoeJwSl/pqKebhJ0QjODkEnIHR6gpmaeFRBYD0r
    VoQ3JMEA8P1wnFKU4LHGgJpQLNP4/nK7dg887RrPnS+Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754882AbeBWUAb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:00:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbeBWSni (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:43:38 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.9 034/145] ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag
Date: Fri, 23 Feb 2018 19:25:40 +0100
Message-Id: <20180223170729.319704101@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit a21b4c10c7bf5b58112afa20d6fa829e8d74e3e6 upstream.

Without this tag, we get a build warning:

WARNING: modpost: missing MODULE_LICENSE() in arch/arm/common/bL_switcher_dummy_if.o

For completeness, I'm also adding author and description fields.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/common/bL_switcher_dummy_if.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm/common/bL_switcher_dummy_if.c
+++ b/arch/arm/common/bL_switcher_dummy_if.c
@@ -57,3 +57,7 @@ static struct miscdevice bL_switcher_dev
 	&bL_switcher_fops
 };
 module_misc_device(bL_switcher_device);
+
+MODULE_AUTHOR("Nicolas Pitre <nico@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("big.LITTLE switcher dummy user interface");
