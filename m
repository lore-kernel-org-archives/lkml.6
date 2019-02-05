Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172BCC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A402081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ym7fciJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBEE05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:26:57 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfBEE05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 23:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dAckLqnQQOE1fjRR4tubQoeoFlDG7wd4nClEhSSOuC4=; b=ym7fciJ1UUdOffT5UCkxTFQPSO
        eVfQLDrPjo6RPeZR8mEfHjRD5+Fdw4JVUFh5QCjVE/7lj4l1OU/uZ0yLYe7k7mZ+4/j6c8MwCaHhg
        wrTe8jT01a6GUJsqsEtCgR1DDR1/O6T9uxLCNjjKnaUY7Xv06Xks4upFjF4Bn7GmJD9I5A79weRo1
        4ud7qaEdoSp0vw0XmWaEUd2No3C8HkZkgHJzyZP+x0B9FJQR4AObUcZiDMM5vV7dJAnfby2KnLidH
        3CUt32LHZYCX7boBRC86+pFZ1yCGflhw4xhS76BtHBS8KshWZXwKI6QpcvHRXlAOcQ5Y7WLtxe8A2
        RQbMKIcA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqsJr-0007gu-QH; Tue, 05 Feb 2019 04:26:48 +0000
Subject: Re: mmotm 2019-02-04-17-47 uploaded (fs/binfmt_elf.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20190205014806.rQcAx%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <08a894b1-66f6-19bf-67be-c9b7b1b01126@infradead.org>
Date:   Mon, 4 Feb 2019 20:26:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190205014806.rQcAx%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 5:48 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-02-04-17-47 has been uploaded to
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

on x86_64 UML: (although should be many places)

../fs/binfmt_elf.c: In function ‘write_note_info’:
../fs/binfmt_elf.c:2122:19: error: ‘tmp’ undeclared (first use in this function)
   for (i = 0; i < tmp->num_notes; i++)
                   ^



-- 
~Randy
