Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9BCC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356E02082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnPg6RN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356E02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLCUe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:34:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35426 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeLCUe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:34:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so11981679edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/H+DYF/gmReZwQWsv7MKq2jl03FrcNxhmAwYZyuixkU=;
        b=TnPg6RN5cfy5w80wcwv59bMweiOq4tGasbzQXkNu9GkmIKoegjwLEpf2tx52N7dy5H
         UMHVQaigSnOutrhDMVnorqDHDMokk9to7XOkBjZmjGm+OzxU+PwLyDCdQHGjTqaSVnAT
         QwadmriflQ1HeEeV8MwCniEB2Zuq/R4isQR+Rx063HwrebgulSYVh2ZvFzuOSJG6Alds
         OVkvVo8qrkR8Zd9YtXSeCBo1zf9eIhfSyEhcSPyrRnLvzEuj7+f3tnMuW4k4JOHZD3v8
         yICoVspmNvRLEiQeMCejXysvQn2lS+iQyU+R4/Hy0MDtUYl5pCUeARyWgxBDE36S3eVp
         Efeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/H+DYF/gmReZwQWsv7MKq2jl03FrcNxhmAwYZyuixkU=;
        b=PYmRhxN/hCheb4jom7nAwMpIFFUzB/OwtzUkf036WOgNR+QcrkDxAudG3oAiS3+uSz
         Kzamsh9vmj9J2sYzAtqP8BE3qmocqRN3J4uWjbmKiMldpNrWaN592RV0V8mb8Gn8fm3T
         3FQYSqGb8/gPFfK+lYLnalGJrVL8tpU1DKDU9SYcsqhYp3qHRpLINKAy+/gPdyMgxeKP
         YmL810oH+H8A3BfnT4Pf18q/y3Muog09UpH5HISnauJDSm3RDhKe8WsfVyMYWG3E3Z7a
         enCBRuljPaEgt7fWSgoc6d2El+IR5lnzir6zhhxxjbSrkWdMlrQypXwkLJkHxgdUlqz4
         FCUA==
X-Gm-Message-State: AA+aEWbew3RuhXJM4uv9SWfd4prftieamAWYGSyULbD1rBs3zvm3BgF/
        jiPlnWrPPhZjSJhouXJXQJE=
X-Google-Smtp-Source: AFSGD/UfMxjjkFgufJHTLFUR5osTp32T2jEIjfk03nV6e0WmGxTVf8gpOroW0hNLA4YxqyBIKn16Tg==
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr13712720ejq.19.1543869292534;
        Mon, 03 Dec 2018 12:34:52 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i24sm3966217edq.0.2018.12.03.12.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:34:51 -0800 (PST)
Date:   Mon, 3 Dec 2018 20:34:50 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1] drivers/base/memory.c: Use DEVICE_ATTR_RO and friends
Message-ID: <20181203203450.rjrpn2l4hpsjstfa@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181203111611.10633-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203111611.10633-1-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:16:11PM +0100, David Hildenbrand wrote:
>Let's use the easier to read (and not mess up) variants:
>- Use DEVICE_ATTR_RO
>- Use DEVICE_ATTR_WO
>- Use DEVICE_ATTR_RW
>instead of the more generic DEVICE_ATTR() we're using right now.
>
>We have to rename most callback functions. By fixing the intendations we
>can even save some LOCs.
>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Ingo Molnar <mingo@kernel.org>
>Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>Cc: Oscar Salvador <osalvador@suse.com>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Looks good to me.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> drivers/base/memory.c | 79 ++++++++++++++++++++-----------------------
> 1 file changed, 36 insertions(+), 43 deletions(-)
>
>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>index 0c290f86ab20..c9c1ee564edb 100644
>--- a/drivers/base/memory.c
>+++ b/drivers/base/memory.c
>@@ -109,8 +109,8 @@ static unsigned long get_memory_block_size(void)
>  * uses.
>  */
> 
>-static ssize_t show_mem_start_phys_index(struct device *dev,
>-			struct device_attribute *attr, char *buf)
>+static ssize_t phys_index_show(struct device *dev,
>+			       struct device_attribute *attr, char *buf)
> {
> 	struct memory_block *mem = to_memory_block(dev);
> 	unsigned long phys_index;
>@@ -122,8 +122,8 @@ static ssize_t show_mem_start_phys_index(struct device *dev,
> /*
>  * Show whether the section of memory is likely to be hot-removable
>  */
>-static ssize_t show_mem_removable(struct device *dev,
>-			struct device_attribute *attr, char *buf)
>+static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
>+			      char *buf)
> {
> 	unsigned long i, pfn;
> 	int ret = 1;
>@@ -146,8 +146,8 @@ static ssize_t show_mem_removable(struct device *dev,
> /*
>  * online, offline, going offline, etc.
>  */
>-static ssize_t show_mem_state(struct device *dev,
>-			struct device_attribute *attr, char *buf)
>+static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>+			  char *buf)
> {
> 	struct memory_block *mem = to_memory_block(dev);
> 	ssize_t len = 0;
>@@ -286,7 +286,7 @@ static int memory_subsys_online(struct device *dev)
> 		return 0;
> 
> 	/*
>-	 * If we are called from store_mem_state(), online_type will be
>+	 * If we are called from state_store(), online_type will be
> 	 * set >= 0 Otherwise we were called from the device online
> 	 * attribute and need to set the online_type.
> 	 */
>@@ -315,9 +315,8 @@ static int memory_subsys_offline(struct device *dev)
> 	return memory_block_change_state(mem, MEM_OFFLINE, MEM_ONLINE);
> }
> 
>-static ssize_t
>-store_mem_state(struct device *dev,
>-		struct device_attribute *attr, const char *buf, size_t count)
>+static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>+			   const char *buf, size_t count)
> {
> 	struct memory_block *mem = to_memory_block(dev);
> 	int ret, online_type;
>@@ -374,7 +373,7 @@ store_mem_state(struct device *dev,
>  * s.t. if I offline all of these sections I can then
>  * remove the physical device?
>  */
>-static ssize_t show_phys_device(struct device *dev,
>+static ssize_t phys_device_show(struct device *dev,
> 				struct device_attribute *attr, char *buf)
> {
> 	struct memory_block *mem = to_memory_block(dev);
>@@ -395,7 +394,7 @@ static void print_allowed_zone(char *buf, int nid, unsigned long start_pfn,
> 	}
> }
> 
>-static ssize_t show_valid_zones(struct device *dev,
>+static ssize_t valid_zones_show(struct device *dev,
> 				struct device_attribute *attr, char *buf)
> {
> 	struct memory_block *mem = to_memory_block(dev);
>@@ -435,33 +434,31 @@ static ssize_t show_valid_zones(struct device *dev,
> 
> 	return strlen(buf);
> }
>-static DEVICE_ATTR(valid_zones, 0444, show_valid_zones, NULL);
>+static DEVICE_ATTR_RO(valid_zones);
> #endif
> 
>-static DEVICE_ATTR(phys_index, 0444, show_mem_start_phys_index, NULL);
>-static DEVICE_ATTR(state, 0644, show_mem_state, store_mem_state);
>-static DEVICE_ATTR(phys_device, 0444, show_phys_device, NULL);
>-static DEVICE_ATTR(removable, 0444, show_mem_removable, NULL);
>+static DEVICE_ATTR_RO(phys_index);
>+static DEVICE_ATTR_RW(state);
>+static DEVICE_ATTR_RO(phys_device);
>+static DEVICE_ATTR_RO(removable);
> 
> /*
>  * Block size attribute stuff
>  */
>-static ssize_t
>-print_block_size(struct device *dev, struct device_attribute *attr,
>-		 char *buf)
>+static ssize_t block_size_bytes_show(struct device *dev,
>+				     struct device_attribute *attr, char *buf)
> {
> 	return sprintf(buf, "%lx\n", get_memory_block_size());
> }
> 
>-static DEVICE_ATTR(block_size_bytes, 0444, print_block_size, NULL);
>+static DEVICE_ATTR_RO(block_size_bytes);
> 
> /*
>  * Memory auto online policy.
>  */
> 
>-static ssize_t
>-show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
>-			char *buf)
>+static ssize_t auto_online_blocks_show(struct device *dev,
>+				       struct device_attribute *attr, char *buf)
> {
> 	if (memhp_auto_online)
> 		return sprintf(buf, "online\n");
>@@ -469,9 +466,9 @@ show_auto_online_blocks(struct device *dev, struct device_attribute *attr,
> 		return sprintf(buf, "offline\n");
> }
> 
>-static ssize_t
>-store_auto_online_blocks(struct device *dev, struct device_attribute *attr,
>-			 const char *buf, size_t count)
>+static ssize_t auto_online_blocks_store(struct device *dev,
>+					struct device_attribute *attr,
>+					const char *buf, size_t count)
> {
> 	if (sysfs_streq(buf, "online"))
> 		memhp_auto_online = true;
>@@ -483,8 +480,7 @@ store_auto_online_blocks(struct device *dev, struct device_attribute *attr,
> 	return count;
> }
> 
>-static DEVICE_ATTR(auto_online_blocks, 0644, show_auto_online_blocks,
>-		   store_auto_online_blocks);
>+static DEVICE_ATTR_RW(auto_online_blocks);
> 
> /*
>  * Some architectures will have custom drivers to do this, and
>@@ -493,9 +489,8 @@ static DEVICE_ATTR(auto_online_blocks, 0644, show_auto_online_blocks,
>  * and will require this interface.
>  */
> #ifdef CONFIG_ARCH_MEMORY_PROBE
>-static ssize_t
>-memory_probe_store(struct device *dev, struct device_attribute *attr,
>-		   const char *buf, size_t count)
>+static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>+			   const char *buf, size_t count)
> {
> 	u64 phys_addr;
> 	int nid, ret;
>@@ -525,7 +520,7 @@ memory_probe_store(struct device *dev, struct device_attribute *attr,
> 	return ret;
> }
> 
>-static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
>+static DEVICE_ATTR_WO(probe);
> #endif
> 
> #ifdef CONFIG_MEMORY_FAILURE
>@@ -534,10 +529,9 @@ static DEVICE_ATTR(probe, S_IWUSR, NULL, memory_probe_store);
>  */
> 
> /* Soft offline a page */
>-static ssize_t
>-store_soft_offline_page(struct device *dev,
>-			struct device_attribute *attr,
>-			const char *buf, size_t count)
>+static ssize_t soft_offline_page_store(struct device *dev,
>+				       struct device_attribute *attr,
>+				       const char *buf, size_t count)
> {
> 	int ret;
> 	u64 pfn;
>@@ -553,10 +547,9 @@ store_soft_offline_page(struct device *dev,
> }
> 
> /* Forcibly offline a page, including killing processes. */
>-static ssize_t
>-store_hard_offline_page(struct device *dev,
>-			struct device_attribute *attr,
>-			const char *buf, size_t count)
>+static ssize_t hard_offline_page_store(struct device *dev,
>+				       struct device_attribute *attr,
>+				       const char *buf, size_t count)
> {
> 	int ret;
> 	u64 pfn;
>@@ -569,8 +562,8 @@ store_hard_offline_page(struct device *dev,
> 	return ret ? ret : count;
> }
> 
>-static DEVICE_ATTR(soft_offline_page, S_IWUSR, NULL, store_soft_offline_page);
>-static DEVICE_ATTR(hard_offline_page, S_IWUSR, NULL, store_hard_offline_page);
>+static DEVICE_ATTR_WO(soft_offline_page);
>+static DEVICE_ATTR_WO(hard_offline_page);
> #endif
> 
> /*
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
