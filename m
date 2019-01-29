Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB12C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C77820844
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="cttwPpbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfA2K4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:56:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44903 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfA2K4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:56:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so17047160lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 02:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:organization:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HnlfyhLRQiZ8EkhANr5K6UBqRMQBwQfg1Ashpm0OURk=;
        b=cttwPpbN6zZZFtUtaD9CH6BlBXGYNFMivY/EZLJXtzYrmDDDV4igAFGunoD4RVCqqc
         PLpkAVtbYs6UlrUvF9j9Y1Czm46LW+INjuACUM30O2j4gi/aYti6u7N2ktc2T35IZmv/
         VTNh31TtDZz75p51YG71xMkrvmmuIJ+shDmIt8p/MvBhgE5JBO3BeCizvCey6agYiDRt
         Gpch0Ams90C9FhJ8Imm1jEVcBFlKwgQerChNz++V9AMjzKMT1cSS2cgZDRga8xuupE0S
         /vDWX4aHjfidaFll5noQP52Uxy5E9YsqS0rsWb/AK3blPy5p0D4IJsXbiEK59XzvTzKK
         0a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:organization:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=HnlfyhLRQiZ8EkhANr5K6UBqRMQBwQfg1Ashpm0OURk=;
        b=cXhf7Vb1kXUYioTzq20QXOh6RkgapOcRNptsDbav4fL2Wn4PFPzeyW2VGC6spxbxdH
         Rm+nrULoPXhDEqC92fWka0Lw7Nn2fL90fu6L5PY4p2fstrFqsBgSFdcQ0huoxOqSwYkc
         7Iq5k3Xkg/8+vzUObt5YHMZrm1N2Y+9PJygzIkRUm9CWRGpiyYgWl4J//65JCVOAKn5A
         57mkD1UkRInsBSFPtBZt6YkjwkgUQahpd5CtGucO8OfMGHCRz7XZFEhjXmwK0Ea8ZOrl
         SsCdyUy9qvPmUsblgxDjhZBC9KMJz6XDWzblClnWr097FM4Erd0i1Q3SK09Vl2bq7u0O
         LulQ==
X-Gm-Message-State: AJcUukezYgixRde9sIo26FNb1bDXxc5YynkEwFyDTTGpx3WLS18sUVOf
        kIS4Qi7/u+3IkVwezzsb0wLrrkgrujQ=
X-Google-Smtp-Source: ALg8bN59lOFXiq7EPgT1OBkdNChZjix7WllSXmTzssgpRTtb1cN6vXGjnyBSJ8gELVa8+ZzJa6sClA==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr21332635ljf.96.1548759380937;
        Tue, 29 Jan 2019 02:56:20 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.176])
        by smtp.gmail.com with ESMTPSA id b25-v6sm3547866lji.94.2019.01.29.02.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:56:20 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] devres: always use dev_name() in devm_ioremap_resource()
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Organization: Cogent Embedded
Message-ID: <1c848f62-e1d1-514f-f097-722d60f56711@cogentembedded.com>
Date:   Tue, 29 Jan 2019 13:56:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() prefers calling devm_request_mem_region() with a
resource name instead of a device name -- this looks pretty iff a resource
name isn't specified via a device tree with a "reg-names" property (in this
case, a resource name is set to a device node's full name), but if it is,
it doesn't really scale since these names are only unique to a given device
node, not globally; so, looking at the output of 'cat /proc/iomem', you do
not have an idea which memory region belongs to which device (see "dirmap",
"regs", and "wbuf" lines below):

08000000-0bffffff : dirmap
48000000-bfffffff : System RAM
  48000000-48007fff : reserved
  48080000-48b0ffff : Kernel code
  48b10000-48b8ffff : reserved
  48b90000-48c7afff : Kernel data
  bc6a4000-bcbfffff : reserved
  bcc0f000-bebfffff : reserved
  bec0e000-bec0efff : reserved
  bec11000-bec11fff : reserved
  bec12000-bec14fff : reserved
  bec15000-bfffffff : reserved
e6050000-e605004f : gpio@e6050000
e6051000-e605104f : gpio@e6051000
e6052000-e605204f : gpio@e6052000
e6053000-e605304f : gpio@e6053000
e6054000-e605404f : gpio@e6054000
e6055000-e605504f : gpio@e6055000
e6060000-e606050b : pin-controller@e6060000
e6e60000-e6e6003f : e6e60000.serial
e7400000-e7400fff : ethernet@e7400000
ee200000-ee2001ff : regs
ee208000-ee2080ff : wbuf

I think that devm_request_mem_region() should be called with dev_name()
despite the region names won't look as pretty as before (however, we gain
more consistency with e.g. the serial driver:

08000000-0bffffff : ee200000.rpc
48000000-bfffffff : System RAM
  48000000-48007fff : reserved
  48080000-48b0ffff : Kernel code
  48b10000-48b8ffff : reserved
  48b90000-48c7afff : Kernel data
  bc6a4000-bcbfffff : reserved
  bcc0f000-bebfffff : reserved
  bec0e000-bec0efff : reserved
  bec11000-bec11fff : reserved
  bec12000-bec14fff : reserved
  bec15000-bfffffff : reserved
e6050000-e605004f : e6050000.gpio
e6051000-e605104f : e6051000.gpio
e6052000-e605204f : e6052000.gpio
e6053000-e605304f : e6053000.gpio
e6054000-e605404f : e6054000.gpio
e6055000-e605504f : e6055000.gpio
e6060000-e606050b : e6060000.pin-controller
e6e60000-e6e6003f : e6e60000.serial
e7400000-e7400fff : e7400000.ethernet
ee200000-ee2001ff : ee200000.rpc
ee208000-ee2080ff : ee200000.rpc

Fixes: 72f8c0bfa0de ("lib: devres: add convenience function to remap a resource")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'driver-core-linus' branch of Greg KH's 'driver-core'
repo (for the lack of a better base).

 lib/devres.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: driver-core/lib/devres.c
===================================================================
--- driver-core.orig/lib/devres.c
+++ driver-core/lib/devres.c
@@ -134,7 +134,6 @@ EXPORT_SYMBOL(devm_iounmap);
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 {
 	resource_size_t size;
-	const char *name;
 	void __iomem *dest_ptr;
 
 	BUG_ON(!dev);
@@ -145,9 +144,8 @@ void __iomem *devm_ioremap_resource(stru
 	}
 
 	size = resource_size(res);
-	name = res->name ?: dev_name(dev);
 
-	if (!devm_request_mem_region(dev, res->start, size, name)) {
+	if (!devm_request_mem_region(dev, res->start, size, dev_name(dev))) {
 		dev_err(dev, "can't request region for resource %pR\n", res);
 		return IOMEM_ERR_PTR(-EBUSY);
 	}
