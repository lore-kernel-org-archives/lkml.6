Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CECC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72B72082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107302;
	bh=crz4EwbQdBmJ/KVsEGpiXiticJN5CY/s1NEaQ9hCtes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lrDlAbPoFPlgy1WtS0vAKfOjljMWR2GK233YLOfK/tCtw+wkIgT6F2dnjPoS2z7Sv
	 AsoONyJvu2dkLVda4ZV7Dti1dH9TI/xS/+JJYBwqIVI/by2qh7k8KubACJa4sAxIUo
	 7KgUdnEiGcpiE1k3KJlrAl0vtPfEcmSKpbf8KFvw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72B72082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeLFOll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbeLFOli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:41:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20B020661;
        Thu,  6 Dec 2018 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107297;
        bh=crz4EwbQdBmJ/KVsEGpiXiticJN5CY/s1NEaQ9hCtes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKWv7+9i9dTvCZ1f43+WmLuqbQDah09oesMWS/JazwhV+R/hSBYM+7WaG5dUXJjsK
         HKjhjIBCJDQ1fRkSYQVZ/ER4+rXO/JEytGyggMP6Qq1vaWDkE6TAlzwJoMq3jJW7U7
         0EDCPJTq8gz+qdhBLtiBn2ijaY+BF1ws1YKCQyD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 32/41] Input: synaptics - add PNP ID for ThinkPad P50 to SMBus
Date:   Thu,  6 Dec 2018 15:39:12 +0100
Message-Id: <20181206142952.820972879@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit 9df39bedbf292680655c6a947c77d6562c693d4a upstream.

Noticed the other day the trackpoint felt different on my P50, then
realized it was because rmi4 wasn't loading for this machine
automatically. Suspend/resume, hibernate, and everything else seem to
work perfectly fine on here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -170,6 +170,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
+	"LEN005b", /* P50 */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */


