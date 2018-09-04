Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB44C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714EC20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ZUSL2uXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714EC20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeIDWaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:30:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36217 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeIDWaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:30:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id e11-v6so2000142plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YIN2ngdGBdqWEH+a3pAkWa+TsoyCP+VfkT0H/MFpK+w=;
        b=ZUSL2uXOpKMHfYYVrEOajfb436UskAofq8h3Tn+bQyGaxDw+h5In0FyKhQhipgOWMG
         Or7uAbFTbIBiKxEhTXSroRlEPMwVFbDfNV6DWFPd9/jN56Is/pVYrLTJFCazhQx/cgqB
         c8BPevVHgR/ULd0HUTkilMFbv3o6ihbF+AIsXikYdlzKTALy1Vxa3ttl+7o7BO6Vm9sn
         uRJhHIajebVnCs4UtpD20LHeEJ5IS2GLIfTGCQIZTOH/4LS3OzYUamjhIZ1FMytq56Dr
         OnfN9k/bfVFkG1meVx66IruKnIYheWxY5ny4w+FQtr6azX5HLBOKtZS3Ai+DUIAkBnVg
         hezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YIN2ngdGBdqWEH+a3pAkWa+TsoyCP+VfkT0H/MFpK+w=;
        b=evUJcoi5MFnYGIDcE5N/8THjebBBCb5LE8YVoYeXgFW/t5B3k83r6357njCZkE7SIo
         vBo7LBLqTRVkI2cxHZylyPI4OSf367UHc0ZXQ6EIPbyiwXH8d73TeBgKa4+lVrQsmzD0
         CtHJs/YQIFL4JAjB1nbiafpdsUFk0mL/g15ZVUI1MO9Hc6LlDfq8t2hgDBd+3zxSz0K/
         Fgp5nRfBPkBxJY2TS54H8tncxME45xH4CNio4vJjEzQy6jqFG5Lul/O4z8kXnXJu3l8f
         dpiTkkIJScMGMJTBYlKuTf5lUfP8ayiMnCYSrgiJGi6Az06UC6dANgOhul3U9JEF4E24
         mvtg==
X-Gm-Message-State: APzg51DwsYHV2YJ9L7xO+qMpMpOHmeQECKwnNzTlopslMKMiUSQ89OGx
        JCW/WK6iTW6Hohhyfz/H31n8ew==
X-Google-Smtp-Source: ANB0VdYQHHEBlp881mtstYsk/yma25p7oa5yoTnPziurFV0zkiG3+/6S/J9SJw1PsePw37w8lGimVQ==
X-Received: by 2002:a17:902:3a3:: with SMTP id d32-v6mr34619558pld.294.1536084233647;
        Tue, 04 Sep 2018 11:03:53 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::7:db7b])
        by smtp.gmail.com with ESMTPSA id n79-v6sm44480291pfh.2.2018.09.04.11.03.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 11:03:53 -0700 (PDT)
Date:   Tue, 4 Sep 2018 11:03:52 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH] proc/kcore: fix invalid memory access in multi-page read
 optimization
Message-ID: <20180904180352.GA24406@vader>
References: <20180828105959.GA29204@nautica>
 <1535515447-21167-1-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535515447-21167-1-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 06:04:07AM +0200, Dominique Martinet wrote:
> The 'm' kcore_list item can point to kclist_head, and it is incorrect to
> look at m->addr / m->size in this case.
> There is no choice but to run through the list of entries for every address
> if we did not find any entry in the previous iteration
> 
> Fixes: bf991c2231117 ("proc/kcore: optimize multiple page reads")
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> I guess now I'm looking at bf991c2231117 again that it would be slightly
> more efficient to remove the !m check and initialize m to point to
> kclist_head like this:
>  m = list_entry(&kclist_head, struct kcore_list, list);
> but it feels a bit forced to me; deferring the choice to others.

Good catch! Sorry I missed this last week, Google decided this was spam
for some reason. How about fixing it like this? One less conditional in
the common case, no hacky list_entry :)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index ad72261ee3fe..578926032880 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -464,6 +464,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				ret = -EFAULT;
 				goto out;
 			}
+			m = NULL;
 		} else if (m->type == KCORE_VMALLOC) {
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */

>  fs/proc/kcore.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index ad72261ee3fe..50036f6e1f52 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -451,7 +451,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  		 * If this is the first iteration or the address is not within
>  		 * the previous entry, search for a matching entry.
>  		 */
> -		if (!m || start < m->addr || start >= m->addr + m->size) {
> +		if (!m || &m->list == &kclist_head || start < m->addr ||
> +		    start >= m->addr + m->size) {
>  			list_for_each_entry(m, &kclist_head, list) {
>  				if (start >= m->addr &&
>  				    start < m->addr + m->size)
> -- 
> 2.17.1
> 
