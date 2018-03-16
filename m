Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221510-5-11297922053825271880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221509; b=K9bQMn3+SRCed4AaSuJEkMgyI8KIeQwNAE03g6Mztjk9eth
    USjjAepe6h9Fleon4JdqM26p51IJuWtMx0o/iHKSF7b68SIUxV1zDUJbzbp0kPla
    GGaBt33/WEctnAMImNSJiZZl/2omA4x0/gmoXS8nKEtpxODlmXpWqBN2np1t0lKQ
    mgnD2xWfbxpB4LItGQalTYFivcubn9HKoA1wd6oiX7q1rxUZWw0xWH/fJ5CkcarR
    zrWnO8+XqYrZCdtH+gC8QfzLvK012NDVkhrFpsS3zmCj6VHOrEKU16q9k86Tbvlb
    btm+sD6vBndXnu1e9YNZX9k+fHx1xkhpytjQcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221509; bh=yMwwu0rRneUVD2l80RC9ZjMbrQ
    Xz+3O7sPVujT1BMs8=; b=h8gLy8YYHqh1ue6NMunKT3ScX8OZzfBTe34dhAIrNx
    wu6eUQI3wvyQGhaDqpVU+MagV2LWeWeWdDtmglXfBf0zDpVR9adzWnSsoxyg5KG/
    Vz3MrT25h1Xamd1cvrvvGqpfk3BPoVV0xTX0EsP8jHnG6kF36shlG9pmhzzT0yzm
    BNZloIzFwGDsJVPxmVrUyD2vhgJT/uyNQgpXK6mCVWg0TRlHnzlgGfLSvWYFLgm8
    gYAlTeZwYeWs70grXTMlLFluwTWNEGFX9INXqWYhtjC84P/1i2QvqDBX8l2Ec4iX
    wC8oDzpPktG2EaJKjSqjHB9IrBSRFaykQwrtHdlTWcxw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeCPP1m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:27:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeCPP1l (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.4 27/63] watchdog: hpwdt: SMBIOS check
Date: Fri, 16 Mar 2018 16:22:59 +0100
Message-Id: <20180316152303.057655220@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerry Hoemann <jerry.hoemann@hpe.com>

commit c42cbe41727a138905a28f8e0b00c147be77ee93 upstream.

This corrects:
commit cce78da76601 ("watchdog: hpwdt: Add check for UEFI bits")

The test on HPE SMBIOS extension type 219 record "Misc Features"
bits for UEFI support is incorrect.  The definition of the Misc Features
bits in the HPE SMBIOS OEM Extensions specification (and related
firmware) was changed to use a different pair of bits to
represent UEFI supported.  Howerver, a corresponding change
to Linux was missed.

Current code/platform work because the iCRU test is working.
But purpose of cce78da766 is to ensure correct functionality
on future systems where iCRU isn't supported.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/hpwdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -700,7 +700,7 @@ static void dmi_find_icru(const struct d
 		smbios_proliant_ptr = (struct smbios_proliant_info *) dm;
 		if (smbios_proliant_ptr->misc_features & 0x01)
 			is_icru = 1;
-		if (smbios_proliant_ptr->misc_features & 0x408)
+		if (smbios_proliant_ptr->misc_features & 0x1400)
 			is_uefi = 1;
 	}
 }
