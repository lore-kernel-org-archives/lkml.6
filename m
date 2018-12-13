Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D4FC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0912080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="J0idZ/yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0912080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeLMJfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:35:17 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25412 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeLMJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:35:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1544693706; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=l0PYZHGMb4Ctl3V6m0/Ky0mVWRT3SJIe1j8xPjNoBMQPKxxa6jQCKyyA/FdWnPNx4eEyMZ9mPs5u+naOYA/HhFEqkkUh0tgkk0H9HJo5xjPesfS7mtEiC2xWrwr4yLCJAcldaaBM8mvgql51mXd9Y/cEvXunVcnRU1asbnZYHNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1544693706; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=WQFj6Edup29JXr8BKN7hxEZ2IYC07JDP5gVeunBL/H8=; 
        b=Es9cP1NxnovrX8BrV8bRbCKM9eY7YVFc+Zmm0l67190snYDnHlW9o1fcvEXzKL5oGNYWyAcd6u+r0hwRbx0e/bYnIQ8VtTsZ51rj4bETUvQWqf8ESkvZRceeWRtyC5dJBCxCxOEOTShDlq9VMv1USm/sj8MaOGl/DMNwfUf3cIs=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:message-id:subject:date:mime-version:content-type; 
  b=tRTxdSJxg+sxqLAEXPnMxmQphSo2xTKfmMJa38psvZB4mfSfU2XXGgu6Th5MIOutdeouMMWI40TH
    Z77PmiVKgEpT9yoA+UWWnLDhBGWHIGHJSGv8hn9LtBtT4915hA6O  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1544693706;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=3398; bh=WQFj6Edup29JXr8BKN7hxEZ2IYC07JDP5gVeunBL/H8=;
        b=J0idZ/ybcT4PIgwrIU1DJR3Ha3OtCIyuLyHgBXau/NPH2QA61Rbv2WiNPPxesWYs
        vB58OHqOGIJKlXLKqm0xIAgVb7IpVr1S1VNg8GsNL+Cp+J8Oh37vZvcKpcWReNH94iz
        8kvb62O2iAOanCx/QXtMgDKP4JQTSDO+3XRdoIAw=
Received: from YEHS1XR956R00D1.lenovo.com (125.33.111.245 [125.33.111.245]) by mx.zohomail.com
        with SMTPS id 1544693703614393.6282955707112; Thu, 13 Dec 2018 01:35:03 -0800 (PST)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     alexander.deucher@amd.com, harry.wentland@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, tony.cheng@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, chengnt@lenovo.com,
        Huaisheng Ye <yehs1@lenovo.com>
Message-ID: <20181213093454.10872-1-yehs2007@zoho.com>
Subject: [PATCH] drm/amd/display: fix compiler warnings about wm variable
Date:   Thu, 13 Dec 2018 17:34:54 +0800
X-Mailer: git-send-email 2.17.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

There are compiler warnings within functions 'dcn10_log_hubbub_state=E2=80=
=99
and 'dcn10_get_hubbub_state=E2=80=99. This patch avoids the compiler report=
s
the following warning when building amdgpu.ko.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In fun=
ction =E2=80=98dcn10_log_hubbub_state=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:94:9: w=
arning: missing braces around initializer [-Wmissing-braces]
  struct dcn_hubbub_wm wm =3D {0};
         ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:94:9: w=
arning: (near initialization for =E2=80=98wm.sets=E2=80=99) [-Wmissing-brac=
es]

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer_debug.c: =
In function =E2=80=98dcn10_get_hubbub_state=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer_debug.c:7=
4:9: warning: missing braces around initializer [-Wmissing-braces]
  struct dcn_hubbub_wm wm =3D {0};
         ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer_debug.c:7=
4:9: warning: (near initialization for =E2=80=98wm.sets=E2=80=99) [-Wmissin=
g-braces]

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c       | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 193184a..e96933a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -91,9 +91,10 @@ static void log_mpc_crc(struct dc *dc,
 void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *log_c=
tx)
 {
 =09struct dc_context *dc_ctx =3D dc->ctx;
-=09struct dcn_hubbub_wm wm =3D {0};
+=09struct dcn_hubbub_wm wm;
 =09int i;
=20
+=09memset(&wm, 0, sizeof(struct dcn_hubbub_wm));
 =09hubbub1_wm_read_state(dc->res_pool->hubbub, &wm);
=20
 =09DTN_INFO("HUBBUB WM:      data_urgent  pte_meta_urgent"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.=
c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 6415890..f5610ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -71,7 +71,7 @@ static unsigned int snprintf_count(char *pBuf, unsigned i=
nt bufSize, char *fmt,
 static unsigned int dcn10_get_hubbub_state(struct dc *dc, char *pBuf, unsi=
gned int bufSize)
 {
 =09struct dc_context *dc_ctx =3D dc->ctx;
-=09struct dcn_hubbub_wm wm =3D {0};
+=09struct dcn_hubbub_wm wm;
 =09int i;
=20
 =09unsigned int chars_printed =3D 0;
@@ -80,6 +80,7 @@ static unsigned int dcn10_get_hubbub_state(struct dc *dc,=
 char *pBuf, unsigned i
 =09const uint32_t ref_clk_mhz =3D dc_ctx->dc->res_pool->ref_clock_inKhz / =
1000;
 =09static const unsigned int frac =3D 1000;
=20
+=09memset(&wm, 0, sizeof(struct dcn_hubbub_wm));
 =09hubbub1_wm_read_state(dc->res_pool->hubbub, &wm);
=20
 =09chars_printed =3D snprintf_count(pBuf, remaining_buffer, "wm_set_index,=
data_urgent,pte_meta_urgent,sr_enter,sr_exit,dram_clk_chanage\n");
--=20
1.8.3.1



