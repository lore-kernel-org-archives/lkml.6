Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E552C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042FF214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTRBNUsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042FF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeJJVPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:15:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42476 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbeJJVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:15:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so5836309wru.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=efF4QrIVaQqc69TO3pAq8q3rnPzS6G0oe6szYk5X4zo=;
        b=NTRBNUsaw4ta0GdYcC1i6Fnbxv9IoGxEqarfgcw0XJTbuePpfdlD89cuUI48ZxnkBr
         dymLvnj12u49OS0QDPemh028NkNQTxwM6lYR8B0FY8g8AHUDMxUo6csUqi+Y0eFOjPGz
         EjkfxmNZpIcfO+lNVCo2I1QqsT3DUj9k4xA27zYWbLpYg2ZkaTw6anMFVqcNTIsukqsp
         SuG4qF5nYiPHxlPdu5vAtGrTVri8U3WDp5Jq58arthUdNeK7msvqgSTAnIWPo9oeSIx9
         2mKdlq32ycw3dWjm5l5pJmLPvOEXd75CIzAX9E9yM466s4Ue2WaGtM4C84reK1IVZCeh
         mmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=efF4QrIVaQqc69TO3pAq8q3rnPzS6G0oe6szYk5X4zo=;
        b=O8U8FHW87PSVsQkAQEo63VcgaDqnqc1Acrt16xOnf8Yy6dKsfQWD2mA6fMZX9yVP/U
         gymSMrmNRzALFqr1vQKF7u8GfXpV5APyDvmjaiVlYwTQYIWzN41sp+JOT+8glAkNVGi5
         tDbHLF/CadlvhI1HTYqoaH+NGHWiOPUCiZz09p1BSPnxUN+6tNYuaVrZGWNM3ZvTDdLQ
         47DDS9AGFJJJeDcUyflmtS1ZLtJhmT5UmqTi7vOphDKpym6wwhvLnoyu5OEXXr1NmXt7
         EjDfy8EGeTnH4fdULoR1wK4hxmMiuCIuWYw9MB5zQtdqg/3REinu99BOJJvmtR+scODm
         PkPw==
X-Gm-Message-State: ABuFfoh5qQ4pYHasFlShX8WeYQROIW/7K9DkpIC/SsrBzF1ldcAcaH3n
        b6W8AMdT2EJjfubDdgtzE1E=
X-Google-Smtp-Source: ACcGV63YWPuSTReU6fTcbS3W5Im53/boWQAp6NWy/9YkNSHaclRogi2ttNZ4kbVYFm8/4v+Ktye2jQ==
X-Received: by 2002:a5d:4791:: with SMTP id w17-v6mr25544643wrq.319.1539179608674;
        Wed, 10 Oct 2018 06:53:28 -0700 (PDT)
Received: from minipc.home ([2a00:23c4:911f:4500:a5ab:58b7:ec39:bb8])
        by smtp.gmail.com with ESMTPSA id t143-v6sm14912890wmt.2.2018.10.10.06.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:53:27 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:03:05 +0100
From:   Laurence Rochfort <laurence.rochfort@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, laurence.rochfort@gmail.com
Subject: Re: [PATCH] staging: gasket: Fix sparse "incorrect type in
 assignment" warnings.
Message-ID: <20181010140305.GA20899@minipc.home>
References: <20181004175225.GA22487@minipc.home>
 <20181009131303.GC25423@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20181009131303.GC25423@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2018 at 03:13:03PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Oct 04, 2018 at 06:52:25PM +0100, Laurence Rochfort wrote:
> > Silence the below sparse warnings by casting betwen u8 __iomem *, and
> > void *.
> > 
> > warning: incorrect type in assignment (different address spaces)
> >    expected unsigned char [noderef] [usertype] <asn:2>*virt_base
> >    got void *[assigned] mem
> > warning: incorrect type in argument 3 (different address spaces)
> >    expected void *cpu_addr
> >    got unsigned char [noderef] [usertype] <asn:2>*virt_base
> > 
> > Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
> > ---
> >  drivers/staging/gasket/gasket_page_table.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
> > index d4c5f8a..7f5e5b3 100644
> > --- a/drivers/staging/gasket/gasket_page_table.c
> > +++ b/drivers/staging/gasket/gasket_page_table.c
> > @@ -1278,7 +1278,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
> >  				 dma_addr_t *dma_address, u64 index)
> >  {
> >  	dma_addr_t handle;
> > -	void *mem;
> > +	u8 __iomem *mem;
> >  	int j;
> >  	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
> >  	const struct gasket_driver_desc *driver_desc =
> > @@ -1290,7 +1290,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
> >  	if (num_pages == 0)
> >  		return -EINVAL;
> >  
> > -	mem = dma_alloc_coherent(gasket_get_device(gasket_dev),
> > +	mem = (u8 __iomem *)dma_alloc_coherent(gasket_get_device(gasket_dev),
> >  				 num_pages * PAGE_SIZE, &handle, 0);
> >  	if (!mem)
> >  		goto nomem;
> > @@ -1325,7 +1325,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
> >  nomem:
> >  	if (mem) {
> >  		dma_free_coherent(gasket_get_device(gasket_dev),
> > -				  num_pages * PAGE_SIZE, mem, handle);
> > +				  num_pages * PAGE_SIZE, (void __force *)mem, handle);
> >  	}
> >  
> >  	if (gasket_dev->page_table[index]->coherent_pages) {
> > @@ -1353,7 +1353,7 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
> >  	if (gasket_dev->coherent_buffer.length_bytes) {
> >  		dma_free_coherent(gasket_get_device(gasket_dev),
> >  				  gasket_dev->coherent_buffer.length_bytes,
> > -				  gasket_dev->coherent_buffer.virt_base,
> > +				  (void __force *)gasket_dev->coherent_buffer.virt_base,
> 
> We should not have to "force" anything here.  Something feels wrong in
> the definition of these variable types...

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v2-0001-staging-gasket-Fix-sparse-incorrect-type-in-assig.patch"

From bde80ff6bdab740d838210aa3e664c8901b2142a Mon Sep 17 00:00:00 2001
From: Laurence Rochfort <laurence.rochfort@gmail.com>
Date: Thu, 4 Oct 2018 18:42:26 +0100
Subject: [PATCH v2] staging: gasket: Fix sparse "incorrect type in assignment"
 warnings.

Correct the coherent buffer data type and memory space cookie.

sparse errors were being generated when passing virt_base to
dma_alloc_coherent().

warning: incorrect type in assignment (different address spaces)
   expected unsigned char [noderef] [usertype] <asn:2>*virt_base
   got void *[assigned] mem
warning: incorrect type in argument 3 (different address spaces)
   expected void *cpu_addr
   got unsigned char [noderef] [usertype] <asn:2>*virt_base

Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
---
Changes in v2:
- Correct data type rather than forcing type coersion, as per gkh

 drivers/staging/gasket/gasket_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index 275fd0b..9d09678 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -231,7 +231,7 @@ struct gasket_coherent_buffer_desc {
 /* Coherent buffer structure. */
 struct gasket_coherent_buffer {
 	/* Virtual base address. */
-	u8 __iomem *virt_base;
+	void *virt_base;
 
 	/* Physical base address. */
 	ulong phys_base;
-- 
2.9.5


--ADZbWkCsHQ7r3kzd--
