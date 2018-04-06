Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1491530-1523022549-2-10705642952121081497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022549; b=UUyylr+MOi8PMkCWp14gWgraxtULwc+wAGi4t8gipCxj+pIGQ2
    xyQk+pgwVD3OKiNMgzsYJBdicPAUUNImoqGd8UVBpSttzKX4Skx6Gp467KekJb29
    rjwgiMHZ7B+drgT5mYV2c4hbPZgKkAHYgK+pOEEG1xuuCe3C6ecW6YTmuRqHTufa
    ZHE/mJmQ/hvnRoqaSKbgoSDqFYewBz776bdRToBSNktsxodG0VwRgY+8FAncPbyv
    rETl1IundrtYoMf09KdDt6ED7zjYjFKywTiwbsZrPoj8mdPr7+PHnQMzhvzSvzj8
    o/wOjNcEt0+vgFdqPrsLWgHsIQbQfw2fLqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022549; bh=lFHDp9tkQ3VSN3i0jrvfSTiKyLMktg
    /yXqMFICAbpaE=; b=L/U9mQOT6FV4xa8ArgWtLHX/HSnUlI/Jv6Wx8A+6W3KKKK
    4v1Dw2CW0RmuqrhlgO6ant5U4g7Mz8GIAndt/5o0p/U8MgFYB0AitZfmeZDy5/Jl
    yyb4EzmPK7kOpk+SKE6c+fVB/xq4gZ+Wwq1SWvtywk7nRAFiFtLX3ehRJuhuJvkW
    CrVIenGKJkTO6mUpCfU7ugSgpMOnkdes7JZ63oWPAjutiJN90on2Sc5Gx5H+euVN
    Rz7LAIr1wytdenGRAFPmbh9Ht5twQn7+PFGKkO2/M5LIloOiO085ZJ+JUZaq5OBO
    OyAIaQhgNFdm6odQsxHPalveEkClAe88FjPNZOmw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfHCD/z7+ET4Oad/dks6No+jb+DR774OxYDdt2GIqPBO2hrSBpbrHwdJX1+zpocqMiMdKK7K45hJMpwvjIlBnPB6pV+THbvMomzXsO7NqEtWBDR8cs6hj
    qY2Hs5XTSncKIZWvQKj8JUNQb9Wba4lSHMcspFc8qn1IpcrYNT0ACF5EWJ990VZpEE3gmRRswa5zbafkWYEEDo9WRe66jSKuJ5vzY3o56VpLaSF7jmdm3Gek
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=AgaioDkCAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=XbTrpd2YzVd0SMtc9A0A:9 a=QEXdDO2ut3YA:10 a=eNS--96rZ24oWIaEtn_1:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756564AbeDFNpM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:45:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933040AbeDFNpK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Zary <linux@rainbow-software.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.16 28/31] Input: i8042 - enable MUX on Sony VAIO VGN-CS series to fix touchpad
Date: Fri,  6 Apr 2018 15:24:53 +0200
Message-Id: <20180406084344.761649889@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
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

From: Ondrej Zary <linux@rainbow-software.org>

commit 04bb1719c4de94700056241d4c0fe3c1413f5aff upstream.

The touch sensor buttons on Sony VAIO VGN-CS series laptops (e.g.
VGN-CS31S) are a separate PS/2 device. As the MUX is disabled for all
VAIO machines by the nomux blacklist, the data from touch sensor
buttons and touchpad are combined. The protocol used by the buttons is
probably similar to the touchpad protocol (both are Synaptics) so both
devices get enabled. The controller combines the data, creating a mess
which results in random button clicks, touchpad stopping working and
lost sync error messages:
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 4
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse serio1: issuing reconnect request

Add a new i8042_dmi_forcemux_table whitelist with VGN-CS.
With MUX enabled, touch sensor buttons are detected as separate device
(and left disabled as there's currently no driver), fixing all touchpad
problems.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/serio/i8042-x86ia64io.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -530,6 +530,20 @@ static const struct dmi_system_id __init
 	{ }
 };
 
+static const struct dmi_system_id i8042_dmi_forcemux_table[] __initconst = {
+	{
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+	},
+	{ }
+};
+
 /*
  * On some Asus laptops, just running self tests cause problems.
  */
@@ -1170,6 +1184,9 @@ static int __init i8042_platform_init(vo
 	if (dmi_check_system(i8042_dmi_nomux_table))
 		i8042_nomux = true;
 
+	if (dmi_check_system(i8042_dmi_forcemux_table))
+		i8042_nomux = false;
+
 	if (dmi_check_system(i8042_dmi_notimeout_table))
 		i8042_notimeout = true;
 
