Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82F8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F1C20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F1C20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeLKKp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:45:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51049 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKKp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:45:26 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 1665ef04eab9dd22; Tue, 11 Dec 2018 11:45:23 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c24xx: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Tue, 11 Dec 2018 11:45:05 +0100
Message-ID: <1989663.EJsIJGg71O@aspire.rjw.lan>
In-Reply-To: <20181108044503.7zqgi3cjsxnsziuo@vireshk-i7>
References: <20181107161346.9887-1-tiny.windzz@gmail.com> <20181108044503.7zqgi3cjsxnsziuo@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, November 8, 2018 5:45:03 AM CET Viresh Kumar wrote:
> On 07-11-18, 11:13, Yangtao Li wrote:
> > Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/cpufreq/s3c24xx-cpufreq-debugfs.c | 46 +++--------------------
> >  1 file changed, 6 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> > index 4d976e8dbb2f..0df87b6480fe 100644
> > --- a/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> > +++ b/drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
> > @@ -63,18 +63,7 @@ static int board_show(struct seq_file *seq, void *p)
> >  	return 0;
> >  }
> >  
> > -static int fops_board_open(struct inode *inode, struct file *file)
> > -{
> > -	return single_open(file, board_show, NULL);
> > -}
> > -
> > -static const struct file_operations fops_board = {
> > -	.open		= fops_board_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= single_release,
> > -	.owner		= THIS_MODULE,
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(board);
> >  
> >  static int info_show(struct seq_file *seq, void *p)
> >  {
> > @@ -105,18 +94,7 @@ static int info_show(struct seq_file *seq, void *p)
> >  	return 0;
> >  }
> >  
> > -static int fops_info_open(struct inode *inode, struct file *file)
> > -{
> > -	return single_open(file, info_show, NULL);
> > -}
> > -
> > -static const struct file_operations fops_info = {
> > -	.open		= fops_info_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= single_release,
> > -	.owner		= THIS_MODULE,
> > -};
> > +DEFINE_SHOW_ATTRIBUTE(info);
> >  
> >  static int io_show(struct seq_file *seq, void *p)
> >  {
> > @@ -162,19 +140,7 @@ static int io_show(struct seq_file *seq, void *p)
> >  	return 0;
> >  }
> >  
> > -static int fops_io_open(struct inode *inode, struct file *file)
> > -{
> > -	return single_open(file, io_show, NULL);
> > -}
> > -
> > -static const struct file_operations fops_io = {
> > -	.open		= fops_io_open,
> > -	.read		= seq_read,
> > -	.llseek		= seq_lseek,
> > -	.release	= single_release,
> > -	.owner		= THIS_MODULE,
> > -};
> > -
> > +DEFINE_SHOW_ATTRIBUTE(io);
> >  
> >  static int __init s3c_freq_debugfs_init(void)
> >  {
> > @@ -185,13 +151,13 @@ static int __init s3c_freq_debugfs_init(void)
> >  	}
> >  
> >  	dbgfs_file_io = debugfs_create_file("io-timing", S_IRUGO, dbgfs_root,
> > -					    NULL, &fops_io);
> > +					    NULL, &io_fops);
> >  
> >  	dbgfs_file_info = debugfs_create_file("info", S_IRUGO, dbgfs_root,
> > -					      NULL, &fops_info);
> > +					      NULL, &info_fops);
> >  
> >  	dbgfs_file_board = debugfs_create_file("board", S_IRUGO, dbgfs_root,
> > -					       NULL, &fops_board);
> > +					       NULL, &board_fops);
> >  
> >  	return 0;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!

