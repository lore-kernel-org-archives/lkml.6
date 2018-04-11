Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472489-5-327424155089010788
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
    1523472489; b=NnNEi7XsEkIPctDiXprn3XwOuLmlSA2rFdzd128MynsSMrfgSc
    pxA7Q2XwVAv9dH47lFv8IclCsbZjRJWR0Mk2S3TvPi7dvfqK4Y+FLqFjKzfZRF7g
    KiSpGcvlp+XCEeWvsLUhVvdNtBuoICjvxSH+1V7BGNKPxWijn3lLnpORc1jbWbEH
    C/RmQM9ol+G520t92PWN2X+uqCsNhIaeuOLOcb7+unchbneDRK0vNhAFFhXRB+35
    8/w5EuH9n5xzGdIFYmEnHDyBt4WoPXEc8HoJfyLqkXE4AmvvHkl+0euEzdHwwFBM
    rCKcChKDdMcebYAT96siq+G/popvwnm5kgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472489; bh=4nWYR2umpi82ycD6M07cjEpYC5MDMA
    Srh9Skq94l9/w=; b=TUSb2GK0CGXVIAtnEzzcemQJhiGKo954nah/kyeFqcz2lc
    kW62/rXB6qMXJBGIng+ySCVCnvDf8Gkz9qbpGYoyWcBfmZ1F1JxuaxkpN6B6pvAz
    WNuPcYMExDVXv+tf9QanydZ6yB0AKh390VaRIeU+p+97wNBCYPqpGeLwwJHjDI76
    w2Lom3bIGTBDzShnzVVlqweIXdxpxMbNKTQ+0FRWdE+tnliyJJAYRJYVqRWtYQ6L
    lNahlP++pb2Hz5g9IvLSfDAKALsDqI2UVpjjf5dqKDz5FwcoC1ACRKq1PkML/rmm
    eyw8JVpoYqTGISIYgipNtA9MdUQYuDBM5Eo1XVfw==
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
X-CM-Envelope: MS4wfP1G+qN7KaW7VpPlxx/WdzzJPrkIYfpYuyPl7ihTRy4aL+gdtOK01Xdx5t5bc/2h2eAluaomYT1pEFru8BYFx2cGXCsnZc8aF1u1H/VM3YZFx/ADPkVn
    zFE7ehq3DyJnfCjItG614Z/UPl6/L0+b5hxY9omOB9icaUZGydwYh/1ZBxM3h5+GSWAuYMQ3/z4krRjV4JFZGyWIhcWEyBa41Ql7WRC9/Vp55IR8JCgL1q0z
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=r7hTFzgnQUyMEkfOMgEA:9
    a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756049AbeDKSsF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:48:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756016AbeDKSsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:48:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 059/190] ARM: davinci: da8xx: Create DSP device only when assigned memory
Date: Wed, 11 Apr 2018 20:35:05 +0200
Message-Id: <20180411183553.782592752@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Anna <s-anna@ti.com>


[ Upstream commit f97f03578b997a8ec2b9bc4928f958a865137268 ]

The DSP device on Davinci platforms does not have an MMU and requires
specific DDR memory to boot. This memory is reserved using the rproc_mem
kernel boot parameter and is assigned to the device on non-DT boots.
The remoteproc core uses the DMA API and so will fall back to assigning
random memory if this memory is not assigned to the device, but the DSP
remote processor boot will not be successful in such cases. So, check
that memory has been reserved and assigned to the device specifically
before even creating the DSP device.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/devices-da8xx.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -795,6 +795,8 @@ static struct platform_device da8xx_dsp
 	.resource	= da8xx_rproc_resources,
 };
 
+static bool rproc_mem_inited __initdata;
+
 #if IS_ENABLED(CONFIG_DA8XX_REMOTEPROC)
 
 static phys_addr_t rproc_base __initdata;
@@ -833,6 +835,8 @@ void __init da8xx_rproc_reserve_cma(void
 	ret = dma_declare_contiguous(&da8xx_dsp.dev, rproc_size, rproc_base, 0);
 	if (ret)
 		pr_err("%s: dma_declare_contiguous failed %d\n", __func__, ret);
+	else
+		rproc_mem_inited = true;
 }
 
 #else
@@ -847,6 +851,12 @@ int __init da8xx_register_rproc(void)
 {
 	int ret;
 
+	if (!rproc_mem_inited) {
+		pr_warn("%s: memory not reserved for DSP, not registering DSP device\n",
+			__func__);
+		return -ENOMEM;
+	}
+
 	ret = platform_device_register(&da8xx_dsp);
 	if (ret)
 		pr_err("%s: can't register DSP device: %d\n", __func__, ret);
