Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE20C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A26E21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151394;
	bh=9EKmwtC3GDePV9BajLC4j59n0BU+qOCrxbFim2M4yQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1F9mXtJON21FIRVQ3NKFWo1k/iHIYi0FK692V8TqDi6c5s/IdOvWiYxNRnqYUALV
	 AQYslP8uEyfL1ZWdZFKJyEUtQpB1tQRtpkruWLTGHaz671TjeViStgGPPqz5xVyFQu
	 KhRLnxLQRQd34/siyt5AN+GKR47jw3BwYXd6kME0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeLRQnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbeLRQlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:41:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BBD621873;
        Tue, 18 Dec 2018 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151292;
        bh=9EKmwtC3GDePV9BajLC4j59n0BU+qOCrxbFim2M4yQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTo0wy74nANUd5QQYDqCKistXqj1J1l9OVcG4B/nCGt0Sc83a/1uieHGsAg+5hp1t
         uKQKIlqLbV5J/u7Fvv92cxXx9YEsJFj7/cYHvCB44XsRG7PR7RmXoQz2jRIscWx5pg
         xbp/58rNM5xe+0fkSKgUF3uCRNCcNMrx1veaLDAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.19 39/44] drm/amdkfd: add new vega10 pci ids
Date:   Tue, 18 Dec 2018 17:39:51 +0100
Message-Id: <20181218163931.971062438@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 756e16bf79f2815e7c83a04881b5545b55a99fd3 upstream.

New vega10 ids.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -326,7 +326,13 @@ static const struct kfd_deviceid support
 	{ 0x6864, &vega10_device_info },	/* Vega10 */
 	{ 0x6867, &vega10_device_info },	/* Vega10 */
 	{ 0x6868, &vega10_device_info },	/* Vega10 */
+	{ 0x6869, &vega10_device_info },	/* Vega10 */
+	{ 0x686A, &vega10_device_info },	/* Vega10 */
+	{ 0x686B, &vega10_device_info },	/* Vega10 */
 	{ 0x686C, &vega10_vf_device_info },	/* Vega10  vf*/
+	{ 0x686D, &vega10_device_info },	/* Vega10 */
+	{ 0x686E, &vega10_device_info },	/* Vega10 */
+	{ 0x686F, &vega10_device_info },	/* Vega10 */
 	{ 0x687F, &vega10_device_info },	/* Vega10 */
 };
 


