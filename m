Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281222-2-3443044244333852937
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281221; b=CwjOjosgQaR71Fs5sq4CBxYKoF0F1N9E5/QTKEJRwer6rgIh4u
    DspArGKESIHrV3azHB4RMzSrkLTJoWEPvQdWSlMmkSO8dljDsxEyYwnU6eGo11cN
    DcfmneSkh9Y4rPwZgGycvW4ceiAgu6YHuMPfAJZO8zj+WMnVMYpCaBF6R6pPMpNP
    CVqnTniLMu04Gp+3FoCd3LYcdukHyJ9hH++fMWdp5RAvDydX0OJx3KTroexGjs6L
    TOs7y/h6oAfDHLyPW0pWYFhRNAR9nTM/qg91bPp2MGAlF1twbC8kNE8XNe3puW6e
    vZV7gVTEMMmwWv+vVJ1fWfw0jdPa2orr/Now==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281221; bh=4V4zLWnjoFpSBmixy6LoM/j8AR1KxK
    RdOA9eiPAVWbU=; b=f80ELPuGb0xbSkEgzMYYP2nt6m6pTHNb6bOBE9vDK3eua6
    hrn02ILS/w2ReNQymOBfWJN4USlq+CQJ1WuFbAwhHOswsVQ+w2xeeeuhO/I2YTsA
    s1ebaAJm3dqKAHQOLjV3F6vzxQoICT6S7YdGmu+MGYpsPLPY2gcz+lett7/k56bJ
    Th94tFbSpCPotwR5JxeUB6dHU4H4fv1LPy0orOUrNt7E67XL8WiaBVA9gDDnMPoQ
    hVKFcTV1qMRi6AKi2BukeyhvUumNrxuebq5RYfYoMSgF6A7dLetJ6dsc/FD1xpX/
    ToYGgRYyXApQbDmK6r6KRKEasy7tL7IlnzV1RUHQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ozDFzXbq x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ozDFzXbq x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFuPtT35NVDjcBAQTyU14xkEd/MbXEQN3VTW9BnV9enTb2Mp3od1xZgEkqxgq56eQy24DT/rr7mjgO4aEg8W6woij0z3hmHo/6re+L7jTJ5iNh/JPXIj
    R+BM4geNYjF8pHN2c7AfuxrRwaG9kM0nfa/7309HyIAhUGzi1c9l/ex4DuIcB5gCcBJvNK79N9OiUHquqeVWyBzPGxwjlCs5BKsfSilRe+WH8xjuoR8zxsxu
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8
    a=gXZjf3BiQpGE2TUTz0EA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbeENHAS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753921AbeENHAQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 4.16 59/72] thermal: exynos: Reading temperature makes sense only when TMU is turned on
Date: Mon, 14 May 2018 08:49:16 +0200
Message-Id: <20180514064827.108801941@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
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

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit 88fc6f73fddf64eb507b04f7b2bd01d7291db514 upstream.

When thermal sensor is not yet enabled, reading temperature might return
random value. This might even result in stopping system booting when such
temperature is higher than the critical value. Fix this by checking if TMU
has been actually enabled before reading the temperature.

This change fixes booting of Exynos4210-based board with TMU enabled (for
example Samsung Trats board), which was broken since v4.4 kernel release.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 9e4249b40340 ("thermal: exynos: Fix first temperature read after registering sensor")
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/samsung/exynos_tmu.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -185,6 +185,7 @@
  * @regulator: pointer to the TMU regulator structure.
  * @reg_conf: pointer to structure to register with core thermal.
  * @ntrip: number of supported trip points.
+ * @enabled: current status of TMU device
  * @tmu_initialize: SoC specific TMU initialization method
  * @tmu_control: SoC specific TMU control method
  * @tmu_read: SoC specific TMU temperature read method
@@ -205,6 +206,7 @@ struct exynos_tmu_data {
 	struct regulator *regulator;
 	struct thermal_zone_device *tzd;
 	unsigned int ntrip;
+	bool enabled;
 
 	int (*tmu_initialize)(struct platform_device *pdev);
 	void (*tmu_control)(struct platform_device *pdev, bool on);
@@ -398,6 +400,7 @@ static void exynos_tmu_control(struct pl
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 	data->tmu_control(pdev, on);
+	data->enabled = on;
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 }
@@ -890,7 +893,7 @@ static int exynos_get_temp(void *p, int
 {
 	struct exynos_tmu_data *data = p;
 
-	if (!data || !data->tmu_read)
+	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
