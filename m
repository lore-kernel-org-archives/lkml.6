Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4308FECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E115F20871
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NDszZsCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E115F20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbeGNB7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 21:59:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbeGNB7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 21:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=75Wn5pvqDb/JW6G3ab1ZtBQW7fZbuI0Y79EurrCvFRA=; b=NDszZsCp6AB30VvYpoUBOgHb7f
        b1nCppUBVEcpY0v050TL3r8UyITUPGpmRZaPlfRrQcfRQMDeo4CqyodZogIuZHbF5Ke9/wBh3Nzlc
        0IS+eDrhfJgYgMqAGcT0R6GnLmIYLFB4wV8tRQTZXrI0qEVrayQ2WYlv0U+kYKw+L9vutdsPvxxDj
        4D+O8UJpOBrm1kXmBkMOhOEqNAHlPfJr5Qbc8TjAnBWuwJp0RGlvLTEQlhzoIHBxHYu+Wn2XksrBA
        OsrPyPF3MdyU82QOroOMqfha+NIbZoydq2eSlj2Um+0rBjW12lNVVGEyzsj8vvjPRCv2anfx2tnTM
        JtY1HY9A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fe9ZH-0005tv-NC; Sat, 14 Jul 2018 01:41:51 +0000
Subject: Re: mmotm 2018-07-13-16-51 uploaded (PSI)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20180713235138.HoxHd%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf4f5b65-6333-a1f0-6118-16fc0e5bc221@infradead.org>
Date:   Fri, 13 Jul 2018 18:41:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180713235138.HoxHd%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 04:51 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-07-13-16-51 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (4.x
> or 4.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.


../include/linux/psi.h:12:13: error: conflicting types for 'psi_disabled'
extern bool psi_disabled;


choose one:)

kernel/sched/psi.c:
bool psi_disabled __read_mostly;


include/linux/sched/stat.h:
	extern int psi_disabled;




-- 
~Randy
