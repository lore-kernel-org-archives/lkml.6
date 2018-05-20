Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526803045; cv=none;
        d=google.com; s=arc-20160816;
        b=qlXQcnxYV1c9OJYajs3v6VJuqe20dOA8M01a1Bn2JSjkhlh0NT2dGaZlQpxG44OoQT
         S5xPA2TYj/LJCNAdIFQANEiVuyCnJd/6kyIrTAsOX7JqICYxgjNPElQuRIKmf/E9F7oz
         kn5+UCKfG/MPrhZRBZP9bBY8U9xZcJf3F8lF9zYgh30FjIu19cZuadqxSXt0Q6qkUh8n
         qA539OV1EiplnQxcOLkS/msoBP+heqjGbR/rISXc0KO5p3tLP9LLc60QhoveHsrfqNHH
         f5r+FK25qkk31xQ1NhqZPV8OEUvuvo5WrJp1jOE/RX1eRa9caoWxM+CClHgayBtDg+66
         seRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=0zsMSR6kJEgNU/dNslzPV/LIvOPSffcDo3AlUq9s7xo=;
        b=Ph6isJGcfQVNreSogmmONh8DS/pjXC08VBTT9s1DBm5hJgLm8f9vmhi19x6TPTMYYJ
         u3KEk+DOdA/jE6Q5leMYe7Ybl1BHrwSlpe/91yKvAWG2bKaEyKe0urN94xefAJEBPzZ0
         Cv26HQdDWPnsAnsMAm7tIogbRyFpQkGkyLcfYEEnhYA5p19p2LV+TrZyF9n9yrV5zf9Y
         nLh9nnCvfUBxRGLANYICsKgWylyc0oYxCdfCOwZJpvah0eTgtyDQNd/a+JE1Dic8/FaU
         arjGS1z7+AOUhgIpCVeeCpZqnC5FZsDnSTNz9jRN4aZT3yqkY9d5HZuUPiX0bEf5I49o
         uC5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MwiAEQTt;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MwiAEQTt;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpcOsaOZXoyzhKoA6UcM/X7tiYLRD8FiBGSzSduwslMH9Fa/5+F40Tjr1rKpc56cJTWNKnfjA==
Date: Sun, 20 May 2018 10:57:22 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
	pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
	aryabinin@virtuozzo.com
Subject: Re: [PATCH v6 13/17] mm: Export mem_cgroup_is_root()
Message-ID: <20180520075722.qwwrxuz52kqulsnw@esperanza>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
 <152663303322.5308.13190345531934617119.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152663303322.5308.13190345531934617119.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790764385859486?=
X-GMAIL-MSGID: =?utf-8?q?1600969030236752143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:43:53AM +0300, Kirill Tkhai wrote:
> This will be used in next patch.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/memcontrol.h |   10 ++++++++++
>  mm/memcontrol.c            |    5 -----
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7ae1b94becf3..cd44c1fac22b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -311,6 +311,11 @@ struct mem_cgroup {
>  
>  extern struct mem_cgroup *root_mem_cgroup;
>  
> +static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
> +{
> +	return (memcg == root_mem_cgroup);
> +}
> +
>  static inline bool mem_cgroup_disabled(void)
>  {
>  	return !cgroup_subsys_enabled(memory_cgrp_subsys);
> @@ -780,6 +785,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
>  
>  struct mem_cgroup;
>  
> +static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
> +{
> +	return false;
> +}
> +

This stub must return true as one can think of !MEMCG as of the case
when there's the only cgroup - the root.
