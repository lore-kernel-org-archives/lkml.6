Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeFEJim (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:38:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35637 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeFEJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:38:40 -0400
X-Google-Smtp-Source: ADUXVKJ85E8cyiCRtO18QSi6ZZPfPSWgtPgSAM7GnWMJGuKlqxkCLFgMwch5Rl1npkhbVXjLGQM0/w==
Date: Tue, 5 Jun 2018 17:38:40 +0800
From: Wang YanQing <udknight@gmail.com>
To: axboe@kernel.dk, gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de, caizhiyong@hisilicon.com, rdunlap@infradead.org,
        jiangheng@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] block: add verifier for cmdline partition
Message-ID: <20180605093840.GA9488@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, axboe@kernel.dk,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        tglx@linutronix.de, caizhiyong@hisilicon.com, rdunlap@infradead.org,
        jiangheng@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180510030637.GA25734@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510030637.GA25734@udknight>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 11:06:37AM +0800, Wang YanQing wrote:
> I meet strange filesystem corruption issue recently, the reason
> is there are overlaps partitions in cmdline partition argument.
> 
> This patch add verifier for cmdline partition, then if there are
> overlaps partitions, cmdline_partition will log a warning. We don't
> treat overlaps partition as a error:
> "
> Caizhiyong <caizhiyong@hisilicon.com> said:
> Partition overlap was intentionally designed in this cmdline partition.
> reference http://lists.infradead.org/pipermail/linux-mtd/2013-August/048092.html
> "
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  Changes
>  v4-v5:
>  1:Delete unnecessary blank line at begin and end of logs.
>  2:Delete newline character in log, pr_* will add newline
>    automatically.
> 
>  v3-v4:
>  1:Fix grammar typo, reported by Randy Dunlap.
>  2:Delete unnecessary type casting, reported by Caizhiyong.
>  3:Record the reason why we can't treat overlapping partitions
>    as errors into changelog.
> 
>  v2-v3:
>  1:Fix log one pair of overlaps partitions twice in cmdline_parts_verifier.
>  2:Fix out of bound access in cmdline_parts_verifier.
> 
>  v1-v2:
>  1:Don't treat overlaps partition as a error, but log a warning.
> 
>  Hi! Jens Axboe
> 
>  What is your suggestion?
Hi! All

I just want to know what is the status about this patch?

ACK or NACK is welcome.

Thanks
