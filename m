Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C2BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFF92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="FCNk+qrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFF92082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbeLJSWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:22:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44455 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeLJSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:22:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so5328783pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=lTY3D4r5yGkpD3rZ57IKw7/+ANtgLoTbxcVlf5RMU84=;
        b=FCNk+qrIqQAwS6xX3xacqkE6qfO6S45Jqg8d8x23q2HoPVYQvK8/7tB62pQw46EDWA
         BpGTcjUYpcRaSbSZowy8DFoJzWhsA6kyNzGY5dqQtFCPczib/ft6oz7cwxLKl1aVsNru
         6mOU5m9h669OYo0edttPmoz6Sb6bwlOg/o7ifXU+n1bVeLISJaIqZd99Hnnngy18GZH4
         MZWJLirtG3HWUE3CU+2VehGhGyK3smEcFLLR1/I/yk8ORrjlVGSqFGDWSWZTdWqB+KSX
         Ib6Fh08Az475VBLTu57202hKy3tkciSyJmeXa5UMH41LRU0hROWKJcYXE9JlYbaOpZhb
         bNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=lTY3D4r5yGkpD3rZ57IKw7/+ANtgLoTbxcVlf5RMU84=;
        b=tvpG8InjWS5oYjEG4eonR2HrP6Azlq3WaVvPFKAGuVgwLO8KvpBIZbCpxWPIO0bJ7P
         nxmlZpI/IPwKUrqHwRrwOIT+7sX9RmeKXgsVdYg1u2lbx1m+KruxXp8L8eYU2LFRgny6
         gGRRrEqsS/W3KDi7s5ie4UmXJJnHs8RAdFrwyvYsjTKaNmDlgNIJ6l42eAsZ2AHkvNkT
         lmDs8pUWovvkdKtQJVMeDy19/qQ9+jC6NmrfASDlGGmmQgfzSxmh4g6aq2E7HxmruJ/q
         2vvFHfrEvksbRLC7weMHndHXEWPK5hPbfYGZ/TZyUtaMc8C4P03tqOmi5uJySS6xVCgJ
         1JBA==
X-Gm-Message-State: AA+aEWYZ2ptFUyCN8L6KBG0aUgTsEgBbTrLKsrEesW7vpseuABZ9aftQ
        3xJeuWI5qjjYhdCsG/S5Z/lJIQ==
X-Google-Smtp-Source: AFSGD/Vb9PSBzejUbnUMeVDxBsl2+MI9g96u3FGAA+DzhgHZ4eJ42M+N6VuQtroCjsvNrRbI54Ac1A==
X-Received: by 2002:a63:7219:: with SMTP id n25mr11835982pgc.324.1544466121232;
        Mon, 10 Dec 2018 10:22:01 -0800 (PST)
Received: from cakuba.netronome.com (c-73-162-4-14.hsd1.ca.comcast.net. [73.162.4.14])
        by smtp.gmail.com with ESMTPSA id 85sm17315851pfw.17.2018.12.10.10.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 10:22:01 -0800 (PST)
Date:   Mon, 10 Dec 2018 10:21:57 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181210102157.6fa8fd8b@cakuba.netronome.com>
In-Reply-To: <20181210160327.20811-1-tiny.windzz@gmail.com>
References: <20181210160327.20811-1-tiny.windzz@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 11:03:27 -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Please post v2 with the subject prefix set to "netdevsim:" rather than
"bpf:".

>  drivers/net/netdevsim/bpf.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
> index cb3518474f0e..14b4d9774708 100644
> --- a/drivers/net/netdevsim/bpf.c
> +++ b/drivers/net/netdevsim/bpf.c
> @@ -48,7 +48,7 @@ struct nsim_bpf_bound_map {
>  	struct list_head l;
>  };
>  
> -static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
> +static int nsim_bpf_string_show(struct seq_file *file, void *data)
>  {
>  	const char **str = file->private;
>  
> @@ -57,19 +57,7 @@ static int nsim_debugfs_bpf_string_read(struct seq_file *file, void *data)
>  
>  	return 0;
>  }
> -
> -static int nsim_debugfs_bpf_string_open(struct inode *inode, struct file *f)
> -{
> -	return single_open(f, nsim_debugfs_bpf_string_read, inode->i_private);
> -}
> -
> -static const struct file_operations nsim_bpf_string_fops = {
> -	.owner = THIS_MODULE,
> -	.open = nsim_debugfs_bpf_string_open,
> -	.release = single_release,
> -	.read = seq_read,
> -	.llseek = seq_lseek
> -};
> +DEFINE_SHOW_ATTRIBUTE(nsim_bpf_string);
>  
>  static int
>  nsim_bpf_verify_insn(struct bpf_verifier_env *env, int insn_idx, int prev_insn)

