Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021787-2-14719878957870331207
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
    1523021785; b=CR77cwiomBKWqkRRF97aZtS+wgTM6MfZewKPwHeSNGXCQPI9MJ
    7udSwzlnJRIDXyomTMPbWBEG21CDur9c7ind7o+JFaFapBBBVFHQ4j1tM6rTsp0W
    KQ8biZhu5858OVci2nVmUuBqsqSXnfZBOjP+hR9eJqCzIpelF38xmXO4wDtLfhfd
    XAcALTmlKThny4vtXaQqZq9ydHqBHVttrLEI6qzf6LJmdPzBhq7nW/KqIFVmSCPI
    MNy3FVI/R0Se95dSrnw5dMFj3Cx67eHgoY4oGhW5CFedc4XQu9YR/PSDWPh4Wo8r
    456AB4X5qKd2LaeoUhr35ni7Ln9+5P/HXbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021785; bh=jYSCqGiTE43XzNfCXUvubwBYzVyYNV
    WBKo2P1EAqJBE=; b=cRlRYnDwDLRIvX6Cwwm4mJnOXCI0jmJewKW2YSZ/u9N2UI
    xqAIOX0KiQUsbta9DGFNi7q8dKCPR1wP6+crKa8mL3CmpaQ+fY58wVbQ/b47WOre
    m2/T0aLAp1Nq5S4wvNVOt+XO59i8S4VUeovU+e4mjjzqkUf9TnPAubGqI5r2mTJg
    KpBd4k5b+uLWosQ1lC4B69MarWmj7TDUtYqpUC2+NV/k9fWc9yqKTpornULykHJP
    htQypPdzmp3xcDfo7CpgtB1gjzaq0WuQrlgWmqaV6Xe1a2PE2EI9DeRrDx/kVC32
    4ItesbZ+mWjsBU43pR5NhLGIJrm0Kw/5V5ePWNKw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCojCcLmWfVojSSVpvlKX6iPN7FJW61CxX+AQ9AM0bw3DTAAs54CuU6etdJG7SU9bRkJ7+2Mwl4i44p0fax7FR2q6rq8nLS0WsDDw1ZrwgXi718/XMC6
    +UWL1273AVLsa9EVC/em06zF2oXK0q61tKXaDVpwKAkV+w44G0N0bSGa6XISnGDRQ1yzbxCL98wVm23iZnlx9NNqLADUbLp6j7a9Cq6U10CidVjRXZTOaBmc
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CEwII1yZAAAA:8 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8 a=pGLkceISAAAA:8
    a=ag1SF4gXAAAA:8 a=stH8ADgi9cZ-LRKY-tsA:9 a=yuHOFG3mZbVzFQdN:21
    a=rtsw3k8JSiEtAB11:21 a=QEXdDO2ut3YA:10 a=4LuAaoAPjBjBTe8K2uIj:22
    a=AjGcO6oz07-iQ99wixmX:22 a=rjTVMONInIDnV1a_A2c_:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbeDFNgR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:36:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeDFNgP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:36:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masaki Ota <masaki.ota@jp.alps.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        Jonathan Liu <net147@gmail.com>,
        Jaak Ristioja <jaak@ristioja.ee>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 086/102] Input: ALPS - fix TrackStick detection on Thinkpad L570 and Latitude 7370
Date: Fri,  6 Apr 2018 15:24:07 +0200
Message-Id: <20180406084343.568999055@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
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

From: Masaki Ota <masaki.ota@jp.alps.com>

commit 567b9b549cfa1cbc202762ae97b5385c29ade1e3 upstream.

The primary interface for the touchpad device in Thinkpad L570 is SMBus,
so ALPS overlooked PS2 interface Firmware setting of TrackStick, and
shipped with TrackStick otp bit is disabled.

The address 0xD7 contains device number information, so we can identify
the device by checking this value, but to access it we need to enable
Command mode, and then re-enable the device. Devices shipped in Thinkpad
L570 report either 0x0C or 0x1D as device numbers, if we see them we assume
that the devices are DualPoints.

The same issue exists on Dell Latitude 7370.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196929
Fixes: 646580f793 ("Input: ALPS - fix multi-touch decoding on SS4 plus touchpads")
Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
Tested-by: Aaron Ma <aaron.ma@canonical.com>
Tested-by: Jonathan Liu <net147@gmail.com>
Tested-by: Jaak Ristioja <jaak@ristioja.ee>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/alps.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2538,13 +2538,31 @@ static int alps_update_btn_info_ss4_v2(u
 }
 
 static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
-				       struct alps_data *priv)
+					struct alps_data *priv,
+					struct psmouse *psmouse)
 {
 	bool is_dual = false;
+	int reg_val = 0;
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
 
-	if (IS_SS4PLUS_DEV(priv->dev_id))
+	if (IS_SS4PLUS_DEV(priv->dev_id)) {
 		is_dual = (otp[0][0] >> 4) & 0x01;
 
+		if (!is_dual) {
+			/* For support TrackStick of Thinkpad L/E series */
+			if (alps_exit_command_mode(psmouse) == 0 &&
+				alps_enter_command_mode(psmouse) == 0) {
+				reg_val = alps_command_mode_read_reg(psmouse,
+									0xD7);
+			}
+			alps_exit_command_mode(psmouse);
+			ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+			if (reg_val == 0x0C || reg_val == 0x1D)
+				is_dual = true;
+		}
+	}
+
 	if (is_dual)
 		priv->flags |= ALPS_DUALPOINT |
 					ALPS_DUALPOINT_WITH_PRESSURE;
@@ -2567,7 +2585,7 @@ static int alps_set_defaults_ss4_v2(stru
 
 	alps_update_btn_info_ss4_v2(otp, priv);
 
-	alps_update_dual_info_ss4_v2(otp, priv);
+	alps_update_dual_info_ss4_v2(otp, priv, psmouse);
 
 	return 0;
 }
