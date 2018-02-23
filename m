Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414863-2-8172012645612685154
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
    t=1519414862; b=N8IkWiIj14+5aQSLh2kB47V/sRMWLoIlKX0QoakA8tZUl3x
    HeNnBEkdlPrBUfG3R0uNFGCRplchYv2Rea/261siSXhyIYbNtSsQhQ4ZtXWkkvZj
    OmqTFFVS4N/94Blm3+wxRNdEIPvH+ZNmGeq6alDPWdg8VPrJGtFSzXrimIQ6cFzt
    4Aj3cWr8/ocGQ5zbssvHZuk1P4UbdDmbsgic2QLj3o/JXgy6B0lR783wB88fZfjv
    qqJHvAuBronUTjaPjm7GGjTWMXAhGHi708aXTI/0b95Q6n5gqisLEscyOwadMKo9
    l6OduTkAoHWPoVl9nzkVhFWkeHw2JgdIxlTk7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414862; bh=ZLHlBkPX3vH2jBkN8KIacoHTRZ
    j8/Gh9ufbPEcbyCh0=; b=bB/ErA983opOxrrHKDrcNSNSeB3wFkgqXlkkasQWXP
    /q7fINu3FFk1TlolJ8hhxx4JBQyVcg9a+YjI4Nwi39ZcU3flnsOonI5ZBv76BLuB
    Blsog+Z8YShy/ieDyaxTe6zzC67nzcczKFKhszp+5p49NPjeS8FD2mHBfJ+lLdKH
    x+78lETeItx5PZM7eadIL1SHX+6tTctKU7t0QW2As51zaOO2x05cpKqzYQR2cJNU
    vwL8b0RxaDM8FDFOJgw2CoAXvd4HzK4zcsMfpyHbCIbR3K12r6lnvohtliOwnDE4
    wYhclTJE1omFbyaPwwgL25rjy/MtCXHOd2i2pttNOjZw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934507AbeBWStU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934483AbeBWStS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 4.9 121/145] drm: exynos: mark pm functions as __maybe_unused
Date: Fri, 23 Feb 2018 19:27:07 +0100
Message-Id: <20180223170740.469982248@linuxfoundation.org>
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

commit 7e1751001818209b214b8c3df0b3c91fae250ea2 upstream.

The rework of the exynos DRM clock handling introduced
warnings for configurations that have CONFIG_PM disabled:

drivers/gpu/drm/exynos/exynos_hdmi.c:736:13: error: 'hdmi_clk_disable_gates' defined but not used [-Werror=unused-function]
 static void hdmi_clk_disable_gates(struct hdmi_context *hdata)
             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/exynos/exynos_hdmi.c:717:12: error: 'hdmi_clk_enable_gates' defined but not used [-Werror=unused-function]
 static int hdmi_clk_enable_gates(struct hdmi_context *hdata)

The problem is that the PM functions themselves are inside of
an #ifdef, but some functions they call are not.

This patch removes the #ifdef and instead marks the PM functions
as __maybe_unused, which is a more reliable way to get it right.

Link: https://patchwork.kernel.org/patch/8436281/
Fixes: 9be7e9898444 ("drm/exynos/hdmi: clock code re-factoring")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/exynos/exynos_hdmi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1939,8 +1939,7 @@ static int hdmi_remove(struct platform_d
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int exynos_hdmi_suspend(struct device *dev)
+static int __maybe_unused exynos_hdmi_suspend(struct device *dev)
 {
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 
@@ -1949,7 +1948,7 @@ static int exynos_hdmi_suspend(struct de
 	return 0;
 }
 
-static int exynos_hdmi_resume(struct device *dev)
+static int __maybe_unused exynos_hdmi_resume(struct device *dev)
 {
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 	int ret;
@@ -1960,7 +1959,6 @@ static int exynos_hdmi_resume(struct dev
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops exynos_hdmi_pm_ops = {
 	SET_RUNTIME_PM_OPS(exynos_hdmi_suspend, exynos_hdmi_resume, NULL)
