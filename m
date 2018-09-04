Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FF8C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1932086C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="whlSVxtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1932086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeIEDJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:09:06 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35127 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEDJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:09:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so2410466pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WRxf5DmPmMtFZZR72JRYdG3CXo9dOx3o7ctMlbTTT5I=;
        b=whlSVxtIj+wz7sEkVq/rXB5n6G9DR/oaL+Dm9ntMT7iqKpvYpq0CiNwIrf6wX1enXF
         DuDgX0Dv1awpbME3tLxZPdsvaShqux3aOjByCWdXPZRL+ZKtR08IkHb0dTqq/D6b9qpT
         iruFyET5PBndZ3845wtRSCQsYb25Eo9P8Lj3xp/rEBTxos3WNGlTYrHVdNmcpc2glWfg
         nwZvVg5jxF0qB/bdIAALJAFagCNCuGVMBxJ+XeqlbIccZW6MwLBbmCmjWsqUzpB8PV7l
         2kH9KNKP8vhAUuplN+E4qq+1kt1VMsbUUX3Wo7/hgSbaKBBly3zW0ygZ44hSuAs5Ob/y
         OM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WRxf5DmPmMtFZZR72JRYdG3CXo9dOx3o7ctMlbTTT5I=;
        b=MfztbDSbE9OO/Z4aTbyl5rxxbqcRi/seR9pVC+LWI3dcxbJHaa8cFbqIF9zn8RJjaA
         V0Qp2GaOI49mz/9RcjgSZY+QRZTazCoyXB0cvmB+WVlHlMSOXEVq9dQd4sws9rrQWQLc
         xZGgwrHwpb8TD7LgKMOGQ9++Tr0Ks8zFkLVyoseHQGWjc2/cQAoZasC7cZGfSefxJqiL
         GF2Uyopi52f87GKrPar8rStezUrG4aHtBd04n1rYs1yvekfPoJwfFTAGOHQniX4H9mhT
         c9gMWydWZ2Pbhw7KpEnW6BNXxGWbKHvYEOJm5DFJlosORfOEiixdGLiJNGIM4ABYwiwb
         K7Uw==
X-Gm-Message-State: APzg51AREwfUNnuMdEjQk95Z0gWw/+DXqBr3/5PQxOSuwPzYD83NLAc+
        tUfXGm4hoHhLsEoN54n2kD4DUA==
X-Google-Smtp-Source: ANB0VdY2Jy8KcHe4SUGaiRQR8+c0qo7iOVujrcDZH426Aapb2p2yf32mWfCzMj5QS/NQFsb1Q6TjSA==
X-Received: by 2002:a63:e001:: with SMTP id e1-v6mr7381501pgh.380.1536100912172;
        Tue, 04 Sep 2018 15:41:52 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::7:db7b])
        by smtp.gmail.com with ESMTPSA id h85-v6sm79535pfk.71.2018.09.04.15.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 15:41:51 -0700 (PDT)
Date:   Tue, 4 Sep 2018 15:41:50 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v3] proc/kcore: fix invalid memory access in multi-page
 read optimization
Message-ID: <20180904224150.GD24406@vader>
References: <1536100545-26905-1-git-send-email-asmadeus@codewreck.org>
 <1536100702-28706-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536100702-28706-1-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 12:38:22AM +0200, Dominique Martinet wrote:
> The 'm' kcore_list item could point to kclist_head, and it is incorrect to
> look at m->addr / m->size in this case.
> There is no choice but to run through the list of entries for every address
> if we did not find any entry in the previous iteration
> 
> Reset 'm' to NULL in that case at Omar Sandoval's suggestion.
> 
> Fixes: bf991c2231117 ("proc/kcore: optimize multiple page reads")

Reviewed-by: Omar Sandoval <osandov@fb.com>

Thanks again for catching this!

> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> Sorry, resent v2 because From didn't match sob tag
> 
>  fs/proc/kcore.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index ad72261ee3fe..578926032880 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -464,6 +464,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  				ret = -EFAULT;
>  				goto out;
>  			}
> +			m = NULL;
>  		} else if (m->type == KCORE_VMALLOC) {
>  			vread(buf, (char *)start, tsz);
>  			/* we have to zero-fill user buffer even if no read */
> -- 
> 2.17.1
> 
