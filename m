Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100FCECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8422520C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMrxQ4fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8422520C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGQM6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:58:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44996 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeGQM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:58:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HCNqpU183172;
        Tue, 17 Jul 2018 12:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=WMx9rQ8lAgRj6r1Lbl9q0LC6ynD+2FsBavzU3GyhdVQ=;
 b=XMrxQ4fkC3cLWnF75dSwBiUFSWcB0EKbrbZ+nAHBq570Nzelr7B9IEpn1yQdGy/ipX0f
 EF3eDEKapIyW+XkaWFlAv1BMp1BLHjzMBKINgVfTUrfv3CF+d+Pfm+Csw3qls84blDgY
 AcwLTSOIuUjVyWDMon3KCVqlAxiza0kWj9v70iI0ngxwR6B/VSSyxWvbusaw1XMb4+l8
 wox6ciqJHYcTMj4JIP8vZ0LH6OHnT8je67vl2IgOkCEc+5j+5oBshP7RT3/GOHHMBT98
 oSCKeq/PRXcKxWrSwmaKTjt2XytaYObGgMt4AZe6sfd6bX/Tx4Oud2FBVouZQ8UIg6z0 Gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k7a340dgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 12:26:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6HCQ5Tw004415
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 12:26:05 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HCQ5JX003091;
        Tue, 17 Jul 2018 12:26:05 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 05:26:04 -0700
Date:   Tue, 17 Jul 2018 15:25:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, RAGHU Halharvi <raghuhack78@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        RAGHU Halharvi <raghuhack78@gmail.com>, tglx@linutronix.de
Subject: Re: [PATCH] genirq:Dereference desc after null pointer check
Message-ID: <20180717122557.joykttug2wr55sf7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180716222725.14896-1-raghuhack78@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi RAGHU,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/RAGHU-Halharvi/genirq-Dereference-desc-after-null-pointer-check/20180717-150842

smatch warnings:
kernel/irq/manage.c:1571 __free_irq() error: uninitialized symbol 'irq'.

# https://github.com/0day-ci/linux/commit/3ebb02d34bcb1c8111a79856326bca85fb3321eb
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 3ebb02d34bcb1c8111a79856326bca85fb3321eb
vim +/irq +1571 kernel/irq/manage.c

d3c60047 Thomas Gleixner                2008-10-16  1560  
cbf94f06 Magnus Damm                    2009-03-12  1561  /*
cbf94f06 Magnus Damm                    2009-03-12  1562   * Internal function to unregister an irqaction - used to free
cbf94f06 Magnus Damm                    2009-03-12  1563   * regular and special interrupts that are part of the architecture.
^1da177e Linus Torvalds                 2005-04-16  1564   */
83ac4ca9 Uwe Kleine König               2018-03-19  1565  static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
^1da177e Linus Torvalds                 2005-04-16  1566  {
3ebb02d3 RAGHU Halharvi                 2018-07-17  1567  	unsigned int irq;
f17c7545 Ingo Molnar                    2009-02-17  1568  	struct irqaction *action, **action_ptr;
^1da177e Linus Torvalds                 2005-04-16  1569  	unsigned long flags;
^1da177e Linus Torvalds                 2005-04-16  1570  
ae88a23b Ingo Molnar                    2009-02-15 @1571  	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
                                                                                                                                  ^^^
Not initialized.

7d94f7ca Yinghai Lu                     2008-08-19  1572  
7d94f7ca Yinghai Lu                     2008-08-19  1573  	if (!desc)
f21cfb25 Magnus Damm                    2009-03-12  1574  		return NULL;
^1da177e Linus Torvalds                 2005-04-16  1575  
3ebb02d3 RAGHU Halharvi                 2018-07-17  1576  	irq = desc->irq_data.irq;
9114014c Thomas Gleixner                2017-06-29  1577  	mutex_lock(&desc->request_mutex);
abc7e40c Thomas Gleixner                2015-12-13  1578  	chip_bus_lock(desc);
239007b8 Thomas Gleixner                2009-11-17  1579  	raw_spin_lock_irqsave(&desc->lock, flags);
ae88a23b Ingo Molnar                    2009-02-15  1580  
ae88a23b Ingo Molnar                    2009-02-15  1581  	/*
ae88a23b Ingo Molnar                    2009-02-15  1582  	 * There can be multiple actions per IRQ descriptor, find the right
ae88a23b Ingo Molnar                    2009-02-15  1583  	 * one based on the dev_id:
ae88a23b Ingo Molnar                    2009-02-15  1584  	 */
f17c7545 Ingo Molnar                    2009-02-17  1585  	action_ptr = &desc->action;
^1da177e Linus Torvalds                 2005-04-16  1586  	for (;;) {
f17c7545 Ingo Molnar                    2009-02-17  1587  		action = *action_ptr;
^1da177e Linus Torvalds                 2005-04-16  1588  
ae88a23b Ingo Molnar                    2009-02-15  1589  		if (!action) {
ae88a23b Ingo Molnar                    2009-02-15  1590  			WARN(1, "Trying to free already-free IRQ %d\n", irq);
239007b8 Thomas Gleixner                2009-11-17  1591  			raw_spin_unlock_irqrestore(&desc->lock, flags);
abc7e40c Thomas Gleixner                2015-12-13  1592  			chip_bus_sync_unlock(desc);
19d39a38 Thomas Gleixner                2017-07-11  1593  			mutex_unlock(&desc->request_mutex);
f21cfb25 Magnus Damm                    2009-03-12  1594  			return NULL;
ae88a23b Ingo Molnar                    2009-02-15  1595  		}
^1da177e Linus Torvalds                 2005-04-16  1596  
8316e381 Ingo Molnar                    2009-02-17  1597  		if (action->dev_id == dev_id)
ae88a23b Ingo Molnar                    2009-02-15  1598  			break;
f17c7545 Ingo Molnar                    2009-02-17  1599  		action_ptr = &action->next;
ae88a23b Ingo Molnar                    2009-02-15  1600  	}
^1da177e Linus Torvalds                 2005-04-16  1601  
ae88a23b Ingo Molnar                    2009-02-15  1602  	/* Found it - now remove it from the list of entries: */
f17c7545 Ingo Molnar                    2009-02-17  1603  	*action_ptr = action->next;
dbce706e Paolo 'Blaisorblade' Giarrusso 2005-06-21  1604  
cab303be Thomas Gleixner                2014-08-28  1605  	irq_pm_remove_action(desc, action);
cab303be Thomas Gleixner                2014-08-28  1606  
ae88a23b Ingo Molnar                    2009-02-15  1607  	/* If this was the last handler, shut down the IRQ line: */
c1bacbae Thomas Gleixner                2014-03-08  1608  	if (!desc->action) {
e9849777 Thomas Gleixner                2015-10-09  1609  		irq_settings_clr_disable_unlazy(desc);
46999238 Thomas Gleixner                2011-02-02  1610  		irq_shutdown(desc);
c1bacbae Thomas Gleixner                2014-03-08  1611  	}
3aa551c9 Thomas Gleixner                2009-03-23  1612  

:::::: The code at line 1571 was first introduced by commit
:::::: ae88a23b32fa7e0dc9fa7ce735966e68eb41b0bc irq: refactor and clean up the free_irq() code flow

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
