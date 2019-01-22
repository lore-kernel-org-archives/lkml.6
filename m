Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6A8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2482085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfAVStA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:49:00 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:43904 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAVSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:48:59 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-66-19-nat.elisa-mobile.fi [85.76.66.19])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 8EFBA300BC;
        Tue, 22 Jan 2019 20:48:56 +0200 (EET)
Date:   Tue, 22 Jan 2019 20:48:56 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/5] mips: cavium: no need to check return value of
 debugfs_create functions
Message-ID: <20190122184855.GB2792@darkstar.musicnaut.iki.fi>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
 <20190122145742.11292-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122145742.11292-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 22, 2019 at 03:57:38PM +0100, Greg Kroah-Hartman wrote:
> -static int init_debufs(void)
> +static void init_debugfs(void)
>  {
> -	struct dentry *show_dentry;
>  	dir = debugfs_create_dir("oct_ilm", 0);
> -	if (!dir) {
> -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
> -		return -1;
> -	}
> -
> -	show_dentry = debugfs_create_file("statistics", 0222, dir, NULL,
> -					  &oct_ilm_ops);
> -	if (!show_dentry) {
> -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/statistics\n");
> -		return -1;
> -	}
> -
> -	show_dentry = debugfs_create_file("reset", 0222, dir, NULL,
> -					  &reset_statistics_ops);
> -	if (!show_dentry) {
> -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/reset\n");
> -		return -1;
> -	}
> -
> +	debugfs_create_file("statistics", 0222, dir, NULL, &oct_ilm_ops);
> +	debugfs_create_file("reset", 0222, dir, NULL, &reset_statistics_ops);
>  	return 0;

The return needs to be deleted now that the function is void.

A.
