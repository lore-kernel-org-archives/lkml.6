Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AG47ELvDl9qQKdv2USqgLAikgmkwLi6quX99xEHM9B+1+1ubn2YJSNdCE0EnTDLVUqlESBZ1qtKW
ARC-Seal: i=1; a=rsa-sha256; t=1522077256; cv=none;
        d=google.com; s=arc-20160816;
        b=zn5PrJ0OgcxNZLuj0ixL/u/+ekd6QPNgbvHYtnxJfeSs/wJf/oSw+/pLlivF6DQOoj
         rpZ2c2zo/45YWsrbN+UlG1KyfT2ELZcQW9MhgnfF7U5APHow3i9a+f1tNYrJOQdMNRJ2
         YOp+v854FpGYXzDOLEU6VLo8kivS4HkCIC8E3J4YFfA23F09OuXiD9cUd1k535d0JwJQ
         8q4F5z1+YvBblDiFQhgFpeXNMMWPC6YNX4u7eZiNL4HEppPxKSA4qW0/97Hpgw4gXj1+
         +FX2UoRrok+Lm0/ipVJpPqyx1QpwHn4br9s84kN144Ld2EJnh7kdYEXUPBE/jhTDo4tr
         /xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=UIMNfl+C8xXSRXqgAlFmiH1QE7+FWkF2/BC5KomN4iE=;
        b=jShcW/Pm7vEvqd1xPi7OYiSaXW0AFDDpW9Gr+UlsOBE83yCZaRJrYHzy3w74OiYUTW
         EWPnNB+ufvx+c8U4hl8STSDh2R3yOeSkSjYBWBQ6SHWZTHTan/UzSORwbimhtQNCYPeN
         c9G2AHAuiWS5hdlOOwSKdsNg8v+9cef/u6Xkew1GjPE66w6B5zUdzMHSGAGIOqUGop/l
         u/HNZGdvMOgFMI0AxnBJP2opG6Wtfav0IC5r+kAWGi/BCYOsTfdwwDreY+akIMhNHdcf
         oPI+gnnyQDdPQACmArTYuonA/06jRN/UWDHrcgFHf6BDV4QcbuirqU4+sfiJgPdd4BxS
         fVuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XCVXzt1T;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=XCVXzt1T;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Mon, 26 Mar 2018 08:14:06 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org,
	tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	hillf.zj@alibaba-inc.com, ying.huang@intel.com,
	mgorman@techsingularity.net, shakeelb@google.com, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 01/10] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180326151406.GE10912@bombadil.infradead.org>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163847740.21546.16821490541519326725.stgit@localhost.localdomain>
 <20180324184009.dyjlt4rj4b6y6sz3@esperanza>
 <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db2d93f-12cd-d703-fce7-4c3b8df5bc12@virtuozzo.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553598792007322?=
X-GMAIL-MSGID: =?utf-8?q?1596013681507264785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 06:09:35PM +0300, Kirill Tkhai wrote:
> > AFAIK ida always allocates the smallest available id so you don't need
> > to keep track of bitmap_id_start.
> 
> I saw mnt_alloc_group_id() does the same, so this was the reason, the additional
> variable was used. Doesn't this gives a good advise to ida and makes it find
> a free id faster?

No, it doesn't help the IDA in the slightest.  I have a patch in my
tree to delete that silliness from mnt_alloc_group_id(); just haven't
submitted it yet.
