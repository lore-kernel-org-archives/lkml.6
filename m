Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319E1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C0420C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pI/taAQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C0420C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbeGQN4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 09:56:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44564 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731464AbeGQN4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 09:56:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so434625pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LNAgzu6p/t+1zxRxKVkx8sruxhdbhFwYyJsdiolBO7c=;
        b=pI/taAQ3IgbeM/146B0EYbXJB65ICeOeLnR82cY8dqXjqr9D/l4VBEDlHRaKDGRUK2
         lTbymUcT11QUB3Gixl9g2YKY1eyUYO0BV5bNtSwyx+xQRAUE27RD6CuP4VGY9LtYGXSM
         SBjPlfvDCW5KDjlSb5nwGiyh5p5jp7MJ7nPkZtzz5noPX2uIYAzw9FVOwjcxeqiBpM2b
         ano5sNIruKheLG0kLCNhXaK+IipNKh4jabE9yo7tWeIUWhb6OItBkzbQFeH9/Ftj6TvU
         7V9nAFp9RX/unr1WL/d4taR0V2bXk9+YORnUPea+VEWkniKtjzsU4SMaA/doD2VG9bMY
         q6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LNAgzu6p/t+1zxRxKVkx8sruxhdbhFwYyJsdiolBO7c=;
        b=bpDRv3GMBtm8XmccFgG45TmJD7+oremdnVjzLXmC4+6tcIaZOscpLyDe9k5ArvE3rz
         t5T7kmcndqVxYpwglXxu5eQuCFH4ndaPBUxdcKQumeN918Caq+NjWMrLWRuNOl5qvH1p
         v22tXLCvm6ccQ4uYNlqwsxTUPVCrG7uRb6bAahfzcmXzIYa77wSmziymrQ4qskX6lPxq
         2Gwc/CsIjZhdDGPnkF+S3T77aOlft4Rq0rdyu7PfqDrUCg5ByLb9qn/XCK6xpQ7omrdW
         ZOnGGUg/Z44+aPLY2MoyzNZj86b8T0BXBYlpP5Gn4O/sPPFR6eTE0+k2+xsEnkEm9oY1
         N0HA==
X-Gm-Message-State: AOUpUlErNAUaqCxs46/pYzak2ulqslCq4+XL5TcDK312V73jzwWeEdDw
        Mom8PQgr8k0Xhnla9msHEgQ=
X-Google-Smtp-Source: AAOMgpfGdzqxSfSBfDk4N3PS3jvI377QzScWYQrTDURQLLRfnOxQyH6W0Zv3WIp+wquV67Veyxj7Nw==
X-Received: by 2002:a63:8848:: with SMTP id l69-v6mr1544752pgd.377.1531833848572;
        Tue, 17 Jul 2018 06:24:08 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.12])
        by smtp.gmail.com with ESMTPSA id f5-v6sm2182947pga.58.2018.07.17.06.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 06:24:07 -0700 (PDT)
Date:   Tue, 17 Jul 2018 18:08:05 +0530
From:   RAGHU H <raghuhack78@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@01.org, kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] genirq:Dereference desc after null pointer check
Message-ID: <20180717123805.GA25982@raghu-VirtualBox>
References: <20180716222725.14896-1-raghuhack78@gmail.com>
 <20180717122557.joykttug2wr55sf7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180717122557.joykttug2wr55sf7@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes Dan, I should have done better.

Also Tom suggested to get rid of NULL pointer check as its redundant
because callee does that before calling __free_irq.


On Tue, Jul 17, 2018 at 03:25:57PM +0300, Dan Carpenter wrote:
> Hi RAGHU,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/RAGHU-Halharvi/genirq-Dereference-desc-after-null-pointer-check/20180717-150842
> 
> smatch warnings:
> kernel/irq/manage.c:1571 __free_irq() error: uninitialized symbol 'irq'.
> 
> # https://github.com/0day-ci/linux/commit/3ebb02d34bcb1c8111a79856326bca85fb3321eb
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 3ebb02d34bcb1c8111a79856326bca85fb3321eb
> vim +/irq +1571 kernel/irq/manage.c
> 
> d3c60047 Thomas Gleixner                2008-10-16  1560  
> cbf94f06 Magnus Damm                    2009-03-12  1561  /*
> cbf94f06 Magnus Damm                    2009-03-12  1562   * Internal function to unregister an irqaction - used to free
> cbf94f06 Magnus Damm                    2009-03-12  1563   * regular and special interrupts that are part of the architecture.
> ^1da177e Linus Torvalds                 2005-04-16  1564   */
> 83ac4ca9 Uwe Kleine König               2018-03-19  1565  static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
> ^1da177e Linus Torvalds                 2005-04-16  1566  {
> 3ebb02d3 RAGHU Halharvi                 2018-07-17  1567  	unsigned int irq;
> f17c7545 Ingo Molnar                    2009-02-17  1568  	struct irqaction *action, **action_ptr;
> ^1da177e Linus Torvalds                 2005-04-16  1569  	unsigned long flags;
> ^1da177e Linus Torvalds                 2005-04-16  1570  
> ae88a23b Ingo Molnar                    2009-02-15 @1571  	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
>                                                                                                                                   ^^^
> Not initialized.
> 
> 7d94f7ca Yinghai Lu                     2008-08-19  1572  
> 7d94f7ca Yinghai Lu                     2008-08-19  1573  	if (!desc)
> f21cfb25 Magnus Damm                    2009-03-12  1574  		return NULL;
> ^1da177e Linus Torvalds                 2005-04-16  1575  
> 3ebb02d3 RAGHU Halharvi                 2018-07-17  1576  	irq = desc->irq_data.irq;
> 9114014c Thomas Gleixner                2017-06-29  1577  	mutex_lock(&desc->request_mutex);
> abc7e40c Thomas Gleixner                2015-12-13  1578  	chip_bus_lock(desc);
> 239007b8 Thomas Gleixner                2009-11-17  1579  	raw_spin_lock_irqsave(&desc->lock, flags);
> ae88a23b Ingo Molnar                    2009-02-15  1580  
> ae88a23b Ingo Molnar                    2009-02-15  1581  	/*
> ae88a23b Ingo Molnar                    2009-02-15  1582  	 * There can be multiple actions per IRQ descriptor, find the right
> ae88a23b Ingo Molnar                    2009-02-15  1583  	 * one based on the dev_id:
> ae88a23b Ingo Molnar                    2009-02-15  1584  	 */
> f17c7545 Ingo Molnar                    2009-02-17  1585  	action_ptr = &desc->action;
> ^1da177e Linus Torvalds                 2005-04-16  1586  	for (;;) {
> f17c7545 Ingo Molnar                    2009-02-17  1587  		action = *action_ptr;
> ^1da177e Linus Torvalds                 2005-04-16  1588  
> ae88a23b Ingo Molnar                    2009-02-15  1589  		if (!action) {
> ae88a23b Ingo Molnar                    2009-02-15  1590  			WARN(1, "Trying to free already-free IRQ %d\n", irq);
> 239007b8 Thomas Gleixner                2009-11-17  1591  			raw_spin_unlock_irqrestore(&desc->lock, flags);
> abc7e40c Thomas Gleixner                2015-12-13  1592  			chip_bus_sync_unlock(desc);
> 19d39a38 Thomas Gleixner                2017-07-11  1593  			mutex_unlock(&desc->request_mutex);
> f21cfb25 Magnus Damm                    2009-03-12  1594  			return NULL;
> ae88a23b Ingo Molnar                    2009-02-15  1595  		}
> ^1da177e Linus Torvalds                 2005-04-16  1596  
> 8316e381 Ingo Molnar                    2009-02-17  1597  		if (action->dev_id == dev_id)
> ae88a23b Ingo Molnar                    2009-02-15  1598  			break;
> f17c7545 Ingo Molnar                    2009-02-17  1599  		action_ptr = &action->next;
> ae88a23b Ingo Molnar                    2009-02-15  1600  	}
> ^1da177e Linus Torvalds                 2005-04-16  1601  
> ae88a23b Ingo Molnar                    2009-02-15  1602  	/* Found it - now remove it from the list of entries: */
> f17c7545 Ingo Molnar                    2009-02-17  1603  	*action_ptr = action->next;
> dbce706e Paolo 'Blaisorblade' Giarrusso 2005-06-21  1604  
> cab303be Thomas Gleixner                2014-08-28  1605  	irq_pm_remove_action(desc, action);
> cab303be Thomas Gleixner                2014-08-28  1606  
> ae88a23b Ingo Molnar                    2009-02-15  1607  	/* If this was the last handler, shut down the IRQ line: */
> c1bacbae Thomas Gleixner                2014-03-08  1608  	if (!desc->action) {
> e9849777 Thomas Gleixner                2015-10-09  1609  		irq_settings_clr_disable_unlazy(desc);
> 46999238 Thomas Gleixner                2011-02-02  1610  		irq_shutdown(desc);
> c1bacbae Thomas Gleixner                2014-03-08  1611  	}
> 3aa551c9 Thomas Gleixner                2009-03-23  1612  
> 
> :::::: The code at line 1571 was first introduced by commit
> :::::: ae88a23b32fa7e0dc9fa7ce735966e68eb41b0bc irq: refactor and clean up the free_irq() code flow
> 
> :::::: TO: Ingo Molnar <mingo@elte.hu>
> :::::: CC: Ingo Molnar <mingo@elte.hu>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
