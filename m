Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C51AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC0B20862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC0B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeGZX6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:58:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51106 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbeGZX6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:58:41 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 73AF840B;
        Thu, 26 Jul 2018 22:39:47 +0000 (UTC)
Date:   Thu, 26 Jul 2018 15:39:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Antonio Nino Diaz <antonio.ninodiaz@arm.com>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_maintainer: Allow usage outside of kernel tree
Message-Id: <20180726153946.3d81bf367cef7fe241bb3741@linux-foundation.org>
In-Reply-To: <04452ac6-1575-f612-72c6-6ea88e70a9d5@arm.com>
References: <04452ac6-1575-f612-72c6-6ea88e70a9d5@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 11:07:03 +0100 Antonio Nino Diaz <antonio.ninodiaz@arm.com> wrote:

> Add option '--no-tree' to get_maintainer.pl script to allow using this
> script in projects that aren't the Linux kernel if they use the same
> format for their MAINTAINERS file. This command is also available in
> checkpatch.pl, for example.
> 

Seems OK to me?

Please note that your email client is converting tabs to spaces.

> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -48,6 +48,7 @@ my $output_roles = 0;
>  my $output_rolestats = 1;
>  my $output_section_maxlen = 50;
>  my $scm = 0;
> +my $tree = 1;
>  my $web = 0;
>  my $subsystem = 0;
>  my $status = 0;
> @@ -255,6 +256,7 @@ if (!GetOptions(
>                 'subsystem!' => \$subsystem,
>                 'status!' => \$status,
>                 'scm!' => \$scm,
> +               'tree!' => \$tree,
>                 'web!' => \$web,
>                 'letters=s' => \$letters,
>                 'pattern-depth=i' => \$pattern_depth,
> @@ -319,7 +321,7 @@ if ($email &&
>      die "$P: Please select at least 1 email option\n";
>  }
> 
> -if (!top_of_kernel_tree($lk_path)) {
> +if ($tree && !top_of_kernel_tree($lk_path)) {
>      die "$P: The current directory does not appear to be "
>         . "a linux kernel source tree.\n";
>  }
> @@ -1031,13 +1033,14 @@ Other options:
>    --sections => print all of the subsystem sections with pattern matches
>    --letters => print all matching 'letter' types from all matching sections
>    --mailmap => use .mailmap file (default: $email_use_mailmap)
> +  --no-tree => run without a kernel tree
>    --self-test => show potential issues with MAINTAINERS file content
>    --version => show version
>    --help => show this help information
> 
>  Default options:
> -  [--email --nogit --git-fallback --m --r --n --l --multiline --pattern-depth=0
> -   --remove-duplicates --rolestats]
> +  [--email --tree --nogit --git-fallback --m --r --n --l --multiline
> +   --pattern-depth=0 --remove-duplicates --rolestats]
> 
>  Notes:
>    Using "-f directory" may give unexpected results:


