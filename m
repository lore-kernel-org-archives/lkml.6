Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1878097-1525116867-2-16135271239198917402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116867; b=irZUmHcrA/Mc2jBivb6Q+r+vMMzQ9BusdWMd+pc9hAZb6BHbfi
    H6jPUOhU0FHsYxLAFrs9DkCEMQ8IEKsHzVTV6nf+2HnbRRmrX0/JSSh+EgLcdn/l
    1X1dVWBucnH5Jb1h6rnPkjxKoYeV7jlxdJePoZidOWjsJnAEwKgT2Aqb9mWamEo9
    NMJytec+JaA4wBZz5yedBqZTrDPxOv63tBJgNOFfI+HH8flbQyzYZ8T78l+72pM4
    FnpnAs69/nvLjMTH/gfUKighR2+cpxyt2BLyRzcB7qBGop+6X3FMtKYcl9l1ahbC
    vbRJMiApya56SAl+9lHfDELLv8sqpGJcReLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116867; bh=ljBc5jdW2RvKl08Ae5c3ViUSTA2Gyr
    CfzKcEQS8ATgo=; b=IN1CfsB3Dp0K0DuUY9UDUmisYUiEN2XjiZToi7zr0ir+UX
    RHHCJKbbRwTwO/wuoEM16mwdbNA9MIHD46FSygtG70lCOK++7qpdRqmeeVQUiUYX
    NWcdxIlpv9nZlJNmGozbSFEdosNtF9YqB3C8DIvTQLB/ZLCsHN2sndSUGfhaG3CE
    XEKS4uhMtBpEQHIYBId7QJTt5eDVCWNY0wGnpcJr9Yhd/mLMwBoOZy5xZjFII9Yg
    xCOXY56411zciBg9TCMR98DWcI1IiH4v5MDVeISdDmz1YKMrKUDkcaBnK8uEb6/f
    O+C9p4Dk2LKKzSuTSUfp33w+ev391qYA71iVBMrA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfISp1FR/dSp0qZCRSGovof4zy1qn9SDLFW7SZGJhYe8P9TB74P5k9Er5RtbgTGp1a0H8L8ggLxCxvs/UOtmWkbT8qUwtc9EuFN/hZNl2Hacew1TYW30v
    KBrX8oEc1sS9vJFC8UO1BN7l23G89ivy4c9CCQjsE0lPjqJHnb1G2mIRI5Vt7fk+FnWBoE9y7KjkEy/UIbSG+EBxbpzqzpp8/LujxdRcn3ED7bfNKb3Q50Cg
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=4qJa2TyV-tAcKX4WSNMA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756491AbeD3TeN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755980AbeD3T2x (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F50F22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.16 104/113] drm/amd/display: Dont read EDID in atomic_check
Date: Mon, 30 Apr 2018 12:25:15 -0700
Message-Id: <20180430184019.596757596@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
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

From: Harry Wentland <harry.wentland@amd.com>

commit c7b8de00384be49dc1617a838b0ce89a0235f319 upstream.

We shouldn't attempt to read EDID in atomic_check. We really shouldn't
even be modifying the connector object, or any other non-state object,
but this is a start at least.

Moving EDID cleanup to dm_dp_mst_connector_destroy from
dm_dp_destroy_mst_connector to ensure the EDID is still available for
headless mode.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c |   32 +++---------
 1 file changed, 10 insertions(+), 22 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -157,6 +157,11 @@ dm_dp_mst_connector_destroy(struct drm_c
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_encoder *amdgpu_encoder = amdgpu_dm_connector->mst_encoder;
 
+	if (amdgpu_dm_connector->edid) {
+		kfree(amdgpu_dm_connector->edid);
+		amdgpu_dm_connector->edid = NULL;
+	}
+
 	drm_encoder_cleanup(&amdgpu_encoder->base);
 	kfree(amdgpu_encoder);
 	drm_connector_cleanup(connector);
@@ -183,28 +188,22 @@ static int dm_connector_update_modes(str
 void dm_dp_mst_dc_sink_create(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
-	struct edid *edid;
 	struct dc_sink *dc_sink;
 	struct dc_sink_init_data init_params = {
 			.link = aconnector->dc_link,
 			.sink_signal = SIGNAL_TYPE_DISPLAY_PORT_MST };
 
+	/* FIXME none of this is safe. we shouldn't touch aconnector here in
+	 * atomic_check
+	 */
+
 	/*
 	 * TODO: Need to further figure out why ddc.algo is NULL while MST port exists
 	 */
 	if (!aconnector->port || !aconnector->port->aux.ddc.algo)
 		return;
 
-	edid = drm_dp_mst_get_edid(connector, &aconnector->mst_port->mst_mgr, aconnector->port);
-
-	if (!edid) {
-		drm_mode_connector_update_edid_property(
-			&aconnector->base,
-			NULL);
-		return;
-	}
-
-	aconnector->edid = edid;
+	ASSERT(aconnector->edid);
 
 	dc_sink = dc_link_add_remote_sink(
 		aconnector->dc_link,
@@ -217,9 +216,6 @@ void dm_dp_mst_dc_sink_create(struct drm
 
 	amdgpu_dm_add_sink_to_freesync_module(
 			connector, aconnector->edid);
-
-	drm_mode_connector_update_edid_property(
-					&aconnector->base, aconnector->edid);
 }
 
 static int dm_dp_mst_get_modes(struct drm_connector *connector)
@@ -426,14 +422,6 @@ static void dm_dp_destroy_mst_connector(
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 	}
-	if (aconnector->edid) {
-		kfree(aconnector->edid);
-		aconnector->edid = NULL;
-	}
-
-	drm_mode_connector_update_edid_property(
-			&aconnector->base,
-			NULL);
 
 	aconnector->mst_connected = false;
 }
