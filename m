Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585387-1524656149-2-14749921872300515256
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
    1524656149; b=qc3W0N9jKvALqs0/M4jk0I9zXjrULWJ22ZEx/aTcS66/HA1t6l
    T7URCl2zoYJusoI8z8iH2h55pIScMwUOnsk5319AAkLd9cyLONutF5mryxgeYq1Y
    jQiGRuXBbd6+Mr3GVmexammXP+cNpejmUNViG3hr/yPO+zgHCq2/JZFIe/lHLy/2
    2z0rlXkpWpJ1xoSf5Bf2zNVVZp6rsOcilh3f8JfAnQnEQAYd+1jQ3TVXHgstZ9Fn
    Eij5kt1kUSmuD9L5b1rfUb1kSjj3DBw7QNR52Cq4LnbyA6jHqR94XSELiazKw0Gr
    kAIAam/+mee4Res+M399LbCAtGrk9igypKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524656149; bh=O8tWBf0KTJ/OBDHXSGLlYbH/VnJ1Xn
    LXuHdGF4IwKOw=; b=fqKuEuyGTij7lZEES6AO54zd//+Tz2jwecNsIksVfov5Ex
    AShO3azRivsBCQ9dQzbtiOqtu79vrOtFv0iOtLZ9fT1qxT5ixhDuSWhVlN+c+7OA
    ZSo+eznb1bMeCTe2+PSuxUG3LOZUpoQPqFT5xwHqbKIBlfK93Z1nFt0BwVoHJDnU
    yWSTOzEDlm2fEg8lOixMrqR7egrXWQNFPz0WcD7qEw+rRTgum9LLvMJeo0YTDFfK
    rUNAPp2VLL5ou9iONVI4lvI4bn7s9iQ6lhmDpvuZ2YQNQ8ikl+AB2UM0i03OBUCr
    YHHnxjhx96zlB24gI0qnzKYCTCrRYAcOJLSj5tiA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfDP5HQCW84CIK9/C02zNiu0tAnpULh8FiRw1AiWwlm3UdUPSeUhdMRLEU14i1zz8AgXGmomueID8SLWWxV+3V5M4bLaTScPdf/xL4Ylw3dTYA9ZqzO2M
    8pqMEhXR/77pH0dpmVX3vaAH51ugO4bd6BI8q76elyFmOZjmNVVkIfaP8VuSitVcdwXHNA97Vh6zvklGZuT9XPcFBVO31j0q/xXV6zmsLhxhDjGrs8yQFyW1
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=ag1SF4gXAAAA:8
    a=XpdkUprsQGsbtyAbTgAA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Vxmtnl_E_bksehYqCbjh:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbeDYLfo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:35:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeDYKeC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav K Singh <gaurav.k.singh@intel.com>,
        Abhay Kumar <abhay.Kumar@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.16 13/26] drm/i915/audio: Fix audio detection issue on GLK
Date: Wed, 25 Apr 2018 12:33:22 +0200
Message-Id: <20180425103315.374964303@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav K Singh <gaurav.k.singh@intel.com>

commit b4615730530be85fc45ab4631c2ad6d8e2d0b97d upstream.

On Geminilake, sometimes audio card is not getting
detected after reboot. This is a spurious issue happening on
Geminilake. HW codec and HD audio controller link was going
out of sync for which there was a fix in i915 driver but
was not getting invoked for GLK. Extending this fix to GLK as well.

Tested by Du,Wenkai on GLK board.

Bspec: 21829

v2: Instead of checking GEN9_BC, BXT and GLK macros, use IS_GEN9 macro (Jani N)

Cc: <stable@vger.kernel.org> # b651bd2a3ae3 ("drm/i915/audio: Fix audio enumeration issue on BXT")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gaurav K Singh <gaurav.k.singh@intel.com>
Reviewed-by: Abhay Kumar <abhay.Kumar@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1523989338-29677-1-git-send-email-gaurav.k.singh@intel.com
(cherry picked from commit 8221229046e862977ae93ec9d34aa583fbd10397)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_audio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -729,7 +729,7 @@ static void i915_audio_component_codec_w
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	u32 tmp;
 
-	if (!IS_GEN9_BC(dev_priv))
+	if (!IS_GEN9(dev_priv))
 		return;
 
 	i915_audio_component_get_power(kdev);
