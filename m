Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57EBC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5DA20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RyzLrolJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5DA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbeFTJWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:22:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42136 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFTJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:22:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K9IbRJ096271;
        Wed, 20 Jun 2018 09:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2017-10-26; bh=64WYT0mqi7yAH0J8iFdK0TEMe1kF7yy+nFrkU28XalA=;
 b=RyzLrolJuXxmrLCe7+xJhCbeVnrqoDyo4L30lYMO5gPWEzb9nq4qJcRwqfFxExKFyni0
 ao5glcSrGukub+aGsMoGGNBLNZFMCYcG1rTscY+ptRtD4lrwRAgaP1MDEK0StV5XouA0
 qFRGqd6f5Sp17WLXPowKRl4/v+S6nt0oHlWqxD11DslXOd7/Ib6zoYIps9ZrPMIDr5Rb
 HFz4MVACRPo1e/X3V6DpGKXJN49aYLyk/I3rZPhsC8kqt8UNoX7H/e5STfADZGdC2kGR
 bf1rlBOlX0d7zSAyFgtxteqy2zr36Zux05Ol/sFP20vv/8WbGc+MBg8ABIXbYJow8+8E uA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jmu6xuk16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 09:22:31 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5K9MUlW018478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 09:22:30 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K9MTEH007851;
        Wed, 20 Jun 2018 09:22:29 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 02:22:29 -0700
Date:   Wed, 20 Jun 2018 12:22:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Michal Kubecek <mkubecek@suse.cz>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] proc: add missing '\0' back to /proc/$pid/cmdline
Message-ID: <20180620092221.wzjwnvfckmoe5s2s@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619162411.B2B7AA1081@unicorn.suse.cz>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch! Perhaps something to improve:

url:    https://github.com/0day-ci/linux/commits/Michal-Kubecek/proc-add-missing-0-back-to-proc-pid-cmdline/20180620-015310

New smatch warnings:
fs/proc/base.c:248 get_mm_cmdline() error: uninitialized symbol 'pos'.

Old smatch warnings:
fs/proc/base.c:1882 proc_fill_cache() error: 'child' dereferencing possible ERR_PTR()

# https://github.com/0day-ci/linux/commit/b305ec6298033adaaac8c8598028f0ca1a1234b9
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout b305ec6298033adaaac8c8598028f0ca1a1234b9
vim +/pos +248 fs/proc/base.c

^1da177e Linus Torvalds  2005-04-16  207  
e4b4e441 Linus Torvalds  2018-05-17  208  static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
5ab82718 Linus Torvalds  2018-05-17  209  			      size_t count, loff_t *ppos)
^1da177e Linus Torvalds  2005-04-16  210  {
c2c0bb44 Alexey Dobriyan 2015-06-25  211  	unsigned long arg_start, arg_end, env_start, env_end;
b305ec62 Michal Kubecek  2018-06-19  212  	unsigned long req_pos, pos, len;
b305ec62 Michal Kubecek  2018-06-19  213  	bool end_found = false;
5ab82718 Linus Torvalds  2018-05-17  214  	char *page;
c2c0bb44 Alexey Dobriyan 2015-06-25  215  
c2c0bb44 Alexey Dobriyan 2015-06-25  216  	/* Check if process spawned far enough to have cmdline. */
e4b4e441 Linus Torvalds  2018-05-17  217  	if (!mm->env_end)
e4b4e441 Linus Torvalds  2018-05-17  218  		return 0;
c2c0bb44 Alexey Dobriyan 2015-06-25  219  
88aa7cc6 Yang Shi        2018-06-07  220  	spin_lock(&mm->arg_lock);
c2c0bb44 Alexey Dobriyan 2015-06-25  221  	arg_start = mm->arg_start;
c2c0bb44 Alexey Dobriyan 2015-06-25  222  	arg_end = mm->arg_end;
c2c0bb44 Alexey Dobriyan 2015-06-25  223  	env_start = mm->env_start;
c2c0bb44 Alexey Dobriyan 2015-06-25  224  	env_end = mm->env_end;
88aa7cc6 Yang Shi        2018-06-07  225  	spin_unlock(&mm->arg_lock);
c2c0bb44 Alexey Dobriyan 2015-06-25  226  
5ab82718 Linus Torvalds  2018-05-17  227  	if (arg_start >= arg_end)
5ab82718 Linus Torvalds  2018-05-17  228  		return 0;
6a6cbe75 Alexey Dobriyan 2018-06-07  229  
2ca66ff7 Alexey Dobriyan 2014-08-08  230  	/*
5ab82718 Linus Torvalds  2018-05-17  231  	 * We have traditionally allowed the user to re-write
5ab82718 Linus Torvalds  2018-05-17  232  	 * the argument strings and overflow the end result
5ab82718 Linus Torvalds  2018-05-17  233  	 * into the environment section. But only do that if
5ab82718 Linus Torvalds  2018-05-17  234  	 * the environment area is contiguous to the arguments.
2ca66ff7 Alexey Dobriyan 2014-08-08  235  	 */
5ab82718 Linus Torvalds  2018-05-17  236  	if (env_start != arg_end || env_start >= env_end)
5ab82718 Linus Torvalds  2018-05-17  237  		env_start = env_end = arg_end;
3cb4e162 Alexey Dobriyan 2018-06-07  238  
5ab82718 Linus Torvalds  2018-05-17  239  	/* We're not going to care if "*ppos" has high bits set */
b305ec62 Michal Kubecek  2018-06-19  240  	req_pos = arg_start + *ppos;
c2c0bb44 Alexey Dobriyan 2015-06-25  241  
5ab82718 Linus Torvalds  2018-05-17  242  	/* .. but we do check the result is in the proper range */
b305ec62 Michal Kubecek  2018-06-19  243  	if (req_pos < arg_start || req_pos >= env_end)
5ab82718 Linus Torvalds  2018-05-17  244  		return 0;
3cb4e162 Alexey Dobriyan 2018-06-07  245  
5ab82718 Linus Torvalds  2018-05-17  246  	/* .. and we never go past env_end */
b305ec62 Michal Kubecek  2018-06-19  247  	if (env_end - req_pos < count)
5ab82718 Linus Torvalds  2018-05-17 @248  		count = env_end - pos;
c2c0bb44 Alexey Dobriyan 2015-06-25  249  
b305ec62 Michal Kubecek  2018-06-19  250  	pos = min_t(unsigned long, req_pos, arg_end - 1);
5ab82718 Linus Torvalds  2018-05-17  251  	page = (char *)__get_free_page(GFP_KERNEL);
5ab82718 Linus Torvalds  2018-05-17  252  	if (!page)
5ab82718 Linus Torvalds  2018-05-17  253  		return -ENOMEM;
5ab82718 Linus Torvalds  2018-05-17  254  
5ab82718 Linus Torvalds  2018-05-17  255  	len = 0;
b305ec62 Michal Kubecek  2018-06-19  256  	while (count && !end_found) {
5ab82718 Linus Torvalds  2018-05-17  257  		int got;
b305ec62 Michal Kubecek  2018-06-19  258  		size_t size = count + (pos < req_pos ? req_pos - pos : 0);
5ab82718 Linus Torvalds  2018-05-17  259  
b305ec62 Michal Kubecek  2018-06-19  260  		size = min_t(size_t, PAGE_SIZE, size);
5ab82718 Linus Torvalds  2018-05-17  261  		got = access_remote_vm(mm, pos, page, size, FOLL_ANON);
5ab82718 Linus Torvalds  2018-05-17  262  		if (got <= 0)
5ab82718 Linus Torvalds  2018-05-17  263  			break;
5ab82718 Linus Torvalds  2018-05-17  264  
5ab82718 Linus Torvalds  2018-05-17  265  		/* Don't walk past a NUL character once you hit arg_end */
5ab82718 Linus Torvalds  2018-05-17  266  		if (pos + got >= arg_end) {
5ab82718 Linus Torvalds  2018-05-17  267  			int n = 0;
c2c0bb44 Alexey Dobriyan 2015-06-25  268  
c2c0bb44 Alexey Dobriyan 2015-06-25  269  			/*
5ab82718 Linus Torvalds  2018-05-17  270  			 * If we started before 'arg_end' but ended up
5ab82718 Linus Torvalds  2018-05-17  271  			 * at or after it, we start the NUL character
5ab82718 Linus Torvalds  2018-05-17  272  			 * check at arg_end-1 (where we expect the normal
5ab82718 Linus Torvalds  2018-05-17  273  			 * EOF to be).
5ab82718 Linus Torvalds  2018-05-17  274  			 *
5ab82718 Linus Torvalds  2018-05-17  275  			 * NOTE! This is smaller than 'got', because
5ab82718 Linus Torvalds  2018-05-17  276  			 * pos + got >= arg_end
c2c0bb44 Alexey Dobriyan 2015-06-25  277  			 */
5ab82718 Linus Torvalds  2018-05-17  278  			if (pos < arg_end)
5ab82718 Linus Torvalds  2018-05-17  279  				n = arg_end - pos - 1;
c2c0bb44 Alexey Dobriyan 2015-06-25  280  
5ab82718 Linus Torvalds  2018-05-17  281  			/* Cut off at first NUL after 'n' */
b305ec62 Michal Kubecek  2018-06-19  282  			n += strnlen(page + n, got - n);
b305ec62 Michal Kubecek  2018-06-19  283  			got = min_t(int, got, n + 1);
b305ec62 Michal Kubecek  2018-06-19  284  			end_found = !page[n];
5ab82718 Linus Torvalds  2018-05-17  285  			if (!got)
5ab82718 Linus Torvalds  2018-05-17  286  				break;
c2c0bb44 Alexey Dobriyan 2015-06-25  287  		}
c2c0bb44 Alexey Dobriyan 2015-06-25  288  
b305ec62 Michal Kubecek  2018-06-19  289  		if (pos + got <= req_pos) {
b305ec62 Michal Kubecek  2018-06-19  290  			/* got > 0 here so that pos always advances */
b305ec62 Michal Kubecek  2018-06-19  291  			pos += got;
b305ec62 Michal Kubecek  2018-06-19  292  			continue;
b305ec62 Michal Kubecek  2018-06-19  293  		}
b305ec62 Michal Kubecek  2018-06-19  294  
b305ec62 Michal Kubecek  2018-06-19  295  		if (pos < req_pos) {
b305ec62 Michal Kubecek  2018-06-19  296  			got -= (req_pos - pos);
b305ec62 Michal Kubecek  2018-06-19  297  			got -= copy_to_user(buf, page + req_pos - pos, got);
b305ec62 Michal Kubecek  2018-06-19  298  			pos = req_pos;
b305ec62 Michal Kubecek  2018-06-19  299  		} else {
5ab82718 Linus Torvalds  2018-05-17  300  			got -= copy_to_user(buf, page, got);
b305ec62 Michal Kubecek  2018-06-19  301  		}
5ab82718 Linus Torvalds  2018-05-17  302  		if (unlikely(!got)) {
5ab82718 Linus Torvalds  2018-05-17  303  			if (!len)
5ab82718 Linus Torvalds  2018-05-17  304  				len = -EFAULT;
5ab82718 Linus Torvalds  2018-05-17  305  			break;
c2c0bb44 Alexey Dobriyan 2015-06-25  306  		}
5ab82718 Linus Torvalds  2018-05-17  307  		pos += got;
5ab82718 Linus Torvalds  2018-05-17  308  		buf += got;
5ab82718 Linus Torvalds  2018-05-17  309  		len += got;
5ab82718 Linus Torvalds  2018-05-17  310  		count -= got;
c2c0bb44 Alexey Dobriyan 2015-06-25  311  	}
c2c0bb44 Alexey Dobriyan 2015-06-25  312  
c2c0bb44 Alexey Dobriyan 2015-06-25  313  	free_page((unsigned long)page);
5ab82718 Linus Torvalds  2018-05-17  314  	return len;
c2c0bb44 Alexey Dobriyan 2015-06-25  315  }
c2c0bb44 Alexey Dobriyan 2015-06-25  316  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
