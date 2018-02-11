Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325124-2-451012677237324180
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325124; b=HNC+pyeZqLqmLeSUFatG5AVaswxZBPDcLLwknt1OR5cplB5
    u6AdU4FxDkw7iQxtvDXM5o9xzWjLlaJZo9Kg/Gky+ksBnLE9X1ruQ13xakPjJr76
    nkjBaiN9JnJaBljnlEes/1svHNK+/wjEiMlfFT0zy3IfPSl2kE8CmuCp7Sqk9Rk+
    Cj8qHTtZ1GYTR45KaUMS9SWD/u2lqvmDeXZ8o+8H7Iud2UdT01ESUbV8DQkXetuz
    vJq1y7XhmnGmi6TvQ4rpIU2ffR3HxP40EOa8s52/+9f2a2fn8ntT1lMxcK9n+Avp
    xnKAxXdbXyoc6iVY880MWU41OWxyeb6pRPsLJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325124; bh=0MPQrxRkoigJpJBcxuJ
    5EWS/1+C23T7LG3onfvTwdR4=; b=LWJnwz2qvulShTcOfjfeTbjSxdEyhrc8LOl
    lA00mAMVWQIAuBm4KOAOhXIrr43JBDEbyCo+6bicMi+iT/drKXMzvuLrAPaY+Hoi
    ShzV1I2WEk0ZnfyIJx/ysWs3zLpTij8qd3bXJdWpXntukhEUBpzBtnVA9BgqrVzW
    fgjN1v/ntZ1EmyZ+LNz+bRY4XwroFZS0F2H6XiXPW7vixAx379o+NHN/8F9AikRK
    mBPJUf46FId80cmbHEvdurvlqXf1aiDhptmZLLm9l9cO+2b4B9S6ycZc4i91ZL/W
    D+3f3u1ogcTJs6kff0Rw3AlEffy2sLZqcBZ5FE4LIM5/LKZ9YkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753559AbeBKE6E (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41689 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752791AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Ville =?UTF-8?Q?Syrj=C3=A4l=C3=A4?=" <ville.syrjala@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        "Marek Wilczewski" <mw@3cte.pl>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.213484894@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 014/136] drm/i915/bios: parse DDI ports also for CHV
 for HDMI DDC pin and DP AUX channel
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

commit 348e4058ebf53904e817eec7a1b25327143c2ed2 upstream.

While technically CHV isn't DDI, we do look at the VBT based DDI port
info for HDMI DDC pin and DP AUX channel. (We call these "alternate",
but they're really just something that aren't platform defaults.)

In commit e4ab73a13291 ("drm/i915: Respect alternate_ddc_pin for all DDI
ports") Ville writes, "IIRC there may be CHV system that might actually
need this."

I'm not sure why there couldn't be even more platforms that need this,
but start conservative, and parse the info for CHV in addition to DDI.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=100553
Reported-by: Marek Wilczewski <mw@3cte.pl>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/d0815082cb98487618429b62414854137049b888.1506586821.git.jani.nikula@intel.com
[bwh: Backported to 3.16: IS_CHERRYVIEW() takes a drm_device pointer]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_bios.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -1007,7 +1007,7 @@ static void parse_ddi_ports(struct drm_i
 	struct drm_device *dev = dev_priv->dev;
 	enum port port;
 
-	if (!HAS_DDI(dev))
+	if (!HAS_DDI(dev) && !IS_CHERRYVIEW(dev))
 		return;
 
 	if (!dev_priv->vbt.child_dev_num)
