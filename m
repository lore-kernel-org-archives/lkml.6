Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8D4C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A06C20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 16:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A06C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-pingi.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeIBUrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 16:47:31 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:40311 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeIBUrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 16:47:31 -0400
Received: from mailone.linux-pingi.de ([84.176.100.82]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0M7sUy-1fjUfk3TlI-00vRtE; Sun, 02 Sep 2018 18:31:08 +0200
Received: from [10.23.200.0] (pingi.linux-pingi.de [10.23.200.0])
        by mailone.linux-pingi.de (Postfix) with ESMTPSA id D801772005;
        Sun,  2 Sep 2018 18:31:59 +0200 (CEST)
Subject: Re: [PATCH] isdn: mISDN: tei: Fix a sleep-in-atomic-context bug in
 create_teimgr()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180901120019.31664-1-baijiaju1990@gmail.com>
From:   isdn@linux-pingi.de
Message-ID: <3ecd32b2-81e5-038e-edc9-fd06d6e21851@linux-pingi.de>
Date:   Sun, 2 Sep 2018 18:31:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180901120019.31664-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/rL/6r+2jH/8bTewqfByN2RSZiad6zbfJPT/a1SbnxYeM/gygNn
 Y0n+/SzY+p4+yuGYiNzM/bn99H5zsVTGG8/hPW6LgmxtSITolyIJSkXTqW5r81sDOS5AGPi
 C0w0ccP0VCuEyItiNwCrdajbkhg3DlLXWWitMuQHcdml7CwdEGJjDVIMu7jv0TaJaWJP1kE
 COlUYSJJgPhMjqov5D1pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:am8LP3aVpyw=:hQf+X4OrTvQnP2RyFH70YX
 Yz3VYTPfLgmBpChh6KaY8VbS3kB6ZitcB3MtcQ59kzmit6872XhOpcxJsSD6EjjHSH/af1VO+
 yqwuM7kUUvl9hP241sxwT324gDM7Z6HFMhsGp18aL/YZTv4K9CUxBQ7bBPB7rW0VAUnHm7YBq
 6pZHSinxKQI6QpwxVG0m91NYqETE5IfZGE5VVS92ancnVJ1Lj9j2Xflpu4pKcmEubMJA+ZbVT
 l60nptKy76l5wGGx4htpPn6U+9ILu6q+YhAR+vKAy42uGlQXWSbsLI6MibOZW2xJSU7bPqS7P
 xc9lflT+l/qTvdMGkpG+lj7iqE73nF9UiyyAM2LlVKNvWnlO6TrBvNNV4Q/89gosv308Wtrz8
 dGroqh2Jw7WHGZqx1MrpQhtZQK4XznOAhUrBvZdiuDwt9U1jHbWlptH9DLHkyM1xATx/AFK76
 6fAhOxj7YguNa0inPjzmBS6AzwPBF1CIa9ZTJzc8qM/JpMcij6SsKdgRAcSwshdTKYY02qxVJ
 yQ2gK9ul8yfY6heNUZO5c9JTtw76a5dHym+soVfmjJ5YymKEOUtARm7EyRdSRbGqrcD20qcND
 eKBaF4wLKQC8+RAdBKa7lpjOR7aKEdxUA0QxJjmzJSBP5xEnYgGEW5OlusEfgkxwR6XYwYPVJ
 yMb8IJ1CtgROT/LfZaOJKGwsMO/dzBYbd+kpduSb7s5nxD2CTdbMEV0lt2hMpfqlrOzfMhKoE
 R1QIWRkqhR8Ur1d5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I do not understand the analysis and do not see that the spinlock is a
problem here.
I think your DSAC analyzer assumes that the FUNC_PTR mgr_ctrl call calls
the  mgr_ctrl in tei.c, but in real it calls l2->ch.ctrl() which is the
function in layer2.c, not tei.c. And the function in layer2.c should not
do any GFP_KERNEL allocation.

Same for your 2. reported issue.

Am 01.09.2018 um 14:00 schrieb Jia-Ju Bai:
> The kernel module may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] kzalloc(GFP_KERNEL)
> drivers/isdn/mISDN/tei.c, 1058: kzalloc in create_teimgr
> drivers/isdn/mISDN/tei.c, 1278: create_teimgr in mgr_ctrl
> drivers/isdn/mISDN/tei.c, 1048: [FUNC_PTR]mgr_ctrl in create_teimgr
> drivers/isdn/mISDN/tei.c, 1045: _raw_read_lock_irqsave in create_teimgr
> 
> Note that [FUNC_PTR] means a function pointer call is used.
> 
> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> This bug is found by my static analysis tool DSAC.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/isdn/mISDN/tei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/isdn/mISDN/tei.c b/drivers/isdn/mISDN/tei.c
> index 12d9e5f4beb1..6d95ee639fdb 100644
> --- a/drivers/isdn/mISDN/tei.c
> +++ b/drivers/isdn/mISDN/tei.c
> @@ -1055,7 +1055,7 @@ create_teimgr(struct manager *mgr, struct channel_req *crq)
>  		       crq->adr.tei, crq->adr.sapi);
>  	if (!l2)
>  		return -ENOMEM;
> -	l2->tm = kzalloc(sizeof(struct teimgr), GFP_KERNEL);
> +	l2->tm = kzalloc(sizeof(struct teimgr), GFP_ATOMIC);
>  	if (!l2->tm) {
>  		kfree(l2);
>  		printk(KERN_ERR "kmalloc teimgr failed\n");
> 

