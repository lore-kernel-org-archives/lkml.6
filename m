Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GzRmHrDYGVtNaQAAmS7hNA
	; Fri, 08 Jun 2018 01:15:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 610846089E; Fri,  8 Jun 2018 01:15:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3pQN8Av"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D95B2606DD;
	Fri,  8 Jun 2018 01:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D95B2606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeFHBPZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:15:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59592 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeFHBPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6+BYgvPfX+NaAb31nf1ZXiZRGX3sXcILUg/pCZzpQ1c=; b=n3pQN8AvQfhQMc8C4s1uyUkfjM
        B2wncHCpdV6Q8tJPf0+NoU2qPVh/ZvbO3MdAI3xQvUmBaW52I426UoWVh8e7XT1gyXJQM/VjABHwG
        AttljBpShkxHjP6ea4HlfWBS1GLsLQ9fHxEWJytA9LVjxNx/X+fsiMadRDAmqcqKDrtMmWl/3VNmx
        s3WXKYMleufmsopR/Q87Kd5Y64ewXYzxCnxGU099YmH9VcalVV59E4+rE6p5k2gyr8qbix+43td8I
        ZFtWn8x8xm5awtN2BGhUsDyGQcj5SwDFSzZLasQ8Bi/Zc7QWfQxZEq3hDucsF7mG6zS+fI2A1lhoj
        nmVQClgQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fR5zt-0004DS-5T; Fri, 08 Jun 2018 01:15:21 +0000
Subject: Re: mmotm 2018-06-07-16-59 uploaded (scsi/ipr)
To: akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20180607235947.xWQtg%akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <656ccc09-951c-4b74-05a0-bc6f510a6453@infradead.org>
Date: Thu, 7 Jun 2018 18:15:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607235947.xWQtg%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 04:59 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-06-07-16-59 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 

on i386 (randconfig):

../drivers/scsi/ipr.c: In function 'ipr_mask_and_clear_interrupts':
../drivers/scsi/ipr.c:767:3: error: implicit declaration of function 'writeq_relaxed' [-Werror=implicit-function-declaration]
   writeq_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
   ^



need config?
-- 
~Randy
